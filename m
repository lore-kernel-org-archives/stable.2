Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB04F4CE7
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415008; cv=none; b=Np8YV2nPGcAHDPa/KhuqOiqGJD1e1hfkFNnsKcvXENTp/19YCYk61+GbrkqMl88Yw3xgYCqcYpO4wGpr3j9UsQEDGJ7lxEmOLl2h9E3J4bpyOv7f2SSiEVaHo/6X6PGR+qZdp99cpHtH7NU8kGc7XI0MCQh2Syy35VO3S+4cLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415008; c=relaxed/simple;
	bh=QNrIDKsvgeRp/5paQVQcPIJk7NtUHcicaHd6IPX9Vh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8FeD3Tw6GcsNxf0LGT2U11O3fj2PlDwohw0PTyL6HDnuiZPGgRONSXQN7NOLFmsP/t4X012uY4mIkinSsQMY4r9dzO2VvEP2PKIi+7yW3qWMubJHOd/ILen/2FuxzMfznFfsXo7rpvv1jsf00cDeKRyBApSyjl1E7nKYX5rKFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BY8Y7Hb4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxniaYGb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BY8Y7Hb4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxniaYGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792415006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNrIDKsvgeRp/5paQVQcPIJk7NtUHcicaHd6IPX9Vh0=;
	b=BY8Y7Hb43ey74mkSGSaaBBFjW4xyjr9SD8EbubSJ4SnDajxo+uA+tvC5RCiaWiRYlcPb0N
	fi2QT4OxqnPlGHjLqsl8U9bW3KAizEqkCzyMczOTJ71EeGmFPf6E7QoKPDnYwwWrAJ/11p
	S+KV7B5LA2kdNNUAevytLEDuGRrxyFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-yqquggPONfafiwZKfV1HPg-1; Mon, 19 Oct 2026 13:03:24 +0000
X-MC-Unique: yqquggPONfafiwZKfV1HPg-1
X-Mimecast-MFC-AGG-ID: yqquggPONfafiwZKfV1HPg_1792415003
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48b00febba3so1901453f8f.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792415003; x=1793019803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNrIDKsvgeRp/5paQVQcPIJk7NtUHcicaHd6IPX9Vh0=;
        b=JxniaYGbXrxw7ERjyEzBv6nq+fA4ZrLEduTf5NySA59uOUtd69d+fLml7BetPhpLVo
         2Tenq/BRcSG0S4aSIlt3TsVnykrZPwiU9EcF7B719HUdk3rOvcE4TKUP+fJfXtf01xu3
         1UmYK3hWQoiCHQitZ33U/8G/AAdAQ+0WKr3IrJTDCZBIqZ6Od/5hA/fShyTefw818K0t
         h3pGbVXjNcgiml2aqBJdQXJKW0Zy1TYpbcGXaKYMVE+TM+qGnIs2QKOTZphyPscmkgvp
         ArKLeQd/W/U8l++kykCxItvDkfBbg6xw0SoQaW/FR7XfF67VJttZ0A8s3TxdweAqD9cL
         vCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415003; x=1793019803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QNrIDKsvgeRp/5paQVQcPIJk7NtUHcicaHd6IPX9Vh0=;
        b=srZwpqWtOeeo4KJ5sp2qs1SEC8SZEUDjGHIPaA4NMTOSHEjvc++x62lo/30B3D++Ux
         ntF+quGUF7homWfCWPVN68/fNmmjNkJoeeT7AfQT7GwRBUSBrxrshkqYX8jrmoAAaqom
         HlSnbqGtbShNkrmoUaF0f9RwkC4yV2GIiuely1nHF+8YoAX6YRCYXVzyKNvDPzxPYPCh
         ZGups7tT0z3U6gp6NFjAwaOM/4Pe5yg35PBnwTtYtp+ZWbY2Ix0HnOpZulAuXOd5q0q7
         3qJ7yEB8DvtgFiYDZGCeuGNt8hoiYYcEmq6QVPvI9C70VU8Pjk/N3NCbdeetMaMMIFWA
         EwIg==
X-Gm-Message-State: AFq9FYLMlW754q9N9vEWQyuoEsWIWetS1pj/dYFL8tqZwxnU6SlGxMCP
	u1OAdh7YkvT9rAmaldPmEJyIeFnzjAxIP6234tSfHzxle801FkfTcQYOsSxGJb6kYsKVYY2i3Xf
	zmkkSDYsil/0q+pkZ2pNnqOPnvuPIwFMO0Yrre6cC7N201QKUhyx8XzypMA==
X-Gm-Gg: AYBFou3V07IUpolO/xaxneXJz5OBoZN6nos8Ov7QNTNK6eKyDYnKRCFDycYrsNxgrdg
	J/Qa+hNzxffJTk1ruFNKkaFVw0OoWcu5Nyp6F0acSx/uKwPVugCnNUzisyCKjeEOaoFpcPO4Nc5
	NuEIimhGRmD9VZ0HMmPZv6VRY92utN32glc3U3swq7Y5BvzUie6s5tMaEu905iqm8epwBSQM5MN
	TQhpHGwwglZ5cs/rsXZMX7SVi1mh7WlsFIAopMjQDHGB0T9KKJyYhItgf3BTYhygGfp2xlFbJ8y
	sgcFyw+kLgL+Tk9o8ZEdzxIiwHP9IopaHRayAUdj9DEkdx0bB92cax//z2UEySd4kME/AzTAuKu
	BSfiSayk/XLDKKlilkyUihUaWW583j7P8kGKCPySEd6FZ/16wEMy1n44d5wRRNA81m5n8Em9ZKg
	==
X-Received: by 2002:a05:6000:290f:b0:48e:740:c945 with SMTP id ffacd0b85a97d-48e07f9eb4bmr15189870f8f.32.1792415003241;
        Mon, 19 Oct 2026 06:03:23 -0700 (PDT)
X-Received: by 2002:a05:6000:290f:b0:48e:740:c945 with SMTP id ffacd0b85a97d-48e07f9eb4bmr15189570f8f.32.1792415000735;
        Mon, 19 Oct 2026 06:03:20 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdc4eecasm22733073f8f.13.2026.10.19.06.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:03:18 -0700 (PDT)
Message-ID: <5f01c934-990a-4fac-92e7-17d1e4949aec@redhat.com>
Date: Mon, 19 Oct 2026 15:03:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: korina: fix dma_unmap_single() length in
 korina_rx()
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261013132319.22253-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261013132319.22253-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 15:23, Thomas Fourier wrote:
> dma_map_single() is called with size KORINA_RBSIZE and
> dma_unmap_single() is called with size pkt_len which might be smaller.
> Therefore, parts of the buffer may stay mapped after dma_unmap_single()
> is called, which leaks a resource and might leave exposed mapped memory
> that might be eventually freed.

Sashiko noted this is actually a cleanup and not a fix:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013132319.22253-2-fourier.thomas@gmail.com

and IMHO with very little value.

Dropping this patch.

/P

