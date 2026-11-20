Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207210;
	b=2ip4IByXC+fRB9FW1gySk3OYTdaGsNpPTIkFGDmzpEVuB/aVHzRpWJA411J8zglAKbya
	 5DF+IabSH42L5g/paGMGhqrn1kGu7bkoADPRUcfZx+trSEy5ESpUUZbbcknjLfM/5XSov
	 tWo7Gxd9dVFshM8IRFAGL7gDG4esM+ViiqigAftHovpjjcH0+DYfYjvu5XJJGS0Hn37tJ
	 W3Q/l7elOr47bidV0wycpoNar0UvoAplODYZHqB/Ovto9qK4Oc1iA/CNeF9y31wa3dOG8
	 97f5TOvSn/cfDsQ0J4gNGd56+MexS5jCApYKUxyoz7oambILW2pAv1URTp/NKPOsXMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207210;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bIew3IiJ8mCgEZcFZfOsayAVtXyd5RByc/78pUI4AtY=;
	b=Qxv6kDEL5FC8ICHDKeX7FYcCOvXr+kCUIRTe1qEG6bCj0GaUZNTH+iWPHp2WhFSCErn9
	 Z8SosxIRycK/eGAVPiDOhIY0jaj/eRfzM6yUwM8KVIwUVLREgy+XVd0zqaTq29F/gnoPv
	 +xMlV+/nra/eDaow3tRAYNg7SRVIC4jsST52FRQNPLVV2Mn4ShQZmAs58OC4BJ/LCgbJZ
	 KINW+3R1NBLgg5sPGSRnQlfDoMSAiz/MARtN5jEEcjCB8+DWp3AjZFgGWs92tSnJ3wd9p
	 9miEFFFwHpCo2L6J0naK8yQ0/X+O1iil+hDeJ0/ggHk3HYbbZQ4xc9ZjKV7ycUKAZ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MODna7My;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF8606A6DE;
	Fri, 20 Nov 2026 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MODna7My
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274221F000D2;
	Fri, 20 Nov 2026 20:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207210;
	bh=bIew3IiJ8mCgEZcFZfOsayAVtXyd5RByc/78pUI4AtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MODna7MyyK3troyconrMvtAmd/n7qMqqRMj2TjNcbKynCbQKwPWF1TOVN5fo1QDqt
	 GRp3jXATYqCksilzGYiHfJQ4MYz/+XwAOfa88+v2hRPsLi8U5K5xfmQh9GZ1Quo1q4
	 cYWx9ZxpN7VcRGuPFMtZw08qt1DJ5eGuIIETE0560ht198/5ufLAaMIQR/+e4MYW60
	 I/3bjDY2hXURaB62d36445T3zp57pKd9NvAMYX/RVjtJ0kq8tFZfM+AWkhXnLMykB0
	 S1fRA9QQoqSGgLlKqaWnZ6pbDPr9NKzG8X08VZ/LVwBNbpGjtGt4VKmqCdN0sXucdp
	 Wd8b5k4wb5TJA==
From: Sasha Levin <sashal@kernel.org>
To: "ntfs@lists.linux.dev" <ntfs@lists.linux.dev>
Cc: Sasha Levin <sashal@kernel.org>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	"hyc.lee@gmail.com" <hyc.lee@gmail.com>,
	"zenghongling@kylinos.cn" <zenghongling@kylinos.cn>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"d3nchk@outlook.com" <d3nchk@outlook.com>
Subject: Re: [REGRESSION][NTFS] Linux 7.3.4 mounts 64K-cluster NTFS read-only after $MFTMirr record 24 mismatch
Date: Fri, 20 Nov 2026 15:39:17 -0500
Message-ID: <2026-11-20-1-daily-reply-0028@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <VE1P190MB0877D026E2C3905F0324B46F85782@VE1P190MB0877.EURP190.PROD.OUTLOOK.COM>
References: <VE1P190MB0877D026E2C3905F0324B46F85782@VE1P190MB0877.EURP190.PROD.OUTLOOK.COM>
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

> I suspect commit 749357bd48c16c4cdc09093450deca609492f012 introduced the new read-only behavior for this case.

Yes, this comes from 749357bd48c1 ("ntfs: mount hibernated volumes read-only
regardless of errors="), b0a4eefbb2a1 in 7.3.y. Stable will pick up the ntfs
maintainers' fix once it lands. Until then, mount the volume read-only or use
ntfs3.

-- 
Thanks,
Sasha
