Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783C3A7848
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788639224; cv=none; b=nXE/rV1RMfFso3cqHjJpaGR5cikax8dc+uMRXLaPtDM7FdGUvayi8ERDOwPQw+icTxK6byQI6tTFxzjuM3MJdgcf73WdzwXJ5PpsTr5X4lwh3LNb+6d7fMlROJqber+Wv1R0+eckZHHJS6+jOY+Y9Dg8iitQTPQC2tDHpnQ2OcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788639224; c=relaxed/simple;
	bh=3PKFXcmHlUz3OfVy3HJ0w8Q/d1ojlG+0EylTJLYM3SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wlh/5UdKcxzMK9XNIiwBzbvenXpkgvWlCH827pIOiBHf047s4aOKAr9K1j0FyQr0wGjMeER8Psr+gU6ABov8BpM4/GXrf6F5GgpxL/pPxuTcSKWFDwLHqq/60VjncTg/g+7KbModAe0ILja4dP9/he7TKEH/leBBcZvUf6r4L0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dmdFl6QZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dmdFl6QZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so16874395e9.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1788639221; x=1789244021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYLQLVPrMZqzYFFCaoEPigRERkkXFvdO1k2M4yUI9oI=;
        b=dmdFl6QZXKDFYW7ZXcLx4SgmtzM9XmrjpVDyhnN3zr2IFJTPBgLnbqNpOGrATEomtI
         7uVhlNU0Y5Ua8ffPbYq/aAMdTLrekF9FDflA8R0zynvovdy6jvTd94AzdiCDIX3+0Aj1
         nei79Vd6st3S1DULfr4GzMTI5kUOMt3DJaVTpV10VBF7iPpCT8Xp4pKukKO80+zs73zH
         VHocThow9yOBBCV6vOZGhLjpzml0V0qV4V/JJnu2ltZkkPYVVgAU3fEOd4ZpSCT91U5W
         z0eWQERO8nEF1rERvsqOTDqnVsM7+Mhku+yajDzAhYLpcxyX5c226LLlpl4oBw7tqZfD
         2KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788639221; x=1789244021;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AYLQLVPrMZqzYFFCaoEPigRERkkXFvdO1k2M4yUI9oI=;
        b=e/TNOUFCw9ZhE4Wx52Bg8LOzCL/S50rcz0mQxTlFB/o7U3Gphl6D84oMdb9/bDsQv1
         UDSQ1Lh1f1+p/QlW31nr1+Cc1Psv0frnZw7L7l7yTfm7SCbQkBO0qxpBTwUJAc17Fz4s
         3TxejXGxvXEVRMyURPGndJopk2WuHmJuj7NvK9r9Q/HQPHZ57d756Nn8E1CQv3IFP3xf
         UB5uWIlZKOfPoxctqvJd2vWzRzVPROQP5jRcp+qYZSKhfcP98jv0tcavjDj4loySA9Hq
         NBgM3RePXWrJHE2d49bvdbk6CI49Jh5mMsYsTp4yLU4YqejUtrAriv6CCVFxlpzR6iI0
         hLvA==
X-Forwarded-Encrypted: i=1; AKwUvBz/MhzqrL+6YSgsyETz/kMVUTpQZHodNKxpb0tZdTwFITOo8aiwAFgEAx66LLsKOm4VyRoIkHM=@vger.kernel.org
X-Gm-Message-State: AFuF++k2go8oCwfLZ/VJowQ76tywVKjyNHsBaXMEhuo27/DVFlK7h9bH
	UNBOjWW7NYrqb2AdfsTFq44AKQypO6xqKIJQU5Wd5GiOZLX5OxU3L7E=
X-Gm-Gg: AYBFou25WbXmTXHYFGe7yhqczuiBoZSPDVxLE67eCVVOKCKiGgjP58WF/JmjuyBDksB
	64xVvWiKswl482qdXh4W5Klnxfq758kK0wXjY+8vn/E/OBbWBuHqIomfOwc7DjE3AzWlc7XksLO
	Z/pDTT9i4F+Zixmk63/R4o8BmdOSn/0sA00blagxt9BENoh9L4+3eBdNbnGoqVIu4CWBONIhK/+
	nnTBx2BoeOn/yCd9bv6aqXf+1PdUToDTs7A9TdRwNIfdPc7Q/xx45cCRvbjJL3Wzo3hSof+gHdl
	fQ+K14vP/fjANrN6L1laph9KXtrq7jvEfd0iBYlkTFCBqam9ko25bQWDyTN5kBxAeK6VDACY5D5
	UAnSsYpRpOx4VNOz/I76bUE1/COGBzycPEJrNiDZWUiDJ+zQiyGK8/GlXNHX9qmXysVRrrqPz7S
	8DZ6e6/+PIQ4oST5PhgUL/pDA9n/pODxxi6K3VuWls/7krBj1+KuiI7ODohAIMSh4aUsaQEKYIB
	lTHOt63s2fuaoZXx6jKz5H9cpRkgyz3O8iwSJ5N
X-Received: by 2002:a05:600c:4684:b0:49c:fc6c:be14 with SMTP id 5b1f17b1804b1-49cfc6cc10bmr112637755e9.26.1788639221125;
        Sat, 05 Sep 2026 13:13:41 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acda4.dip0.t-ipconnect.de. [91.42.205.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023edsm253975395e9.7.2026.09.05.13.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 13:13:40 -0700 (PDT)
Message-ID: <6b05880f-daa4-468c-bf98-389111b2646c@googlemail.com>
Date: Sat, 5 Sep 2026 22:13:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/551] 6.18.50-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260905115635.269562615@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260905115635.269562615@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.09.2026 um 13:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.50 release.
> There are 551 patches in this series, all will be posted as a response
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
