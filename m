Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741480;
	b=ohTkNndnJRQ47ZjJYFra5CUi8qoUKGOxGc7+WZcnS/YVyPKwcJPGtgCGKUorTTrrMkAQ
	 /hhMW8ajzp3qEJZ0La9CkHFaV8mENQgOp6RzFF7bL76gnVok1xJm90BabRv+4P5T6VTha
	 ODyoJUVVrTrgbDRpHsz0QEAYyV5NNTrohtrCUfOShGtP3ayG882mqonfS9OPMasaiLdUf
	 Fyu+4GyjL3OQdl9W7QSZqfH9UP+yHbGn1MvnMPkkrgo3lPlN18QaVpDjegwXk0hL2UfDm
	 hrMxypRFV+k91rk4SD7jg1UdmLMrN0N85PgG9aRPvCbvqXYWqulKnoEvIekCtREgCrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gZ+IfvaF5tbCPxuo34K4rqwnsNUTstyEef0/kpMSmY8=;
	b=WUy5c04t8sD/LckLAirNo9MclEogccepLkm1xA9LIR1waLJUkzegFLgpXA+BT5XSo8G5
	 DcVTkqrasR6nCvtPhXP33pJc8vpsyOUGdGQJgQ7nN1qkN+vS7RrqC4nndp+Egcc4t3LUf
	 gBrIJOlPlcRyYOIv/URHL55QI4ZAnSiQqLAzYtJim7CzZssNbegI5X1poGg4rsRUiSCfY
	 2GG8tab3UWq1p35aYMYhLpksSglG9ZbNJiyATl4aJSfpaeWOGg2NVPw/LqJ2JltjHMMjd
	 01evqdALk+xoO3B22xGq6t9Ms2nnH2o3ZAkJVP9gEc/D9lS28AgCDVZr4OsTW1zwL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhAiVRSu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514D606A326;
	Tue,  3 Nov 2026 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhAiVRSu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6022B1F00A16;
	Tue,  3 Nov 2026 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741480;
	bh=gZ+IfvaF5tbCPxuo34K4rqwnsNUTstyEef0/kpMSmY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WhAiVRSu9jzcd65HdbyoWO7rT1rJCeYt6TUzTSc7DoKfgzZyucaH1BPISvdtDaTGk
	 fCKzVmCq8pAI5ulbBOXkCpUeP4tbTIQjPgIA/oeiXWc7M0n1OlWhOVq1VYHsvgA/9N
	 mGj4T/zo9jmcg60SN66wdthdKNMTpUxNbcWSr3SHcAhY5JZYUgJ/2xai2dIN+xSSAu
	 WaPSHAy+eqifAbI08C7qQQIbc8fAJW7l2rzJVM6awOYLfArul+DIOaHXwcTVbd5FEk
	 xhbBgjnKrERb0oDvMRAP3+fRxvtsRiaWRzLVnoMBd8yM7Fa2G17WUHIZGMd6T4AJM6
	 5MSXSMrbP/TQA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Ajay Kishore <akisho@codeaurora.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] pinctrl: qcom: Check qcom_scm_io_readl() return value in msm_gpio_irq_set_type()
Date: Tue,  3 Nov 2026 21:29:15 +0000
Message-ID: <20261103213002.1673560-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103213002.1673560-1-lee@kernel.org>
References: <20261103213002.1673560-1-lee@kernel.org>
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

In msm_gpio_irq_set_type(), when pctrl->intr_target_use_scm is set, the
return value of qcom_scm_io_readl(addr, &val) is ignored.  If the SCM read
fails, val remains uninitialised and its stack contents are modified and
written back to the hardware register via qcom_scm_io_writel().

Check the return value of qcom_scm_io_readl() before modifying and writing
back val.

Fixes: 13bec8d49bdf ("pinctrl: qcom: use scm_call to route GPIO irq to Apps")
Closes: https://sashiko.dev/#/bug/linux-a5545ffd-48cc-4856-94cc-4b2dd7968f50
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 27f06bbc113c..1b46735fc4bc 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1105,11 +1105,13 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 		u32 addr = pctrl->phys_base[0] + reg;
 		int ret;
 
-		qcom_scm_io_readl(addr, &val);
-		val &= ~(intr_target_mask << g->intr_target_bit);
-		val |= g->intr_target_kpss_val << g->intr_target_bit;
+		ret = qcom_scm_io_readl(addr, &val);
+		if (!ret) {
+			val &= ~(intr_target_mask << g->intr_target_bit);
+			val |= g->intr_target_kpss_val << g->intr_target_bit;
 
-		ret = qcom_scm_io_writel(addr, val);
+			ret = qcom_scm_io_writel(addr, val);
+		}
 		if (ret)
 			dev_err(pctrl->dev,
 				"Failed routing %lu interrupt to Apps proc",
-- 
2.56.0.385.gac671c819a-goog

