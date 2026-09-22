Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF5B479891
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099765; cv=none; b=q6pkPcSpfBNCooiab9Xl8AS3e5IQY6ScgG18gWzRMjcjjmP9MKMHSTKse1+p5XpX7F4rYirSEvZ2NOjnRAPrxo6YAPZeQ5OCh2ZKOCE7tIRx8XmRWuKZLHrUTFVeSmvNvVCruumgLS26sGvK2dzZWWC2QO74PhTxj93vNTvQNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099765; c=relaxed/simple;
	bh=4W6HBLw9Lr1+57Qt3KINghZPFs5raMOBbGpkU2beGN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V06WxPlEn99uhbANV/AAgqsDF/sqn9+CqwalMJRpUiHa+YdqGadPn0sIHrEYLf99l1GlRl0sx5qbIhtSmwyveShHva8WA7Va5L7LmTyL+8y9+T0OL3jMO+Mh/Tql4do+Fy7ptInSTUtEkvTdRNFjCox04On5axQyqTGrviTd9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp57nwhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp57nwhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DBE1F00893;
	Tue, 22 Sep 2026 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099764;
	bh=wm9+2F3AdgjPo8cDJZUs7v2xJnQGOS27qO6Se2Tri5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dp57nwhQJNThx08zjr/9kUfgmuHMizUXS/YPWWe11DgToG6Sh6klsO70wO2x9h8cY
	 Mfh42y7EuhjMoBsOdS9yRI3kzkUctlXkU+TyuxCDF6FzU6hKvLHNXM7/wwQNtfYOSg
	 hwoFrViadeSwmVvqvec6VuzWhqXVzXUTtuZTZECw7qajzK5KjVUmHq98cF7P6z9fiU
	 onNrURKio/jDFXIU9DTSjYUSUe6/p7e2nA+d5R1uY/gI1CYMyGYNzXzF62ipWAA49Y
	 URvsAptcbaXBsCdW4Q6rQ/AkewRzjRxCntG13r+C6th2zDkemxKwRI0dq4YQAY0evU
	 mI5gm8DHOxjBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] i2c: qcom-cci: Stop complaining about DT set clock rate
Date: Tue, 22 Sep 2026 13:55:59 -0400
Message-ID: <20260922175601.3321063-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922175601.3321063-1-sashal@kernel.org>
References: <2026092212-macarena-tidings-7d83@gregkh>
 <20260922175601.3321063-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit 8284750a182937bf805f703311501730f02eb40e ]

It is common practice in the downstream and upstream CCI dt to set CCI
clock rates to 19.2 MHz. It appears to be fairly common for initial code to
set the CCI clock rate to 37.5 MHz.

Applying the widely used CCI clock rates from downstream ought not to cause
warning messages in the upstream kernel where our general policy is to
usually copy downstream hardware clock rates across the range of Qualcomm
drivers.

Drop the warning it is pervasive across CAMSS users but doesn't add any
information or warrant any changes to the DT to align the DT clock rate to
the bootloader clock rate.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Link: https://lore.kernel.org/linux-arm-msm/20240824115900.40702-1-bryan.odonoghue@linaro.org
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: 7362a1553eb0 ("i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 7e3e1514416d8..bfd722b5be353 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -602,14 +602,6 @@ static int cci_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (cci_clk_rate != cci->data->cci_clk_rate) {
-		/* cci clock set by the bootloader or via assigned clock rate
-		 * in DT.
-		 */
-		dev_warn(dev, "Found %lu cci clk rate while %lu was expected\n",
-			 cci_clk_rate, cci->data->cci_clk_rate);
-	}
-
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

