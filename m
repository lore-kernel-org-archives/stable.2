Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804598;
	b=AS+s83VkIq5sPErGoA8PhwzGVUf2YwSD0qiSHMwEaLyxPahTTb2eNDwl8CKRB8B+HqT+
	 wDX3lz49IAHPEqDEwIRuERlFmRXHZ3iLf4TlncCn+Q1WdkTPIe4GBjqa2L4rur6Sq9QCG
	 iEH7yNZiuJ5qbc/hJKq0Wxsn24C8SFbQaaW9ZvK8WsVGTl6qRCBgBzyfyVQ0VM/72oABZ
	 ypulcJJWDN6uPrYuD4btcRCA3DdQS1sM4VLwxzLK68+pRNNICcHvfkhFDxI4XkkLM8t59
	 YtpUTrrEYNmEy4J9UKdX0WLv0XBlrb7g5q7jlKB2eWkdG+VaJIXE6/fv+A2uqOvdt5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804598;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wMIKscvgJyz6s31NMv0NlSVP0vJydCQ+WGHxYrw4eIE=;
	b=unpYvu3K2Oo65V6g1aq58FgjWxlioCBIT5ThU1LqgYQxlSrkq7QWEok/byvCyL2obL5Z
	 X9lNQXMjIhbD0as+Tc6Bf8iPRBSouQL/6cT0Ky5MScqR+4ctAI/ctz+u9geWavMCuwy7O
	 7jnKD8JpyP6256LgrZ3Y1O2uKgvmG4vchb60FZbeLscJGv5Wjvhosn9fBQS1cH/nV6jFA
	 ml9myanpgH9gJfyY6SfzTYSJqN5vRzC7/hN6tcBLYqGHLDwsPeT7SQGZ+fctHPRv/lq9v
	 oey4VLjxOAfFruL8Y2feF+BrclcCmcYPgZW91O8kHTtdOvk5+e2bJ7TDw61Gv1xkNSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNtMRNpF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74237606A31E;
	Fri, 27 Nov 2026 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNtMRNpF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8913A1F00898;
	Fri, 27 Nov 2026 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804597;
	bh=wMIKscvgJyz6s31NMv0NlSVP0vJydCQ+WGHxYrw4eIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNtMRNpFvvcZK99vRCDQlXdIBHzeEBU9UV/yIBq92vUQwEcgn1CSCFDN52YRRXjlc
	 HGmY8D+iTJSW3sWjo7zHyZ+CvVRnlQBSNzNWSsd/Dt2VwV4akyUtFAynv98QJ283Xn
	 gSRgkUG/ZlC2aeEVgI8dj6STb3qdNCNxpZstJmGhoXsGk4kLYufnbYDxl79lCrTSru
	 UDbwz6RhLtgC6E/RjS3pi4e+BxNMUc5j1j/cSe+xlctArHLPbeqbGFVHim568ZP+aM
	 q6fxtn+NhMoCeitnracA6HQa4Z/g6r+HH20TPntf6b0rV6v+p4yaS7LKmNDPXyt/kd
	 5RtSXpd5NNvdw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/8] regulator: core: Defer supply cleanup and unregister event forwarding on error
Date: Fri, 27 Nov 2026 18:35:41 +0000
Message-ID: <20261127183624.3341010-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127183624.3341010-1-lee@kernel.org>
References: <20261127183624.3341010-1-lee@kernel.org>
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

When enabling rdev->supply fails in set_machine_constraints(), the error
path calls _regulator_put(rdev->supply) without holding
regulator_list_mutex and clears rdev->supply to NULL.  Neither
regulator_register() nor regulator_resolve_supply() holds
regulator_list_mutex here, and when called from
regulator_resolve_supply() under regulator_lock_dependent(), clearing
rdev->supply prevents regulator_unlock_dependent() from unlocking the
supply chain and skips unregister_regulator_event_forwarding().

In addition, the wash error label in regulator_register() releases
rdev->supply and drops the device reference without calling
unregister_regulator_event_forwarding(), leaving a dangling notifier on
the supply chain after rdev is freed.

Leave supply teardown in set_machine_constraints() to its callers, which
already handle cleanup with proper locking, and unregister event
forwarding before putting rdev->supply on the regulator_register() error
path.

Fixes: 05f224ca6693 ("regulator: core: Clean enabling always-on regulators + their supplies")
Fixes: 433e294c3c5b ("regulator: core: forward undervoltage events downstream by default")
Fixes: 8d38423d9dea ("regulator: core: don't fail regulator_register() with missing required supply")
Closes: https://sashiko.dev/#/bug/linux-f6e93cf6-c907-4a0b-b748-617186aee410
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8bb1ae4e03ea..18ec8b77e620 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1680,11 +1680,8 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 			ret = (is_locked
 			       ? _regulator_enable(rdev->supply, NULL)
 			       : regulator_enable(rdev->supply));
-			if (ret < 0) {
-				_regulator_put(rdev->supply);
-				rdev->supply = NULL;
+			if (ret < 0)
 				return ret;
-			}
 			supply_enabled = true;
 		}
 
@@ -6392,7 +6389,10 @@ regulator_register(struct device *dev,
 	regulator_remove_coupling(rdev);
 	mutex_unlock(&regulator_list_mutex);
 wash:
-	regulator_put(rdev->supply);
+	if (rdev->supply) {
+		unregister_regulator_event_forwarding(rdev);
+		regulator_put(rdev->supply);
+	}
 	kfree(rdev->coupling_desc.coupled_rdevs);
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
-- 
2.56.1.839.g22a8290db9-goog

