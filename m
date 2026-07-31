Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA1290DBB;
	Fri, 31 Jul 2026 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785458634; cv=none; b=R8I6LgsiQOLd3CYy8FNRc7fB2weS7ET6PhrQGEb2+N3T77RUSmQdsbsYX57kxhYU2AwspAaaszP74iSMrZne/3JRVjUGKj44xsSeVj7j8zcCkf91nGsCTJh/Xi+g8Gpw+Sk+W+l39tWs5d1XX8USwofJrLAg/M0IfNk1stqGy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785458634; c=relaxed/simple;
	bh=wG2dMQr6fnGnd/It+1xMbwLtOnqk3333NaZf0Z0xeQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTCQWKcJ7/ZNKWvFJeYIeqzJ0HXJrXtnxNYDdnXQjOgwXABaTbUMRFZM1r27xZbQK8lPmwQcy6pGvYaF+y5IWzNE+QPwGEwCx9YaukdqgbIyheiGaelmr4eTDWsWt/mpGSlme3iOtyhnn/r8D5dJW1K4YNO5djLzKnW4w+VK2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpDCbj5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpDCbj5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1085B1F000E9;
	Fri, 31 Jul 2026 00:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785458630;
	bh=y1cTrfSjEicTSohljYkboJ2gRQlh32PgZX/BaD7HEwY=;
	h=From:To:Cc:Subject:Date;
	b=MpDCbj5JyGWGY0KSIvpo/K84czQls7HhZiMW8tVKj9PdHeU79hSLN/QhYkzutBQro
	 LXkqZ8623DyleOZ7jB72Zc5SfL01ogDeDRkEGk9N3n4qq6kr3UlVTAH0uNZI66ESzA
	 jHzzBU+JNnNjxwT6Em+GJMBTfb8nO0+Am8khhTOREodYAdZ2k98rtOTn+/wUckWRlv
	 d90+gOQAOLHfbwrF2gAbwsfnPvCkbIDTCxw6PQV22lMO/Ak7qygiVpfwjjDi/WkZQQ
	 LaYF/3ONoELSOvcu/vVkxI2EaJroOntKDm9/EnojmHnhAsoJHLR0LLoIqAVw4xeciB
	 OIQsIhGqKCtww==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: bpf@vger.kernel.org,
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
Subject: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
Date: Fri, 31 Jul 2026 00:39:25 +0000
Message-ID: <20260731003925.2728977-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
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

Also correctly handle sizes over INT_MAX, which previously caused an
integer overflow and crash.  __bpf_dynptr_size() returns a u64.

Fixes: 67814c00de31 ("bpf, fsverity: Add kfunc bpf_get_fsverity_digest")
Cc: stable@vger.kernel.org
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

base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.55.0.508.g3f0d502094-goog

