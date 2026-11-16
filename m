Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794791671;
	b=cSi1dCv/c7ha/ZmYNV3WZPKXnC9L4dgPEkKk62BzJFLUcTSnUqHh9gsfYfNJlhbBoF6i
	 GgEpdl6rNaOuLEZFWJp3C/gOSIfOvFQM5UUUMycJ5dp2fBhFidaj3MwvPpUzAKlWZtu3k
	 JynIQTByrOdLEaoG3MmCn7Qt9HQNJn1Y7TrEvyEgBf+Zes16/5e9sxu1Gr7rFbykfrve5
	 zB9KksY1NEmur+pE/+Rk+qJelWYialh0qoo5yFDsOlTUCvwvF36u9IGLaAMCMOycexv+H
	 Gq+hD3GZI8e6ACrWwvFbVZ3FCLxXQuklpE+Ds1W0iqX213CZNfh7sgYgUhacI2Dtg2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794791671;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hsZRjYnu7O61ukE7pScEBw2PYJ0R3BhZO6n9jv6euYE=;
	b=c5Fft7GqKPilmKFYfBrfim6tnDsm4jGjD8y0rlUliVz/W/MVPRvtfU7eQKH02x7uYWy5
	 RzLWdvRJ99siooAbQ43PpRsN8S5XvHoFqbT4jwpcqrzp4QAEBZ2ul5zdcKehDDJ18JBcB
	 mGQ6Ca/u8eUl3aqSO3C4ShdXQODc5+LX7RfLFZRiJ9RHZnYAKrEhBFQnmMmPuiG4mTUd4
	 cVf+n0HaMpGx5EsQif3kFMPf3ceVDV8FOs+0sexP1bGfRNvrpICGN0fcwjPE/2gkHTmZi
	 CsPmJHvkJfqdodfg6k+1LBxx9QBJoc5O8uuSQ59LvQYLFkQeK0LQ+o9vTP1cfqs33dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8tt3pBI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8C606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8tt3pBI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27D21F000C5;
	Mon, 16 Nov 2026 01:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794791670;
	bh=hsZRjYnu7O61ukE7pScEBw2PYJ0R3BhZO6n9jv6euYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A8tt3pBILR15z7PJpAxr1ptTW1hcdhj6KD3l+k1VQsSkKpwNM+uEJJKz7fvCovL1A
	 nZ4s6P+vUOcUjpfOs6jaTiLPxVheUton1WifgmdpapGa5pUZFIjHhOsU9pPVOXUmkW
	 5oRsiPbIGIdgZw4klLA1ThuLuylGvfecAqga+AQ8fineLNIBQv6nAhldniG6i9JIPM
	 TIssBDfxhem14zk5gFXKEu5pqXz2w6am8S5vgNMe4WRZicWScxg4lI8pYKpeJiCF7f
	 cX1bz/hF1YaGYjdxjtjsLfDYdtsYW1A9BndSSyVXNh9KKM5+czO3OTnEyvC/P6adRh
	 FudNRBnpMOJ0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu: Check cs flags.
Date: Sun, 15 Nov 2026 20:14:28 -0500
Message-ID: <20261116011020.2049515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202829-failed-5.10-f5ea64f9fcd9@kernel.org>
References: <20261109202829-failed-5.10-f5ea64f9fcd9@kernel.org>
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
[ sashal: Moved flags validation from amdgpu_cs_pass1() to amdgpu_cs_parser_init() to match the existing parser structure. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 601934f93098c..0d49c407cb0d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -114,6 +114,9 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	if (cs->in.num_chunks == 0)
 		return -EINVAL;
 
+	if (cs->in.flags)
+		return -EINVAL;
+
 	chunk_array = kmalloc_array(cs->in.num_chunks, sizeof(uint64_t), GFP_KERNEL);
 	if (!chunk_array)
 		return -ENOMEM;
-- 
2.53.0

