Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701527;
	b=l+GLjbhZXwWBg5yxbts4AO2Nx0T6kmb5OUTriOAYvYaag8Vev0grfOECxDaBs+Z8X46f
	 qcvvggT58zdqaLf3OIVgn5I8H1//LIbSTV6mDKbLSpoGiH9uMUWfkraktEVjJHPAVH8yU
	 SJhgG0c9JY0RE2fQ+5uqF0xymY7PkuxlG2ZiqO/m7bi7IO20YA6ZNzeiFifRMBvUrJKyi
	 6z1id7R1Z37wMHOikNngCFLUcfXL075XxVzlaFjj/0rkYwzfsi4wrjShKFVdFu2D9kcAw
	 CPVaVRRF3hT9l0ZT8Avs3rk+BV9fRERgn00hTnV5XPxaNVyrLKlgaJVB9Kl+WPmfYRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701527;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qkKYlnGzsJH2HfAEfzXTAan6Bv8aAIqtd/at173AXcM=;
	b=XtzRQmEXXKPRjwo1uX7s7R/BjxMpszXJgY9RegeeNkF+HdACr2O80T8ce8a5TGmARLNS
	 26liSX7ssLxSZrcTxEWQwMK5JrexUqivuTs6T/5B1ilwabTacs0kQaxOyD1qqXIkK5cSL
	 lnedEAtRfXrRP9G+FsFaIEQBN2+0oBi1PYUyIHae9Fc84pTOIPgo09uMeV4YRkWIl27ea
	 yd+G1aFqXBuwOQpBJr0oQ/zzW1RmfbMpPncAk3j2NYqcdMM6AZ5uvzBljjd6uIZfDgbNs
	 EYclXfpq3YeyMypaYjDyJTSaXQgenlbi29GU97k3p0ix+BTeSdOFTyvhazHJTnJN68g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpuhU1Mj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168E606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpuhU1Mj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4AF1F000C4;
	Sun, 15 Nov 2026 00:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794701527;
	bh=qkKYlnGzsJH2HfAEfzXTAan6Bv8aAIqtd/at173AXcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZpuhU1Mj6vtq2jFgYnKBf2qvUgpKEAUeL/lvtAYCupBFNKvQzF3QJa67j1v2W5NJ/
	 Q9z1fu8W1r6buACXwr+2n5rftJgmJLUF81qOvbFHO0Gj8SOLnqMM9dUI2i0dC7tef0
	 b16keuLqqlU8bJpc9rb8vEbVjzhjUJ6lSv6WyajRmHgaaByA2BAiEMzB4MBzHNqwzv
	 BdhUFoIOQFaua1iREwQysisYy+XCXKPFtDfXYFz7ax9cV2lZ40vn954FQpLou4Z121
	 oS0foxPNaEYcF1JuzDQzcD0A0cIVcd7k+CDOR5u3C52yzgWh1aS1qOOGZ8QznjZieP
	 z7jdtSo2SzWig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at
Date: Sat, 14 Nov 2026 19:12:05 -0500
Message-ID: <20261115001136.360985-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202419-failed-5.15-63a596375176@kernel.org>
References: <20261109202419-failed-5.15-63a596375176@kernel.org>
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
[ sashal: Adapted amdgpu_cs_patch_ibs() changes to amdgpu_cs_vm_handling() using the existing offset variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b461e31b91c25..c92a6d6b72671 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -772,7 +772,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			}
 
 			offset = m->start * AMDGPU_GPU_PAGE_SIZE;
-			kptr += va_start - offset;
+			kptr += va_start - offset + m->offset;
 
 			if (ring->funcs->parse_cs) {
 				memcpy(ib->ptr, kptr, chunk_ib->ib_bytes);
-- 
2.53.0

