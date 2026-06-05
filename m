Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net [178.154.239.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB33466B72;
	Fri,  5 Jun 2026 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780656246; cv=none; b=OBtLaVK3kaJo5j+7QEMrch4/KPEzjp0U4ZT4pCw8bWtb46dX0x76SKJoMQlm1bvkCihku1wsPhwHIsa+EUb2Zcw/TpzqbLz3drKVzQ2KL4cmKxoowL4NCustmajB1ndgvrvlCcrz7fuECmQlqAidsKK3t66fOmv6iA5iQHaoImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780656246; c=relaxed/simple;
	bh=LkYqiCDqco6mevM8zai4datk6nmQUALOCQEH0MFK+NI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V6cK4VhiLFbF45An6WEABsbBnfqcH9b0MjDyBwiPa5AXEDrH7yzo4s3MDK0kehvb81Rwu6tegvx1MMBa/CcGMoTEetalC4kr1lGHdS/t3/F5WNt9gQ+K7CJliWPu6kZDenTZI8/3U0JuKDaNSIrS+sqJSsbbYOQbjxydKFQtbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=knUqC+WD; arc=none smtp.client-ip=178.154.239.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="knUqC+WD"
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward202a.mail.yandex.net (Yandex) with ESMTPS id C1261845BA;
	Fri, 05 Jun 2026 13:38:46 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c18:0:640:5600:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id C1E9F804C0;
	Fri, 05 Jun 2026 13:38:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp) with ESMTPSA id ZcffmqLe7a60-kaRNz9XR;
	Fri, 05 Jun 2026 13:38:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1780655918; bh=roqDwFCKSOfqoEvMH3HcV0q1plvbGQsfEEkLVszHKiA=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=knUqC+WDUAgnqxDKtEh2dL3DL5dQWXYQLusjUQPo7MUozKS5ebwl+3MFZW/HGzuUp
	 mM+9j+8wjSbropEF3yhxkZ6LbDLvPa1kBwQhOa82kf0UcoCI+z3A33aL1bQ42RAUe1
	 m6Ona2oyCubeeWta9gejEwsVQTeY9p9AcgP0bT7U=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: jaegeuk@kernel.org,
	Chao Yu <chao@kernel.org>
Cc: daehojeong@google.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] f2fs: read COW data with the original inode during atomic write
Date: Fri,  5 Jun 2026 13:38:34 +0300
Message-Id: <20260605103834.14894-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When updating an atomic-write file, f2fs_write_begin() may read the
previously written data back from the COW inode:
prepare_atomic_write_begin() locates the block in the COW inode and sets
use_cow, and the read bio is then built with the COW inode:

	f2fs_submit_page_read(use_cow ? F2FS_I(inode)->cow_inode : inode,
			      ...);

and f2fs_grab_read_bio() decides whether to schedule fs-layer decryption
(STEP_DECRYPT) for the bio based on that inode via
fscrypt_inode_uses_fs_layer_crypto().

However, the folio being filled belongs to the original inode
(folio->mapping->host == inode), and the data stored in the COW block was
encrypted (or left as plaintext) using the original inode's context, not
the COW inode's -- see f2fs_encrypt_one_page(), which keys off
fio->page->mapping->host.  fscrypt_decrypt_pagecache_blocks() likewise
operates on folio->mapping->host.

The COW inode is created as a tmpfile in the parent directory and inherits
its encryption policy from there.  With test_dummy_encryption the newly
created COW inode gets the dummy policy and becomes encrypted, while a
pre-existing regular file -- created before the policy applied, e.g.
already present in the on-disk image -- stays unencrypted.  The read
path then sets STEP_DECRYPT based on the encrypted COW inode and calls
fscrypt_decrypt_pagecache_blocks() on a folio whose host (the unencrypted
original inode) has a NULL ->i_crypt_info, dereferencing it:

  Oops: general protection fault, probably for non-canonical address ...
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:fscrypt_decrypt_pagecache_blocks+0xa0/0x310
  Workqueue: f2fs_post_read_wq f2fs_post_read_work
  Call Trace:
   fscrypt_decrypt_bio+0x1eb/0x340
   f2fs_post_read_work+0xba/0x140
   process_one_work+0x91c/0x1a40
   worker_thread+0x677/0xe90
   kthread+0x2bc/0x3a0

The COW inode is only needed to locate the on-disk block, and that block
address is already resolved into @blkaddr; the data's crypto state belongs
to the original inode.  Read with the original inode so the post-read
decryption decision matches the folio's owner.  This also makes the inline
crypto path use the correct (original inode's) key.

Fixes: 591fc34e1f98 ("f2fs: use cow inode data when updating atomic write")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
---
 fs/f2fs/data.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cf05014fa5e3..8f6c22537e9f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3961,8 +3961,18 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 			err = -EFSCORRUPTED;
 			goto put_folio;
 		}
-		f2fs_submit_page_read(use_cow ? F2FS_I(inode)->cow_inode :
-						inode,
+		/*
+		 * Although the block is stored in the COW inode, the folio
+		 * belongs to @inode and its data was encrypted (or left as
+		 * plaintext) using @inode's context, not the COW inode's; see
+		 * f2fs_encrypt_one_page(), which keys off fio->page->mapping->
+		 * host.  fscrypt_decrypt_pagecache_blocks() likewise operates
+		 * on folio->mapping->host.  Read with @inode so the post-read
+		 * decryption decision matches the folio's owner; otherwise an
+		 * unencrypted @inode whose COW inode is encrypted would hit a
+		 * NULL ->i_crypt_info during decryption.
+		 */
+		f2fs_submit_page_read(inode,
 				      NULL, /* can't write to fsverity files */
 				      folio, blkaddr, 0, true);
 
-- 
2.39.5 (Apple Git-154)

