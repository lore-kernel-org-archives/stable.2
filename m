Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A22D1913
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792272345; cv=none; b=BHrRtfxqek+6AlauNKt7AszjUXUC82fL8eeC8vIiiytb95BBDHSlq9NZynk9IJ3DPuFV+yhztN3/WX+nWEwOOs0euXSHPotd3ntlqTSDtSZNDAsGwEjA3OUrgtQ9/GMRnBo2wfPFTxNNlq0xKpnIqziRYlqOXn0ESft00sGyVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792272345; c=relaxed/simple;
	bh=56ptqQlyHesFnGpk+PtWo4QmVljOTxhSInTCjUT+VZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s84wjJsfZ82DJO+o7Zi0RZrW25WBxONlpRIoW3kKSQatg6+y0wold76qYpF0s5bc4AvUuXyYVvceOpDvDx0UtTMBo7/zBRFr3u/X863q0aZ9ROH5K9AZeNHf1Db5SRZYvjYLOkHpEin7AMuvdIU+xhGCNR34WvHpp/5BFEnFflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=p7crKOdr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="p7crKOdr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1d75f2f11so6630935e9.3
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792272342; x=1792877142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tPqZTZxjS+0hRnBnz4z6hzvbgGGkcWgYGELhxyf+/ns=;
        b=p7crKOdrfrQW6ssZzj8ZkZKQapgptWFXz0oaPRXvIJa3/B6OKvIZhvpcZreDq85uAo
         pa9/LXoNyc21AIk8ztXo9AYDC4ylIfJ0iv7N9gMfU3wxIOOYDykXujOMW6qyz2exXSj1
         y5KReDI+WaC4W7BuHcXG3kE4DFV661g+b0fQd5nmLahpKM7y+6u9TjOwWAiYjsTjIEPU
         b236jTRQ98tb2W0tJs7exosPt6Y7BN6lClX+eJFad3YQgBcB8LFlHKjiCYJYrIQsol0F
         ttsfxx46ib+vqt2vNGCF6Nh1dvKTlfJRkOSq87/z0mFJ27Jy8wZjrBo38EAV9yu4MOpZ
         nmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792272342; x=1792877142;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tPqZTZxjS+0hRnBnz4z6hzvbgGGkcWgYGELhxyf+/ns=;
        b=RW4LUh8CAdfL+bbtfGM9B33F42xTRG7VGtCoWjpeYt8LzlG7E9JLgRa4FGUOVwha30
         STpHr6GM7VKYoT4uBmNWYCNABYllaBfjLJR0blotTrOt2D5jhXK9j+bQQSGLrYEjnZPp
         u7k6hc9VmadeYRqz+LnEbrY38vF0R4QMy/ZYYpMVsKnhUCr5zIChm9ZXHmlDl8lT+0lX
         UIsheX4d635w5oHng7AXv83wVQTm9Y29r4nvkKwTcxI1Q1hK0RMJol7vwDoOPdImDAQh
         VMRM7X/TDvoaHrep6KhJzPt+aPvVKJyV2516cJRiJd3tEeX2oif2hJExKXvzI9RBoyPD
         v+5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzdqiXlXL8iA1gM5guINPKgulA8Qx2SVvU4MFfLI8kvYfo+XxiH/iViGdv0sboDEbNBIvKr/5Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlIOaVAsKtpDw6RDCN2vfLT4DNQ0Rlkoshsk8U2Pa4PPRyKJwy
	qvRnEaPLPEMpmNtUwY3GS75gc4Zs/4UOvmKD8KxsvWq/2iabJXCYojk=
X-Gm-Gg: AYBFou2vZSXlHogqPOux2tMEiyxmYgGxCIMUsnGG+TBgLXyir/WVwmc2y2D79xh51Yc
	1mfjXgM+/8ZUdn0DdgKYsihjMxiuEIF4s8bmWPOBmqdIHDSh9Ed8rAYRwHtsskiIL+4MLL1EhHU
	UTabZBpv5H4iTWnSJsbtd/Qphj00iiahG3gp4moqPd6uJ2YkfpQSyFbUqwpWOu5dmQSDXp6azsZ
	c4UslSJ8zDX6tA8LgQuxFpaUwcyvMtZk46GKw94QeQ41tGslMKQU4GXRKZwp4ORnaadaN7JG61l
	QMbcZ42MQimS55hjXFo3f7QQlpYdb6O70WtPoj3hsRI/Pso8EaGDpuzLeu/7YmEWDPbfldMj3E1
	nTV95OY3JzvDZB7sHK19ZavSzBYn8Uh9WoCvFzkxuGszmPT+b1tkjlz4EX/ntWRH5W+AgOZAiHv
	dqc4KfA76GDLJ9qDyeXY7mTeR8c/60MdWGH08EwCE+Sswvv7GKRh28/j4ExVyFG/S6GNJdZsAFR
	AObkpb6aklZcClypkoM6I3o8IsORv6s7Ht8pewGIM7GSAXtaRbPECFQdRc=
X-Received: by 2002:a05:600c:870b:b0:4a1:d487:2dc8 with SMTP id 5b1f17b1804b1-4a1d760518amr73953995e9.18.1792272342267;
        Sat, 17 Oct 2026 14:25:42 -0700 (PDT)
Received: from [192.168.1.3] (p5b057d26.dip0.t-ipconnect.de. [91.5.125.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca31234sm103050165e9.4.2026.10.17.14.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 14:25:41 -0700 (PDT)
Message-ID: <f91512f3-34dc-4dd0-bc7c-611b521f1217@googlemail.com>
Date: Sat, 17 Oct 2026 23:25:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 00/10] 7.2.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261017155059.698368299@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261017155059.698368299@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.2026 um 17:54 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.12 release.
> There are 10 patches in this series, all will be posted as a response
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
