Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795331271;
	b=WxwI01/y0ZPoZ1dB3EVsdxwvQEglAnw1FWoUd009J5l/gof8TuCds1NjaR/cghipENoc
	 wlAfA5czqMLk/X432A75M3baMaVAkPbK2PvBVd3qBWOlgo0mmUeRMvKFQS7iIKa0l6tuI
	 w7OAsMLOf/oQA9ejh/9nZUKZ8vf9m6r/ZYwb0e5d+1T6pFFblI9dzCsGqqhCxPJgOXS1p
	 MuzDrbyzClPWi+/HLh8ylcJ0luirEKBtEdhVDIOAu41d4Bx6xJq4OjBWP2OME2HBJb/Km
	 x5b8nGP2p7DT+bDcGGxEqK1n29IgOis+oesf2STqY6rWzMeraiCHcQO+Eyfd/8b9WAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795331271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=yUCb8Lcy89UQfJcZKAktnm4+xKTFfwjUrjGT4Fqtk5c=;
	b=Wia5+wU6ozIwjzyGx7yqKaXQARKWGEgLRChpyCdIkT2xQMoToVLZtg6HdzHpA584NKtr
	 dCX4Yf5N5miu/FQi2/cKKwyW4f6Hdqn9dswtYp1FWp620YQSMTRHwjrhVBWrXNeMDl2uZ
	 FD63Bb4RmnvY/8PTSN08fRFMcjTdxIaOeZlJTjvWgg3d+LwVm5F0D91yRmWtmAnIOjL+1
	 8XRAc8z5927OcKtWEgfKHMyNmIGxeouYa+A7gXOhhSOHiib3yjtVuPyEyhmO1tGlqblaf
	 kYak63UAljsqacLUdeHIeuAOMAgdYQZd2AG1EW80K1EAEGWw/D2+TflFoHqgwQ1DrWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ty0W6qCZ;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3546F606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3546F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ty0W6qCZ
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f20b304c0so227008785a.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 23:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795331270; x=1795936070; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yUCb8Lcy89UQfJcZKAktnm4+xKTFfwjUrjGT4Fqtk5c=;
        b=ty0W6qCZRq7YNWiExEeclncz31xhSqaS+f1Sei5NAYDLm9JWkyMNmmzIbj2+M6YTO5
         835AaHtkR5UqmD1k1hKxSF4F7YKOiq/hOXIoLY5CvhTFaktCa6v1Di91cJsb35xo821m
         V/0YFD4QhUBPd9vm3mV2fSmRiBpd5uVnjlOG8sg3o0ZTIG4Mi1yrkmBp8U4piXqhWak6
         Bnny2ToRZed9f6zSWGyBj7/WWvNNIeL1RIZ3FbzGk+I2cA6HvkOJcc+X2sV3tPf9B7WS
         HEI4AVpZUJ2s40axvkVNvTknUHLKhMoyhKjmjL+QBmzTYNijKA5U0Btox/DimSlSzVUC
         lujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795331270; x=1795936070;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yUCb8Lcy89UQfJcZKAktnm4+xKTFfwjUrjGT4Fqtk5c=;
        b=V6/xOsXqwL1EaaFbpMLkEHkIa/lQ+BgJX9J7uzSqAuqOKDNA2gmmxmmLZ8jxuN2Mu4
         4K+ZeLTlYUhByKd3h9lEbCCPnWtMOHwy+G7JXzsI0eX3I+szlD9A2y3PnXrvUQWlwNMQ
         fa3V+QzWTuLT/UHqo67+Td0l17SqX6iLpCbMpfY8TsnlvuyNvkMWEVgqAHR5/kiasQN2
         VikaCaFey1E1DrAOMj94zBS2W+tUYo7/l5tXjgunE/Pktc5t5E5kZXEZzSARfxWjGwuz
         pwmOPiDgs1Qy2Mvjo1JTcLgP0ITSq0RA2LB4HSfIq6OsOgBdpw8Mo8oBEbmTpqXJIgio
         bajg==
