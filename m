Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951375;
	b=fbUOdIqfn8VlJLwAJ8cuUIcf8A08SGDaj+QLPbdaJ8kMgAnNHcRmhbelc+JbVwetkiwC
	 UK82OmsHUJJLt9cq6+CTbMZjtXqAwg+tomrajLqNIgAB7VjZbKmBgwJ4yuglg4QTQF5ik
	 zS4OA9MGkWTxFn038ihimZCX/2kx1V7vN3mfQ3/R8uoI231+iqFYtIqER/pOTUkBFbKlE
	 w6Yb+hb5t5UGZBHhAbpb5al8Zm2wyMax5fKHi3RLEjFKziuqk4VQIn3PwJgYjcBF1QfC4
	 5fn2m97MCy2W60cfXUksdWngqp1xz0am2kUdqOxZJNO0gXXCaJ4RKOtI6UC4CfzHVjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951375;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HR6iXTiMIefigNuLIKJC7E9XrAqovAbS86neO6AkdOQ=;
	b=VtQWlEHwQGPyklFhkvCqZ3h2PHCZHabCt5lSvIbYIi/hOultKp4zPa2HCCpE79VZmiH+
	 h+9IPHp8l/wyTzg0IymvTKZUHKiqzfOkbuXeOzoCeVGJ/DjAUs5gGOE2sLJDFdRXwvF3G
	 DLSWBa2AtIHk8iLPPQXeKcEYjP2U3NrFPQunOGCmeKCoEay1aWpwQu7Ux67SsstRCKQpe
	 vftWJ+YoRhMkUgyvyquh3reHh218NEFt+m0YGo3+kfmPEGyZhDKZpWz74Eg+35eskcKOr
	 p1Hetxbx0OUpbL1WEizqsdd5owZf43jyBdDJc5XIG8osRxMUQCCNwZixJt3H/8rfuOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9P0NucO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDEE606A31E;
	Sun, 25 Oct 2026 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9P0NucO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2F71F01825;
	Sun, 25 Oct 2026 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951374;
	bh=HR6iXTiMIefigNuLIKJC7E9XrAqovAbS86neO6AkdOQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M9P0NucO8V+pGJal9Alt/dRnIIxzxFKqfMYUqO+FFaqP3cZV8ebkgpLkNcEA65jCR
	 KIcIFWgeZtXKTy+H+wdqBrvusFlINy+wzpDkQZjsiDSEZk0MhKIpcG0a3DqWHJEOU1
	 eIWC5xikR2YdqQ8ThJt69SICzvmkzQnaGnXH0ijEsy83Lzd8aQRCX/vQdJelAKddye
	 +UMYnkMxY8aM2EAM2Dp7L2L1znw9zhg9B4hF7BYRBy1c/0upDWj8qAhJpzMlDfbz45
	 f95MRZ8xKkrS1ST9q5PXkLigIdmdJrkEArjFWVdbiahkKdFQtooZGOq4CMalUm6vNK
	 6Oz/7KSwy94/Q==
Subject:
 Re: [PATCH] net: atlantic: AQC113: Initialize struct hw_atl2_priv fully
From: netdev-bot+sashiko@kernel.org
To: j@jannau.net
Cc: sukhdeeps@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 25 Oct 2026 18:02:53 +0000
Message-ID: <179295137342.3134.496049235576818261@kernel.org>
In-Reply-To:
 <20261024-net-atlantic-aq113-apple-regression-v1-1-b8305415a8b1@jannau.net>
References:
 <20261024-net-atlantic-aq113-apple-regression-v1-1-b8305415a8b1@jannau.net>
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

- [High] The patch puts back `memset(priv, 0, sizeof(*priv))` in
  hw_atl2_hw_reset() (hw_atl2.c:148).

--

net: atlantic: AQC113: Initialize struct hw_atl2_priv fully

