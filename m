Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0C4399E6;
	Mon, 10 Aug 2026 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398617; cv=none; b=VUgnvzpMYYz3osvDKFx5Jo8alX40GMc6sAHbYcf11iqdoovw7RExfsrOM8a+cKsXShJSLRtw8GeWbqr0m71vZyu5tXlh/vlsxX+5UmJJsoHpNE9k1nawIgDtiZo8+sK0wdjZyCjUmZwVwCkO+QkUWvcPOdmKGyxaPgqXk/gMIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398617; c=relaxed/simple;
	bh=sF76N/v66kWc5vaw0RBBnDOYCjX6zF67WRR6uOCTxjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHe33NrpSZGttJl8RvkBtvya/fzdSaPXUznL4ckDvEjJxwsBizOpU4q6EOPATB18pc3vcO/C6G2a6MBCNvVZQun0678nZKhCkm9jl0k2a0RfdJUisJKJp2zI1AqGZF64zLIIrYOP/jZgunHjB/4vvUc7HtbdVdSLU4gHRgCFwdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF80SGco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF80SGco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F511F000E9;
	Mon, 10 Aug 2026 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786398613;
	bh=OgyhPNNC0sL2BEMSErrvHSSaLuzaoX85UGCt7hgMLtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GF80SGcoFkRa0QnAdLhhhjLuIMvAb+kW8/+LWl78LZd+vjvVqns0Sq+unsF4x6D7n
	 l5ejNwhrhLKWt7a8H5Zm12l8qLCWJbdajFiQXXaFEfRZ6azL6srKs6mCWBGN7TUHrx
	 JGOgvTEPU7HapWuLK+UXUbOEmEVdu5nmer1/Pi0I2TFRHcJewxXZbNI1ZW7cn8NEuu
	 iMCidwp4SGZXWV9yCXiw4pZQThbdvmqJG+MilDaXjEvgZn/xBNhYeQ/5oR9t6gkS/n
	 VjQImG5Uh5PkmUi+xSKgO5SihO37uCFBoMb73KzlJ/uOHV/hKTpcb5YpkAf1hvYRgY
	 b+pZPTXx5e2Ag==
From: Jakub Kicinski <kuba@kernel.org>
To: moonafterrain@outlook.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	radu-nicolae.pirea@oss.nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	danisjiang@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] macsec: check offload ops before inserting TX tag
Date: Mon, 10 Aug 2026 14:50:12 -0700
Message-ID: <20260810215012.869528-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805-macsec-fixes-v1-1-634d7679a030@outlook.com>
References: <20260805-macsec-fixes-v1-1-634d7679a030@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
macsec: check offload ops before inserting TX tag

This commit fixes a NULL pointer dereference in macsec_insert_tx_tag().
When phy_detach() clears the lower device's phydev, macsec_get_ops()
returns NULL. This patch adds a check to safely drop the frame instead
of dereferencing the NULL ops pointer.

> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index ee0e2eb7dbc61..86c8009dcfa98 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -3436,6 +3436,11 @@ static struct sk_buff *macsec_insert_tx_tag(struct sk_buff *skb,
>  	int err;
>  
>  	ops = macsec_get_ops(macsec, &ctx);
> +	if (unlikely(!ops)) {
> +		err = -EOPNOTSUPP;
> +		goto cleanup;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch, but does macsec_insert_tx_tag()
still risk a NULL pointer dereference or Use-After-Free?

Further down in macsec_insert_tx_tag(), we re-read the phydev directly from
the real_dev without any synchronization:

drivers/net/macsec.c:macsec_insert_tx_tag() {
    ...
    phydev = macsec->real_dev->phydev;
    ...
    err = ops->mdo_insert_tx_tag(phydev, skb);
    ...
}

If phy_detach() runs concurrently and clears real_dev->phydev, couldn't this
pass a NULL or freed pointer to mdo_insert_tx_tag()?

Additionally, macsec_check_offload() and __macsec_get_ops() appear to perform
multiple unguarded reads of macsec->real_dev->phydev. Since
phy_device_release() frees the device directly rather than via RCU, could these
lockless dereferences lead to memory corruption, as the datapath's
rcu_read_lock_bh() doesn't protect the phy_device?

[Severity: High]
This is a pre-existing issue, but doesn't the RX datapath have a similar
NULL pointer dereference?

Looking at handle_not_macsec(), if phy_detach() clears real_dev->phydev
concurrently, macsec_get_ops() can return NULL.

drivers/net/macsec.c:handle_not_macsec() {
    ...
    ops = macsec_get_ops(macsec, NULL);

    if (ops->rx_uses_md_dst && !is_macsec_md_dst)
        continue;
    ...
}

Since the returned ops pointer is immediately dereferenced without a check,
will this cause a crash when the PHY is detached?

>  	skb_final_len = skb->len - ETH_HLEN + ops->needed_headroom +
>  		ops->needed_tailroom;
>  	if (unlikely(skb_final_len > macsec->real_dev->mtu)) {
-- 
pw-bot: cr
