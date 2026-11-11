Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373348;
	b=qIh9Fz/eBldipI304agH/5Bb+Vn2zJTHjCcyzTS4DtpAVY4CTD/k8T+cceSuGqBwKbN9
	 cOZuQcPfKf98Mj5Vf4hTEfG0Wo0onVLHg/SMltb+dm4l1swrRaYGu12+GwGWIOueD+Z29
	 aZiR4V9FTsnQNKR7oVwOJEFfEfd48CrsqK20S8MIQgja0/LvDSHWfsAyqlIYCtAuSZM94
	 E2QSRK69ExJLZgaCszk4fhleoJJCt3QYLsC66GPLc0v0QoXBL3q7R1MJGgffj0uxThX+U
	 diLNeZkHiUPkqv1lf9fiXOwI02SU9ft18dqzplovEpQ6G39/KJ5FsM1bs57ytTdCa4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373348;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=V1HaP1AhQlqvm2LLr5j570CPX+ScSZSFp6dR4Ky3DPM=;
	b=skAeEUMT6M0Et+uF7zJsgTDJkGmpfdJm1wr/DCVYbXNqmzx3FSPahCSkMpQLhwH+k5Ow
	 v3KoA3MOZYQgS/Xc1zPOG2HjweXs3PP2tJ3ZrEdvcCFJsEY/xWSpGF8hbRRaUrRQdiI7a
	 UG5cOGGRLdYL6jxVuN8oaot52TR9ALFzhpjdHA/Tg4dJYfb5Y6h/KxQL03UpwmP3M8qST
	 kQ/9MMp5YW6K1adjTkp7gtFzzkfS23vv2QO6RpPQvFcE0U/WFQLfm8dYF3OcS0tqaNn3i
	 /4vM8ayLG6yrMm3Z6cifGaJDTKLi5QZlfdBxPZsKfoXGyleQfjm/Wmtu7tNqM6jvmYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I0vd0/uf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E4606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I0vd0/uf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A54D1F0089F;
	Wed, 11 Nov 2026 05:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373347;
	bh=V1HaP1AhQlqvm2LLr5j570CPX+ScSZSFp6dR4Ky3DPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0vd0/ufP5ykyjZ+C1+yj9LQF7vURIi4bKy5hwDt9NG7SD5NU5wAaqDYrGHIeD4b0
	 LuyqVDqmBvUrMmgANdrU2mHLipxmOPfq9f0PK/qGZbizi4gPy08yQhMhkj/srHUBV3
	 nDzZkAZYouRZmUxaaQHGLFRz/FsXatUrJC/vjjPFs/wU6+IJJf1E+l3T8zoa8QJOo+
	 jOL7DzlO8iV13yCJf2E4trMhwYCk5kV+4azo8x4U5P5aMsAt2QgedhR4Mpjs9DvxIk
	 ywnP9bCKLOKyrPe6N4AXNO+QJhqqHuzh2/2n6Jo7HbWb0df9iuBGKoNcRuNYhn08Zx
	 cbaqdGral33iQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ceph: fix 32-bit overflow in readdir reply count check
Date: Wed, 11 Nov 2026 00:02:25 -0500
Message-ID: <20261111050205.1216786-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061210-failed-5.15-52913831ba56@kernel.org>
References: <20261107061210-failed-5.15-52913831ba56@kernel.org>
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

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

[ Upstream commit 52913831ba56efceaafd80b501d68fa00f79bde6 ]

parse_reply_info_readdir() checks how many entries are in a readdir
reply by computing the end pointer of the decoded array. That pointer
addition can wrap on 32-bit kernels and let an oversized count pass the
check. For example, a count of 0x40000000 with 156-byte entries wraps
to a zero offset, so the decoder can write past the preallocated buffer.

Check the count against the number of entries that fit in the allocation
before publishing dir_nr. Reject oversized replies through the existing
error path.

Cc: stable@vger.kernel.org
Fixes: 54008399dc0c ("ceph: preallocate buffer for readdir reply")
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ sashal: adjusted error-path context to match pr_err() without WARN_ON(1) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d1bac25eb3e72..e5040a67a14f7 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -363,10 +363,8 @@ static int parse_reply_info_readdir(void **p, void *end,
 		goto done;
 
 	BUG_ON(!info->dir_entries);
-	if ((unsigned long)(info->dir_entries + num) >
-	    (unsigned long)info->dir_entries + info->dir_buf_size) {
+	if (num > info->dir_buf_size / sizeof(*info->dir_entries)) {
 		pr_err("dir contents are larger than expected\n");
-		WARN_ON(1);
 		goto bad;
 	}
 
-- 
2.53.0

