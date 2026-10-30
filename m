Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375349;
	b=Bq3PEBZoX5+fxv50qFuN8bRgDOe9rCfYA8RvPpHSDGjuoE/eUazUMMmx6BaH85r8ChjD
	 R+duWjBqhDWFFJ6LEbawJZT1JV5odU64qJ6qR/tlrIlOIBkIuE+blQwkLx+wp1LYNBPx9
	 jhx1WOmaYBKZHqbBTGTSPVnZMXV6cPvJzNj3hXkLYw+0a50UHLNROSyC12EdA7/qwgzdT
	 0BGzLo6doidWaIlz6my7OP9aZina+ll2wmSmGMw8c5y33LRifDxSM6iYzuGVaefwiTxed
	 jzK1xUuXBbEk6xypFOlhZXVVZJ3aCypr37syv3UlnpaHdl+Zv++o3C1GhsgcZOtrvtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XeWdEKJNRx847la4OpQ8xK5JYD/W25iZBdkd3AUui+w=;
	b=h+SwL/0MfGmGMViq9a1p/31DlEPiOsfTkVuIpRIpQK3HrUBcNJfYw5rOz5uBB/zBFBq4
	 4llyj1LZy9cQJr/cLrvU3nUwy2nWr4Lw0qKBlpZxTYXd7j8sGyYkh7PaHoia3TW3vv5j8
	 PVBk/MD8Ho/lIJjn/pJu7X2iKWGH+rmSfWJCT7hWXm80TmXvBQQxOx6IRMu1XhMHrpotr
	 mswkzeW+a8zXOx38SbihionG6hkMaQhzhucjdHrDCY/32SXNIavFUWIBRHeKltEL7nsL2
	 teDRC7R/u2VVYF1K/gzgumSI6qHgbgM4tXer+OhXn2Lqv7jCcSVlOGjMrqq/VHrPE5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HjsQIk0I;
	arc=none smtp.remote-ip=74.125.228.6
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F750606A327
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F750606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HjsQIk0I
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd8cb23d52eso421116a12.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793375348; x=1793980148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XeWdEKJNRx847la4OpQ8xK5JYD/W25iZBdkd3AUui+w=;
        b=HjsQIk0ITG7q8guMBxqFHFsECZy30VQbxjEJ2NmMCXdkdDWLTQHQ24VH+fluq1N6JE
         z+kjKcHuearmgOe2xOLYx+LA0iWAcQDxJ3kCfaER8N79zPEGsHUTBHlQ5d9C9W9sbVAS
         7ctHtlZIi0SUwufe0C/QpNZwiRCmO7lpuHdlQBwXXarUCCeNXI21U9th+pFyKz2luU/8
         Q8G+wr/FFAdicTFOx8PAbBKHUwprCMXPywThqzPIHxaK08tTqgEVYhFhslkWcjGnho5D
         7qf6v+xFg4OOHscQYVzoqba0ms9/afxXu5NVaVUuFnBFlftBB/t5d/dI0NEqSLiV3Lmm
         byvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793375348; x=1793980148;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeWdEKJNRx847la4OpQ8xK5JYD/W25iZBdkd3AUui+w=;
        b=yTh+qxJheUXq17rIvfryR0uUSwinhxYyMkuIVUgPoGOaxiS0vN2VrezqcGZrtRkGOW
         jGKkpVu6SIYU1SvC1m+FWW0zmLOZB8277GrYiyMXLmRrmE1Rsozw9JrBiFwNrnskvdUa
         D12k6So9/zT/SqZ5wBHfjv8FDchBM+MbUANl2LrHxgG8aZT70Fdt9NaM19addd2aSJJb
         XURV6vMqKu025+MRd/4cEMBpMJyx4qfOwB4YdZa9mAEd148QfkwYZTM5fhvQPpvD+8ZP
         SPhh9lljen7Oox0o732HDz28QJv7BEHgVH2pKzNaX9uaa48Dwv1vDvaxt9ZBlslaFTFI
         /gcg==
X-Forwarded-Encrypted: i=1; AKwUvBztD1+uwVWx3o1LuMOMCv6biMYFU5iH/f4nFJHGbVCM4Iyb1OYzTqZ6xT4IElqijvEN1tQQcjA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLZ80aUwAgHN6XogYPSptC6U4ojPKnO/OhF2VBMy8rjx0gwIGr
	MYtoWMTkZXfv0q4KVGLQmcnRd3JND/xAxyZZM4OeEcDb7tXhYNhMTtfI
