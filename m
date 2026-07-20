Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74943711B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570919; cv=none; b=tvbgWqU2h+rwGBfrRxR7bYdlb7pEFx/iBbWMEbjaU9hxg4SOgGExKwit/3vnTVpf6988Rrz72JbWOs5gcGJ4ZosGdycauXM0BaOjI83KL6ElnVLzfxXJQUg094+hSbI0Wj4QoNAwUimwgJOg7RdvyM2QRmV8hmn9WH7cHL2BM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570919; c=relaxed/simple;
	bh=o4qVXXvzY3bgLdY+mpEFsmUbnXe90hr29A2AnMBs/3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgkq1F0+1XWDldETmil+e2JUAqx9QQjP366jEPJ/h13X9gBS5Qmyaxzhv5QLN27SMFJvDWZ0jwdhrza6cAjAv5kpdrjOrhmupIbwhJCsor8Am331syeKKMdfv5x4dgzvCX/vZse0OtXIyR+4D1Ma7oyn9j8pXmuJQ7b3wOhNV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfUxUokQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfUxUokQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB3D1F000E9;
	Mon, 20 Jul 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784570917;
	bh=7FBxScKfqMfpenVe4cFU5sDluLAG4GsoL+7TUoaXvfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NfUxUokQYSizp3tooKySj37uMmm3MsW3/14Xp2nqKk492ATQ2OKz4dKuHpaBupTqG
	 kU6riCNTuwzqq+QpgxNyHWypf/QDn5yChi2PHGBmkXz1tWEaiJJupLjJ0wA3yG//nf
	 w2t0HWMjj48mVh+m3R6QHlRY+FQ4M285EubQipxzMNqe88vSqpqmDTv4p700bAN7vm
	 /n4AMIbMYdoChIyl1vTam9FB+ONibX1B8X5g2i8v5LmDP5hps2DEH9K6QU8rI+DOyf
	 s6UK/Cm8XHno4NXIOk1cqoRGOKppFX5qwp/oOYtqDycRKaGnOzJn9KfLIiXn2PznDp
	 iIQOn3sganSZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ahsan Atta <ahsan.atta@intel.com>,
	Maksim Lukoshkov <maksim.lukoshkov@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] crypto: qat - fix restarting state leak on allocation failure
Date: Mon, 20 Jul 2026 14:08:35 -0400
Message-ID: <20260720180835.2922413-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071550-nebula-figment-3256@gregkh>
References: <2026071550-nebula-figment-3256@gregkh>
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
index ad35d1887f162d..f26cadc19d6bb1 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_aer.c
@@ -207,13 +207,14 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
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

