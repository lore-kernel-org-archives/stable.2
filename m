Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9203BF68D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979871; cv=none; b=eusftIvWVV9nfMFEpc8xSTjTR71I0f25TMk7dUKgtdjZo/ydgu48Ijq03XwszSG49SLxQoNOlYCnuUwjokP2oeh14NsgNqVpdSwGEmxJti8HwI+mZj7WZUcyIeXk2ojjzHvHsLd4GRSiFTsmk46Z6HkhIJ2teiSaAYpiMu63cHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979871; c=relaxed/simple;
	bh=Xp/GFasEgAIJqNsAXJa6SclJ+9x6pB+nQDMQoDogRr8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjP+LcjODbVrRbyNwCgwdaUeo0YWO2Hm8VOz0BVnwAFt/vWDqqmkMxY28WCpEruY89b5bLDA8yK5JMs3YUOmea+lektPoHNwfvbDue1yJqdrVXqfRiKkoCEKpRONRprd64BWVJq6I7ZDdHxyzNa97h8emLkptGA8s1hgG64yHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Q28rOaZL; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Q28rOaZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791979867; x=1792239067;
	bh=1+JK5m/+BxZlw9mOjY6pK0jZbTnl/yjFybRroz5wVa8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q28rOaZLaqwPv6WWyoUAzRSQOPQKse9SplIc551P2v3tz7zYeLnbTYLMTj1UihGoo
	 SA7soBR7Bc7mmAESSqOSo0cGhQbWhvie/TJC2GfyX3jpoeWTTYTz6ypsjLbGxO+Smv
	 nzzEug+nlcP9tqRzuEzZeSO2HHqpkPidtNO8txFDTw37Es+Sn5ou1dRIO1cw4u9uFq
	 7h+s7AB16XI3sVNhEaf6UQ6lLMeYvd8EUWkveq/V4i/0L8Fm6Tmuybcscrb2OpZaMX
	 4YISC6Pc18FwDHNoRHm92RDEpf7kV/uJo6SMNLzFXIrGZY+H6pjJC954iPpPcvqjVS
	 WcyF357uP0nXA==
Date: Wed, 14 Oct 2026 12:11:02 +0000
To: Thorsten Leemhuis <regressions@leemhuis.info>, Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>, Daniel J Blueman <daniel@quora.org>, Andi Shyti <andi.shyti@kernel.org>, Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Sasha Levin <sashal@kernel.org>, Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
Message-ID: <179197985641.52689.14222546983549320957@pm.me>
In-Reply-To: <e8f862fe-f86c-4522-9ef9-70fd754529af@leemhuis.info>
References: <20260929041444.9837-1-daniel@quora.org> <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com> <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com> <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com> <20261009145800.rc-reply-0004@kernel.org> <b7bfbf6a-e5b5-48be-84ad-8bcd8e22c5de@leemhuis.info> <4acb0eee-f7ae-4817-9848-d72cf486bc06@oss.qualcomm.com> <e8f862fe-f86c-4522-9ef9-70fd754529af@leemhuis.info>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 233af268ef3cb190bce00ef5572e1b46943b76f0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/14/26 07:08, Thorsten Leemhuis wrote:
> That's how it is sometimes, but then it's likely best to go back to the
> know old state by reverting the culprit -- or is that a bad idea for
> some reason?

Hi Thorsten,

One correction first. My report was from 7.2.9, and I had not booted
mainline when I sent it. I have now, on the Yoga Slim 7x with v7.3-rc7
(a distribution config, no patches), and the keyboard and touchpad are
dead at the disk passphrase prompt.

  geni_i2c b80000.i2c: Bus proto err, noisy/unexpected start/stop
  i2c_hid_of 1-003a: failed to fetch HID descriptor: -5

Same kernel with only i2c-qcom-geni.ko swapped, one boot each.

  v7.3-rc7                          keyboard dead
  v7.3-rc7, cb97bf3d4f91 reverted   keyboard works
  v7.3-rc7 with Daniel's patch      keyboard works

The touchpad binds whenever the keyboard does. The I2C serial engine
clocks read 32 MHz on plain rc7 and with Daniel's patch, and 19.2 MHz
with the revert. In all three boots the touchscreen and the three PS8830
retimers on the other four buses work, and only b80000 fails.

Thanks,
Birk

