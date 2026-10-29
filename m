Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292457;
	b=sCIZj4hSSpl3vESNckUxqwWOxEnqFMCLGFduazJO/ZmamdWfgAvBOpL/NOeJSXq4rvJ+
	 OssawsbzRKMgaPJ2YgkYjiEHRbD/pKVGoP0kA7LzjKRuMgLEN45O0ayMq9Bi1x8ywRfyu
	 zp0BmPokel7Q2yPOr8TfFlR9AeZNalZKWIjaRYiJH9idBrgevnSQrHvJSvRBcHVqXjDqz
	 Nv9gunTfRUV5ywUhQpfWM2/kDyWKxJhApuF1nbRB54lrrQipmi2fzxRMqpWwtAEMgkSlF
	 r21eiSxTjUu+sjv7Yep4pSYXEH9R+7vlk4xMokULp2Y6Nk3QWFv3EaN2Z6oKOdh1JXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
	b=vbCL1aVOjk/gqYRGmWAC0Q57JmDFh5k+r8vBoJxrDx6ioVvf/8yq2PsPt4Ms+UoR7mPG
	 xilOTAc2deI0TcR5YqaLKQmPa6qtWnN6P/vOnHv4U+QuRgYeuNXxsq54+oRXFn3PiJ89V
	 wHB39U9wGXIq9TMozeP20/U4ao5NAa5lhIWqw423A+pAUWOw2jk+Ssz8LLOTh/BmJoSpx
	 w271V3Qvb9/Uw8V8CtZUgFSB0IQ33ibB6lQbb5XQzNbdntFmDw3yviXbg6m4YvoG8LFPV
	 jGBr5/isFjQRN+K4AyrggRRMImCRu+38xtizOYxvlVMDq5eMASbtUB/j/XIOZTdNsnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bc3UWHS/";
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B8D606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B8D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bc3UWHS/
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso1020279a12.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793292456; x=1793897256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
        b=bc3UWHS/ITwD0lzOlY9HZfRl+H+UlpoFOjSpInaHqsAGuPpJWyh/FXc6a2K2pSXk8w
         iTkYvSbr/AjS/E3BcXEgQzgON7gmFsF3M/7fJ5AxagKMx184QFcpqSt1l5rJFLI5bDVa
         nHyINJKhvRk+27BZYbVV1Rg05Mo3v4/3Y1XKToRKQPk0nni5CUyd7mn17xcCeW+VdeQE
         hwkgFvVf2k/csc87MnoCKBvEqeDnuXyIJNiPcItywFhxtVKgEgOmuQ5cdtqYVIdrZfbq
         cSZJlAoEu4KsgNSOugcHmITimtX+YJAe1RQqYic4vi3h3gFW/mRHyzkMVSJkS5fgDAA9
         yN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793292456; x=1793897256;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
        b=xzbP6vWA+6Hvem5O/knZrry5kX5L5PifbNFvT8ysMoa1eTYxYpsTIeenH/cd7l0Q1v
         Q40F7k5Z/SYzgZOS9lb2O4zxtENl2knF2oddDopCt3beIcnDcugUwtdfB9EK1wWPtnNN
         K88VNNZkeZxZ07qs4aLXxfkjDOesvVyx5rmsziNYqr257z0OhmfcE7jw8X9YdZg6Hi0V
         5cq4gwerjlzzvRSEupHKyJXZPQI6Vrid8S5aB7sH4Jk17Xb+Fh8GDCNkj/ziQYC66uT9
         ilIiVvvm3SfuvZ+cCmP/f0YmcJpOit6B2mPMuYgr+auRhUuntRx7fyS28crBSqt3DJ9M
         AilQ==
X-Forwarded-Encrypted: i=1; AKwUvBysxkNk+OlwYaVWJLzYba/+nXsgcO5a3yFiinGLLbaeDvXXI2E590R70LgOsSCfuWcediEkkl4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIOWplz1cV5c7Nd3HT85Bpl+YlDQWQxvI6tBK4kbCj0lTkFXou
	BsVm2HiJx9SIcVNYFvdXIuQ2cIftcP8Moz+zyO1K8ibXvKUtNZG/exNH
X-Gm-Gg: AYBFou1FJsT/CXbc2Z2Y7HJGM95lQyRtx7STLXEYFZgexD1AfSsZn1Ntwhwa35oJ+a9
	eqcky2fH88c0rEzHYwHOyUJ3d8res4AdI/q4vtIYDwEOiq/H+0fiuro6PWUuJqceiM/oc4Fa8OO
	mQP8CYvDZ6kVcSVTisjLNVvppmsSDwrklNBYvqc0YeiWqiVD8j98+PkKGpODZBkcyih5ySirA5k
	ZNqUdNuMHs0wBUeqyGfne69wFajVfFHANqdW2GQFMvaUVsy++g5A6abX7dZ2onVYtjGGUN6y9Dw
	kRYC2lxH7p7uRq7qH1PMa+ymqsfPbU1sgWyVZ5vRfwmgzrLWwZEWAk/3pticu3TTdE6cdyBLkku
	pul7pJDr1ylU970eLSyoe72CzvZ59hhiSAEXYmg8Gj0AuXEdO76KFxdtfe56uPVjiKuSVcjlfmG
	/m1gZ8unyORePtTw2mCFvtFJC8Rjm/4Jxlc56HulH0GVEjoY72QRRlbNnjYsawB1TCq0QXXHzAC
	yHbkp172fbz5HfXgM9EqhFVOWFkMLawBdDknH5DWwVBRDqD79vosWM8DVprQAdKr4t0x0aVX/oq
	d0odUZGMWCBYwuBGVM9PgwYDZZCW9BF+Z3dOi8fvzsCxo2QQlRseyRi9+8bgw4iyXwpmFEcebhi
	lxy51GrjekWxP8l7+Xvr0RU4srXQ7tNRYritvgBtpynNYlwHXOlZRzCXcIbbTFNGd654=
