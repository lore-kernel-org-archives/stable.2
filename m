Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41E42BEAA;
	Tue,  1 Sep 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284993; cv=none; b=ZC8faGP/pNEy0F5ZgzjQu2IroyGaZrHQ/1KEf0ec/dKcLguy9IS+9MsL+QJefH77TWPxog58jbNqpaazuxuHCH54jRKzPdDRTJ96br9yaSext1Z7VBzOCcmSTrq3oXjQqakaMzCb6+fnbsYKKT/0YgieZNvzvFj++W3ycq6u/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284993; c=relaxed/simple;
	bh=F0LklRtFSXeQjK7D6ZPutqx+XbwgMNSwpv1KRwrlgCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dt0zQwZ0EKbKSRTZHK8SPWBGf1ZCD1wQc3dbP+L26/xjuRUp6NjkExEGUcrrIIjWsM4mqx+KCH4bqLrGc6jDJoj9CpCl/0vZ1DZezQXDMoI3tAA02mqYpZ4z7ECxVRlwRv9KnaB4hJ3hZAwbYi7uxAnC9/xQJqxKVUl5v/jWpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WdRudZ9o; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WdRudZ9o"
Received: from localhost.localdomain (unknown [52.172.102.219])
	by linux.microsoft.com (Postfix) with ESMTPSA id DAE1E20B7128;
	Tue,  1 Sep 2026 10:49:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DAE1E20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788284954;
	bh=2gguwpYhmjNlRVlGYJOLn4hwFyH2pbwnWpRN0CDsyZU=;
	h=From:To:Cc:Subject:Date:From;
	b=WdRudZ9onwk2aci+42Z6mU7v9arNtEsXzqqZnuxwJwIf+2bujhLy2cWikhiHrdAGN
	 GJXQ4zlpGa/Z6uVCiE+MeQDUizkpBKewxb23i7K3weC1n8gPFdsQOz/AcjNYtsUozy
	 nve3R1+GnvRUf7Zr45IE8aRN8mRjHG5VtjZFwR/E=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Subject: [PATCH] fs/ntfs3: validate target_attr in log_replay()
Date: Tue,  1 Sep 2026 13:49:34 -0400
Message-ID: <20260901174934.6275-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

log_replay() treats lrh->target_attr as a byte offset to an
OPEN_ATTR_ENRTY in the open-attribute restart table. A valid offset is
the table header size plus an integral number of entries. The redo
lookup checks only target_attr < bytes_per_rt(oatbl); its earlier
alignment check subtracts the header size without first checking the
lower bound, so the subtraction can wrap.

The undo lookup has no table-bound check, and its earlier alignment
check is skipped when lcns_follow is zero. Unlike the redo lookup, it
also does not reject unallocated entries or NULL entry pointers.

A crafted $LogFile can therefore point into the table header, the middle
of an entry, or past the table and trigger an out-of-bounds access.

BUG: KASAN: slab-out-of-bounds in log_replay+0x7d44/0x9d80
  fs/ntfs3/fslog.c:5235 log_replay()
  ntfs_loadlog_and_replay()
  ntfs_fill_super()
  path_mount()

Add rstbl_entry_valid() to require a nonzero entry size and an offset
between the table header and end that is aligned to the entry size. Use
it before both lookups, and make the undo lookup match the redo lookup
by rejecting unallocated entries and NULL entry pointers. Skip
targetless records with no LCN work before the lookup so their unused
target_attr is not subjected to the new validation.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
---
 fs/ntfs3/fslog.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index ed50c1d0c23e..1ddff43dbe87 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -384,6 +384,14 @@ static inline u32 bytes_per_rt(const struct RESTART_TABLE *rt)
 	       sizeof(struct RESTART_TABLE);
 }
 
+static inline bool rstbl_entry_valid(const struct RESTART_TABLE *rt, u32 off)
+{
+	u16 size = le16_to_cpu(rt->size);
+
+	return size && off >= sizeof(*rt) && off < bytes_per_rt(rt) &&
+	       !((off - sizeof(*rt)) % size);
+}
+
 /* Log record length. */
 static inline u32 lrh_length(const struct LOG_REC_HDR *lr)
 {
@@ -5086,7 +5094,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto read_next_log_do_action;
 
 	t16 = le16_to_cpu(lrh->target_attr);
-	if (t16 >= bytes_per_rt(oatbl)) {
+	if (!rstbl_entry_valid(oatbl, t16)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -5231,8 +5239,29 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	if (lrh->undo_op == cpu_to_le16(Noop))
 		goto read_next_log_undo_action;
 
-	oe = Add2Ptr(oatbl, le16_to_cpu(lrh->target_attr));
+	/* Skip records with neither target nor LCN work. */
+	t16 = le16_to_cpu(lrh->undo_op);
+	if (!lrh->lcns_follow && !is_target_required(t16) &&
+	    can_skip_action(t16))
+		goto read_next_log_undo_action;
+
+	t16 = le16_to_cpu(lrh->target_attr);
+	if (!rstbl_entry_valid(oatbl, t16)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	oe = Add2Ptr(oatbl, t16);
+	if (oe->next != RESTART_ENTRY_ALLOCATED_LE) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	oa = oe->ptr;
+	if (!oa) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	t16 = le16_to_cpu(lrh->lcns_follow);
 	if (!t16)

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0

