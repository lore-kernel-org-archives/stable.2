Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051008;
	b=IdIoBY6HYSq4XDiUH/KRB7WI/uxajW1wHj/OeqCGTB9LaxEB0R0HkF9uIbyoSCwBWRyS
	 XB/s7jmKzYtXbFXjSwumaWYIjbSXJwE8a9pU/9cVoFQ4dmwjJxHHv4+EY8XysJllKwN0+
	 YXXkSaWTwB8PBeo4u9W+sUNxVqnolmHhDzZM8mQEMrTnraKzJS/H2S2ZbXPTxpIXqM7cc
	 f1e3ZwZWvqCrBElPZXFDnerCpyAlzvTWp9NPiPQkyxqd+jAd3qVwjvdksq36NJ4JHNDwv
	 oYCPD2/PN4g8W462Lvq1osTlo/gXh/1S6/iLsjU1BX7ybhJB93nY9GEGxGoW6OKCiDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051008;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=h2OUyj4pLmGXYG5HpgBT1uBadkO/j+IOA4p0PDfTlIY=;
	b=uGlWKiSsAJsPEivFIMegTHQ12cv/SMk1WPAHD0niQEtGTV60t8njngrxodT6xazqQIjq
	 oFWyVzYb3zQgzWy9zYEGjJ9N6s3UG9kYGzs0yR7UXS0GHzQ2+ZXwJeyTmYe9Ag8UjfPwy
	 eZFOsrLUDYRTtdttSBsk5B7+yQaqYx4AZXcnW1Lbcj3YgbNn6V9fjroG6hsjPSBeME4U9
	 ZA/hlzTS3IVGkN3UF3Qu4w89XBLFmqdcu776MzvlZU1XENaANThhfES6g7mbhI2sZeSMV
	 ec4RWNzXrWNyqoUuySrvxXGhX62aZyzE53OwVRK7sZtE++b95QCiTEi2f7MfoI6LG0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DyCqEw5S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E22A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DyCqEw5S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE1E1F0089F;
	Sat,  7 Nov 2026 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051008;
	bh=h2OUyj4pLmGXYG5HpgBT1uBadkO/j+IOA4p0PDfTlIY=;
	h=From:To:Cc:Subject:Date;
	b=DyCqEw5SlEUS3gfMfDkuGfrGt7YtgEJRU5jcLwoxYpErkn0ez5s68eqtoN3yQkVxH
	 6VOfJ62fgBxBimg2/MD9suRMraDQf7nluR7QMjXn2i5ED+4ewgt2AVjhssc5rwlhsj
	 sV2Gy5INF+8x7cvkouSPyromvwYBZ9/ECsaA/oD6GNQjeio61vL4Z6SBWn5vz6kS8w
	 +hX7iiotKQVQbEuIg+YRpzWiIMJ85GJoBC/Y9bGC4ERcsDyegA9YA78bwlAfvEBOFQ
	 WHgD/HaF2fy888FNgBvXpGjM98y242dJ6dOBiPCaPU2wGS7irJzQPmnNSqTRSUpKBv
	 4mI1uEhXfIbEQ==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: reject CS chunks too large for kvmalloc()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:30:06 -0500
Message-ID: <20261107063006-failed-5.10-ba4c3c202919@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ba4c3c202919405f461a393e823e4b72c8518494
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107063006-failed-5.10-ba4c3c202919@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ba4c3c202919405f461a393e823e4b72c8518494 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Sun, 18 Oct 2026 19:17:57 +0800
Subject: [PATCH] drm/amdgpu: reject CS chunks too large for kvmalloc()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CS ioctl copies every chunk with vmemdup_array_user() before it
looks at it, for whatever length_dw userspace gives. kvmalloc() warns
about allocations above INT_MAX when called without __GFP_NOWARN, so any
process with the render node can trigger a warning. On navi31, a CS with
a chunk of length_dw 0x20000000 returns -ENOMEM after:

  WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x5a5/0x7d0

Reject such chunks with -EINVAL before trying to copy them.

Fixes: 2098105ec65c ("drm: drop drm_[cm]alloc* helpers")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dab5f5280406088591645f499f048dcfefab8d7d)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 65e13ad445bbb..70bc53923d119 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -218,6 +218,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
 		size = p->chunks[i].length_dw;
 
+		if (size > INT_MAX / sizeof(uint32_t)) {
+			ret = -EINVAL;
+			i--;
+			goto free_partial_kdata;
+		}
+
 		p->chunks[i].kdata = vmemdup_array_user(u64_to_user_ptr(user_chunk.chunk_data),
 							size,
 							sizeof(uint32_t));
-- 
2.53.0




