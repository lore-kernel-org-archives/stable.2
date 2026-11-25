Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605771;
	b=gdXmn/qt8xjnk+GdAg9TvpAAHgOcDX5U1YAp9J3KYHHION9PI5YYT/OauimMXxvk1u7C
	 rMlZWuRgwNqCIe58u9M8Qi8mGmM9ocmjhRLF1gOwcSbZfxT18RA0spft5H/QusQRopr91
	 7bjkjVEaGc1WF3zfqsVBn3Sm4+KhKbgDt5z8Oznbfz/eVfurLiZpb7/5gemX/mrZS1igJ
	 rffHYVMcY9aveXVfA4CNMX2wrGXAyMGStmyHhdDruyCHntHOAVFGvJslSJcFApuFNYdsa
	 /OpBAvvlBgC6m43TvjMrBdge96LdUbwr7bb6bmQcphKk/MZ8fOXMKEe9vnY/YNOgwxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605771;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ykzuj/zaY6gslsjzhbJvcRZzYsnVjN0GyJsjC47/W18=;
	b=NUgRQn1OOC1mQeaf61AGAfIGFysAtCnQyLnmToqOObGk0apEdClXVMYvKWozqse0p0Po
	 V0x7BJd+PdOz8ubgQLY/Urw9RX0HHADkI2yj6zAiY7kXIBgpASoAy3EewUtudNruZOw7I
	 caBgwz70kL6VGN2Dka1Nc6g2x8/3qwHFPU/xu6xZPUXLdD4Hp202q20KcrDuqgntROLid
	 bA9Zav/3yuzqV/kI5PjIaaJXKXXhOiq2YXLr+X2fBPlQRSb17Pm9GQRUUAUE6E44GJM0l
	 gSJKtZzQNShcsujZGfL3VJJ0CUN47czfbkrLZvwnYTBXsRhEF3PWt9nopyHpFhZIVaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqUl1elz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BDE606A31E;
	Wed, 25 Nov 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqUl1elz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC92B1F000CF;
	Wed, 25 Nov 2026 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795605771;
	bh=Ykzuj/zaY6gslsjzhbJvcRZzYsnVjN0GyJsjC47/W18=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aqUl1elz3yTedvagE4ap1hYKrnCKuXMvv2B2OTA9F6VtfGiKNq52APuaqULyb2L9d
	 DT+JIWg2RE4X3/El8P+TEtWW4FlEb9hpoEDNZ2uDdTt9g9SEyDx9wZuP85epKfxiE8
	 xSlGLRLfoGRkazc1SvAc23csHe6kkA96Rcv+gBue4LcHF3XmgJqgc3nGLCvGQzOMeQ
	 ci0Ihaa5zUWgggMPuq1yYv3VApjic7gNVgm3GWtIqmByxRLLlRzWDGwnHwkenYvma3
	 JPQh9MJv7i7SWveyk14fef2oLss5xwpP14pLSQ7SqJ8AT5SRsyJiltFJocOcxDCutw
	 +QdtOIqHxiH5Q==
Subject:
 Re: [PATCH net v2] netdevsim: fix rate node leak during reload and removal
From: netdev-bot+sashiko@kernel.org
To: xietangxin@h-partners.com
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, dlinkin@nvidia.com, vladbu@nvidia.com,
 jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+bbd81e1e2276c534dea1@syzkaller.appspotmail.com,
 gaoxingwang1@huawei.com, huyizhen2@huawei.com, xuanqiang.luo@linux.dev
Date: Wed, 25 Nov 2026 11:22:50 +0000
Message-ID: <179560577028.3135.18386607599971206035@kernel.org>
In-Reply-To: <20261121110858.1337003-1-xietangxin@h-partners.com>
References: <20261121110858.1337003-1-xietangxin@h-partners.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix is incomplete: rate nodes still leak, and the same
  WARNs still fire, when the device has been left in the devlink…

--

netdevsim: fix rate node leak during reload and removal

nsim_dev_reload_destroy() now checks the eswitch mode unconditionally.
Rate nodes created on a zero-VF switchdev device are then destroyed via
nsim_esw_legacy_enable() -> devl_rate_nodes_destroy() on both reload and
removal, which avoids the devlink_free() and
devlink_reload_reinit_sanity_check() WARNs.

Link: https://lore.kernel.org/all/17cc4251-04ae-41a7-a872-fc5cf525b58f@linux.dev/

> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index c6b17b3873271..b483c25dfecdd 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -1700,11 +1700,10 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
>  		return;
>  	debugfs_remove(nsim_dev->take_snapshot);
>  
> -	if (nsim_dev_get_vfs(nsim_dev)) {
> +	if (nsim_dev_get_vfs(nsim_dev))
>  		nsim_bus_dev_set_vfs(nsim_dev->nsim_bus_dev, 0);
> -		if (nsim_esw_mode_is_switchdev(nsim_dev))
> -			nsim_esw_legacy_enable(nsim_dev, NULL);
> -	}
> +	if (nsim_esw_mode_is_switchdev(nsim_dev))
> +		nsim_esw_legacy_enable(nsim_dev, NULL);

[Severity: Medium]
Can rate nodes still leak when the device is in the reload_failed state?

The new unconditional check sits after the early return at the top of
nsim_dev_reload_destroy():

drivers/net/netdevsim/dev.c:nsim_dev_reload_destroy() {
    ...
	if (devlink_is_reload_failed(devlink))
		return;
    ...
}

When reload_failed is set, devl_rate_nodes_destroy() is never reached.

Nothing seems to stop rate nodes from being created while reload_failed
is set. One possible sequence:

1) devlink dev reload runs nsim_dev_reload_down(), which resets
   esw_mode to legacy. nsim_dev_reload_up() then fails, either through
   the fail_reload debugfs knob (returns -EINVAL) or through an error in
   nsim_dev_reload_create(). devlink_reload() then calls:

	devlink_reload_failed_set(devlink, !!err);

2) devlink dev eswitch set ... mode switchdev still succeeds. With zero
   VFs, nsim_esw_switchdev_enable() only does:

	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;

   No devlink command in net/devlink/ checks reload_failed.

3) devlink port function rate add .../n1 also succeeds.
   devlink_nl_rate_new_doit() has no reload_failed check, and
   nsim_rate_node_new() only checks nsim_esw_mode_is_switchdev(). The
   node is added to devlink->rate_list.

4) del_device leads to nsim_drv_remove() -> nsim_dev_reload_destroy(),
   which returns early. nsim_drv_remove() has no other rate cleanup, so
   devlink_free() hits:

	WARN_ON(devlink_rates_check(devlink, NULL, NULL));

   The devlink_rate and nsim_rate_node allocations and their debugfs
   directories are leaked.

If step 4 is a second devlink dev reload instead,
nsim_dev_reload_down() -> nsim_dev_reload_destroy() returns early again,
and the WARN in devlink_reload_reinit_sanity_check() fires.

These are the same two WARNs the commit message describes. The early
return is older than this patch. However, the subject promises to fix the
rate node leak during reload and removal, and this case is still
reachable.

Would it make sense to also destroy the rate nodes before the
reload_failed early return, or in nsim_drv_remove()?

>  
>  	nsim_dev_port_del_all(nsim_dev);
>  	nsim_dev_hwstats_exit(nsim_dev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121110858.1337003-1-xietangxin%40h-partners.com
