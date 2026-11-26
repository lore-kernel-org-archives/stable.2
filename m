Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795720884;
	b=hXeMO5YSBifGbpdkKMDgB5xjO9a4wEVOLqLCjSnWgbHyQC9vD9BzGCyA/Cddz5wSQRhn
	 hXJGO2eE4VeOAxHqtPqZ0GJWfXGBBJ+hqOvk2d8ZDOAQor1tYtcLt1LgLwhP3TX444oga
	 /es3q+E2DC3N1YCddfti4C+f8xZunLJv0rbSVNic6TuaH+t1cAc32TvgY+7lVsFrD8HwP
	 dzjgvuw3FCEu7yQRd2vtcdtEXfXBxY1RlHlPKATX4ELkX1rp4O55a46JosEW22ZNSLN11
	 e5IOkHTCJRBy1Bar1E5nXF0/o2Cnu1AlpdXXPJHVOxcFQ/YILMR6WjVAOPSk0si2pkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oxIk9FvIh0u2YzbWxdwjMI8skmCOeZZ6dGUk74RsIms=;
	b=MeQj4CsLJtoC/JA/7Eex2a68oTSZYhTNnUd4vJWASrrxwF0ak6xeAxYIKusTh//Fy8TL
	 EeqfRhdOMXABsdSutmCZjwf2pOPw8SZ3vGxp3qaf1DbqgggQrhGoymRezF0uADm8vPhlB
	 mIRsKKa19FSovrnCb8+UKMI/aaD/1qP4rM1rBIOck3LTIvUhykS2fSkfiUKS+e/zhTzAA
	 fM9M/U9ewGVNBWJC+PunVYNQugyMB/XfbvJpym5CIlnLEL80aeVLcsaOtXuGODN/fTjgo
	 8BGW4PXldpbjH1Ch+gwphL7snUH2EbqWrkpSAjkGrRuIJbWRgpL+4CKjbtEETE/9k9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xn/ubnZr";
	arc=fail smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDE606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 19:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3CDE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xn/ubnZr
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb606491faso39153565e9.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 11:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795720882; cv=none;
        d=google.com; s=arc-20260327;
        b=PzAdT0KLrlnaUBm7k6oV/bBsVVoEAHuz2U23MbseDjFQ8eVgDK3ubEm9sc/g73CBWW
         nvNTPqayZzTaZyExF36JnsEMOKTCfoIM0XwElw58TxU9o7Jn7Gvv7iZnqLLRzvYqcj8u
         W0XwAAtQNu0hJYK/IbalDpktRIyLfYgBCAIqFl1X7waG55PEBo2nXo9qGjxL7vPxyRIW
         MABBT8ZN+t5ABuHe3gjy5QWxQUTDOQ5AdhCrzonC/79DESr+ev5ZRoScT9JEYiqjGiTv
         A5Rag/L6OpEpRSUcmT50m+/C1r5gD0kBeghitTQXkapXllNbqoWJeMnGUWT/8BVdil2H
         u9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oxIk9FvIh0u2YzbWxdwjMI8skmCOeZZ6dGUk74RsIms=;
        fh=E+K2kqIiKsj50dpAKABs13b22ag+2X1X27ca1nZfbPc=;
        b=CzjN6Y9YIE9vEj+pIcE9kqw/P0ouuPA0DszMj0v5b+ovASJN8r6mHkG9/sY0+Wu8kz
         3AbWuDoWE8XwDkFvvwUPc+UBAxgUKUcoJHb9oS5ivEi8tPt6YH//t6MQ706I/ylzNThC
         xJXrATCQ8oxm2VPcOGxWeGmtXlhWiJ1oN9jYd8i50VB3BxzXXMTePbzFoIJi8quimrBf
         IYNj9pMvNCgefgJ67PjvADFogqMzcjCVuQB/k+gMN6lyCCQ3/m2iccvAbh2lCH8P4s80
         JrbLQIPw8dQJ1tdywvPuaeeQj8hmbAaRPL8SG33j386y5MAxyQtl3bpMT1OCdeDZL/rO
         JT1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795720882; x=1796325682; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxIk9FvIh0u2YzbWxdwjMI8skmCOeZZ6dGUk74RsIms=;
        b=Xn/ubnZrxwED+WHf0P0xqhy2VqpnM1a1PrjpZ86uTk/Avb35f8+NyzOkNgRiNmvEOo
         iOJQ52SN/ZBKXB7iK3Mo6CYGXJ9MURyfpHOkawkyh9hRXtl2DadGMMbuIkULPR/yV8nx
         LF8H2ZLNs9mlVwWtUSeUFfEiwNcU+1eXJ4YAR+X+ySR+jceuef3w3vt3DhjEbpXgKSda
         +LncFbusVPJngzdIAxFEeUqETzlmXYeYMrZ28WeCUTrrIKii92Y/s4DoPaZKhQFpH2GA
         Mlu/A4TaLWgMSHNZo/SlUhIjo10Nb8RisV3/PEzvTI/668iHo3o3tlr8aYLcjolnj6Zi
         EHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795720882; x=1796325682;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oxIk9FvIh0u2YzbWxdwjMI8skmCOeZZ6dGUk74RsIms=;
        b=HVYGiPnN3Dm4OGEOLkIteo9SolABp1zCaEM1oCukBChm2hrInpBduYxWa4MSjnFn0P
         BhnmDtKPE8CWH4D6yo91NGI8uF68VHOqbgFA8n6zm0YnncquiYmttnNG6YKigz1D4fQd
         IpYRG6oUXqF8AX/YFptwJmDsGbuJHIvxbQDSlQFjzb/3pH2UH8OdKEBRpdHZuGU0gXfz
         Sj7EDR//bP4BIOFc1yYvgxdpnCNdmMQhOjsINXligkj5yobHxplPQbLOEjqPP0SSTaJh
         k0q78dVSg1OZk03AKlakCj6QaxT0ywsbmMHPwdIsYkwKp5R/pgFMCuY9QT8sWVEF1w/b
         UKyQ==
