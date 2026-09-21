Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECEC4EB85A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011851; cv=none; b=sIGxNy1Af+KsR+bXz/QzRnQx9aQFxGlpR+5SFsgnaLYEsFVy0TCD8NlJ6DDKkhJ1KH4c5IZtDKvrs64RXoEkvy/wtdFd2i3Cq+vFpQrRrOzND6AZQcI3gI5KHdchApd7I1Yuv32qaYSv/45+OwJ9KYr88VUR+o8lAk34bgkmXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011851; c=relaxed/simple;
	bh=+5uZ3k0+i0138r6TjbIE8SkNZdIkmusl5Zhh2otCCDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ryhf35NzI2QO/bm02oL5TnvJ5m92Cux9iDF8A7qb4wptwf8+YeHCoZm6EVmNdR2RawGrRNNSDWtIJIxUj1fRcflQ0v23xfWJ7rESTBM1Bi5jH+ELjPiPTITlrCQkqAAZdLQbBgKWFl/RbvylFQ0DzjMOfOEg6N6PDJ2W4NUeztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bdzojxby; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bdzojxby"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so9372875ad.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790011848; x=1790616648;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q1m8FIyre0txQoAK/ZMa3aVTldIqDlQtinxWjfyCf64=;
        b=vKf9z153Q2T6W9Jp9YF+t0edbw7uH5vLchgBWQ8Yr90ZFsscedVZ/pBhKo69vODOGy
         VmKL6/0olnYoVd95RohSQVnQd/odjNA6/sIof0OqE9MuZA1uLpxA1ET1wMVr0TDqBPvb
         f2f79GPImDnlurn4A9kPkrldcZmT4VL50Woro7Op9fKtIs4UaQCNa+cmnvqPyFTIo3nT
         LYBNsXb+u2Kk/y7sbUMyU8x6NSDYeX7QcEp8O8oDqWUwcjUdWsPPWvJyBVdSevxzSyqJ
         ybEoQLUYllvz7QuvKMHzBPkL52fI7E/wRWpZoKcPvQGNMsdc+DXYgMBsGIBVaL29VH6j
         +z3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzSt01IbRHxAjAkgluxy72zqUEOCTYQ/jRjb2dZKVgt+bf1wY0H8xRWChfar/S7ViXYIRHVTXk=@vger.kernel.org
X-Gm-Message-State: AFuF++nEXblL04DS62kiFIZduoeCvd6DGcPpj1e6fGSATxeHMUL+eJ5D
	AnnQWyFzeYFIu0KzC898GpJlZwCXDV5J5wJHRAOJg5/EYPomuBI/XMq4CYV3c7frHxnJBDuV9wC
	CjrMZwI7UO2YIZHhGtCRjJIzpEqqVBbLPaMmORQsJaP5BtoVdfRqL1aNKL1oqqONbBFir/BM1sU
	lRgk75i9ftCVkh5SoztIMpACozQJfJT8/jyQDxPEkPX1YIF9a5gh2H68Vzu2pTE2YS2sehYuoAr
	RqJrhEfb3JwgU2T
X-Gm-Gg: AYBFou16kspdn50uIGX5rBYa+SAg+imLWlcYJCvJkQLucGDG9Mqa4I3Byms0KR96KTj
	A2jwkC/TuhivIR3lrXzQUhm60kM5MH5X3P3bznari7OMPi2rh8tuPJdL3p7YQNwTezNx1Kwn3ky
	j/TvLu6+ic9Zp4A0tls5lBh6YFfMHT0GO5SmCyQi6S0wm0Po0SXWVkCH4PkvmMW4xBf3o+v2f0Y
	QY9Knpt993pZSwM9qedna5dpP6I4jLwbLNtcCZ5QFT4lSnGzc1ATmodAY6uFp/eQPje7unhKyFU
	QA12NeRd47vtIiSsKSPdNaRQn8t8UcU8/JdXOMsLpCWBe55Nzedx6aYfBdL47jmbFKeDocPTOy7
	89EC7G9HukdLzaF8V2x2LI66HSk5/Ds04YfvorUiVSCnuukM/0hIoWunjtgNgl8vs691PJTPWDr
	1irtDqY+cC8lSB+pNP+v30YV4k7nKBgiWcGiFcJfvd
X-Received: by 2002:a17:903:3c43:b0:2d1:134:b86e with SMTP id d9443c01a7336-2ddb1acac1dmr183225015ad.2.1790011848147;
        Mon, 21 Sep 2026 10:30:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ddc17a9139sm2630265ad.13.2026.09.21.10.30.47
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:30:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so502143185a.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790011847; x=1790616647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1m8FIyre0txQoAK/ZMa3aVTldIqDlQtinxWjfyCf64=;
        b=BdzojxbyQnqq7eUIXa+7FSuY8lerBs/UtW5iD1HOVf7mXT+coZ0kW8YlBhH7SFMzDj
         dfNh6lgjXVNVX5+8TLSmhX5eruAhCVKqHGHGr5I7okg5I7jepTmQxB7gveOinJIjC4UR
         JF/pJijCptnnGk6t2y1DA+Qodz2LfAVyr35Uw=
X-Forwarded-Encrypted: i=1; AKwUvBxLKW29+4lMRFpCgnF1y9N1axTGzl87YoR9yVr2VJfwx6Hr2+m2TA4zEML1Lgu9OT3+8WRd3fo=@vger.kernel.org
X-Received: by 2002:a05:620a:17a6:b0:93b:d7a1:ba12 with SMTP id af79cd13be357-93c15eb8261mr160199485a.61.1790011846432;
        Mon, 21 Sep 2026 10:30:46 -0700 (PDT)
X-Received: by 2002:a05:620a:17a6:b0:93b:d7a1:ba12 with SMTP id af79cd13be357-93c15eb8261mr160193585a.61.1790011845878;
        Mon, 21 Sep 2026 10:30:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93beda72290sm686610385a.8.2026.09.21.10.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:30:44 -0700 (PDT)
Message-ID: <7e2d1041-35ba-4d7d-8702-a13275e1791d@broadcom.com>
Date: Mon, 21 Sep 2026 10:30:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_bcm7271: fix use-after-free in
 brcmuart_remove()
To: Fan Wu <fanwu01@zju.edu.cn>, linux-serial@vger.kernel.org
Cc: alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260909084002.686911-1-fanwu01@zju.edu.cn>
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
In-Reply-To: <20260909084002.686911-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/9/26 01:40, Fan Wu wrote:
> brcmuart_handle_irq() starts priv->hrt to work around a receive-timeout
> quirk of the 8250 core when hardware flow control is enabled; the timer
> callback brcmuart_hrtimer_func() dereferences priv.
> 
> brcmuart_remove() cancels the hrtimer before it unregisters the port, so
> a receive-timeout interrupt that arrives in between re-arms the timer.
> After devm frees priv, the callback runs on freed memory.
> 
> Unregister the port before cancelling the hrtimer.
> serial8250_unregister_port() shuts the port down and frees its IRQ, so
> brcmuart_handle_irq() can no longer restart the timer, and the final
> hrtimer_cancel() drains any timer that was armed before or during the
> unregister.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
