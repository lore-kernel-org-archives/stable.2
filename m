Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702719;
	b=b1KL2/KhmKeb7tYK8pFozZ+/XXaWiYpqjVGE3uVvwXnEombEdFtRnlC0ytoyd8hhaYjn
	 PBuMfsFilMJQ0YkC5F40KLsrmSslUGpT/pwZjkm9QjUFt/Ht7i5W6hIZ3MK9w/gAJXu2F
	 B+aLgTB7gLvNMgT3w7SncfwKTTTMolIkBnktQc3Ro5kUzugIZuaqf/3EH+TrzG2qk8SlR
	 FXwgqnmU0pdhL/26tIVkq9PLWgpkiKNSY2ALbKoR05LXjqIjxqndq90Nb7HNZala1WWWJ
	 IkHTSiycJoOSAk6UkTKb9ktzHp46H2l29wrNfEpTD1mZf5uXxQt4rsRHby8J8UWC5rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702719;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Oc0e78R7GnTku6S9kDpVJbJPkJaWrIi7MbRLcQ86nNY=;
	b=twZ80sFNZ4fM8nVxJymAh/jvByEcRLdAn3uzxAtc7U/VBMivk7b/mvaxuh7s05GjH2NJ
	 PDDpIJOldfu236hIpTRr+FeV9+DTe43Z/bOoiXYglV0SYbWhJ5QunW16KRfmevwwc5BYW
	 JHCEPCWtQ+sBaMePjQv6ZlVHtnbdshwwDmnw4EoDPFrrsq82gLaeoLXLFLLPyGZoKl6CB
	 h6gbugli5gZDZ7ALvl4w6Qj69DPt32VctmWFvWLcFdeiU6Y/l9UJ5RJJMBAhG9SxrpCsc
	 aI64Dg7xnF4kAHpuzbIr9IWO3kKSjUqnqv908pqRIQEp7AtN8USzHz6nazSYIwm0BFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IQvQ+jx5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ys9EsDdr;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441B606A32D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9441B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IQvQ+jx5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ys9EsDdr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795702717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc0e78R7GnTku6S9kDpVJbJPkJaWrIi7MbRLcQ86nNY=;
	b=IQvQ+jx506yOy/x4yvg8d6uOB9A6r/WEYX4lq96Ol2I6Rv/SlmUr6Y6RxajOMnSma/aAfd
	A9bsKYZHhHPRKwe1XRTSGD6XOfgn6zcqFI8wEOdhbakXxWiWRVjfreWXDApHhL6SGSdQP/
	xPyk3/mNX1NLhwjyKf3BrOTNQvAYLPU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-ctlO1uezPV-ZLuu2cLhXCg-1; Thu, 26 Nov 2026 14:18:35 +0000
X-MC-Unique: ctlO1uezPV-ZLuu2cLhXCg-1
X-Mimecast-MFC-AGG-ID: ctlO1uezPV-ZLuu2cLhXCg_1795702714
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a204ac318aso33601365e9.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795702714; x=1796307514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oc0e78R7GnTku6S9kDpVJbJPkJaWrIi7MbRLcQ86nNY=;
        b=Ys9EsDdrD5piq4RdxKQVYvH3piYXoPWplyhnfpJP/rp7INiy9Y1Zejgy0SoGtg3E8U
         kGoPD4DrOd+KwEH1gEk1TjwU/AhH2OHPQGHemjMJxtRkV+rrn+k3+ldQLct8a2GssNwA
         NkbMJB4d7bt5+3k+FMgHuH7WF8bQmaSmJh/K3/ci9RvxSKWi5ixxyiDsdyK8pCy8e1Dt
         Xq0BRq+dHdYAoGuyqXng2A3bJ6bwlDCEjhfrVSJ5I7fnIltk/JRhHV4l1ZiRoVCruGx6
         q/28ZZxp/6pdwFDm7bTNqv/9NuQpf0DeMPXPt6qqA3Ckzam+a3BnZzkj8/1mcnpyNcNe
         Z6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702714; x=1796307514;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oc0e78R7GnTku6S9kDpVJbJPkJaWrIi7MbRLcQ86nNY=;
        b=O6dB4R0L+nLuOkiBARaFwZNZjIbdFOedc0aFZqJQKrGEZ+OHyYXXJsU6G6Oh3ThoA+
         jojZ75i08P1yL905jJ9RY3PsNgeywCl5mor5MGWXOZAdWuPhuvYAXeRq/IYOWvgPj0s4
         TvM6vEbMc7El0CnGgD4PLTKBcLayZfGze4CfqTzoJp8np6IRpfo7U0WLK9IcfeVTZ7IG
         /nFXa8M6k/FeTT+otgHjs2PnTJmhMvkkIEWs/3GVNGX5QMmFYgsbnFYrkEQxQ1LvgAH2
         a3cQ4I3WPsOIo/DdYFE0jXbZv/gKfjWEhOjSTjQbfgNXgtoJeOhdTOwMO39GhhExLxsa
         6ETA==
