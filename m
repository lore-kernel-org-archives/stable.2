Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470716;
	b=Wi6hkD1ZqQNujyAmz2ADKWgWX7Jn1v+G4gHYupPYUU0l6JkYYhoy9qgi9rARR+8pQix4
	 /SbGLpT8wIZdtG8vuQ+6LxzJbKQgphUG+Cu+8rORZf+TNRzUeeskad5Cd+N7QohCCgM2T
	 1muLErS94PIPCCWekzwF3KFL3UksNh5j4G6RztdN/zDiHFyNgaIQDOwJi/lqSE3nVwsjA
	 LpwnGuJbckZRylsYIZ/rQ//U7Zff10XWg8mU6eYzneHZWusBnTdyU/WUDRqdEoJ2CX38f
	 BgKGMuikn784sRt8dUFnb2glTI99P85TcVbvJISr0Ttn4RSFYYQNNo6hb/hUYYvMQeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2UGY/oTHLWmVAYjT8YaGDfb9jGbAf2o4kEDKWYab9wc=;
	b=uuAYS91SEOeOesz/0QRb3FHCDLAJKpN4Cmzw+XEwgrsGF7mEum5+PDdpnfhVhMreYHVF
	 40cZw2dX/QU5v85tXSRCoGmKoTOLw8hed9S26fxrY5+ChQe3mjSouasMC8vJ4fuIe5JWD
	 V8CkW91skKvqokv1m5lWDhXawp6bPM6WOzm65OyonwDTBJROqN9a31uWAQsfXpJbzM/B/
	 D1NU4it4lZBMnrYq7wVAV3+rC+0KOLOcHgWrmdIhQbE19OD+u13shDOtxRqI3e6LOvnYb
	 MIvFid0Wooay7JX4Gz4t2oOJopaQvO+lYsBM81QXV0jkYcOdI20iORsVsAMfZnSm3tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFcsjKfv;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FE606A326
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 21:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4FE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFcsjKfv
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb609d9bf4so8623525e9.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795470715; x=1796075515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UGY/oTHLWmVAYjT8YaGDfb9jGbAf2o4kEDKWYab9wc=;
        b=cFcsjKfv6H9NbIuMZZX7vTjnybJSP55lQ/PxodsxbdsBN7EPPVCukPjsOdQG1y5Swm
         vAt3OTEuzeSgbrg+4u27MnR93ucW+/AsaF7XAUJ0T8kgemKdrcLcuuY5cvAo+1YDCNMq
         Ho1TaYJg+Mue/Ykk64koPLvfAbnj1cR34lR0Da3uT6qj+mhmN0w74T4kGfo8TKGzZhaS
         wxTVUnkDXAPBQVc1MT9D/fe2LNwWGNJIOlVeWwKhYTu4CHNOTRGuM/FJJ3nFEA7Ml/Hg
         Mdm/efETk1APSp/NObZwp8Vqw09UFOiB5SUcMAQ6JJo5sapV+Q4cR/Ojg7DrgwUJxqkL
         D7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795470715; x=1796075515;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UGY/oTHLWmVAYjT8YaGDfb9jGbAf2o4kEDKWYab9wc=;
        b=gJ+hBzMWm7cKPQLPr0jri5Uq4lzXtTC8WxlL/1tKJPqvADWIuTkziqt0qVGOAkcn7x
         M2QUxEAkZsVdiyrOWEf/QEEFl8gNXXtZZ4FH6gJI37YU0IRsAayPSiOx5BhElcD8/J/f
         hg5NHqGI283eKq1NYmMWPvB2s7tT+aguAQGcz9jrpvKDFTCV0jRDdtvO4O0wek848Oir
         RyMWaElqMagD7PyWoB+NkFZR6hPHCFK7Xbvd3ChSnz1dHBYX3haubE2Lzg0C7L14Ey2S
         oTFq1E4t4uQfbtexihLjtSC5CQ2gw456CUNWp3XA2uiRuIYTRA5DMYKV89LAsxQhdVg7
         4d7Q==
