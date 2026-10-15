Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059151A726
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069860; cv=none; b=j7BR5nYfig7TY9BQfk4YKGUn/8LhFICLBzD1Yh2QDsKL1fF4cHSqzlYRG7P7GAG2OUqdtA5UHrHh1RNDmhwrkvbXZIvQFG8QeW9KQre9kbYj18rpTN1/x0jhtH+61eErEtYHWVzh8xYQEYrzlWCIyEtJdN0sTrA7z4fdenhcSyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069860; c=relaxed/simple;
	bh=vMOw2LnSptLx2inZHDauA7QAHN1ePZ6m86XtVnrNXWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQAiSlX0Vg3KpeERrUyqEJ0GXnhD7KSb+1hoSYW5K9l58XZa3dGzAflRYq5+zSSltyjt7DTsJsmaWBhdou4TCH4OJ4ghYGORVnecqWT/Dys7yPR7kGMTs65c8J9pyDAJ78wCZBuMWxc/pEFasIlgM8XdEKBvnEz1b/jC/kVYAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EUWgwLAG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EUWgwLAG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so21112135e9.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792069857; x=1792674657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y1H+C/SntNFC1iY1JZXwhhR2BGSETQJL2ytojY5GJ3U=;
        b=EUWgwLAGFmMJsZkYtydLu/CHXyvnmoKfUkRIEU5V1Udz45MVgy4jqXeixgbKcoWEjr
         jRnQuhYBi0OcFCauVI5CdndT26uTqZtuJs/dvWTFa9c2GULJX4JE0wNH3LCI1MwJjG3Z
         GT2QtGd+lTA2AYKQJ4JZLf3IisUvPgXEqr2vqIzNqcU4e1MEFwFtvm9l0a2sS9vr1lD/
         pbGsbs9ImfeUqCCdtQ5m2mTf0p0bMXRgAAo2ocL39fs9ev23HZSFRWbLSqM35SmXsa2Q
         spDiL9CcJTH8Xhs5r7qAgqSMraH1OQrVfeN1DDIW6NdublJS/hHLtxdsszqSAVKgFsgW
         bdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069857; x=1792674657;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y1H+C/SntNFC1iY1JZXwhhR2BGSETQJL2ytojY5GJ3U=;
        b=w4AguTdwb9NKXv6OpJRfHWB/Sx1qJSz2vSNI+J3+ChY3PmWciXCcYpBFZTUQWfPkDQ
         5b6qgO9uu2yZgYT01Xl3fQuHPTSkXrLKNCmGvsSMnL2MYwCWK0Af5FZKIDwulQOHVR7A
         2/fe0IcVshTw7a9rd5HlwbkQzrAcx1Hf0YNcPaISk3F1AQiuoNcVQUW8zAXbJUQJfs/b
         SHWpnN1DhBW96KiYVS6AuVhLAFnn01VvLSFX6Tcf+RBV/VACIogzKckkNq1dQt+EMG91
         LQ1A3eKsER3olxMdxksTYNqp6rVcva52Y/Lv8sFiHsOgAPKJuxHvXbO5iZ+E53lvyUX/
         Qpnw==
X-Forwarded-Encrypted: i=1; AKwUvBypTw6xAz1M+6WqMwlzQxAvFHUvhYf1LujkWwuDOJqJIion/s9VLIKnJFUbA5udToM140HB7e8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKum7S+qBbgeoVPX3irXWaySB8NT7lJwIk9SouDochKtNy8Fs7e
	QyE7WjfIYkO5Pi5w68HWQXER0EWnpSUX2J3d1JfV0XVv2SMVsr4D9ucpVe15p3Q8Qc97rsI9X7G
	dfkg1BUM=
X-Gm-Gg: AYBFou32XXEPOiDt6KoCRKhUrI4QL85HrVm5ZTZI+ortuQr5sERZS79SnMzqSsk7qaH
	QzI1Kbyi293dBgFp3CgcYYR1PnzUz8F1fFYibXGWUcRz8O1GVm8dR20HJeZH+Hdnc7y6jTwkpbp
	Uo1YNEGq2MvxyQwk7ruTid1zAqLviX84sNHIxCLcNS3B1FxNkPgxjX7DzVAM1ic1wu6Nv+xtvz2
	2C+7jOcOtGYPpsX4Fm/bXckMdWP4LqzBm87p+AmYOBCCUHrqP0EcehOq1LeBbGfKDAGkRM9e5PQ
	Syeicc6ubht5C+lllPQWnfamhuAIPv0GX997ghmnz5hYDN7gWa/tvQGa/0A552+Jn2hiC1mXaaN
	LfrbppiuqoRBosd7H31Vnkgj8F9WjyMrPPCpdXg08aY46uYeSYLoeMX0WRwqqggENeBz4CzBJ/N
	WqSb9LjVw1sfP3AFA18+qqGP0/pRQ9X3WsDKv30fwJziUwRmIV9O8tQb2UzvHeTSDm04dijG0xK
	4u82yzJmYGnxCp59kyw9Fks0Ozl28HdvmuoKGGOxxA=
X-Received: by 2002:a05:600c:524a:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-4a18e4a4f2amr384803075e9.6.1792069857275;
        Thu, 15 Oct 2026 06:10:57 -0700 (PDT)
Received: from ?IPV6:2001:a61:130c:b201:1a24:6e5c:9182:4c01? ([2001:a61:130c:b201:1a24:6e5c:9182:4c01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6834dasm65234445e9.4.2026.10.15.06.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:10:56 -0700 (PDT)
Message-ID: <aed1c8c9-1603-4d35-9b2d-e164d559f497@suse.com>
Date: Thu, 15 Oct 2026 15:10:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: storage: bound timeout=0 URB waits to 30s
To: Hongyu Xie <xiehongyu1@kylinos.cn>, stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261014093856.415812-1-xiehongyu1@kylinos.cn>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261014093856.415812-1-xiehongyu1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14.10.26 11:38, Hongyu Xie wrote:

> A blanket bound for this helper was suggested before [1] but dropped over
> concern that legitimate SCSI commands (format, tape rewind) can exceed
> 60 seconds.  Those commands are issued to tape LUs whose SCSI timeouts
> are much longer than 30s; usb-storage-attached tapes holding back a CSW
> for more than 30 seconds remain the residual false-positive window of
> this change (modern tape bridges use UAS, which is unaffected).

And these concerns are entirely justified.
I am sorry, but there is no uniform timeout suitable for SCSI commands.
If anything hangs based on wrong timeouts, that is the bug to fix.

	Regards
		Oliver

