Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318768;
	b=2UGTBiF3VRVVDltZRbZC0U9U7R5c/NNwSWlDC26x1rhJdonBeRdwv73FqBm48luzsJTo
	 v4TdhPx2d6Z9Hjytn1JY7PUhFnfdo7RqPY9k4gdX5vsQ93T3qtjH6STr3dB05/NzwCTCw
	 ne4gnMu1NzVDZscGSGJsl7RCZJ3UTh2Lx2WmcUtkD8vrSY1g7Le1NdGt7gBzw4tII212d
	 KCUElMLJSqFiDjeKtfFhUIdcmqoPuhGMRM50NJaCrzPwGb/5qDj3L6QPiIeVhrLm2DXJa
	 kmg2opK5/nz0Lp2NBD3Y1RhjioCLMvEYSaxRNTVJ4BE0atgEune8uY0CMr/bRR9SOsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OTn5s8hi36cEo7SAt4HSaAxYK0+FhtLR9irmvCDJF68=;
	b=v1ENQH/3dpSc9Q6yCheYV/S8uZAeog8dECmRYQsmSgbmq/uKM6cjakz5D63ctBA3CGdu
	 JIa4rKGUpLHkxLWUcZAQJYCtdxE67p6vfwOZrPTVP+UhJ8vMN9l4NgidbB9r6tTu5mLyN
	 yx+KM556Dh1PpfJOQe30FqrL55KxYKw5EbqroTgrMQklMx8YnbH1LXC0aidwtExhZ0qeG
	 eH6lCyyif+tlBhUkPnsY/WMFXOYBAxaH4jtfFt548RWcCug30NioHvSNMrsNG/AG9attu
	 Tuqy0cJ5qiEl3IrHqoaGK+NaRIFgWkNcrvOxB8BmpwaC+QVgbvOLyTdHZ2TQ5fMXqpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZ08Lv2V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC64606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZ08Lv2V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8D21F000C0;
	Sun, 22 Nov 2026 03:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318768;
	bh=OTn5s8hi36cEo7SAt4HSaAxYK0+FhtLR9irmvCDJF68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DZ08Lv2VYnqABo9nPHBMXDW1vAh2YIGGpOqSlET/vDlBAweniUn/qJ/SjRepGk3Mf
	 yqH0pkW2wz1/CEB4lIpglMFtPnKtJeG0MPhUE+Gho5Z0cpxZ3sU5hKgD9rooHFLuAH
	 EipNdCPBpP9+F48eRWlWdcCr9nFDq2lsMgZQRg1otBZdgnNTXAhnWmxUa44B05+wDO
	 JHlcO/fTSwZscdXjo6M0oPVhumbg0BVYrsoT+5KEIa6rluHu+qbMaEzOQD+VFbM2qF
	 bBcJVZmvCzFkOqhmpzu8fjEvjQIFgogHSda+czC25wgMwAVT401d1mGJpfqmMPZJOv
	 GgZfRLnbVb9PA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 7.3.y 0/9] io_uring fixes for 7.3-stable
Date: Sat, 21 Nov 2026 22:38:54 -0500
Message-ID: <2026-11-21-2-daily-reply-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121213154.1790334-1-axboe@kernel.dk>
References: <20261121213154.1790334-1-axboe@kernel.dk>
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

> Here are io_uring fixes for 7.3-stable. All 9 patches are in Linus's
> tree.

Queued the series for 7.3, thanks.

-- 
Thanks,
Sasha
