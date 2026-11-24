Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479638;
	b=j7GhmQIQDuaQU8NPswoykK8JAmXWkq3ppwD52443DSX0KhCFNBVlHYPTBrCuXmXVN4/K
	 uaH5duRuJhXpiTMvBdMd0zH0sZBgdrgXNK8b1FC+ZdxACnSYTb39L9y5xDlVdO0/NkXbd
	 WQlVXX7wvlnFH/69PEhm5aEdrlJXPnqwFPay5BawBUaqZFWszYPk6cIy74Ida175fzs1A
	 newkpyM52OoJan1t0bvaRWpRbT2tbV++cFf1IjOQCRsV4J9WqLkDp0BU5R0BHEuRJ+65F
	 5ZlRu0ZXtHT6izhyo41h2lOmlFV1BZ/QdB3+XG7KJ2vUNdUM2x6jh3/knZevHtSkIMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RkBSZ8d+AFw648xembT6BFiAoaC+T7bdkrUAs+ewioY=;
	b=5riztyD8vKdMlXhRbsfYWyZdSCML9qMPLMcAxWE7npRDpX4vhvV97UTwb9Fh53zmWAFd
	 Z0c2BReLdJVSvSjPehyOgzTopCQpqLOLIEK+hZbPzpxtfbxztuwHflcMmgvEmH5nrry6X
	 +OB3kdttyb4el9pMJ41r3kJA7oG25WiQKLCx/NY6Jh4h5GGSbtn7k4Ek3B9iUDWbXSj71
	 m1ftWFkrY7bHeL1L7RXoGEbLHeZb7XGn9Kd4GcoF85qRgaOmMASTKyCw9gFgE+ySanRoz
	 3dtyS1mCY1gWIeA7OBk69cEyzSiosPb0/cj5b/rC85DCZjabWKLI4H0wc6Mz6UDnf/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Bw1/ZZyP";
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99AB606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A99AB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bw1/ZZyP
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f06ff94acfso12692805ad.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795479637; x=1796084437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RkBSZ8d+AFw648xembT6BFiAoaC+T7bdkrUAs+ewioY=;
        b=Bw1/ZZyPtkr9FQcp8ACv2+sq8QzgbsuKq1ha4CPohCG82WRc+ECliBBTORILGsNWKb
         u7q3C5/V/vDBQh0WydM/QaJrkMggjDaotmWESiFFLrCDu7fig0dm5glzeGTsocYd5hG7
         K6r3KbuYMWEJmfX0yQY14JAothMMvyvkeIXrSD5FXKudu6CRJa7xXbJdrvRkKXIAixj4
         JW5ATFsHKZwx+QFxjb8xUDzT1XGxhqZLV9HRySKICbXwPvottKNdGcZfZxoToqb6k1n8
         ykmqXZF+p66fgCLa0/P6mZqZxDd43Cy7cVTiBObH7ndGSg+GcL4Pa2aANAsFZ+Pr1QFg
         DqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795479637; x=1796084437;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RkBSZ8d+AFw648xembT6BFiAoaC+T7bdkrUAs+ewioY=;
        b=FCys4b5SbG4qziDeA7wtbc9FQkx71zBNejpNXGcyUDO58YvNwvMAgbVV/Io3fad2h4
         sIzzi+gjy4DStrT8vfOiOLirtYeTy43R6SEWb0cYLtx83f86A71+L4dFmOTdOSnhzfKj
         jXI0XIXmqBHYQzoihUJjnFFnY+biXuNz2KOlzqdxXgXvg17cPqZc+T0HLtho5M4PNmV8
         JRC0ZpqzJYOmbwesan7G//RvO5KuaGxyn0VZdZCwTkQV96KOpWQryBeK2lkHAlMdjVW2
         hkzu9uciVJdG1dDbjBdy7A6z+f4fbcqQiZUDBOvfNtnfbZsH8AomHzkO2pbydFf61pV2
         t/Fw==
X-Forwarded-Encrypted: i=1; AL+hErHwmPhij+4IJa36XNLqCFK5uU3JY0rhGlW2lxAoYFI3x2OJSy+wMxw9gKemF/joy8ShMBXL4nw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8MPaax4uvyze4NdwtXB77h6pckeDcgTztVuE1RAE9aNgcE+QX
	R1nfKcqu9RSjBaE/N2pSQHZ4OdS/RplF/eZVdQ2pPpJEcFnu5TdtqU8m
