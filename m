Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431954A64D8;
	Tue, 22 Sep 2026 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058775; cv=none; b=hPktVDFK/9a7VoPlTnAgigoHfKHmoOEIxg9F6ww4ktBKwL7rz6KV0mNcxp5d/AsMq7L/utXXMlZsOY3OLhyGUh1cP5M77UPndzcvGo0njP+HuChjrXJlsRnK3oBdRVB0fYnsWqtG6Nku8MKzmiPs3IICO/WNKtNFD0ADGo9hbBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058775; c=relaxed/simple;
	bh=iQ6ylYqNzArsLZ+UeL6zp9ZiAnv83zacFCW/n34Nmbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doInqqsL47bccNvPuKsjKNIfeU/BBd0mXAaPvTTBH4D+PSK8zlWo6k2bIer5H1iRzT2bswxEPfgb19JED2a1Pm5RzKYqPBl3fxKl8rg1kF2VHIm+qps3uf3pA9ubYMVPZmjo3VBCRPh0g2/gu9+hIClTaWZXXl9vYaOm/f+t2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0MR10quX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0MR10quX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3CD80C23DAD;
	Tue, 22 Sep 2026 06:33:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9BF0C60580;
	Tue, 22 Sep 2026 06:32:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6948103291C1;
	Tue, 22 Sep 2026 08:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790058766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xXIPkAzWPjZ1bfrPFkHsxzyu4xiPTTHY2pkYzmzDQek=;
	b=0MR10quXK5OzWPkOJVRpGLtlRI6nD/P0pb3XUrL4Ps3AMEmDuPb7M1CqbbFs3hbi8ktFTS
	3SflqTpzGNLaW98K7pTw3dIpOwdHDYWge7+pidiWfBUGlZAeS1HHE9VNb+TMkIgQWbOBM9
	LYaUm98+A212vyQq1NzZmb3+K5G+AorguHiciLB9ru++83u1AyY5GZlL/mPpNsWCsnomSp
	WxSaHUQ9KWtSD6WLsT8dyZAUgppEK8rHcZftpKkfYEz2Wi3xPyqy+bNV7GrEFsBWojXvUX
	vkUC8wrqptabCab7Cvo27sFJvlwgoKp2DtDeJ4h/KhKFK9nycMiricQUgBVHaA==
Message-ID: <635cfefd-c588-4b3f-bbc4-1cf11ef0a2c5@bootlin.com>
Date: Tue, 22 Sep 2026 08:32:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: microchip: save the periodic output
 request
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 ceggers@arri.de, arun.ramadoss@microchip.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260917-fix-perout-v2-1-d8acf3eea6f7@bootlin.com>
 <178998077822.2160803.3867886756893254872@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <178998077822.2160803.3867886756893254872@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

On 9/21/26 10:52 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (2) · Medium: 1 (2) · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] ksz_ptp_enable_perout()
>    (drivers/net/dsa/microchip/ksz_ptp.c:226) commits the caller-supplied…
> - [Medium] The commit message states that 'if a flag was set in the
>    request that triggered the periodic output, it is lost when the output…
> 
> Pre-existing issues:
> - [High] A non-canonical but ABI-accepted period whose timespec64
>    conversion is zero (e.g. period.sec = -1, period.nsec = 1000000000;…
> - [High] In ksz_ptp_restart_perout()
>    (drivers/net/dsa/microchip/ksz_ptp.c) the elapsed-period quotient is…
> - [Medium] The device exposes three trigger output units (caps.n_per_out
>    = 3 at drivers/net/dsa/microchip/ksz_ptp.c:1056, PTP_TOU_INDEX =…
> - [Medium] ksz_ptp_enable_perout() resolves the output pin with
>    ptp_find_pin() (drivers/net/dsa/microchip/ksz_ptp.c:206).
> - [Low] ksz_ptp_tou_reset() (drivers/net/dsa/microchip/ksz_ptp.c:66-86)
>    assigns the result of the TRIG_RESET read-modify-write to 'ret' at…
> 
> --
> 
> net: dsa: microchip: save the periodic output request
> 
> The patch replaces the two stored timespec64 values (perout_target_time_first
> and perout_period) in struct ksz_ptp_data with a copy of the full
> ptp_perout_request, so that the index and flags survive a perout restart.
> ksz_ptp_restart_perout() now replays the saved request with only the start
> time recomputed.
> 
> A few questions below.
> 
>>      When a periodic output is initialized, only the start and the period are
>>      stored, not the flags nor the pin index. So when the periodic output is
>>      restarted, the request flags and index are always set to 0. So if a pin
>>      other than the first one was used, or if a flag was set in the request
>>      that triggered the periodic output, it is lost when the output is
>>      restarted.
> 
> [Severity: Medium]
> Can request->flags ever be non-zero in this driver?
> 
> ksz_ptp_clock_register() sets caps.n_pins, caps.n_per_out and the callbacks,
> but never sets caps.supported_perout_flags, and caps lives in the zeroed
> struct ksz_device, so the mask stays 0. The core rejects any flag that is not
> advertised before it calls the driver:
> 
> drivers/ptp/ptp_chardev.c:ptp_perout_request() {
> 	...
> 	if (perout->flags & ~ops->supported_perout_flags)
> 		return -EOPNOTSUPP;
> 	...
> 	return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);
> }
> 

This check is 'fairly' recent, it was added by d9f3e9ecc456 ("net: ptp: 
introduce .supported_perout_flags to ptp_clock_info") (v6.15). I 
experienced the reset issue on a v6.12 kernel.

Even if it can't happen right now, as soon as this driver registers any 
new flag, the bug will come back.



All others comments are already existing issues that can be fixed 
independently from this patch so I don't plan to address them right now.


Best regards,
Bastien
