Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50E31D75E
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861541; cv=none; b=b365JgJJ3PDTW/iUmaNrckjbAbN5gtto6ar6pBHnqWaXiiMa4qL/LkK2n0yFdWvXKPMBO4DoKfMolhq2wpAysXtfVCQWdVR4V94Rf0jNwV5hU6sIreHn0kosd7+HdO+N7D/+PqWYNpBDWkBT3AamgteBaU9yxcu6X5+Mviu8cAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861541; c=relaxed/simple;
	bh=tCCyScGg5zLktCv4/vu7dP7DFr0mxGEvVB09IMqHG0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjMAVHzxsYQcmR1usrRsdSTmMjfhpt5nPLcE/lPT1BsWSbWTht+5S08daRJGqiapUc9EEDCU7VyXHRK4rIMyd7KFcfYH+9czOtzqEnA61rpch0GJ8bGP834vljHyk4ct7LXOdPJIQstaBPDR7L/UU5Ev5iyAOgpt02rFXDY/+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dWusZkfM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dWusZkfM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b64c8311so40676045e9.3
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1780861538; x=1781466338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHoXjXG0dor552NQWwgbrAyEMhGxFl2juanAjE9YOn4=;
        b=dWusZkfM+ulTaKZBfK7z4yuUr/U3b+ZaqJkwseALK2XSYxXJbK88qqwXnpQTfPCkrY
         4GcP5iPj4+ZYOFwre43T4HtphBvclZUHW7hReQjstVFGNBDYZSdHINCTAmeewXwX9gJ/
         SpbSVavjgh0xolq92yWpkg69VN1XbwRU5AZ93dHnX8YTV1mirxeJMV1fiYzyY0WiKGF5
         ktRYMyjntftRC+sRuRBUlc18g5t5y2s+DXc5HukMrM/Wj7wE5MGs3clTMs7wyXtLyt9w
         0ILC67uZqih74tKG5dHfdnoBbuyYRiBH8Ie8MUAMWtuPTevdD30PVzXmgnkIMvcrp6B5
         0M+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780861538; x=1781466338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHoXjXG0dor552NQWwgbrAyEMhGxFl2juanAjE9YOn4=;
        b=IMoz2SZd77RKa7ah5WsReddi7pF0N3qaQBHW6idwymBagsbo0H53zYm4KJ4cvZjg85
         zkvezKduDTPs0NIPuB0J5SGRm+ObVMZ7rUbSbGve0++GUbEYUX+CKdRCWYBJI83MXAa1
         5awaqTSPJCMj4H7W6cXwOpDipZk/BcpHXM1G4ch7ezkZVEt+SJCdv9Vys5tZ7Stcda44
         iUs33oTtlDlZ3Qy1GWMRzhU8wdfASL7ELjcUcTBwZKJVM/j7RoNTbMMe5/Wnr+jZLe7Y
         R0BD/1rXOJ105eVDZNyb0tSjRh+mYvuzaIcGBImHa0jqGVxMh5P0w1NT9fPQgUduuCm9
         UYEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RAe8uO+lpCICBg4vz8TcdncUKnNjsmTgFT/AXWv0rIGrL4HXjP2WB4ObcoeMECxO/TVp5Oog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIYR9OTb/4UCjKAuARNBkkka9hlPNo1vKmEgMQNMkcRicwegD9
	e28p/VEqaORpLy2vydfH1yaoaaXjeqZRXsX8hqMTBlsO/yNX+KXa97o=
X-Gm-Gg: Acq92OHsSIgCyGm1NGnqMxJz5iaGssq1fWzlEzbqyAs1DN0xnzlM0KA7B9o4V9Hfs6X
	BDWnPwNoqsqQpUkrF5KIGuPSyGhpG1BzQYevaL1XznN4mkittBy04dVZgkRD3PufnEsU0WmE+Za
	cCSIWbTVyasL3dnYxwzdFE6huvpXr0pmB1bafZyr6qn/BQkunykeANooG26m9n9DQHlNQjZl7ji
	jzUpvNlw3EoSYsPtdBp1bHeJJHQGcdaPw92IsZQ1i52RmiZQ+m381J/dmSyCD+Bqt6fdYPNvy1a
	JJJqtIKVt+PQNJhEGSyQhpTY9W5U9TMRhjMe7dSAf0fBSpecidECygGnauWxKj164PY39wY+8Th
	w9loT9ZPraCjlAH+v90euteJgpvnc3FvIJM6xnva7trnMK/6+oUIruVewPfza7fNSDSVx36eJt3
	5Ld41bQSyg1nsqLwdkYoep8s3o7z9UgvdPvfN4HIcO7wIzJwLb/t4E97Ha+ht/ZP7zZ9EpXUmVF
	RGAWYpuNS0NKw==
X-Received: by 2002:a05:600c:3e83:b0:48f:f64c:c2fe with SMTP id 5b1f17b1804b1-490c25f1ac3mr206766775e9.22.1780861538381;
        Sun, 07 Jun 2026 12:45:38 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b48d7.dip0.t-ipconnect.de. [91.43.72.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm333640585e9.15.2026.06.07.12.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 12:45:38 -0700 (PDT)
Message-ID: <60bd06c4-be38-43a1-9375-faa890402dfd@googlemail.com>
Date: Sun, 7 Jun 2026 21:45:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260607095727.647295505@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.06.2026 um 11:56 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.93 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
