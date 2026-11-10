Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344396;
	b=x917mF2Cso11BZpYuc7oxeUjLY3IJjHt+7ABmeVDy6iMGIHbtYCU3LSjTfBo5J3igavO
	 8MlVmjk7rQbWFyXDbG0EIDczSs80cZt2PhIsiBbQsih/O4Wev1z1B8hZxdGVVLtREt2Cc
	 s4xD7e4Ai27PYzW/aXGmp1UA3p5DCWaRYiVRRqJU3Gvf1n0j4GD6Mx4ibBW7B8Vm00vHf
	 taKGCUbbiMNLXxQrzgONF2xNRh6RaeDMxOpMPTEH1v1kef703RkKyPuIZM7QoMOgYUdqn
	 IChFZPuwUEp22Jxv0pySu/TMgfFx/EM5ohLn4S09wKM+hrQHtlkfwpYuAXls1zq/SNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344396;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NiXFBUDkrhnXInvPJuYiyM/mBn/ycge7uV7NU/Qm4Qo=;
	b=Qwnbt0mPGKZJKM3o/4Jle6NhJnd+ssNZgRtJI43QcrvvwRwM5sSxgiFraagE+G7RzpC7
	 EesEx/gRuu5soldyKDse3ssxkHFxBNkic73U9tJywVmhW6M+uXrPIcS10FZkpp0BTXccy
	 VE+xf7QFQsFp/kyVArVJwSIRakIi0t3ZNVw5U/V8qjgeeYeRo2Atj9N/rVb0HF5E3xwt4
	 I7ZH2/8jaaxhmW3nvzHZrJV13F+ymSdVeHxtpsyCNzMLGZa66OBYnOiy6Ff62BdnB7cti
	 KCsJtW+3hRDRRdNnLC96lTBKX7ryv1tOCH9+cVkCbFUPANzRIuXhJo9RFGmew2WMgzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZLQjmU/J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D40606A33A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLQjmU/J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F961F0089F;
	Tue, 10 Nov 2026 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344395;
	bh=NiXFBUDkrhnXInvPJuYiyM/mBn/ycge7uV7NU/Qm4Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLQjmU/J945ecQ1A4i05HOXyTmrEVi9jNzMmMYy3nXn+FuH+yRztJ6rcuLXSUv/Of
	 H7nd+uOefAvHg54XIMJ8fNEGDDTKtR7Ld9vY0Sf1egoaIQVg/HVxh6oRft1tGtPKpb
	 fi2brPq3ZzZJwtHhX6iQ6e+156AQgKyvyV8Oj/qvz1xqu7ntp89kpoq8pbWW/yXVLA
	 LNifYoxAwZRqB9MjynRCf/lEHlgSRZRi4tVr6Qc6EEcbaw74/3TUYfONO8irMo9OgA
	 25fxe3+qlk7PNRBXYC6H6UQgaqtFy2proAvRb2xH35ywcQkmzdBhqBb0RUCaSLA6e9
	 vJhQdW+RQn3+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.18.y] batman-adv: tpmeter: fix u32 truncation of reported bytes
Date: Tue, 10 Nov 2026 15:59:20 -0500
Message-ID: <2026-11-10-1-daily-reply-0024-batman-tpmeter@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110184913.70492-1-sven@narfation.org>
References: <20261110184913.70492-1-sven@narfation.org>
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

> batman-adv: tpmeter: fix u32 truncation of reported bytes

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
