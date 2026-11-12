Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497725;
	b=pinACt8+o8s58X7E0Pbmy8bXa3S7o5E8l8W2JdQezPlHv2s5CaoFgXRLFD+H9ytLzeSO
	 zpBMUfyz4x0sVSth/hi6R7Jh14gbWE4xm4NgGZW+A/0QKg+jYgo25tS0ZjuFojWmZ/Nrs
	 CZsaXiuw5IrZJXjtzz7WJ4vhGg27EWOcWBRe0bfRpqq9u26UdF+Nx1CG5byGEfuU3gHAn
	 wEMfnudoN3EOjJ/BHwmg2OFSTlMufuLVcE9ZnFAOR0KmKVJEmhA18lLS8ToPOP5s35VGo
	 AJSr/NwFcWyf9v366jZLEateqCjAj8JzxUD9e88Oi4t5oBsvOoY7lt7AnQK8bAfX2QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BsJlBCPotEOl3Ms/1GKReU1OR7zbrzwg9fRjbrgC3ks=;
	b=CLGQl5dYZ2pHF6ulzEPamCxPWMQODcv5Yh6eh7fmHSp9BBx9IHyv6YUI8GI9bUhrlw7V
	 yGdFB0+db2t0ifFrzLei0uQlOIc6E6fqRexnqe1NlPfvOTdbJ5GQrjOYxUaA3khf5Jqv8
	 VZX0lB6KL7r/T++z2JOJG5AJhpaSDB3oXCuGYXXF03nWJCLClVa6HO0vdhIwh6+FeaHJz
	 OQ52wSkizRuThtByWjM8v07fXsQcn+rpPnH3ZTd0Xyr9PgtKZZN6SwcJ3jQVN6AETuWF+
	 KyfrEVuxjd39vmQuelq4HVW6bpTzjNSd2Vi/ZVbPRMS9Tx5PaG/6f2NJ5jYBxNgAC6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VBkLjZ5v;
	arc=none smtp.remote-ip=74.125.224.135
