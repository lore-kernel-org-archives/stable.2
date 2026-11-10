Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273861;
	b=AJYkTTpFzziXmN0+7JKh+zwyelxk+VD/QCG5tfiGqIef6qIBAHEJabisA845L6wKPjt/
	 /pOtc6xetG1ODtp/CWptpnOC8ADLUeZhnrFWEz1WN213LyH7ivMZYJ+lb0clLciDbZY4d
	 erz+abxTA7VQhTu3BBRpzKJbHJiCdKzEqxNFyex1TQWTzrKbW9n0WJID3BxOyecCj/3gb
	 2TWS8gb2Wc/xgpqaELQoH2H/k657JOmTnwt9Dan0m587FrduFc8MNDi/e9hmnMoz3V+mM
	 9Vp6b/becTo1ZF2sP5SckxpFlL9kBbj7ILiCT+4mk81nb9PthaQDfBbLZ5xAF1IN7PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273861;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+R1/41T4ngduSZlNY3q+E/cLJyhYV8ewDLoTsqehXHk=;
	b=esrmUcwzqZydB4ugcmWQiDIyraRNaJCcAtQlqMnmXfXY2u6w5/LLkixvbJOjOgxStcM1
	 KANN32OM6gIpGWUw9K/Z0SLB/w036vsMzXVb0wnJpYCsSbmgAU46zZjEtFEQJXo3vWBQA
	 xdVisinvCq5s9oSZGhO8l2XvQ5DDAa/cT7XUNgUjePXyK4QI3t8NVP9+etgvELzzD6T1I
	 ml75syn9BIUz1mR2BFrj70j158w4WkyGmQ5pDrTnH9EnEKO2YvwiQWe3UjL52Apt3Rc8m
	 9/a2q4PQricc3gXncF2gG06adIfwXKmzQ+CrXd+gOMEtImq8zB2OWVdtv1YVyZrBwlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoyBRudy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970760A2619
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoyBRudy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403BF1F0089F;
	Tue, 10 Nov 2026 01:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273860;
	bh=+R1/41T4ngduSZlNY3q+E/cLJyhYV8ewDLoTsqehXHk=;
	h=From:To:Cc:Subject:Date;
	b=UoyBRudybrO/m1fzdB987yBaUVpNuFVzCKd7l034kK1dk7WsiyYxUV6hAMP/qcd1X
	 52AJFNga7w1R3S8ST87C+gh+WXVFn0kHsHuloQ4fJEsb9uS15swTXbPXj209L7/SLm
	 GV8+5BycSqTrSbsvBRV6EbmITk46xhwGoKnmU4MlG8shN0cPz4JBhkLWqDnmzXLrx9
	 8SOdayvlUjRAQXn5he3hSll+tn8p79W/BWqNhMJCKiYdC6JqoRT3LPmsrSoheKGqzF
	 hUH4yOUU/hnQae6lMpgKCpD9mO8uFcfpzc9iuuAI9rWbAjA+YZv6X62KwsaFIjoQ4D
	 GW/1mWzXa8Qng==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:19 -0500
Message-ID: <20261109202419-failed-5.15-63a596375176@kernel.org>
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
git cherry-pick -x 63a59637517682a920f86da1a189a3e639dd4fb3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202419-failed-5.15-63a596375176@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 63a59637517682a920f86da1a189a3e639dd4fb3 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Tue, 20 Oct 2026 17:53:16 +0800
Subject: [PATCH] drm/amdgpu: parse CS IBs at the BO offset their VA mapping
 starts at

For rings which parse or patch the IBs on the CPU, like JPEG and VCN,
the CS looks the IB up through its VA mapping and maps the BO, but
ignores the offset in the BO the mapping starts at. It then parses
other data than the GPU executes. On navi31, an IB of JPEG NOPs in the
second page of a BO, mapped with offset_in_bo 4096, is parsed from the
zeros in the first page and rejected:

  amdgpu 0000:03:00.0: Invalid packet [0x00000000]!

while the same IB submitted through a mapping of the whole BO works.

Add the mapping offset when locating the IB in the BO.

Fixes: 4802ce117786 ("drm/amdgpu: fix UVD/VCE VM emulation")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 74ba1d87d67d0a38d8248928241c3e1c73d0d53b)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a703268ceebaa..ac32530c1b488 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1075,7 +1075,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 		if (r)
 			return r;
 
-		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
+		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE) + m->offset;
 
 		if (ring->funcs->parse_cs) {
 			memcpy(ib->ptr, kptr, ib->length_dw * 4);
-- 
2.53.0




