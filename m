Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784115;
	b=a9i98C8wtIiBJLkw/hCD2pJf0O/mwAaDh8BsPK/n6WNqw0lIdzsZISJZSgPgDGI3X9lA
	 tRkNl6/8/tF4RA5AGvj/xB4/sc9XmEb1ychmboah++0XR8kcTgunTb726AsMFDAgI84sl
	 AEYz+0GhjI4Tkxa6ejaUctPaOayEDahqk0VOF9w2u28BMpGUlNf34vzR4WSANnLikTkpQ
	 rFyTCUVy3IBuQTGPMvZwQJB6PfFb5ZDzKKIuuQrw2PPorUWPWg5XmIPHlv3+56ce7/0Sx
	 hR2btVYWa2jcYRkFUk9g8mWhCD7dyYKg00X4yMs6SVZSmrjcmyX5UVztqt4tr5Dq2tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784115;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FPknVUZzK855S9yI8MClCScYyQIbXuE8HJCc9PdRG3U=;
	b=Odz7cX3BRe4KTDThzw8bwh7cgtuyA/BdGeL9l0l/w0GpMW4CNPKygu59Dszpne0skqWy
	 jxeUyv2zmTyK8HVQ+dQAzh8SkB5z8TNw6OY9WIntaQpjrkLNQAFCVednQCEWU2DtzWZW+
	 0shpEVLAF8okMc7oANfWGEy8R9fXmKXxax9ala3LayjC4WkxaQ4/T0ewG7dfe2m8Mfuue
	 ik/YmZy4LcjQ73PRxRi9cohWXf52IQVVwTMllhhMDrmz2RcMcGXcj/K+lhHDPW985nYcA
	 aS+5ERXX72UZmK2XPsB3S+l2x+G8RySHt8OYoQ/8fU5zP7kEshSmtxz966KIiq0h4Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=rFk12Nm1;
	arc=none smtp.remote-ip=203.205.221.236
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83A606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 09:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB83A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=rFk12Nm1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793784105; bh=FPknVUZzK855S9yI8MClCScYyQIbXuE8HJCc9PdRG3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rFk12Nm1f+vFblw78VXrH/eLb7uWoC+1X5XLwP+h+c5xXLvAtvOWU43sggOZm5EmN
	 kN71QB5oNlU+zvJIVv60CaqrcKRr7knRtFWIi4m4gCSv2pK0MPRdGq/NGlQ5NNeNPr
	 jTqwPGKXO82w81e9Ao5IgJapRXpbXMLkWxwiRhW8=
Received: from shuai-VMware-Virtual-Platform.. ([218.28.192.28])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 56998ADA; Wed, 04 Nov 2026 17:21:41 +0800
X-QQ-mid: xmsmtpt1793784101tjhggwlnf
Message-ID: <tencent_8E52FEA6C91DD754CC6282C41D4DFA95E505@qq.com>
X-QQ-XMAILINFO: ONXjbYTFhCz0/J0Xyv3rdUzwB8RdVBk8NhRjXndzEyFva+U/hiLGHZ/klARgaQ
	 3rhTelFTWkw+JjDE5Il6TA22cBOvIvTBA7ZFBPp3BwTEMNlcQn9HnPUpZpmDtIp5vwttXRI0qIAD
	 Epv+10TZznVNFL3UBkPaVsl7DVoNhCaoGI7EkhFVyrGy0eg+VLr2wZP/oUNnbFVe8IRAOEwp3NZr
	 B/4s2z09vSbOEx4rOMaYpzF1WY7Rn+3JudR+JyuygdYj3+SxZ7TvBbwza4AjColD/X0WiIwA1wSe
	 IO7cR/w9VneOBHxBha0Fe6YWZJuB/zQTOktyfLNM+AWL/f7lpSkRCPoHPNN/YNN8d1lSgTwRIjRh
	 7jKygNOv6P+YqUXmu7AoWcl0xsM4QYMEwC/By+q7vVkX3rWURTgVqnjUqIvaSVEPmGMWej+Fyq7g
	 m2u7WSZnxgiBmjyj2l/sVGg2fCgP4kJUDvr4Or62meJBJN+XOGlG+SuAV76lyDmvK6GkaR9VchbR
	 JilZiH2t8A2dkg79pN4khQYMJ3wc2MeNyugFRmjJSuqVVSMFst5cbrTx0OGIOIpjqCJ8xl9b/7u3
	 wRL0psRR/kw2L7F9dPtaWDmR/GpXuY65XqgaepGiBRjACcB7EvqjZsc93TNaqGWCZLeKbQPogqPv
	 W7rvsuStWFxntOUdYQz9Ms/RBLgkX6EdLgDkAok5mH34MHzNvVaezEMe8We25YFrMuBouDoZQ/M4
	 YJHt3HmIVCOwiGbzm6teZiuQSKE66HPDsxK1c8IcZDMUNC7TO+h5EFLwZ7/N0ScowqLlBpP3thiU
	 R8QBpZdqoSkbY5/vtzcGLEU6MmEWf5cWPIioPvqvrrKpIiun/TxxkblCsf90GH/eoV61EJiZqtN3
	 rWAmL0K6X3SqgLXUu+WlZHGATZ8GmIyUJnPB5qjseZT5hXPg1msNRtcDlbmpcmOYuNF3mkf/2LSu
	 bhXT3kql6wFl4YbIjoUsaTAX7LqqdeFLSJDOQr7RnlKOr+iyrx9HmvqAAwbSMqpXkHZlQKOmnaeS
	 msXTqROk9sFRxdcMDOMz2SdH7H05qGJiquLK9/7YyCRhTqZb2a4xSY1h+RDE0lOVi0Hx7MSrFm3h
	 cHBaNmOEe1DJgZwNNdBgl6pmaZ1w==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Shuai Liu <847807867@qq.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	linux-kernel@vger.kernel.org,
	syzbot+09bec78ee77613a3efdd@syzkaller.appspotmail.com,
	sashiko-bot@kernel.org,
	Shuai Liu <847807867@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ext4: fix slab-use-after-free in do_split()
