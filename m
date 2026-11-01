Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793533742;
	b=CfODO5RZL7DOzkVNbLfaloJZRUUm6tabvKcofB3cSjGJ+S+hcAUk7oVrD4ohFkELtLvp
	 PUaWy7uedrhVYwnWHv8ihOFHa2MIe+bgsyvL0d2ZS5w4APmT3sJR286+fbGtCXY/Y+6fH
	 gNeLTV2QYyJtpu2U5M/hdBj7UwcqM217y/TRNKB9WeV5yKJkzx20WljG8b8uU2OgkO9CH
	 RzcRV3y4oX+US/iQsabPZpNXc/ZOiObBq1APbRaXPF+U99ry/RS+tsIj/bmaQzVQasMP+
	 Tgxb08bUz1cRJMSKhdiR82OPwI0cv12i9vdgLusx3+O9I3Xq+GckGt4uSN7Ys+MsOSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793533742;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uhqQZWYhQfQseqw3TWhQ06TGIfzrnlFvPN/L9zUwqpE=;
	b=y0/8LU4ChWARF+3Lvofwq55U5vmt+apgIneJDGdv8gShuHAFnSkbm9eNzVU8rnHkqJ55
	 iEKW5fyc2tQHR6CZyVLa4rQ5ndS2H03TIOcdejS0x9iaRf9sw71JEqiOi63wTwgkvrMoL
	 bEmLZNOhY4CgnxcImmANJsx05lhqr3osg/FkXcryhPlK9sbW3DJi5NCKUFHmgwglUS3BQ
	 aY5cawQKtlKw5FDaGPGfppzdnHQ4PAM76AWqGElK9G7zPbRPkhq6OWvHNw0PUgxIy4FIC
	 +iRbs2BdjDQFiE91aW6a6wm04+WiMovaMEBqrsTUZiolcpUvqZAwqdcbnMfEyMWMJRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldkaxfbS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FC606A324;
	Sun,  1 Nov 2026 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldkaxfbS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6E21F000C1;
	Sun,  1 Nov 2026 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793533741;
	bh=uhqQZWYhQfQseqw3TWhQ06TGIfzrnlFvPN/L9zUwqpE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ldkaxfbSysz0X0K2rHj+IB3XF9NOWWt/iLkNc8wNpYpF5HYGrfK3hFE/eTf4ztgGM
	 hNaKxknKioNxk/kZMqQKItDTezc9UAFTBbfc/FPXheupCV+pbci/IHAsWWcD9kowau
	 VBddHTzLkS1Ihf/nVpV5cgdbEHqMILE7CCRri6+Gmi5M0cKu0sCblKpsWigrnIrGws
	 FZ91SDb7GLF/WjuXsWJt3gSekZA1ZaErAe3iQDx+vIQozD6pwywuB1lAyWpy3+gBho
	 rl77ZHRQ8gq3nz7oJWmkWSRSURJ2YCc/7PC3uAHPlqbzBHudBUauH0rFLENloB56HE
	 LS4kx6VWblE5w==
Subject:
 Re: [PATCH] seg6: fix OOB read in advance_nextseg when segments_left is 0
From: netdev-bot+sashiko@kernel.org
To: tangbin@cmss.chinamobile.com
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 01 Nov 2026 11:49:00 +0000
Message-ID: <179353374041.3131.16148032694599738830@kernel.org>
In-Reply-To: <20261028113141.2111-1-tangbin@cmss.chinamobile.com>
References: <20261028113141.2111-1-tangbin@cmss.chinamobile.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a bug that the current tree does
  not have.
- [Low] The patch adds a second NULL return to advance_nextseg() in
  net/ipv6/seg6_local.c, for segments_left == 0, with drop reason…

--

seg6: fix OOB read in advance_nextseg when segments_left is 0

This commit adds a segments_left == 0 check to advance_nextseg() in
net/ipv6/seg6_local.c. The check runs before the field is decremented and
used to index srh->segments. The commit message says the End, End.X,
End.T, End.B6.Encap and End.BPF paths can reach advance_nextseg() with
segments_left == 0 and read out of bounds.

