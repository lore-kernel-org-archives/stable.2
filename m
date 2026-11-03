Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736646;
	b=yLCdjs+Vkadm/P5OPD7+7rWR5cgq6Ivpj9TQspcFILlTTm9k7as76yOJb4wIp+uzgcv0
	 tKLEkDRSGunPnIlijFrNvUim2j3TBn8Vko8LRIsgoSOTIKqgwej1YyAA0Mw8pyxemysLf
	 sROzulGioFlOPXFDZaTDCrbaHML69hptyXH3XqjhVlHDVtVTZ6kVulNeoU6MI62TC7u0H
	 tNDGF6RKJMvBewk87S28eHKEbMWSJlBgJo2n3eKyq5/NVsSwgFc1uvyWd4V/KYt8bJZpV
	 e42Ho/mvo+9S3rhEIy/mi1lRgRw/NzsI58LTBY0bPriAG2wGinShF9j7ElIXYXaZTiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=G+e0C+OO2ssPNCY+CMpKUyz+R3cTGFEfmTPvkxrQ+aU=;
	b=BYVvsmNW5KYXTQURdk88XnNEKdFYrQNMEk2RIRnYoxSkuiihuPVWaDN4SbT3k/7a+dKA
	 4JpoLwBeO7PJuJgqto0mUrac+HSksnkjhwaJjp/V+mfknc8DkngyFgibnF3vTV5FbEMgO
	 lzscekE1Fk1+e1TSl3KXkBCGTR06HmeA6zVOLBPuc7JHK0NiQeQpELyRsWfWG9pUXsr9B
	 vGFDzUleJAnbMILt69ggC9Ay1h0mxkf0uhSK2U++BoVQSecbqvFFG9Hqd6Zc/vUW5+2eF
	 1HWWlLuLs4gEZWKCZVc3VtIDQIRIDmeVDW74x/XKa4jw77F3qO0DknKwTOyI4X5I6bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aiuJxGNq;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D909606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 20:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D909606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aiuJxGNq
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-368c26de2e0so1219069eec.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 12:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793736645; x=1794341445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G+e0C+OO2ssPNCY+CMpKUyz+R3cTGFEfmTPvkxrQ+aU=;
        b=aiuJxGNqM2NOSyqLYh6xbIBKOf21JDB4WHU1FyrgtQBJZArufAJ0HrqHViyCi6VD38
         vRVHbkUKCTR4vl8vruhaj+5eMiuN+U8fqOOCro9zpjEpBRYYf9lLfxnGQ0LZFl5JH6IN
         8Ugtk70zgdRxYJIwwY2K3f+TweezPzv3QsuPwBe7ZYHU5cSmedf1L/S/1vKgctgmq2Wk
         fLaPC4K0kgS2dYkqhL5k3FDjBUvaMeb0sk4FG8b2w+z877/RtUSt6NewD9lzrSQS4USx
         Yn1EIzEbSO+F1BZtFUXZYpuPjkz8FoGmoAo9k+LE1kdlS1yFXNg06wMs0Papz7oZdk4P
         //ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736645; x=1794341445;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+e0C+OO2ssPNCY+CMpKUyz+R3cTGFEfmTPvkxrQ+aU=;
        b=FIpkr55nAgpWJExeSC2IeDSHEgt5o82zvn7DPfyZbo62/HS1KKpgxwoN2+cR9ilk4p
         XngVZnMXg8kWvjNECX25JJ7OQ7vTg6rZOQ8G7UIfQTZjLTlaOU8i/m5pTJTPdYrtwloc
         ocd5z+gDM4FhRp3F8TuHFq9zYSgoQPzC9v96B0c8HKRrYOAvTJKwbTpnlgVrK180sHyl
         DcNFxWjyZkAG5Sa2ORYS78vqbsADK/78f3UyqNFvFEgkWtZxIuN+LIXpqFeimYQQ36gC
         3sjnZCaqWEyeug0TCz8TuJBuBfiMhIR823d5ujAYHo83i7Qh5+cmGuW6XuoGfy3Jcyof
         6BHw==
