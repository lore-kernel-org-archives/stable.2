Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4330FC12
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124563; cv=none; b=VKEpAmmq0kXL2Ti87Z2EcI56xiiKmHySD8L6ag3VRNzZmYnIap99epD+q2gMo6pQbcAOygaQyxIvvPEeIGb5d5H578di+e7XxN/qDkOZI+5xE3NU74S733Etrk236so/oF6/GGbZ6AF33fvFvAubgMGkCmlEbU1VTXZJs9MMhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124563; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWsMPGCVG8KBJuTdFweo6G77Ki9pYB2Bbp4wPTI9e2U9uGTGh77FguH6ThaTAIcP9NrwlAkUcbbR4Ep4g3xbe0wpQzwrTvj+w6RraMnJHtBf8UelfqFcMcvibA9AXUsFzkIJT24QzJ47lnzrMLaPU+Fg+iPbX6aXImWmLhIE6GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49557167508so29418275e9.1
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 14:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788124560; x=1788729360;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CeIbwT8U1S4qr3nleR1WAm6lZQ5H+/hsQ+guLkK11g6z62xM9pJtKQ64ABaB97ED/t
         cizMB3+KnnY3/F4id42YNa9hqInntHw9DoYcrLfEr5M/lSCh2C2B/IYXRysmHM8fVt5F
         TBwqJPxw7BBZ32Obm5CdL4T3JriZ200UCEjHa6EmtcFuAERY821YqEoJ43/E7/GpUnYj
         rBJ4EJIf+jDGMSwAXwvCu6y2PsXWcbdkcjd8+TzRd0nlH1qg56DiF8jjOygMucCfnJPI
         JVc+sVQASIazm+ScNNasVFaZCon7Ql535hUStTC9Fcg/t16HiJ2LZmtpuykPIQu4olRx
         5T7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrkmssEkVYUDSee1t4nxtYDpleByPEjdcIgtjXQZwaPMydmEXGAbCKHhUlArp5xErPf2l08/aw=@vger.kernel.org
X-Gm-Message-State: AFuF++mlUfOvb3Uz3P6AWvupVlcpR/huchFrfeVj+UjZbh31C4jj8FmF
	7KD4sUPOEeZXIB50sc9NK9NLpeXzN11AvcV2YkvqG8qgcfRSoBXKBzTw
X-Gm-Gg: AR+sD13Y3xb/6t5p7XmNgBEX4yDFCLyXl5J9AbwuNZgFFwiCOiSKsFeyOWPougZrEom
	ZvCjraCnKcuV+9zpZYIatoxR0SmIlMrWZ1ln44ierIfrYK1Irxux3xS2pPJr0UsNYk6sNFeji6R
	oFGNWMsnHEsKLIb7F9YEbeEeDocOYOmntu4oPJpN9gwu/5tiIDAo5C6Et+YmikKu1M5vq0lIL4l
	3WpMbGyrQutOzjvOTow72m4mb6lNhYA1X1nogrql7Hjw2X6UH5lOqV/JpT0ul3sPBy7u08Quvml
	erK1FBZHyMBVCt36TTaIwpQX4OLV2Qd3QqFMVnMrJu5Q+OO8S6s+rmpEKirZuYnwAq+dNxS4Gt7
	60cmE9th1+2pe+wElHvhZfC+AuwXsiviSLMb3y6d9bvxbS3jQ1LGG0Zdi6pb9ONU8tdZWFBYcY7
	voS4nWRSKhdxyh+zYeMWhEAZz5ErwKmIIxBN9twLWm8K4kTdGp5DVqDoFGShoSC5cRJsvjZeR3Y
	ExgRLCukiY1pWp8u5POhw==
X-Received: by 2002:a05:600c:1c13:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49cd52ed3c0mr89516045e9.4.1788124559938;
        Sun, 30 Aug 2026 14:15:59 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab3f22sm19013222f8f.2.2026.08.30.14.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:15:59 -0700 (PDT)
Message-ID: <ce174d12-006e-4e36-b261-4b8f41d1918b@grimberg.me>
Date: Mon, 31 Aug 2026 00:15:58 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: reject unsolicited H2CData PDUs
To: Shivam Kumar <kumar.shivam43666@gmail.com>, Greg KH <greg@kroah.com>
Cc: security@kernel.org, hch@lst.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
References: <2026082755-stucco-champion-2bb9@gregkh>
 <20260827192455.1849385-1-kumar.shivam43666@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260827192455.1849385-1-kumar.shivam43666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