This patch puts back the full memset of struct hw_atl2_priv in
hw_atl2_hw_reset() and still sets l3l4_filters[].l3_index and l4_index
to -1. Its aim is to fix data transmission on AQC113 NICs in Apple
silicon desktop Macs, which broke after commit 6c1ca112a6e4.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 25dd7150aaaf2..5d6e81fa3baee 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> @@ -145,11 +145,7 @@ static int hw_atl2_hw_reset(struct aq_hw_s *self)
>  	if (err)
>  		return err;
>  
> -	memset(&priv->last_stats, 0, sizeof(priv->last_stats));
> -	memset(priv->l3_v4_filters, 0, sizeof(priv->l3_v4_filters));
> -	memset(priv->l3_v6_filters, 0, sizeof(priv->l3_v6_filters));
> -	memset(priv->l4_filters, 0, sizeof(priv->l4_filters));
> -	memset(priv->etype_policy, 0, sizeof(priv->etype_policy));
> +	memset(priv, 0, sizeof(*priv));

[Severity: High]
Doesn't this memset clear the firmware filter caps that
hw_atl2_utils_soft_reset() has just read?

This is the call chain just before the memset:

hw_atl2_hw_reset()
  hw_atl2_utils_soft_reset()
    self->aq_fw_ops->init()   /* aq_a2_fw_init() */
      hw_atl2_utils_get_filter_caps()

hw_atl2_utils_get_filter_caps() is the only place that sets these fields:

	priv->art_base_index = filter_caps.rslv_tbl_base_index * 8;
	priv->art_count = filter_caps.rslv_tbl_count * 8;
	...
	priv->l2_filters_base_index = filter_caps.l2_filters_base_index;
	...

It also sets the etype, vlan, l3_v4, l3_v6 and l4 base indices and
counts.

Nothing reads the caps again after hw_atl2_hw_reset(), so hw_init()
would run with all of them set to zero. This happens on every reset, so
wouldn't it affect every AQC113 and not only the Apple systems?

With the caps zeroed, several paths behave differently.

In hw_atl2_hw_init_new_rx_filters(), art_first_sec and art_last_sec
are both 0. art_mask is then 0 and falls back to 0xFFFF. The driver's
ART records get written starting at index 0, even though the comment
there says:

	/* FW reserves the beginning of ART, thus all driver entries must
	 * start from the offset specified in FW caps.
	 */

hw_atl2_hw_init_rx_path(), hw_atl2_hw_mac_addr_set() and
hw_atl2_hw_multicast_list_set() would start from L2 slot 0 instead of
the slot the firmware assigned.

hw_atl2_hw_fl2_set() calls hw_atl2_filter_tag_get() with
priv->etype_filter_tag_top == 0. Both loops are then empty, so every
ethertype filter install returns -ENOSPC.

hw_atl2_new_fl3l4_find_l3() and hw_atl2_new_fl3l4_find_l4() would see
first == last == 0. Every ethtool ntuple L3/L4 filter install through
hw_atl2_hw_fl3l4_set() would then also fail with -ENOSPC.

There is also a question about the commit message:

> This leaves other fields uninitialized.

Is this accurate? aq_pci_probe() allocates priv with kzalloc(). The
removed memsets already cleared last_stats, the l3/l4 filter arrays and
etype_policy. The only fields they did not touch seem to be the
firmware caps fields, which had just been refreshed, plus
l3l4_filters[].ipv6.

Could the full memset be fixing the Apple systems by turning off the
firmware caps handling that 6c1ca112a6e4 added (the ART section mask
and the firmware L2 slot)? Nothing that was actually uninitialized
seems to be getting initialized.

The patch is tagged for stable. Would it be better to keep the caps?
Possible ways are clearing priv before hw_atl2_utils_soft_reset(),
clearing only up to art_base_index, or saving and restoring the caps.
It might also help to find which firmware value or init step breaks the
Apple hardware.

>  	for (i = 0; i < HW_ATL2_RPF_L3L4_FILTERS; i++) {
>  		priv->l3l4_filters[i].l3_index = -1;
>  		priv->l3l4_filters[i].l4_index = -1;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261024-net-atlantic-aq113-apple-regression-v1-1-b8305415a8b1%40jannau.net
