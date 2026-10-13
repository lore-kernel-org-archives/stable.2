Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA753F6B0;
	Tue, 13 Oct 2026 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904875; cv=none; b=dOry2NVKtwayD/s1WeVTTbE9vRTSQXatO6phNJh3Fl5bB1ZBCeV2g92RuHzSFxhcmDVNh+vMtYQtJpKhHyxzqnolc5NRWppbHb8HZcisrYELx6QtTcDqolyoiRrMsgUP/XNoWOfPDxrdqMtz5k+s5LcN7K143jcuFeMtHyxqwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904875; c=relaxed/simple;
	bh=6d019nn8BwUs8GO+4tHGPEPmX9fd53978uK5Jj7cPeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IekJPoZ26GkgD+DOsJkFX833EENo86+uPJnMcDx1W4ghIAtuYH/bGGMUVsd8DmI4AlMSyJLBFvTeWHFIuA1gzObbogRHrpNhceThprCDbt4NOthjDXR59DEjBCaCw69IN8DKApdT6lQOUmWoxNgAgJhF+4P0hGH3OvThG79apA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=AdybLNnH; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="AdybLNnH"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791904872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rc71fgZHwADEeq4p7dd0dPWf8I5xcTbvFS9HuN595XE=;
	b=AdybLNnHYsQIKddtDVjlqYbw+JX0uwW3/3h9KaTu+nDjUnxsOM5m32URnOTQKjhZXY4bVW
	FODW0E1hcM7TGwhV5rxCEY1HZfPRCeEEz6XrClJNUmU66iFLINybac2BAPeqa2ShtQw9NP
	jj2WZ6if4aBZgvIB9lbLFUracOBJ1Gg=
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
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
Subject: [PATCH v3] fs/proc/task_mmu: fix lost maps entries above 2^63
Date: Tue, 13 Oct 2026 17:21:06 +0200
Message-ID: <20261013152106.1834364-1-stian@itx.no>
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

Skip the rewind only for 0 and the two sentinels instead, with an
addr_is_sentinel() helper.

Fixes: 5631da56c9a87 ("fs/proc/task_mmu: read proc/pid/maps under per-vma lock")
Closes: https://github.com/sparclinux/issues/issues/111
Cc: stable@vger.kernel.org
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Stian Halseth <stian@itx.no>
---

Notes:
    v3: drop the inline from addr_is_sentinel(), add David's Acked-by.
    v2: https://lore.kernel.org/all/20261013150712.1827315-1-stian@itx.no/
    v2: addr_is_sentinel() covering both sentinels, as the comment says
    (David Hildenbrand). No functional change: m_start() returns early on
    SENTINEL_VMA_END. Re-tested on the T4 (7.2.10): maps and smaps read at
    128 sizes, 200 and 1000 mappings, no lost lines.
    v1: https://lore.kernel.org/all/20261011162019.922436-1-stian@itx.no/
    
    Tested on a SPARC T7-1 (sun4v, 7.3-rc5), a T4-1 (7.2.9) and a Sun Fire
    V240 (sun4u, 7.3-rc5): no lost lines at any read size afterwards, and
    Python's sys.remote_exec() test passes 20/20. On an amd64 KVM guest maps,
    smaps, numa_maps and the proc selftests are unchanged.

 fs/proc/task_mmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5c54aebe21182..24c2a5079f080 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -32,6 +32,11 @@
 #define SENTINEL_VMA_END	-1
 #define SENTINEL_VMA_GATE	-2
 
+static bool addr_is_sentinel(loff_t addr)
+{
+	return addr == SENTINEL_VMA_END || addr == SENTINEL_VMA_GATE;
+}
+
 #define SEQ_PUT_DEC(str, val) \
 		seq_put_decimal_ull_width(m, str, (val) << (PAGE_SHIFT-10), 8)
 void task_mem(struct seq_file *m, struct mm_struct *mm)
@@ -339,7 +344,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	 * Reset current position if last_addr was set before
 	 * and it's not a sentinel.
 	 */
-	if (last_addr > 0)
+	if (last_addr && !addr_is_sentinel(last_addr))
 		*ppos = last_addr = priv->last_pos;
 	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
 	hold_task_mempolicy(priv);
-- 
2.43.0

