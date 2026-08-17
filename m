Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2426ED4F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003393; cv=none; b=eWM1OvmzeD91hQwpR2yILswSG0jIOrUV8WP7ludMiV5dpEAhCagfFTupBgfCgwgNPNgCHSgn3YlqiTu2XGI/Z0R7KDQk+GWACZwtBLdHzmdPHAgdAJZ4bYAIjbsNUxCvTrgQUYVQvf3Zw1hnAKxLb3IF180mN5ZZJfiXBJOGGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003393; c=relaxed/simple;
	bh=ec6qc1oDKNxMJv5NHulpSlaSCNolwso75xXsCcOXOWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KprB4kIomL6iqyJ0kPPohppSEvkqOhHpl6rodCfGTsk25X8ns+yze8CWMS0kIL5///je6aPlzE/pW8GDH7sBupBujPVAkGD+Twy9aOS+7ck3DeljH4Lggb2Qou5hynCYOEGUFCjmUNT5Ubg+P4u7/e7IyQUwDHXzHT3bJv9zY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gaIsQyxY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gaIsQyxY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso50089195e9.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1787003390; x=1787608190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/VweXn4ZwGBq5JiHyqSLqQhPbx5NBCMv1RpSwymi+p0=;
        b=gaIsQyxYD0/6IRTe1hJmLJTg5QF7smtNR2FGS8ipREPC7MllFAukuTKbRlMTdjrhcq
         P8xZiTq0KA6EZOiLrWe419NCUXCsyvL3gRkEo/IQX8RteJs/ovxKuTqchv/BJV3h32Ar
         Mepsfe8re/+TqoKNEafvbkVyY0WNLKGkvinglHPQQJmwY7gllZnPgUw3CU46d3frdi/S
         txC9ZCxxRkJDHGq5mAnPFUPYleFhroxM+1xO26vhRUPeUGRbFq3cDn9yDpD5ip7t/rPn
         s0t3ktc32Y+gorjuP9Ml35j+JTaeYheUcVoqTsanHSIuOV+OVbMCf1HumoftZAjbZ3+h
         Rzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003390; x=1787608190;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/VweXn4ZwGBq5JiHyqSLqQhPbx5NBCMv1RpSwymi+p0=;
        b=blFuy6IY3ytZOUcGvWMSNug8fAC59hVzyDLyITx31I8XNLHvObFdGeLEvYU3ChhzQ7
         aesnbtIQIcbbuOTBXnJmF1Naww6NlhR94eaXZOtccMYLjm+XMrRXxCKd+ilZLRlr7LTj
         Vuk5cTyb/Nry52u/4XVrTh1yfOtDkAThia0ktfp55eaOExe7LQaHmgRXQusxhqEAoG93
         ksbYc0ZE8Qio/pt30oOBLFDlB/JKiqSkRnMLQxvpPkFtjYKi964efvryaORm6H8pU48n
         fkAL3l1hAEBTedHdhLuJ3Xk7R3d/BNT7EldQidLwlrKQ6qMoT7Q7nQVgVnFQ4jb2KxJG
         Fyow==
X-Forwarded-Encrypted: i=1; AHgh+Rp2Hnt5BDM3+mnr0AbNxk+Di4jFs8HlZ08gySvjiHNLKDectAjfoGsCzvuCnG2BF56uavyqnF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztfxJOiEwO+wtt40X7tDcwe0vZl1V6evyIwdJypmJiVvOhIKJq
	rjQqUI9NN+qKPfw/CsCQUgAzhSXEOMJG2/897lzt3W1gwlne4svXMsY=
X-Gm-Gg: AR+sD1312D9jZkZTYS8/3Wx9NXfdVwl3+2Yd/2swYe+4vtqZ3AhOw28UnJErPtkCKHk
	seW4XblqtR288601fVA+D/T9o0P5Gqm+pkNRDyF2QRG9aswJ2RFOOoLxC05Pw+SMEtnrLqPGWd3
	bwuXCbSTdohvlZLGzTRzfosqJgmPD+MT0vNh74Ip79meIb8mOzkVOGOhAOvRZjU1NW9KQd3XNRS
	bhC8ZF4JfP1iDOk87rrh16W5CgUvgMXL710z331H/TeNJp/hsWJq51Dx7cUm0+C26OGvH88N4lh
	ywfZ1jUbX2/UZtgElhJvm/G/CH9owlCpM0Ylt6cPTqUu2DdLGtIiZq5OMPBpks9/jmLdXyPz8Sc
	nzjoEbiThJQtHanLbeY9qllbGtgQugf1k6b6vIiQYG7AK1RPFUpb459oLbNDTil+hJUZLXmugoV
	IveP5f3OX+E7DJ71vTUWCEIkL4jSUX3wFjCBckxIBKih/3PRewG2NO6IbMqwsa1eZQ/+yv0l6Hq
	XWFxxqowcP7MFFkeGXptML7EbxRmUSIaS5YqP/o
X-Received: by 2002:a05:600c:5253:b0:499:9eb8:a1d7 with SMTP id 5b1f17b1804b1-4999eb8b71emr72583625e9.9.1787003389675;
        Mon, 17 Aug 2026 14:49:49 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b466b.dip0.t-ipconnect.de. [91.43.70.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d061637sm67513855e9.1.2026.08.17.14.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 14:49:49 -0700 (PDT)
Message-ID: <3cb36c81-cc96-4a6a-902b-009349adc7c2@googlemail.com>
Date: Mon, 17 Aug 2026 23:49:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 000/271] 7.1.9-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260817132536.752504388@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260817132536.752504388@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.08.2026 um 15:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.9 release.
> There are 271 patches in this series, all will be posted as a response
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
