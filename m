Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525577;
	b=kxLTIkD7qDldnB1SUvDZglS9mGmBM5+UqYZirqjGMP1xpf7IcLBIDDNl4+j/6Meqh/fk
	 VW6Jx6iuqh7HGxdax8xqXAqkHQsMeZSJbCEim7NhRqVMnkPIjRDeZzLFuCsCKBmQCJxZh
	 3aShvBUG5wiPrSKnkTKs6bQDkqiOIfKIE6oqIIhordta9OO5VmWy7d+C3qOT3bxg/lYB+
	 Q23DLFQFDTVh1tThKGSf7wXI+LFhLjeptXUsSOtGERfJL2wkho6K8eF4UHbmeptRfWEVm
	 yVBshMZWkyx9a0KGBS0COiXvMRw3hYduqozX5+92Ny7xNjXlOHG6aMuAVrbaBkQZDvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:From:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=q5dIIGVihzd+X8s26junyurvtIQM21LadFXMcw50iWg=;
	b=3Nd6jaIPR7OVIYCxln+eWounNKcc25qIGD5Hf4jol19e02IlawXEFjqi5OKM2w9gePJw
	 tkRZVXEYUlPYqGEkk4QubHKd50p2srYCtPYp6LG7yJoZaW+jfwOMmkSJM5ElmLXQT4nWj
	 jMoqfWRSJuOGa2p1hyPfZg7hTPHDN4z4EzokqmtE0yrmAkhrS5v0DCaskuqRZ460Jswe6
	 gXdQBqSyNUnjq9VJMrX6jZDAOGTXziTLRYmyTtLY2z1SPVAaUpv+BuQbVlJlq6xSsxbW8
	 I/zhCzbgQgrwuBtR2tqmgGY+Tz3UJX+fMiUH3D/IodByXsdYnfku4ssbYxX//L7iZRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qtec.com;
	spf=pass smtp.mailfrom=qtec.com;
	dkim=pass header.d=qtec.com header.i=@qtec.com header.a=rsa-sha256 header.s=google header.b=NSmsyM5r;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B4606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA6B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.a=rsa-sha256 header.s=google header.b=NSmsyM5r
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c51a02ad3acso412666b.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1795525575; x=1796130375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q5dIIGVihzd+X8s26junyurvtIQM21LadFXMcw50iWg=;
        b=NSmsyM5rbRqxtoIbCdqyWCMq+qiws86/VQgaP6oiciTYLH3Zx+3KXs+CvlE8NFWqbs
         aO6088ZqNDSy0TKt/t0HcQR6E6prJCOwFxuhyVh+9UZjhXwCiCGGbm8CzR+ncM66OdX2
         nSK9Ie50V898V8n7GL0TeNLMPN1EL90nRSFzqxku+F9YBp6GS1q8oRja9xUpW+82xeJr
         tMpRpe/JWpn/USVbTOABVl2Ep+s1baVDK/wG/PNn1wueIvq0pofIZl563QOAmTfyBrp4
         N+4jGakwb6CaAgO+1p+4GxBfYPW82O1EbHVFUxssBEM2EwwZvpRcam+JRsU+YDfGDTHa
         MtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795525575; x=1796130375;
        h=content-transfer-encoding:content-type:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5dIIGVihzd+X8s26junyurvtIQM21LadFXMcw50iWg=;
        b=dqNqWca0egObmQX7oa3/qf02I7lNS76mqRtrhxexDVnFSFr5XJIpjIBKGXVAecwELQ
         fMidUbBWEh5MCqrU98EW6zz7YKT8m1Cib442pN34L5uZOFleLcLHb+gHnBBoT1VLTBQ0
         q7uvV1J0ovPjzU7XQF3TUQoVudiyDsImzlVTXlqRBEHhadKZzOJKhbJ7zYewTH5aWIPe
         b0RZxcSLFDJ/VwxhKEumcZjDgqrImGJdzqYuY4jqGlgf5iHY+sL6lQgyv45GANAsb92q
         xhNqGXxFk7/KBE8QUxDIPi5Kd9O6LcTkeqtVCIrU2uem8iAcL9V+lPJCh6cqayGSgtEC
         eMUg==
