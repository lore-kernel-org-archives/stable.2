Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819804;
	b=VGeUt1PICTwLSR1paejCXeredZa0kZgiE27eZMDSVXchNqohdX6P5HYuMk3dBBrUKOVc
	 2Omzt8L2lfcw2n634+/CxpBu97z4aXUarnf+7mtOUlkhjRz5K+fmIH/nW336bvkF1mXLb
	 /GoIgNyJFOcdnydePY9hPV7O5hBFTq8Gbw62I9jPQVAqdbLAHHpN+u4rDwGHh6xOU+IyK
	 KvVBUQrgqG1gIlZbpVVwdKfSMK9AeMMb8e6iaZCEqhNM5h9FQReQmjv02/iNUTX7JinRy
	 hPY2m9dpk+wqx0CToxPqedCN4qIRoAtdKzKfljuO7jHQUNcpd6AJIlJ9OyPLfjucPjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eSNiR/u+jF1juXBbpc/UT4G6ygT/mwfkEaeSc9JG4Bo=;
	b=QK46b46B8lVbGhLVk15RMUzp3jR+2fbHMEwajkdUZvHjudlcfUccqG3HdkOyVtph09US
	 qqKgfOeI1l22uM+dcdZ1zf8sPngPJOnKAUwMaS0MAyyb1ewED14Qrx37G3qpTtihoQuJv
	 4HHFxqb0AxebWNQsMy7qlq3kMAtgsQowmXT0yRbrlTPQQUYNjoUgsMWps2quBtFj/xhrE
	 EgaveSAeCiFOFj/RyL79fMQOs0mgQKIe+sSYp7tASybYpaWBLhTob8w9dO3FjGEcA6kCO
	 F/hXzzs24fX1WEHH9gvBAK7gDLT6qLQXiTrS9x3vM1BOmocPDfOt75qQmV7Mv2arxqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPML37VD;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65B606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A65B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPML37VD
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36caa19b0ffso610788eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793819803; x=1794424603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSNiR/u+jF1juXBbpc/UT4G6ygT/mwfkEaeSc9JG4Bo=;
        b=HPML37VDjqNIY79kIBbqkgr0jhTitN3IVcQUPu7dW9DT2p0aGqioBaqqa9L9V8ZLqn
         n8G4IEccGsEJajih8bcwZrWEoTrqUhRkxMzpy7ePIl9e94el616ne9BZ635i2X9wcfiM
         gKslbNEGQLIcAjrjujMkOx6g+9sBE7L854Wjt7piOzrUA4G8E291xPTXlpfxnHK8u+pL
         t3k9e7N27gFvtnQDfwGsCdqloM8s8w3kyaeMYq/CKPPmVyTpoyHrGbE4uVltYdm+H4hM
         aFgFdrA2533Qa08IyBCJXFfShfPoXuIR0XZBCqcXYRHs/ICmuRfjMmjSM/F7hnt3rCgb
         lD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819803; x=1794424603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSNiR/u+jF1juXBbpc/UT4G6ygT/mwfkEaeSc9JG4Bo=;
        b=Ow3DwuzGF48oYfJNHUQYDrBdPUEtXoINQz31zmc1Zd4EwvvmMFO6uF21AKyDve+8RL
         iUSQU2m/bMBKEsNb+k0TYRuMVdO1k+tAHY4jKIks/ChNu67K55jpQBmm3sArD8XqhrRp
         BZSpC4v+p1hdP8M2rOZqTeY+bWyGqEM30i70GyfPGcHXx8FPnTOHwCiAN7dZOPR7bc9C
         brFQjLcAJe2ODvrd7kDkgHAyRPWVSJT6sOx9WSB8yu/XX9xveYnMn4EaxshWV70GiodM
         HgQ7LU8KLM9i1YtFLWQAoBaaxRPZnrWi/JwAPu1/WVQTpX9cGfA7Njuv8slR0OS+fXDu
         pc4w==
X-Forwarded-Encrypted: i=1; AKwUvBzk9md6VBdnhpOU0ORcXs6gGzI8WVkC3dzwNJz1P9Gz4MZNim4O6SiwuquTnEwg03PMlZjIN80=@vger.kernel.org
X-Gm-Message-State: APuU4Z95L+EqcnMMFmEYt+1LyJKBN1wIoq5sDWK4Lp0erY0anaelHbg8
	uJ1r7TN5n+LrPy7fA+IZTkPExjheA6QFqGEBVR2XLAqKuN8rgenNbe2K
