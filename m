Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424033;
	b=2YD+xzcnyMWNGJzCdJUmYzYOcv8ccQxHXIevSBjpu/dmj6phLTY/3hS/XQ4q1BnJjF+S
	 kNtXM6HSvAUlVQPIF7OYjn/VZVtHvqplCijAHoyIUQpoJR5d06ikyRbIvWHCCY8t/mjIk
	 ml0qtnIcM6AUQJcMYOg8UgkdGb+3jefX/XaM09oOoQ53Y13WhwfX497Haw48q59aR1KGw
	 JRCFtv66xAsJzlyonHaXe8yxLDforlk/5/y5Vx2+GluAmDnC0bQLWF9DsSx/8XXPz20bM
	 26gqtNmWxMkBbAaJjBFi+wYL1u18XfUEyKBZitXntGgkmSxE7tzEzAOZqwe96Ocw9Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qvGcuiMvzkgnIAM2MInhiFXlOFrLbqnlcDucLLp7jgw=;
	b=GnR/1OcIXmaO4UKza4mFbPIuxDTDXgvXxdFCQlOADfWxR/hjWE8mOslIGlIgcmoOUvXu
	 LfcH/zidPX2EPpFvOTx/wLQZPIHj0LqMS2kb4U687KaQUfjfpQ6I7jWyee5fipf5GlpwQ
	 Vd+AbiWnJiftVkMF9zHdRNqs5tXh8x4A35Zq6dL/TCQAjFky5tWzFwzVd0Gylo9jgUJk1
	 4mvee0T4JP+fy2Uwyj7zRzxBEPrlDt0sOZ9s23c5v8S+a60ugLHI8e9Zbxu78n7323zQS
	 4UsaPXdEM35q1s0TXpZGCBI8pdmkU3BEx/AlXqe9HuKmZPa/hM1xcOZvz/XxgwjNwlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="Y36KJ/+u";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA8606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06DA8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Y36KJ/+u
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49465892f7bso2200192f8f.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795424031; x=1796028831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qvGcuiMvzkgnIAM2MInhiFXlOFrLbqnlcDucLLp7jgw=;
        b=Y36KJ/+uELTQEZY98mnBxgqeidd1AjqL6IC95iTjrD1MQcPwDUAXoqOQ41nEjnqhX8
         z+C32A3W7nsGEaBnaGCIo+bjaki/dH78Q79x41OkQ0jPmlpMg0f9GPwXGCTQj7e5sAIN
         3QpwxALgM9ZbVEVL0ADyu548sPr9F18ErgG9ucJvSVpA0QGP/IrQ45fl18X1fZrB/bi7
         akMgL+3K5DDuXjoeg37350xVfUriTAywWa11RdTCQbwm++MUV33DfSHBYlahX7YT+cYj
         ad1AKzg71It2G3mnFkZbT0zqu8KLJJMdbLkxUEPvJB+KT0nwrmmiyEUEGdokT0TkOWc2
         NBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795424031; x=1796028831;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qvGcuiMvzkgnIAM2MInhiFXlOFrLbqnlcDucLLp7jgw=;
        b=VmpsNIMokxWYS3mGJLiDsANFFSoEzQxQSguf6I/v9TDNKvOYpXsE3y4aboMqmNTjqv
         B9ZJDUNqQInmXN8zFd52dJ63b9de2GPqak0z7DLP3SEhD5G3IJid6hBubQDCJwOW0oWb
         iEBUyYAc/CWQETQ0LUenxstE2crATAxNGdpmksbe8OIyXxFMLVvGFTHuhSxIjW+9i8QF
         ge4vKZvVKx7Nyz5shK8IIgGvrFdXr+KFpAsRvgs8Rkg5CWgz2tuezLBPyZwBolUffliC
         FvsnLs6DkLte1kEUtXfvnphr7Stlj8bEzi1gZKxXHOa5vZxUImGpDmda91CS6J5S9egm
         WwRA==
X-Forwarded-Encrypted: i=1; AL+hErEiWvb1VCdA5ob/ALNyeZXRwfrJh0sSGQg3OxfH2mZJmAx8ye3jrhXxQEf67hnqbXpnuL0yku0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hhPXeEDX5URZvnhk0lVDbMg9V96/NQYfUzZjzqaaUzgl1CJSr
	yE7Y9z8MnX5B1dQTNYzK/EyrRfFN/phais9kaW31CrM7KQPwKr1eqpyAfRTBbCFOdlU=
