Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C53A48F6;
	Fri,  5 Jun 2026 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687587; cv=none; b=vBNpfOhytxNU1Uzpjd5CAQV59YF19BOLdL0eZ+dBKy9y7oiAuPuUCXYAh/n9CYtLhh26aCc6Af2a1Bz0pcpiEAvo7u7D4+x3hJwXkUUeJwBXfSLixLu3FBo9V9SnwzhdG571dtqnHrIxVDnBDVNYpuo1sQw1dPIZWIZ9srNG0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687587; c=relaxed/simple;
	bh=HfJkDa57jybui0vuoTt7yhA0z+LitAmFSOiu3rAwRv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W67xjDRj+7wgPgbDDW4+yezibHyyQqMT928Fo30apP3OEGkPXBWdgMs+6E9bRdYJyDAkuJ4iy2C49zH57e74+KoMt9kfIyxWt9wTy3yPkY753LtqwAETBJMDGKyH5qQU77rppfrmNO4OuZ9p/8yGO+WxqdiSGjEeUdNZnY+kghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=RCwLrvIz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOBUBTLx; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="RCwLrvIz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOBUBTLx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D72DA1400147;
	Fri,  5 Jun 2026 15:26:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 15:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780687579;
	 x=1780773979; bh=yNwqrh+OYmCtybS2nQNRCR8l0aa0V6Qbo/uTwuqkPUM=; b=
	RCwLrvIztI7ZnC8ChfwnOBunaaFGn9he6fyC8xbAGKnQQ+azTYen9AaxJxcqXEto
	Znx2dfjR2QRj2VLUjLq4GBEWKxnTySkewNKNtCz/sKqnkH3it3B2sXdaz+L7bYw1
	ZvJoAWDug5B4IhDgW1g9tdVI57PHAMvkkIAF0r1K3lBgUetEKduh5BktpYiVqMA9
	ICEi5p3LgCcHH7zVa0JCcEv7z2aWaB1UEpkxOjl9tR8yjkP7S0CBVQp5J07z0+jU
	h6ggC76aiMnlZTJRtRH1Ufs6zLUuwzYV++P3EtzPmVcupdIonCSxKAYcutnYhbP9
	wBsA0uknKu82Lw/N9MsqWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780687579; x=
	1780773979; bh=yNwqrh+OYmCtybS2nQNRCR8l0aa0V6Qbo/uTwuqkPUM=; b=M
	OBUBTLxlV4apBjIZvz9xQkQyJa3KI7L16mi+u6WGas/YZrKmhDZrgwJ3IErq9HqO
	UAnQMVfdCG7bA5C8OQ6AXF6rjc+Q8+TY+gy8fwVCfZTgWo9cAoid4qr4s+x+otGS
	NswDlVExPhgvco+jHGng7PqzCGf35TvpfgtJOyVuQaD5QSW0CNXo9xoiPsaJ7L/M
	Yx8gU4gIEVxtNQMIlC9Z3W8966z9dzcmqk4SokeBz7QUlqkCMDl9kuw4Fp97tGb9
	Lv3f1A7dx4VMC3TEWWfwaQJT3EnaaA5DxcBgn+04GdtfRS+HxJRxhhn4JMYSIsLI
	fYAEWKU57RGI96DW1wmJg==
X-ME-Sender: <xms:2yIjaoQcl_VggIN5dN8u057gP3RNmJzvFz-b9vw8bHlZSKVyQcDbnw>
    <xme:2yIjak_XcOYceqRnGnSPyovCiXzYzd5-VLfZM0TrZ_ggUCvpDE3-xQjmfTRRADmp3
    kGTFcgCgvHSJ3AUAE4i9xsA6RZgxsy4VE5TKZ0CxSU8UL5zofBg-w>
