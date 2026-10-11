Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944F339387;
	Sun, 11 Oct 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736176; cv=none; b=IISxrZEscddXP3XjJKGJvLIvmgwEcmMPGuwkMy/HL8FYMES3FJ8g56UXu30yVapVj0Z31GsS4+2Z2nCyLFlQZHUJhkh5JeVTAEAbTVvksBffAnW4svLCpeByT8zPgSuX8pPN7ON9RNIjPUVOzbAaHuPmV/TXpXZXylbJ6MBSxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736176; c=relaxed/simple;
	bh=WndzLhBb0HUUX0sO0798zNIc9+X+/xCoKEm0WMcuE88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rus8y/hUEwiUgQ0gi4i1RPKZYqT/Mq+yHf2Mlkg2oE2mxHRaNduDuLhTeZ7LRXHmYoKPvsP5qkaLtB8vzUUv/lpcvQrIs9QKqVWthzWULQ1kyn7XaPRz/UdTPWgh3DDxPe9T8U8VPpuuRcq5ANUYt0zBxvX9lpRYA04wk+rTfrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=XADCc8U9; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="XADCc8U9"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791735627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I2h0x6MRK97TXy17q/oGa0pHMkpomhGIicSPhvbv6/g=;
	b=XADCc8U9B8QaYAchNDAG8w3uziok9xva1leOsMX6XlYarOzrlxHLQiQNEA2yRR9eYfHsJD
	7tcUmPT3d8Cz1A7pCmSLBgwzP9OKi+w/aHtUT76trhQpWU5UnKoKsXeAkYiDPwZXaY43+/
	EGaVAudImrmY0ja78Nii6cGyHZEjtJ4=
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>,
	stable@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: fix lost maps entries above 2^63
Date: Sun, 11 Oct 2026 18:20:19 +0200
Message-ID: <20261011162019.922436-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a read of /proc/pid/{maps,smaps,numa_maps} resumes, m_start()
rewinds *ppos to priv->last_pos so that the vma which did not fit into
the previous buffer is shown again. It only does so for last_addr > 0,
meaning to exclude the start of the file and SENTINEL_VMA_GATE, but
last_addr is a signed loff_t holding a vm_end. sparc64 maps shared
libraries, anonymous memory and the stack above 0x8000000000000000, so
the rewind does not happen there and one entry is lost at every read()
boundary.

Reading the maps file of a process with read sizes from 64 to 8192
bytes in steps of 64 loses lines at 126 of the 128 sizes, smaps at 123
and numa_maps at 97, and the proc-maps-race selftest fails 4 of its 6
tests. Python's sys.remote_exec() reads maps with fgets() and fails
intermittently when it misses the libpython data mapping.

Test for the two values that are not a vma end instead.

Fixes: 5631da56c9a87 ("fs/proc/task_mmu: read proc/pid/maps under per-vma lock")
Closes: https://github.com/sparclinux/issues/issues/111
Cc: stable@vger.kernel.org
Signed-off-by: Stian Halseth <stian@itx.no>
---

Notes:
    Tested on a SPARC T7-1 (sun4v, 7.3-rc5), a T4-1 (7.2.9) and a Sun Fire
    V240 (sun4u, 7.3-rc5): no lost lines at any read size afterwards, and
    Python's sys.remote_exec() test passes 20/20. On an amd64 KVM guest maps,
    smaps, numa_maps and the proc selftests are unchanged.

 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5c54aebe21182..cdce513edcb1d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -339,7 +339,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	 * Reset current position if last_addr was set before
 	 * and it's not a sentinel.
 	 */
-	if (last_addr > 0)
+	if (last_addr && last_addr != SENTINEL_VMA_GATE)
 		*ppos = last_addr = priv->last_pos;
 	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
 	hold_task_mempolicy(priv);
-- 
2.43.0

