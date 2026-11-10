Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273538;
	b=H6mqOBsjLLisQLgIdvvFSGuO5EYv5FhmrirSs/cm1WaFoa3KF9L2fomQ2TkOv2Mwy0LC
	 SEOx1Ebar0Hf9tQvm8WjM8+HYzQe55PtZZMvfgMXtVhA2EbU93AwOdM9D5h2YSQv2QIhm
	 HD6kPs649yO9JUhcapy/uHCBomuo+3R5H7+k2Fe1G7Jj9lBtpCttMim6VrFpOz2Xd9IUk
	 p9ddGqj56sHg/nGiNxJiF0lKdFa0ry15/P8o0H04kessmm5bGuA5RdsdM3PE0ThG44grZ
	 DhhggmoTlLt4ypn47dTU2BHDQcI/Xn3yxHwgnVWCSvRapEFM90QOrvtShcmkygBrfZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273538;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PT/dPjH/AU3A5fEhUAfhzdBWx2EOcbeqz3wt0qeELqo=;
	b=YLt/HN8/MjwrSqKijBS0wcoX0lLZG5060woBhnxs0hVjWETUa+6osCB8q3Npha6DpPts
	 vgtyuIGUPlJad1Ht8S1VGOpTlRwIEsyi6PBzPyovv3LQqaDqsCFHJEzotbqOTyboyp5Sy
	 9eQK4kY2PSQpvJlIRlsaMmUIWhv5tDp5CG0WugqayVBCv00j18c+79s7DeG2p/u9mnp/O
	 QTrEKdwb6KwjxsBLMjGKL1jXF6FZKm9VxmQldYCnozKgHQKqcS/WLEKnrSn0WnWhUR6Jz
	 G/8AJTIYw9wD8J/wJvwW/mleCayQvFZLXGZ8zkzflAzfwEpAu1+ymeF4kIm2yXybcyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfPi12ai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A6606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfPi12ai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0F41F0089F;
	Tue, 10 Nov 2026 01:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273538;
	bh=PT/dPjH/AU3A5fEhUAfhzdBWx2EOcbeqz3wt0qeELqo=;
	h=From:To:Cc:Subject:Date;
	b=IfPi12aiff0/4duQgXo0ow8oYbN+LY/wJ7u4kkcsfIEmEHAHw3AWb9p72UMk3k7Jg
	 KHfntHGDmDcRYHimKAe0pEjXrVl3jVRd9/+J3/fC7wF3HQ2RNQm9iU0JvVlZetRGhj
	 a4tFJGqWG3GsjWyWJoHtJ1rkTBLflz7dMev1LIZmTaGIB1YpKpF3MXJA05zt97DHEi
	 S2fSoSoDDQwO4IneRotP+gxVKf+ljamm+qxstL6b7/Z29NjQ1Y689OzvYyMnsqjhjn
	 AhhzL8EnfdL23bCApBcKRsPplNRZcm0LS6FDjNXXYgFFEAjIhK5Dxhlrrf8OncuNKb
	 WP2hto83XXuyA==
From: Sasha Levin <sashal@kernel.org>
To: bas@basnieuwenhuizen.nl,
	faith.ekstrand@collabora.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: Check cs flags." failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:56 -0500
Message-ID: <20261109201856-failed-6.1-f5ea64f9fcd9@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f5ea64f9fcd921bc4e2307a262e19450b8a58524
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201856-failed-6.1-f5ea64f9fcd9@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f5ea64f9fcd921bc4e2307a262e19450b8a58524 Mon Sep 17 00:00:00 2001
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Thu, 22 Oct 2026 01:30:54 +0100
Subject: [PATCH] drm/amdgpu: Check cs flags.

Had no validation before. libdrm_amdgpu memsets this, even
for the raw/raw2 functions.

We have a lot of functions touching the ioctl struct, no
strong opinion on where this is placed, but I thought
early would be good.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4d01e15e76358f60ef6734462d2b6d9972b9dfbc)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d69018a14d96d..a703268ceebaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -189,6 +189,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	int ret;
 	int i;
 
+	if (cs->in.flags)
+		return -EINVAL;
+
 	chunk_array = memdup_array_user(u64_to_user_ptr(cs->in.chunks),
 					cs->in.num_chunks,
 					sizeof(uint64_t));
-- 
2.53.0




