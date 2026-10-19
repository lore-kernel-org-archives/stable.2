Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443366;
	b=Q/N1UMxX3fORImyXcdSRI0328terT511oBYAls3/D14+kmuO6ckgnkDXNLU7UhM/CAbB
	 OfjreCTiejjtQJPNFD0ruKwA/iXW6LLv+JCNdZEapoYD/70VFcAS0BRpsAUnCQjFo7d4a
	 SJ40KAWmwg7US1gjiBiH/nk7oFjhJnR3VNWOiTiJSC/7JIzkwvZgbXEyW2Tp0jfEwTCLH
	 GY39/siUMZatuanXt16vIgZIO+qbtc3EzLl00OUPRN7Cg0r+Ync+7W+m2kEGegPw7hLU4
	 e6lw17FJauFqSynZGvUjBoxeQGUgN9/ULNXu9U+75fXCdPkkgz+lwuWGUneHUDv8jcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443366;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BjZVrzg3rsf7XbY7jaOkZkV6KS8iKu7zuHPhPhRa91E=;
	b=NQzxsEE2f7JhR5SKQjvwsH96XQyHYqvSYbg6BpN4HLnF+Il/huiE1QNUgxBSX8A+Xj4r
	 pbTQ0Ne8jhFh2EQfXpeNyPIPCMVKHXPC4AkaT+it+Cx8VO1PlnZMS/daGP/yaZRJbADpt
	 /dPMOJiE2KVrzbGZcc5dlD8dS6+F9oxOTfKxm8hx2g1s+llIGK3uNIaQz1wnrJ2jNPZqW
	 jNDlJeSQatksLij1uwBrpGecdE8lxro+V2JJumunL2G0TVZRXfSGfDGOKwu1VFf3KvqvA
	 i0yEswoJ1iT3mDTc7jDL15Tr4hGn0v6Z9PercazZ4HqvosWBkwCl0VezaNckTRip+1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaqOCt87;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05437606A31A;
	Mon, 19 Oct 2026 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaqOCt87
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B435A1F000C4;
	Mon, 19 Oct 2026 20:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443365;
	bh=BjZVrzg3rsf7XbY7jaOkZkV6KS8iKu7zuHPhPhRa91E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AaqOCt87uid4jy9SNYadhhhufQD2OkEVYLeIo7wWintbkPMxDFt5hE094B0UN7vP4
	 wtWaGcX5VWIhD2E9cKYa9k5DgB1K4t72apgufNGpoDikiPAAoosP3Fsbf0WhJcPlxy
	 hX1WftopX9o+g1zUt7Qv1z0px45podZKK44kBo+r2YMJuxqJExsqHpZgHdTyLSdygs
	 phh5+ftZaBVa1JwLYi4GUXNXoTaok9DvC52ALGtSmRhE4E5dFVKj27ux2V/2D/1mla
	 O8Tu3RZ7yOXwFvYMkr/EusQCC5LivmSa62msVHKDIMf2hpVjEkSIy1Bfg2at/pI0Zh
	 1aTrmPNfNCYmg==
From: Sasha Levin <sashal@kernel.org>
To: Daniel J Blueman <daniel@quora.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
Date: Mon, 19 Oct 2026 16:55:40 -0400
Message-ID: <2026-10-19-1-daily-reply-0015-i2c-qcom-geni-clk-policy-7-2-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com>
References: <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com>
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

> On 9/30/2026 3:01 PM, Daniel J Blueman wrote:
> > If you can get the final values into a patch for the next -rc instead
> > of my fix here, that would be the minimal path for everyone.

Queued the mainline fix, "i2c: qcom-geni: Restore the source-clock
selection policy", for 7.2 and 6.18, thanks.

-- 
Thanks,
Sasha
