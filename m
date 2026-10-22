Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634653;
	b=FjeIn3wLH6G7x8VJTKnfmD+/5BZefzwFYVnQDIrbQi+A+sIJKEou+Ym9AI9na3wMKCXD
	 sMRfPCY/Y3e8iHoSWL9zi1t8qVBkfjYduwnoRys6bVwVQhnb29VPM2cGiKZJNmHqmpQpY
	 DwESgiDHLeIlSvjBmWebDIFF5PlCtxD58zzR1GQC2XfUfkF0ty+hjCXvPWakGfvpaew08
	 HI1xfsJusDooJ4E28k13WNvMa0Ca3fSSQ+xtvKccV2rFAWbZBRHlX54GwccHuFLeE2aAz
	 Q1xoivSMLIhmNf5NWU5It9Fun2g77r3L0DQ+cBHhdn09noXPuIOo2UN0Pf2n2aGYHbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634653;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KUdiQc80QlWY1VQHz2hIXiVlw7ejVbPzSxf3xxM1f+w=;
	b=g6YBqs39jfdQfnp3tO060oUpsEum28IUkSaU2eHLBvuFxJhGM/zgal2LXJIwIsGU7of9
	 +GydhxsjUkMal6XQtnLI2QrcBIJHjkaucdzaeo76zq+TPG5V9MIFKYPmiePer+79oj8rR
	 WW/MQO1X5uvnyfMayjlRVNF63T27SLn615UB6q0B5xCQLmYfbl9aKkzWpbszuCVhDyHf4
	 eZmlGlHPKtmFJugvzKXvOZfIZFceHzkoW2l6ninRhRvQVDydvI+DEel5XjA4iBGTvsBxn
	 q/b9JhdozJmBlNJ05BIzei/f4b3sGwgf6l2L6PyhUMFuCwRRZOKfAgxT5+o3JvS/tiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GovDm2d+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F65606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GovDm2d+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151F21F000C5;
	Thu, 22 Oct 2026 02:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634652;
	bh=KUdiQc80QlWY1VQHz2hIXiVlw7ejVbPzSxf3xxM1f+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GovDm2d+EmMXeO7cNN+5Cqycdo9ZObPJYfy1FrUVciLRNG/TZ89py8RzB65PonBMB
	 O74b27jbVt9n+aOgYeO/5AB0Siwk425syQfVLSrJetdFZQ+bs13KgHg2tlJM00Ek99
	 hymtGMKkDMwVn+6tYYJIIXjb4rCyVgPrFHj0+wLahFJt918ZBLpnQFQSsfBuE95+I1
	 lRkNBNIxE3tACpWfaSwvjiS585dc7/gl7cDaU4Bm+J1vU5L7SoJITx3gK+nE12XO63
	 xvbb1aQdpjzI2vEQPf5bWuSa+Zdn/spJTNHkckbuqnJuGaBP/XfDrZ5FkUhZpYTlbH
	 bc3YctWjXIqOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Di Shen <di.shen@unisoc.com>,
	Ling Xu <ling_ling.xu@unisoc.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.15.y] OPP: Fix race between OPP addition and lookup
Date: Wed, 21 Oct 2026 22:03:38 -0400
Message-ID: <2026-10-21-1-daily-reply-0013-opp-add-lookup-race-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2026-74405-5-15-v1-1-d71668a66800@bootlin.com>
References: <20261020-cve-2026-74405-5-15-v1-1-d71668a66800@bootlin.com>
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

> A race exists between dev_pm_opp_add_dynamic() and
> dev_pm_opp_find_freq_exact():

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
