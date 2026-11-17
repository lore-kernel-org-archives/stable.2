Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877393;
	b=h7JB0K8Icp3B1R3OXh/8eOw3TFba3VMARzly8GfJaDD9DQfSzAOZxR/poWRQMRdlrT+K
	 NVs1X9KBeBnjjYXKUhngKnrx+c6difEZmt/xlyBGBYo6z4JNmvu4KQmNEG7CL7HE6AwUX
	 jUrj36LHiZdx2QIjFPu0i7EkjJCHQcvMYljjXM6AuEEp/Nr05M0MS0NawHnXC8e6+PGhn
	 Ee6fAjHufTeXGKdVBP/TpJQ7qJuw44jqTUvhdTpPisXqvIDTzctx1utMRqJqOrZtjfigV
	 +Q7HivXjqOKkfWc73PN7n4TN9466E/na8bZgQSIeICqzlzP8USSMg+nPkYAGmhMaV2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877393;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IkLOL1iRy5qWErpm6MEixAZQiSaXq0SRmRzvuNa5Z34=;
	b=kwTGSUFrxdVnxjPxc8NKT03bIY8VXHrhdb4w59DzJHgQc/nh4aW0pZze5il9TMcJCT2y
	 53nerNlOU+wwrr1h60ZTVMjhTj17PINLn7bLJWRSgIVr9L0iaeimDEp8NJFP1yVF76zFD
	 qoe4fY+hB4EFCA2C55u69t9t2c8UKfWNQqGnM/86REmsjmjMCU0GyweCsTVgqrNgE4qoy
	 v8ylFo515vNMrlLWTbM4u+oS/WkJZIg1XI+2Mc4UKRXq9yMjoASGyyArKNVgWotk5AeBC
	 A7hu5bcvcy+BZL5jiNH8lNjq5Vf3xw7M3t8cx7uXCWaQzJuCEL2EIBBskz1q1QV+HoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="azB/03y/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5FB606A323;
	Tue, 17 Nov 2026 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azB/03y/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E391F000C6;
	Tue, 17 Nov 2026 01:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794877393;
	bh=IkLOL1iRy5qWErpm6MEixAZQiSaXq0SRmRzvuNa5Z34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=azB/03y/fCAxkH8UZxAPtksJvAmuUVP+eghieKvlR3GIo4prpGdXU6/GwhDi5cy5L
	 nYMEymqJp/L8vHRBNdtGK42CVAvKIzKW4KAtr7RYvMm+3pSXEub86AbMNJVIN0dEMM
	 6D8U+blDFMbfyqFHQ41CuoYqvC6XC2XYs8Qi/EYHaAV22E43WtbtRLFaimuB+YaJLy
	 IZclyeaLdiNTY5WXYu9iGWoEZC2DEiPA1OgwwwwhYJ2yG3Fkrp2BBbr0bRUFYNrnUF
	 PmG7Fzh3lbRBeD0q27RyffsA59BUHh51HLAr8tHXRK91Dk8Jbh6tCBvtp2p7843aUb
	 kIcM9QryflnNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	netdev@vger.kernel.org,
	Imre Kaloz <kaloz@kernel.org>
Subject: Re: Request for 6.12.y: r8169 RTL8126 ALDPS fix 4af2f60bf737
Date: Mon, 16 Nov 2026 20:03:03 -0500
Message-ID: <2026-11-16-2-daily-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <603215d0-9331-40db-95ec-5742146a1cf1@app.fastmail.com>
References: <603215d0-9331-40db-95ec-5742146a1cf1@app.fastmail.com>
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

> Please apply to 6.12.y:
>
>   commit 4af2f60bf7378bd5c92b15a528d8c6c7d02bed6c
>   r8169: align RTL8125/RTL8126 PHY config with vendor driver

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
