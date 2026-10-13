Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457152D2DC
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926589; cv=none; b=f9/SNVbbpXpARyF+gdux4mDx+oOi3Eve2q8UtT6H8+xrvW0/KqTd8ZGcuilvtfPCTNnW4k2ovQLtlgUUBpYZhAWTtQ80m6/kq1ReDE66v9FIBytAveK3ijbFMsWOY0KlUudPDU4LE/GGxrpbZuYUFNOS5VMPsioTF6pXbtoCKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926589; c=relaxed/simple;
	bh=yiESBERC+Xl3L7/FsxOPHfK5bIOLCgd7G0wZyXxK1mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfA9sSJtOEgsesn8DaH+mBaZAZUjlsv8ajSN0aIK8zOmSWltrvcG/reViUZSsVJkj8GVIGhkubgyDGwmv5bBNI+NzBm90ubFcq59q6LdScU56jAJH73lGghTZjFLqTswc+i3ReLMZY974JcirS8253veGLzPN1/RwYwp+m2RaJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FiF4LpHU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FiF4LpHU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so29702805e9.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1791926582; x=1792531382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNr9QrvvLJoXy24Y9C0L722O7ExNexOvKEg2BEzpUi0=;
        b=FiF4LpHUWTc7u89iIkiTPgfMImLvX7iKSW8Lj45AdTsCMpEOu7S0Qw4/+iRaDiNuJn
         UNEQwVuLtxeRaVn51aqyQBYONkrFw7bC7mhtLWbnMK5eoUEs5kdr5Rwc9oifFOvh8hOI
         b5Z8sSb3EyZ0qis79oCnYsxKcli80Vpflixt3xYWRqOqmJJGckqIXjEIHLygNyuQDFeq
         IB0nmMMkd4XrDLq7d2iqz8w5eNxGHFA1ub6+fCaeQUEXJKJoCPYTFzJFxRvg4uLJ6KE4
         Fv0qopsINOJbGAh9ruO/huvBEqRbt0EjkvXXp+0nw4ZCwc4AwbfpzJmRoOVgYRnwMctw
         KpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791926582; x=1792531382;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNr9QrvvLJoXy24Y9C0L722O7ExNexOvKEg2BEzpUi0=;
        b=ucANnuntZ66x10DC61PyQHsQ4eHkP7t5de+FxahAZLTsh1uswDlfyFwCaFGKTDpQU4
         34fc0+Uwcd9j472CtlK+tvd0KSH1ox04B2Mh6r1ntHuwAY+Tiy3UE84yfz0+Gt5PDGYp
         JEe7YSBJuLzJpB0dvOyssWxQ97Pzx5eegn5FG24V9ydsdP45Uu5Wrv8Iru+YNf3GUmF6
         TGhGRSGnF5+QZhSDPLI5giF26A1yKWhQEFzIZwga+SQ+dSALI4VMeBaB3aLX+66bkx7y
         v11AVdJZYI8v6CdOZ+P5I6sOyC4icmACPjd8vojSB8z7VpsJzkB38m0AzLF6Vd8czHAZ
         NtiA==
X-Forwarded-Encrypted: i=1; AKwUvBz2AAHy7AP+qpZgbFhYhipIuZ2d0CBYs2lz/TgqFBc4Oy5XBmQkuW6HEDAavlwyOXe9qRCLpig=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGiYc3LUdngwnB4jKJ7ZInLJDi73Z8ZDWLt8GQoIZhebT67996
	caC05vslgwChj9Xp+Zr3d+1rPw0cGiTh4T78kSSb4icdhOHynuMords=
X-Gm-Gg: AYBFou04HLpNWo1k/XHY1C+HHagCl0Kua1Sq47Eyr1LXL1FjWLcajEcDD+fCGZgNwLB
	wD8in0Oz/vqU+X+5OyfDslX/n4YNxwktknmGc2c8kzuQnueo4Ae3wy1gQdmWqkwM7e2lB7XW4KI
	lzMJamqUzXkZVyX9hcCfEth3lbVgXxEGFIW3vZjnzq9byhevRFGDdB127Vh7/lJM4hjlU4mOawi
	rZgXaRfPys0ADse5tsHr6i1oPyQEAd4WwgAkrIqPzgJYlM9ja7GY31TvN37i7O3H/HKUEh7pWz2
	tbDPZqBhIamnu87GUiUnEV4EpAyzD+37HlDZ/niTONME6cR4SqhuqvW3QlKuq+FP1/JgC8IeU3U
	wPm1rt/DHPmpY/INomEsEi8P522bI7uH8QYd5vlc7sXRMcuura9JxRXxwCiw/Piwx3upujLDYJR
	015uGkc4WK7P01YkaLc8SSsfxJ+f7HHFv5XTaDl5OkEhQZwTx+EiP9HvUVB1MzijgeiQ/i45+3q
	P4lgkge1MVqWLHru0vZj/UC88opYaLJAv3KZ4zoEp0g2wQ2
X-Received: by 2002:a05:600c:8519:b0:49d:4ef:bf70 with SMTP id 5b1f17b1804b1-4a18e4a16femr256430895e9.10.1791926582261;
        Tue, 13 Oct 2026 14:23:02 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b0e.dip0.t-ipconnect.de. [91.5.123.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm613852585e9.8.2026.10.13.14.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 14:23:01 -0700 (PDT)
Message-ID: <d65b9db1-3445-440c-917d-fce806af41c6@googlemail.com>
Date: Tue, 13 Oct 2026 23:23:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 000/281] 7.2.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261013112855.045212108@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261013112855.045212108@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2026 um 13:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.11 release.
> There are 281 patches in this series, all will be posted as a response
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
