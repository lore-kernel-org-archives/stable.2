Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519741;
	b=If1/4R1zrT4l4p7anyPr7lMKcRwG0gI07u1X9Z075DaYUvhtb2Gj8Lbt1mU0q+hzXbaz
	 mNSP+2OSuyadP49uiEnw8gBfsGHatKfewFH/FnrIemGqXkkd5DTjmUcab9CSGuJ1Hahlt
	 OaFHAbjPO/BjvmjDCu141yFrDmrK6F2OcXPBRCJ5bwFKjsNeCs5ZzUZt5Kn3JLzH3UhZ6
	 zPlEHwCSOzLMJmSHXpm6q6fXsZ89rqxqqMbp4e4laJxIE8cT7yGtBRZski8vSxiwlj3DZ
	 xkRCmwQa1g7KIJcq6rWD/M9ftvvG7CjgI5FgqPYpdK7J0kt6k7IPxYBebmvizz/HS3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=x3B/JDR+cURsrWXLjVWxo7FtstCSf95jnpcyvW1ZTJk=;
	b=bGm+pJIO9V8WlGDpM0Ory0+B+cURMKeY6NozazmxxKWOqfMp2fsQrN0hl4EDtOHLo/6d
	 WB4xtHrq5uX9W5hVyKl8HO3x3XzsndqwfSR2tdmTO2/hBY1FfWRhPZFk49iZFeKq0IXqV
	 yjGakcts0zM8Ro+saSjc0fM+oqXrIi50X4QtGkDo41SoKuzEBG9ueFz/sMnYofKfxMbG4
	 crTG/oKFg6kEira09bREbu5gqqL33NiQ8oP1ZVkIKsPKfRNZ156GF76Bq5fqJBAMivFiP
	 oaezfsVV7bvnPOsrAeX3EyP4ck3DpDjyW1sy+VRwkyjM2RDuzWnzNimeBYneXdWQFhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=HV+4cc7m;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62D60A2604
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 18:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D62D60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=HV+4cc7m
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1e3098ee2so30681365e9.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792519739; x=1793124539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3B/JDR+cURsrWXLjVWxo7FtstCSf95jnpcyvW1ZTJk=;
        b=HV+4cc7mostuDKBYHHlKh56mBjrsdI+7Rjv3fx2UN2XjhBpK4MUDjpm0mP9ep7gQZV
         pGlCHigQoegyoe7LZYe/pz2nlse/rcnjqbF9uydqi74xzqqTA/f1kF/ppE8dnZnK3IZb
         uo1vSRY/9hcXJrqaNJDoUaP2leWRWU/9l4o4hROEtRJBZ+GCJHDuqcaJG6apu+10N3GH
         nR1EOVs05VMBwu7kZAxICUamvibTxATffDetYqLQOIeXK7WsC6DmZI9h3jMY/nK+89gZ
         7YsORyS0WvI83OV3RRW7fWZ4unkLbwB3cbE0EtDBBeBCswGNYZQl7yxO+ymW1aJ5U8o4
         G3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519739; x=1793124539;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3B/JDR+cURsrWXLjVWxo7FtstCSf95jnpcyvW1ZTJk=;
        b=OSkj0NiVcTZ5aCMxzHnGIcljoksdZX3bS/QYuWgdie5rleyM48bmvizLC6i6KVkhAI
         qraPOk8aic9OlZ4/6mMEfJa6p9w5Sf+oN1jIOQZNIBkkzxvGniiwQJNXuPZajf0NcqnA
         fxrGT29xNrg156onAmg+vTkvKDJ8jcs3VWN8ANQ6b/E0OCW2cx2vWO+5rPiyGqvrTHeG
         IqLcusn8d0fZEF/YD/GF7HHt9zRCVsGZD8IVP1Tf3cahqqsv7xdSrja7VRCMWBJkF08W
         /BjrZ/xVIOAXHBb6CULN7srQcAQQSbOiCKU4pCYh048IA/GYE9ZQ6k25n8FpILVc2yqh
         Lgvw==
X-Forwarded-Encrypted: i=1; AKwUvBwGvHrKrv3GBm+fg6pFyhrmHKchIZBkmJ9AQX0rpB8wy57TpMb6/34JAS22Ps5dic5VRqF7t2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1e+i+byD8t0X83kztADteJR6BrhrLY/beQhUPH7wrpJ2mtiSb
	PMffZQiVETOx1Sj2ZC/0a55nZ7/Khgybf/JB6GNzPQf7M0oftFiQXdE=
X-Gm-Gg: AYBFou0y8hSlnI6yCkbDw+YijCtbqqt2t9YXqpmZtWs65MQmf6Y8D3QI4Pl/TMsyl5t
	7nwfyRRuOKr/i6K+QIkKEq3i8tokt2ZaA0cVROI65HBNH+KD3uD+15+OF9tVUFZxu030u0gQGnd
	AXri7TbdDk1pMT0wLMcSCRMgJTrBZiMVNFX78fijbGIL4aQYBoaCFXfsFABbUdiiftT5mgA6Tk6
	zG5B6EhPH45xbNZ8Sdjm/SoH895Xb/XZSDcGSjLO0TmrA1smF2zFTVZXjjC+OQjGbVnlyBu9N1q
	5xTUc7XVdIv86nnXXrtZjHQ2E/gOqUItvJMp2EPknrfYT+HJMdu9HEbS+3z11ZTmuW+9Tcqv0Su
	EWOqngEwliICKChYVDXaoHgOYQcoBo74CmrC9rUkzrARk5O1kFk04OwC5Vp3cUghF8tp7zbvhgD
	urfLk5ba9nhkIJ5IAer4Q6L/OGOkgErDxO04O8gSmJ8IItqEoAdZVCUY0jdUMhaso+rHKgkfe6V
	S8MjSYdOFKWlzB2yz8mPF+shnWznjruioaBTpwt7jIb2ISQVHjX1k3fLIefBg==
X-Received: by 2002:a05:600c:3554:b0:4a0:2488:71cc with SMTP id 5b1f17b1804b1-4a1d76234a3mr246372675e9.32.1792519739356;
        Tue, 20 Oct 2026 11:08:59 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace83.dip0.t-ipconnect.de. [91.42.206.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb698cebsm23338615e9.1.2026.10.20.11.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 11:08:58 -0700 (PDT)
Message-ID: <bdb59552-51ae-447b-a3d8-c03d860eb8fd@googlemail.com>
Date: Tue, 20 Oct 2026 20:08:58 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 0000/1651] 6.6.160-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261020075535.084584701@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261020075535.084584701@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.10.2026 um 09:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.160 release.
> There are 1651 patches in this series, all will be posted as a response
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
