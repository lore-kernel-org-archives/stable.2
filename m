Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88C511E69;
	Tue, 29 Sep 2026 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679982; cv=none; b=MmoH2DiVjrVYiYedaAls0K9TYTWW0uXF60Dup8R1f6uU/oWqd66Qg2HwCSXUZ2eoqhgO61CdOaP/s4enZMeWhA92Qo79b3HdwbEmBaAONW7hldOm38viGJNpj3h1w4se19gTeM0Xm83NZSPAP2WZAoVCmKsYvJkI75YWMQsJIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679982; c=relaxed/simple;
	bh=ZmxofnHhmxko4/AgiFHLlXXtimoSepvDulPtbd4hNKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aOy3LRlnN/Y9jyPbIFQHbIgiASPx86WWfXHEq8KwKsrHr/auC8FH3x0g+78WHV8PsmJkiRyLsSiXVW5+X0zqLlwxIHdh46G1RRMlhYPokBUN07X/ub7KgURBvK/zVjLdO/0jkXQjcevlVqhiK6KFEUv1hknPpRv9Q3JhSbGs/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g2yvNmPa; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g2yvNmPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=QB
	EQM78Q0lpd+BWXfbu7jyyCFrPHGFRUJBbWz7Gkb10=; b=g2yvNmPaDcESO65VSD
	QdKGJOEt6BaISf/r7Xx07zC98e65ipJatuwJD/3CDZem3qKL/Tml74DuAC+td2Dm
	XEUOCi9tErq1ROlA0GNPfxjT0aFKhw9RPLbEBqCGviFIWseWAtpQL2m7caAANIv3
	0vSOTjmn6dZfJE41HIijCCu8E=
Received: from WIN-TOG0NDEIICD.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3hBWEm7tqit_tBg--.40624S2;
	Tue, 29 Sep 2026 19:05:41 +0800 (CST)
From: Shirong Zhao <shxzhaosr@163.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] jffs2: fix wbuf_sem leak on summary failure in jffs2_flash_writev()
Date: Tue, 29 Sep 2026 19:05:38 +0800
Message-ID: <20260929110539.20-1-shxzhaosr@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgC3hBWEm7tqit_tBg--.40624S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1fAr43Wr1UWF4xZry5Arb_yoW5KFyrpr
	9Iqr13Kr1vqF18ArnFyF48ZryDC39xJFZIgr1rW34UZan5Xr1Sga97tFy09Fs8CrsavFy2
	qF4kK3yjvayDZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeksDUUUUU=
X-CM-SenderInfo: hvk06xhdrv2qqrwthudrp/xtbCxgWRz2q7m4VWrAAA3o

When summary is enabled and jffs2_sum_add_kvec() fails (an allocation
failure while recording a summary entry), jffs2_flash_writev() returns
the error directly while still holding c->wbuf_sem write-locked.  No
later path releases it, so every subsequent read, write and GC blocks
on down_read()/down_write() and the filesystem becomes completely
unresponsive until remount or reboot.

Fix this the same way the wbuf recovery path already handles a lost
summary: disable summary collecting for the eraseblock with
jffs2_sum_disable_collecting() and let the write complete on the
normal path below, which releases the semaphore.  The summary is only
a mount-time optimization; the node data itself has already reached
the flash or wbuf, and a missing summary merely forces a full scan of
that eraseblock at the next mount.

An early version of this fix returned the error after unlocking (via
the shared outerr path).  That was rejected by runtime testing: with
retlen reset to 0 the allocator makes no progress, the retried write
lands on the same offset and trips the contiguity BUG() in
jffs2_link_node_ref().  Swallowing the summary error instead matches
the established recovery behavior and was verified clean.

Test comparison, same guest and test program in both runs (QEMU,
upstream 7.3.0-rc4, JFFS2 on nandsim, failslab fault injection
window-limited to jffs2_sum_add_kvec, fault count taken from the
failslab times counter):

- Deterministic 20+1+20 protocol: 20 clean 15-byte writes, 1 write
  with injection armed at probability 100, 20 clean writes, then
  umount/remount and readback of all 41 markers.
  - With this patch: exactly 1 fault fires during the armed write
    (times 1000000 -> 999999); all three writers exit 0 with no
    errors; file size 615 bytes and all 41 markers present both
    before and after remount; no BUG, oops, hung task or hang.
  - Pristine (unpatched) kernel: the same fault surfaces -ENOMEM
    ("Write of 83 bytes ... failed. returned -12"), then writer:79
    and kworker delayed_wbuf_sync both wedge in D state in
    jffs2_flash_writev -> down_write (hung task reports at 122s and
    245s, rw-semaphore "likely owned by task writer:79" itself);
    the D-state writer is unkillable and the test never completes.
- Endurance variant on the patched kernel (2 clean + 12 armed 256KiB
  block writes at probability 15 + 2 clean): 6 faults absorbed, all
  16 block markers present after remount, no anomalies.
- The original hang was first reproduced on 6.13 and re-confirmed on
  7.3.0-rc4 before the fix (writer + kworker D-state stacks in
  jffs2_flash_writev, same self-owned semaphore signature).

Fixes: e631ddba5887 ("[JFFS2] Add erase block summary support (mount time improvement)")
Cc: stable@vger.kernel.org
Signed-off-by: Shirong Zhao <shxzhaosr@163.com>
Tested-by: Shirong Zhao <shxzhaosr@163.com>
---
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index 3b7803c75..7ed3fa2bf 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -904,8 +904,16 @@ int jffs2_flash_writev(struct jffs2_sb_info *c, const struct kvec *invecs,

 	if (jffs2_sum_active()) {
 		int res = jffs2_sum_add_kvec(c, invecs, count, (uint32_t) to);
-		if (res)
-			return res;
+		if (res) {
+			/*
+			 * Summary recording failed (allocation failure).
+			 * The node data already reached the flash or wbuf;
+			 * disable summary for this eraseblock so the caller
+			 * still sees a successful write.  The semaphore is
+			 * released on the normal path below.
+			 */
+			jffs2_sum_disable_collecting(c->summary);
+		}
 	}

 	if (c->wbuf_len && ino)

