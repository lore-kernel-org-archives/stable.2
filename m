Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E023EA97B
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406400; cv=none; b=Zg3EQHg0b3VIXFB8wPBRA9CG+8SHk1krMqrXUDF14J00ITBz7ED5e+Bq9W+CkcwO/4e9tKcZscmq3aSdrxEAHJnA8hqgZG0wz73S7Mi7frfLdLEl/U78jtoCpNEI+ifeCNDXknuwzqKoFAgQYcaoywUMUI76WE0KIlLFHEjyz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406400; c=relaxed/simple;
	bh=pSyrneVZE3Fw7bk9QupiWCgMXjVhDU7ey8F3ipqp+Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4+8k2M1ksh6TBPVQpJW05w2emrr482yEFP6/ChEQLqaC7jENMr93ZoNuzCSKN2/E26DMR0VfUNkPG4xMvsITFkZIjf9tZjLTriZbkUIl6bvxv2v1oUCEUXFbtID8F3FQBfvBTJvfRz83AA7Row00/I/JVnU+UQ28k5jMYuprcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1mH5Hth; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXN41C4t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1mH5Hth";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXN41C4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785406397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hyi5P33Hd7zC18fjV/u2o5p57tCCsdMzMx4mr4O5m5k=;
	b=N1mH5HthLqXxgXDjNWAQO7ZYcnDQna8l7TJpoTWMk+fz7kuSC0ijgQ+4a6X/EsfFMUP1RU
	1gbm1E5aTKILRExCfhIBl9gKcw8MK+AstV7lnuueK/qflzZBwS/VdYvJbjiJEmaQEf7oOT
	smKm/rGsIJ/kXLVRJ3U1FglJvgdkkH8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-HRDczmyJOfyfV6iT6lQ30g-1; Thu, 30 Jul 2026 06:13:15 -0400
X-MC-Unique: HRDczmyJOfyfV6iT6lQ30g-1
X-Mimecast-MFC-AGG-ID: HRDczmyJOfyfV6iT6lQ30g_1785406394
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495569acf8dso13168505e9.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785406394; x=1786011194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hyi5P33Hd7zC18fjV/u2o5p57tCCsdMzMx4mr4O5m5k=;
        b=ZXN41C4tbAzNCFZTZjJ+srlfAu3gyxnSd6/iw8UwDkIm/xmACT79qAS6jyHZO3cYkJ
         jHkn6l90Z7idR/+gDSHCCOf4NTijDleMe3hr5BCXwboKHrhxhAIH0DMsCoSxyc7P4VJA
         PqAw0IM/H0u6hYksA16AVl1P77QwltkfluEuQ2Op2nMhlkFnqAJGLNYn4kPZJX7HbKYW
         /fGV6xXTalucQOJK4KC0u3u3x9kRlArj0aYtzAKKOUfz0lblBzcTcWeWJTF/DvBZJnms
         togiULbw/nm0KChW7HVM/jkgtSAI1t6KKajOCPBk8U76JKc+49xRXVNxfZPQoqMc/gwa
         j8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785406394; x=1786011194;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hyi5P33Hd7zC18fjV/u2o5p57tCCsdMzMx4mr4O5m5k=;
        b=LrKm8jREjvmmm6n5jn40pwtf9igswjQtuIyXYApjoNQIhmoHsha8nwGXc+SFiau3wL
         hxCi9n/ep4lp8J8SmrkQ/h9Bw6s46eDNK79wteTJ+IBN3Ch2ztzUK+96EKyODvv6F2ej
         AyIv+ljvW/RdbEY0gcVizu90ycNcnBI1DH4EG37PDEZExypeUt3JFKUcCcRIEo3922RE
         algw1ELgC0Or27DmF+x1SDB3RjSs9Qi3dh/TtHf7F6gXoy5+083H2oGJ5bZsYGHc7of6
         XQAyo9Phus7XRoMBMzBpuEgIJQpB/Tg/mA80WphO+ITyCujzox1SqCI0LhkGqmAggt2n
         Qwvg==