X-Forwarded-Encrypted: i=1; AKwUvByHMk3TOuKyovushb7glx8vize9n9CCYvtyJoOchaY34Ouo6MLOhbcrYhfHprKtJEttDDUWP8M=@vger.kernel.org
X-Gm-Message-State: APuU4Z81+p3l2G1gV1ev3TmkJXcdddm3QwA+XA7k/AN6XYq0FFL9zowO
	6tD/3f/bLu7uqdETuob4Wl1VexLDcRLyu6HktsJM/SwRbPZkWHkHaW/a
X-Gm-Gg: AYBFou2QF6j0VyBe82YEb4mBcKPNVSzuqgYOvRCtvHCFrvN1CYTfy1VpDVqizo5oIgM
	Wz7reYgoxY91HDh29rWObQAbXHVEwt3kWqtf7M4LgbEqnRXI/EO36Tn2EyLOiJ++hHyMOyabHS8
	tNrhQdG7iMS/fCCEQvZjQsr59GA4Xh8+NAkqqqa1eUfey6UXO4XDHlWoFlmTKNVEYqHtJcq4SYp
	VcwEkwRhYihVVy1kLlXXGu4CC9J832HwY05i22cjinZQKAPfnmZ5Hi6EPtZZUw7qHAUDNB7BVaW
	E/WLeVJOJCV7mWarIZh9rR7RSHGa0ruMlty0LG0d0ujj7rrDt7ggXuvVfG6Sc5qbsrW1W8rT99Q
	xeMcbvybJ/rwpJ8LING8B4dreRzVrkVEOG2HbyzyfZjMBrpDruy/t0zLnNb41mpCcd+QISZhfmz
	RlRW+TTGgEhRm0WUhvcgAr13uLm5mU1gySXNlOIoVo+u/HirN8r7lW+SRzz0PyYOP5KA0OvuAcj
	IOCrDOuCBlT3mVDKR9IT0hVGg4m1iMhHSDQBRvvqMm9szHrP6SAduUFjYCedv20lokmknwFkTOS
	rmMhjL37xBXrCR2UM/2ZGnVuAHrbpVTnlH4KlyltLrI=
X-Received: by 2002:a05:693c:2512:b0:369:fa7c:aee9 with SMTP id 5a478bee46e88-36a423f54a1mr20127351eec.19.1793736644552;
        Tue, 03 Nov 2026 12:10:44 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:41::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a54ccsm481879eec.4.2026.11.03.12.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:10:44 -0800 (PST)
Date: Tue, 3 Nov 2026 12:10:39 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bryan Cochrane <bcochrane@google.com>
Cc: Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <joe@dama.to>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] bnxt_en: Take RTNL before netif_close() when
 aborting FW reset
Message-ID: <auo_uBLO1gNqk2HN@devvm16445.scu0.facebook.com>
References: <20261103042210.2984373-1-bcochrane@google.com>
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
In-Reply-To: <20261103042210.2984373-1-bcochrane@google.com>

On 11/02, Bryan Cochrane wrote:
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
> path.
> 
> In bnxt_fw_reset() only the error path that closes the device after
> bnxt_get_registered_vfs() fails needs RTNL: drop the instance lock,
> take RTNL and the instance lock, then clear BNXT_STATE_IN_FW_RESET and
> close. The normal reset flow, which may run on many VFs at the same
> time, keeps running without RTNL. BNXT_STATE_IN_FW_RESET stays set
> across the lock switch, so a concurrent close marks the reset aborted
> as it does today and a concurrent recovery request backs off.
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
> ---
> v2:
>  - Keep bnxt_lock_sp() in bnxt_fw_reset() and take RTNL only on the
>    bnxt_get_registered_vfs() error path, so that the normal FW reset
>    flow does not add RTNL contention when many VFs recover at the same
>    time (Michael Chan).
>  - Dropped Stanislav's Acked-by because of the change above.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