Received: from mail-yx2-f7.google.com (mail-yx2-f7.google.com [74.125.224.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF92606A899
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF92606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VBkLjZ5v
Received: by mail-yx2-f7.google.com with SMTP id 956f58d0204a3-67be538da49so2140665d50.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497724; x=1795102524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BsJlBCPotEOl3Ms/1GKReU1OR7zbrzwg9fRjbrgC3ks=;
        b=VBkLjZ5vsERKU6se9/AdwZznL8IRocmJeRhRPP6m7A3NRjPAMnCyLb97xUuU2TB1gh
         pEDqyd7pnR0HlT1KAUcAeDTtsUsdOlhonglmRmTrTz8IyFS/Amw+96MoaJMfL7swccwD
         q5ig8oC5pMeNuZg04bG2hQMQcxwIPyfKX+q/3MJhja7VqjxrFm8e/X04F0AtVa4ceB8M
         OCz8orbXoIvs4vETY1fwpyVp4tD+ms1isltT71Yv8yclsHwq4lDudHefRM9wfYDxWFK7
         3IgFUdCtNhPc02iENqU8J90r0lY+5jD0G06EgSzUMxYLLQ79G8gPIR8MGgr9ap6JSoAg
         HMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497724; x=1795102524;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BsJlBCPotEOl3Ms/1GKReU1OR7zbrzwg9fRjbrgC3ks=;
        b=d9j4n0J6wiw4vpFlW4BheP1miCIj3rHe6MmkIqbtoLKh7AqBUz2lclCiL+kops3Z4u
         KgBaE12ZPqRRAJepIIzF7LFHtcHZXUw46Ys3EqW4q0KJLvameyo7ogaPTEpeDGCF6rgO
         0AzzWrW0jEx1EfW4C+q2Z7F2gYx+CBz1XG63mABkaBV9m/sp3k3J7KXLjpLB8D8K5quo
         1TvuqEkrUVjwSXAuR3Vmc9WOwH3s7eiyDK7HfHB+0+opKWyHXZMkaMqOyvxyLdKdSw2h
         Rx9oIAY1mkDqUZh0dAh/EdAiHfp5tBOPZtjfvXywFiHvplUMymFVZTPeKS8zEdelgICU
         hgFA==
X-Forwarded-Encrypted: i=1; AL+hErE4jlU+oDLUB5kV2srnKuqCTn7DkxrYzbtPMkcS2fgXeK7wU6oxbpUBWbXuJCh3cKGdpY5AjwA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OYto9e6aPtyIlFx/txnvkljSUmPzNEv84Wy3bEZGR/gpD4ifr
	TzTHaT23dCS3eSkUkVg9xlU/8yckYrB4ANsnDqHUb0W60vPDE5yDkL0f9vgU6Q6/
X-Gm-Gg: AYBFou01TtHsCDxhKuM8JyG2gVLTQw2fDYIKsqROevqsxmUQxzt6ZYR7S0LUh7Uhtao
	2gh8x5PPqyqdzCgEvbfLLbLjxBC533jbL3hNk+B6+F0K3K7WtMLy/XwLy6kjXokNDrbdZWB2kO/
	6az0KLy1J1VC1f1J58tA/D0E8tnYBF83kD2RiHIUspQeEdWexsO+3AAsKjLwCzwjFjVyCszfrei
	JTvE9+ZU723GMjSIZmO3Vv2dbe8Msw2u0Y6m2Fljy9zybqTJWpbMvmbA4e0Y39qaWUidXyapo8E
	nMhJ0AkltSyNFwRWIvJylyUSRj0W6E+0oNuQoCC3gDEauqKIg1kcb3Xk6DUyX+mrXp3VfyIA+CX
	nhGrr+bbhH2IHG6Q/ygwpSxopGD+Ec0HXIUDPwmUcjFk9IvoWF06QGoVji3lMeJzNFnLW/BywXs
	pQqU0wC826TSpn07QSxo7ba0iueusCpz9XQddsmh1OYZItaAsjr9Zx0UQFpsbZsguREDGhdqtFX
	+z8xlwBh3Gcrp6SqY6OQ8Xb2HExODU1bd/dy8APb6oWIXC63XztelmJS32WBPgyjlvKf4s7xFoE
	47Va61be5JgYPU9QUy8YG8WXe4A9V7Rn3C0=
X-Received: by 2002:a05:690e:4386:b0:67c:58f1:80b0 with SMTP id 956f58d0204a3-67c67fe095amr2023215d50.80.1794497724340;
        Thu, 12 Nov 2026 07:35:24 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c4e9bsm7462376d50.10.2026.11.12.07.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 07:35:23 -0800 (PST)
Message-ID: <225d164f-f95a-4c55-afe5-81237c6d5a22@gmail.com>
Date: Thu, 12 Nov 2026 10:35:23 -0500
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
Subject: Re: [PATCH v2 3/3] nvme-tcp: consume TLS records without application
 data
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
 <20261111-nvme-tcp-live-ctrlrec-v2-3-6295202b84de@gmail.com>
 <8f7656ef-2730-484b-98cd-701616ef1a8f@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <8f7656ef-2730-484b-98cd-701616ef1a8f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/26 07:32, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
[...]
> +             if (buf[0] == TLS_HANDSHAKE_KEYUPDATE) {
> +                     dev_err(queue->ctrl->ctrl.device,
> +                             "queue %d: peer sent a TLS KeyUpdate,
which is not supported\n",
>
> A bit awkward; maybe 'TLS KeyUpdate is not supported'?

Yes. v3 will use "queue %d: TLS KeyUpdate is not supported".

[...]
> +     ret = nvme_tcp_drain_tls_record(queue, &msg, MSG_DONTWAIT);
>
> Hmm. Doesn't this assume that the KeyUpdate is always the first record?

It assumes that the KeyUpdate is the first handshake message in its
record. RFC 8446 also allows a KeyUpdate after another handshake message
in the same record. kTLS has the same gap: tls_check_pending_rekey()
reads only the first byte of the record. v7 of the kTLS KeyUpdate series
will check every handshake message in the record, so kTLS will detect
this case.

nvme-tcp needs no change for it, because it cannot answer a KeyUpdate in
any case. If kTLS misses the KeyUpdate, the peer's next record uses the
new key, decryption fails, and the queue goes into error recovery. The
queue fails in both cases. Only the log message differs.

> And we do have similar logic in nvme_tcp_skip_tls_record(); can't we
> merge both (ie just call nvme_tcp_drain_tls_record(), and drop
> this switch statement?

v3 will merge them. nvme_tcp_skip_tls_record() goes away, and the ICResp
path and the live path call one helper.

I would like to keep the switch, for the log messages. Draining alone
works: kTLS sets key_update_pending when it decrypts the KeyUpdate, so
the next read_sock() returns -EKEYEXPIRED. After a fatal alert, the peer
closes the connection. But then the log only shows "receive failed". The
switch logs the KeyUpdate and the alert description. The alert is often
the only hint why a target dropped the connection.

One change for the ICResp path: a warning alert ahead of the ICResp no
longer fails the connection. If the peer closes the connection after the
alert, the next read fails.

Thanks,
Martin
