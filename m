Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469537;
	b=2RVGDBO8mXm+vSD9kCFStChj84CoUVIsRUNlW8c0y1ic8TwbFBej9T0GYBHkDvJdBb77
	 MzOa7T9u4cMql1vuz74eOrpWUP4N7JOI0r+Y5CTx2+bJEflIhZoGBFch7qReuxoDOPuXE
	 MkVJmY0jZZ6Io1Y+jPiGdvp4h7QEMahb2keXyNp/jUCUs9zuM4K44IUPhHLEKCdmwt762
	 6uqKr6yDMXnDSQyiURZgIMriuS6vSNdSL1WLwiMu4WZV0rW3y3mQHsmkNGkxtZvrVrnUb
	 F8tQf4hhqAGXOn/Vwdcw+Bou0G663FS5qKwPHCeKcZ6/h6jTK/c91lRsKpNLqrSZ2QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oMcHckr7xzBy87rdjUeibIDdjsNnDgKiiqf5JhMKkgA=;
	b=Y2/1kaVTaqXOiKm0B67Chf+w18XIaW0JNKlBGMezC87N8ANIdLSqaJmCN8F0Prg6C+zo
	 FETW62AY4gbAVvZJ+hRtAZZw/fBnN/IBfpGUChoXu2HGzlfHKr9dgcISGIeU9tOcgYs0/
	 XJDypml543rqSV3KfSwTWe/2X3qgYLjclXgmdmWyZzTukoXCKz6qWVzD0CTOLJs8MRGI1
	 QDHO+9xi6DPkCohzIK8bq8c052aOnRciblA8tLEd3Xpe/7xaT5iplOiaK/MDzi9Si7nO7
	 +XYforQ0iFLWRrsOe6EnjkOE8vbauaPZUdKwXrq79Nll3Gth5cM6L/9QI+W6odXourQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRqG1qpm;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590FE606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 21:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 590FE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRqG1qpm
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so3485155e9.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795469536; x=1796074336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMcHckr7xzBy87rdjUeibIDdjsNnDgKiiqf5JhMKkgA=;
        b=QRqG1qpmNHm3CINMJEGFCZVUZIHELj4/YROVzdBghlrKedFgufnZAPMpY5qyvBwUhy
         VXG2uzc4GCyrh29M6DVcTOeOk/X10AO0oLoqOrCTQcA6qOKkuY075ncIJotc5BqGxf3Q
         SZ7LppdbEcXHlQbh5mziFtI17CPDvaCl3BZT/bkDeWMYHQccfYHLlCdzEFUcL6cB7UzC
         oESAP7RI+3rqpO9C4nHf176roq6sbARwbEBk8D7PWNAbN6lLtTtUeQhKn3aIyO/EPoc3
         AsKIkGUGvD7CBVf4nzTez+L1uItMEGA2xKKPPGHMGwdwJ6wV6RxrDczkSJrPv81VOlNg
         TruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795469536; x=1796074336;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMcHckr7xzBy87rdjUeibIDdjsNnDgKiiqf5JhMKkgA=;
        b=oqTcsgLqqIihjzeSJ7WW1NwaaFs0JrzLk0B16c1qBDYcn3q49tBICwWE/17NlIV87f
         FL97L+XX9WbPHE46xuLv51xEOpaCoRTlAfZhnom9bzZgQU552nX6IwE4yaOFiY630Ose
         kRB9x38UHVwt5Cuy+ULtHAIwgqeqZppr7AQWQCjDJwWZXnW4bea3yGUtW+yWw7GCp4OH
         qVN1LSZBKL3GSDacULYFLkWDm4B+TLXvMqJJnFgCgWq4tRV9C36czFTw1k4nqRpWaila
         HI1d3YsiawW6NA8XOSsstsfK7Ep+KNQzhW8T7NsTFQKOS2lF60RDpgBJ9WM+FAfieIbv
         RZfQ==
