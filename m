Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226905;
	b=YKIcqWOq2WP39ASr5/DEw2Xkcz//4EYup5wfj18vbL8BnhYzlSoj6mgLiaEgPfYilxFf
	 BP4uApDtGM/kLoXYu5fiva931/cNXaWDMk+2V0JuEcTtO13WdXAOyze+vavSedI6PUK/X
	 D/t5KGIeeZ4ug+4Y6/Dnoy1/0ywaNRTr0mbu13qhKlCNL9LFDWUN/Ue/eZUJ9oW1chsCp
	 8eZSzv1VJKt8GEB/SGFuBPgsaTKA+BgdRdfGP67507SoJM9hZqwNYukTi1LYvtTYn5Pqe
	 bSAUyP04aO9LtPqJAk9WzkyPRjmgbWIzQbcyejkr70fx2lE/4xgcNcNeHurpwZvOs/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226905;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ly/DHPYaYtg4H5d7I4tI+XKSj5VHoc0rWfr4sQj575E=;
	b=UkKMfhsV7WKEDR/flKY5qYInD8CJT6J9vl/+MQq6206HDAzXiFTH8m62kQdI3+30crAR
	 GETPpQkpDIreUQNqYvGqF3Bpjz1Rgp28+KW6t/RH+UnfqhWP83yf3EbPS6Wlh0TAu3Ggd
	 c/J/2xhAmuDJMdYBnWj5xEssUbXJo2xlokeDfT+LEoK74mLDS8322Ch3ibCEL8jxnWRCt
	 BcZCBE9xNWzpiFyJjy4tn26nMIQ/xzUk0BQl47TVQCII2G+m4R+8HhVA1Df6r2/XVd/sJ
	 mnGFzLg+mXGVm6el1Hi0n1fuDWv5N5UGIJKQoggAHltUJo+DPxmCgsQrKx6hwVIlEww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G+wzzvKx;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342C606A321;
	Mon,  9 Nov 2026 12:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6342C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G+wzzvKx
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794226895; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ly/DHPYaYtg4H5d7I4tI+XKSj5VHoc0rWfr4sQj575E=;
	b=G+wzzvKxiI+kD7xKoJSHBxKN2vlcy1BHW6ov8WKUXZccLJVqCeSOONjr1H8rKj4mbCijhyZ+hBXvAj/fU/8oDGPIvkrqyLWcB1BuW/PQmvoFF5mp9vkTYxAxp7isdTT5rlhQSJPUC8p5/Wo0R87vRC0MG/If2Z9FOqrM5dHeyG4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEOZNct_1794226894;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XEOZNct_1794226894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 20:21:35 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Heming Zhao <heming.zhao@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 01/31] ocfs2: exempt orphaned dinodes from the zero nlink check
Date: Mon,  9 Nov 2026 20:20:51 +0800
Message-Id: <20261109122121.21473-2-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20261109122121.21473-1-joseph.qi@linux.alibaba.com>
References: <20261109122121.21473-1-joseph.qi@linux.alibaba.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open-unlinked inode legitimately has a zero link count on disk.
ocfs2_unlink() drops the last link and writes it out with
ocfs2_set_links_count(), ocfs2_orphan_add() then sets OCFS2_ORPHANED_FL,
and OCFS2_VALID_FL is only cleared much later by ocfs2_remove_inode().
The zero nlink check added by the commit below rejects such an inode as
-EFSCORRUPTED even though it is perfectly valid.

That commit describes its own change as a check for "(i_mode == 0,
i_nlink == 0, non-orphan)", but the code it added has no orphan exemption
and ORs the two conditions rather than ANDing them, so a zero link count
alone is enough to fail even when i_mode is valid.  Add the exemption the
changelog describes.

Orphan recovery hits this on every pass.  OCFS2_FI_FLAG_ORPHAN_RECOVERY
clears can_lock in ocfs2_read_locked_inode(), so the block is read with
ocfs2_read_blocks_sync() and then validated by the explicit
ocfs2_validate_inode_block() call in that branch.  The read helper having
no validate callback of its own does not mean the path skips validation.
ocfs2_orphan_filldir() then ignores the resulting ocfs2_iget() failure
("Skip bad inodes so that recovery can continue"), so the orphan is never
wiped: its space is leaked permanently and the "Corrupt state" message is
logged again on every mount.

The same applies to an orphaned dinode read through
ocfs2_read_inode_block(), for example from ocfs2_delete_inode() once the
buffer has been evicted.

Note that a zero i_mode is already rejected by the later
ocfs2_valid_inode_mode() check, since fs_umode_to_ftype(0) is FT_UNKNOWN,
so the nlink arm was not what protected against the zombie inode the
original commit was fixing.

DIO orphans need no exemption: ocfs2_add_inode_to_orphan() is the only
caller that passes dio=true to ocfs2_orphan_add(), and it never drops a
link, so those inodes keep a positive link count.

Fixes: 7efb45f9685f ("ocfs2: invalidate inode if i_mode is zero after block read")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 7005e59519b2..371857673712 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1482,7 +1482,15 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
-	if ((!di->i_links_count && !di->i_links_count_hi) || !di->i_mode) {
+	/*
+	 * An open-unlinked inode legitimately has a zero link count on disk:
+	 * ocfs2_unlink() drops the last link and ocfs2_orphan_add() sets
+	 * OCFS2_ORPHANED_FL, while OCFS2_VALID_FL is only cleared later by
+	 * ocfs2_remove_inode().  DIO orphans keep their link count, so they
+	 * need no exemption here.
+	 */
+	if (!(le32_to_cpu(di->i_flags) & OCFS2_ORPHANED_FL) &&
+	    ((!di->i_links_count && !di->i_links_count_hi) || !di->i_mode)) {
 		mlog(ML_ERROR, "Invalid dinode #%llu: "
 			"Corrupt state (nlink = %u or mode = %u) detected!\n",
 		        (unsigned long long)bh->b_blocknr,
-- 
2.39.3