Date: Wed,  4 Nov 2026 17:21:41 +0800
X-OQ-MSGID: <20261104092141.727845-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-196913@kernel.org>
References: <sashiko-outbox-196913@kernel.org>
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

do_split() allocates a new directory block with ext4_append() to hold
the second half of the entries of the leaf block being split, then
dx_move_dirents() copies entries from the old block (*bh) into the new
one (bh2).  Nothing verifies that the newly allocated block differs
from the block being split.

On a filesystem whose block bitmap is inconsistent with the directory
tree, a block already referenced as a directory leaf can still be
marked free, so ext4_append() can return that same block.  With
concurrent operations on such a filesystem (as exercised by the
syzbot reproducer), the block can even be freed between allocations,
resulting in bh2 aliasing *bh.  dx_move_dirents() then copies the
block onto itself, corrupting directory entries mid-copy: a rec_len
field can be overwritten with name bytes, so the subsequent wipe of
the stale entry memset()s a bogus length, causing the slab-use-
after-free reported by syzbot.

Fix this by checking for bh2 == *bh right after ext4_append() and
bailing out with -EFSCORRUPTED before any directory block contents
are modified, reporting the corruption via ext4_error_inode_block().

Reported-by: syzbot+09bec78ee77613a3efdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=09bec78ee77613a3efdd
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Liu <847807867@qq.com>
---

Changes in v3:
  - Also check for aliasing with the htree index block, as requested
    by Sashiko: check *bh == frame->bh before the allocation and
    bh2 == frame->bh after it.  An aliased index block would be
    overwritten by dx_move_dirents() / dx_pack_dirents(), letting
    dx_insert_block() memmove() out of bounds with a corrupted count
    and dx_release() brelse() garbage frames read past the stack
    array.

 fs/ext4/namei.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 354fc2d22df1..25bea69ab246 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1922,12 +1922,36 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	if (ext4_has_feature_metadata_csum(dir->i_sb))
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
+	if (*bh == frame->bh) {
+		ext4_error_inode_block(dir, (*bh)->b_blocknr, EFSCORRUPTED,
+				       "leaf block aliased with index block");
+		brelse(*bh);
+		*bh = NULL;
+		return ERR_PTR(-EFSCORRUPTED);
+	}
+
 	bh2 = ext4_append(handle, dir, &newblock);
 	if (IS_ERR(bh2)) {
 		brelse(*bh);
 		*bh = NULL;
 		return ERR_CAST(bh2);
 	}
+	if (bh2 == *bh) {
+		ext4_error_inode_block(dir, (*bh)->b_blocknr, EFSCORRUPTED,
+				       "cannot split aliased directory block");
+		brelse(bh2);
+		brelse(*bh);
+		*bh = NULL;
+		return ERR_PTR(-EFSCORRUPTED);
+	}
+	if (bh2 == frame->bh) {
+		ext4_error_inode_block(dir, bh2->b_blocknr, EFSCORRUPTED,
+				       "leaf block aliased with index block");
+		brelse(bh2);
+		brelse(*bh);
+		*bh = NULL;
+		return ERR_PTR(-EFSCORRUPTED);
+	}
 
 	BUFFER_TRACE(*bh, "get_write_access");
 	err = ext4_journal_get_write_access(handle, dir->i_sb, *bh,
-- 
2.43.0

