Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434121;
	b=v2DpqOLg1u60qFLZTyUx3xiP87bfcYSmkH2ljuG0Ld0NVS6rxYBP+hCYSpk+MkUVp4pJ
	 IhwbdNdajOxTmR31rGoI1cgLIlKd5p1iridODt2PODPr08z8HiTCAqMr+uySOWgwDtzAl
	 R7moZBsKH3ta0QsUODAC/AvPYWztVOrTZLrY2lNRLfpCOChYqTztOQRt31j+cUGtHvrCD
	 x2QbXENavLN2JXhXDZKVo2YnvClcqT1sNVTn2e9puoCQDI8uauBKw1Ixg1co0oTqlLMNx
	 YTFy5KR7GakkqHFWG+9rB1ERt1/DbAzN8Mg0aLNj6YyyBu/kn1BEje9QNIO+yGy/IsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434121;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Zr4Vx+/Gmb10yJo7an73dZh8NbM8pKsHfcPn/uLTgIY=;
	b=z7aMA5tPh79SjdMTcwLxSjT3aYuivr7XcrTH7zojhdW6nkkl3ZXkl1y9t3Ol1gac6Fkq
	 Wa4gGWJonYNAmh1Ems7ACDMRlY2b003TMDjdWvoKc1c8zOKbPz/vhz40PY8j3XLMLHBTR
	 bFjktwyDFtoEYWRiNsmvH+n6JK9FA6TPXLR+ZpRGbejd5NnOMyKSRQ77JYyJYWsTLZ3d0
	 BK6K9n/OkOtElwIhew/YkP79pRp7LFewfcELhfHEtwgU0pAoxNdkyzlAAigqi+x8KajVY
	 kWwbrPuSp8Huy5ZJCi6wB/4jqUdBLlI89InECcl4g2XtTzeY8neOUv4uO2xUFSMebpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dn+ZWFko;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889B60A3814
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dn+ZWFko
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0F81F00A05;
	Wed, 11 Nov 2026 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434121;
	bh=Zr4Vx+/Gmb10yJo7an73dZh8NbM8pKsHfcPn/uLTgIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dn+ZWFkoLntbqr8MHvjvquurDWnxSc2SphXD72MqXvTxSyppnWjBgbi8riDk0Jk8L
	 iUv8C5GrS5YJPNQ6YiH/cfz9JGBrbXPk11Sfey/UQibxYr+BoZ1WR9VV8+TWFZoAY4
	 V7lRPzQqNjEng1/hBKrwB7gyjykDVpUJ5J3P1vZmTZLjeYKrRRcrG0gzVDOakYT/gt
	 qRx1hVtcS2v6RnKrPirEQF4NYV//AjDjp70DWzpq0PxLNTxvzG8+zLp6fD42prMx7s
	 6ERzbZWNIMwbJUjXyBmp+nsdqs28687zLO6ruisgBm5CEdcVfe1j2n8ZNVxg8thCY9
	 z8oN8qox4593w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: Re: [PATCH 5.10.y] ALSA: hwdep: Serialize DSP load requests
Date: Wed, 11 Nov 2026 16:54:58 -0500
Message-ID: <2026-11-11-1-daily-reply-0025-7d3aa7a83ebfc4bfd8b3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111041847.4364-1-25031212351@stu.xidian.edu.cn>
References: <20261111041847.4364-1-25031212351@stu.xidian.edu.cn>
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

> [PATCH 5.10.y] ALSA: hwdep: Serialize DSP load requests
guard(mutex)(&hw->dsp_mutex) sits after two early returns in
snd_hwdep_dsp_load(). 5.15 and 5.10 build with -std=gnu89
-Wdeclaration-after-statement, so this fails the 5.15 build with
CONFIG_WERROR=y ("ISO C90 forbids mixed declarations and code") and warns on
5.10.

-- 
Thanks,
Sasha
