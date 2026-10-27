Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092041;
	b=hSKfiu8Homa7zZWGyDuBW0s0lr69ClBkINt30ewX+TV71T3pR6rE+/jRBKXaPI3dVoCZ
	 jQP892x3vpgCJ0b97fcnX75Lq5wBL6Q+hYXlhRSmMUlTrOoDAxwiLYpUt8ZRI6LmdoCwD
	 sgFj8eS5rVNc0QFWU6d8wwQcaxMxk2kP3ct4GpuEkVljR8bCmhSv/a1qTYv4AUWtnwLiE
	 1mh5+3duVG1lj9H8YlminMGAHF8nHVt+mgzEFXJifBcFGB0F0r0tiT9q2uBwxU9PjWaHx
	 VLdvqjnpACFJ7KNmCMvL6ylcv2aFv/d3sRfcBAEEnj3pP1fcRDnuoLKoVdrC92QFMqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092041;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CvG9nuygN0yktJ32UyxWM2+If6+E11EHBfx2QJOffRY=;
	b=CBb+xDCTmaS1fwiztHz1H5aeBktSXbeSrn/1++Pn/HD830e6MNyyB36/I3AW/Zp2zNqj
	 1HpJNSdziWOyIfeHj0txj85I+erw43SsgWgNX6zEq5opAkPGuOrR2FRv1BQXvX3g0N1sp
	 hJlQmupicWklDT+MpWdcWrJuVBOiCX89at4tFLHUu4+PQu+DFD7DRLt9VXI49ErDnI4sz
	 fWp+giCCcEOsgFpcCHGu217g0BNVG/IgHQZrPRGy4lRo9XEWEONrjwe1ArCdAY706PYS3
	 xTZkQcSysjUr7/3lxKkzrw6hU17RsXV3CxFzi1HifnM0kEG72bV/oDCk21O3UVoPzjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IWMnAgtZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZGH3OXvT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854F1606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 854F1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IWMnAgtZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZGH3OXvT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793092039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvG9nuygN0yktJ32UyxWM2+If6+E11EHBfx2QJOffRY=;
	b=IWMnAgtZBibjGWiVemPH0LYVfbX21tcYOqtX0zb2IbBLG1/PiXp60/yLYg9VAnvxm2+gk8
	LLX3H/tU433xLjYsQM84MeKwUCdCBuBj9GDXq1kIXoTT/rrpn0UdfG9lnX+pX5lHa8N8YD
	RTOAPMy7cqL2zYrS/LTXLdgjWsXsYzs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-r6-OF7_fOXedhOIN_agxLw-1; Tue, 27 Oct 2026 05:07:18 -0400
X-MC-Unique: r6-OF7_fOXedhOIN_agxLw-1
X-Mimecast-MFC-AGG-ID: r6-OF7_fOXedhOIN_agxLw_1793092037
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48af4046a3bso3841994f8f.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793092037; x=1793696837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CvG9nuygN0yktJ32UyxWM2+If6+E11EHBfx2QJOffRY=;
        b=ZGH3OXvTbDPuFQS3PLOceC4AkGEYOj6E0wYTqriuirsATNGRSAm4p+UWN0rulZxVrM
         PiP+jOgS6xpKIKWSyOSDFvU+c5g5oKaKWzshtwwcKUTV6LxzQlAkz0FQE33sWVGhsf+Y
         kbsbGK3AVei8YLlWayK/qqjivSnI29T9TSyfmicGXftowA4hXqzAH7vvuVuvMugyiZyL
         UH5eUlWz/JQORgtOfN0WNofCyeklipg9cG9n3/QfgvWfiwExYWZ/FoTi7f0OQq43NJFn
         K7w57jsXLQ+CKfC49fIvKIFguOShYpCBkiFA2AV25mTFODtmWSHeziN2cEAQoCGdlHMe
         qUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092037; x=1793696837;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CvG9nuygN0yktJ32UyxWM2+If6+E11EHBfx2QJOffRY=;
        b=du4ZFeaRyOI03qcfIWRa3dGx+WfOICb8+Sgh//VFRkoPpQiqsheS6PVyUrUJZCywbx
         rSg9w/z0BNQkNIxQUfc0zaA9wYQm/U0kdF+/NO2VwjR6ThLs1A6o1MdZiqRnciuQeddM
         hqBzeWX3rBrpMqGbDM9In4bwuw2yPjpdqMT7+ACGuRiWiSGaRFKY+SRwbthJwRB7TE6X
         6/qBl0kEFVWIe2V4nPEMUSJn8qkEKbB8TFfHFPD9/me6A4vObdiWEqcuuJC6YE+DE1L1
         sYUiyTGMWNuFuXT3USk6ZP3sy3t0CHgCLonTguz5Klam/DcjxfzQDj52WNxC9082F1aW
         EQmA==
