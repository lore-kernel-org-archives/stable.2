Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F524679C
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792275560; cv=none; b=K77GIMB7SeHHCJCc6p0YnP476hZCaaNUtk44p4nlLit0KX7gO0fYdhaOJpjuTnKZF4Te6Gnh9tT45EN65+XA1J/b5yWbUsF7+mSiPhxQAJthVxa+SzWzH5tWDHptOLjaThpeMCEpeqBD1hgK7Geue8gYfryaVGNNUM1DIDZq6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792275560; c=relaxed/simple;
	bh=fEZZqs/2ON9aIF0WA8+r/aO+iqtvUwUqKlBtjbwzNe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4GQy0Bj8epkVLqQ1dP6Wl1VMAMmJ2DAUkv74aZiDiiZD65xOoN/UcvJMbgjbg0nwnG7bRL3Iyn7RTSr3dxNdZktegmL/MfYWIaANmd/C1ejZaDvplYeeQGSXHPbaWv1effA1RPd5fmG9QRFh4shH6cAwiy+3p4Iozbk2SQHlRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SOWq4zZi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SOWq4zZi"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso6927985e9.2
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792275557; x=1792880357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1P3vBDxvZfLACU44clWpmAKjc22PaxwE3/MUdrEQfXA=;
        b=SOWq4zZi5+XauVKDDwNwGHJ0gsc44CwYFUiPNd3bouCqJST88O75zU+E/vlKYwHwoF
         CaTaCIgfFR/FPYBL09w7OqGtLsO2elsGJULKR5amUKr1jvcpwjGJabQmo3B8TTvSTsTR
         SpjY/MP2igKREEV9JdSniBPc+490ARMPcMicKZ7RrRSw742RP7ALtrwHBsPVHdwMUkM/
         JZUXNFUbqVY4+w4DxCMB5fc2olfo5xUx6PSOo0gTyZB2X5KwrGYo+g+BnAXG4X2X7QdF
         7WSdfyYSs0KHIBwnlp+n8cotdGzs989gMIK2VG/bFQQMowqwN3Nvme4sxUiju2dKHW3K
         Eq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792275557; x=1792880357;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1P3vBDxvZfLACU44clWpmAKjc22PaxwE3/MUdrEQfXA=;
        b=ey3f6YnDOCx3NfRSyQw0lKUnuVKf+cbxZkt2I4GT3wXUo3pdMCuwHUTRaSZgBkAYzf
         tGedyxc8fQxCbxKXEFO8qadO2i9Jvv1fx9NYvEgX6wklgfjaK8EdxfhZxqkZehbqB1lc
         uKWEW9yO5+tfFVa9wdA0wDnqJL7PrrIF2HfuXQH6z9mPGhN/Ig9mKoKEkQoV40AK693Q
         A8gNO4PlPVhdBc2PxmcIy8TSwyTQDpLeGtue/Qb9y2Vtp+nO+Y3K/qh4ZBaAC2MNxf23
         aVLvT3FqQMWt5nLY2t1A3FY/ubeaj2v0h0mzvpQs5ltXhUbMnWN8XMvbS+zo9Bw0BMLy
         fu6A==
X-Forwarded-Encrypted: i=1; AKwUvByX3qXFhudNXtWmjxAhzKAbmAI+oqHbNQ5TgnJ+R+atHoK7WBpFuYbDKwigKb2yWm2B0WTYz5w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEMzbbu0be+oCSRPUmqXNRYG6q5XcF+JD2tNVNfRDWISjW9zzW
	WXoTPytjCifeC4Y3xcMBK8GGH+hG5ND4DIO1+8glH41pU7MZNrbafCk=
X-Gm-Gg: AYBFou2IlzLdvhhKsR0eUK0f3Wwi6wWWOZh11Q++0zV1nfsuPjlw1JpJA9WJKI5pJrk
	EYkmpZJ7eOcEGDW+zPtQR2m3e703RBinLn44+V72EHNUKSBnSWfdQw/VXv19q9c+gcap9A5hr5g
	3xVJ1QSW0iBm+VQrF2fMHasp29GQpWz5ICD45QmffN3ZoFZK3klUzt2FG4vK/HCZAeqIJ2gW/7N
	U6K4NzZknrbLtWEID8J/+dddS0eFzBBgT9c9Jar3CdsjIsDQ1N7j24RO7SqmYOmofR5DbwuitoJ
	E93+cDt9Bs1YU+nqcASeJUQIj5fSnTqrisSqnvzmoetiYGOU7A3/XSB05srrJplZRYahOCABCOp
	uwi7jTo+sIMRKEZAgdsb0r6H1j4bUDrBUwoYqn9q7bRsI6WVOsPUjL3yz/WAjM48SL6EytNuz58
	guVeRuQQrP6tBefRk3m3TsX+toSo5arBY87mV4dB6QPdzQHv5qC9nuP7fmW79VSgcyvby+TGt7u
	BJCxdW+F5WJpVsD4intb+vZO1RJp5h+FUg0gJcsRpz1m1Ag
X-Received: by 2002:a05:600c:4595:b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-4a1d762168amr82215755e9.31.1792275557036;
        Sat, 17 Oct 2026 15:19:17 -0700 (PDT)
Received: from [192.168.1.3] (p5b057d26.dip0.t-ipconnect.de. [91.5.125.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd47104csm14989798f8f.8.2026.10.17.15.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 15:19:16 -0700 (PDT)
Message-ID: <65c9facc-377d-48b1-8d48-aebac14e8bbb@googlemail.com>
Date: Sun, 18 Oct 2026 00:19:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 00/52] 6.18.58-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261017155104.830766652@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261017155104.830766652@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.2026 um 17:54 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.58 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

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
