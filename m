Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757205;
	b=JBQdAjm61EByutbWR/zx23FlmaKVr7OBTcd8N1y9ShpVM/3K09xTkIbo5wQweYprievc
	 AkBcYT1nKUXM9aYBUaAXynmHZC5UOblcUD/Xfd5Ol3rez3AFKwslVmXATs6PSJDo+jgv/
	 oErojI/FEilFTK//HoiTwFd6ucEuqSZX8yGz0nHfFLr+Rgv1IMcUAE14q+EW1Thq2VEgm
	 KZ/i9vmReFy0YApFiVw7hJ2gMsy1cI2ANWUBS/vagWxSfGiQtFK2RRDZ71H3389wd161D
	 q0jiKdHC9ZUadRxahyQP+VBoeHy7/3p8RpiCNaRIt+M0AeNEgnne3ipoItxddHc1Qeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757205;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+RATv/wUxpgDuVmhg1PgKehxx379Rnb0AzMOcKWqV7Q=;
	b=1huwTOS60uSj6KHd2UjQUh+VpmQdDf5tbOTmY2aFGB4qVp2WGtOmemITVtuMjGWcfN/I
	 W7Av1tD+lFzlWDUI5BSScJ2SdYSZ5iWu534KG4SbUbPa/4q2EqXZa1HQSoqlJanQTzhLo
	 dqp4AJxr1SYXV0QDDAzg+q4+f789hq9bI9pSOK5aoi/i/MhLHYJ+u00XqxZsJBF5xqm+V
	 gCWYBN2xsaH7Gj71lUmDws2jYr2yJTReeUQwdRpgnf3RuuBCnVhjWLuad4ToHXhc0DtNI
	 K1Xpfmzv8hSaYbOvvxEppsOG4yxYJARmkQh8aBI6MWJ2a6C8FPl1cDolqIjXjjwmnIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owUPkSs7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187E606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owUPkSs7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64471F000C4;
	Sun, 15 Nov 2026 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794757205;
	bh=+RATv/wUxpgDuVmhg1PgKehxx379Rnb0AzMOcKWqV7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=owUPkSs7h3Ir+uBlm5IUf5BHVPenvwQ2ufk3Brzqy0pOISG5NhEr8VR8+RsJ/Grvk
	 eEE2de9CwYOY9ebXvDRrKAlXqrNsLkqkKF9pfuD1KnlSv0ktXtdG1zVUP3Eh07HOnO
	 5PjEHFA0dWcSxdl+2fLtlqtKMtCiom0P2wxPLQASnzrq6u3i67GHPJkuMEKJr4B7Fn
	 FVgHzZDIYGswIoYX1l3dFtXL44YbmePeXq8pyk9T1G1LFaf4UXaUZSg4tUFtUQiKsJ
	 ChV8bbo2DipXuLgMhxejFziRJOKXFDiMYlOWipe2Aa89UUAMSkKo4QRBpwbfuPOHsb
	 UATNB2aoV7HZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at
Date: Sun, 15 Nov 2026 10:40:03 -0500
Message-ID: <20261115153829.1275433-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202851-failed-5.10-63a596375176@kernel.org>
References: <20261109202851-failed-5.10-63a596375176@kernel.org>
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

[ Upstream commit 63a59637517682a920f86da1a189a3e639dd4fb3 ]

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
[ sashal: adapted the pointer adjustment to use the existing offset variable in amdgpu_cs_vm_handling() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 38491f05c9d39..6766ef8224706 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -770,7 +770,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			}
 
 			offset = m->start * AMDGPU_GPU_PAGE_SIZE;
-			kptr += va_start - offset;
+			kptr += va_start - offset + m->offset;
 
 			if (ring->funcs->parse_cs) {
 				memcpy(ib->ptr, kptr, chunk_ib->ib_bytes);
-- 
2.53.0