X-Forwarded-Encrypted: i=1; AL+hErF5mn52vh/QToslzkssRn5CbO1mjo/lNT15Wat1G2fQADzFk1wJu+fVgsWjap05GmC9kiSflB0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9U/HUQcMDBqQR579MAHL5VNUbiaeEM/lmz61wq+6vVVq/8TYyh
	8GTP5nHVT3c0mWDI9mFUfREnnnLI9dQ+QAoKZ/tReJSdq5n+CO3HCOrK
X-Gm-Gg: AZFdTZdvKCWzlRFzwWddzSLVHfSsw7QYlbKYYwuEWZyMU6dRzMvz2RrnyV6KMuZETC+
	osjeeZOU+vlfcnrI6WOjPUqst57SA8GrC0QkJU1tML6zme64jEevr/yIFzRxP4rxUggXTV7DIUO
	5sycRZtCGZO/lN7+lW+UMQK4dM/bm6FTRcfAWo2xVoubqIFEwKcL9bs32ZfULgOFy7F3rumwcZn
	zBLKP5PBS+AYt8zpXyI1Q7EtMDc0JjicCUPUqNu07p+MtbLigG3NWXV9R8mRgoQxokR/bI+OYzy
	aKlznXLIBXPkBRCsRGnsqBmHp8RAdDpc0HS5PIKZNr+xG7WDxlYBMT7K9330+q3HMOujxxWnOId
	vFUjWBQiwZboGsMUMbjV+jeikm/uLKBhRr5dWIwoeT3DZjG5ZSrp0FCgNfE3aiJxD2DclIpqJkF
	n30bDCgSgoyDMTq+ytir4v0TnqTMq5HZ5NhfUulxubChZMxD3VyPOy6ZQf50t6sZ8SV+z5mcleQ
	SU+DnuStnsyW2h01AB70gE8XT6qbBnUtUI3ESqLra092D02ovJ2O4jZw+OlnqAPIl6biLUpCxWR
	SJln8ewt8s6mDXXMVtCqnURrZgxMegIKK/VJQXBC8MkQKTbrr+liuIuxfEUly6/31MWJ8vCsM7P
	fH38eJZY4DpegoEPu4oOCPCqoOx+NlL6CeeIsMevYawXxSq2aJ0LrcSpJ33ZHkiQGuUbv
X-Received: by 2002:a05:600c:8a18:b0:4bb:7ad9:301f with SMTP id 5b1f17b1804b1-4bb88806505mr189200245e9.2.1795470714642;
        Mon, 23 Nov 2026 13:51:54 -0800 (PST)
Received: from [172.172.2.5] (host-188-174-207-233.customer.m-online.net. [188.174.207.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f643adsm170594995e9.1.2026.11.23.13.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 13:51:54 -0800 (PST)
Message-ID: <f5984b2d-6886-458b-baca-43c76669d2fa@gmail.com>
Date: Mon, 23 Nov 2026 22:51:52 +0100
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
Subject: Re: [PATCH net v10 2/4] net: hsr: refuse forwarding devices as
 HSR/PRP ports
To: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
 kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
 fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
 xiaoliang.yang_1@nxp.com, skhawaja@google.com, liuhangbin@gmail.com,
 stable@vger.kernel.org, sdf.kernel@gmail.com, lukma@denx.de,
 fmancera@suse.de, danishanwar@ti.com
References: <20261117141922.20-3-xiexinet@gmail.com>
 <179514132185.3136.17085396682149520983@kernel.org>
 <1f2ccb87-9017-4053-b8c8-5b31a211bd21@gmail.com>
 <923664db-2b04-4440-8b07-2965c1e97aa0@redhat.com>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <923664db-2b04-4440-8b07-2965c1e97aa0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2026 14:47, Paolo Abeni wrote:
> What about explicitly detecting the AA deadlock maintaining a per cpu
> status?

Thank you for the suggestion. I will add this check in v11. It catches
a frame that comes back to the same HSR master, and the locking can
stay as it is.

Interlink input and the supervision frames also send to the ports
while seqnr_lock is held, so I will put the check there as well, not
only in hsr_dev_xmit().

A tc redirect back to the HSR device is enough to hit this, so it can
be triggered from user space. For that reason I plan to use a
rate-limited message instead of WARN_ON_ONCE(), like __dev_queue_xmit()
does for "Dead loop on virtual device". Please let me know if you see
it differently.

I also plan to keep the port type check from this patch.

-- 
Xin
