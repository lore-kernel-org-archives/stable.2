Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441650;
	b=je5PWSOGSIcQ6Ev+TtLDLyncNbwHQwhlPTsffbRXfuoGthXFR6sKg5kuQgEZwaexJc5i
	 IrLAA8EtyIa9zNw5/nOPoIbVYbxgM5ueeUQzEcZ7dZL14fH/uGMvGPJu5LlahJhDozpm2
	 ExjxdbmThguVZA2e3t1wxSiT35MeXOEP5jvpK2Zyn/dX1dQwKXBXMZQFM36Osx/qeU9+F
	 TpTx6Ib4LTp5Mnz5PInu+ERBERol0EsFpTUMp/htx/c3oV2DKRzsEll9xONCrNvw+gjC1
	 56QEkB7AKWjFWk0LD95LvqStN/AX9CiXaqUwgUIdypSRwVjpJx2d9gKQBLfD+r980Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441650;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YLrN3M1XfLMhZZJEefU5MTc8mdCMhL4DOsawNJPcdvE=;
	b=UuDOOiBZTqOaHSzGSVYTiULfKFRpY6TXa+/fDjcNDO6yqSOUUcUwMbP016JusCBDIJJ0
	 nJUa2qz/684ofIDRAHcYs1nhKVptgNM2xBhsueniI1lQG0k3kB+EIclGT2Xx4tf8CXgwy
	 wvoCRiamE5mUJNQ7nL8UlQvqBhjfsNkPMvBPd/AnVl+mcVNws80lSkgLPDsKfmIjE3moZ
	 ufCadcQApVErEJpbQhdXhiBGXzull0SsRQ0IJp7sIY6mQF7T/CgGIa36EbYSzKd9MXtvo
	 yFLXX8BH36GrqXL06LlWFByLERSkV3EIUAz6iESOAb4HhpwD27ireNsPxJQxYy54LYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TEElbL9+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MVBeloww;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C2606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D82C2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TEElbL9+;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MVBeloww
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795441649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLrN3M1XfLMhZZJEefU5MTc8mdCMhL4DOsawNJPcdvE=;
	b=TEElbL9+IhYUMR7UShaacTfs3gUDH8tMqn4d9NxZXS4ymv+D7cBu12yLUI/B2InxToVw//
	pGmaiooHO3cFPO6YU/507LPci6u8nHA289zCvFOOsNPuP1iDkC2ebITUwyOfJGyZ3eU8Sy
	HI+8VYsqkkNbukLubfyi6Cruzsd6h1U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-oE3zmcivNOyWKfaqV9dPow-1; Mon, 23 Nov 2026 13:47:26 +0000
X-MC-Unique: oE3zmcivNOyWKfaqV9dPow-1
X-Mimecast-MFC-AGG-ID: oE3zmcivNOyWKfaqV9dPow_1795441646
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b586b0a795so2630830a12.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795441646; x=1796046446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLrN3M1XfLMhZZJEefU5MTc8mdCMhL4DOsawNJPcdvE=;
        b=MVBeloww5mnD8r+eZnMeR9Ryb911xBNhv7v00DCT4CrVvAkGS0sISuWGItbJQneRy3
         0UvdoxlIu0oGueA80re4THmH0qJzn6xTPAqY7Akc4YJmYOqvKYStjG4seCPZfft/cIum
         N3sje3R4zj6v37LhkkqAj/C4AZIOmN2o7QUTkvg2tzf84rGnl6ODVzWxTofaZyf2Xe9E
         H/x4hdFRIZYoN1OgkHMQttJC1G9F0OU+svS0ElyHrPzRl9iLPGnF9JGW1SWGLBPQyqYf
         0eMMV6yI+3E934FK3/RgtnAVXm/OTXZsW0AD4j88C3TlGX/MN16rIdKTDSS4FxthA6UH
         WckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441646; x=1796046446;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YLrN3M1XfLMhZZJEefU5MTc8mdCMhL4DOsawNJPcdvE=;
        b=CCE2i2TDwxk4598t6NkTD8WYt9ey8+6hMx//mD966L/41wkKjasRVdEaHHPw4fas2Z
         FukNw2fWgQgCXPpU/D7Cm1PKLjfH1ZZkZCLRMyN5rVobrBr3E2ol/QCbM8joKcaSEigY
         igJHbkZsgXf1eXbZkKzww/Ab1sVl0Kj7xyi3nED09BpDvZxcfrHdkgQzGOBPDEkpEFPj
         L5AxS3YHS6yTzPPnB3E2jTJXnsk3EPenzuE54L4iUutcZ4osvE2ZPvRYoLZd8bB7G7TQ
         OfejifhZsOrb9VzuMgAf0zEKs5RwORJY8lI9344Ox1Unjnw7rPsFsCuMx/uqZtJxOqBR
         JCwg==
