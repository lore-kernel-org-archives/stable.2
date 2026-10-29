Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299438;
	b=zMzipDhYqhwAyrT6iF71Wghs/942Qf2qX/uIznqwNz3Zr2jVrlmAbgqE020+AnEgMHGa
	 LqZIkN67HQdcDydcB3XbPh4d+Ijmlt+1DZkyMMS5mOPj8FfRbUpNjZd/yiFp5bi67J/iM
	 /73sAh5IjC4GZm0lMv2Wfuz0wqI7408KQQlS08qLkVwqnKo3GwzXs8wGTs/8/QCnqeuES
	 ndiFeC/LcYJAdeR2kAYO6gH7EtvZTRjcLeM4U4Pa/KBAGBeASGgC55SwZrgJAt2uncXqI
	 SfYm2KjjGQBsbuRjaDknipqezRZUscSIaC75d5RYh1+ruBkHZQA8+ucbytPWlrqmc5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299438;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Rvn24u2XelRIBkEMiPRzx2kxygTTc2LAl/uofGJZDiM=;
	b=ctcogModCx9ViWcaWEz7r/CskzqlJgKVYNtPr9wDLYc8qSZaW1qhSm3uNfQoW89K0ysb
	 KOWQVHaoPYrYt2fkF664xOv+WlbhcrUQa/fnersqKhXWJaAwuIDr3YJMMmBSN0LuPaPNM
	 ah9wKZ9cH55FG9jE34pqgXazhvEA/0aHsVQULunK4zB5YqMRvROVe4wzCSR2q5spJ+eKp
	 vsoSXlaQJfCe0xruZVeLWeu08pG8WVYPwwzxIHXyIKLSaNZUNS2IDgLypmR/qIvixKRyP
	 su53J9bJ/8bcH7OY9yG6SxnxkOquD4ZorndpGATUHPIqjTAzzTBISuI8WAEKNAI5VZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+9D68on;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72EC60A2626
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+9D68on
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28E11F01285;
	Thu, 29 Oct 2026 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299437;
	bh=Rvn24u2XelRIBkEMiPRzx2kxygTTc2LAl/uofGJZDiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H+9D68onI5RgIunqkgQnCDDDZ/H2YnKNdd/nbrt0LtEz8ponD5ay6RDMYedIKvE+0
	 81psAxQDZTolhDak3sI7eMR5IWZf0fcRKBHAj3Y2esVRZHLuoLqClkUAoBEw7NGNhv
	 ZtF4hwHBi7p/CxY4a1lEsoEkExy0OQb3l3pDEh8pzg7CULUtePD9UKIMHNGQj7ltPK
	 VtU5U+QPpFVPszghgeOUGveXTVV6J5/qpjpRoAm7ilCtjra2MJ4rl0pzQciOOFUpXj
	 AwpMVJkGC/jtxXbnDkSOUgqYNo66oTre4UtUn8f1YtVJLARxy/mX9UY5TlmX3zR3CQ
	 NychOLng0x8vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ridham Khurana <khurana.ridham222@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>
Subject: Re: Request: 59797443846b ("platform: cznic: turris-omnia-mcu: Add missing MODULE_DEVICE_TABLE()")
Date: Thu, 29 Oct 2026 14:43:27 -0400
Message-ID: <2026-10-29-1-daily-reply-0020-turris-omnia-mcu-module-device-table@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029004521.48885-1-pepe.schlehofer@gmail.com>
References: <20261029004521.48885-1-pepe.schlehofer@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> please apply this mainline commit to 6.12.y, 6.18.y and 7.2.y:
>
>   59797443846b ("platform: cznic: turris-omnia-mcu: Add missing MODULE_DEVICE_TABLE()")

Queued for 7.3, 7.2, 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