X-Received: by 2002:a17:90b:57c5:b0:3ab:9f89:e1b3 with SMTP id 98e67ed59e1d1-3ae580dded9mr4420716a91.40.1793292455884;
        Thu, 29 Oct 2026 09:47:35 -0700 (PDT)
Received: from ?IPv6:2605:59c1:38c:400:82ee:73ff:fe41:9a02? ([2605:59c1:38c:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm5285959a91.10.2026.10.29.09.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:47:35 -0700 (PDT)
Message-ID: <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Matt Vollrath <tactii@gmail.com>, intel-wired-lan@lists.osuosl.org, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Andre Brait
 <andrebrait@gmail.com>, stable@vger.kernel.org
Date: Thu, 29 Oct 2026 09:47:34 -0700
In-Reply-To: <20261028170239.28606-1-tactii@gmail.com>
References: <20261028170239.28606-1-tactii@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
> When an skb arrives at the driver and the header length exceeds the u8
> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
> are sent to the card. If TSO is enabled, some header lengths will cause
> the card to hang.
>=20
> This was reproduced on an I218-V with an unprivileged Python script.

Can you elaborate on what the script did to trigger this? I am
wondering if it can even get there with a valid frame supported by the
interface since most of these e1000e parts don't support tunnels and
such.

Also did it have separate cases for the CSUM vs the GSO? I would
suspect this is more a CSUM issue than a GSO issue.

> Fix it by disabling GSO and checksum offload when the header length (and
> checksum offset) would exceed the field widths. Compensate for a
> software-inserted VLAN tag.
>=20
> Because of a quirk in the ordering of ndo_features_check, the skb's
> transport_header field may be stale. If the skb carries
> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
> no reliable interface, so don't offload it.
>=20
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently f=
or ICH9 devices only)")

I am pretty sure this Fixes tag is bogus. This is the introduction of
the e1000e driver which was in 2007. The ndo_features_check didn't
exist until 2014 sometime after that if I am not mistaken.

Much of the complexity that enabled frames to build up massive headers
wasn't until much later when the network tunnels and OVS started being
added.

> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/eth=
ernet/intel/e1000e/netdev.c
> index 6f85dab5c55c5..370776657d100 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *n=
etdev,
>  	return 1;
>  }
> =20
> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> +					      struct net_device *netdev,
> +					      netdev_features_t features)
> +{
> +	/* Do not offload packets whose header lengths exceed the u8 fields
> +	 * in the descriptor.
> +	 */
> +	unsigned int hdr_len =3D 0;
> +
> +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +		const struct tcphdr *th =3D (const void *)skb_checksum_start(skb);
> +
> +		hdr_len =3D skb_checksum_start_offset(skb);
> +		if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
> +			hdr_len +=3D __tcp_hdrlen(th);
> +		else
> +			hdr_len +=3D skb->csum_offset;
> +	} else if (skb_is_gso(skb)) {
> +		/* Work around untrustworthy header offsets in this case. */
> +		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
> +	}

Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
the frame must not be TCP/UDP GSO since for those normally the checksum
and offsets should be populated. Have you identified cases where we are
seeing TCP/UDP GSO w/o the checksum being set up?

From what I can tell it looks like the only valid cases for it not to
be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame are
FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
anyway.

> +
> +	if (skb_vlan_tag_present(skb) &&
> +	    !vlan_hw_offload_capable(features, skb->vlan_proto))
> +		hdr_len +=3D VLAN_HLEN;
> +
> +	if (hdr_len > U8_MAX)
> +		features &=3D ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
> +
> +	return features;
> +}
> +
>  static const struct net_device_ops e1000e_netdev_ops =3D {
>  	.ndo_open		=3D e1000e_open,
>  	.ndo_stop		=3D e1000e_close,
> @@ -7374,7 +7406,7 @@ static const struct net_device_ops e1000e_netdev_op=
s =3D {
>  #endif
>  	.ndo_set_features	=3D e1000_set_features,
>  	.ndo_fix_features	=3D e1000_fix_features,
> -	.ndo_features_check	=3D passthru_features_check,
> +	.ndo_features_check	=3D e1000_features_check,
>  	.ndo_hwtstamp_get	=3D e1000e_hwtstamp_get,
>  	.ndo_hwtstamp_set	=3D e1000e_hwtstamp_set,
>  };
>=20
> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
