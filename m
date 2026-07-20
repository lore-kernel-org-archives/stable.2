Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92137E5FD
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573691; cv=none; b=Tby3ISRAOzbhQ1IWlvNvNh4zrezsiT31IXyFvlFh+uYOmUzbvyrvotsGS2Vz9sQPXyFbcP4ooRCbjQy9ls3NTkX7VdmkKsE38KR8LKf1G4IBkboM929dHywod0ORODTOk6Q18PGyJVE/dQBXS9Z17gu/3UhiRzFoRMvHmyRpp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573691; c=relaxed/simple;
	bh=Qhkq7zQwKuBvHebwrHwqr3ZryJ0HqW/kAScpNyTy9gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDMRQ+yHqiOeO4S9b7QFmSXuKnHVkWVRwzieSSS2kxYOT9fajlof+6XftpCQYeskDhu9BWpXgwEWCvaCWT9txSBZ35AKYrWrickGJimKYfcQvODZLRgZEEPOzo0zBm86aoUSp3RZ/Nj5tJLqz4PFQp7rnv1sC0yToXBcD3giC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQs8cLhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQs8cLhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BE91F000E9;
	Mon, 20 Jul 2026 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784573689;
	bh=yFn1P0/08wkgzkqCgpxkwMxy3NDNWk+QskwexkluR14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQs8cLhSulwEbT6ZgwwoGYwQ2hpwRcf4RQZ7YRz9xG0GvC7NcA8RrV6FvlZ24H8Vs
	 uywCnGDTZ1RC4t0bQAfWY/xkWIUp3rgouoJh2BYuHXBHSAen0uHyC8opL0DVkb+GOo
	 VCvQrxB0aESWzE8seymHRE7DHUF9D2Mzt2yjC/kwt1R32t58lmftigZsDB4vdcxy4s
	 mdXTh2skRG7PdLzC0dEpEXdc9IGrjEq0a5f3qZ7hvYQfpIyXDr66j15m82/vvj0NKb
	 o+M/NXVmgRVFDUBgJamIQpRBbCspRl1fhcYHRdYNXOEWgGCtGI+JTQIz/E2pTs18/5
	 zDvLldsrOG65Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ahsan Atta <ahsan.atta@intel.com>,
	Maksim Lukoshkov <maksim.lukoshkov@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] crypto: qat - fix restarting state leak on allocation failure
Date: Mon, 20 Jul 2026 14:54:46 -0400
Message-ID: <20260720185446.3089237-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071551-marbles-greasily-2b95@gregkh>
References: <2026071551-marbles-greasily-2b95@gregkh>
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
 drivers/crypto/qat/qat_common/adf_aer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index d4bf6cd927a2ad..220ecf53200e78 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -116,13 +116,14 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
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