X-ME-Received: <xmr:2yIjaogRgjvy5q2v0A2JwUATYYRiQSSVWA31VOGUd4Gh6K14WYdwYA4BfYU>
X-ME-Proxy-Cause: dmFkZTGjBeY6u5SIxs1YzppehSFeRsay+GdRwvPCEn4/vc0eUxFpfKqKZFqwYAyqaC1o+B
    GPb4TZpXph0aUskl28CEQbt0C/tEN7ctmO67URz4PavcC29/pQrsc4Sbc47wrz+B4awc+i
    QHUFQpaNUEErs6ahXT6Dyp0rNMukFxC5hoZDKgU30qHrbzFLnDE6+Uw8575a/A5MHOBrfx
    7cIL3hoXX8S0PblnWrHLxGTBwbxnnDRALFQc+F5dwPOpzvPfRUXqxg2K1gG7cmIBe04gQW
    CeMMtNzZR4gbWVI4+7aOn5STIeF51Iv6Bp5BIX4JnTqI+17hReZDSKq8GXOb+CmBcLgSGt
    JXaDY3uP/OyqxpSnN1zL8e/aSfERtNlhLP0tWOLn5Kv27/lirGfXAVvnpTfkxJJzaDzU9F
    hs4aIgfC3rwz9Nay9j0bu8n2j4hJEH7zf1dzMtGxR/ZXgUqr1/lF/+7ODOdM+Xu7hgB1bD
    LI54aiK0J+i3TSBftnd/nKz/oHOvsFe4pVXZZ9MzfhrVvTJUw8J2CYWvUfVMiRzGrcyUmQ
    diXwHeql5zIhn0HCqs8jYAhPl67UPmha1TdRZ2dMzCRpLP3setnrIgzZLK5kDvGYzotKBO
    LJw/gZsTN3L/9kCMZKx15btlkKtMFCXkeFaBZskJcIyyrC03HrmvGwW+39zQ
X-ME-Proxy: <xmx:2yIjalbg0hPx5bnt6P8jFcNWqXCg7b4V8oag_Gl8s-9wGyLhrDtpUA>
    <xmx:2yIjat8FTXyYvROMNU9ixfmas1GbX0rFStpAEYYYIOwI1CHtP950wQ>
    <xmx:2yIjanNwMDKdjqRI_lzvvPG6xtsuv6_eKG3lhzj2P0Ly-J1i1ChXuQ>
    <xmx:2yIjaqEEqnJZuh2HAz_EXMQCjnOvbJv5q9G7CnL-IiuqbNr1P-7D7Q>
    <xmx:2yIjatjtdD_RCd69jVCi5pI0n2VY0AsgwBgp9U0SRu1GmSfZ6Hb7G2qG>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 15:26:18 -0400 (EDT)
Date: Fri, 5 Jun 2026 13:26:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Shay Drory
 <shayd@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio: prevent infinite loop in
 vfio_mig_get_next_state() on blocked arc
Message-ID: <20260605132615.50a26aae@shazbot.org>
In-Reply-To: <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jun 2026 16:58:48 +0800
Junrui Luo <moonafterrain@outlook.com> wrote:

> vfio_mig_get_next_state() walks vfio_from_fsm_table[] one step at a time,
> looping to skip optional states the device does not support until
> *next_fsm is supported. A blocked transition is encoded as
> VFIO_DEVICE_STATE_ERROR, which the trailing return reports as -EINVAL.
> 
> The skip loop does not account for the ERROR sentinel.
> state_flags_table[ERROR] is ~0U and vfio_from_fsm_table[ERROR][*] is
> ERROR, so once *next_fsm becomes ERROR the loop condition stays true and
> *next_fsm never changes. The blocked arcs STOP_COPY -> PRE_COPY and
> STOP_COPY -> PRE_COPY_P2P map to ERROR yet pass the support check on a
> precopy-capable device, causing the loop to spin forever while holding
> the driver state mutex. This can result in a soft lockup, and a panic
> with softlockup_panic set.
> 
> Terminate the skip loop on the ERROR sentinel so a blocked transition
> falls through to the existing return and reports -EINVAL.
> 
> Fixes: 4db52602a607 ("vfio: Extend the device migration protocol with PRE_COPY")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/vfio/vfio_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6222376ab6ab..5e0422014523 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -858,7 +858,8 @@ int vfio_mig_get_next_state(struct vfio_device *device,
>  	 * logical state, as per the above comment.
>  	 */
>  	*next_fsm = vfio_from_fsm_table[cur_fsm][new_fsm];
> -	while ((state_flags_table[*next_fsm] & device->migration_flags) !=
> +	while (*next_fsm != VFIO_DEVICE_STATE_ERROR &&
> +	       (state_flags_table[*next_fsm] & device->migration_flags) !=
>  			state_flags_table[*next_fsm])
>  		*next_fsm = vfio_from_fsm_table[*next_fsm][new_fsm];
>  

Applied to vfio next branch for v7.2.  Thanks,

Alex