X-Forwarded-Encrypted: i=1; AHgh+RpGon8AHMp6zllvxu2KhFfNrjrf1EKEl3leHtn+P0z9rv5lbEfOSmAADdaDK0KkmU1eLrq28p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYYz0UgEklpo93QjhxPhYxgXOcnjAdzZJVHbh21aDxA3Dq1b2O
	bdgn7I2Z0Ticm6a0qayOZnvj2byp3f18IVbYRJ+8HliOaEQiz3H4E9M3rUttkDPRWlsZSjDO2z1
	OieuPw2h81i73lL9BekBqgwSfrh4EcH3sFxbJk1umO2HQvC9c7B458oRWVg==
X-Gm-Gg: AR+sD12NlLXsK1MLxOMKTrgrY3n/lV0jDBebQDYXYwEwzAaOECj8RZ8X7Kh6/8h4jtR
	kBsv54VUQQamVY+Z4jbHX5v3iiLZyYACJcqKyhCnnLoXWVW6hStd0fG73DymA6FWflJJtZ53mbx
	QoAvjtoyBhP62gwe4SAnd2wrGi8QaI0IvO5Za6Zf3f/J8Ox92QB0+kULGVvl3RTpl+ZqV5gFOCC
	6KpexHwnLBGoNelHIVxxUVCwQIBnX/qL2XMB/gOSWoUmfXnXlN4p/Z0HxxNH9a5JnUCxnODAnIa
	5wP11VUhcZZE/Icq7hnSY7MWp5vS0KLAjxuRav3/n/nbiKTtdTrwcn8vEtarFwKSuLbco3HQybU
	8cSIz5hYDa9xmv+sKsKjmT1c6zpO0X9t4VZNbsdqDCniXEkImQqSjgZs8UXpo/qrMVY7+QqgkOq
	PQpg==
X-Received: by 2002:a05:600c:1f85:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49800e7028fmr23043755e9.7.1785406394164;
        Thu, 30 Jul 2026 03:13:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1f85:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49800e7028fmr23043255e9.7.1785406393590;
        Thu, 30 Jul 2026 03:13:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011feca8sm50128245e9.8.2026.07.30.03.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:13:13 -0700 (PDT)
Message-ID: <fe135316-72d1-4347-aaac-aa2164bcdd4d@redhat.com>
Date: Thu, 30 Jul 2026 12:13:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: atlantic: free stranded TX buffers
 on ring deinit
To: Yangyu Chen <cyy@cyyself.name>, Sukhdeep Singh <sukhdeeps@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
 <tencent_E5DA048E95B86B31EB21258D8E7CE1825308@qq.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_E5DA048E95B86B31EB21258D8E7CE1825308@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 11:01 AM, Yangyu Chen wrote:
> aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
> call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
> stops at hw_head, which no longer moves once aq_vec_stop() has stopped
> the hardware and NAPI. Completed descriptors beyond the budget and
> everything still posted in [hw_head, sw_tail) keep their skb or
> xdp_frame when the interface goes down: aq_vec_ring_free() then frees
> the buffer ring and the references are lost for good.
> 
> Today this is a silent memory leak on every interface down under
> TX/XDP_TX load. With the following conversion of the RX path to
> page_pool it becomes much more visible: XDP_TX frames carry fragment
> references on the RX ring's page_pool, so a single stranded frame
> keeps the pool's inflight count above zero forever. page_pool_destroy()
> then never completes, the pool is leaked together with its pages, and
> "page_pool_release_retry() stalled pool shutdown" is warned every 60
> seconds from that point on, on every ifdown, XDP detach or ring resize
> under XDP_TX load.
> 
> Bring back aq_ring_tx_deinit() as it was before the removal and use it
> for teardown again, with one extension: TX rings can hold xdp_frames
> nowadays, so release those too. They are returned with
> xdp_return_frame() since this runs in process context.
> 
> Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
> Cc: stable@vger.kernel.org # v4.11+
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
You missed a relevant point from Mina's feedback: this is 'net'
material. We don't want fixes tag in net-next addressing bug in previous
releases.

You need to send this to 'net', wait for the commit to reach net-next
and resend patches 2 and 3 after that.

/P

