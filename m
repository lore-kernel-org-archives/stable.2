Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798964;
	b=URQD0kPiqd8bIhe8d6bUE1bOH71zcUajBGKBjjB4TTlCIfZ4jXbYCrJOVOuR4Ue6WwIc
	 2f+49NMyQA1kab8yUurBERiSa6ZPmaRMfvpUldCjupeL+VARyATSFOZ+GCkfzeo9/7gFz
	 bvNsSlNw+8FOJ0t6LEkNsTsV3PnIlXE9raK2RM/SoE1hzrgoVHBJxq2k/wp4+2F1uaDdk
	 Xot6Zhj06fnU7TF2u6ak+4NE4vsqyRu7I0DEXQTVrRwtOYyt0VOn8oAFMNvDz5Uiw9nLd
	 atsY+mGzcyh7bXQ5YRubhbk2Ysfz7+lsvHROwbsRTDiQMSa6UXP2Ycy+vYlkz/tg65g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798964;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vZgLo3eNhvq9//dSUJKuFlrBAQ5H8bL7vV67p+AmGWk=;
	b=ap01Dxoa6xOsJH+9L1ksSwSKsUcLGCFZVMAg6fayJ75tBtFYafQIpcyfAQRLhEhY4xeY
	 RCGop0a3V5wer4DQOn8+P+iZaLfNdTIWRNh+F1RpkMfRdySZC00HwbjeNeQnupgh4gOfF
	 ZiHCo9LJ/CUmkm+h+u2xngpb2X8zQjD1q9Ipf6WXTQcHU553wsnMCDuMfJGSOViqUp0bU
	 dyNTRTPfE3oyXKBtL3+vZKIAhb1l4TS3jLlMW8PxO6YzygHTHzLq6oJsFkIUNUcLHduZ8
	 sazDrbAylToFG23mzHpi8797uGma9cGUUVX8y0rij3d5q55D7GIIX1ewuijTv/wnRXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DP8NylO4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E8606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DP8NylO4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAF01F0089C;
	Fri, 27 Nov 2026 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798964;
	bh=vZgLo3eNhvq9//dSUJKuFlrBAQ5H8bL7vV67p+AmGWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DP8NylO4LP8u/9EDKseQnpH0CRGnMN1Aau5z3hkUUm1PHepaMm09TT+b8M5s5bd24
	 +ijxo5pSItoQxeM+T/LJNhL8F3zP+9W75hWlYhUbc+mkfquR7Myym6LewxI37CjwTv
	 TGjJF0nKiziFym6ZLgafUbYHjjC1y5KcCntk4QPlhMJsb/K6y4lnvStbnzQZhqd+67
	 IyKddb5cBaV9tD94IYmw6bfdbZ1qrtSrNB1Z+vOrFzKWJu1zdPfRVNnVE1bIrHlNcb
	 vUDQKt0mYimcaHnLxzXUYSCVUCu06FU2T1Vssb7AjalptYuIF4NusnlXj72A5UbcDw
	 CW5swfYIew6pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.15.y] hwmon: (scmi) Check channel config allocation
Date: Fri, 27 Nov 2026 12:01:29 -0500
Message-ID: <2026-11-26-1-daily-reply-0041@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125142943.3949509-1-sudeep.holla@kernel.org>
References: <20261125142943.3949509-1-sudeep.holla@kernel.org>
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

> scmi_hwmon_add_chan_info() can fail to allocate a channel's config
> array.

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
