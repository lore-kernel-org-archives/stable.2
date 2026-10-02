Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33553484239;
	Fri,  2 Oct 2026 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940947; cv=none; b=cEr9MT0/6H4vObG/QOiGktCJjK5WZ0zrKasnTGetyKIY5R9xBv8RBtxFXMfcnE12GK69CfKJRKbgvGBiGHg+2MkEvG0eY2HoLLHPONzYaNbLqUeL/AOeJU9XGfXjy3szV9MxtK4BAwbQ/Xt0qrFk2FA3FNdvp/+xlIokOdKCUpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940947; c=relaxed/simple;
	bh=PUbavTRGY63czA1iO4OrHpptUBrJg07DvWMNclWCZvo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RM0Xpu87Kdnt2QLky45VZruuP92sgqRodzAj3dUdhOZy3HWqu5ADDxgLP7LfqPzaL/ALki5mN13+qxjV0+cGtIJMgj/eaADKRO+YXjPik0eRZtDd2LaWU9t/Gok7COwdzgoJWz5JCOArqZXrHPxH3KSa7/GZozXJDa/yVVRcnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eILlAyLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eILlAyLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815011F000FF;
	Fri,  2 Oct 2026 11:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940945;
	bh=ts7Z1MKJgmCXn2Bw/VJetfhT+A0yKe6e7mbNuBIiqFM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eILlAyLlM4U7y5jybQ7kw8Ce08NzRtqRiAwKBxrz/1MPIBXw+hoqYVftUJK3AKjmJ
	 0dVGANpWwTxPY8xETpmhkSQU5cxaG5fycOh3VW78aaV7p7ixA2R2zUCNI+RCZkoA1f
	 5wj+/WuDO/zt+21ztC75Iw8e20DWdCBhtQXDfPJQzzQl59tMXtHxSFFOFj4FcQ+KKz
	 9J0lnBSR057S+4ZcUT4Qa6bF2FhUE4jab0ZEgts2jFU3c3rSIJqH4SBy9M73eBVeZR
	 45JksOQihgExs1MLV4XE9Af5lFF5PaMyJbs8QilJ7eL/a0sLsNvLySyBP2VmolyJOU
	 Hwt8tqmArrIuA==
Subject:
 Re: [PATCH net] macsec: prevent AES-GCM nonce reuse after packet number wrap
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: sd@queasysnail.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 02 Oct 2026 11:35:45 +0000
Message-ID: <179094094507.434549.10343867236114211128@kernel.org>
In-Reply-To: <20260930203333.598733-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260930203333.598733-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The code change is correct.

--

macsec: prevent AES-GCM nonce reuse after packet number wrap

With 32-bit packet numbers, the TX SA wraps next_pn to zero after
allocating 0xffffffff. tx_sa_update_pn() used to advance the counter
past zero, so later frames could reuse PN 1, 2, ... under the same key.
This patch makes tx_sa_update_pn() return early when the stored PN is
zero, so next_pn stays at zero after a wrap.

> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 78a19b1346321..233391acebb0f 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -486,6 +486,9 @@ static pn_t tx_sa_update_pn(struct macsec_tx_sa *tx_sa,
>  	spin_lock_bh(&tx_sa->lock);
>  
>  	pn = tx_sa->next_pn_halves;
> +	if (unlikely(pn.full64 == 0))
> +		goto out;
> +

[Severity: Medium]
The code change looks right. The commit message may describe less than
the patch actually fixes and changes, though. It says:

    Packets already in flight can still be processed after that.
    [ ... ]
    Keep next_pn at zero after wrap so all late packets are dropped.

Is late in-flight packets the only way to hit the nonce reuse? A wrapped
SA can also be reactivated from userspace without a new PN. In
macsec_upd_txsa(), MACSEC_SA_ATTR_PN is optional:

drivers/net/macsec.c:macsec_upd_txsa() {
    ...
	if (tb_sa[MACSEC_SA_ATTR_ACTIVE])
		tx_sa->active = nla_get_u8(tb_sa[MACSEC_SA_ATTR_ACTIVE]);

	was_operational = secy->operational;
	if (assoc_num == tx_sc->encoding_sa)
		secy->operational = tx_sa->active;
    ...
}

macsec_start_xmit() only checks secy->operational. macsec_encrypt()
never checks tx_sa->active, and its only guard is the PN check:

drivers/net/macsec.c:macsec_encrypt() {
    ...
	pn = tx_sa_update_pn(tx_sa, secy);
	if (pn.full64 == 0) {
		macsec_txsa_put(tx_sa);
		kfree_skb(skb);
		return ERR_PTR(-ENOLINK);
	}
    ...
}

Before this patch, the first frame after an UPD_TXSA that only sets
ACTIVE would get PN 0 and be dropped. Every frame after it would go out
with PN 1, 2, 3 ... under the same key and salt, for as long as the SA
stayed in use. That is sustained nonce reuse, not a short race window.
Should the commit message mention this path, especially since the patch
is tagged for stable?

There is also a user-visible behaviour change here. After this patch,
reactivating a wrapped SA without a new PN drops every frame and counts
it in tx_dropped. The goto out also skips __macsec_pn_wrapped(), so
nothing clears tx_sa->active or secy->operational again. The SA and
SecY keep reporting active and operational while all TX is dropped,
until a new PN or SA is installed.

Could the commit message document this as well?

>  	if (secy->xpn)
>  		tx_sa->next_pn++;
>  	else

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930203333.598733-2-Jeremy.Jean%40oss.cyber.gouv.fr
