Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793694823;
	b=ssz3rgU7jzFL3PaTozGZOKX8sIF6dDOs/jrGHoGph8gHSQotpDRzLuyquWIm+//0eM3+
	 nW3o99S6MCHTu1mWOLZWDxnX487H1h+ykUqRlvqiRwLPa2YFYXIZhIeZVJwWa+T1U4+FO
	 KmnwyYwc6LjQIFsas0nREEXXhqyBZCs+najjzcIsmnjYmGbeJ6aH9ikRLZo5ytiuGcOie
	 eRARPSSFiNMsqCQSW4X2AXfpudwdPV6SYwas7jZ1TYk3a79E7XzKln1UFnxrhyF1lBllC
	 dfwI0ZHXrP12yoTPImfs/Dw3Tr4jeGWWK33Cz2Trytk4uCAs5gnLUhVxhmoqlR6WGsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6ja4OL6a6IgpRSB3wFRJnMwYH3hklXOJLyA0pYW5Hj0=;
	b=43VEIf906uC9g4fOGNZitmfPLQV4CDfoiyV2dgKJnHFaPvVNEtmenV/wmnVeaaafg06s
	 DYzNr80dBHfp6802ZddiX8UeCDTKCyNyIPzWVcv40u65uxFpq2EYAowPW5Vrn4+gczrYm
	 e8z7otYOzN1dNK5XHs+Nhk1ZSLZPtm4MBh+Lb8WyHWQtjU/gOHRZeRqUB4YAeffXiSZBp
	 HucSGIpy0ZDQ+iYvBFhgWaAy+8EbRGygBzLvt7gybHaeqbvTysspJAP+1KvmFLbdZzEa2
	 G9IDMidcuZZTlAI5JX6r++isJS4zQe/h65k82eY425QmDLCbEP+al1IK5u0dWVhIydw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TjCInT27;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69370606EE92
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69370606EE92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TjCInT27
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2843111a91.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 00:33:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793694822; cv=none;
        d=google.com; s=arc-20260327;
        b=kD377t6NaKDPhnRsG3y5crn0YkzpWxMNKuFUmKixujc4DBFZr2rAHCLldryYfKGNTj
         Z3rVWC5ulPPwLdJprHNQj20KwxqCe6TeK1PcZJfjyeshN6fkoBc6DR/MLfn1up2wJuvj
         UnvecgW/tIXiacTERUgns09/dWTNMjkoQSLzkm77koALTsqBK8zGipYYIWWP7e1Dzw5G
         9nlDKzT7WoGB/mdALDkU6cMUnyQy0oIdq/Fk1GG+kYz1PBbzW0cJJlfl4fGRcuC4bUpY
         OSjXf3xjphNW+b+/lCEk0mGFD9d4Tu3J4Ey8uSOfkDg+Uu16SExZFy3ka9C+eKJrWPOw
         bvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ja4OL6a6IgpRSB3wFRJnMwYH3hklXOJLyA0pYW5Hj0=;
        fh=sDOxj3Wuw/newd30sFFO331gI6d5mSrBj9mWnmR8zVA=;
        b=W2CsyeUsugaY+bVl1/bKL1JDS7bPyxh215354Xpqpld8QX70Tnbtvs6KMh4+w+rNXG
         vrIRJmEc2c+yEGMq6w5SRFtjqf+mlmnCzKNdYSzF8+blYt1Fxq6lsodVOmfPDwjEOrv1
         gV305GDrnuurWPgJj8vTdpI7Z06bU5gg6zo4qL9KxKhJTT/IkhDld33RRonNsL/hNPji
         nP9wj1/XrxSyFkRjHvcEbxz4ZtC9ypqzFMtvVI39SOc89h0zXec+lwZKy1SgTWPckPsS
         +4blhdrXWsSZEn2ri3D0h3KDfyoQ2h73kuat2VNIM5oLqwpCjV+f7HnqyuW0tPxltsBD
         iu1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793694822; x=1794299622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ja4OL6a6IgpRSB3wFRJnMwYH3hklXOJLyA0pYW5Hj0=;
        b=TjCInT27A4Fu3pmjTejbbjiqDRCLI7ZuuNObZjKH6dC1ospQgOYStx+s/jrTaRLv+L
         me6bnPknqZA7eaU21YEpKHnAPYx93YCdbJj12sFrJyo+/In7CU5qOva/JEwwUkcknbiH
         cSJHWC2hMN7UuvcBC7cauivNL43UfBJ6x+/mqjwGJkVlTm/Fc8zy/oMwq3T1pLVBpbmY
         90oyIjxV6+o1i3PfEZH2pd4urrZv7LQmRsSxujpHCJF5m0wLOHTeJqJoVuPgPA+cpTuq
         L4znlRWqzkLNGwRQtW5GaeffkjyQkH95y+w7pkMkdlt62extNyVsG2HZsO4+PCfxc8wQ
         dULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694822; x=1794299622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ja4OL6a6IgpRSB3wFRJnMwYH3hklXOJLyA0pYW5Hj0=;
        b=Vfv6+HjoCCeQXlV8kBE2WaQA0V/JUOuBLVkGCAKjCNvcrPlcA5tG/7aLB/QwY74IhC
         CtxqDYR7eM7V5HrescYZ5nU4iuYVgSNZde7z1yP1aPOLCkq3TU7QQwPddRNFBMrBS0mF
         g+r6ceCrch7RHZodxumfjyP98x5GvC7uWf+RPeQqq9qenOzsBLr0p4h59TW6xpzXOXRk
         IDe3L7D6I/+6iunTRzW5o33cSlsSjMUqaaUF0c3ZmGjljgs0wdxfNDsM0yMQdBwpVmLU
         2rFP4rFW0dGrgQvWo/iSSTM+97OUytPkQz7N441yUR0aojoWsrM2e6KnFj1MUKPL3jQQ
         6oUQ==
