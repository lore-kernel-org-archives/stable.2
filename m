Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB9E3BED5C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578737; cv=none; b=opqmJdkxKDwAH9RR9QsoWgKPmxfcJSA/Jkq2dtI+QM7SmnRoBUnCBBHD8gKpOrthjxUFoVsNZt/PusqjAD3UoiZ71zkq6w4puuD7mRFVVCYAIsEgWDfvkEu4M7dzq4B3Wy9cDoLEHzdIZR5NAtrRJY2XOAiRkrNqgEgzP0JUNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578737; c=relaxed/simple;
	bh=kO6o9x3M0ehSiBOG4cezBN3qb3LdMmYkpTcYAySdMmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2dJGqn2vkRumsYiO5urbDL15VbaubIDe1J0ZHGyOH3rkhg/bGmv+BU0Xhzk/cFSG1Qj42JC0AG6Qyd01WuOckqfbVxSpVoK6UKoys/PyrmYMHppD0at5OluwOnPnxsKSJPsxCYH13LjUHqEeO3f5SkzopsrkaVkT/IAHENn6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiomuoNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiomuoNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9091F000E9;
	Mon, 20 Jul 2026 20:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784578736;
	bh=gs0Md4/okfuZ1KSDkT9CHvNqnMwTIXgPzunQlbq8jJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OiomuoNLQcbZmjqlAnk+L/vmZzPqtbEgZAhD14OacQKqx40IKc3G4DNnms8R0+DnB
	 o2Hz5uPDym2PPlG2XvCnDrtkXI1nwfzysv2aZsyQQxM0GBt06lNTvt+hhNBraFAVDv
	 zjdYq4POg19al+pIg5g4ubRZsmiM+8XAkn2QdPNiZ9fx37xQ0u1Nnj1cASNt+4BNcc
	 VBoDLYsjyhWiGICZDxJehRXabbvirLLTbTyR4mm4aa+YHofBk6Y8YYC+tM5DpxRkcf
	 IRU/7jB1yxLZVdfXIvyo7fGrJWmbZqJB8KQYrc3FhR7ciBHL0RJ5j0r/gkozdpSDK0
	 MTRE7eFvr87kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ahsan Atta <ahsan.atta@intel.com>,
	Maksim Lukoshkov <maksim.lukoshkov@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] crypto: qat - fix restarting state leak on allocation failure
Date: Mon, 20 Jul 2026 16:18:53 -0400
Message-ID: <20260720201853.3239508-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071552-tributary-pound-4afa@gregkh>
References: <2026071552-tributary-pound-4afa@gregkh>
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
index 56c45c3408fc58..9ae9e5c88d34b5 100644
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

