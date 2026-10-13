Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695D3CF67F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899285; cv=none; b=hffkEJhclPAiRgjeI2+C/k/n3YPkdFmA2BFDMBc6ueQhXxg9Y/1f31w418o6OjhFnP5fcDZf0eEAx9Z1EdTcCt0/kwXGj5qwziNQmVmMBa5SktfLI1NKj+UAkkzMS0rBNN+vyHuwEWXGZcZ+fx4jZPBtPGvs3pOcp6BJPeqRmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899285; c=relaxed/simple;
	bh=REg5Mntcb+tsmQNtdHglZYMVn8Nwol6pChdRnAFVNkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IW695KxjFjaACBrmPUoPjg6if9a+nk8CcZTOUpkwG1auCod8vOOqU69z35Scoco/WlPprw792AlRHdzgIByxogVF+fGJeaALeBtaj9VABJtxrosajjZ0R1m7YMA/F3swX8skohLvoRbCOB8q4r+cpgMUIT+LqmKiuVGiyhr9jJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGSXWaZE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KreR4oPM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGSXWaZE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KreR4oPM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791899281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgGQEF0Pnm38fJNWvw8gvjA222tZmizMgG6WO+7xu+8=;
	b=QGSXWaZE9X9VrDkPqWtT9FSOG6OIBx/FuFc/LvSTr1rV7SflkcukbS/OECe4ZMxwCkChqD
	p4zSB5bi8HSY+cq5FkDAtfEskw2xFLkTkQAgSqxOf82SmnJtk6f/7uHZXxwYm6E9hCezHq
	XWrVbjXEc2Zd3ktLPutrfbfJyNFUFhg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-_-XKqGflMvObvUc-pTGBGA-1; Tue, 13 Oct 2026 13:48:00 +0000
X-MC-Unique: _-XKqGflMvObvUc-pTGBGA-1
X-Mimecast-MFC-AGG-ID: _-XKqGflMvObvUc-pTGBGA_1791899279
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c437ae81eso1723675f8f.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791899279; x=1792504079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YgGQEF0Pnm38fJNWvw8gvjA222tZmizMgG6WO+7xu+8=;
        b=KreR4oPMlzeA0zSZnRmCu3+uNiACc7J02qXHHcbrVfGaA0nN4/L2X+KtpS6T8de04f
         BjIckzJrTgDP1J8JUCueZWKvjyiGHBJmVLmGSmqNM2l+hajdR9TNl9/tZLvoM1iAEp1W
         EF7N7G44nH7c0aQXyVPurYyVkNt2ylKQWfe2JY9GG/zR/kC/XVPOjTU4aNIs/3+BZUTW
         JXn0M1aorNcTo5RvKE2VUdp2TzeROyaEJWXP0SjqEt2S0XKLq+BjSOVRZqrHlueUHdAF
         oOcihgJupZ65XRipFYuMyyZRe+U14RydMdak3vKdn4w2ursn6703M756EeJqAnH7d4y5
         32sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791899279; x=1792504079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YgGQEF0Pnm38fJNWvw8gvjA222tZmizMgG6WO+7xu+8=;
        b=TazvhbN9446x7NRklD2JHRuKLdPQv/8LtbKQAf87zMv/xGFfbGMl7LFhfxMEU16dVs
         /5NEEWrbSIrkbFfdM8QfoRul4KPt90hn75mArFBv1Tb9HwyByXVmriCB4OVX7utLuqme
         ZUNgP1N2gfKDDWcvXOTTVa2YBWzrFWo21PlPoagSOduKRJElS/zqpYjxFnQFmUXrIy52
         36Fwd5VJkRAxAx0fOQWfEi6z7EQfWUOpLKxxA5ItfQUvs6JsVqXwRfR7ufz0EoOJ84KS
         kGcMNZim/vfygNG0pLRWWlUftWpNAaZFc9NQEWKVk1oQYPWMV+RE5fjDwxXhJVRJvy1f
         lRzQ==
X-Gm-Message-State: AFq9FYLtZEB0S1tlstZm+MCC1KlPF65eKRFNy0/n2XjUVCnIVvFn6t3P
	I+BtoE2FLJUaDWCuQkZ/PLfdDT/aQkugKsm5cdH6E5sSOidjKfbJtYe1PtWB50HLc9816af+784
	70+QLYQO4agZQxN6YHN2i8MGjNDme2hLBGQ2+S+AwdyPMd4TXwHa9Kb15bg==
X-Gm-Gg: AYBFou0glM6EwRQ68v+jGabOg5onJYEHjcqBXjAgRQ2cjCQBBzCJWAqOa0MQnmCMbUh
	jqnn/SuLWnH9MW0EviJTif6T4Zv8oBxr8QOMJLM/dnEu7CqTrlhT15csvftqxIZAAIwLpXDy1k5
	rMHTVIvkPLQ5y5O3pPcMQfGyZqnUdCDIEucgRbBqEMac878snQIR0ylcJThVnR08/PRPOisFIQ6
	WWmjQZ1QdY8BhaChkVxBjrkohyVY3n6kYantSgtogmOdCt4Q6ak6JjlkmiJYe6vqcT6O/p94IB2
	Tz4dF1MZqN+EbpylBV0hiuflJhERNqG1dVBceAtmG0TPKqHcUwnYrZsUwWfs4vKSXfNYcAh5NID
	SuRZNKT8TrdJruxz+EKJm4nnNKUWkkMeDZcKMgnIw3OvU/+Y3Rau0fvX66aozbunvH4JxsVsGvQ
	==
X-Received: by 2002:a05:600c:3b8b:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4a18e4a7cfcmr308259065e9.26.1791899278728;
        Tue, 13 Oct 2026 06:47:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8b:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4a18e4a7cfcmr308258425e9.26.1791899278275;
        Tue, 13 Oct 2026 06:47:58 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc85b1sm4979371f8f.54.2026.10.13.06.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:47:57 -0700 (PDT)
Message-ID: <8c40f576-08d5-4b42-b125-abda8da2a335@redhat.com>
Date: Tue, 13 Oct 2026 15:47:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: alacritech: fix dma_free_coherent() in error
 path
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261006140912.50828-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261006140912.50828-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 16:09, Thomas Fourier wrote:
> In slic_init_stat_queue(), a series of coherent buffers is allocated
> with the length size. The size is then stored in stq->mem_size for
> normal deallocation. However, in the error path, stq->mem_size is also
> used but is not initialized. This error may leave the freed buffers
> mapped, leaking a resource and allowing the device to access freed
> memory.
> 
> Change the length in error path to size.
> 
> Fixes: 60c140df15db ("net: ethernet: slicoss: add slicoss gigabit ethernet driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

FTR, bad things in NIC error path for old drivers is the exact
prototype of things we are actively redirecting to net-next at
this point of the cycle. Also stripping the stable tag.

/P

