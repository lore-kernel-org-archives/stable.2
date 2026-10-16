Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E323C8705
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140963; cv=none; b=qlWE84fwLfsX1rK21i7R5s1pyIpt5/JLoOVXFWyUa2wePn+ZnxeOL9sSrxsCSaRQP5nXMTL80yfewo9c3DKjsl4cK9KE/fhpN2ZpP3FDx9cZht99SDqA1JktDMVswywf77vcxANy0utOhzko4bfRlPqElBYrRMTKE3xpFqpP0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140963; c=relaxed/simple;
	bh=2E+0ccS/jvGnm4GN4Z1UMT3YVp9khzlNVVIH8LJD5w8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ll8uittkSVeYPvkKXCZVSeVW3Yqkc4uQ8eYMokOZHrCeAGwAUKx+GSPW9f6j2ASxBitFIV7rs4pReEDP+dOnl3EG4/eKMPdqJo8ftPV/K/T4OqWsx9Gisgz1zfIxwZDD53O0GB0+h3usVAo7ut1t52VZr5xgth++iH2J8236dXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5eF62M/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5eF62M/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8935f42e8f0so1300193b3a.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792140958; x=1792745758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tlnCz8G1IlSw43gyBHlpTezhQ/heCnWiA359vivmr2s=;
        b=d5eF62M/w+m/OGH6nRYtRtKeagzCfljfF5WXiP1PFSXLEoCcEdRa7n9gaqkHeyCbvj
         igDFYOkjpBfvlu7TQ74QLCGgVIQXq+2bd7mAz7jUYghBWYwPw6Oc7m8KteNjxNhQZ+4b
         gSljfqAXS4hf291cq38QwpviVirVFn1aJaZm0TYGVxekQC1mChHWRN1LTJWr13U2nvIh
         0+4rCLHQla24Aw6PA8y3L9hU83tRjFt8gjrYtQ2RgiFd73FepDF0q3E7CzTYESXW06+J
         vVKKBh958W0cuQfGYmyrOBgOcXKSCXaCFgOxO6KZqs1MbvMKtSWkskdc/vLvFAnIcC6e
         c7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140958; x=1792745758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlnCz8G1IlSw43gyBHlpTezhQ/heCnWiA359vivmr2s=;
        b=vPyxcyF9IPUq05UGZ6gYmCRvZpQqYvw87awC7vtSAqqS6Woz5w+ynM1fWPRosSU7JL
         374KCaFZ0nl0mku16KorBtHeaDXsm/gz3NVk8ourXIWlLkFoVrzxrCmDCgFvQxRlkSPV
         jF3QFsgDGkWEUsoydoD/voEhySgrJbZpa+RLOamTCw2nYMfWbvgeB0pYr3MqgrK70Ctz
         tMZ5Mm1jkvZpS8X3H6OqAaU2IPI8axWRXhMVYSBGzYtwCRwpFuFlXNE6xWviglan0Gpm
         axtulV6HVRcdE6LSNWVR552L4R4mtrc0PpSqodBmnnnppwTpeB4b8Uf8qkha4b1wnhOe
         r8cw==
X-Forwarded-Encrypted: i=1; AKwUvBz1Vu5EFe4f9IedgNNoqLz15sxC3plEbuOdKU6f0XfmfKLCVpBT2AIPpN05NSkcxmthvTwj56E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIc24YXndObKQfRg9QnEF5hZj3/t3LYE/Ijii8OYudMDJo8KY5D
	eG8juLpHkw5HHahuM66jxG4Abp01kDnXiCCcy6HkbXYbgg+MFoNTml35
X-Gm-Gg: AYBFou3iULSIN8Oo/1a8oQoPtVWGhDtJ83jA5mbew4AwJVKTdT22A3nsiNYau7Vpv3l
	BIgH05YSChVlY2FKuhxQP3JX66y5OBtUpQVY34GUom0hecLartzAOm631nroE25nwMqIFcvtAae
	jCZZ/nLYuAuwXS4DFjrTZ5h4vj3ZYlfvoI4qs4y3AUJWLGOfXg46RpoLShBZYwVrLPZh6sWnDU6
	XY0T4XGj2HhHvybBvzCkOsofNeuCME9mPXPy0xRapl0+qr7/6Kf4QQ09OYKtnNKHyuiOptrCuaR
	hji1+HmjXXtrfiajUIcqxq7VO5XBNmbxe2lY/61r6oUEoUG9MwyNj4jzSmyyipmdBtN1Jvj51/u
	B+IV179w5FFmyFHrGdPDoCVAJLb/thUt9I8voUC1BxeLq0n3qZRDDWC4HEK+YYDmXU5Rk+I/mCc
	ThAleM1jjifTZhM7k5ZpWA/eISbDHarmremqlag3dhf+woeeEEUDRedFY/m7rnpOePFdgpho4LO
	FwIEYOyoarcrDIYkeRorw==