X-Gm-Gg: AZFdTZf8FuM3YN1enaXwTKxdKdTeO54b53mno5cbfjJODRTiGwdOygL3Pb9DWNdW5Qp
	8fRMOQcz8sdPPINl8k4rVIPRdXnEic/IM/cb1MeMN4NEiu3GS0yqgibW0xaKmrQPZKYiNLVQCpk
	dTRePPJDQgK5wzFcQE6zsutj89OWB7dd2Y54Nb6SXgI0TGgvk7FR0N9ZJwl89+UKZznS5YT+Dkq
	cxrzU5PARFEJaTg1X8T3M2eKvBMqw7BWnI3guv52YhkHOeO8cHXgNy2JAgEqVa4PUTvmlOO8G59
	AL33dy0wC59b9pIJ8jI0h3w8k839BTL1AgTvy+a8A9f6Nsui8s/I02S0U0bghg/8DNGEM9RvWKm
	jW+72malSEEuSvXXIQnoHIMXF8hZdI5AIZGNP8rV5fDtwkwE2j1jjLr3nKEqpJh76/sh8gynrUO
	DioWY88Mh+oaZWlr5/r+Q/Eaz6fa8Qb/2tGkPPn0TewV0DzzPxf3gzeGeioasPyTtNtd/HszwWE
	ZSC94aVaqCpaIQ5F7vAXRlCot8yYHkfkwgDKf/6gAbw53GNwon8IVvvRVLeNIHchED5HvwCOecr
	U3s5FyTbAefeO3acGTC2dUvMAxG0HpqxRFSZ3ycx7Tcl
X-Received: by 2002:a17:903:298c:b0:2e9:5714:6075 with SMTP id d9443c01a7336-2f03f117c82mr117452435ad.17.1795479637005;
        Mon, 23 Nov 2026 16:20:37 -0800 (PST)
Received: from ?IPV6:2601:600:a482:7d70::b4f9? ([2601:600:a482:7d70::b4f9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee85466sm59365165ad.4.2026.11.23.16.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 16:20:36 -0800 (PST)
Message-ID: <b18b3bfc-d95b-4538-b5e0-0fcd5200e69d@gmail.com>
Date: Mon, 23 Nov 2026 16:20:36 -0800
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
Subject: Re: [PATCH net v2 1/2] net: wwan: iosm: cancel the ADB timer on
 cleanup
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, m.chetan.kumar@linux.intel.com,
 linux-kernel@vger.kernel.org, mail@maciej.szmigiero.name,
 nihaal@cse.iitm.ac.in, stable@vger.kernel.org
References: <20261119042714.505405-1-davidlwesten@gmail.com>
 <179541106939.3135.3810191786366936844@kernel.org>
Content-Language: en-US
From: David Westen <davidlwesten@gmail.com>
Autocrypt: addr=davidlwesten@gmail.com; keydata=
 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
In-Reply-To: <179541106939.3135.3810191786366936844@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/26 9:17 PM, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> 
> Does this cancel fully close the use-after-free that the commit message
> describes? When it runs, the netdev TX path, the IRQ handler and the
> ipc_task tasklet are all still live. Any of them can re-arm adb_timer
> before ipc_mux_deinit() frees the MUX.
> 
> [...]
> 
> There is also a second case. Suppose adb_timer fired just before this
> cancel. hrtimer_cancel() returns once the callback has finished, but the
> ipc_imem_tq_adb_timer_cb entry that the callback queued (wait=false) is
> still sitting in the ipc_task queue.
> 
> [...]
> 
> Would it make sense to stop the producers (netif TX, the IRQ and the
> tasklet) before ipc_mux_deinit(), and cancel adb_timer after that point or
> add a second cancel there? Two other options would be to skip
> ipc_imem_adb_timer_start() once teardown has begun, and to keep
> ipc_imem_tq_adb_timer_cb() from using a stale ipc_imem->mux.

It doesn't fully close the use-after-free. TX, the MSI handler and the
tasklet can all start the timer again after the cancel, and a callback
that ran just before it can leave a task in the queue. The race is
older than this series: unbind and hibernation run the same teardown.
With the next patch, though, it happens on every S3 suspend.

v3 will keep the timer from being re-armed once teardown has begun, and
make sure no queued task runs on the freed MUX.

Thanks,
David