X-Forwarded-Encrypted: i=1; AL+hErEBADUvH/HMYghTdGb211bjCG1ja3XFcjTYSq5lzp5/mMB1wEEJVmYVblBt9cac+zQyslZeXvQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8b4wW7o8Z1Kyysi0mC4W4vYYtqGnkByibigFNvC1u5grGTWsk1
	ThuFTjfIeRDvN3A2oBZBEdqsDT30h/zoYQ3SJj1/E5fnIJIuZx36L54m
X-Gm-Gg: AZFdTZcOZ432LvWanWj/hojbP9DwfTkIt3ErrPNqMfnAUHDWHn9BhJgbIwkYhgodqOG
	K94x0XZvejEU8PbWjEgqbwEFbB7NXIyAAONoIQaKjZfPh13jnAau7YoVT0V4Gu6AZc9pWXjMkLr
	sHk0ls6Py3H1NzCRpKIX5wZyXkvQ41jRgL9B0zmvFU0WESLcME16xFx7TjuQ+tSNxqTqjqT9oMf
	hARWxvDHVfdxkgFgRjYADEBxCBTaCQwcoJJldAlENPoPdC2zLbugJKnFWEQzV2dFtnLJ9nuuFUO
	iUz0rw8xJ6Jaqrz8Z3TMCACtjY+4UFsO9n+gwR5FtULasa04FcvDbMi1ZiXPY/PBtdzC59NVd+E
	qhQ5njav3QreKbIEQAZadYBsz8JQfdO2zJBJHJRyPAJFB1Bdst/j1riAsAOBWXcptcMruf70lNx
	TJIl1LzGddr2dCuznABl+sO62458zB4noCc0uV9bduukUKcOwwqMZKM2Hdp8nqXWsdglH2VRQX5
	yMIwChzceoGXkSc6bdHg+UW/Q4UtPGCyICCWjWyzlollOTF8Lf0U6HcFIny6HaoFKxwWrDk1gFW
	3kJVZQpjhw4PqJz2nxrUDtJ++EtxhV6uN7oRxCFWZuO2HUTboZ1UYLbbZ3SUC7y5bCmRUjRnsMn
	LKnNSBuERung1WpErYgTP2DnXlgJG7MPF6p2TIhArZ/iUpB/5dV1f9lFvrYEFty3r0fY=
X-Received: by 2002:a5d:5888:0:b0:4a6:d298:832b with SMTP id ffacd0b85a97d-4abb6095e39mr24438734f8f.6.1795469535507;
        Mon, 23 Nov 2026 13:32:15 -0800 (PST)
Received: from [172.172.2.5] (host-188-174-207-233.customer.m-online.net. [188.174.207.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm22833466f8f.18.2026.11.23.13.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 13:32:15 -0800 (PST)
Message-ID: <43dba41e-092c-40f3-b92f-45c8ed063c48@gmail.com>
Date: Mon, 23 Nov 2026 22:32:13 +0100
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
Subject: Re: [PATCH net v7 1/4] net: hsr: keep GRO disabled on HSR/PRP ports
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org, kees@kernel.org,
 petr.wozniak@gmail.com, qingfang.deng@linux.dev, fmaurer@redhat.com,
 luka.gejak@linux.dev, bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com,
 skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
 sdf.kernel@gmail.com
References: <20261009201324.17-1-xiexinet@gmail.com>
 <20261009201324.17-2-xiexinet@gmail.com>
 <6aae7800-5306-4839-a4c8-56265a0fae45@redhat.com>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <6aae7800-5306-4839-a4c8-56265a0fae45@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2026 13:27, Paolo Abeni wrote:
> I don't agree with the goal of this patch. The kernel allows a very large
> number of bad configuration. Explicitly preventing one of them may
> lead to regressions and leaves the lower device in an inconsistent
> state.
> 
> Please drop this patch.
> 
> /P
> 

Thanks, understood, and I agree. The patch is still 1/4 in v10; v11
will not have it. The macvlan GRO check in v10 2/4 and the selftest
cases for the GRO policy depend on it and go as well.

The segmentation patch splits GSO input on every port, so aggregates
from a port with GRO on are still forwarded frame by frame.

Keeping GRO off on the ports is then a configuration matter. I am
working on a userspace configuration tool for HSR/PRP setups, which
can take care of settings like this one.

-- 
Xin