X-Forwarded-Encrypted: i=1; AKwUvByrY7f5ehde7Vm36iAjSzMmdNalBhJEbIfznE4NbHYA+V8GrAEyQIifd6/WfZzIQ5GGTVJudmw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6aM9KJZ/oDLigtF+2hknizYnNM2dkBSqKf15a0cNyTeg2cyBP
	fjbLNEOGsexiwT8S1HFgT+zUIyCe4jCk3n3dRhNZrXxxqtpMwAlk0Lha/vMOyRCMv/96TWsqYxc
	bnMcgjYg7nGAtcyTV3m9yTvUaPF4pWl6I39f5lzYw
X-Gm-Gg: AYBFou34P0BMWmMDtDP4XUbfdQfrdENTUY5pcd2fadNz+cD7U3UDM8MPb1Tc3O8FWFD
	+opkZ8ZTdw0FX5KJ2OdQKGfjsiLaCl7MVvmfuB3DztPmnuaGkAdXlpPfW5dixoKIaUyuE8OhNaW
	FYJZV1tVa7Xx2bBGPuigoR2iBv4WAqZpzAb6dxhzwO1ADn9OZlCAC7W/WG9ddIGoAaWSWqrfbs9
	Jub24wxUfkOLr+t6m7+qnDgtElne4ois6EJ5MucOuQAWaSi1QtFucvqCpgoY3+EUHSxJKGsiGB1
	OP2myJjh9GtqAtEI8fDnGGZK0pzWCuKunWUCjcsS3cxMSBHf+uvrWjE6u9izUR4IYmakdkW69F/
	d4qq97FxJ/SJrnWlFKoDDDjyS3kHcIGEZWfDIOUgWiUwCl2Q4L//wRmkSAA==
X-Received: by 2002:a17:90b:1d0a:b0:3ad:c14:35ce with SMTP id
 98e67ed59e1d1-3ae8987a9c0mr10229886a91.64.1793694821013; Tue, 03 Nov 2026
 00:33:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029211634.2232784-4-hramamurthy@google.com> <179365432199.3131.7124013466514019845@kernel.org>
In-Reply-To: <179365432199.3131.7124013466514019845@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 3 Nov 2026 00:33:28 -0800
X-Gm-Features: AclHuK-z1PpgFlevCrkvk6uC03kVd_C6eMftCJMMzfR9D0PsdeiKufjdiZQrwLA
Message-ID: <CAHwYsiopETRjPVbaX+5wrPNk=aU+NvxSNyO_n+i+nLboFBbx+Q@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] gve: Block invalid ring sizes when device
 options are 0
