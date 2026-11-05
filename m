Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889557;
	b=YTJApyiJO4/kTKf8h+sr3VsISsfld3Hu4/M3RmvnvmsOtohScX+IzndTPHqbMHa219NI
	 IOuJTacZjE6ivlF7v+vvq0dqvTYnHFfFsuxyy4kiT/lsJUw9hOOSYvDlDMZoB4gKKnA4n
	 TcSERsmweOv87+kqwhiMb+D2eZFxPESUW9nfU9HSluDr0XKY3kC1jr5C6evocaHCV+bSc
	 VBm3R7rIfCBshk2ORw8HLzR+M+by75nyp8eUZOKX4MMlBIlz1fatSYbmksqigbCCZT83k
	 x17xukEihNnljfbuaR7h/yCtsVXmTJHhtRDvsx6xDB+NFevJrfFOm5IpkImNcDyyuDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FiV21OCubJEzTg6YT+Q4kjJCdTRu4YfZXKAgzksJbjM=;
	b=pakOzqD6dLtsgayGmex3N7/anxUQ8y6aIbqWLmxQEzsDCoJk0fl6vjTK+favRLl1E1cH
	 ePYPxo8gzCInY6epteaI2o4SWV2sG+56vVk8y4zbajyfs32N7ZAbgE04VXmFpaQDYg1li
	 GjOkJa82oqlIF/Djqwv9ji+Ri+K8zH9cFkg+0dX5FuEgogzNrOVsf0jyf329SazqltKxk
	 W4ZWRTZLPUJPEsVO74+MfKKRHnOxn23+TPVw/EptQxZBHn0s+J+FUwD8nnFbvCcNJKFUm
	 HqRy3SSqmQ63tadne7/5hJCvTVVM/ZbeiBSZ76hDkCjGv9e7y3a+nym7MJ62gyujuuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBFG09mJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEE9606A33B;
	Thu,  5 Nov 2026 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBFG09mJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16CD1F00919;
	Thu,  5 Nov 2026 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889557;
	bh=FiV21OCubJEzTg6YT+Q4kjJCdTRu4YfZXKAgzksJbjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QBFG09mJoLNJqFObhX4Wx3KrWOCSyVwty+pF8IqCAUVrPiGOMZlBIQTJ97j6x0VF7
	 Ey1oQLf5TG6xEdVxmWZlqvf2PjYyyBi6un3oVT6D+3oSX6ypeS/uqJIJddHiY4gH3Y
	 sNahT6CzLwJGRs7N1u6hVMuez9s9NG0a+gVwkghxLdDIK8bFHQgL622PEy8PGm/biD
	 MzpOK9gQ2C2Idw0ZQnf/GmO41mjUB7jDeaKq0j5qPUOUsyEGszWGPkgCj85t1CkzcP
	 77qEu5kngYp9ol0pzMe4wqzgxWEZjEgC5GUKrjRtWpsbtf399ofxYJaNo+z3ItGboF
	 0MGiUn6I0nvVA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Juxin Gao <gaojuxin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 3/8] pwm: loongson: Fix 32-bit control register truncation in pwm_loongson_set_polarity()
Date: Thu,  5 Nov 2026 14:38:05 +0000
Message-ID: <20261105143847.2559586-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105143847.2559586-1-lee@kernel.org>
References: <20261105143847.2559586-1-lee@kernel.org>
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

pwm_loongson_set_polarity() stores the 32-bit value read from
LOONGSON_PWM_REG_CTRL into a 16-bit local variable before writing it
back to the register, silently clearing the upper 16 bits.

Change val from u16 to u32 to match the 32-bit register width used
throughout the rest of the driver.

Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
Closes: https://sashiko.dev/#/bug/linux-bea00bdd-ae27-4d81-9902-e96ed8b6d8ad
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pwm/pwm-loongson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 98c809bde2b3..4e8b54c8016c 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -76,7 +76,7 @@ static inline void pwm_loongson_writel(struct pwm_loongson_ddata *ddata,
 static int pwm_loongson_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 				     enum pwm_polarity polarity)
 {
-	u16 val;
+	u32 val;
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
 	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
Cc: Binbin Zhou <zhoubinbin@loongson.cn>
-- 
2.56.0.398.g882cbad275-goog