X-Received: by 2002:a05:6a00:ba8d:b0:89f:e1e7:e7e8 with SMTP id d2e1a72fcca58-89fe1e7e935mr511572b3a.18.1792140958260;
        Fri, 16 Oct 2026 01:55:58 -0700 (PDT)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f579479f8sm776051b3a.38.2026.10.16.01.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:55:57 -0700 (PDT)
From: vienna-0FFH <viennaoffh@gmail.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	viennaoffh@gmail.com,
	syzbot+e7f24354da9f7915bc54@syzkaller.appspotmail.com
Subject: [PATCH] xfs: fix slab-use-after-free in xrep_newbt_free()
Date: Fri, 16 Oct 2026 16:55:36 +0800
Message-ID: <20261016085536.591-1-viennaoffh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a slab-use-after-free read in xfs_defer_item_unpause()
while online repair was rebuilding a bmap btree:

  BUG: KASAN: slab-use-after-free in xfs_defer_item_unpause+0x116/0x250
  Read of size 4 at addr ffff8880132c127c by task syz.0.0/5327
  Call Trace:
   xfs_defer_item_unpause
   xrep_newbt_free+0x3fe/0x5f0
   xrep_bmap_build_new_fork+0x5a9/0x740
   xrep_bmap
   xrep_attempt
   xfs_scrub_metadata

The buggy address belongs to the object at ffff8880132c1240,
which belongs to the cache xfs_defer_pending of size 64.

xrep_newbt_add_blocks() attaches a paused EFI to the repair transaction
for each space reservation so that the blocks are reclaimed if the
system goes down before the new btree is committed.  If a later
xrep_defer_finish() fails (e.g. metadata I/O errors while staging the
new btree), xfs_defer_finish_noroll() shuts the filesystem down and
xfs_defer_cancel_list() frees all pending deferred work items, which
includes the paused EFIs referenced by resv->autoreap.

The repair then unwinds through xrep_newbt_cancel() -> xrep_newbt_free().
That function notices the shutdown and jumps to the junkit label, which
calls xfs_alloc_commit_autoreap() for each leftover reservation.  That
unpauses the deferred item through the stale pointer, causing the
use-after-free.  The report confirms this: the object was allocated by
xfs_alloc_schedule_autoreap() from xrep_newbt_add_blocks(), and freed
by xfs_defer_cancel_list() from the failing xrep_defer_finish().

Beyond the use-after-free, unpausing the deferred item is pointless
once the filesystem has been shut down: the remaining deferred work
will be cancelled when the repair transaction is torn down, and any
EFI that was committed to the log before the failure is replayed by
log recovery on the next mount.

Fix this by only unpausing the autoreap when the filesystem is not shut
down.

Fixes: 6bb9ea8ecd2c ("xfs: log EFIs for all btree blocks being used to stage a btree")
Reported-by: syzbot+e7f24354da9f7915bc54@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e7f24354da9f7915bc54
Cc: stable@vger.kernel.org
Signed-off-by: vienna-0FFH <viennaoffh@gmail.com>
---
 fs/xfs/scrub/newbt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/newbt.c b/fs/xfs/scrub/newbt.c
index 584076b..83558fd 100644
--- a/fs/xfs/scrub/newbt.c
+++ b/fs/xfs/scrub/newbt.c
@@ -516,10 +516,15 @@ junkit:
 	/*
 	 * If we still have reservations attached to @newbt, cleanup must have
 	 * failed and the filesystem is about to go down.  Clean up the incore
-	 * reservations and try to commit to freeing the space we used.
+	 * reservations.  If the filesystem is already shut down, leave the
+	 * autoreaps alone: a failed deferred finish has freed the pending
+	 * work items they point to, and nothing will ever finish deferred
+	 * work on a dead filesystem.  Any EFI that made it to the log is
+	 * replayed by log recovery.
 	 */
 	list_for_each_entry_safe(resv, n, &xnr->resv_list, list) {
-		xfs_alloc_commit_autoreap(sc->tp, &resv->autoreap);
+		if (!xfs_is_shutdown(sc->mp))
+			xfs_alloc_commit_autoreap(sc->tp, &resv->autoreap);
 		list_del(&resv->list);
 		xfs_perag_put(resv->pag);
 		kfree(resv);
-- 
2.43.0