X-Forwarded-Encrypted: i=1; AL+hErE/GtuIgj7MezRlyuM5Dm6GuE0Rv/jllXiAzPHtnSDDamXgrcbWjc8V2CIR9pnhh/9pNjGd4y0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Xic5tUDbg3X+VyYOdPXw6DGFdVu0nsZopjnEALJqjfEjYNTSM
	DBIaumYz6SlBqYpis+3IOX9Io+zEsdsk1vw9SZr+j1Mpk6mMYauH4EG2XH3zaW7cKcQ=
X-Gm-Gg: AZFdTZevm2PbyRPgWdYjM/76xqfSfV7W+pq801yjtHbB9TW5DfUZFlMq7Jh47F8YwTm
	xPoeNfOcHntU1jtni1EkMQKtfOtuH3T7aIXxujmlbfthkUeEpk4jCXENAhhK+wnivfF9tzs9QCn
	0MMs7B2qnYMWPUPL5KmQY3fCXVWvCoOG7Z2lK90o6Y71P0EpoC5wd76PRkFJ1MdCY/IlZUey1Ye
	J3QrgOO//l18JnD+PC0uYGmZGclmGjACJwT/JbFAc7veNaqzo+UUHHscgCoEMgSCb7GbYQkM2l4
	YUwaPf9NKj5+NQoHefjyuHOnIIdDTVUYVZeNAgl4tBSFHUlrmfSymtSmGIfCL/kfBpTMprIicne
	WGTJVSA6AFOGWx4c/XgKcl2Ae/ybHnXLPFN4x2F3JdShcqj2eCRyH8EicmVbajvmk8HUwPcAzHr
	ZVUErOFeDblbU8q6yYGXmfJsgJxlEvTXWzCiK/D+yxxrDousA+57HQR665Irw2Ko+Y3biSJPSBz
	gIAViTnD+CnTmmCOrqzyciH1tjQt9+2Gpmzawr2///v9SQUXix5zbiM0HHve6AlTYsdsw28D+F7
	K47F0J/T+OZnc2cb8aL0qgfv1Uu7IOnKbfMgBZzV6DM23eeJMSKiG2GtoFa0OBg/ePphsSigeL2
	bzXbaPwo=
X-Received: by 2002:a05:620a:8387:b0:947:8f04:1c1b with SMTP id af79cd13be357-949ba7e4216mr1216194885a.3.1795331270129;
        Sat, 21 Nov 2026 23:07:50 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213515f467sm69991526d6.41.2026.11.21.23.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:07:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] [v3] mm/mempolicy: fix copy_nodes_to_user() for
 odd inputs
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 larips <larips950@gmail.com>, stable@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
In-Reply-To: <20261120185248.823415-1-arnd@kernel.org>
References: <20261120185248.823415-1-arnd@kernel.org>
Date: Sun, 22 Nov 2026 02:07:48 -0500
Message-Id: <179533126873.412063.12506068140979067572.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-20 19:52 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> copy_nodes_to_user() is broken for compat userspace in three
> distinct ways:
> 
>  - Passing a power-of-two size plus 1 as most normal userspace
>    does can end up calling compat_put_bitmap() with the wrong
>    size, copying an extra 32-bit word from the stack into
>    userspace and overflowing both arrays as compat_put_bitmap()
>    expects the actual number of bits, not the number plus 1.
> 
>  - Asking for an odd number of 32-bit words rounds up the
>    userspace buffer size full 64-bit words, leading to
>    an out-of-bounds access in userspace.
> 
> Fix the calculation of 'copy' to be based on the userspace
> word size and use this to for calculating the final number
> of bits to copy as well.
> 
> Reported-by: larips <larips950@gmail.com>
> Reported-by: Gregory Price (Meta) <gourry@gourry.net>
> Fixes: e130242dc351 ("mm: simplify compat numa syscalls")
> Link: https://lore.kernel.org/all/20261117101910.1820066-1-gourry@gourry.net/
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

