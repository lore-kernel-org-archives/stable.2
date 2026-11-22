Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307074;
	b=kr3lt/7C2+kGaERSP+/jJhzjlb+Yqi2FYSYNoebYtHKAu4X2DcqZ2HFGIfCdQ45PXvWb
	 aO02858S+Uog52AQ3gG2Lj4Q3oO70OSuGkhBlrP2zR6wLQFOKcoSlUyUuV9R6HrNzCK9S
	 FaAUfi50nuUAPHAkktLw6xGoZeOy4qyBiZKGbnxEatr6hiXPSPHmwHHRcMNaLtBMl8Wsu
	 O0vPD5VEUCsspxgmdEYjvv4Dtw5oTMwZCXWKyBrb0uMjxOFENWY8xqqglm0L/Nexvph25
	 cC3UlMv9GEC/CmyxLw2tJCkFWwfakyrdf5gJESKyu18QWqblFjdcdFSW78owgeAg/rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7AutQAwdwwoaFEE4x44ILwTb8k/RmhAWlEsJY45jANo=;
	b=eVtTeFS0FdW5qB9qExT3KsPqQBbmK9MMeYqiYaSkKhA/QUN9fR4ooeTDK4Z6OqoA/7HK
	 cy88zusP5KX4Q9bDUxGFAzwftSOcurIp/Wfgp/bULPOcP97Rc/KsWzGMYr93L9ogWG3OT
	 uc//K9wFOBGjYw7zx766NMEbsuPUssq21M69fpOFxaPE3RF2g5hWnp65JSVJd56k7Wjl7
	 QS9aCKdb1rKq3KgcLlz7V4Ozt00T7Vbzh+mA1HnU6TQdERAy4rbyDgnuPX13gsEp0Bn+W
	 wOXhDAg2g9VIWMN0utg63bOO638GyjrE+ofdHGkEz8Pb08NQQ9OY1xCtaRu8edwmFVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mOU5fgAn;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD1606A32C
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 00:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8DD1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mOU5fgAn
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so17184755e9.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795307072; x=1795911872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7AutQAwdwwoaFEE4x44ILwTb8k/RmhAWlEsJY45jANo=;
        b=mOU5fgAnuSK3v6vTsPnGm7cRPB+S0vG3TKjzKG99IKrsF/M3tHQwDCcIQ1ff4hPFQ7
         894cJITJlGAEXaqJPsc3QGDEPHLPx+4DKzjyZRN7RXIdW5CW1loSBVqzDNnXN2zzKSeH
         80rhQ8uSXOIBnHvXi3WkpJHd4Ltn1cIgId+xZkh/kjJqczMrfjPKxf/075a0HvqpaiNu
         T8ETVbnl2l/5mcD7TeLdOPWx/KAC6z3uLlXXodmpubniji2RsVqKsxgDHqSfVX/yq/tl
         cilGfjwMYjy3MIYWnSLk14jrws37jE7OVTRonVcATs7EIeS+JhX7Y32Et+XdsqUasq5L
         TA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795307072; x=1795911872;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7AutQAwdwwoaFEE4x44ILwTb8k/RmhAWlEsJY45jANo=;
        b=GBjHhWVGqrhHK7G1NZkqyllIy9+gOxeL5UlqZYvZnwk47fzfTBbG4Fhbh5+jH7TxwR
         iScRnsWRwA1MJayWMsFhpYIXFqH/mRBH6ZgIfqkA2jbPX3/DypPGB4TyvvCJBuhwk4cl
         T+sCwkhjvm9aiiN05qXo9Zu0eE3HZb/dsleyDtJFXgHIJfxFxCBn20be6hrE16TC0opp
         QGOuyvX2HOb0Ohto9Uv7huHGBHU30UInCoMLF5UiP+S9QN9Ytq13ukm1o+NfRiuuBq4a
         CPG8fsDqjDFTPPiclovPkkpcL6V6k2IuVeOMRLsg0Tnl44EiqX1uRHo0deDqbT/bmzOU
         FW4A==
X-Gm-Message-State: APuU4Z9RQtBweLNTEJ4NCEbEOlxZNhKdOlKmUrSS1FvqUBlYWMMT0HF9
	eAT0rPp59Cg/XGu6eNZT0xB9JuVW7sGmiUtRapcCWT7dHPatqt1GDHyN
X-Gm-Gg: AZFdTZf5C9KfdlcUWrTqgUxYvaf8Z4ilnuK0qFb73gl6yNlyYxuQrEOlynDd1uhvNOY
	tR64C2CdZ/dXwMtiQmbElGFav0XhqgNzGXecdZf0+2btC+lX8HRcUSqGihARvn1EXB9V1dzng1X
	m5jqqnImrnPlzm15RXBAwkEG7zWAPE6c3iErTfq0AEWNI2BqqCstnG/1XnLWk8vO5I+rjqxyoC9
	WnBs/cjGTZlWoLEQv9EIlm2HcvdEcrHAGt7/Zf25It28RVWDJEXpDLcFn7Vx8Jfu3bYw49GiXIq
	cwehtf08SQZx08Q8UN1PaY64aNgnaZJEqULUyVniQ24LjafGDruoxnt5y0ERAvlLgUHmQmvjB/z
	qZSf6cqUvaU/pLVgBWYs9VsGmEoRGyZLaMYLOwWLHqCIuZxVcZxpxAlNz/JiaR1GFOTsZo6x534
	xsMk5djiKAnnJbzLh/iUYdX/NOjREQBH0BtogklYZvcSL2JD2XJ5BCtvENm6O790cqfEPz5dxDr
	r/CACgnGIDrBGJFLLd4gZktP3pqUz4FFqmJXFnEhQse0YNO3oPPTlUieEei0mJ+UMUro3YOQMAc
	jUqeAsnvilnB7Rl6cWyhB0x8mlv1CRRIObOdQoh9a96sO3YpObe0qiyGkXNzHqisPBrvJSF/wW8
	3qoU0eOn5pd9Qe+TcFJ7/yE02zK+UEBrM8Ngy0AuyhfrPf5lrRtz5V0UxLJ2yIMM36TpqvKkvCO
	7yO4AuWw==
X-Received: by 2002:a05:600d:82d0:b0:4bb:818d:8d8f with SMTP id 5b1f17b1804b1-4bb88818955mr181628885e9.23.1795307071931;
        Sat, 21 Nov 2026 16:24:31 -0800 (PST)
Received: from eagle.home.marco.cx ([2a02:908:176:3bde:b462:7469:ce26:99ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9066e34esm88663715e9.3.2026.11.21.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:24:31 -0800 (PST)
Date: Sun, 22 Nov 2026 01:24:30 +0100
From: Marco Schirrmeister <mschirrmeister@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 0000/2144] 6.18.65-rc2 review
Message-ID: <awI18u5yuXDv-6rT@eagle.home.marco.cx>
References: <20261120055114.182757740@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120055114.182757740@linuxfoundation.org>

On Fri, Nov 20, 2026 at 06:58:10AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Native arm64 build on Arch Linux ARM with 7.3 uapi headers and
CONFIG_DEBUG_INFO_BTF=y works fine, without my local __u128
patch.

Booted on an Odroid HC4 (Amlogic S905X3), no regressions noticed.

Linux habicht 6.18.65-rc2-1-aarch64-msc-lts #1 SMP Fri Nov 20 23:02:16 CET 2026 aarch64 GNU/Linux

The SPI NOR flash on the HC4 is now also detected,
thanks to the HC4 DTS fix in this series.

Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>

