Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439473;
	b=z4ojxVaK4C2sTNxlieNcNqKjA7qeNKIr08wZgUL28AIJKfQuR+zYEaVR9uvfbWMS2bX1
	 vjZGN2SXet+/GC1UrnKfHAlnid1b5HExn5fqI9948LF9JcJZcnhdyiINHZvor960RPk6c
	 8aoalmjbG+yywuVFYOPtargueZCHmoPLTYMuwKpbSPZ7Xarv9J1fZ6Sg3KAzqUb82/OmV
	 3iGAxYgxoLV0iUbdMigQ2HznZv5kyKlyK0YBGuxFJp9vCOlBi2duw2eZbdKBEacAL/Q2n
	 zbxbyYQDTgZBGb32TKQDKZwbMoILvgOaNEySfeM589usPMzhCMCEcQvnv3WL+KaURVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=MOzoFV/EttzH2eSHwTtI7g/R3LIN8HHsyif9JYD5UCk=;
	b=ywaPzYga4K6rc3gm+DGnKYjl8LYW475sh/Px9Oplgi+Eoggx36w0OXxrpo7HqVWj9lnl
	 7ZDCGd4IJBXskbCr9VXlslwxNItxlZyAMxMyu2BXOB0SUdTPNc7f0ma3xZANbTGaR9T5p
	 03YDuM0WD1Ak6+JOLvxJPr6eYyhMtCJiw3zs5haVpUhnPCvgN35GarCx+uYfeQV33hJp/
	 FLSbenT2Xw979FV+5NAzWrBUknr75xs1dlJFiR2wWA+OWx4E0cTBXLVN/oiuKadKM15a+
	 HmtH+RAheyEeKafyXL6YD1cKVKQc9iR1ywpUxcOozsdYQRI37tGcJ+QhJfbDvqwskYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxL1fLbT;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93891606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93891606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxL1fLbT
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-492690dd5daso2953804f8f.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794439471; x=1795044271; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOzoFV/EttzH2eSHwTtI7g/R3LIN8HHsyif9JYD5UCk=;
        b=XxL1fLbT7B8Ga3QmZxdOqHNm1NQCEUVR8sxnEqrFd1fWxs5zkdH678e+tRROqw91Pg
         qLTkgD0bfQQX96dfrOOnp9Eb8hBUWM3w6yZKVOiTKDrXsv/fsO5DOpXLY/6WLMBv/16h
         0xpM6ThNUvUCgIsBlfegnAmuraVOcPDkXOuBH1EQJtizDynGDNXP9P84TDFyyoWcsNNI
         WxN9xDClqrMQpH8+xrzi8z2Zij4DW0DSfNTCCxFXzSfSAAX93bRcqZu8Igyw+/qRRAf7
         WsOEhMxTKX/ZUAeS+obTUmA/jJKscCU8W3zV0gGNgxJfEfJ0nhx172MwMz9KSrK8RPqp
         OTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439471; x=1795044271;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MOzoFV/EttzH2eSHwTtI7g/R3LIN8HHsyif9JYD5UCk=;
        b=hzhO4ayN/9B91FEy+j+bL1geqAVGRAYaPhk1bLtMduntrm1TRqTe6EcojWPHzp1gB1
         tAbWJ/NrIU4TlTijCCSa9Ql1hJhcBlcWcJ43g/cnBQG+bFp+sKBv5lOzdDQSdICVJD6b
         i7v2BSOYNZHAG7UW6PpPoVMFkVgPKvVbbtdWeyYQlphUsIOfxNynthJOMwXLYfD7z3K/
         hInMxUjxRUDs0ghP3GiOMQHIEfhgvKPwXS22mKZqT3HbAXlhUfps1BxWBohzihEt9B65
         wPyqcGJc0tfpfMzRTK6CS/Vw5yxHERcJ6nrRuJMLhyR6tC/1rd78gets7lO+GFmGEfxu
         hLDw==
