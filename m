Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2D433023
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223958; cv=none; b=uBnBbsZ7HkI45qLwXZkdUtKk1cfCbvrIiVl1gYYA92G3hgsUTokgDvrKq/Bd0wemtxBBP7+ueXdgfs3F2k3RBbSWxZkia2yyf2FWZbPhTteuMieBljkaHwJCnBPxcao/FFlm2ZU/mYTu/4XocLwlDspA5osEu3EtTDE8m083LCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223958; c=relaxed/simple;
	bh=5VGTo8Gojk1fHDkhTgLsgm0mnQsXEEEUa5KdFwLDjDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4vLfajMr+sCMJVTZrOUc4A/ag85IAjSH1McppUyw6NI0VtblOmzOdkYIsFtuueA392JHgcPZhkAo1zMgtEQhwrO0yphmOMqt/F6UBSfYCHsSmjkSc1OKkK3TdotOCxOkYBsMRFoKH2vYF/wJEx5ulNg0tKq0kl5UPYYERP6sdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJAqNhKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJAqNhKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91F31F000E9;
	Thu, 16 Jul 2026 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784223957;
	bh=JbaBvBV48Y33ykWBmaxzF2Hlbk2Fob5Vve2DA+fE3rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TJAqNhKlxBxpbDmEMmIukSyUqn9fmg2QAduk2sSIClo34unmPoxwf1Uh2NqEISv1Q
	 2QCPsrt5Fv+/3yGhJul2Aj/Kypj/3tK+rrHrk6ezXx3ViQ1qeBSKjT8f5S58W2ImxR
	 OgXa3qntmBTRqROevuDa9gpwx7ekrlSPEKdyLmY8na11inK1TQRmMkB2+ZVlfRv5LD
	 hv57jSpCs06XkI0tJipsCc3Q5PhKr+5GtI4wpdZRBrD2i+pswlWLzbY9M6LquhnuVp
	 tVqKhYmGNIf/kU5m2Op8Q03GB6UuSTnDj6Og2O/1aYScnYVZukRS7+MfuVq7Rt7GkF
	 mH0wNla5yDTSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] cpufreq: pcc: Remove empty exit() callback
Date: Thu, 16 Jul 2026 13:45:53 -0400
Message-ID: <20260716174555.787913-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071413-devious-clay-8609@gregkh>
References: <2026071413-devious-clay-8609@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit dfd3e8b90b3660b706c3031b0f746377c571b324 ]

The exit() callback is optional, remove the empty one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Stable-dep-of: bcb8889c4981 ("cpufreq: qcom-cpufreq-hw: Fix possible double free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/pcc-cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 6f8b5ea7aeae4f..771efbf51a48e3 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -562,18 +562,12 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return result;
 }
 
-static int pcc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver pcc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.get = pcc_get_freq,
 	.verify = pcc_cpufreq_verify,
 	.target = pcc_cpufreq_target,
 	.init = pcc_cpufreq_cpu_init,
-	.exit = pcc_cpufreq_cpu_exit,
 	.name = "pcc-cpufreq",
 };
 
-- 
2.53.0

