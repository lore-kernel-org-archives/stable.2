Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39562809
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787444666; cv=none; b=VuRrgv+gModt+9uVDjZxUX+IaNAJVAd4FzXYWQipIZad9hnnJIkskrZQbyQfYDixTzl1C+/ypGNwsRZCyN80k6h4HSwveeavwwQD9OF+PTQmrC34JHC+As691UBRJCeIMa3o6b6lOtICvhp36cG/Q+nAf0acG0J2ZIVvsiSeXbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787444666; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJuQUkesWOUg9SlnOmAVtG66VN3wAX+haX4drmWUuELMy/d0JZzE4hYwOaXPQOQVGmtk4QcsKJyflnKCTDQLRUEdSiPOPMzS2E/J+ZE2bk0+uumFqdjZFAjAyCG/AOFA99dvpxpnGquDCGtFtwAgZfODtJb40E4/Gf2T6yhJoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15e2dab83eso434191966b.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 17:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444663; x=1788049463;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kLGY7whYIsq9RqggyTTC2m11rxnl6jx9PypQovmEVsUbX7emRR98eGvtmMbEj/9zo+
         8JNb2WQkKh36fugO5j2M+/IQ/wJCDB6zEw3Ef1cxPmVE0h6bAK2HaBAVbnmMCAixhQQ3
         BJcu8RolOcNLsi5PXYM65xOZOdEu8UdKrKUyNfMyt2ksYGNVezsDJsOPd79F5QguYSIW
         +CIt+A1eaFNHbmBz0IihHL8qf7RR4YIvt0InFigczgo/vKuJdOL0UngK7h6UyS1+6ZmZ
         KmSM7wpKiUWuVz5q2sTFd3je+CDJ5dXHFU83ylpG8jL4IIkdwtEtVH5hNKHWGRZ+cl2O
         94Kw==
X-Forwarded-Encrypted: i=1; AHgh+Rq97lqrSH27WXXpSeR2m1S7ioo9uJO9AIWZodN+HEg0se+7P4RHSMNk0BL0UAp3h9THkRAHshs=@vger.kernel.org
X-Gm-Message-State: AFuF++nvky+vh9prXrQI+R2dei6pmKPZv+h9pfE7STKorQujk9aXAm8B
	gtqondTy4WSrBG6AFBfWOb08FFQNNrQnPp7/meF6QmjxL+GPmR24QjEV
X-Gm-Gg: AR+sD107cvYQEDsA9YmX5JNbYQhoGjwBISCsUcqxP7iB2dzogzZXU1rA89b0n6gEpTJ
	tpmovKvHV4qZ8wToQs48UW6kn6P220BbOXTieGidfdDFWq74jLQ4hJBbwE2chSm4pvT5ZkdBC61
	a5lJkq0xXD98tkheIg2wXDZQ0KvBdqN7z0iiclugmpXYuKygjP6YgexWxcwdDoS5FjbxiW3MmB/
	5omLj0ZXQg/ERETVeXm0zUdv6dh0ppBVIQlSQGh64KigOnvzJ+vZF0Gsbr4o4jp5TPDUSYcAciW
	nr0NXnSHeUpCMpPOwA9czT40HNgXuXrOi08DrDehDjwlAUEd1PVa4smsTnsDWWBK6qdBVHqJUYe
	LiJxuBOutJ3pmGBAiEkmcuczvQzcRAIRJHDyUoeCFCA2DJ5TrYoUlJYmYKrRl01fN7SvHMbbJZh
	xZk9Rct2xNhxIwS8+ps1oCa5CULnwejxTucECjUxrZrj+F3/F4yPM2c2qZjHsxLBohX3+R1t62R
	RhadzRxGAtxHia4hM1GmdQ=
X-Received: by 2002:a17:907:c50a:b0:c21:1b58:fa96 with SMTP id a640c23a62f3a-c246a39f3a8mr1806838566b.3.1787444662964;
        Sat, 22 Aug 2026 17:24:22 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24968a2e42sm438723466b.59.2026.08.22.17.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:24:22 -0700 (PDT)
Message-ID: <528fee47-2eba-4a11-a7a8-4ded7388d532@grimberg.me>
Date: Sun, 23 Aug 2026 03:24:21 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvmet: avoid recursive configfs open for
 file-backed namespaces
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-3-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260819155228.84938-3-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
