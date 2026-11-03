Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717543;
	b=HarV9i71gD1EOBhksVC17rYrE2PbmXZiGyf8GV3LvZtsUlV8MbNk7EcLYX6pVxD7UbXb
	 ccJz0TBlJu0kac5UwQ1sDEz4ScS2xAuL/AoMgnnzxEcYYs9fCkQPKJarBqnkGSp1h0vfa
	 U6uBv0oZt3m0u2fXZuGU15zrr4LqOGiZiwws2R1y2HISt253mMVl5o3yPMvAb0OLe0/0K
	 gWqBfiot0HeLOPlTATs7+LgzjGUhRfcvkRIXEy912F3A/E5yAdozmr4YZgXzCiqWZKT8D
	 XCoRibLM3gZj3496Iyahtyyh/VJVYR257KiLiiI1rZAswjvta+5R6GNSlVaMZqaq4iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BTQhXryiFz6WNhtO/2cBLI/E9BKh5fzSCgT17OC2isQ=;
	b=svBHdNlchtg5WsVbdtmavTVYCUZx6/W/6oRdCEWRsyKeoYcH3u2nUQ3qgG0sUU3mQ0iw
	 Z/S7fQzfburmVk++YvZvJL0kcmCJGWxDBzckPUH2owRNtYL5hG/xqstJ+WC6cbDBsI200
	 2/SQfYmLCSsafCxdbsfl91qGSyQIf24d4ey4xwpoyOvjCm6fjG+GCnBpRQ5Ux5mAwKSwI
	 VajnsgsjM2S6eYBAvhYCCpM+iQp4+LdtMf2aw2TpFlStBazQ7NRDfYoaojEJIJlbyyQvL
	 qbs4nNccRKKbWsHe1BU6DruxCQaR26wJl1Xd3vcU1VGZGluDGc3A7GTKA2I7yo7UePg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YULUcOln;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5260A2624;
	Tue,  3 Nov 2026 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YULUcOln
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C1B1F00919;
	Tue,  3 Nov 2026 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717543;
	bh=BTQhXryiFz6WNhtO/2cBLI/E9BKh5fzSCgT17OC2isQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YULUcOlnU5estLQZ4jpKMFl1ZUufGXrceg4QR9QBHrz+KUXwTw5DarbaN4Sc24PtL
	 HD4NcxARddyrligJZ3EJ9NEpKUS/qyW2S+PZHSAOX4Nj0gQWUkELPABhufTZYCoj8m
	 L2n7AsCkjpMqXUjts2F/rlD6YbdxhC101ijSm/Y6yHsCIi6PaSX0JZJdBVG8zKsZ8H
	 4pVXOP/I7bY9uvJbjewxTMmgVsRJKwUb2BMiiIBBdMUltfAZ5yf3Dn/MoixNUj+KaI
	 9ReJ+RcCaxrkT1vR1SGJtOYZ9ldi3aC9jBpq38EDwdiEwELgjmCQCOubApelLUfMQP
	 58erdJ+VLWzSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Erik Brangs <erik.brangs@gmx.de>,
	benh@debian.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev,
	1149377@bugs.debian.org,
	Christoph Zwerschke <cito@online.de>
Subject: Re: [PATCH 6.12 1/2] Revert "Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU"
Date: Tue,  3 Nov 2026 09:51:57 -0500
Message-ID: <2026-11-03-1-daily-reply-0009-re-revert-asus-bt-rtl8761cu-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102153243.373899-1-cito@online.de>
References: <20261102153243.373899-1-cito@online.de>
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

> This reverts the ASUS USB-BT540/BT600 Realtek 8761CU ID backport.
>
> Mainline keeps the ID entry, so this revert is for 6.12.y only, as agreed
> in the regression thread.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
