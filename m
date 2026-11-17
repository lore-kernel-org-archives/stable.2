Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911249;
	b=v1BbJ1TdMJoXHQw9bXpwqWVtSjjA6XLNqD76Aaz9Vvk3If+Zoduf/NNuOLQ+EhWFNzUB
	 Ob+XHpL5aIpHZ7G1vY0I2DP5byHIIjL7JttLM2FqwryzU+BnJXzgqDhtNLaGHU+R7sJ5/
	 06wO7LFGYXlMf8jyfqM5WLHGO+jBFtnst33Xvhp2qDmIzzcIYeWnAJVSRVfg/lPgXP15s
	 cxdrBtPuLKMiAXODthqqiJlUWAZzDurC/stxyzccILuK+e0AjzOCNWBhPrRnsCOz5xxwz
	 tSZgBi3KgwV+aObhqEvvZz+I3ezwnnj9IbFI+VD2PwFSJTSxT3ThzXutTiaJ6xghGLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911249;
	h=DMARC-Filter:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Subject:From:To:Cc:In-Reply-To:References:Date:Message-Id:
	 X-Developer-Signature:X-Developer-Key;
	bh=62+gGKMaygG1k5qNn2ymzEQraurA9BoCu7JFO4e5HG4=;
	b=AbxAbe7Vblda25f88yXehIY31xcXeatAZVrIteBCWKr+XuAIzThN0SMbkLycMBidWvPL
	 +iNZAgFywNE/q0ZG+U0EesJ2DRCMVLy9dCTTOIBci5EnHEnrcjy/j+xU+SoA7nhNPOEwj
	 yeTEnBJP3D/V+6F0Sph82yIMdBQB1RR7fp4rs1np5QhkMJAq+otKFMCoe/ESqbnl4EB6a
	 z65RDe+LklvpyzVQeTsOjFLOYzwgY3/AWBQbf6ZQETJk3/qEljSEBQhdkI/yx0uof5LDT
	 f84val3GDSjjcLq/fnHcexO+DMx8OPLomSkprZbNC5G1XE5yfCdFXhRkhgHz6diNG5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E96606A32A;
	Tue, 17 Nov 2026 10:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5E96606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
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
Subject: Re: [PATCH] wifi: ath9k_htc: fix use-after-free of tx cleanup
 timer after failed start
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: =?utf-8?q?Miko=C5=82aj_Pisula?= <mikolaj@pisu.la>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261116162702.15393-1-mikolaj@pisu.la>
References: <20261116162702.15393-1-mikolaj@pisu.la>
Date: Tue, 17 Nov 2026 11:27:17 +0100
Message-Id: <179491123717.208602.16662402283759581420.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=toke@toke.dk;
 h=from:subject:message-id; bh=Fbd3NbIdXqid/5YIFQkP8t9IJV5HYiWRc5N5DPMBTMI=;
 b=owGbwMvMwMHoHCeQ8/XXa3/G02pJDFl/dLg3tgj/ZLq8sf6nvZQsQ05uBF/kZemewB0/jD1Ul
 2kdcTneyWjMwsDIwSArpsgisElY2CCoqKg268JsmEGsTCBTGLg4BWAi3fIcDIs0dAo3ax/3aOHi
 ba/doz7P1/yeoqNnZMpKxi3s0ju2MbhwSunEc/hciGG57V3rdMDWkGuHaYK9g8n0PW/Kv5V1H3g
 SVfbm1bLfS8Rqiid87bXTeFT2Mz8l4Efai50rww3M2erPSiUtUlJdzueWEhSmYn14ataJCm1nXo
 6EMDHWzwuUFtxJMrzzVlP2xWox29l2P9g8SpgrV8nsmW+8RWLfs4oMxpjpp08E3bZevuvL4veOr
 fyhN0Q3a5hOmKxiKZwXcGiZ9/7uvKnvTlvOiv3IcGw7u0lZemBE5L5TedJ+SwI+/k3NuO//U/jd
 AWGnnKQ7R4pqpY9vWFmySF7E5PLZLbNKdm9cr7rAzWEfAA==
X-Developer-Key: i=toke@toke.dk; a=openpgp;
 fpr=DE6162B5616BA9C9CAAC03074A55C497F744F705

> ath9k_htc_start() does not treat a failure of
> ath9k_htc_update_cap_target() as fatal: it logs it at debug level and
> goes on to clear ATH_OP_INVALID, starts HTC, wakes the queues and arms
> priv->tx.cleanup_timer. It then returns the stale error code.
> 
> mac80211 takes the failed drv_start() to mean the interface was not
> opened and never calls ath9k_htc_stop(), which is the only place the
> timer is deleted. The timer re-arms itself, so it is still pending when
> the device is unplugged and ath9k_htc_disconnect_device() frees the
> ieee80211_hw:
> 
>   ODEBUG: free active (active state 0) object: 000000002df157c8 object type: timer_list hint: ath9k_htc_tx_cleanup_timer+0x0/0x770 [ath9k_htc]
>   WARNING: lib/debugobjects.c:629 at debug_print_object+0x1a4/0x3b0, CPU#2: kworker/2:2/110
>   Workqueue: usb_hub_wq hub_event
>   Call Trace:
>    debug_check_no_obj_freed+0x44c/0x5b0
>    __free_frozen_pages+0x724/0xed0
>    device_release+0xcf/0x390
>    kobject_put+0x19e/0x530
>    ath9k_hif_usb_disconnect+0x371/0x540 [ath9k_htc]
>    usb_unbind_interface+0x1a0/0x860
>    device_release_driver_internal+0x35c/0x560
>    bus_remove_device+0x28a/0x540
>    device_del+0x371/0x930
>    usb_disable_device+0x2ad/0x6a0
>    usb_disconnect+0x27f/0x990
>    hub_event+0x1bd5/0x3ad0
> 
> Without debug objects the timer core later finds the freed timer in its
> wheel ("WARNING: kernel/time/timer.c ... !fn" in __run_timers()).
> 
> The device is fully started at that point, so return 0. The interface
> then goes through the normal stop path, which deletes the timer.
> 
> First seen with a TP-Link AR9271 adapter whose interface open failed.
> Reproduced on v7.4-rc2 with a USB proxy that withholds the reply to
> WMI_TARGET_IC_UPDATE_CMDID and then disconnects the device; with this
> change the same sequence produces no report.
> 
> Fixes: 859c3ca1e460 ("ath9k_htc: Add a timer to cleanup WMI events")

The Fixes tag is wrong - this was introduced with the commit that moved the code
(which indeed didn't react to the ret value before):

Fixes: 1057b7503908 ("ath9k_htc: Unify target capability updating")

-Toke

-- 

