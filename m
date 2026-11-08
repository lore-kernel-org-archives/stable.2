Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794123748;
	b=QBNP/26tzmBKNoGxC/OiydHqmEMAx6KeC1XPpdED23xAKCJHSWBZ+hZiRl3lz9KVJqCM
	 BaluQ39+rsn601rHp7W6fbK15aof9d6XjK1ug5A7zGdaATawqWadm3WamBVfQ7Q2fDMCJ
	 hvbD4/c6ZO5Uyx9qxoPB6CcJUOOEH6fGig0Ied0FGjnAqkkfGTF+R/OquZBCfOIb0IP2X
	 Vrnq7NoH/PGfloo5FmIY+SDg3yrgYQY4mfjuYKdNcMpdoMo1LNM7WxLmx8FaoxzkRAUza
	 D9xAYEiXSVNOwERhVOD4gnchjPqCg1rj+LnGfOpuL961sk03726j34fL+lDmql3BySw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VLNz6RHfyZ2V0vojI2Wyp9rbbg58O57zxxjtT74LsU0=;
	b=LNFTLtcDbOKEycJB/ac1dJ/aKzkME6ilnw/2wwjKiBGm3OZGCG6Y3NcDeFrB6U9xSsz6
	 tWrD1uNvupmOalRLFPzrUXJgW4cMoxhX7u/Zxnyvqdwof+uMJg+LGqmybQplyoLgjGBAI
	 Af3EGvi4hCPmhC5Kl0aS84InLtEKJUb8X1r8wa9ppXYgxV4szlLgViK+aWpkNAl0Qxbhr
	 wlrH5NG2C6+EIVNZauBUac+dk3F/gkuKZgWQaY6jPZaflvAL0QIpKoOZ9l4WKtQ8fKBsF
	 oCMW1a7vDPv4xqJo18TJ6cMYfZypUTDuX4/DXqmJ7CXkxmQWdcxxUbDTxHZ4iFllQpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=futuring-girl.com;
	spf=pass smtp.mailfrom=futuring-girl.com;
	dkim=pass header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=WDdgpR1C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BAE606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 07:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BAE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=WDdgpR1C
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b56c428212so224290a12.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 23:42:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794123747; cv=none;
        d=google.com; s=arc-20260327;
        b=WPFscZ3DivOPPQS030PkmvgKzAEQkA1GAaBo3qaJSQrZElARy7e13bfInvxZkbiNqL
         M+GWhxYjFeBmkEeBjWWqbKCIDe6CKyXZr7D4dvp34Ba91+q/G1hJFzaW8kztG2XD/5Px
         0+BQLvj6fwUqPwBt/OqNLiRvIKy2WMPpMBH8kLnSGyt0NKqXfanKb+sJv5rbr7YBf/tP
         9DJP+38TFKwPyN1Bsc+eWGVnPOyMbT0+PJcaMPnjtVvZpWphPklskpHXrUE1FSwT9/As
         Pc0I147QtprlaRbIRpm/wuMyd2WdOfBc8ySSypKVIrzFJDx9UYH6JTi9qqtsc5yH+bxH
         T+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VLNz6RHfyZ2V0vojI2Wyp9rbbg58O57zxxjtT74LsU0=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=p4PIBI7tRtUPNAolWn7eCVkA0OzQyJeN7LSJeSszutyyTVG/YYIayO2RmepdSTz01e
         2KmveFGQ+phQ44RYxuD53UTA0M2YPUJLBMCEI788USlFf3484S/XcEn4Tdsp8VxUsoU2
         fnUs8IvHWDab/9lkfFGA0YIfzdyOEN75BB4+A3y11azKHrbT4tXMb6UiCMCcW/Dcq7o9
         pk4w0Jhzt9MRLt7Df0TcuM4DZo1tnZmRxOzwJqDlfgss+AlAu4JWVT1sqXNWduPbGM7i
         zPWrtu6I0yRQ7KcY7ilX6Nt/RV8XYjcQmhAJjl2W4uAlWRVdy1LkIkNJe03aXI8+7PDx
         foog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1794123747; x=1794728547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VLNz6RHfyZ2V0vojI2Wyp9rbbg58O57zxxjtT74LsU0=;
        b=WDdgpR1Cr4LlFfGn8lZUZwZAfSFoPLNi/WotJWOD6tv8xOx5wfKeYkE0LTd5jXhQYP
         cbIZODYYQPD47OZIMi3V4QMkMTsFK5mHVVwWP6Y7LmfjkzT2K+9AAPcsTkCM0BlfdGSQ
         fkLR28554SxnYkkFHFaMn9C7B7uuA5MaFoQpXn4TRCngellis38kHkec1tJogXriFpYA
         hhNDLvQ8t7RVBGmXOTmWCeg1hForTzFtMLObqk5qavSL60ipEwgC/7E9HxnAYLtarQ+M
         Taz4RPKdk5zGG/S/Y6HinmR5N9vCpluCu7aQ2auUeqnBWkKaDQ5P+HSW2BodTBQSlVGG
         OkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794123747; x=1794728547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VLNz6RHfyZ2V0vojI2Wyp9rbbg58O57zxxjtT74LsU0=;
        b=N/sX4Hp1jGh1MOoZkroCIALFhO+W+R1goQL14+JCWF4Fkcd0uYvlTuMB632/P6uRO8
         axl0SdeNQQYsTECeEgFu3kXbSMdF/GuPF9ag/NUzCu5VQWeAKNYV3CugzGvW82wUCW1M
         1f4cm/QLkJotQZlUZwxIHm9XIvLR6RZAbCZ75lBUHOEEl7541KHoChnb+JMfaIftJ1XT
         WdxoVSmPkaEQ34xrJWm/JpxSIU+yTmc9HRmxrirkV84q8VaCJ95ZcbH0rl91b9GXrIAB
         W+W+ba96G5BNjzFH/taWBaTRcLg9pKrPvs5fA0GagnlaGd30BAb7pIvekyKgDWLvSfi5
         5lEQ==