X-Forwarded-Encrypted: i=1; AKwUvBxkJY4VIP5XKygQzY2HKh7jDnf2fY3i+huh2LwdDEOb/iRCcGn1XvGjL4QDwpe/rJ03AP46Mb8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAIPjnpQRxBtZYuLC6ZML0H2H46SffkgVNjbn9ziaiFBCg6JSZ
	a0yedtoRI53g7DkXNCZtx7NhMsOOBVsKfYb8ZhXivFJSUMQai6SUgDquXx8e9QgGspG6y5F3JE4
	Ug6rbGXVGPI2AAZk7FAi50VGDWAY/eyC+LsCDpM0vwOsdfWQEEeqrzpt8SS8XFw9hTw==
X-Gm-Gg: AYBFou0tt1M4fF1D9DdGdGyFD+IcYhk7sKnMTZVm/7w7HsetvuOJTmx+X/+V6qnyIHK
	gQEVRflpyXQ4oqVR9i664llgLeR6yw8ivwuJm5AKYAVwA+aX3hRcvvksqV3ydcGYSZXk/n2nCbS
	Ubt5JllBDLI3fRheJaRfirlIZhp6Ck8/pf1eHMYS8WcAtBbpXjBQI6eRieaLMhoyEIfE5uEKM9r
	9OZiaV9IsmakmQm3IC0h/OZwdC9cnN2RgNSSLaeyH69CCPZ4JCgdaRFuy+RWDyPhILNDwvOEzuB
	ldVypfc671jUUOUL2c1xqyW+PJfPC9KjqJ5LHSO1q6NQBLGp439ZXqy4eXs+Zp2SLd2z7Xtr8sT
	G3A9/U1NMs0IECGH5gkERBsOVlVzTBJM11mzLJZGZUDQqqonT2yaQA2WdIcah7jY23MCUBlg8Eg
	==
X-Received: by 2002:a05:600c:620f:b0:4a1:e672:5721 with SMTP id 5b1f17b1804b1-4a35ac9956fmr157314145e9.13.1793092036995;
        Tue, 27 Oct 2026 02:07:16 -0700 (PDT)
X-Received: by 2002:a05:600c:620f:b0:4a1:e672:5721 with SMTP id 5b1f17b1804b1-4a35ac9956fmr157313435e9.13.1793092036309;
        Tue, 27 Oct 2026 02:07:16 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5698f1sm250416975e9.8.2026.10.27.02.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 02:07:15 -0700 (PDT)
Message-ID: <0f7f68bf-d02e-4bc5-accf-5f89a599d37f@redhat.com>
Date: Tue, 27 Oct 2026 10:07:14 +0100
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
Subject: Re: [PATCH net v2 2/3] rxrpc: Fix counting of in-flight transmitted
 packets
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org, netdev-bot+sashiko@kernel.org
References: <20261020201258.290827-3-dhowells@redhat.com>
 <179262720290.3135.1509720869529893686@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179262720290.3135.1509720869529893686@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/26 02:00, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Incomplete in-flight accounting: if a segment that is already
>    soft-ACKed gets retransmitted, its tq->in_flight bit is set again and…
> - [Medium] Behaviour change on soft-ACK reneging (ACK->NAK flip).
Basically sashiko says that the accounting looks still not perfect. Is not
clear to me the new status is good enough.

Side notes: sashiko comments on patch 3/3 are not blockers, but you should
revisit the commit message in case of a repost (and do not include patch 1/3,
postponed to net-next).

/P

