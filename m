Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805A4B049F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636589; cv=none; b=JO2rvLkZxeaXl44rdJTYptyUOOOjr/A3yOCZ0WzHjyc+jdu/keKJ8rh2nCiiyjHO4aNBR4B/qiOkvOeL+5CePPmWcDK8ynPU6r5l1nKq3ltvwdNfGtpen4KJpBf97Ocl6GCAShjdIEhenjSDnt0Dx2aXv70+DRkK0px/WOxFqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636589; c=relaxed/simple;
	bh=wVFGrWQQBa00Kr1v3u38oJ+Psc2Uy+oa8aI6FjA0COU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQibdQamlH8ZM/FRGGS0RG/3EGyR8KQ1gX4agaKiMCzrvfayjxOc5m/X1NEdZBcF0B666E6HTVBQF/Po6Qw3jh9GJZOsFv45IqkHsznJMjsek2w7sZEUzTAyvydCIG2sSPiBJNrmFlv6CorfL1af9uCEGoIIrZab0/FuNapT7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVJadweY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+P6SdVe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVJadweY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+P6SdVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789636584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YasMKQ2T/AatfsN0JjpUO/fKJtg6yNiDvHeBKdEJON4=;
	b=FVJadweY/p2GAFPubmv+sYFhRnd8PdFrWlyz+762gHnnsDtsDytRKOOP7oeP2GHIUtfgZJ
	PtMcHVlv5OUkL+xgAAG1hQqEPlRw27mJo52tA8g8yYUT0hNXHl2vh7P4IHB384ZPKbQdYp
	15r8AeLCsxBcWL2tKNy2tZbAAZuaWlA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-lp3oqxtDNb2K8h1DWL4-vA-1; Thu, 17 Sep 2026 05:16:22 -0400
X-MC-Unique: lp3oqxtDNb2K8h1DWL4-vA-1
X-Mimecast-MFC-AGG-ID: lp3oqxtDNb2K8h1DWL4-vA_1789636582
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-486f3c0d896so367535f8f.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789636581; x=1790241381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YasMKQ2T/AatfsN0JjpUO/fKJtg6yNiDvHeBKdEJON4=;
        b=I+P6SdVejhwgRieImpF/lHGRd+wYWPhq4gVaoxap5KUvQQHwjurNfGHBFXw2xP14rl
         D9pOFxOpxpJ1xjL+x4AWXq3ZBhJvnFeefxlGMneXIIaMbVEYshgibUbLTXovtRA1ZZUi
         CXtmKwF/7XoKY2uF9g4QylCIj1k02aN0GzYQk0vx9yoYkswRyneOPzRR9DjtF8q5NMvm
         HUUxeFWhJFGOzTmlJwKsIHvzGQNiJLGt371OGM9+B25jya20S/gWBF7DrqIkPuUxQFyH
         AWRUaE4SRHNdov5SEb63C6JV3cZO4aLk9szefKn8oakK3AIE821ujVkyy3FNz4J0/qGM
         bIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789636581; x=1790241381;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YasMKQ2T/AatfsN0JjpUO/fKJtg6yNiDvHeBKdEJON4=;
        b=0s/f/7UF00Kh8ZStHZKN6atmHl5tUXX6ZUKC+diithts1m6zdHaThmXOVQ486xPNwC
         Wdk2+rX9RUQyT8ogZ7lZUnXA20Tk59++YA3X7e8IJYHqp8kGSWqsSADcEcu1MFgXlE48
         7eqgq1mEXmn/EBxlkpADmDAEuYhLIZWdvPiTyWonm7FpbRBZ0HJb0mrQ6Amv4T2g0uHG
         o9cDW5klsTFv7+RQAOXCDjXy94T+sHj+Dvl7oCl8QqXH10QPy+dgWDErU/fB4aROXy+B
         Z5cHKf3ukkHzCJd0Mv8YQk5S4Dt/iup/JV4kg7bjvzzwsGCeRyN0NQGgt7vTw1iSXPcY
         tdsg==
X-Forwarded-Encrypted: i=1; AKwUvBzTWYYOSF8PGpcNNS2WHiXFlV9AIBp2ipKSOx5wsVEFHpjJVlhygHbww1jpOrrR7sXE2oZLEjI=@vger.kernel.org
X-Gm-Message-State: AFuF++nq1W5RnWcvPjGMrDoy/BsWPbcsx8pqilRKwOS+durlAcKnW3fC
	hU1/gPTxwUJu0tq93XOOT2fdmkC2UCXGesv+pw/DAcHEntKZPkl9Ov5wq/cJIyn/FgoY93RDelF
	O5kfYQ/cStlF26Dj41Cr2QAl1mbm1NOazwkXOeXWTKN5S95mXbG0BmCbwDQ==