X-Forwarded-Encrypted: i=1; AL+hErHU9N+ocQ9F+0FQSX3UwXM62yoaF/6YguZY/4XmmGN18PhRxFHHinGocR48N6YLlEIPKFZdzkU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VfzGVWAqNKz47wQrX1OrW5NcWEysFh7MCycJ02BkR24NWIOGr
	+kzClbYO3B0GVW1Lck5yy6CZHlGZ7uH8ZcHEKcBhwRzx73lkPNR5tn6Xdt2/ewPB63LNsJ454I3
	KpcuH/o6grFKQ1+7SIuZMwqtTs0DmDBf4O+UdG/PGz0dk0NRTOvrCc1PfDBeLXcTDF6VZ
X-Gm-Gg: AZFdTZcQpEPoVG2P75BBuRl89ofvjcrl1fR9GkqlGeLHeKwWs08aj9LF6clFnASiNsJ
	DGxh71C/80MkpVj1HL8mrNWz+wBxRUzS1y0NpR4WWJ5XxBQaXumfgfCRurIotJPr9SCGxWok8i4
	jd7FQmKIP5E0zxuL4x4pOyuUcC/tiMLisQKPoHpOn380XmsZdNbOEKJ1XkcZ+0a2kKccgCkm94h
	VwV6noYMadRvJC4KuSVOZMNXa8J/yhLUJMN9W+xlmPINXaSQ8mzAJi2hzzfJy6+i2PFx7NTlktN
	o1GUD6PA4ml9JiT2NTAgRrI90nx/NWhu7/pJ+Zkp3ioDCOd1RUXSIu5m2xJoo19+IlsxJUxCI1n
	7x8liu9m1vOtbwvmysbpBCIyDmgKyqj8fua82+ALmazAQwf7bz2yyy7Xt8iMlbzcNryMkZ6degJ
	qDTLN1xNsl6Xw7rDRcHti9KUrAIffZjDZSpEsUxSqBoiO3
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id 5b1f17b1804b1-4bb888267aemr430554095e9.10.1795702714047;
        Thu, 26 Nov 2026 06:18:34 -0800 (PST)
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id 5b1f17b1804b1-4bb888267aemr430553595e9.10.1795702713623;
        Thu, 26 Nov 2026 06:18:33 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm1120826425e9.4.2026.11.26.06.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 06:18:33 -0800 (PST)
Message-ID: <14059088-7992-4d89-ac6c-1e6d1f61b3c8@redhat.com>
Date: Thu, 26 Nov 2026 15:18:31 +0100
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
Subject: Re: [PATCH net 4/4] net: skbuff: limit folio refcount when splicing
 from sockets
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>,
 Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Rik van Riel <riel@surriel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
 <20261118-skb_refcount_overflow-v1-4-5551b4954c3f@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261118-skb_refcount_overflow-v1-4-5551b4954c3f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 09:32, David Hildenbrand (Arm) wrote:
> @@ -3299,14 +3311,14 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
>   		.ops = &default_pipe_buf_ops,
>   		.spd_release = sock_spd_release,
>   	};
> -	int ret = 0;
> +	int ret;
>   
> -	__skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
> +	ret = __skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
>   
>   	if (spd.nr_pages)
> -		ret = splice_to_pipe(pipe, &spd);
> -
> -	return ret;
> +		return splice_to_pipe(pipe, &spd);
> +	/* Returning 0 would make callers report EOF. */
> +	return ret < 0 ? ret : 0;

AFAICS the above introduces a change of behavior:
caller with tlen==0 get 1 as return value, while they
used to get EOF. I think the return code from
`__skb_splice_bits` should be ignored, when not negative.

I think the churn here could be reduced re-using the `len`
ptr argument to store the error code; something alike the
(completely untested) following:

---
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85d5caa08887..9fd5116f33f3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3177,6 +3177,10 @@ static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
                 spd->partial[spd->nr_pages - 1].len += *len;
                 return false;
         }
+       if (!try_get_page(page)) {
+               *len = -EFAULT;
+               return true;
+       }
         get_page(page);
         spd->pages[spd->nr_pages] = page;
         spd->partial[spd->nr_pages].len = *len;
@@ -3299,6 +3303,8 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
         int ret = 0;

         __skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
+       if (tlen < 0)
+               return tlen;

         if (spd.nr_pages)
                 ret = splice_to_pipe(pipe, &spd);
---

which is arguably ugly but IMHO no more than the tristate
return value in the current version.

Possibly some comment around __skb_splice_bits and/or
spd_fill_page() would make this option more palatable.

/P

