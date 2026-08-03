Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE935E94E;
	Mon,  3 Aug 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780805; cv=none; b=G/oKhfqeqbIIVuNrC4YzBBbyhVXIujgqGRrm8INo2+KrorCRzrvBNFdL0jXHEzb7di1iJD51Xk07ZBZ753pN+db3Xnwd/umepBiWjCURUP3oWUUJqgirf3lnclE5vDcDupJiTFK8C8u4gc+/P0Zbq+wOaTXXo15pCI0g0fAwKy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780805; c=relaxed/simple;
	bh=Q/dZi5hA8K+90LfLFO+8KUhUpOlrWMKbGN5SGqZx6xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxMsmp5GWKCr2+X1yTKl//a901kwiNXBQ4R5o8gjbhk8oierkIAlXFP1t7+gIiNTB37a5eWIbhwa1Xpa437ktzWE1NY1/Ibkv066JnuNjoVupn8/aaYvxCfoEgpwiuhU1yuwvhw2QrveIYwX9+XsPyouR6rsVZDciZznJfr/VWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByOk3Meo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByOk3Meo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E491F00A3D;
	Mon,  3 Aug 2026 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780804;
	bh=RFgr9FRC1IjAIMhstc7EK8DGLKbN4/UtrRJfKSRkdJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ByOk3MeoSRiFLCLtdJom3R5VislGhactY42OwBmNp8TcPkscyn/S2qNnME5HPVVsn
	 p0GknCleJnvhga4WSp54YUZO9TjPwIUBuYIo+M0VjQg7HOZkdDBl/kqU9CShwRxIe3
	 uIsDQ+87EyhyZwPqWfJ8nR8uUbQ7k+GxUlCKGV0kqw7PPvbycjhYfoBctuR9HFAV6d
	 iqnPdu/AlJGruVyc7JWa55VPHf9uI/qqYJFrpahVlnmaCV31vMst8ujumgoVhVWUgl
	 mA16a7CxSyzNTfSPARvia4wY1YJee0YU7Tu725lHph2NL/GcmHT9r2rJfD+zrXRI4L
	 Ep/F7sNYDB78g==
From: Eric Biggers <ebiggers@kernel.org>
To: bpf@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 1/2] fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
Date: Mon,  3 Aug 2026 11:12:31 -0700
Message-ID: <20260803181232.14743-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803181232.14743-1-ebiggers@kernel.org>
References: <20260803181232.14743-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier and the dynptr abstraction ensure that the memory space
referenced by a dynptr remains valid.  They do not, however, provide any
guarantee that the contents of the memory are stable.  kfuncs are
expected to remain memory-safe even if concurrent modifications occur.

bpf_get_fsverity_digest() didn't follow that: it could crash if
arg->digest_size was concurrently modified.

Fix that by using the known-good value hash_alg->digest_size instead.

Also widen 'dynptr_sz' and 'out_digest_sz' to u64 to match the return
type of __bpf_dynptr_size().  It doesn't appear that it can actually be
more than INT_MAX currently (since __bpf_dynptr_data_rw() excludes
file-based pointers), but the correct type might as well be used.

Fixes: 67814c00de31 ("bpf, fsverity: Add kfunc bpf_get_fsverity_digest")
Cc: stable@vger.kernel.org
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/measure.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index cfe2d5e535f9..f8b3526af004 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -122,11 +122,11 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struct bpf_dynp
 {
 	const struct bpf_dynptr_kern *digest_ptr = (struct bpf_dynptr_kern *)digest_p;
 	const struct inode *inode = file_inode(file);
-	u32 dynptr_sz = __bpf_dynptr_size(digest_ptr);
+	u64 dynptr_sz = __bpf_dynptr_size(digest_ptr);
 	struct fsverity_digest *arg;
 	const struct fsverity_info *vi;
 	const struct fsverity_hash_alg *hash_alg;
-	int out_digest_sz;
+	u64 out_digest_sz;
 
 	if (dynptr_sz < sizeof(struct fsverity_digest))
 		return -EINVAL;
@@ -150,11 +150,13 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struct bpf_dynp
 	out_digest_sz = dynptr_sz - sizeof(struct fsverity_digest);
 
 	/* copy digest */
-	memcpy(arg->digest, vi->file_digest,  min_t(int, hash_alg->digest_size, out_digest_sz));
+	memcpy(arg->digest, vi->file_digest,
+	       min(hash_alg->digest_size, out_digest_sz));
 
 	/* fill the extra buffer with zeros */
 	if (out_digest_sz > hash_alg->digest_size)
-		memset(arg->digest + arg->digest_size, 0, out_digest_sz - hash_alg->digest_size);
+		memset(arg->digest + hash_alg->digest_size, 0,
+		       out_digest_sz - hash_alg->digest_size);
 
 	return 0;
 }
-- 
2.55.0

