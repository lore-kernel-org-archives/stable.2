Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495196;
	b=yBgu6wtkC8wisN3YIg8qKYHILmpTHeJDwT/yI/jOZzs96hnW3xRIPBkVJDnqX8zihn70
	 0XdZrmC1+9CJydoTD7tKfrm4wBQn5DlMU1PqySu1LmmICgxHaMN4Q5G928Etr2RKUqT/g
	 SyDon0yjxOBX/S+AskVOnjCJDPeap9ftfh9rJ7/kD4UTGegN4jra76vDcXHFqrDngwMRj
	 DpLJJK/8QNac2MCDuytM8r0F9HAURZHsJZjWynuM4k+o2X3hqNnQHynaXKer86beyAKl8
	 OIpH0f6slFk7DxS+Rmgl2q+8/WI0djwJGI7Nt3MZdU3HOp8RYgBKEAD3GfOVTKqY2SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=e8hU1KwP7KOcNpt1N+F1VtaFHoAealByJyBT1mkquWA=;
	b=wZLbLnm2hUxvr1a7Jyt3MoyBkTaIhXkgOr+Atv0uCTeQleAGMHIje52T0TWTP7gRG5dx
	 PZnLgy5+QSOk0lZfvC075XH+87GAOk6y1Mjf41dr+e7UrAgzJwiMkIs0OjicQcrumKnEt
	 LdaQktfd7JMjfKQqcmR9dHk3O1cHa8D4h2vQ17lhe6P+d5UPf3TobfPGIo0wVcMmTEyT7
	 ofORNJKseKMawgEedu1ai9Xo4bZYfRW092FJcAp5EkqppRccMx/ePyLFufEBjscUEJWNc
	 0WyCajBBPQtZYStvaI9m6l7fab88/+mkQNMtYUoQPcgQFMwIyrcWaRVZhntlCFcWY0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZNSafUon;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3A606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F3A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZNSafUon
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-386ab9ab619so3823309eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795495195; x=1796099995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e8hU1KwP7KOcNpt1N+F1VtaFHoAealByJyBT1mkquWA=;
        b=ZNSafUonYPg9CR0WBoVpuOFRKDVjdqJxBy7Np4xVHLU6KbfVFy2IcQKTQP4x4ahlf3
         gn2XHC5I7y/1z0ijw+UAk1opNdVHeRBld75RlyGjFCryuQDrsn9PCvNhub+MHUKWwTZ5
         L5Gdw2ydTqT7IdicOBXLAbj5aYQ3FphxhLUn20Kx2WagUpr6w1wQ93rWZBd2sxO2LZ6A
         Jik3VEcYeXJMiOYPFVuOt3HEYFiL5SNDZozzYsKPvS/ArZR6NYu/G7CHNC1S2eloB5+P
         VLLxcld9G4pcqGOI8lNGUSzKBKWewTUYDRdo21VFbH3IosTSShbDqG/HwrFrEd4i2ZG1
         pB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795495195; x=1796099995;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e8hU1KwP7KOcNpt1N+F1VtaFHoAealByJyBT1mkquWA=;
        b=MxDd0qCr+03FQYpn2YoaaTIgnX8+Ku1YrRUp9v4XHqpIaBD1TC2HtPK2zKPqutJr3v
         9bjY08I1QgtjKaGFibqKuyZMXoG55UPCOnBX+g2cE3lchihCktVLgTiioMg2m7RpF3ap
         0rDC+F7HL1mGhmXWfXjqC2SAjheKP7Kbd5uMEFlrTb7gYyZ7O/RnokUG9ow3YE7Hm0r8
         4TuaCGlbJmzMiccFcJ12yP58LD/OXCGcAPFnU/boItQnzLZ2JLh6LxsTCRDDh3SdSk3r
         /CE+9rQyFmkqncj9oxnsoKL0WFGZLlIeryaVHa8bfzw6gkd4KVGt73Legg+U0bgnfF81
         bSpA==
