Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479122;
	b=Tam8yGw7LSQVwKkJbcPMKnlugvHDjlrw2CoKp+PGuKfEQp3hygBwB5XqXmZSrf61XkLu
	 ZruE6cIR3/ktCza+2+9Vkhs8W1OabCGHOUCBf0EVB2QOPlXrH3lQJvhK+MEciIOVyyTV2
	 ZOINwDI1q9dSr/iug3txCzQYAE1nwfTN3pPrb50D7ri1TLf3nXQb3t7gTP0JrYDe3s9yg
	 AK3mmJDLOh8veKNUyjdGm2pFKvDxOvzdya0Hz8aa/HSKQLao8254zBKw69CiPJzfC0fZd
	 luANFO2jP0rDJommYeZq8QtoWAZnIKnc5G/VIqxASKXzPMtEaJ2IlVXggmw+kR5KtjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479122;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qq1EtUeJPfVRhMT84eKDN171V3V7kRLXUYB0WvPhq6M=;
	b=2Pnp7WNbGh5BuhReXZ4vK6ONcgRQ4U+9/mR43/lSxTsHfp6tN3yuxZySblL/14qniivb
	 rX3dry+M5ZmlIlOHZsSIaJ/fy/DYn3DOqmUcqd3/lj0qjJXBZRzLQUTfrEh9S2ZD5o37K
	 U3t5jxComKMtMK7r336YdKwaV8t5ESg1Ay76OjHVUZGSut1SLfn0DMTeCyONCeJF1TefD
	 DjZlHGbuoKhUerryciUBUwXXn3sNgt0lvpMI0lkXnFXm3oaBDBIANt3jVWU3CuzJcJN5k
	 3uDdq49nOyMepBfBTcQOKw2LuFmq2EIYt7hNW8e10Pi6TQ4HuGSbLLZr9d/5nCDF4PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWh4CObp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABCC606A33C;
	Tue, 24 Nov 2026 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWh4CObp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73361F000E1;
	Tue, 24 Nov 2026 00:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479121;
	bh=Qq1EtUeJPfVRhMT84eKDN171V3V7kRLXUYB0WvPhq6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OWh4CObplpShzOP4Be/nEZ/tHo2VALingRFb7v0TubmQ4tAhjH+SLYcMGaXuCz51k
	 AZoaCSCdxiqwBeTTnuzndOHU29KZAWsm8Jqw3TkmDpvD+rNq17Zz+oZS+DcpVlJT4r
	 14yjdcbX9tmmq9v09vD4Y5nO6hBiwJ3zsl8YwStosawq2VYrcja8QiTnr/1KzswrD4
	 H1FAXE5rHg641pRujzV9FKWlDJ7fBoE7fXlLLzESlougbCWHAQbkfQedw1VRO+La5H
	 jU+8WDDvejG1immlE4zgk3N9PYji79aIMDmN/grm7MfDvyQFcxCr0O9PAyt+Fd0JmL
	 58v6ggf2rlUYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Nick Venenga <nick@venenga.com>,
	linux-wireless@vger.kernel.org,
	Josef Schlehofer <pepe.schlehofer@gmail.com>
Subject: Re: rtw89 USB: crash fix and RTL8922AU IDs for 7.3.y
Date: Mon, 23 Nov 2026 19:11:49 -0500
Message-ID: <2026-11-23-1-daily-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122132329.52933-1-pepe.schlehofer@gmail.com>
References: <20261122132329.52933-1-pepe.schlehofer@gmail.com>
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

> please consider these upstream commits for 7.3.y:
>
> b1827227176821af9bba0cb643728d23328f3660 wifi: rtw89: usb: Avoid crash with dynamically added device ID
> de2cb461456143a69845c24ce38ac14a61d6e166 wifi: rtw89: 8922au: Add support for TP-Link TBE400U
> 475539db19530b7e134f58555e1afcae21d419f3 wifi: rtw89: 8922au: add ASUS BE93

[...]

> I will send a backport of the first one for 6.18.y, where the RTL8922AU
> driver does not exist.

Queued all three for 7.3, and your backport of the first one for 6.18,
thanks.

-- 
Thanks,
Sasha
