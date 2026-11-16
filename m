Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794788468;
	b=aRJrktzaXLPKCc094MEnrnXLEl0M3zBbqWv84CRz7J78PWt+5hNv3hqRcIbrS0M38IDV
	 C5Zg2rovmjrlDaw/HZ/MqCY6tMxaFCbr5k/Qg7xWoUZuvzFHKY/xn02eFFKj3cOQ8L0jr
	 J0iAmp05iHEuNC9LzGvoFoxIbZxx6s9cC6qL+IG4BfoOy7P9WE2OaVrzf3v5//8kZK5d3
	 jVp8/pjcE/WjnX9UNjtZdff30NhWbU+uqMPxYU4q91KUnHyXlVFe3JGWYU8/nl6fPPi4s
	 W4464RxM0q2ynowKRvLxI0UzObKqLaa/0AO9JZd9Q2AkWZbSGmZy/ZwAsT1sOY8QVOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794788468;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=NmXdBQ9lr42Z7OVmrM2QJ4TG6Mnh9mUojEikNRSpg+k=;
	b=c4MZkiWsKVCsBgAmb54RGVL1c3QDgasxitqwPhuqcmcjk92UtBR1nEkDKhrl5YDy0QCO
	 xQxUx7q9nh0GdzSEsghWp9z62iCHUisbL0HFJ4WS1UKlqbbiYRLaV0yjypvt35VPFBScF
	 JbEz9kCKp5ocV/MOCZojcx2Cgb9RqG628Lr23fI0Jo732OjX5XVREeKYYIhF6ARRBfrRo
	 YMFfLP8xIuqoWNBLcMJKWYOdAcx65snQ2ovEo9QVLLEq6NxLTaN9pbEoOQWZatFhQY8Lm
	 xaVNUH0Yqsvf4HReHkbrTAZWpniAHzD5aDhGA0vFn7pSsmA03IjqhcaGT5doYCSsxMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392E606A31F;
	Mon, 16 Nov 2026 00:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E771F000C4;
	Mon, 16 Nov 2026 00:21:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 7C080181BF9; Mon, 16 Nov 2026 01:21:05 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, raoxu <raoxu@uniontech.com>
Cc: linusw@kernel.org, robh@kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <91858196CE770E42+20261110055021.263296-1-raoxu@uniontech.com>
References: <91858196CE770E42+20261110055021.263296-1-raoxu@uniontech.com>
Subject: Re: [PATCH] power: supply: gpio-charger: Keep properties per
 device
Message-Id: <179478846548.237582.1838176915808832831.b4-ty@b4>
Date: Mon, 16 Nov 2026 01:21:05 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Tue, 10 Nov 2026 13:50:21 +0800, raoxu wrote:
> gpio_charger_properties is a global array that is overwritten during
> each device probe according to the optional GPIO features present on
> that device. When more than one gpio-charger is registered, a later
> probe can therefore change the property list referenced by an already
> registered power supply.
> 
> Store the property array in struct gpio_charger so each power supply
> keeps the property list built for its own device.
> 
> [...]

Applied, thanks!

[1/1] power: supply: gpio-charger: Keep properties per device
      commit: fad4655224f60328cc9bcf4399eda8f6d7a587a6

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

