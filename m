Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923739;
	b=1o4BesyL1bg2bBXAJF/DL+5YY8n3Q6OCjbiED7/EOHo7E++WcBLCjurjBdMu0UlQKbLR
	 nuVemdDU1VS03kUcyDFOMRmjsAe8t+gypvjRfMG56xSX2ipnTlpe4zNkWG3dsNiwdJtF7
	 tBcIzn9mcM0ssgHUiOwkghc5H9qMoKh9rXR6yHThYKP2SKkgxMn2CWwLIaD40RA4B87HL
	 tmfGnhh5yDHkA8NZ5ePhOlmX5PPVEexVUemtyBx/WRZDYQgDNaODcfPxFJwcfi8YHKNw+
	 Dg7MZVQwi374p6akugqTU7KHcaKEJs9Q8vTP6+hMOLKvWnFzum9tqwyPS1purnLj6cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923739;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=70rfcJx4ppckiFBPTRygMuzYZpbn/QbilZ5teuDYXJQ=;
	b=ITN7v1vWKTU1bODsmR532Hz0uWqPcQcJkF81opWkShSMW/ZZ4egyZh0RCvJk1VbyubJd
	 MfQ1pJZL6OalB7Ak0E2xVlGpDpWHvdXldu8+IZ3aG8TBiEk7lgARTkyge8hKoOV5d075J
	 j7DCXECp7BumreWYWOn+wPSgtOttpii7yuTWe/7YtVr87cwEDyoYIg8ibopAvr3ixaOel
	 Y3GBleiU/eirNQrF3V+UdnrmKz/yc+brinJhy4HiL6COe1dIRAvKixfNvU4L+MiaKMiSc
	 LyBxAkk2TA4Kh0lUCfDfImV+2ITYRxpim+o+qDsW9YHSxbOv1KNHEujND5gQRGyu2Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cq1gMyW3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21816606A323;
	Tue, 17 Nov 2026 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cq1gMyW3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603B81F000C4;
	Tue, 17 Nov 2026 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923739;
	bh=70rfcJx4ppckiFBPTRygMuzYZpbn/QbilZ5teuDYXJQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cq1gMyW3B/17uRd16MqBTJQARqK4AQkyVxzdXhwPf/ADQG95sL+i6Id5F1aGXXHk4
	 vXii/bZkq9eHrmHzFoInhJ4Typ8l9y8WnVLUVl+RQjTWzvTldzgoP3Dmdrjqc+Qrca
	 1dko5XDFSP2kAQjZS7XRj/FLJqs/DZW4RCJpBL4m0qd06cQBbH0cKJafs9wJBbMtiA
	 L85T+F7qVSbmhnF7eCD3Z85y1spfeE5y7hH/T6qhtCJUnLMrIJPkLk0ac9ZQg3AKqr
	 fJe8XEOamTyiFIhzVc6X7PbgMSzltpE+uaI+rIHZ7VjnRLl6pYLJK1g34ON0E7mA8a
	 k4Mp9TFN+3CeQ==
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after hardware unregister
From: netdev-bot+sashiko@kernel.org
To: chenyichong@uniontech.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
 syzbot+8a8482d4c33cc58babb4@syzkaller.appspotmail.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Tue, 17 Nov 2026 13:55:37 +0000
Message-ID: <179492373789.3136.2399679338709401263@kernel.org>
In-Reply-To: <0D7C088B45E7283A+20261113134141.2626113-1-chenyichong@uniontech.com>
References: <0D7C088B45E7283A+20261113134141.2626113-1-chenyichong@uniontech.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes the stale-PIB double free in hwsim_del(), but
  the error unwind in hwsim_add_one()…

--

ieee802154: hwsim: free PIB after hardware unregister

This patch reorders hwsim_del() so that ieee802154_unregister_hw() runs
before the PIB is freed. The current phy->pib is then detached under
pib_lock with rcu_replace_pointer(), and only that object is passed to
kfree_rcu(). This avoids a double free when a scan abort replaces the PIB
during teardown.

