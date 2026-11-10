Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333159;
	b=dp07IMtOiyGojNQN21HvUx1OueuP/DrU9XU24G5H9euYNqOX/PeF5240GXJ0sBRueqXq
	 3NBfn7pAFCv3v+WsBSd7rqKv/FNu/KvQJqXHKqjGNDmV7nuIfnasn0vTXnBwumWWGIjsf
	 wmrT1Mio+kVSFw60wvFTcqFXbJ5RcQX0hDMRKPpUZRZ1JFs8cq2iJV3W6kKMZt4wUsRJn
	 nNIbp+4u1d+pyotqcb5S50unHepjs6yAIwi/3RRP+3pQPSh2UjwiybtYsttZdqe4qxIBC
	 3RUK/muN1vsZXT6Ye7Yy2wG4C1HmEZH7PM+YS/j9BV+a+HgOOvklo11R85AWlQmOc9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333159;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=xCxO6wHN+TRXHIDjOGo8CEF+HLXvHWy33I8APC/0vgs=;
	b=r9KhcslR8Kh7mZLr+buAqtMakQrB9cKBYb+Pq8/krdn712qdSrx/yjc4azq5Hcpi1jmn
	 oMCxxkyRpttKz9lNegV1663HMVotA0XHdLdIfD2vmgnq95aZaf5zzpUTPoal9Ga7ZreGV
	 ddYnjjJEHu2T0Q7scZte5hVKhVGYRWsAhxYro/GGjAAqrUe4fthUu/rVbAVpOA6VZqkvs
	 6L9Gu+23cLo8QNDMEHFcNXiMWmhJBz4weqqSnGe/gwRolj+CoMpBRx3vZGvANnsXoB9I+
	 yidgYSZvn9qpOLy10C6s2VYXIUsrvuihQ21CXDXFYdoG+S8nLPxvs1Hd7GDnc9EgaQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Kg9Q+eJO;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A8606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 153A8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Kg9Q+eJO
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so1001990a12.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333158; x=1794937958;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xCxO6wHN+TRXHIDjOGo8CEF+HLXvHWy33I8APC/0vgs=;
        b=HvWf2cTnKONzaZ1f7uUdED8/zMA/TQlZSz6Oo+sUf2B1UQr7Hc97zsFaxcNquaMjMc
         a+U0Bevh5qAi4O8xNNYQE0WaZF1TX3oYgiz/QnehIb5bo6vIbOvxDgbsXZ4np8JUFe9T
         e3uFmSp+yLNobuX4DugZ01Cgau7Adc7TTrgzIGagO41612nlI3NksSHB0HsNrVjqW5dV
         uqarVDvY2ysI4Gtq4Grqci3pdM3mYC4tuxpZ1W+qlFxjAY3BTB92Hz/l6mht/61qw5OM
         co1ieoQmCwJREuv07UZXcdtRKigkHKyPQ8TWhX7UDE5b2Ey/t2W8/uiuC3L+L74/avyj
         oplw==
X-Forwarded-Encrypted: i=1; AL+hErGrpsHQjGbEu+JbO09PufeVzV2gTJ3f6Nt/roASX1cf6ZF3vxs0yYqZpxlMqP6sJ+T2Zb5Rp/Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4V/q1PDba8LtYUGNrkoS16a6ekhTR1F8Mysa/fQ4Md/mYrhii
	nU6P2x3hVs/o+2t4kZwCuW3dNUzTxpNV9jdutqR8w642E+QajMQtviXtgEXCteXx3nuKBN/CGJL
	U8mW86XEumqM9koIyZfcVi7bW/b3psYsquvMJmK8sNh9diqpsM+jcWhXVyZ3JRPVzL+5WvYOqr2
	OwYlVPDg3PedVgm9FeWYExIhNmRA03/WT6QtgDvuF3OaGSW1isItr3YFQ4Vrlv590t4xI8Wt6vk
	MqUdGgZjYqvtlSU
