Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755884;
	b=RNrEKI0m2OI9eiN+sL/boVGmx85emhI1ehoDXXy+fNB3z+60ilRrYBf+hmiWzpn+JWUu
	 MuqFbCzHAkUvZ5aKOlatEIQ5l7murRn6GPYkfIiKi+sqU095nnK5zVl1YUTgWgmZIzdS0
	 Mlw0mZjYTPUX85WRAjbl30BfgwahPTYIJzfnZac42jP3gfQFfBv44N4Um4ajemIo1Q+lz
	 JO0EG+E5cjOHxM5o3Q1FlDZwyja51M0ByiUpuP05jkkEM/cm8iaAzJl7j4rCXET7LDyrI
	 IE8W1fT2QEgnG5T8ZI3qeu0EdYPwnRtLew48DjuUXTDuROiGCVuTqhxFQKiVMgCGc4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iKEon/arrVwHCjKwAF6mOB2ak3GuRcD2VjRg0cfVgHc=;
	b=ZrEGKEC0KA+fgyEyyrC5hfHbvzxl73RjiIkx6c2tR2u0i602X1tLSM8P0cljCevaCKmZ
	 6/UpDqpvpmzHnDltOCan5vWJameaF+2MTYavuq16pnp4UGI3mzcNufqwT8HG95+T9ugOp
	 z1fdJ9UuvOYZCk3cWI5IvyaEmNa1MvuOXkxgRZIo0eqWBtBaEhmJ5+J94UpxlVuK8mJFf
	 Ntk6ktMJ0OBpob9jQrwEUlDKo8JuxPg6NHELJPYyEIMLf4RXhTX0FlBNkRL5x7cxNOO84
	 9LnknDASmex0+LqMjrnEmOljjTNESPLvNdVz7ZDCVsf33820L0Xr6VawwsAlHZY939A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9TjXJtM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48141606A31F
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9TjXJtM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B561F000C4;
	Sun, 15 Nov 2026 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794755884;
	bh=iKEon/arrVwHCjKwAF6mOB2ak3GuRcD2VjRg0cfVgHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M9TjXJtMILnP4dFbzZzQ7GCB7ek4V9LR82frsbi0Swsj3DIn+31isC43DnNhDPsLk
	 F7CHl6nqUn3l6eZlTpCQAjV4dGizCIfH83zDNAsJtmCHDcPezukoqpsAtdjG+H76ku
	 U1ijWhLeDdA4wxMN04qWV3N17uiGXth7JUH0fJDqemnaF3nvlNjhSke5whLIYL/usC
	 BgfaXMNh6ktuhyAcMlRmJBr32X9XLaIfns3n2mkkqxAsRTad1chL7slE3vFzrnl8nt
	 QLb6hc/nFZIwU3ZMEzzZrOXqsN+vDXr8coUo4MrZ2IA7lNjOLadcU9JDXjQxaHRO5/
	 LTiG7D4OABM4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: Check cs flags.
Date: Sun, 15 Nov 2026 10:18:01 -0500
Message-ID: <20261115151556.1405402-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200938-failed-6.12-f5ea64f9fcd9@kernel.org>
References: <20261109200938-failed-6.12-f5ea64f9fcd9@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

[ Upstream commit f5ea64f9fcd921bc4e2307a262e19450b8a58524 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index c49aabb343a72..3c194cd99eb05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -209,6 +209,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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