X-Forwarded-Encrypted: i=1; AL+hErHdTFUwKLBM4FReqpI7LyDjmrFtqUv3U39lJvnx6VegJhXqeStGDU+0bWrfFOfPisN3GVGzbQs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8E7BV4uKWcDo3FWh1HTRQweWllcrYtNp3gKKUGb+D172a4IggR
	Zn1wnP9yuLK4NgXey7B3X6o+4hZpJBqpg5FkGS4PR93Lr3sGF3tTk4Pe
X-Gm-Gg: AZFdTZfemgSRNHktbULtRmIJ8nUeqakylrq+RpxWZCudOuus9KLW3w3UiMD7No7wcY7
	NndwD+X4unI87r/c6Rxbg0nRXIqklA9tAZZHGTR7IGEvzOqC9jK31SFsTjEfiTfzxcAEQRtIaAX
	j5YdYD0ws7O+RIHEw8NWOC5fZ2z3MhW43tgjz210gfCsKWOSE6BRvmEPLxFuxr+mhOye8SUpU/u
	qH/ugJowZDfyypsIiN6b6HRBptq6btLG0zIny6ngW4+xb112gnIIryGlNZXSy8EqFhJqiIV/wPq
	dGrjrmBsl8l4wAIOu5bhUrprbrlu0Gp2reJr7t/P5w7oKkhgmXXmWApmo7CD2sCDvklDnrCvrki
	zMjHnuOmB00KzQoALaDO61d3gIG+Ff3uMZLPIPtX5/+PVknWbr7+oKo1TxYn6yX6GY+v5Rx0DNq
	1sirMKIUmw81iLtPGGgzsbwrliMaZxMOb7CAraX7FHfFmER4BOMalQEiLgzfj+tzev6Pm/ZStab
	I+tkB0tXtQpNEbErGbCIFrchTKp4lAPKtdohkERqA0LOMwkBngz/Z8rRSAUkcw+zErhBg2Z85Fh
	mtKFhCTAOf40XHLqMYZMRto8oG9yahRUCx6l3q+EmN8iw3nAd8qKn/pji2dHUuinAqrijaY=
X-Received: by 2002:a05:7301:6405:b0:381:a3bb:f945 with SMTP id 5a478bee46e88-38570254ec3mr16446848eec.22.1795495194672;
        Mon, 23 Nov 2026 20:39:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c349csm43149340eec.22.2026.11.23.20.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 20:39:53 -0800 (PST)
Date: Mon, 23 Nov 2026 20:39:51 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: filipp.dunsky@gmail.com
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: sx8654 - fix SX8650 reset and status handling
Message-ID: <awUVCt-TC6HaC-UK@google.com>
References: <20261123-b4-sx8650-fixes-v1-0-b82a881b971d@gmail.com>
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
In-Reply-To: <20261123-b4-sx8650-fixes-v1-0-b82a881b971d@gmail.com>

On Mon, Nov 23, 2026 at 09:41:44PM +0300, Fil Dunsky via B4 Relay wrote:
> Fix two independent issues introduced with SX8650 support. Its soft-reset
> register is 0x1f, unlike the other supported variants. Also retain the
> signed SMBus status return so an I2C error cannot be interpreted as a
> conversion interrupt.
> 
> On Almond+, writing the old reset address acknowledged but left CTRL2
> unchanged; using 0x1f restored the documented reset value. An isolated
> harness using the actual driver helpers exercised 39167 cases under
> ASan/UBSan, including negative status reads and both reset paths. ARM
> built-in and module compilation passed on Linux v7.4-rc4.
> 
> These fixes are independent of the Cortina platform series. Local
> OpenWrt conversion-rate and recovery policy changes are not included.
> 
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
> ---
> Fil Dunsky (2):
>       Input: sx8654 - use the SX8650 soft-reset register
>       Input: sx8654 - check SX8650 status read errors

Applied the lot, thank you.

-- 
Dmitry
