Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B57445AEA
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571834; cv=none; b=g9K6PRqF7y7CGuFPiPPb0wYBfhD3mQBtGPD2/umpA6cw/Vp+R4z1/aHx9aPMOekJRY/YhmjUEnuEx/DRqa4wqu8FUt2KYlln3KLfsxe2hXBKZhmJy2WXP4q74BnxPNzwr1a47LlI751GgwXd/awS7R7DlGAnxDvfJqPQ8XYFW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571834; c=relaxed/simple;
	bh=c3mnmUjjy/arYjjxlMo+eoE5AtYByhyyopLx9gjokNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNypGojLtg1KWuykhDwk7fWViVs8Jbe6aOfHFKR/4mvt99+nguJC+jltZG3BGtCGvBM96BgyK8PMovNNzOe4seVoUvbeVpdfyS60mIQ4Z6QrrzeSGTkso4wNd2i4qFew+XubC5lKEriRyJZHMqt61A2/YbOPGKkeCpy/v/sDd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyI9GtiM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyI9GtiM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DC81F000E9;
	Mon, 20 Jul 2026 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571829;
	bh=BZ1ZkbTAD3fILMM4hGXSOPolBq2OShYqfOJcZ909d3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hyI9GtiMg+Nf1SKSes/f6ULVcOcZp7RJbN4c3Eq0jP0Y5HM9OfdEqLatW5aNZBC5Z
	 xiEhz2zzBNfd4qlPpA3abnrDDWUc7M6uzMTJioibKvv3rCzZSOhySr+vBo7N5i1XKx
	 iXqvLWpUjICIJmmJZg5J18JjGeJQE4TjoAmtiqj9QbnbHG5JuslTQgMbrXml7EquvS
	 dsASzt0C8DrFP2kMQjhgFAj+L2jnXtVX0FWY3UrLdq9jgAF5goPfnw2ffuF2v/3NTO
	 TDYtilN4RqsDNF8qKbk2OpkMJRUCtU8oxj54Chf9tk26eVAvHx9Gh72u/zwmH7NWDA
	 Lo9Dv9P3qr3+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ahsan Atta <ahsan.atta@intel.com>,
	Maksim Lukoshkov <maksim.lukoshkov@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] crypto: qat - fix restarting state leak on allocation failure
Date: Mon, 20 Jul 2026 14:23:46 -0400
Message-ID: <20260720182346.3021518-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071551-disjoin-undying-828d@gregkh>
References: <2026071551-disjoin-undying-828d@gregkh>
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
index d2078cde8d8657..bd81458bcf3274 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_aer.c
@@ -157,13 +157,14 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
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