X-Gm-Gg: AYBFou3FlrxVYCHsir7yGTZaiabc8mowWuxdkLMI3PPVM+FtBmnQyjPxtxueaDCSsV4
	WMxugjZif8L/kb9gH2nanuTGh6BXkpWKJV1dGlnSEGmrkpQVNBUIJidQ5YartEsIBKnKZFMyv4o
	OQA6eLzBe9x5YwMtzhaiLU0L5n0lfmHX2jcnXY/B4cWqwCxDLw/72qnryxLXf0CU2ZRA8RGGYsj
	b6Pa28BlXG0nMMbQr4U6nBfLAqBLhOr45HvD3iq7hXaV0UpHxNRUNtx3SIfsG5VCbe9rq9mcebl
	FJy6vCQ/+x7OJVJEMb3w+1/whghf8Dd99N2/kFZFk1jBpWWtuj/Z0AJN5EI4PoYvzjuh0QcW3TU
	TrHihJyNmuo1Zlgj1erlFzYOkBkVWnRe/9bD1Ux9NIusbmSF4AOI4hiLbL86tQV4tVoUIVF6891
	daGx1jsYBUnEvaEqlDJYznGHTxtPBsY6HziPPVQv+v
X-Received: by 2002:a17:90b:1dc7:b0:3ab:f38:2b3c with SMTP id 98e67ed59e1d1-3b166cebb32mr3221330a91.28.1794333158089;
        Tue, 10 Nov 2026 09:52:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17e30b681sm276008a91.7.2026.11.10.09.52.37
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:52:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf6c528aso416639285a.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794333157; x=1794937957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xCxO6wHN+TRXHIDjOGo8CEF+HLXvHWy33I8APC/0vgs=;
        b=Kg9Q+eJONJstBpEUYiLBQNThTJm62XVv0rQJA+Ns1wv1T4i6qTasR46vkVFRbNw4il
         VKSUQKoXizao2u7kpuZBvv3y0qlO7RSrBBksCGHwUZ+H6Tr5IZ+s3jZNfbUD9/DF44TD
         7/z+4HXDrNeMzNgKJERcSZ/ulgP0YPEIVV178=
X-Forwarded-Encrypted: i=1; AL+hErGjzrbbTcbXyrqSpVJdV4kARxjmgfytIJKVHCQM+yv32uVm4eotuTijBueP1IymAkANFH2RVss=@vger.kernel.org
X-Received: by 2002:a05:620a:371f:b0:93e:56c0:bea9 with SMTP id af79cd13be357-9479f311f79mr562160585a.21.1794333156975;
        Tue, 10 Nov 2026 09:52:36 -0800 (PST)
X-Received: by 2002:a05:620a:371f:b0:93e:56c0:bea9 with SMTP id af79cd13be357-9479f311f79mr562155985a.21.1794333156491;
        Tue, 10 Nov 2026 09:52:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f02efa477sm1774066d6.16.2026.11.10.09.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:52:35 -0800 (PST)
Message-ID: <b48af994-293d-4a19-ae06-cc0fd586bb8c@broadcom.com>
Date: Tue, 10 Nov 2026 09:52:33 -0800
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
Subject: Re: [PATCH v2] phy: phy-bcm-ns2-usbdrd: cancel extcon work on unbind
 to avoid use-after-free
To: hyunjungg <hj351016@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: Ray Jui <ray.jui@broadcom.com>,
 Raviteja Garimella <raviteja.garimella@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261109170223.1829473-1-hj351016@gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20261109170223.1829473-1-hj351016@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/9/26 09:02, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> ns2_drd_phy_probe() schedules driver->wq_extcon (extcon_work), which is
> also queued from the ID/VBUS GPIO interrupt handler gpio_irq_handler().
> The work handler dereferences the driver data via container_of().
> 
> struct ns2_phy_driver is allocated with devm_kzalloc() and the driver has
> no remove callback, so on unbind devres frees it after probe's resources
> are released. The GPIO interrupts are requested with devm_request_irq(),
> and so released by devres; free_irq() only stops further interrupts, it
> does not cancel a delayed work that is already queued. probe() queues
> wq_extcon with a debounce delay before returning, and the GPIO interrupt
> can queue it too, so on unbind the pending work can run after
> ns2_phy_driver has been freed, dereferencing freed memory (use-after-free).
> 
> Register the work with devm_delayed_work_autocancel() instead of
> INIT_DELAYED_WORK(). It is set up before the GPIO interrupts are
> requested, so on unwind devres frees the interrupts first - after which
> the work can no longer be queued - and then cancels the work while the
> driver data is still valid. extcon_work() does not re-queue itself, so a
> single cancel drains it.
> 
> Found by static analysis and code review; not runtime-reproduced (needs
> Broadcom Northstar2 USB DRD PHY hardware).
> 
> Fixes: 787f24543c4a ("phy: phy-bcm-ns2-usbdrd: Broadcom USB DRD PHY driver for Northstar2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