X-Gm-Message-State: APuU4Z+UrOxyrRU58c9ILRusBwfcMrkDcn4QeefaazgALgXmNe7luMPb
	9mcW8CTDRWg0Aewip4UV46JT1GeWDBGkLKaFRT4RNsjtneEIt0q1qP4txXpcmxo2hAc=
X-Gm-Gg: AYBFou19LrLQyezl1Fn9TbnbCGwG9oscr8XZ7Uu7qU4uzbADKEoSaqp17ygiQ1SdHrr
	t5aEmBc1B9t4UkdmztMJZ4IlecVdzebf5/sN8lfcGC5ABHiKIPYQGVSPfKbAqHXXRkif4auxzvh
	d+MKTSr8sKf+pSuC+66JQgGbn/pgShbeZgJ4tbALS083UFT1xCLqQKHkty/PGyI6eO03vJtmn0h
	3INnF1O3eClXckePio7o71CzAh7I4+EyU45MFJYQFWQ7F4cW1Vl7s83lPqBi7jBM1qPl3755oal
	OtjhWf5cbbHKNq+RmKjRBNpnpOzM3k6UIEYBV5kO7DRtP0hqA5z1Gp31/Cew60MTS2V0klAGlON
	JkEZYoZgbsrASQRM/7r7w5Y4xmzqRRl1No9YZehu8krAs7XLmLVggMNjJBsMhc7xyuTdx+VY5Tr
	BUc6pdbQ+8O3796gJf5RuKqyCBtAvOUbDHn4oRJxxiyPka40ru2aWfnS09EZboSlMk0dzhTeovY
	TA1I7ElrmSEcC7y3OqdH7LYzY0xcc9gh5ojY3ITz1c0w/5ScgbmoBlK5AXncBV4GgTqlkV6ht0a
	mDyrX4ws3jQiOHb15qXB3+ARkyOhp7XPlmcQZ/P+SvmIOajavjUwKwCJxPoTkwZ7vKxVut4jfJE
	CzctZO6P/BfUlwqQ9scUXBI06S+elCF99g+RMd6n+1zu7LDUvle7pkLMZIeLc8YlpL7M84qK0S1
	Kxi2Q2Tw==
X-Received: by 2002:a05:6000:2203:b0:488:7df9:3898 with SMTP id ffacd0b85a97d-499caa40bfamr6264621f8f.56.1794439470962;
        Wed, 11 Nov 2026 15:24:30 -0800 (PST)
Received: from eagle.home.marco.cx ([2a02:908:176:3bde:78c8:14d7:11e0:20bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49836a9951csm13768927f8f.56.2026.11.11.15.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:24:30 -0800 (PST)
Date: Thu, 12 Nov 2026 00:24:28 +0100
From: Marco Schirrmeister <mschirrmeister@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Will Deacon <will@kernel.org>, 
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [6.18.y] Request: 10a47fb67340 ("tools: linux/types.h: Add 128-bit
 integer types for arm64 UAPI structures")
Message-ID: <avT46huKpXTv09GB@eagle.home.marco.cx>
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

Hi,

please backport upstream commit

  10a47fb67340 ("tools: linux/types.h: Add 128-bit integer types for arm64 UAPI structures")

to 6.18.y and the other supported LTS branches where it applies.

Will Deacon agreed it should go to stable and Jeremy Linton requested it
in September, but it doesn't seem to have been picked up:
https://lore.kernel.org/all/aplSEuD_h9OPOZoD@willie-the-truck/
https://lore.kernel.org/stable/bbbc33a1-cfd6-4cac-82c0-253888ca933a@arm.com/

Distros now ship 7.3 uapi headers (e.g. Arch Linux ARM's
linux-api-headers 7.3), and native arm64 builds of 6.18.63 fail in
tools/bpf/resolve_btfids (libsubcmd, libbpf):

  /usr/include/asm/sigcontext.h:81:9: error: unknown type name '__u128'

The commit applies cleanly to 6.18.63 and fixes the build. Only this
patch is needed, not the follow-up arm64 uapi change (d4bf9e08d412).

Thanks,
Marco