X-Gm-Message-State: APuU4Z/TcU+hvlhXdrjAMQThJ/WnNuS8yEX6y/nPkYW4KP5Ly4jlcE2h
	SzkeUYt4g0qnHjHrrFNwDsN++Gpj3mmkJVaFW2G5oDOX0KJv8zXxV+MbS8VAC8yjULBIHDfZZi1
	2XlktFeYbSfEbFbiGQXguRoFDO8cLqaJK0iQmb066/OkJDrdKmVhljcQIVQ/Xl1n5SBOi++jBmO
	W4J31dISWMbH+wQGLHpu0NtIR4gKNBO30lUA==
X-Gm-Gg: AZFdTZd5QJVTApZyXJ0cZuS3Mklba7TO9zdLjP+7GytyWmzSLmiuv8cYS2G7vjMHqwY
	D2s37aUrGnMz0Dzd5viWBP+lDHqt9ENEK9ebhrI1IAlal/L9L3D8INyeJN6fAFHKSrxgdhEhJER
	KZC3y++D9H+lh0wvXWQyNAvNADtYQURWe3iWrOynWT1M7STrd+xpKLXsDgEkORCXyBfKjZAUv2K
	6Mb0rd7CP8RtNl7jc1aJ3JVMZkNA74xBlLO98ODYBs+cuKTmU0052m3+fGT1hw596XassX789iz
	f9nZT8aukKdfF/gxal1DORmgnBM+Kz6nitWiq0Bn+fNsoxo/iC0srpNbTxSXJOV69aet87eM9+c
	giFeRv/IiHEzTeR0LLQb7NVe6hFPxXbhSVdrBP5ktJKgBuH4DnFOVC2SctYBNkYJ9z+MGFyBqQw
	/nrhOakuWdyuSpLl+HGkg9ie5xbI12A27PQqeM1stIye53qm/9PFuLfW3KIx/XSvqpfds/4bCKV
	i4zhoODm/PHDU59s51Nr15wWNlzdTiF8V5VLg5xDT+yp0yzP0sT22WjWaf8FuRS/6LZyOkakW9j
	C3U+xgcH3KHfV6EgCW1rV4axlxy8zCBjurNnwCbAhszJ5rcHTVORrcbn344yRRgk8aaorNQ9THQ
	1JNLb8XXhoG7mUwhRZoHBm+ctEF2qOZ4YVp8oz5PUP2nXaj4dSXCn/6/fC7crbdpNFzPg2V4=
X-Received: by 2002:a17:907:9d1a:b0:c51:3b58:b99b with SMTP id a640c23a62f3a-c513b58bc59mr1191794766b.19.1795525575068;
        Tue, 24 Nov 2026 05:06:15 -0800 (PST)
Received: from [192.168.2.43] (cpe.ge-3-0-8-100.ryvnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc73d3sm502810366b.64.2026.11.24.05.06.14
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 05:06:14 -0800 (PST)
Message-ID: <768938ea-ff6d-4fa8-bad8-fcb8713a008a@qtec.com>
Date: Tue, 24 Nov 2026 14:06:14 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Lundberg Pedersen <dlp@qtec.com>
Subject: 5.15.y: Missing "nvmem: core: Check input parameter for NULL in
 nvmem_unregister()"
To: stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi

5.15.y is missing the commit: 8c751e0d9a52 ("nvmem: core: Check input parameter
for NULL in nvmem_unregister()") which is necessary for the commit: bcf4ef28b083
("mtd: core: Drop duplicate NULL checks around nvmem_unregister()") which has
been backported to 5.15.y.

Regards Daniel