Closes: https://lore.kernel.org/all/6af5f575.b350cda4.2b6a63.0000.GAE@google.com/T/

> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index a9bd1555d2dc7..a65ae2afb789b 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -1008,12 +1008,16 @@ static void hwsim_del(struct hwsim_phy *phy)
>  		list_del_rcu(&e->list);
>  		hwsim_free_edge(e);
>  	}
> -	pib = rcu_dereference(phy->pib);
>  	rcu_read_unlock();
>  
> +	ieee802154_unregister_hw(phy->hw);
> +
> +	spin_lock_bh(&phy->pib_lock);
> +	pib = rcu_replace_pointer(phy->pib, NULL,
> +				  lockdep_is_held(&phy->pib_lock));
> +	spin_unlock_bh(&phy->pib_lock);
>  	kfree_rcu(pib, rcu);

[Severity: High]
This fixes hwsim_del(). Does the error unwind in hwsim_add_one() still
have the same stale PIB problem?

hwsim_add_one() keeps the original PIB in a local variable and frees that
pointer directly on failure:

drivers/net/ieee802154/mac802154_hwsim.c:hwsim_add_one() {
    ...
	rcu_assign_pointer(phy->pib, pib);
    ...
	err = ieee802154_register_hw(hw);
	if (err)
		goto err_reg;
    ...
err_subscribe:
	ieee802154_unregister_hw(phy->hw);
err_reg:
	kfree(pib);
err_pib:
	ieee802154_free_hw(phy->hw);
}

After wpan_phy_register() runs inside ieee802154_register_hw(), driver
callbacks can replace phy->pib through hwsim_update_pib(). That function
calls kfree_rcu(pib_old) on the original object. Some of the paths that
get there:

  NL802154_CMD_SET_CHANNEL -> ieee802154_set_channel() -> drv_set_channel()
    -> hwsim_hw_channel() -> hwsim_update_pib()

  interface open -> drv_start() -> set_promiscuous_mode / set_hw_addr_filt

  scan abort inside ieee802154_unregister_hw(), which is the path the
  commit message describes

On the err_subscribe path, ieee802154_unregister_hw() runs first and then
falls through to kfree(pib). This happens when hwsim_probe() calls with
init set and hwsim_subscribe_all_others() fails with -ENOMEM.

The HWSIM_CMD_NEW_RADIO path can also reach err_reg, when
ieee802154_if_add() fails after wpan_phy_register() has succeeded.
wpan_phy_register() drops rtnl before ieee802154_register_hw() takes it
again. A SET_CHANNEL request can run in that window and replace the PIB:

net/mac802154/main.c:ieee802154_register_hw() {
    ...
	rc = wpan_phy_register(local->phy);
	if (rc < 0)
		goto out_mac_wq;

	rtnl_lock();

	dev = ieee802154_if_add(local, "wpan%d", NET_NAME_ENUM,
				NL802154_IFTYPE_NODE,
				cpu_to_le64(0x0000000000000000ULL));
	if (IS_ERR(dev)) {
		rtnl_unlock();
		rc = PTR_ERR(dev);
		goto out_phy;
	}
    ...
}

In both cases, wouldn't kfree(pib) free an object that is already queued
for kfree_rcu()? Wouldn't it also leak the PIB that is currently
installed in phy->pib?

The commit message says the change "avoids freeing a PIB that was already
replaced during teardown". Should the hwsim_add_one() unwind follow the
same sequence that hwsim_del() now uses? That would mean detaching
phy->pib under pib_lock with rcu_replace_pointer() after unregistering
the hardware, and passing the result to kfree_rcu(), rather than calling
kfree() on the saved local pointer.

>  
> -	ieee802154_unregister_hw(phy->hw);
>  	ieee802154_free_hw(phy->hw);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0D7C088B45E7283A%2B20261113134141.2626113-1-chenyichong%40uniontech.com
