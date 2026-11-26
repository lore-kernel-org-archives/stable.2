Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723994;
	b=oCprJmA5cFZuIklhrFrZesVulIgsbmLLj2B4n9BX+lcczwj/VYq0V9zs3pNZ4igWFupI
	 Q54qA4Kp6nbB/+ioqhDZV0eV/V14iq1wxL2+xxhsAfbegS4iGa95mpzNTtLfkzCVAh3T3
	 1mm1Q7o0J5u0ZGXyrv0ShQGa7lSXG5e8+8JUTo2k1blO1VHa3yobBbacg1Iq5lKQczky+
	 ayBxqQE+ANCDqDjrp9ABZOeMCc4FSuZvuUUzNbZUI4d3NcxLQ6Q0TklGHG/PExbFvppLu
	 qwXHxTUjR7smZjjuGRwXtDRi4csSbXEhzsarYgoDAd8VH3T53cVHA7dUN+lHsR1fJJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q38Klj330dtRWghQm6M3dh+epEB584jmasAttwXUnHw=;
	b=4PFsBFX5aWJ2cQnlucvLM54LR3/XEoy8WwdXMfIWOmKaZ6yrm08hhstt+bvSx4JnvyqG
	 0PNhuiPTB/gi9VRsQxjeCFUz85HEhrwS5b5Ye2CGe8ldSZ2iPG9wxrK5z14fmHoPItV7D
	 6frnt600tmoJxzgNUnhGpWwJDsMEsKM8VGgtB98itjT84l2tERlLDLMWD/XCvZ8z//qHM
	 h1Q07lca+Qahmoj0Y1kVwJw/Y7XY6EgakxxkDTKdDPfbQH0xselxVY6tV0FO4qGyUErG/
	 V28sFDonRsAjk2bzv0vMbJdATsA1xG3BtzJihpA61GYIIbM5VVuUh4eZvxBE9TlMhXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=e2b.dev;
	spf=pass smtp.mailfrom=e2b.dev;
	dkim=pass header.d=e2b.dev header.i=@e2b.dev header.a=rsa-sha256 header.s=google header.b=EkbGWBZL;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC82606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEC82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=e2b.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e2b.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e2b.dev header.i=@e2b.dev header.a=rsa-sha256 header.s=google header.b=EkbGWBZL
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-491846221ffso6483843f8f.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=e2b.dev; s=google; t=1795723992; x=1796328792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q38Klj330dtRWghQm6M3dh+epEB584jmasAttwXUnHw=;
        b=EkbGWBZL7E1vaDT/CSiNF9QMvL90vs9LoPdngbpiU9CZBY0lBXIADvCvOkz2uk2OGn
         6xs2TxKNgN6tgE4UOMJ2Pv4Ib60dtjpPAm/UH6CA6kea+pWnNfn8TgQlqZ1kRaJBIBFO
         vXEEU6x0/DoI6y2rfCTaHou6SFh/QmmBpdhu6mLR2ZkVSyjQA1KaIGwyacab8wqYziFK
         7gzQQHwfKIsdUdhUPTgL2AuxtabprlxhbZidg4xdKidttwpl2EiRkP3EgLi/+vjArzbV
         vo0x1dvpDYFFBxCMghRk3bHTypsYTFuAojpzhzkwxT0aNRrZK+gZOhRhgthZ26bZ9ydV
         slKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723992; x=1796328792;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q38Klj330dtRWghQm6M3dh+epEB584jmasAttwXUnHw=;
        b=uDPM1oOM/miGNQTJXiiSvnzSxI66/zH/JQG4uwmpPN+SI3cRyaaXEMZPNEZV7ObNit
         nmigEvwcUBEEVbg2hjpJjxA296ixCmKSj0z9gAGdti8lXIV62l5zQz5Hou71/NveVOKQ
         86cCTOiKCmyKO7YUgSIvQ5rqomteIPtPkErfFAeSddP/webWEXNuvJ8QhVWVeMrVbnUf
         gMWUUxJCpH3h29Wxmp7MYGYZXJID9seV9PzAtb/cgLywStyWyuWY+bx/QSc687UDWMXg
         U2UmECo+Cod4qOeJI1zq5k5E2nud9No+g+utxcIxTqMFmFm9G2xVbkzH+PMK8fAcSHaP
         3JUw==
X-Forwarded-Encrypted: i=1; AL+hErE8/buTeiA6E4SJWaK/zjm9RF7RcHIhw33Hy/y7Q2Uyj6JhWUJtpL2GWMmZ84zxCNRclyutDO0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2GpIz4HlbjA1HoW2eGMM5ruUC6AVhH4FcvDrST2ElCXB4PbqV
	XK/L9RY9ESNnD6Gdk5OwkUtEgCpgeFgc8gw+9H+RW2tV0YaTEyrqtzcZvnAG8lxXttI=