X-Gm-Gg: AZFdTZdOL6WkZjj6mmOY2GM4YkY6PlDb0kcDgQhgXZg+rxXKpBBE1M190kANkMRe+8C
	+ldxJ8I8xBCRKEAT2djGE0hYXLzMMZzlr2gWp35caVuS+rOgqgoNwAjn6BGGBZ2B0vCBkaUFS0q
	a+k7AviDe0YuSwf8Zwn2cp7PxESijKx2LeISRrBWFSGW29PCNiR2cxHQsive+3VAKEAEzaX0uOv
	RmKPtnwU+m3ljr0O7C/chLev+bxaJ+h3WYdgjNVnImOHHd7dsu9BtXfeessCIEBVPcwRmxy8fia
	w96wPSS1J2/YOZyE4j5zzx+a1cpB6B9L34bt0Yf6arkHc4VctTgH8uDrcBlP6vKdd2KWnpyWn+E
	Be0wJDzdxKFBH18J3Jkru9EkUeuVj/HJo8qs6p7rMODGsk9Gu/lWp5LSJ/7gjKvQRnp1yHLkpeP
	owiuPwTUhuVdjWVo37P7GvJpAdEoj56g9xF/9GxhkFtpznpD3S8H/5pCY/4buaZNY+50lokNlzs
	uS2jH1M8YKO8n08vppYgpWN5d4mBC3eaOd41fKBGIExx0//ZrXMLRlCxqEjo4FDoNGDSj9L1PGw
	sELr0GwOScOpX99d6HN9ZT5o5sMoOuNHrxQGxTUEr9+x9Afhq+hJCSipgxF9xLPanCCaM3HkccP
	Y1S0/LLk5G8Owf16Q
X-Received: by 2002:a05:600c:1d09:b0:4bb:6fd3:5ac0 with SMTP id 5b1f17b1804b1-4bb88816c7emr237165875e9.28.1795424031393;
        Mon, 23 Nov 2026 00:53:51 -0800 (PST)
Received: from ?IPV6:2001:a61:131e:b901:6da9:459e:7c6c:e85e? ([2001:a61:131e:b901:6da9:459e:7c6c:e85e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm331210845e9.15.2026.11.23.00.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 00:53:51 -0800 (PST)
Message-ID: <f9715edb-94be-47cb-8bf1-f84a3323f000@suse.com>
Date: Mon, 23 Nov 2026 09:53:49 +0100
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
Subject: Re: [PATCH] usb: image: microtek: don't receive REQUEST SENSE data
 into sense_buffer
To: Alexandre Becholey <alex@becholey.ch>, Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20261119084526.535901-1-alex@becholey.ch>
 <643a71e0-7347-47f3-8cad-ce31f76cb8af@suse.com>
 <AP57iwtzG1Kr6EB4hY7F0Hd-DaLhPZJzxoKNuvDpeiAKZvyxsddI1fl6kRKAc2Xg1ox0kL-KAdNYmZrRMEYN_mZRamfiV6nXjdcfDhJhGyY=@becholey.ch>
 <e3956050-8b80-4270-998e-2e5ec70cbdf8@suse.com>
 <8iDv29vCFEOxycORJWCZZoTT9dMFbUZZ9VK25sT27tKoWWtaKvLKZaW2YoQDygTrSRkZRE6Pu5PmkMFLl-PDCWXI9n1l-LSB9aJCByn8gks=@becholey.ch>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <8iDv29vCFEOxycORJWCZZoTT9dMFbUZZ9VK25sT27tKoWWtaKvLKZaW2YoQDygTrSRkZRE6Pu5PmkMFLl-PDCWXI9n1l-LSB9aJCByn8gks=@becholey.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.26 16:14, Alexandre Becholey wrote:

> I looked at the other drivers for that special-case REQUEST SENSE
> (in drivers/scsi, drivers/ata and drivers/usb). They either
> transfer its data into the command's data buffer like any other
> data-in command, or emulate it there. I found no other driver that
> copies a caller-sized transfer into sense_buffer, so I think the
> fix belongs in microtek. If you see a place where the core should
> enforce the size, I am happy to look at it.
Thank you, that makes the situation clearer. Yet it kind
of brings back one question: Why does scsi_cmnd have the
member sense_buffer at all, if you simple can write the
result into the generic buffer?

I have no problem with cleaning up an issue in the microtek
driver, but if an issue is to be cleaned up, it should
be done fully.

	Regards
		Oliver

