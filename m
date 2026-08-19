Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7D1F942;
	Wed, 19 Aug 2026 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181004; cv=none; b=SQ50gI+0etWdq3Vkq+stCQu3R4TlEn+kFFZol1HhmNXMPCpuxQ6uxhInyLYd2iw47WUxPP/y9z7fWsMsDlzBZnz1JHT6pnYY4tSMHyjb1EaIOjnZXZgb6IIzu4mDhZrZ655sl/8/jqH34gQHJPbV7AtZKs0Uj0wspe5vVb9E4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181004; c=relaxed/simple;
	bh=di8lDjxqjEUu2frXVo5i67auNBzudR9399AU6vo3m3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cusrw2i9uphmhbNtWiWp44AExzELbRnCnbU+txWKy0udImdN9Uq5cZMMpJ7PzsckQpOpuZWwZgI0+fESMHoLNJ9CynxZHerAuDsVOv11OS4J1F/dJ5OoZtUdxyqlwo/ga73aAO/DWCqq/bSW+cJRyLV7hqIxu0xZVzt5DSGtC3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDYwFiIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDYwFiIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8C81F00A3A;
	Wed, 19 Aug 2026 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181002;
	bh=oi3boUOkzX5Fioh5QmD8x8BL+37Kty3nYY/z7h2oQHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eDYwFiINKf5JbSo6traJNjGvUNvKn2Unt9Mn6smDBILf9U4IUjkavUTgZifrwAqWz
	 yHg63NRllhrOKx0FYHRTAnQEAJye3rBPsUdbDyayXpuJkpFlXBkKEuuvULhKm1uNQh
	 uFw5cSDqUo8t7aYpG2l/zs5xxp+EV6lIKe3EgTZz9RB7nUbdh7VPc7eVkofqYfts21
	 oQ57GFjvCl991rqZpYLkXO1kryScw1Rl4kMbQK6S8/W0ciJkY9C9yMMzW7FzMBv89y
	 eSAs/5Hweo3P3eeNosdIxb3CuCE6WYwnbsV6466bcipRitbqkmTMhU32oBuD4lO+MW
	 oXtK+8lEO8qSw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:18 +0200
Subject: [PATCH v2 01/22] powerpc/spufs: don't dump more than the note
 supports
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-1-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3760; i=brauner@kernel.org;
 h=from:subject:message-id; bh=di8lDjxqjEUu2frXVo5i67auNBzudR9399AU6vo3m3k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me9TjBGxXp7x+/vRRGW9M5M2n/7oyc3z+ml+gd7Fy
 R/NLvMldZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkzk5Ghq0i3AvsrVfacrDG
 83rFf/V/tkh9scZ9doFOg8K4k60TJzMyPDh05Nhn5ucTt2d8To4zOzjJMvnqDo53zzS7GIOEy1h
 kuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The spufs_arch_write_note() function puts notes in the header and uses
them to fin where the next note starts. The spufs_coredump_read[] array
provides the sizes of the notes:

	dump_skip_to(cprm, roundup(cprm->pos - ret + sz, 4));

In this call @ret is the amount of data the dump callback wrote. @sz is
the declared size. So the position moves backwards if the callback
wrote more data than the declared size.

For three note sizes that is the case:

(1) signal1 sets sizeof(u32) and dumps u64 via sizeof(ctx->csa.spu_chnldata_RW[3])
(2) signal2 sets sizeof(u32) and dumps u64 via sizeof(ctx->csa.spu_chnldata_RW[4])
(3) ibox_info sets sizeof(u32) and dumps a u64 via puint_mb_R

The note is 4 byte aligned. The dump_emit() call wrote the dump_align(4)
just before the note. So if @ret is 8 and @sz is 4 the position ends up
4 bytes before the current position which means cprm->to_skip is now
negative.

For __dump_skip() with size_t that means the pipe or socket gets 2^52
PAGE_SIZE zeroes. This also means a file seeks backwards and overwrites
the four bytes that it just wrote.

Before commit 5456ffdee666 ("powerpc/spufs: simplify spufs core
dumping") this was benign because this truncated (on purpose, I
presume):

	u32 data;

	data = ctx->csa.spu_chnldata_RW[3];
	...
	copy_to_user(buf, &data, 4)

and after said commit things became fscked. So let's truncate this
again. Not truncation means the wrong bits will be picked on big endian.

Afaict, spufs is effectively dead so the fix probably doesn't matter in
the grand scheme of things.

Fixes: 5456ffdee666 ("powerpc/spufs: simplify spufs core dumping")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/file.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index de7494748fec..6f86d87e3749 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -956,10 +956,12 @@ spufs_signal1_release(struct inode *inode, struct file *file)
 static ssize_t spufs_signal1_dump(struct spu_context *ctx,
 		struct coredump_params *cprm)
 {
+	u32 data;
+
 	if (!ctx->csa.spu_chnlcnt_RW[3])
 		return 0;
-	return spufs_dump_emit(cprm, &ctx->csa.spu_chnldata_RW[3],
-			       sizeof(ctx->csa.spu_chnldata_RW[3]));
+	data = ctx->csa.spu_chnldata_RW[3];
+	return spufs_dump_emit(cprm, &data, sizeof(data));
 }
 
 static ssize_t __spufs_signal1_read(struct spu_context *ctx, char __user *buf,
@@ -1089,10 +1091,12 @@ spufs_signal2_release(struct inode *inode, struct file *file)
 static ssize_t spufs_signal2_dump(struct spu_context *ctx,
 		struct coredump_params *cprm)
 {
+	u32 data;
+
 	if (!ctx->csa.spu_chnlcnt_RW[4])
 		return 0;
-	return spufs_dump_emit(cprm, &ctx->csa.spu_chnldata_RW[4],
-			       sizeof(ctx->csa.spu_chnldata_RW[4]));
+	data = ctx->csa.spu_chnldata_RW[4];
+	return spufs_dump_emit(cprm, &data, sizeof(data));
 }
 
 static ssize_t __spufs_signal2_read(struct spu_context *ctx, char __user *buf,
@@ -1965,10 +1969,12 @@ static const struct file_operations spufs_mbox_info_fops = {
 static ssize_t spufs_ibox_info_dump(struct spu_context *ctx,
 		struct coredump_params *cprm)
 {
+	u32 data;
+
 	if (!(ctx->csa.prob.mb_stat_R & 0xff0000))
 		return 0;
-	return spufs_dump_emit(cprm, &ctx->csa.priv2.puint_mb_R,
-			       sizeof(ctx->csa.priv2.puint_mb_R));
+	data = ctx->csa.priv2.puint_mb_R;
+	return spufs_dump_emit(cprm, &data, sizeof(data));
 }
 
 static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,

-- 
2.53.0