X-Gm-Gg: AYBFou2XZZXovyOJy1UMaij3oFvCUMrWpTJ01BMwIoisp5HKJ9fSCemLVb/xu5VJSId
	GDdg0aCkGBDw1sqDC1ehsXVDZujg/BtrtFKKwEcn881cMBFwb/jZZHtsKTluYzqPIXNS/toJSjp
	KMTuOA6D3Og0Z6HL/NDYs8LOkqZaz0+deBn66YuaOHBliS9Wc7x/xGQ9MemvSGI+SW1H7NmiLFi
	d33bB07qshOP4YIbdtvGoVHf29+4DoEJ/GrSFYFfQnxYcc8cuQAa7hRmLHmmsEJ11/uxoHkZLex
	Zv8NqTDTRi/I8fWgDxRU8Bl1n2xABgT4YMfcK8oQmLeE+y8KFtV/Wh86ORs8+dk0dnQiPURwMEL
	TVuPqxmopffs5bRVqre0MceJdVBLJwqzNRwQpmfzfTAPL5gYL29OZTdnmySZU8leWDdIsaH8JNA
	==
X-Received: by 2002:a5d:6f12:0:b0:487:fa6:c921 with SMTP id ffacd0b85a97d-4870fa6ca22mr5920388f8f.23.1789636581610;
        Thu, 17 Sep 2026 02:16:21 -0700 (PDT)
X-Received: by 2002:a5d:6f12:0:b0:487:fa6:c921 with SMTP id ffacd0b85a97d-4870fa6ca22mr5920348f8f.23.1789636581205;
        Thu, 17 Sep 2026 02:16:21 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf37e69sm14006115f8f.29.2026.09.17.02.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 02:16:20 -0700 (PDT)
Message-ID: <a0b83186-7399-4d79-8226-ff43611184d7@redhat.com>
Date: Thu, 17 Sep 2026 11:16:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] packet: use ubuf_info completion for TX_RING
 packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch,
 Willem de Bruijn <willemb@google.com>,
 Katherine Leaver <kleaver@janestreet.com>, Bjoern Doebel <doebel@amazon.de>,
 stable@vger.kernel.org
References: <20260914214229.1674102-1-willemdebruijn.kernel@gmail.com>
 <20260914214229.1674102-3-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260914214229.1674102-3-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 23:37, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> tpacket_snd sends skbs with frags pointing into its ring slots. Slots
> are released when skb->destructor is called.
> 
> A call to skb_orphan calls skb->destructor before the skb is freed.
> This can cause the slot to be reused while still linked into the skb.
> 
> Switch to standard zerocopy completion (ubuf_info) so the slot is only
> released once all references to the payload are freed or copied.
> Restore skb->destructor to standard sock_wfree.
> 
> To prevent userspace from aliasing in-flight state on shared ring
> slots, allocate tpacket_uarg per packet, rather than per slot. This
> adds a small allocation to the transmit path. Use standard kmalloc to
> allow backporting to stable kernels.
> 
> The uarg holds an sk_wmem_alloc reference, rather than an sk_refcnt
> reference. packet_free_tx_ring waits on sk_wmem_alloc before freeing
> the ring pages.
> 
> As a result a slot is released when its payload is copied, which can
> be before transmission (e.g., in skb_orphan_frags_rx). Any slot
> timestamp then reflects the time of copy, rather than of transmit
> (or skb_orphan).
> 
> Revert the now unused previous skb_zcopy_.._nouarg infra.
> 
> Reported-by: Katherine Leaver <kleaver@janestreet.com>
> Reported-by: Bjoern Doebel <doebel@amazon.de>
> Closes: https://lore.kernel.org/netdev/20260909085542.3370986-1-doebel@amazon.de/
> Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
> Cc: stable@vger.kernel.org
> Signed-off-by: Willem de Bruijn <willemb@google.com>
FTR both the 'high prio' sashiko finding here and the mid one on the 
previous patch are IMHO worth addressing.

Also I'm wondering if the extra alloc/free is visible in perf figures? 
Out of sheer ignorance, can't the ubuf be carved out of the ring?

/P