X-Gm-Gg: AZFdTZcw0iSYI6J8YMFnRKjOVNzhhZRrgsjT9hFGE9Wjoo0bckITm/F1bHNeGm9tQKk
	7xv/Q1hhtHacrRq7Apb7oFloowzFdEdz6aKZeOqYkfIEwcFnfQbnj+ieDcOR6L5847+bMJkSUcf
	jbZzDz+6wRkzVacQl8wu4Uc24yqJtyMg1j2ODu/SykRzQQifv2h6PyMAAvyPqWRGuZ8lKyoO91+
	MPEoijLUybiX51CN82kqq70j/dV/7OG2DHJyT2ofF6WZgQVR/PrDktHtgvlYPAhS9wsTKyN7Ido
	7A7L3XG3BvUKVPyPMIi4seS3WqrKtSO7cA05pqr9i6TxMV7ZorcqA+H/Ucnc5pPSZ1mFe8Afz9x
	kEWZSdA2MyziOESpTMAz/LQdfFe3T9L7yZjForN86IELSffkYibFGfXF/X4vvlaH2wFDqRefbVM
	9CuXlh/22JonaK2f0u1cYLXR+z2O2A+E7ATS04fWgeQOpSkP2cRYebGokmVlzBEw+FQQSWwmU13
	lbdseqZxJYoepWYjKQ5OrhpTVleZrkYuc+DEnOeXAwLav3kTkwrafEzV8Q/vGGGHkVHVhPv/E4e
	1f4L96Etk4QUsL+6/X7oyjjHRxjRseFIbYwvxqDq70cs6yPh
X-Received: by 2002:a05:600c:e41a:b0:4bb:9959:54b8 with SMTP id 5b1f17b1804b1-4bb9959552emr248867915e9.32.1795723992219;
        Thu, 26 Nov 2026 12:13:12 -0800 (PST)
