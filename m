Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0640355049;
	Fri, 31 Jul 2026 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468241; cv=none; b=FPLq+DpSwzwkywnA8GrakN+ntUJmF/nRyuUAXysPQe3r64RByKNr0IzWicYZ5ACUTwdjzfI/JViTVO4Ja715NadBS/3WCHhNl+r/Id+aLkktXY5oBypwgVqPmI71L2B7A1UPrXdW1lRRCSjKwet1mVY+LuwWkf/Mu3SdjZdcUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468241; c=relaxed/simple;
	bh=QKWf9xVocO77DFg+a+IVSaSGxnFNZ5Wa7VImOWB7wDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tki0Rhb9HLvxHJMO2KkFJlwHLO13dLPP9U5rS6YwWNO5Zj1lQX9heVTAlMopVgsrdd2sKa1DQDJNmIbivoo9WNJQQ1o+gFtYuNF9OdB7skN//Xt+Sgh+RjUTwFa6fyUzZmrX2u2Dza50VMSn4o/LSaFhxplkwGE4UIu8zAtGUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuls8GR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuls8GR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E761F000E9;
	Fri, 31 Jul 2026 03:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785468240;
	bh=L8WzNij2gRCyD9I+/yy77w28u8H0PhKcb6G/qK4rrkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nuls8GR691+9dGYvtu/bp17ctbfWgyg5lIOjr7uTxkql20HOpgNpeXg/PKssJG5oS
	 77HWBWnCufTtSZNTSWFntK3xv8PtYVNQp3I8wlct67uPYplTKOW6yqGsqOrJB+3etA
	 HR0zgp6Za8WoKZyMEcysOVy3umHQSIYnLO3IK46e5M05yRaJdh3LHn1pSRhQNgHq/T
	 NU4jInTvqUdbJ7X2dkTXvREUBC1SlOCJFi5SW+OVIqjncFjFGb9ww6Ckd1Cm3nSIHx
	 Nicmupi58PnlLWTVsgBhua3Ot0ptp4sTGAVEP0I/T/2hPLW9TxBKhqY5Fr+VNy/jQh
	 B+3/0lmwqgBfA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] soc: qcom: geni-se: Use HW PROG_RAM_DEPTH to validate firmware size
Date: Thu, 30 Jul 2026 22:23:48 -0500
Message-ID: <178546821241.316167.8191448263942791173.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702-qup-se-increase-ram-cnt-v3-1-80b363373a5b@oss.qualcomm.com>
References: <20260702-qup-se-increase-ram-cnt-v3-1-80b363373a5b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 02 Jul 2026 11:12:23 +0530, Viken Dadhaniya wrote:
> The hardcoded MAX_GENI_CFG_RAMn_CNT limit is not accurate for all SoCs:
> some targets have less CFG RAM than the constant implies, while others
> like QCS615 need more entries than the old limit of 455 allowed, causing
> valid firmware to be rejected at load time.
> 
> Rather than hardcoding a constant, read PROG_RAM_DEPTH from SE_HW_PARAM_2
> at runtime to get the actual CFG RAM depth of the hardware instance and
> use that as the upper bound for firmware size validation.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: geni-se: Use HW PROG_RAM_DEPTH to validate firmware size
      commit: 522bfb4f33c0930b3d14d5c5ee80bc93a883b544

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