X-Gm-Gg: AYBFou1sjmpf+0ANJJ7AvUVhlr1hYWozo+scFGtrAwcJLExrwzxEDYckmFkpUfiktS3
	xsZCTiYkNCK81+ZIopMHCpVttM9Bjti3k7AashJMlf88Qi74l4zngFXMiEjrLhmTJOyDBjDHMkE
	BNpM6FgUe5G1eKLrcq7u1dLq88uj1AYryBehXG+6zSdoZPEjwXuqpWv2VtYeXzZ5Kg83OnDk62N
	jqoBpjvhzS1zeDhQJiaJwdSo+l/JdS+D+uRg3UFF9/G3JzqiX26QKGszz/yia8XLx0r9wHaCLpe
	N8Ctcqkr0qhE6ujXmxldzfuPSdcirDJUOqhbhU0+0e1l5fn6dZKmoQDQA8OUINLB/86bdnCOn+x
	U6EC4/jr6vgdBbtZyAYYu6qHbQu+N6PMUNT+OaYF0Rp37Zg9SFCgWaZ5aEL8+jRoKtJyoFHOwsF
	jv7yr2TPx2VMrPqvrr/e8diXsNj3jk6VpmH/+TT5D1bcjnz+2YWqlZ24tD4vlYVDuLI7QMHPqUs
	SXAT/BG3QkyvLjqIcXVSyldvb+hkugdjepIulnvCbyS+m2eCy43KBl/GDwqsD5L907UTHYo6jlx
	ks8kPxnwl1srcyWghBng4TM=
X-Received: by 2002:a05:6a00:3a19:b0:880:fe7b:bc56 with SMTP id d2e1a72fcca58-8a9bf90d0b5mr2497234b3a.50.1793375347794;
        Fri, 30 Oct 2026 08:49:07 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d0259fsm181732b3a.21.2026.10.30.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:49:07 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:48:55 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bryan Cochrane <bcochrane@google.com>
Cc: Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <joe@dama.to>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] bnxt_en: Take RTNL before netif_close() when
 aborting FW reset
Message-ID: <auS8YWtAoDROqY_k@devvm16445.scu0.facebook.com>
References: <20261029032832.1511180-1-bcochrane@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029032832.1511180-1-bcochrane@google.com>

On 10/28, Bryan Cochrane wrote:
> netif_close() must be called with RTNL held in addition to the netdev
> instance lock: __dev_close_many() asserts it, and the NETDEV_GOING_DOWN
> and NETDEV_DOWN notifier chains it runs rely on it for serialization.
> 
> Commit 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> replaced rtnl_lock() with netdev_lock() in bnxt_fw_reset_task() and
> bnxt_fw_reset(). That is sufficient for the paths that only tear the
> NIC down internally with __bnxt_close_nic(), but the abort paths close
> the netdev via bnxt_fw_reset_abort() -> netif_close(), and the error
> path in bnxt_fw_reset() calls netif_close() directly. Those now run
> without RTNL and trigger a WARN_ONCE() cascade when a firmware reset is
> aborted:
> 
>   RTNL: assertion failed at net/core/dev.c (1740)
>   WARNING: net/core/dev.c:1740 at __dev_close_many+0x1be/0x1f0
>   Workqueue: bnxt_pf_wq bnxt_fw_reset_task [bnxt_en]
>   Call Trace:
>    netif_close_many+0xb5/0x190
>    netif_close+0xa2/0xd0
>    bnxt_fw_reset_task.cold+0x8d/0x213 [bnxt_en]
>    process_one_work+0x19d/0x3a0
>    worker_thread+0x1af/0x320
>    kthread+0xe3/0x120
> 
> followed by the same assertion from call_netdevice_notifiers_info(),
> fib_rules_event(), inetdev_event(), rtnl_fill_ifinfo(),
> devlink_compat_phys_port_name_get() and ip_mc_down().
> 
> This was observed on a machine in real use with a BCM57504 (4 PFs,
> FW 236.1.153.0) running v7.1.6: the firmware crashed, announced a
> "Fatal firmware reset event" and then failed to come back within the
> advertised max wait, so bnxt_fw_reset_task() aborted the reset on all
> ports:
> 
>   bnxt_en 0000:c1:00.1 eno16905np1: Firmware reset aborted
>   bnxt_en 0000:c1:00.1 eno16905np1: fw_health_status 0x448100
> 
> Take RTNL (before the netdev instance lock, matching the OPENING state
> which already uses rtnl_trylock()) in the fw_reset_abort path of
> bnxt_fw_reset_task() and route the POLL_VF abort through that same
> path. In bnxt_fw_reset() go back to bnxt_rtnl_lock_sp() so that its
> netif_close() error path is covered as well; bnxt_reset() and
> bnxt_rx_ring_reset() already take RTNL from bnxt_sp_task() the same
> way.
> 
> The bug was found by inspecting the kernel log of the affected machine
> and the driver source; the fix was prepared with the help of an AI
> coding assistant (Gemini based) and reviewed by the submitter. It is
> build tested (allmodconfig with W=1, plus the same change on top of
> v7.1.6 built as a module for the affected BCM57504 host). The aborted
> reset path itself only runs when the firmware fails to return from a
> reset, which could not be reproduced on demand.
> 
> Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan Cochrane <bcochrane@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
