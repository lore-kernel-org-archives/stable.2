Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344398;
	b=5l41tKb4jklOUofaHRnCiEwZbXnnVhVoveH0Yiw6ZxuIyV3OOtK7KXULYwp10HFaXm8U
	 DOkraaA+Pyau+GxmNwV8rGEcmwV79cK98IwXLiRdRVRDIyaPk1wrJ2cnM/HBQa9ZTVFm7
	 nK8cSK54/+D83qxaYZ1cYbk1IJgATp32AKcOoHqXqEhr8ST8nDTYvYqHzmD01K1fC+pZd
	 QoaUpgFgFD0DVQBcBjpxjd1/t2Ye8xtdXjuTKNFH51LMaObxpt2LN7lUR/vOp0G2litXm
	 XC+onD1A0dPQ8tFUgt6/mQItw1//kYk7mcjYSlamDkfb0xUCQduNJbUrX8YAu43HWrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344398;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=glOwsEYmKhlMNpUk27Xoyt5cx/Nlp6c1lt4NQcSc3S4=;
	b=XtfvZmTuFCYDjv+3dz87bZ5JM7qHuVttbmhNge+h96prUeF4c7lAsD2KPzLmk6TGfRXv
	 t3NfmcFyr0i14BTv1pbRPFNCh5THQg5voIQqU1ktNjLsaWLXR5g+E7Ea3r7nKX0d6vonz
	 SlbQCz2EciyhF7kEGtdzbMc6gIeIs0T8ybC2OMNJq0iXgCsxyyNFNAMk2rD6g8aDvlLOg
	 7md8uhVqYoGGYGTVyLlhOxmb+IH2QSBV5EwJheQk2FRXX6Ae2+s0HTm8jCXebFtueWHtc
	 gToo1Rhjqa9PcoNHi9vPEMv4vjwTndhWd9f9duKxiWsH4TY2qNBRWa7p8UXHbBFATfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDLPXjhe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6216A60A260D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDLPXjhe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A651F0089F;
	Tue, 10 Nov 2026 20:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344398;
	bh=glOwsEYmKhlMNpUk27Xoyt5cx/Nlp6c1lt4NQcSc3S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDLPXjhevvKxCOA1xiP2BOXJI6O1AUmzocw1KOYDIpmx0HyJwf1efVJvmBa/YwdWl
	 P1zTy1r0zpIo6TWAThFlHR2nsoHDix2HOGAC/PAqO1mlegq3vNsqvdiL33X07LAJla
	 5Jnj/AnHlPgYxEktNyZ2hBfi5+ZJv82cGS2XAUqRoGtQiBsQGRqZsZCFrJr80LSTUK
	 iqZElPxL4T+Pk6WWi0ZybDtXhw9k+4clJOFUBGOLrxdsJ8VoVdkY+EnEWjfFNkvzNl
	 7Hn/aqIH/EgcWrp/ltkxfdyAH8gngVPyH/UFRKUcKdEsHtuZXOYiwtB2CIVT6XyXzp
	 GGnsF+h4MXgpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Subject: Re: [PATCH 5.10.y] can: dev: can_fill_info(): don't wake up controller if interface is down
Date: Tue, 10 Nov 2026 15:59:23 -0500
Message-ID: <2026-11-10-1-daily-reply-0027-can-fill-info-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110084318.223328-1-chunyuzhiqiang@yinhe.ht>
References: <20261110084318.223328-1-chunyuzhiqiang@yinhe.ht>
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

> can: dev: can_fill_info(): don't wake up controller if interface is down

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