X-Forwarded-Encrypted: i=1; AL+hErHjN5xtDVluWrDP4scSObYQ3feSmbFkKTI9tkDLrcJAt68ggUnPrAaRbyorKEA0fnnU/vr/rzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tpztMGvcVbXmN5eHR1xglh/RI5F6Lmoz2ewzOswP2ggQT5N+4
	TqhcoBMSsqirkyKLg3VEkfRrv+uVoUXPT/EssERQgdTQTs/Uk0gMtqjjfWA4V6KWhqma6hNVCpt
	v3LMBsnt/SLvLDb+SD5unDH1V7zK5rs+0rzHGRAmLOhm88JLHXf5tMFC7Dg==
X-Gm-Gg: AZFdTZebe+/HKhCHGPPQLSaz5gbqfAx8tDUEmFkOQEsuTqE3+n8yfAMmdXG076+c6I3
	QB1IGs8cY7+8B+tv6nvj5LuoYPvZF6xyMNIvTH2sKyPifj2TxXUrv1ccaaF9UOjJNNeNDocK/eu
	nHWtJFberoI+ptIARYzbFB1kaYzn5jyzoFpt3lfqUDDowefVYS8rMHoP7Bj35gTQKccGXYYNqxu
	J4SRLUXrjnOzoRR5jlfAbUVt+IUiBSnUTRU8ujBDoXpCgzzmvJlNUtN0v4A/g2fQrbdVQ+ZLA7u
	yLpRYIYJIqN9JVM4JuTsX+2QsFAyz0iENXldHm43uXoBfxJoItEUZCqgKc48hXJWJNlZCq2IfZG
	eth7vIHXWRJPYBsJcZhWmbqTPRj02YmHEjTmMbkw2jnUidH3MXE3BSd0XtAgo7ULlEYTxUZc3bW
	9aV8UGB2eYYeXZnTRY7dXXRfm2jy2EdloQkx297yTRIVMm
X-Received: by 2002:a05:6402:400d:b0:6b5:9849:e328 with SMTP id 4fb4d7f45d1cf-6ba37ebdda1mr7965710a12.39.1795441645547;
        Mon, 23 Nov 2026 05:47:25 -0800 (PST)
X-Received: by 2002:a05:6402:400d:b0:6b5:9849:e328 with SMTP id 4fb4d7f45d1cf-6ba37ebdda1mr7965674a12.39.1795441645139;
        Mon, 23 Nov 2026 05:47:25 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba37109c58sm5253555a12.33.2026.11.23.05.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 05:47:24 -0800 (PST)
Message-ID: <923664db-2b04-4440-8b07-2965c1e97aa0@redhat.com>
Date: Mon, 23 Nov 2026 14:47:22 +0100
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
To: Xin Xie <xiexinet@gmail.com>, netdev-bot+sashiko@kernel.org
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1f2ccb87-9017-4053-b8c8-5b31a211bd21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/26 22:30, Xin Xie wrote:
> On 20/11/2026 03:22, netdev-bot+sashiko@kernel.org wrote:
>> Can a plain veth slave still re-enter the xmit path of its own HSR master?
> 
> Yes. The redirect case exists without the patch, and the commit message
> lists it as not covered. seqnr_lock has been held across the port
> transmit since 06afd2c31d33 and 430d67bdcb04. The patch refuses port
> types that make no sense as HSR/PRP ports, which covers the syzbot
> topology, as Sebastian suggested [1].
What about explicitly detecting the AA deadlock maintaining a per cpu
status?

	if (<percpu_hst_xmitting>)
		// warn_on_once && free skb && return

	<set percpu_hst_xmitting>
	spin_lock_bh(&hsr->seqnr_lock);
	hsr_forward_skb(skb, master);
	spin_unlock_bh(&hsr->seqnr_lock);
	<clear percpu_hst_xmitting>

/P

