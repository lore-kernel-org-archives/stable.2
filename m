Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4237A843
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989269; cv=none; b=rnBcUIAmrYGunNaMQcYLf9xA9wlCTGeJFEhBIvdTyNBzvd2g6spJw2N5S0k4EPnk814VoNGFJq5ufWdr7087Vj1xOGRVZks2Od2qh0Yy+wlLxY3iDUI20wxF9TXEoiDb06CZsvhWrul8ib8vuQR6hsIW24YzjMGg1Zd9/cLR+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989269; c=relaxed/simple;
	bh=pSS1C0QXGOvHzCVozAFUNIh3elOYnRYPfbOJE/uVnQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amf0fBr7OdQZloxOXPsGPwHOBlPqpKV0EcS20Q9BJGnsA0JXlF+RY6Dm+TrWcZY+K0v+RCk6CeGWXRbhMpsrTSDwmaLYBb78wbwpbOa03k9sZNYHYrOQc2T3HvOIT/cdUQQfI0Lru7UmmOUCcFkOhXXz6JlGMpBIeEh0GlthA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SbCNLRVL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SbCNLRVL"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47fd4531020so2251625f8f.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1786989265; x=1787594065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7Oo4riHRY2DosSl4t51IYrt9p2aq1oht2yaJ1ObPh0=;
        b=SbCNLRVLkBJCwSA6yv3z53bWqO3yvOMJuYZbnEGRIhsv8/gEA/gQ3gC+bViTdeOOxP
         Tx9wIVNReRx3EpKJu1tFYfMK/rMwvC3JmIrEBC6+q5RtP675klf0fvjUJIkxeDjJpiC5
         6XG5roUsYRqpb9PezVOVd6wBKuDev0ypYylL+jrjww1tbjCPnT2g6VSn2ZTE6VuLhXia
         4+MCkeDdPjl8KiGWaw44NUa5aiPXA6umb4cCB2/xS7oUzplp1WQ5kN3/3O/0J1l7RL9U
         ffrIbZM5sEGWB2pjeTGXBY2G47CpDP4yImqrVzGBgKJZ9q5KrBIqEFKdlx/yz0EiKPa/
         4vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786989265; x=1787594065;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z7Oo4riHRY2DosSl4t51IYrt9p2aq1oht2yaJ1ObPh0=;
        b=XTuyUHyY/i6SxzVFFwh03o+z9bM4Ah+sZ3oL+tZWg9bLF70sahWoJcu23KCfdftIE+
         PLyf6TsnA4sbftfmw+KawCtP1JM3yY5RQRwP4q80/0nFMQ3aXFn1J9csoxroMX2tQ6+V
         XEc/fu37t1hPVfP6avpk0+GwdwhJJIZCk3T6w0f4Iscpw5BYng74lu8p/KelIPmFFNQq
         O5w2jU+LMJAqfTzelxiDkPfgIVIim7njr3UmrcUcub272N5WcooERzgjVa41u8nvY5Bh
         ri+7KJCGTUQqnMJnCt8AG7nzhM94eBvAajPlSjrnWdS1I8i3YB1qHrIpMKBP5ZjYZeTR
         7UVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpcwtC7d8pCvUKy7V5f4xjqpsEX0h5TwL8FPTPCO7Nvw6SYFpRt+opUL4MVWeNJdh34htacTMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYuxVcaZPOLuoweDKAv7aSZMOay0gAj723fgssslyDKPhDqs1
	m2rM7xZRsflT0klHyUOg7F5DON4PP6Dvisd+QcVoaj2qOZOZYpmnVFs=
X-Gm-Gg: AR+sD12dUK4vpmvagCY6KQlXkCxeM7o45RbHcs1U8gLUqj1pES4SpoGw1RgrLOEXCxh
	SfilLxbf7IZR7syGw+ocw7WT5kja1J5KeuiFUORQ273jdLnEklKX0R5WDhEZrI0HdZSkI8uQBfw
	/+lRD9GPsQFAFbQOQqy/MzNdWadWJQoSVNoqEmvq9fDExB3O/tXaTvhOaAVlMfDlkY2PekVriGH
	szzfEXEngKchevVUYDdZ1yfbc8kpEWlKaNI9Vh71oewz9Ww5O2cuPq4kFQc+ptiNd2HrZxhstcF
	PY0B9SVZ4T1cG4YHOqZgP6Fuyn9wIbFKxUmyAJEJoAomqtpuLwzY//SO8OIVUld4Tp6vafxodJW
	JGloR8e7ugxRLFA0u7d/KBNSPxZocVodwkrolZLT0f7/R0u4roZzQUMwmbIDdAZUd7XAX/3xeFf
	7Hlmh0P6cy5I9mqEKak0eADM/tnR/FWZtAghXCovEL4XLETwHrJ+7hfhGQ3aaZNI2RjD4wqd/0I
	kw69oos8tK1o2rjqlrhoHFx/NN7cgn50s7w2b5AK9fkLg==
X-Received: by 2002:a05:600c:3485:b0:499:8758:8cb4 with SMTP id 5b1f17b1804b1-49987935eecmr432943595e9.5.1786989265474;
        Mon, 17 Aug 2026 10:54:25 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b466b.dip0.t-ipconnect.de. [91.43.70.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0fb867sm74590685e9.10.2026.08.17.10.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 10:54:25 -0700 (PDT)
Message-ID: <3424c224-a258-4d40-9a7e-9a9531de8791@googlemail.com>
Date: Mon, 17 Aug 2026 19:54:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/156] 6.6.152-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260817132534.666299318@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260817132534.666299318@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.08.2026 um 15:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.152 release.
> There are 156 patches in this series, all will be posted as a response
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