X-Forwarded-Encrypted: i=1; AL+hErHzulKtkZhPV4revne0wYyaDyVG8Vbk+YHe2AfdBrx1T+YAE+o4aIcRRit4f55HPbw+M27Zo8A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cuKs8skslKd3mAE2NAx6KSeF0TNiJLrLfUEeXoE5QI6mZ6JJa
	n8S4t/ZClv2GroyR4ZXa+rJiSCuPKJisb6jgu5yun88nebLqdQFlKpIxBtmJxX2d7q8SegFC7DE
	QiEvqd1wTc5coPnNfYWnoOkV4Qs942ds=
X-Gm-Gg: AZFdTZc3bJcqooUoJfbP45WrXHRU2JDZFxK7KXuRVv+L13apqIW156XDssWkA40BpLn
	ybXCPeqceMQ+rtMnWfG2TFAwWoxCTnsE55EwiRCSc9tpuOiPyCswuX/nZKfwv24qwee5dMA4Auc
	vyh585eKc5mJtjW8uhaVru45t2TKgJFQ2RRKUw4putJ6IPpno1F6Iqh9SVtmzp7s/u7mJGDb/OM
	WosPpFKpHsL77icgp4uK6Wswwck/QDD/C8KHyaru1yY2Qwl0HnMiucE5PI40kKdFNJjcJPwEyzv
	PtHBb+ve+IDo7Fg9DLFkK4hppiO6RKOIzzHItu/HDYEv/KMHKMVSOb4scze30ATbZE4ixNQPXz4
	ufoJ72XmXUfY/hYPGSmw3WpGKfBOZV34hjubljPTAhz9e4eUb9Q3gcL49XBE=
X-Received: by 2002:a05:600c:5395:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4bb8880e599mr444641385e9.8.1795720881927; Thu, 26 Nov 2026
 11:21:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126142406.2753290-2-cassel@kernel.org>
In-Reply-To: <20261126142406.2753290-2-cassel@kernel.org>
From: Mohammad Harsij Sani <mohammadsaniac@gmail.com>
Date: Thu, 26 Nov 2026 22:51:08 +0330
X-Gm-Features: Aa3M54qUdrB17xA1QvQrKJC2B5IlobRrnk9BLGrLk2G4VHKEAcD9kuZ0QWWJnmQ
Message-ID: <CACeOiPgQQvrhyqYUJRnR6dxKVuNzoWQWT1CDUUp+Z3+naCuf+Q@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: Disable LPM on ADATA SU650 with
 firmware XD0R3C0F
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, stable@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas,

I compiled mainline Linux with your patch applied and booted it without
`libata.force=1.00:nolpm` on the kernel command line. The quirk matched
automatically and the SSD stayed completely stable with zero timeouts or
errors:

[Thu Nov 26 22:30:15 2026] ata1: SATA max UDMA/133 abar
m2048@0xb132d000 port 0xb132d100 irq 123 lpm-pol 3
[Thu Nov 26 22:30:15 2026] ata1: SATA link up 6.0 Gbps (SStatus 133
SControl 300)
[Thu Nov 26 22:30:15 2026] ata1.00: Model 'ADATA SU650', rev
'XD0R3C0F', applying quirks: nolpm
[Thu Nov 26 22:30:15 2026] ata1.00: ATA-10: ADATA SU650, XD0R3C0F, max UDMA/133
[Thu Nov 26 22:30:15 2026] ata1.00: 468862128 sectors, multi 1: LBA48
NCQ (depth 32), AA
[Thu Nov 26 22:30:15 2026] ata1.00: LPM support broken, forcing max_power
[Thu Nov 26 22:30:15 2026] ata1.00: Features: DIPM
[Thu Nov 26 22:30:15 2026] ata1.00: configured for UDMA/133

Tested-by: Mohammad Harsij Sani <mohammadsaniac@gmail.com>

Thank you!
