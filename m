Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCC437472
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010071; cv=none; b=jV8N2slGIspDQ2YwEFz9NbRc/nDi20SoiqpI9EYVbBui0KS1U2ouC5s+w+wakRb9BJji1JMOTWCPTDTuyd21OJftPmdenJTwOtnCNhTvJGJiHQd3okQkKYemdnpUEz/RQ4cKvCXN5FWaXm5nCr8reABnQ2geOvBZaOaI30UWh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010071; c=relaxed/simple;
	bh=TVfZTvYjC3SQM9QCFiBCYXL0SRD3EiZSwJodtj0GKf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPlD/dXcZlnuPOTFIO+vCRpfg3Mc1gHbw7N+K0EWZ3gVzwrnoXOXkjRGvgD3Omwo4JB/EFA/9NFTj54AUMzL21dHnIQKh8dGcNPxDNKQC4CHoSzmBUfsoAVkryh2qFBNq3Zsr34s1ec3Y+szdL5NziMXa+CqRKDps/fWSif7yBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYlgBvPY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOE+6T0W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYlgBvPY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOE+6T0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786010068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euI2TAoHdDnhNVjEbzagRIA6btOpFEU3Ddw7XqrrJ70=;
	b=PYlgBvPYFr+MBxfG3cmqbKj0sHkjpzQZnt9X87pArJoQQiXWgpKdPEXqYhsGYe9BOTFqtk
	qLHg3fJsHL7MnhBR10z0HYV77rnc0+ey55hPLFbVCa26FKgikoKm0OCQr1WCDlhPhZrJC9
	TLdnW1WkIkWA+MRoMpqwYVLJuzQq668=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-rS3_7DkyPCGwRKAUTzzY5w-1; Thu, 06 Aug 2026 05:54:27 -0400
X-MC-Unique: rS3_7DkyPCGwRKAUTzzY5w-1
X-Mimecast-MFC-AGG-ID: rS3_7DkyPCGwRKAUTzzY5w_1786010066
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f84ac1990so1147193f8f.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786010066; x=1786614866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=euI2TAoHdDnhNVjEbzagRIA6btOpFEU3Ddw7XqrrJ70=;
        b=aOE+6T0WkEhHJy1lre2P0r7BRlua16CIxTAl5aL//KtL9PBVKP4UrIIR4Jo3z3QtRF
         V+bdeLb07xd5YomI8IzptneHyPKgH2r0wR4usLFkqf03Ko+uOQ2egjICZj9H0H7bU50P
         Q7FEAfyUA+oiRKlTC4lzQTlsblV+RBGffop9f75VNFPVIC5YsYfw8EfNPOtzfrLTa80m
         1XzayiUuarkDEt0ORnzjAEIb3zM8vCtvN1FfNlFuejv0rWZrlX8Zwx/DibwgSWXYf5cr
         BQuyzYwDrSEVAeXYOZjHW5qqSpgLAx1u2zD7GBrn6MtRpYvnSee8qTeJ3SosznQUZBJq
         yLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786010066; x=1786614866;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=euI2TAoHdDnhNVjEbzagRIA6btOpFEU3Ddw7XqrrJ70=;
        b=ErDkN6eedUdRA9/OIbtH9tBXFjKuiBqdzyytAYVl5LV9aTG8Yd9qq+iQGcaKMnAfoP
         Os/My0gUwu3wK551u8QE4T5q2xB56XO/IjAPpf5GCQZ1JqG6Vn7wTMh39xnxMHJr1+h4
         qOsk/ryoGTwWIimNPT+r28U81eZsCCUoFTczxlfUp+TATHeCfCLaCmqbcTlqqWoLSceZ
         JAzV8Yqdv+v81jnzNWo2/YB2wWJlczyrDYdg5+yko5Y6heXMqOHfKN4dVn9L2BvLn40v
         8XSZ2MYSt8r2cj7oY5B69B3RnGCG8jgMsFPtJyGLhXr/wC2sH8oQrETQ4Rf63RyJmr/+
         pVow==
X-Forwarded-Encrypted: i=1; AHgh+RojD4ISZKd5/sy8+IQClyuohvbcBxefUl25xA0VdBY10N4RGlQFZS5rrHQTUp+2eNORsTOnd+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYBIXaA3JxLroBNQFxgcil/+inul86ay/JTn7sBuE5DhCHpmz
	S+pP/tVmy2aV+Dvglr8SNLOgk3zTO8RgVHtAsgvx4vsF8otTd5aR2UfYTXasT8uzu8wU5u2A0+3
	lweKZokgfav4rA2tkbUjJjrF0mDYa5174f4e95wM2QgOjoJCR5E530ImGog==
