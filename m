Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FD52F260;
	Thu, 15 Oct 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066815; cv=none; b=dWZESpl1WLFp5z29okpHE/iYKZx+0/zb3PDKUa5f4wyc/TAvffGBiwUTvHsDBFU5lgW4nnhj0GCtHcKfI0TgR9ZePtb3QktmiaN+xCf0x1C3YSFciMZdU97xv8ISZzki8tLWdTpJCWtOvRrXuVFFxfqLy5Zd3JDTSctz4S/qMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066815; c=relaxed/simple;
	bh=Gq5YBRvs7s13w69V0nh2uq4o0UEC4big2q5KHPOUVjg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1lGY+0alC3ZWSJRbqGId5cbymJqXleGNiaxVNGRftgM9u13AsYHPcsRa36gZSWBZyuTSFWdZ8AHKBLVWfikysdlWYxWLcrEfgMXSvKF3HoCQhbAa+fOWI+LiP4qm+o3p/DfqIpBXC5RXs3zKE8egmNhYGOGeLYUL2wBka7NYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=i/MkhIfw; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="i/MkhIfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792066805; x=1792326005;
	bh=Gq5YBRvs7s13w69V0nh2uq4o0UEC4big2q5KHPOUVjg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=i/MkhIfwmB/ZokhN/sDWO0kOSG/JZNUbhrXSeJZZh1AwQCHpDrpdWu4YWkDu5H+wG
	 SzaVuL7mdcGHxNYZqVxB4lcxzHaPFq2udAL66bca6chN18yWVMnI+mGQtXacu7589f
	 lCYkmC8dNDXb05hkizgejnGEpm5kjNf4fhx7O8EZJknWCzT7dNcEL4tuOqAn+KBFvQ
	 bmGBgJwIKQegGKuBqpro1wmWzFs28DQZ0xP7HvSSbGHt3poYSsiuHPSHgA+a3tqsVq
	 h7RscCnVwG5g+kOxQl7dnvBQVPTvpolAwqJzJXhibEIKy6YefMGOb9X7Il+ZkLmDpi
	 5mMF1aDA8a6vA==
Date: Thu, 15 Oct 2026 12:19:59 +0000
To: Andi Shyti <andi.shyti@kernel.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Thorsten Leemhuis <regressions@leemhuis.info>, Daniel J Blueman <daniel@quora.org>, Sasha Levin <sashal@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL"
Message-ID: <179206679156.49371.3533488984291951831@pm.me>
In-Reply-To: <atC-ZZLkXs3yM6l4@zenone.zhora.eu>
References: <20261014130805.48840-1-birk.skyum@pm.me> <atC-ZZLkXs3yM6l4@zenone.zhora.eu>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: da2389b14d6ad1bc093c9e3ce672f2ca3776a979
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andi,

Thanks. I tested that fix on the Yoga Slim 7x with v7.3-rc7 and only
i2c-qcom-geni.ko swapped. The keyboard and touchpad work, also at the
disk passphrase prompt, and the I2C serial engines stay at 19.2 MHz. So
the revert is not needed.

Birk

