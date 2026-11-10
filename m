Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338255;
	b=G+znbgAz+KbvPjZT7XkiaBwCyIgUSutoPAu67fwwQG1WDEGVZcG3QIDTtTGGrRbWjiP0
	 a7ma3U0nifcBk+2C1oHClex+2wiypiDyRT4imk540Tp8QnLyOtdFLo5uwdSi7HyHf8l/k
	 Geuey84mjozWHHGi4Dbd09p7JqgziGr4C1Q3J7VgSZcvrDwoLWwfhTjG1Wzso1Vrc50wP
	 kx8XAtOYd3eVOd8Cu2paENBXblwL3heby2T/0s91g/SR1ds6A4JRNtdpQN/TFShraOXbh
	 QPv+Y8vbsm8i9Guq2hxJd9yWkwXvw27lBobIEim0mHeoybO0unUeXK4VLPCOfvDvNoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338255;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NWHzOmzoGenyUxfNUvWTecDWhNzx1JmAQQJjRD7k5aA=;
	b=zc7AZwpbbVHnZpua22D05IIjPacu023WWBcwLtdG0JmiS0ODOAPNZs2IxFavoOmHs/hV
	 MWSxTevc5x//DL5Ub+k0ICfPFwLmm2fg5CJiiqSZm9/gFAr4v5ucbKZz0nX/igcgOkxkP
	 JJf1EwXEK5e2Gv+7aWZzP0wz6wItqdoRlgK16C9w9G7JU0rEWXVlJgu1SIf85vH996TEu
	 iAwx/KYEzdCFLSexGIpTz7N7R2daknzUlKg3Z2rOd328GKaBsdlYxB5mpGE/tj7wYtQ8b
	 Yzb98oDTqtES1kSlisHW02nLTnhHXu0hpS3m64RZzrYu8Np3nWrh77Oca+CqC5C8kbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AiYcBIYZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594B606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AiYcBIYZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268851F008A5;
	Tue, 10 Nov 2026 19:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338254;
	bh=NWHzOmzoGenyUxfNUvWTecDWhNzx1JmAQQJjRD7k5aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AiYcBIYZxcruUUHMq1ZRaOZIFmwwRxFp1Cvs7dJvJZ56p+clcpLMP60QgaP+fovbe
	 gXUhzU5VV5vnEb/gCTNwVsqRzAaeqzrh3hJAxAnHg+erIU3sIDBsMH5dtYvzmlLVK3
	 TZZSTQNX2NGUQn1nasotE5ZXHVrhx+pgZyZ5H73lrZaOwsMEPy4NjtteNRb2a8R6Si
	 TlxTarcBXrEyjnAEr1k8RsfevdbVpTQdc9wwc3qYE1+8YaCAwVOIR9Lm7YDipwnj9i
	 /iKMzpduO1sIeJ7TL7PayafKXMOP7ixQ2Ra3fe7BIyd5tXNHdj9qeCrDAjJbcYR/Vx
	 88oI+Xvlw2clA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] media: iris: Fix power-off ordering to disable power domain after clocks
Date: Tue, 10 Nov 2026 14:17:29 -0500
Message-ID: <20261110191435.3457367-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110191435.3457367-1-sashal@kernel.org>
References: <20261107050739-failed-6.18-9cfae7726a9a@kernel.org>
 <20261110191435.3457367-1-sashal@kernel.org>
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

From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

[ Upstream commit 9cfae7726a9a9f526e8905dbddde355be2674e3d ]

In iris_vpu_power_off_hw(), iris_disable_power_domains() was called
before the associated clocks (IRIS_BSE_HW_CLK, IRIS_HW_AHB_CLK,
IRIS_HW_CLK) were disabled and unprepared. This reverses the correct
power-down sequence: with the power domain already removed, the
subsequent clk_disable_unprepare() calls end up operating on
clock-controller hardware that is no longer powered, which can hang
or behave unpredictably.

Reorder the calls so iris_disable_power_domains() runs after all
three clocks are disabled, ensuring clocks are always turned off
while their power domain is still active, and mirroring the reverse
of the power-on sequence.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
[ sashal: Adjusted context to account for absent IRIS_HW_AHB_CLK and IRIS_BSE_HW_CLK clock-disable calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 8367540163f2d..437b9e921fd08 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -220,8 +220,8 @@ int iris_vpu_power_off_controller(struct iris_core *core)
 void iris_vpu_power_off_hw(struct iris_core *core)
 {
 	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], false);
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
 	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
 }
 
 void iris_vpu_power_off(struct iris_core *core)
-- 
2.53.0