X-Gm-Gg: AR+sD10ynwfC1W1fKiwofR1L2BHen8R+h0pzznDrIacQgseQDEfTXBBwkM+SBpQtztc
	cbrpTRv1TFIEb8kP72XnlOmHnmSMoeH6qQp0OW/MhbK9KgIzdV8WXqzjDpGCqRRM0Nlsa2zeHct
	qxkHGcdUHWr0AabFNl20jn0SZSCJfNUS3jgm6aR/SG+yeMzqU7t5nS8IlRO8W2Vfttc1fGS1yYn
	XoWv/VgXYRePmI9kY5PJ0BN3QzpYIVQVlE1aS/W9akhY0ELLyGABlxCjsnB65JZV6zY9HbCE1Rs
	y7+4V7v1ZDx66/RqmeYbtR7lv6yLm9jAOxrjmA416ioXEkKHNN+iNw1zv4FpB50gg/Z6sUAXGLw
	SsfUYrymiraW8K55euS+RF1/BEKBr4tKUBGomDa8nupeKMauxGdDM1fsBNhHwnJkmqOuV6R78NB
	U=
X-Received: by 2002:a5d:5185:0:b0:47f:ecbb:59a2 with SMTP id ffacd0b85a97d-47fecbb6f45mr16618958f8f.29.1786010065917;
        Thu, 06 Aug 2026 02:54:25 -0700 (PDT)
X-Received: by 2002:a5d:5185:0:b0:47f:ecbb:59a2 with SMTP id ffacd0b85a97d-47fecbb6f45mr16618907f8f.29.1786010065514;
        Thu, 06 Aug 2026 02:54:25 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b18386sm5143775f8f.19.2026.08.06.02.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:54:25 -0700 (PDT)
Message-ID: <86d486d5-2625-4b0e-969b-9f1a5fb063d7@redhat.com>
Date: Thu, 6 Aug 2026 11:54:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: pktgen: use a consistent flow count
To: Qi Zhang <marsy12010123@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Chengfeng Ye <nicoyip.dev@gmail.com>, Thorsten Blum
 <thorsten.blum@linux.dev>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, Robert Olsson
 <robert.olsson@its.uu.se>, Jamal Hadi Salim <hadi@cyberus.ca>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260802152309.821584-1-marsy12010123@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260802152309.821584-1-marsy12010123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/26 5:23 PM, Qi Zhang wrote:
> From: Chengfeng Ye <nicoyip.dev@gmail.com>
> 
> pktgen_if_write() can update cflows while the packet generator thread is
> inside mod_cur_headers(). The latter first tests cflows, but f_pick() then
> reloads it when selecting a random flow.
> 
> This allows the following interleaving:
> 
>   CPU 0 (kpktgend)                 CPU 1 (proc write)
>   if (pkt_dev->cflows) // 10
>                                    pkt_dev->cflows = 0
>   get_random_u32_below(pkt_dev->cflows)
> 
> get_random_u32_below(0) returns a full-width random value. Using that
> value as an index into the fixed-size flows array causes an out-of-bounds
> access. The kernel reported:
> 
>   BUG: unable to handle page fault for address: ffffc8fe2d2674bc
>   #PF: supervisor read access in kernel mode
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   CPU: 0 UID: 0 PID: 65 Comm: kpktgend_0
>   RIP: 0010:mod_cur_headers+0x16f8/0x2840
>   Call Trace:
>    <TASK>
>    pktgen_thread_worker+0x305a/0x6bc0
>    kthread+0x2c6/0x3b0
>    ret_from_fork+0x36e/0x5a0
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Read cflows once at the start of mod_cur_headers(), pass the snapshot to
> f_pick(), and use it for later flow-state decisions in the same packet.
> Publish proc updates with WRITE_ONCE(). Flow selection then always uses a
> nonzero count bounded by MAX_CFLOWS, while a concurrent update takes
> effect on a later packet.
> 
> Fixes: 007a531b0a0c ("[PKTGEN]: Introduce sequential flows")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> Signed-off-by: Qi Zhang <marsy12010123@gmail.com>
> ---
>  net/core/pktgen.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index ee64f3012321..631cb1f55f6d 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -1632,7 +1632,7 @@ static ssize_t pktgen_if_write(struct file *file,
>  		if (value > MAX_CFLOWS)
>  			value = MAX_CFLOWS;
>  
> -		pkt_dev->cflows = value;
> +		WRITE_ONCE(pkt_dev->cflows, value);
>  		sprintf(pg_result, "OK: flows=%u", pkt_dev->cflows);

Please use:
		sprintf(pg_result, "OK: flows=%u", value);

so that the user get consistent results across racing writes.

Also you need to add READ_ONCE() annotation to all `->cflows` accesses -
a few missed ones in pktgen_if_show().

/P

