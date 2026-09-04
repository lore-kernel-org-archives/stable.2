Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40823A8734
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490398; cv=none; b=hh2BWPqsWWHt25LT15m8ClE7Tvre3P6ys3odNqflusDXdae8cMtk5b2jvv7LXK3IHa1IZ8R8aRv40Nt/4WHt3UzcoraQ+EfvUkgau38uGB1F52ysWtAZV6N0gV66fkMgxg1VAEunojCSuwFwcubbrmxzKnIcDdsW63t9WVkzi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490398; c=relaxed/simple;
	bh=iH7c11Iik0+LwLNOxk3QEc4StimJ3RZPYToGfowTYqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJuv8WRRcAdnVeuqgXsKgiqVOZsfNhka00qwdMchNlkQflbTZAast/RayIvEXOK6NwJwz8iRLeEeb3L/YTzYqIO/gWSNG+/i9t7es44qvDcAOYwbcEJAIKZX/2zB9UqfIEMbyzQK/ek9uusAmWX9NXqKm1W2OdkY2UEIvjAsNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCvbo2iF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCvbo2iF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43231F00A3D;
	Fri,  4 Sep 2026 02:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490397;
	bh=rdrGBdDtGqiuJqmfbTt6v19rZqcRBq9i85qhkArqQj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bCvbo2iF/jIcEk01Omv4u72+refouACqyCnHUYhRjWoUMRoG/JwmQZgRspSY+JcEY
	 uBg+ck6gCB5C3sIx9KFLdip6MmSEUGScAaVxnAprRz6k9ZNdtjlhMiYb7ZrVJIgWBN
	 2/LAgJ1ygtidyZbYsIbtHqVSil43D3f9TjGZcW7NSMkXROtOOQppBWH2zGl9u/M0wE
	 Izxwy3etYDrNPfZF47hZPVSCi9tpq2NDLRufVpUbmH7vvnQ7BcOzf8hCpdMDbM/WV6
	 TXUzjzFPBuDPV0ha7x9BWuYUmLYYgQBg9WvhmH1NelE9X5szN0bnhn82yK0tSDgUK9
	 Js458nnKR3Kww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Gary Guo <gary@garyguo.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 7.2.y] rust: num: reject Bounded::shr overshifts at build time
Date: Thu,  3 Sep 2026 22:52:53 -0400
Message-ID: <20260903-daily-reply-0001-re-rust-bounded-shr-7.2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903110133.87260-1-ojeda@kernel.org>
References: <20260903110133.87260-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Make `shr` reject shifts of at least the type's bit width at build
> time, instead of panicking or masking the shift amount at runtime.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
