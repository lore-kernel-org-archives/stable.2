Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E22F8E9E
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572718; cv=none; b=tfvLjK9qdr0EWs4JOYG8bDxz5mYNFCwn3S5zgxrXhFkakOYmzQoCdOdVzq0YfI3w6stlRpDFJKze8Vkqs03UqfN9ix4ecECvMqZqQwrJBjqCwVhUuHEH0oaFB+4/eFo2OplvWzijLB3oXJhtX7qGiIq752NMXcIxpXdN+ng8P1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572718; c=relaxed/simple;
	bh=lRyvDTDhUXtkT8JIenyxRXu9gP4Kieo+NRjcYUCGDjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ufo9N4O45QCEb360FNHVMNFkIXy4TLiY9Sjr0QSNNQNzA0oO8uo5MhTDSPGEEnrYeLwaxKjqm28IIOYDQ+NlsN1z/EjJ10MIjuUSBztyeJBH5LvHoTqBpvVI7JmdOUoc1+/9e5/DKmu7cUFbPGk7TYg6Qhaxfp1kvSOdiKNIJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuLFbuOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuLFbuOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C33D1F000E9;
	Mon, 20 Jul 2026 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784572716;
	bh=HbzDA5od5SrwMbl0Axlq5dOf8Tr1/bEHYzMVaNiZBEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CuLFbuOBZD9uaG+A8VQ0pY9Y+OybPmB9fZbwD36sjXRy5V7Sv0CmHaOmKVvryBWoL
	 +tP1DHlSsROs+7JdEwGwIrd76e7YWsfgtn9QuJ6iNpkpqw1KXr5AnLhuSxdXp00l7H
	 DERl4++MPc4v7ozOkuRjT9m+qrxzfGzlcgcvUp2Gmg5QcNAlXDXniqVueExNUalrRa
	 pE7o9PWNx8gzXTGvzfIl4Hth7+CSUABhLk7GuyQggASrAmk3xrywvzcZ/wSGrYt9Np
	 iOgV/x3DpMalwjXbBTpYG5ceJsqGIdcKBJKDUg39JQhJraURB1WFv4GQahwe33EyOp
	 UmiERKHCEh/eQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ahsan Atta <ahsan.atta@intel.com>,
	Maksim Lukoshkov <maksim.lukoshkov@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] crypto: qat - fix restarting state leak on allocation failure
Date: Mon, 20 Jul 2026 14:38:34 -0400
Message-ID: <20260720183834.3080260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071551-small-whiff-1baa@gregkh>
References: <2026071551-small-whiff-1baa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahsan Atta <ahsan.atta@intel.com>

[ Upstream commit 7d3ed20f7e46b3e991936fedd7a28f3ff4aec8d2 ]

In adf_dev_aer_schedule_reset(), ADF_STATUS_RESTARTING is set before
allocating reset_data. If the allocation fails, the function returns
-ENOMEM without queuing reset work, so nothing ever clears the bit.
This leaves the device permanently stuck in the restarting state,
causing all subsequent reset attempts to be silently skipped.

Fix this by using test_and_set_bit() to atomically claim the
RESTARTING state, preventing duplicate reset scheduling races under
concurrent fatal error reporting. If the subsequent allocation fails,
clear the bit to restore clean state so future reset attempts can
proceed.

Cc: stable@vger.kernel.org
Fixes: d8cba25d2c68 ("crypto: qat - Intel(R) QAT driver framework")
Signed-off-by: Ahsan Atta <ahsan.atta@intel.com>
Co-developed-by: Maksim Lukoshkov <maksim.lukoshkov@intel.com>
Signed-off-by: Maksim Lukoshkov <maksim.lukoshkov@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_aer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_aer.c b/drivers/crypto/intel/qat/qat_common/adf_aer.c
index af495a6f039f6b..b47b566689c342 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_aer.c
@@ -113,13 +113,14 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
 	struct adf_reset_dev_data *reset_data;
 
 	if (!adf_dev_started(accel_dev) ||
-	    test_bit(ADF_STATUS_RESTARTING, &accel_dev->status))
+	    test_and_set_bit(ADF_STATUS_RESTARTING, &accel_dev->status))
 		return 0;
 
-	set_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 	reset_data = kzalloc(sizeof(*reset_data), GFP_KERNEL);
-	if (!reset_data)
+	if (!reset_data) {
+		clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 		return -ENOMEM;
+	}
 	reset_data->accel_dev = accel_dev;
 	init_completion(&reset_data->compl);
 	reset_data->mode = mode;
-- 
2.53.0

