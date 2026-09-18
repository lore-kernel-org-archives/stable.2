Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABE73DB328
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720651; cv=none; b=C0DgK0oTHHT3tWZDLpNUECjhcObRoX20I+gEzhOayaGhKe4qAUQ3IKyPBJYGgMaQnFYBdAzPT6L5nSBFCF5ZFS+WmrpqzX7qv/Nqoak+rPOn2Fpg5hWBeDrksTN9mjkjjsPEY2eJkt3qZmXOtZX69MwZoBC7+v2zzxNcddevccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720651; c=relaxed/simple;
	bh=Uxr4WVyD/DNS/detS6ug+v7NOvEjI5JJaJV4V+VWxsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpllaAOKsYYxu2B/uOQ86v6S2n9Wtagrwri9Z/wsaSfb5uvGfvuFkmYq7upsi1tLpe66OV8pEffAE1TZNSQXJLlhP4iQr6lp6LMVJmhRSBTCWCDaKzot/Q5DZIHXkdG/H0sosyGNWkpDzEWoHHx741au9T9ItcoKABpNfSqI3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sUyKAVm5; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUyKAVm5"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so87520566b.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789720648; x=1790325448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EsGHbbePiTbUM57NiqY/i+2M/82wdnf8yfJzQr85VmA=;
        b=sUyKAVm5UpfIhhx75ErJhS6MhdSrfjRXsde0yBrmtZLPEhSOoZwsTSeg2sPetwzmSS
         zFDuCjaOq2pfNyh0hC1OWHKqPxYyh5Jf53eCycmrOTuDBreFIljsoVmr98FFBpKBftkE
         dVPzK2Jg0MCAGFcU+cL7kYUvP5E3Re9QxSNA9+P/F4yo5GK53Up9tnhah2OpIna1ZYRX
         JthbQcFArVC/Pmnc+4ANRjvUekvp65CzP1/3xVZfjXTG85PrTvTmuv6Me7DfQYG3g1S+
         uXZKj+0eHTvrTYK0NSI0RAkp7P4GsNJNjunmdrh78Gw51scMd6otBM+8jYoCBR08b1yL
         qXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789720648; x=1790325448;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EsGHbbePiTbUM57NiqY/i+2M/82wdnf8yfJzQr85VmA=;
        b=qAG99D6RJu+yPA7Oq4E9pqgOhqI/Xe5dZGZduJbPXI72UVGX6nb9J9WehS2knd52p1
         rEzRO6CvY0PgpVEUhEKNamfsu5JGXpRGHHfT18axgTWuxloD73wzCXpavpviC0HIlUIh
         ta5S39zcBrY9rfvQQmFsIIrL6o3Xz5Kl2pQI9WuPegSDeW4DpCZB3S0LdpUKsBFZ9K9B
         3DurdwbyNoVGOMqiqWNT2nkcMdo7rT8wgQ4fX/Hr7xo7sgkPmz7z2MNgbm2VVmafkgSI
         Ewz0v+fphmAR3H0imsR0eSAD7Np0zAfamC3BTQ0BCEZ1xKWxZjjJLgJV+fVCktSJA5hI
         guzQ==
X-Forwarded-Encrypted: i=1; AKwUvBywcARl7ihiMbRhuGnM8TP4++H2BNhsh8Sr5k11O9Woe0V3IapwlUNl8mVW5mpuNdqTi7aSPOk=@vger.kernel.org
X-Gm-Message-State: AFuF++ngK3o+kWBou1Bdvj7+b1XFpqLoPpgsx1hySg8vexUbTH7QZ+h1
	8AfhoUDN6v+yOldptmgxfNM+VVfSwrTle+NhHD84t+D3kcxHTE0chXPbUucTeYiLF3g=
X-Gm-Gg: AYBFou0nbcnhK/lNAwXAfkj8AgYuhrhQ37gIpfuPvxJrxS9g5OnotGnx2YdSrUpaXIX
	WHcIAxUUPXIRQw7Mi+idpiJ2UttA+q3GrkRPaVlPs4j+oZr9d6iISSsTgkh3lhPgOZS0Fg3OuS1
	3vZd7WK6ZDT1cMortqS+n9IkNdKw4yESd3ysMGM+rpQsWeCXJvAi/7JDWhY8tlyJ8Z4gNhMXKLJ
	BBbj6sN6I/asq1N8SpxGsVcBjaYmRAriAESkSV2xY8EuQZ/6fYXBzTJnA9s+MyeP0dOl8RjqnON
	gH6L+aYtT7F/cTKbS4pxashEZhO91C2JSoLhgXfih8zOIqTg6mCwobKHXvWQeve8cFC6WaE54Cd
	lYTPGGWTIX2zV3wxrxPlEKRMMx42I3oJrZrRYZT+880OBZg7QkCrXgNhGWBJfYBYAJn0hlD2u5+
	RKlbJoliZa7kq6BPH3h5gvGyY0mP4j1bibk++lkWf3U4EKqqxP3u3GRpenD3cHsUvo/zGg82fyf
	BtU5HWs2w==
X-Received: by 2002:a17:907:1c1b:b0:c25:62db:772b with SMTP id a640c23a62f3a-c2a15846850mr191330566b.7.1789720648074;
        Fri, 18 Sep 2026 01:37:28 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.4.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bbc6a06sm32784166b.53.2026.09.18.01.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 01:37:27 -0700 (PDT)
Message-ID: <70284db7-a7d9-48a6-acdd-7a9850cdc7e4@linaro.org>
Date: Fri, 18 Sep 2026 09:37:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 0/5] Add phy_get_by_of_node and devm helper
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bryan O'Donoghue <bod@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
References: <20260917-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v19-0-21ad8a76e941@linaro.org>
 <cqoquu7hzclx54km763745dupaxahv7y4xbzq7vxg23isptgqz@j6los24mhnnn>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <cqoquu7hzclx54km763745dupaxahv7y4xbzq7vxg23isptgqz@j6los24mhnnn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/09/2026 02:36, Manivannan Sadhasivam wrote:
> Looks like you completely missed all my comments given in v17 :/
> 
> - Mani

oops so I did, my apologies Mani, I will take those in now.

---
bod