X-Gm-Gg: AYBFou18r3tRMYCByvRDkLKruPxcl8wnf+AD46FeNE8/e4N2SaIg0MB9QmkqiwnLw5S
	UM1a3VwHt71ckuumJU4Eo3RpmHzgEoUb9llXlafr0GfctUHGvPDQSm9h5hUK+RYVEWknIeIj9dA
	rulemFz3hMRKXjMQnXCBsbYW8GhhtEEwD5Nm3/D1XoHj0KHgs8rjf134WYEGFHBCYL20WNL/KCH
	5BQ12IRGRVJ06PhMbBfTnK1w+ovNb8qqrXAdswbTOc2PeAxqwFb1x6uHgC9snj3h1KbA76b2qis
	in4SdYxeySwMtJ0M2Vn7OfN5wuHylz+ycQsX0K1uIyr5/tYHDFcatGeWxq+NSgzIfiJhAGYHKhU
	Uqyx3EboqHyfnm1Q7JiKDrhr4nGOpRSOLl7HG/jkcSpCcbuD9ghyvLNcf91u79m9jOlAMG0rPof
	Ch/a3tTZrs4yWjcCGOhpur3VwJ5qN3a09nNYuToZHi5xWGr20Ih66FKwweHSNR/UhDGrJgqOyPa
	4zlT7f+skJ8oZVeZT9cAt/VnF6G31da2C31HxUxCKjNR3aAq4hELXypUbNbye5hgzo+0ZdD6Uko
	/tc4N5GRv/xepQcjGjM83j6qkQbXWS93fXzaDO2ZeL9kIzOzrI2Rir9fI+5DzJ5foEeNKTqpDoQ
	2VHIwJR8K7QpQlnxZtFEWHfbEn/sK7xSIQ9UAJw==
X-Received: by 2002:a05:7022:1707:b0:189:d6bf:7eaa with SMTP id a92af1059eb24-1ac5c3699f6mr22489147c88.16.1793819802794;
        Wed, 04 Nov 2026 11:16:42 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2f7sm10017000c88.9.2026.11.04.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:16:42 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: daehojeong@google.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] f2fs: read atomic replacements through the COW inode
Date: Wed,  4 Nov 2026 19:16:21 +0000
Message-ID: <20261104191621.89561-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Starting an atomic replacement drops the page cache and resets i_size,
but keeps the original block mappings so the operation can be aborted.
After a sparse write extends the replacement, buffered reads still use
those original mappings for the skipped range and cache the old data.
Commit removes the old gap mappings, but the cached data remains visible
even after reopening the file. A subsequent partial write to the gap can
write those stale bytes back to disk.

Resolve buffered reads through the COW inode during atomic replacement,
so unwritten ranges are read as holes. Keep using the original inode for
the read bio and its encryption context. Once FI_ATOMIC_COMMITTED is set,
use the newly committed original mappings again.

Hold the mapping invalidate lock while committing or aborting the atomic
write to serialize these mapping transitions with buffered-read faults
and readahead.

Fixes: 41e8f85a75fc ("f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/data.c    | 8 +++++++-
 fs/f2fs/segment.c | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 28fd8afff5d..89c4de3640d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2489,7 +2489,13 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 	map->m_lblk = block_in_file;
 	map->m_len = last_block - block_in_file;
 
-	ret = f2fs_map_blocks(inode, map, F2FS_GET_BLOCK_DEFAULT);
+	/* Original blocks are kept for rollback, not for replacement reads. */
+	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE) &&
+	    !is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
+		ret = f2fs_map_blocks(F2FS_I(inode)->cow_inode, map,
+				      F2FS_GET_BLOCK_DEFAULT);
+	else
+		ret = f2fs_map_blocks(inode, map, F2FS_GET_BLOCK_DEFAULT);
 	if (ret)
 		goto out;
 got_it:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 43f40071576..f45b5ad78fc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -193,6 +193,8 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
+	filemap_invalidate_lock(inode->i_mapping);
+
 	if (clean)
 		truncate_inode_pages(inode->i_mapping, 0);
 
@@ -218,6 +220,8 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 		f2fs_i_size_write(inode, fi->original_i_size);
 		fi->original_i_size = 0;
 	}
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	/* avoid stale dirty inode during eviction */
 	sync_inode_metadata(inode, 0);
 }
@@ -409,11 +413,13 @@ int f2fs_commit_atomic_write(struct inode *inode)
 		return err;
 
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
+	filemap_invalidate_lock(inode->i_mapping);
 	f2fs_lock_op(sbi, &lc);
 
 	err = __f2fs_commit_atomic_write(inode);
 
 	f2fs_unlock_op(sbi, &lc);
+	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.50.1 (Apple Git-155)

