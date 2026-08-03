Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420741D20B;
	Mon,  3 Aug 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780806; cv=none; b=KC3J4Rh1vuKJVXy0lz4qVB1Yrgwu55hr3Lo5K1n+vD1fTN9FoJLLcLOpynVGiDaHXBj/hD64BkDMbUN0iTsGhKGRpgee2znk75AyUL4rOz2XgbZvfRVYEsVubu/W81EOIoNbMy3Kzz3ndzHRescDVnSPFDvcyUCtd2eppddBtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780806; c=relaxed/simple;
	bh=t204v6IkJFOLWcsbZpo6q1sU+xH6NxOUQi54boeo3ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZbutAskyGVZGhtDHU+fI7S/jl/JYfkzaikXhimjLvcFz/Nm77n+Su3ncs0K7/hDv8XN4/Y9IirBpFKg7CfDSZjH559RVNah6+NyN6qgU50UJfS6gSp7ZS0o4lBAn3ecqs//++daa7mGFkCWmQFqswlQei068oiKSV5wxP1XC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgxB9j6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgxB9j6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1C31F00A3A;
	Mon,  3 Aug 2026 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780804;
	bh=M++mqAzNlFzgVh8y1H7yy6racbyWVV1Hx6y+OsOYWKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hgxB9j6tfiLskWRkxk16CwZ60Y0rcV6+42+wCGdAHOowSlGGKkccF/t6f7twRqU8s
	 dhXny1DbG3+pjHKXdPoLFl/OLmsj5+vhhnakOu9+CQDl65yfdKBT8KUD0I6yF7wU5/
	 g0Xmap5dPBF5naD51JQjoWAOfnXJostrklCryCvSSE4E0KsonuEfNNt8/mCPdXMh/C
	 JjmOZhSM2793U2UzzlZ4F1qgA2DlSqHwVgYh1rrsd6VebpA550Zb1l2WYsv/VqvUT2
	 bKo0LAv+A6u8w3y3sI/ynDJaCBzn6LEl88MlVX9WJ870eevhq0qpMUBExuM2dcAk+/
	 2/lFh8sGpq6qg==
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
Subject: [PATCH bpf v2 2/2] fsverity: Fix silent truncation in bpf_get_fsverity_digest()
Date: Mon,  3 Aug 2026 11:12:32 -0700
Message-ID: <20260803181232.14743-3-ebiggers@kernel.org>
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

bpf_get_fsverity_digest() silently truncates the digest if the provided
buffer is too small.  This is a footgun, and it doesn't match the
semantics of the equivalent UAPI (FS_IOC_MEASURE_VERITY).

Change it to return -EOVERFLOW instead, matching FS_IOC_MEASURE_VERITY.

Fixes: 67814c00de31 ("bpf, fsverity: Add kfunc bpf_get_fsverity_digest")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/measure.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index f8b3526af004..68dfccb69772 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -144,14 +144,15 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struct bpf_dynp
 
 	hash_alg = vi->tree_params.hash_alg;
 
+	out_digest_sz = dynptr_sz - sizeof(struct fsverity_digest);
+	if (out_digest_sz < hash_alg->digest_size)
+		return -EOVERFLOW;
+
 	arg->digest_algorithm = hash_alg - fsverity_hash_algs;
 	arg->digest_size = hash_alg->digest_size;
 
-	out_digest_sz = dynptr_sz - sizeof(struct fsverity_digest);
-
 	/* copy digest */
-	memcpy(arg->digest, vi->file_digest,
-	       min(hash_alg->digest_size, out_digest_sz));
+	memcpy(arg->digest, vi->file_digest, hash_alg->digest_size);
 
 	/* fill the extra buffer with zeros */
 	if (out_digest_sz > hash_alg->digest_size)
-- 
2.55.0