X-Gm-Message-State: APuU4Z9ZaxQWp3nFVAHFICvRzGH1VvR6Gwb02kQl047o7o6SZwVqr05l
	JOoayfbxocVqDKX7PdsBxsOHx4dQZsp0BoUozzrXRlX1bSx3Cu961lU8RU2Y0ZUyeGLEbunDJ36
	1lPpqSR2jg7XnyaWwYk0bCEOnGkxBcZU+vuoPFCcRzw==
X-Gm-Gg: AYBFou0Y2i9Su22/YmSbzrBCeJmxxtm1K8B/vPkr2GntZwRCD7t+xL5dr1yVVdRXyHu
	bKNr8euifF4tR0fA4jtVgNwoH/99mzlAHHoczApI4+qA2X1XgOKP1T2As/yBmwkD/ik9YS/lAFY
	x8hyVWY7bNGCAdw9Aeug/KmN8j4AKLxwQXmJkYV2OAN4i15QYAe1SRKIIMGxVpTLhP1jhvhE1cf
	Hcta4MPRNymsSsU4DQeLZN4PjdGRPeA2foSUckgEdL4DPa8L02wcqC/2qpwFOFNr1/VzEQU0Yay
	+PMjsdisdvQBrmX+pLM3x/7Fjzk+7R0QDLCw/6FABJRF+VzysLIlA1V9S7kaPRqhXfjz/fEcEpV
	C99zPaX8TjK50rtTidcUWei4LPRu/h5EsTPKb
X-Received: by 2002:a05:6402:2b91:b0:6b5:96e9:ae97 with SMTP id
 4fb4d7f45d1cf-6b722484ae7mr465101a12.34.1794123746308; Sat, 07 Nov 2026
 23:42:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107134939.434104957@linuxfoundation.org>
In-Reply-To: <20261107134939.434104957@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 8 Nov 2026 16:42:09 +0900
X-Gm-Features: AclHuK_4Y2M3DeuqST9ji-ywEkqYo_2N9_-1XAV98U47LHLOvTm2zUmbhhFxDD4
Message-ID: <CAKL4bV507bkW7uEgo4BqgE-ADALXc_ZhH1OjvwUVoa0QT29ysA@mail.gmail.com>
Subject: Re: [PATCH 7.3 0000/1257] 7.3.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sat, Nov 7, 2026 at 11:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.3.4 release.
> There are 1257 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.3.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.3.4-rc1 tested.

Build error
The previously reported issue has recurred.
Built successfully and confirmed startup following the procedure
reported by the previous user.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
