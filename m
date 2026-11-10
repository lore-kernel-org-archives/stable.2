Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273838;
	b=tFONoqczjVJo4R+gn6oWGAse3qbaN9R5qbi1lmyX90LWDia++thNjjkTHgcu7FtTUsNy
	 n1Sez0WPnNi0B74OWnbr7mb7HWE0UvTQCxnTUPv0lFdp494s9SYvPiReU3JgN26b3p4Wu
	 CKELjioxZufhXvE6hHxwy4h7GSlB0GJI+sUlNzCyvsZGj4/mGpq4YI9Gv815+MzFkCql1
	 c6J/25HGcdSJXs2C0uC/DMkySbK6+3+zfllCoqeQVepsIivN+GZ1fN7yDOP1Ud+bWnXO1
	 OE9limpEZJs/B9EUKB6Ep0TijirKFEoj+PzHWjLpNHG77giB8VWSTeiWBtGv1pBSjqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273838;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8N/oLaVetzRs3QybRNTEfWYfqO8INHoNc5BYXLHV9uE=;
	b=I7YrTm8Rab97o0/Z18jSh3RMRKviC1Sz46ltZQanBrU3JOb67yU2RlPSCJVQvLdhVbsU
	 DCOfWc8bPLoYxEmWlVXX7GmvD0VkBKW2QjXI1Yq4LtooYFBs/nfpZoKo52K9H27kQcBVr
	 5yh+/mZGnMxHfxTZSOwxLWO3yCC57OztEjt+XWM11vrbp6zBQ5mjHiWTSqk4ATLI4FjJk
	 FoF3ooDzpZuQTDelyDUKn/U/QWlml8ZeO4GD8e25jbDyeKfg4yhyksns/DMEAxJpaMmlA
	 k8ZPxy3xVx4Vy5fX0lWOP9JarGdlgTXTlk3czKcTwWp/rjL4SjkZ7YLj3i79IREBUOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdeB5ntO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A8606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdeB5ntO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBE51F008A5;
	Tue, 10 Nov 2026 01:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273838;
	bh=8N/oLaVetzRs3QybRNTEfWYfqO8INHoNc5BYXLHV9uE=;
	h=From:To:Cc:Subject:Date;
	b=NdeB5ntOag3jLHGT9La+zVSLW3DonN7PQdcq1qmTEZyZGq85JSRydG9gJZMeSFFus
	 YffDyJtWAvVoab4mSGoQtgtacBK/RLoWDCeAYRN3sMFYUnox+QSMUJsVXLpmAvMHCA
	 cSJOYw+xeWls0lTowxuIWd0wBFfSJcPIZlnvZMdwOWEGqQ0E86QdjQOmSR+gRyLeLf
	 5oP10VP2yaOokGiqif9RgTZKb0BJPMtsQmYfqYf8acd0dqlAK711QCfE80fmGXUvVt
	 GRh3ScDhOz+FjFszmO8IH7UfwA6zBRXL5EP+kQjf4XoAbSaV/Xo9HtdiZc31AYxsem
	 OuAdBH3b/E98A==
From: Sasha Levin <sashal@kernel.org>
To: bas@basnieuwenhuizen.nl,
	faith.ekstrand@collabora.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: Check cs flags." failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:23:56 -0500
Message-ID: <20261109202356-failed-5.15-f5ea64f9fcd9@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f5ea64f9fcd921bc4e2307a262e19450b8a58524
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202356-failed-5.15-f5ea64f9fcd9@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




