Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D73DC4D0;
	Sat, 17 Oct 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274198; cv=none; b=AnDy/1tQYwJu2IhTlCRy5kkEYJ2XLlib4OH6Sf1y75ZsIZQdSqSznPavi9W55/zEDVWPTw8RQFgIsJuj+OaGlYC555lPZ7RL5hlNaUroxcyG839nuXMOq7tVRz2FU6VXRXn6V6Bgkjwr1nIwBIQi+j7Xf8E7tgMmoDZvUlbovrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274198; c=relaxed/simple;
	bh=SbzjMl1UOlV0+IWe4rsim1UBVJ+TEEuodDtx30MloyM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qbfaadfBuacMkof7j/yipEsvObOXBWd2SMZeTTbtfVTLqlis6cvGzMc6O25F/penPidxiSXSeZXnZ3o3QIrceWxpwapCvm9varxtBFQjqp0hTg4PyJnlfIuxDO69FYZIEqnWmTTa8oNPIpcP9/ujrvp3RKlMXTITiDDZbo5EbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAF31F000C5;
	Sat, 17 Oct 2026 21:56:36 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 89C211824B9; Sat, 17 Oct 2026 23:56:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Brandon Williams <turbine.bmw@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261013-upstream-battmgr-charger-online-v1-1-731973e133a0@gmail.com>
References: <20261013-upstream-battmgr-charger-online-v1-1-731973e133a0@gmail.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Notify charger supplies
 of online changes
Message-Id: <179227419355.76434.7619856860075252381.b4-ty@b4>
Date: Sat, 17 Oct 2026 23:56:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Tue, 13 Oct 2026 13:34:51 -0400, Brandon Williams wrote:
> On SC8280XP and X1E80100 the AC, USB and wireless supplies take their
> online state from the charging source in the battery status response.
> The firmware sends no notification for those supplies when the charging
> source changes, and the driver only announces the battery, so userspace
> never learns that the charger was plugged in or out. UPower keeps the
> state it read at startup: a laptop booted on the charger never goes on
> battery.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: Notify charger supplies of online changes
      commit: 87fd20da8ca8bacdaa9bff5860167f208077dc51

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

