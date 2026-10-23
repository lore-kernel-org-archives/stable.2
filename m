Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791583;
	b=wsklhQDfQ+TWMuxrueXe9wSFrEXCy0u1qx4BkGd+PR+JeagupGMZDw+Q8UXKlPPxMBAI
	 DaMBjmLIWH4Zl/QoQYYy4pWdtE3lEpK4wLUQ5ZcmDe/Dsnjjh2bbCp3yiZpMVW8Wgh/lp
	 6GTTftyNiFnB7GLIDGeGz0OVSclMJ5XuG7gorHxasnHwHbHGwFxDkaSZ2piw1bSZhR6Ed
	 R8JQePNoMBEtoCzYz0ergG5ox+trYk2GDbuL8jVR5+3KIV4Qp5StLE4kXSsU3h7RLuVmB
	 HaBkfUjjKR7lsFk0WSKZfQNo1pyrDaFrN2/ZfglQNf4Ws7IRIsHZquQjzT8C/tsf1iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791583;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=u/IIYlBMsIERedMVOhy43pG4RdFmWnfvHko5DBgCsoc=;
	b=GvYu5axzFBN2ahXxc4NPg5qifm50uAAnnR2XSvZlV7yOJa/iSA6q0nhsQaPGrK3wn0O+
	 /wEtLpgyYt832algjAyqYIs4PwZVGr8MYYlOyU3CPJvW4wsGrWMVeo0mP3Rk/Xjcgl5kv
	 aYSjq2pZg4w7y3vnU22aU+BBBVmSsA+wM56qeNa6Dl0UGWxKtHD/5M8g1IsjxVJFR+CQZ
	 iduLv77klcPferLui4pS4ydFqwBalnslfr67u7kLcece/K1X46fmNRrQJnnkosWpfTUO4
	 ivR+NKqgXz2J4u2AqlRH/7OIDKFhZ0IEdE/8TfVGjVwcv/3FXMokoPzEJWUDIK0jepw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QquDzyeS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF2606A31A;
	Fri, 23 Oct 2026 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QquDzyeS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8760D1F01825;
	Fri, 23 Oct 2026 21:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792791583;
	bh=u/IIYlBMsIERedMVOhy43pG4RdFmWnfvHko5DBgCsoc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QquDzyeSuy2WViiUA9t6SoylbRUEwn9JFSQBnrSzVSAavfETwtcKrCB1zGub/Y53V
	 9/wPsa7y0IlVuhImom8WYG1hbI+ZGwS8JikYuwI5oEss1qjJVe1RAfct1NyzG56iXa
	 m5FHBUFK5gbNFyNFRzhflJd+6uYZW8t+J6C5WXFBk0YrAucBcYktkjQfQgElSL2u0m
	 vKqs6HsYmMZiar1THKn5DuDhoHw1UNK8pJNdH/mAOyVjrAHHY30p0GxHagwMvjpv2d
	 1/h9qOXgT72qDnJXh2cEbbgqFCyTrQ0KzbwqtZKsGLnJCsWHpEJ5RhwTPFcvdzP027
	 pAwzhr3T+C49g==
Subject: Re: [PATCH net] tls: device: keep tls_sw_fallback() from encrypting
 its own output
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Fri, 23 Oct 2026 21:39:42 +0000
Message-ID: <179279158210.3134.17242732656375934492@kernel.org>
In-Reply-To: <20261019212651.733565-1-rjethwani@purestorage.com>
References: <20261019212651.733565-1-rjethwani@purestorage.com>
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

- [Medium] The patch makes complete_skb() in
  net/tls/tls_device_fallback.c run `nskb->decrypted = 0;` on every skb…

--

tls: device: keep tls_sw_fallback() from encrypting its own output

This patch makes tls_sw_fallback() pass through any skb that lacks the
decrypted bit. It also makes complete_skb() clear the decrypted bit on
the fallback's output. Together these stop a skb from being encrypted a
second time when it is validated at both a bond master and its slave.

> diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
> index 3b7d0ab2bcf1..24fba12febd1 100644
> --- a/net/tls/tls_device_fallback.c
> +++ b/net/tls/tls_device_fallback.c
> @@ -192,6 +192,14 @@ static void complete_skb(struct sk_buff *nskb, struct sk_buff *skb, int headln)
>  	skb->destructor = NULL;
>  	skb->sk = NULL;
>
> +	/* nskb carries ciphertext now, but skb_copy_header() inherited the
> +	 * plaintext original's decrypted bit. Clear it so the bit keeps meaning
> +	 * "still-plaintext, needs an encryptor": a requeued nskb would otherwise
> +	 * be re-validated and encrypted a second time on any re-entry into
> +	 * tls_sw_fallback().
> +	 */
> +	nskb->decrypted = 0;

[Severity: Medium]
Can clearing skb->decrypted here strip PSP encapsulation from fallback
output?

PSP also uses skb->decrypted on transmit, but it means "this skb belongs
to a PSP TX association". The bit is set at enqueue time:

include/net/psp/functions.h:psp_enqueue_set_decrypted() {
	...
	pas = psp_sk_assoc(sk);
	if (pas && pas->tx.spi)
		skb->decrypted = 1;
}

Drivers then use it to decide on PSP TX offload:

include/net/psp/functions.h:psp_skb_get_assoc_rcu() {
	if (!skb->decrypted || !skb->sk)
		return NULL;

	return psp_sk_get_assoc_rcu(skb->sk);
}

mlx5 reaches this through mlx5e_accel_tx_begin()->mlx5e_psp_is_offload(),
and netdevsim through nsim_do_psp(). mlx5e_accel_tx_begin() applies kTLS
and then PSP to the same skb.

Nothing seems to prevent one socket from having both features.
psp_sock_assoc_set_tx() installs psp_validate_xmit without checking for a
TLS ULP. tls_set_device_offload() overwrites sk->sk_validate_xmit_skb
unconditionally. Documentation/networking/psp.rst also describes starting
with TLS and then switching to PSP.

On such a socket the TLS SW fallback can engage in two ways.
tls_device_down() can install tls_validate_xmit_skb_sw() after a port
bounce, or tls_validate_xmit_skb() can fall back after a reroute. The
path is then:

tls_sw_fallback()
  tls_enc_skb()
    complete_skb()
      nskb->decrypted = 0;
mlx5e_accel_tx_begin()
  mlx5e_psp_is_offload()
    psp_skb_get_assoc_rcu() returns NULL

The result is that the segment goes out as plain TCP with no PSP header.

Before this patch, skb_copy_header() carried decrypted=1 over to nskb, so
PSP encapsulation still happened. Once the fallback is active,
retransmits go through it as well. The peer's __psp_sk_rx_policy_check()
would then drop the non-PSP data segments, so the connection could stall.
PSP protection would also be skipped silently on the wire, although the
payload stays TLS-encrypted.

Could this be fixed without clearing skb->decrypted? Some options:

- Use a separate marker for fallback output.
- Skip the bond-master pass in tls_validate_xmit_skb_sw() the same way
  tls_validate_xmit_skb() already does with netif_is_bond_master().
- Keep the bit when the socket has a PSP TX association.

> +
>  	update_chksum(nskb, headln);
>
>  	/* sock_efree means skb must gone through skb_orphan_partial() */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019212651.733565-1-rjethwani%40purestorage.com