To: netdev-bot+sashiko@kernel.org
Cc: hramamurthy@google.com, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, jordanrhee@google.com, willemb@google.com, 
	przemyslaw.kitszel@intel.com, nktgrg@google.com, maolson@google.com, 
	jacob.e.keller@intel.com, pkaligineedi@google.com, yangchun@google.com, 
	patricion@google.com, awogbemila@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 1:18=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] In gve_parse_device_option()
>   (drivers/net/ethernet/google/gve/gve_adminq.c:194-197), the new=E2=80=
=A6
>
> Pre-existing issues:
> - [Low] The MODIFY_RING option is accepted whenever option_length >=3D 8.
>
> --
>
> gve: Block invalid ring sizes when device options are 0
>
> Older devices report the minimum ring sizes in the MODIFY_RING device
> option as 0. This let userspace shrink the rings far enough to hit a NULL
> pointer dereference in gve_tx_alloc_rings_dqo(). With this patch,
> gve_parse_device_option() sets default_min_ring_size when either reported
> minimum is 0, so the driver's default minimums are used instead.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 8b215fca9c1b6..2c848f0c23dc2 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -191,7 +191,9 @@ void gve_parse_device_option(struct gve_priv *priv,
> >               *dev_op_modify_ring =3D (void *)(option + 1);
> >
> >               /* device has not provided min ring size */
> > -             if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE)
> > +             if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE ||
> > +                 be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) =
=3D=3D 0 ||
> > +                 be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) =
=3D=3D 0)
> >                       priv->device_info.default_min_ring_size =3D true;
>
> [Severity: Low]
> Should the fallback be done per direction here? One shared flag is set
> when either min_rx_ring_size or min_tx_ring_size is 0. After that,
> gve_enable_supported_features() overwrites both minimums:
>
> drivers/net/ethernet/google/gve/gve_adminq.c:gve_enable_supported_feature=
s() {
>     ...
>                 if (info->default_min_ring_size) {
>                         /* If device hasn't provided minimums, use defaul=
t minimums */
>                         info->min_tx_ring_size =3D GVE_DEFAULT_MIN_TX_RIN=
G_SIZE;
>                         info->min_rx_ring_size =3D GVE_DEFAULT_MIN_RX_RIN=
G_SIZE;
>                 } else {
>     ...
> }
>
> Say a device reports min_tx=3D1024 and min_rx=3D0. gve_set_desc_cnt() the=
n
> sets the TX minimum to 256, and gve_validate_req_ring_size() would accept
> a TX ring size below the device's advertised minimum.
>
> Now say the non-zero minimum is below the default, for example min_tx=3D6=
4.
> In that case, sizes the device supports are now rejected. Before this
> patch, the else branch kept the non-zero value.
>
> struct gve_device_option_modify_ring has a separate field for each
> minimum. Would a per-field fallback be closer to the intent? For example:
>
>         info->min_tx_ring_size =3D
>                 be16_to_cpu(dev_op_modify_ring->min_tx_ring_size) ?:
>                 GVE_DEFAULT_MIN_TX_RING_SIZE;
>
> Both values would then only be overridden for the legacy 8-byte option,
> which has neither field.
>
> It's not clear that any firmware reports only one minimum as 0. The
> commit message says older devices report both minimums as 0.

As my reply in v3, the gvnic device either reports both minimums or
both as zero.
>
> [Severity: Low]
> This is a pre-existing issue, but can these reads go past the end of the
> option payload? The length check at the top of this case only requires
> the legacy 8-byte size:
>
>         case GVE_DEV_OPT_ID_MODIFY_RING:
>                 if (option_length < GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
>
> min_rx_ring_size sits at payload offset 8 and min_tx_ring_size at offset
> 10. An option_length of 9, 10 or 11 passes this check. The new condition
> then reads one or both fields partly or wholly beyond the declared option
> length. That is either the next option's header, or memory past the
> descriptor's total_length if this is the last option.
> gve_get_next_option() only checks the option's declared length.
>
> The else branch of gve_enable_supported_features() already over-reads in
> the same way. The new check adds another read at parse time, and that
> read runs even when GVE_SUP_MODIFY_RING_MASK isn't set.
>
> Would it help to require option_length >=3D sizeof(**dev_op_modify_ring)
> before reading either minimum? Triggering this needs a malformed device
> response.

As my reply in v3, the gvnic device will always return either 8 or 12
for the option_length.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029211634.2232784-1-hramamurthy%40google.com

Regards,
Pin-yen
