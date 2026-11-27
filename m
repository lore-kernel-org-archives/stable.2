Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776983;
	b=UQLyb+0BybmdlMHCmn+3/toSuc5gZqhPTVkWpmv7Rr3dzKfkQEF8zC2/TFXsORBubO2e
	 4l9tl9+lbSGacC74wue5i/P2HXGFoKCQYfPF24Gz/S9zs8KDoFK5XJg9umyHV92KnxueO
	 KE0Mo2Lb2rJueDygJlNvMCe9gGzkfb7RcN8QJpnxUMK+nq0GvAfVwSGspjcDNAYqWJxkM
	 vhniw8T4Q5vicJWV+YGa9vUMR50OZA9/X38oXqcvMnwrtOkmSQ2psspsc5JkqYV2ft3zf
	 7cpVFhvYZ2T95c3OmufUdIe8QcvJffKYzg+eaXbA5e+t0KEdxcK780uTqALfHddw9TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776983;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2WgYEma8TSQsWwbF8NY48UPlyoNjGV3ToSrWkt+zFJQ=;
	b=NwGNUePazwmwofSpF66wXnTBNf+sKF/oUace++jKfyUAr/S+U91oG3Pi7JhbcxllJtDQ
	 9hUbZTci1cnKfvKKxbPCiO+P1XdCK8Ig7mGaYrdPSREGQYL/0+HqOWQDVWqOpDzmJyCbm
	 LjgkrcR3Nf+C7DlFz9eM0EhSeJATk2wR4ELG8zzFtkFACP0Etw+BrraPRiKvy4kcKFIb2
	 Sd6T6AWSim8L6nWOrggoMQiMNhn0jMPzPL9X1aLZ6Fg5+P1VSyLGdYwzKZmF/s1v9fPc2
	 uQr/J84kC77yzvIKbxUMpTChf2opbtbJS6cvqkpysLSMrp65cJ6qnDivaITx6JNO6pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gf+VMqw/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962EF606A69C;
	Fri, 27 Nov 2026 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gf+VMqw/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C83F1F0092F;
	Fri, 27 Nov 2026 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776983;
	bh=2WgYEma8TSQsWwbF8NY48UPlyoNjGV3ToSrWkt+zFJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gf+VMqw/N5Ruwdn1LihzyB0kyz2AcIDi45Ht1U5SbQRIOEdoH7sEFQvi+Yks+CQxM
	 hwNv9lkF1OkWC1GgEr4pcLMR3N7Y1HJFTZ76Tpf+w5MRJPguUQ13zIZ+rM8ZHI4uyi
	 26M4b1j0oB63FjVLzuDU09qPGled0Te09ot+mfD/5eF4hVFx6rVzHtPJwqAVaKC0/4
	 u4si2mB4AW5SX7mbIrmqT+bSV4IJM6J9COcqzHrzrUEx/YMul6LWOZCJb8pKFVNSJl
	 irDfaEktfhSB9sS88+CgyM953/4E1FHaUn/TX9jjx0ohXsH6g4LFJc5FS3xdix3OrR
	 sAEdDNe2zUnEw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 6/7] f2fs: fix to serialize truncation of COW blocks w/ GC
Date: Fri, 27 Nov 2026 10:56:13 +0000
Message-ID: <20261127105608.537148-13-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127105608.537148-8-chao@kernel.org>
References: <20261127105608.537148-8-chao@kernel.org>
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

From: Chao Yu <chao@kernel.org>

GC migrates blocks of COW inode w/ the COW inode and its i_gc_rwsem,
however f2fs_ioc_start_atomic_write() truncates blocks of the reused
COW inode w/o holding COW inode's i_gc_rwsem, it only holds the
original inode's locks, so the truncation can race w/ GC.

Case #1: GC caches stale data of a freed block in meta cache

- GC (phase 3, cow inode C)		- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
- f2fs_down_write_trylock(C's i_gc_rwsem[WRITE])
- ra_data_block(C, j)
 - f2fs_grab_cache_folio(orig mapping, j)
 - f2fs_get_dnode_of_data(C, j)
 : get P
 - f2fs_put_dnode()
 - f2fs_is_valid_blkaddr(P)
 - f2fs_folio_wait_writeback()
 - f2fs_wait_on_block_writeback()
					- f2fs_ioc_start_atomic_write()
					 - f2fs_down_write(orig's i_gc_rwsem)
					 - f2fs_do_truncate_blocks(C, 0, true)
					  - f2fs_truncate_data_blocks_range()
					   - f2fs_set_data_blkaddr(NULL_ADDR)
					   - f2fs_invalidate_blocks(P)
					    - f2fs_invalidate_internal_cache(P)
					    : nothing is cached
 - f2fs_grab_cache(META, P)
 : cache P in META[P]
 - f2fs_submit_cache_read(P)
 : SIT of P is still valid
					    - update_sit_entry(P, -1)
					    : P was freed
- end_io: f2fs_cache_set_uptodate(META[P])
: META[P] is stale for a freed block

On superblock w/o encrypt, verity and compression features, checkpoint
does not truncate meta cache, so META[P] survives after checkpoint, then:

- checkpoint, P can be reused
- writeback of victim's atomic write
 - do_write_block()
 : allocate P, write victim's data to P, META[P] is not invalidated
- GC phase 3: ra_data_block(victim's cow inode, k)
: META[P] is uptodate, skip reading
- GC phase 4: move_data_block(victim's cow inode, k)
: META[P] is uptodate, skip reading
 - memcpy(tentry, sentry)
 - f2fs_update_data_blkaddr(newaddr)
: victim's block was overwritten w/ stale data

Case #2: GC reports a false inconsistency error

- GC (phase 3, cow inode C)		- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
- ra_data_block(C, j)
 - f2fs_get_dnode_of_data(C, j)
 : get P
 - f2fs_put_dnode()
					- f2fs_do_truncate_blocks(C, 0, true)
					 - f2fs_invalidate_blocks(P)
					  - update_sit_entry(P, -1)
 - f2fs_is_valid_blkaddr(P, DATA_GENERIC_ENHANCE)
 : or in f2fs_submit_cache_read()
  - __is_bitmap_valid()
   - f2fs_err("Inconsistent error blkaddr:...")
   - set_sbi_flag(SBI_NEED_FSCK)
   - dump_stack()
   - f2fs_handle_error(ERROR_INVALID_BLKADDR)

All other truncation paths hold i_gc_rwsem[WRITE] of the truncated
inode, let's hold COW inode's i_gc_rwsem[WRITE] during truncation of
COW blocks as well, then GC will skip COW blocks due to failure of
f2fs_down_write_trylock().

Cc: stable@vger.kernel.org
Fixes: f18d00769336 ("f2fs: use meta inode for GC of COW file")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase to the latest dev-test branch.

 fs/f2fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ddf71ed6e41e..10c198117f57 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2653,11 +2653,20 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
+		struct f2fs_inode_info *cfi = F2FS_I(fi->cow_inode);
+
 		f2fs_bug_on(sbi, get_dirty_blocks(fi->cow_inode));
 
 		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
 
+		/*
+		 * GC migrates COW blocks w/ cow inode and its i_gc_rwsem, so
+		 * hold it to serialize truncation of COW blocks w/ GC.
+		 */
+		f2fs_down_write_nested(&cfi->i_gc_rwsem[WRITE],
+						SINGLE_DEPTH_NESTING);
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
+		f2fs_up_write(&cfi->i_gc_rwsem[WRITE]);
 		if (ret)
 			goto out_unlock;
 	}
-- 
2.49.0

