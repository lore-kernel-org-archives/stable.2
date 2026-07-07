Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2136F912
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783466218; cv=none; b=HPhbkI0dxnG3z/FQKC75Kjdp3kE8cT3ohFXZYSmeB8CMVPQfTYQV0JYarYZF5U8GtGJSplxuZbAScXKYtyheH4NB70dJz9nrznvWyU951DYX3TuwJzhRnEmyGuCIBVZfomCrGoy0F57aGZS2axaZTeJVUGDbWrN9C5C0XATYiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783466218; c=relaxed/simple;
	bh=Pc/WLT8vyh7rH9PhvdoTJsW2NbouCdu7hSBg4pbUsDo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hfQubjIc5Xt80d/cDVN0etqECj+VDvnshxFWuyglSPHuLDXDQtlxIXZPfeQrisXabZ3lSAAHu5GIhGhvsuCVCnfArivhsay3HwvYxa21OsUyUijdEED4OSdE0GIqaehe35ueI9pdR5opcvgg65SldbG6tbyP4PVqDgU4Yuh2zPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-472365266f5so37199f8f.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 16:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783466215; x=1784071015;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKwBKxnEgAfUGchM8aY1vGW2Ffzyqi1WFv0RQ03fjak=;
        b=nmFitBzb1j0pO1TNd+tpnEhRsn1kmN4WxNNMFgIXB/+2BUhWck6H0RyIH9Npl0hjDu
         0GFrhPGgvXluzNRBxKR8ahqcbU9m4f3FKBjYdjwsVt2mvR0kSLuBMNCGdE6oyXdSDPib
         RY+iV4oeSwrzjCij6J+vbSAcgTWOcQuJpN6rep8ewSSE5QgPN1JxrX+6PV/oVR4zBWXQ
         4HwHLnQxo74/kKyInQ9Rj6gwMrmbclHB71JQVA602/9zkPbjdHg+Xw6dDl0lwp+ZcBP8
         J3jMnZq4V3v0cdNNKnY05HA9AFMQHwbDbghg1VldIYTqynRsnZG2Da+5hQdQbgG3NC3Y
         dtjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBTbBBVAAKDo4W1rSj4hPjrwLkfdupTYboeFyuqDunjAr8xWnyDy0jgY951ER26IY7MR3Assw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBpyYcR/pC5xBIHEdNQQnQiiVjBmP6aXd1LceJ+vLuQmldheW
	OIenyotsVJCZG8ZMTE5BC/NuAtn5GtILxM8YN8AV7ZpLZHfgnVdVGsxI
X-Gm-Gg: AfdE7ckkM92y9QJoXNl8jr7Vs39gEUvWxSgSwAqna6ZXzBdkk+hg8Hn6f5rlUaV0vM3
	VBJQLWMfykBBbUsV1mkxZuG26utaNRz/xyOjUKcWTEOJQ7TfSLT8N8cy3YKkILTa+SLpwFktRO/
	zAWJ5OqOeZ2f41zxjHC5U3Rvz/CShvTcVg4iTGZ7dahB0heBJl6TgtpftP/yHumu8d2NsggIsEH
	RjFARm0sN0sy1G88eysC49IsiZggms0fH4qz5MLi7bPVEUiiNIMkoslOzGLuHuWgDu6h/etinsD
	YX+wOWV+4d871NWrcUSz4athSqXbPOYrzc52SnYaDGsUZCGHjOePVUqHOxyaOY5Im4BpkUslO5S
	QQmBnEqFp80VpNE+rPjJGtdrmQ5N/wvfBwZT2IoXS06PCXZzqYHmuqB7XwfXtf72H73A+36vdhj
	Ia2jIGa/9cMedbV0nVhtmNQTFoemw6OXKaiPmnXX4WsAnSebxvKw==
X-Received: by 2002:a05:600c:4e93:b0:493:e508:1137 with SMTP id 5b1f17b1804b1-493e5081183mr18112435e9.39.1783466215520;
        Tue, 07 Jul 2026 16:16:55 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f294a6sm178853125e9.1.2026.07.07.16.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 16:16:55 -0700 (PDT)
Message-ID: <7bc054f8-7afc-4fa5-b392-bcad1f9d70bd@ovn.org>
Date: Wed, 8 Jul 2026 01:16:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, stable@vger.kernel.org,
 ovs dev <dev@openvswitch.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] openvswitch: fix GSO userspace truncation underflow
To: Kyle Zeng <kylebot@openai.com>, netdev@vger.kernel.org
References: <20260707221635.27489-1-kylebot@openai.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260707221635.27489-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 12:16 AM, Kyle Zeng wrote:
> OVS_ACTION_ATTR_TRUNC currently stores a delta from the original skb
> length in OVS_CB(skb)->cutlen. When a later userspace action segments a
> GSO skb, queue_gso_packets() reuses that delta for each smaller segment.
> A segment can then reach queue_userspace_packet() with cutlen greater
> than skb->len, underflowing the length passed to skb_zerocopy().
> 
> Store the maximum preserved length instead and bound each consumer
> against the current skb length. Use U32_MAX as the no-truncation
> sentinel so the value remains valid if skb geometry changes before a
> consumer handles it.
> 
> Fixes: f2a4d086ed4c ("openvswitch: Add packet truncation support.")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---

Thanks, Kyle!  For the future, please, don't skip the general networking
maintainers and the ovs dev list while sending openvswitch -related patches.

Otherwise, this patch looks good to me:

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
