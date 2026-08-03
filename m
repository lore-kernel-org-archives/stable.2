Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06568274FE3;
	Mon,  3 Aug 2026 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780805; cv=none; b=E+IAIDIi9/WkA4hGA/HlY3yf1XYezu4seLhlsz1MDlbCF3OnLk+XL7jVkqQuslyLM1SBYeeCq8spapw8X7Sl39KDo6Ji3fm7YU6WEufm0NLpAikQyflbM0YlZfUxnGuAAwtnRlcYdtRk4hOT7EEJsoT/PBQCVZTmvNyouoqOMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780805; c=relaxed/simple;
	bh=emOFO5yhjIPILOIw+8Pp/Qygulhq1cgrtEm+aQVtp2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZ3LwjTlM943OIYMAGpEXw2zmiAeH/Z4x9ja/vsd8dFcs6T9/AFxZD9ZMwtQ10F2EQC0zpZ8VaFQBOM8imLEzMDHwQiT+MiAGt36pCwrfL0r3wBHD5292z4Saof6fKbVHniqIei4iPNUH3cHda00NWQZ6hAqy9iC2SSzy6zNI+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPqhTiw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPqhTiw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF211F000E9;
	Mon,  3 Aug 2026 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780803;
	bh=ohtK2yZrCE5aBE6391B08eFYw3B+wSLPoCDFNfCe7hM=;
	h=From:To:Cc:Subject:Date;
	b=IPqhTiw+46SE3GQ2W6G4RkXoHcVwyaq6crpfP/oFBos9aRqLY1tiZLJFAITBWNQVN
	 AUQTPxNUo2Y4pmCz9IvIJ79SmIluq5Xyie7EAIQXSDWQbMVpVXVOGBRtya8DTVJmNk
	 ECYHvY1NVPi8Kv1Ng9cq7lqS5231PWR6l8ZBkMNry4FzXjd7llbAuF/+9azk3QUxFy
	 NYjxB5cRk3ycn0iAaf/hT2v/2yx3a6if4G8yBOOgLX9V5Jm1Jo2lzExJMADb5mainQ
	 orC9mGdUbvpYUTiH0wDdMpopKbCjmetlzt+LVvpD+XgrOKdsLyMgHTHPlLe+Sce0FC
	 9nVqGsGNPK+xg==
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
Subject: [PATCH bpf v2 0/2] Fixes for bpf_get_fsverity_digest()
Date: Mon,  3 Aug 2026 11:12:30 -0700
Message-ID: <20260803181232.14743-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for bpf_get_fsverity_digest().

Changed in v2:
    - Added patch to fix silent truncation.
    - Updated commit message to clarify that the size > INT_MAX case
      seems to be unreachable currently.
    - Added Acked-bys

Eric Biggers (2):
  fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
  fsverity: Fix silent truncation in bpf_get_fsverity_digest()

 fs/verity/measure.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)


base-commit: e5fd3f514e27db1f05fbd72ba615d74941e23c51
-- 
2.55.0

