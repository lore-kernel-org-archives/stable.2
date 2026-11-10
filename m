Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344393;
	b=IVKYEbLH6ibhQxOt2FM9yjqkny1BRsLnmrYiOFt9LM0qVwbyRATT1kieAbkFy6lc7GL3
	 4RoFA3mFYbaWy5Mj0Nj83+OR7/gEIWBOQadbbahOTgFZyEQ/scRPoNT2WU/8Jyx8OOSzR
	 SycJrvjmH5f4M+oZyBcAKW5e5xBLZ6T9NaR1Iq2mQgFmV3m6n8ce5R5OGHsPtL5n/vqEi
	 CLEh6IYx7hAKWxG9sMhJKUT1ZK8XtqtGmK9SCtF4Xqu2sQOFLH1Dn6HlypQRLDqHkChnL
	 dD4l00Z92pDDf4HYblRLueL8fLJ5/AhH/ZyMkrilS2Dj/QCBPTOmc4FUuU5fOt+5BjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344393;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X1ylnwG/Yogv4XwV+Jv6l82tgyhHyXHd4wzO6nNbX9c=;
	b=upQBXlCkqJjNpu8buC5pybujAOJ2opci3ENjxx2N1LAo2pPHGsRrgZLCDbwvQsaAAG4M
	 CXt1kv3ccm7en195gBAXZwgSQ1Je/V4Qh6KfTKlkeMpTZ44iJLlnF5fT3+S6ui4ZpOmO2
	 LkLnTXbKPsU6ISTTtoJaGYLpyr3uMpuNuRN0ex3hSPbpo/uKQ39g1fOGkPTq8Fdrhydzc
	 xYY3dmEI9x1CET+aOJEAdCKi+It8L2KfuN+59yvj5U/7u+sBiEsKjoGDZww15mJUC5mwg
	 u9kwQ8RmFooCksrlXBI3z1VKGXPR6junfOK+HS+LEJgJyZzDyt/fRAuP/11w4ceV2aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H14wGTRS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5160A2601
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H14wGTRS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5B61F0089F;
	Tue, 10 Nov 2026 20:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344392;
	bh=X1ylnwG/Yogv4XwV+Jv6l82tgyhHyXHd4wzO6nNbX9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H14wGTRSXZrPw4uPRvdKcCOuLqqLDxqP5EKED71DCcDfP7aezpjffMhUhsVc1RZ19
	 DYdfX/3vySd0gZHPs3FC+vrJgMH/hemGK2igNCeqWbYZwnp+v98jOPguq2ZUCAtS4J
	 jJTI6VM/UqHrAb+EZt8/2PMWiocN2MvWJcYfoD9+DnvYdsFWkA6JdUCRuajOm2d80W
	 6HukhYBTU1qciR76RiqBMKSPvbFDfEcLxfNV81Ta9IB3dVlpl2FkfaLqcTJnBYQ0J4
	 NSojkwyIm4BPAjX+anSVcws9pIeydcGNLri25Jkth00dZ4ilCLThbiU/8BqmdhRP/2
	 BtoOvLb7vMYbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 7.3.y] batman-adv: tt: only update flags for TT events
Date: Tue, 10 Nov 2026 15:59:16 -0500
Message-ID: <2026-11-10-1-daily-reply-0020-batman-tt-flags@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110184331.44718-1-sven@narfation.org>
References: <20261110184331.44718-1-sven@narfation.org>
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

> batman-adv: tt: only update flags for TT events

Queued for 7.3 and 6.18, thanks.

-- 
Thanks,
Sasha