> advance_nextseg() decrements srh->segments_left and uses it to index
> srh->segments without checking it is non-zero. seg6_validate_srh() permits
> segments_left == 0, so a packet with SRH segments_left==0 reaching an End*
> action underflows the u8 (255) and reads srh->segments[255] (~4KB out of
> bounds); the read bytes are then used as the new IPv6 destination address
> (info leak) or crash on unmapped memory. The decap path
> (decap_and_validate) already checks segments_left > 0, but the standard
> End/End.X/End.T/End.B6.Encap/End.BPF paths do not. Reject segments_left ==
> 0 before decrementing.

[Severity: Medium]
Can any of these paths actually reach advance_nextseg() with
segments_left == 0?

input_action_end_core(), input_action_end_x_core(), input_action_end_t(),
input_action_end_b6_encap() and input_action_end_bpf() all get the SRH
from get_and_validate_srh(), which asks for IP6_FH_F_SKIP_RH:

net/ipv6/seg6_local.c:get_and_validate_srh() {
	srh = seg6_get_srh(skb, IP6_FH_F_SKIP_RH);
	if (!srh)
		return NULL;
    ...
}

When that flag is set, ipv6_find_hdr() skips any routing header with
segments_left == 0:

net/ipv6/exthdrs_core.c:ipv6_find_hdr() {
    ...
			if (flags && (*flags & IP6_FH_F_SKIP_RH) &&
			    rh->segments_left == 0)
				found = false;
    ...
}

So these callers never get back an SRH with segments_left == 0. Nothing
between the lookup and advance_nextseg() writes segments_left, and the
HMAC check only reads it.

end_flv8986_core() is the only caller that uses seg6_get_srh(skb, 0).
There, seg6_get_srh_pktinfo() maps segments_left == 0 to
SEG6_LOCAL_PKTINFO_SL_ZERO. flv8986_act_tbl only has entries for SL_ONE
and SL_MORE:

static const u8 flv8986_act_tbl[FLV8986_ACT_TBL_SIZE] = {
	/* PSP variant for packet where SRH with SL = 1 */
	tbl_cfg(PSP, SL_ONE, F_PSP),
	/* End for packet where the SRH with SL > 1*/
	tbl_cfg(END, SL_MORE, F_PSP),
};

So SL_ZERO resolves to SEG6_LOCAL_FLV_ACT_UNSPEC, and the packet is
dropped before advance_nextseg() is called.

The commit named in the Fixes: tag, d7a669dd2f8b ("ipv6: sr: add helper
functions for seg6local"), also already rejected segments_left == 0
explicitly in get_and_validate_srh().

Given that, is it accurate to say the standard End* paths "do not" check
segments_left? The SKIP_RH lookup flag appears to do that check.

If no path reaches this code with segments_left == 0, should the patch be
described as hardening, without the Fixes: and Cc: stable tags? As
written, it would likely be backported and triaged as a remotely
triggerable OOB read and info leak.

> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 0c3d1be7f1299..0f72b7fe3ac14 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -310,6 +310,10 @@ static struct ipv6_sr_hdr *advance_nextseg(struct sk_buff *skb,
>  	/* skb_ensure_writable() may change skb pointers; evaluate srh again */
>  	srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
>  
> +	if (srh->segments_left == 0) {
> +		*reason = SKB_DROP_REASON_NOT_SPECIFIED;
> +		return NULL;
> +	}

[Severity: Low]
Should the kernel-doc above advance_nextseg() be updated for this new
NULL return? It still says:

 *  - NULL when the skb cannot be made writable. In this case, the function
 *    sets the drop reason to SKB_DROP_REASON_NOMEM.

The callers follow that contract and turn any NULL into -ENOMEM. For
example, in input_action_end_core():

	srh = advance_nextseg(skb, srh, &reason);
	if (!srh) {
		err = -ENOMEM;
		goto drop;
	}

The same pattern appears in input_action_end_x_core(), in both the END
and PSP cases of end_flv8986_core(), in input_action_end_t() and in
input_action_end_b6_encap(). input_action_end_bpf() returns -ENOMEM
directly.

If this branch ever fired, a malformed SRH would be reported as -ENOMEM
with drop reason SKB_DROP_REASON_NOT_SPECIFIED. As noted above, no
current caller appears able to reach it.

>  	srh->segments_left--;
>  	addr = srh->segments + srh->segments_left;
>  	ipv6_hdr(skb)->daddr = *addr;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028113141.2111-1-tangbin%40cmss.chinamobile.com