Received: from fedora.sphynx-tuna.ts.net ([2a02:8308:397:e200:f9e9:8bad:f8cc:87a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm1154281665e9.4.2026.11.26.12.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:13:11 -0800 (PST)
From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <petr.vanek@e2b.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	=?UTF-8?q?Petr=20Van=C4=9Bk?= <petr.vanek@e2b.dev>,
	stable@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/3] ext4: convert regular file inline data through the page cache
Date: Thu, 26 Nov 2026 21:12:54 +0100
Message-ID: <20261126201258.1553196-3-petr.vanek@e2b.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126201258.1553196-1-petr.vanek@e2b.dev>
References: <20261126201258.1553196-1-petr.vanek@e2b.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ext4_convert_inline_data() moves a regular file's inline data to a new
block by copying it into the block device's buffer for that block and
journalling the buffer as metadata.  The file's own writes reach the
same block through the page cache, and nothing invalidates the
journalled copy.  When the journal checkpoints it, the stale buffer is
written over whatever the file has put in the block since.  The page
cache can also miss the data altogether: a folio read in after the
conversion reads the block from disk before the checkpoint has written
it.

Truncate, fallocate, page_mkwrite and fs-verity all convert inline
files this way, and since commit ed9356a30e59 ("ext4: convert inline
data to extents when truncate exceeds inline size") so does every
truncate that grows an inline file.  An ordinary sequence now loses
data:

  mkfs.ext4 -O inline_data /dev/vda
  mount /dev/vda /mnt
  xfs_io -f -c "pwrite -S 0x61 0 42" /mnt/f
  sync; echo 3 > /proc/sys/vm/drop_caches
  xfs_io -c "truncate 0" -c "truncate 77" -c "pwrite -S 0x62 0 77" /mnt/f
  sync; echo 3 > /proc/sys/vm/drop_caches
  od -c /mnt/f    # 77 zero bytes instead of 77 'b'

Growing the file without shrinking it first leaves the old inline bytes
on disk but loses whatever was written after the truncate, and
fallocate or an mmap write on a small inline file loses the new data
the same way.

Convert regular files the way a buffered write does in
ext4_convert_inline_data_to_extent(): copy the inline data into
folio 0, drop the inline data, map block 0 with ext4_get_block() and
dirty the folio.  The data then reaches the disk by writeback, and only
metadata goes through the journal.  The new helper differs from the
buffered-write one in three ways:

 - It always maps a written extent, never an unwritten one, so that in
   data=ordered mode the commit that drops the inline copy waits for
   the data.
 - An empty file needs no block; only the inline data is dropped.
 - If mapping the block fails, it restores the inline data instead of
   truncating the file: truncation takes invalidate_lock, which
   ext4_page_mkwrite() already holds shared.

Directories keep the old path, since their blocks are metadata.

Fixes: ed9356a30e59 ("ext4: convert inline data to extents when truncate exceeds inline size")
Cc: stable@vger.kernel.org
Signed-off-by: Petr Vaněk <petr.vanek@e2b.dev>
---
 fs/ext4/inline.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index acdc65ce4796..537857c3b4b2 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1999,6 +1999,121 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 	return err;
 }
 
+/*
+ * Move a regular file's inline data to block 0 through the page cache, as a
+ * buffered write does, so the data reaches the disk by writeback.  It must not
+ * be journalled as a metadata block: checkpointing that copy later would
+ * overwrite whatever the file has written to the block since.
+ */
+static int ext4_convert_inline_data_reg(struct inode *inode)
+{
+	struct address_space *mapping = inode->i_mapping;
+	int ret, ret2, needed_blocks, no_expand, retries = 0;
+	unsigned int inline_size, len;
+	struct buffer_head *bh;
+	struct ext4_iloc iloc;
+	struct folio *folio;
+	handle_t *handle;
+	void *buf;
+
+	needed_blocks = ext4_chunk_trans_extent(inode, 1);
+
+	ret = ext4_get_inode_loc(inode, &iloc);
+	if (ret)
+		return ret;
+
+retry:
+	buf = NULL;
+	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, needed_blocks);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto out_brelse;
+	}
+
+	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
+				    mapping_gfp_mask(mapping));
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
+		goto out_stop;
+	}
+
+	ext4_write_lock_xattr(inode, &no_expand);
+	ret = 0;
+	if (!ext4_has_inline_data(inode))
+		goto out_unlock;
+
+	inline_size = ext4_get_inline_size(inode);
+	len = min_t(loff_t, inline_size, i_size_read(inode));
+	if (len > i_blocksize(inode)) {
+		EXT4_ERROR_INODE(inode, "inline data size %u exceeds block size",
+				 len);
+		ret = -EFSCORRUPTED;
+		goto out_unlock;
+	}
+
+	ext4_fc_track_inode(handle, inode);
+	if (!len) {
+		ret = ext4_destroy_inline_data_nolock(handle, inode);
+		goto out_unlock;
+	}
+
+	buf = kmalloc(inline_size, GFP_NOFS);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+	ret = ext4_read_inline_data(inode, buf, inline_size, &iloc);
+	if (ret < 0)
+		goto out_unlock;
+
+	if (!folio_test_uptodate(folio)) {
+		ret = ext4_read_inline_folio(inode, folio);
+		if (ret < 0)
+			goto out_unlock;
+	}
+
+	ret = ext4_destroy_inline_data_nolock(handle, inode);
+	if (ret)
+		goto out_unlock;
+
+	/*
+	 * A written extent, not an unwritten one: in data=ordered mode the
+	 * commit that drops the inline copy then waits for the data.
+	 */
+	ret = ext4_block_write_begin(handle, folio, 0, len, ext4_get_block);
+	if (ret) {
+		ext4_restore_inline_data(handle, inode, &iloc, buf, inline_size);
+		goto out_unlock;
+	}
+
+	bh = folio_buffers(folio);
+	clear_buffer_new(bh);
+	if (ext4_should_journal_data(inode)) {
+		ret = do_journal_get_write_access(handle, inode, bh);
+		if (!ret) {
+			folio_mark_dirty(folio);
+			ret = ext4_handle_dirty_metadata(handle, NULL, bh);
+		}
+	} else {
+		block_commit_write(folio, 0, len);
+	}
+
+out_unlock:
+	ext4_write_unlock_xattr(inode, &no_expand);
+	folio_unlock(folio);
+	folio_put(folio);
+out_stop:
+	ret2 = ext4_journal_stop(handle);
+	if (!ret)
+		ret = ret2;
+	kfree(buf);
+	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+		goto retry;
+out_brelse:
+	brelse(iloc.bh);
+	return ret;
+}
+
 int ext4_convert_inline_data(struct inode *inode)
 {
 	int error, needed_blocks, no_expand;
@@ -2022,6 +2137,9 @@ int ext4_convert_inline_data(struct inode *inode)
 			return 0;
 	}
 
+	if (S_ISREG(inode->i_mode))
+		return ext4_convert_inline_data_reg(inode);
+
 	needed_blocks = ext4_chunk_trans_extent(inode, 1);
 
 	iloc.bh = NULL;
-- 
2.56.1

