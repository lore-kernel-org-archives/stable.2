Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA320E023
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306494; cv=none; b=LGKKEY+FD3ktXcrI7bOaQVHcezgHOvbHihaNce7ZYujxY9dEXiu+i0fvkGyiXuoXoFwSH8evypdHq9Jpzf7H1VM1xlr6sIj6vzazBirHs3g3S1Vc8ORDx7Zt7EAAllTVPhEzs5uGDCFIepfbBQmOwT0OC0BTrD/UMwcGI8U4NIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306494; c=relaxed/simple;
	bh=h36t8Aak3xjosKV7ApMoYWbxB2QuJwp89eihxX+6udg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnpoiVRP0uU7ZZ7Y8yXHpWE/oDa88CxEIqQH8FIm2Kli2pP2veZvzTLYbQdbXEx3zemMStck/ar3x3+ABj+TqUCsrrLk1Hv8ctlMPYvAQcgTFEg7xZcyOLQb0ffElxyg7swWAqlcn22hETBwkfNEtTtIzJtFjjUG1VS4hRaWCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf5/H9QX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf5/H9QX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44401F008A0
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791306492;
	bh=F2pbNHA6Cquvp7JKUXcGKjJph/y7K4Neid4Wj2Yqaws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kf5/H9QXpa0VAotc8ZTuspgXQtiSldT8y4m2lJtqRO6x+U9PDuar2Cx910X7kdngD
	 smWVJr2Ytl+xia7zGBIopWDyQQSS1wxaxVJnzrt4eZnzLY/K8n+qbyqjMrm80fLo3m
	 rhvFWd5flSqRs6Dr2opAvLUakPmmE5Vm5rpw/YQI1umTbAYl3RDz4jP53YoAj7AKtj
	 SaX9OQN8cJJ9OuA3qED5mhwr7FoPkcYjs94DGkQdG7kyfgSonE2aYm00LMu9hsBMsU
	 k0w5tipwPv2CAQzInIxKmT9Jdob4suucZN1vMtawndX1cL8e4QxksiGIbcDNr0Mi6u
	 Jf95opbjqUQ/A==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a1981228f8so6984191fa.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 10:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByS3H2qtoZfehCNJ+jzS8l/fBI1MHSCpyBNMhG/JVdejkDf+4NAYRE9K8G4yKAe0yakfMdoY7g=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6Eb6x8IgXwHJeLNE+5QgolxEjj7ozvVldOMvEX4V7v15AZtOW
	5mx6/4/XW/sU59lV3+aqGPF7rfVlNshuOhDY8j4n2rtSOtmdBz1BUkLqbSDWHYKC1I7Lg8GQCtF
	EIZMSQQT2Ur7n+EBcYyfBhB1efVdFe+8=
X-Received: by 2002:a2e:bc1e:0:b0:3a9:7160:e83e with SMTP id
 38308e7fff4ca-3a99ad25f3amr5707721fa.8.1791306491341; Tue, 06 Oct 2026
 10:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
 <a6193df2-98f3-409f-b73f-5b91835a0107@kernel.org>
In-Reply-To: <a6193df2-98f3-409f-b73f-5b91835a0107@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 6 Oct 2026 19:07:55 +0200
X-Gmail-Original-Message-ID: <CAL4WiirwF6bZwocErCthJ+TUu7wipRfSibRBoKWjjkA2nVSrqQ@mail.gmail.com>
X-Gm-Features: AclHuK94qiZU0AD2VKryl24P5rKTJxKe7JjW3M-u_EQacUnswxhPW-YFOySeCss
Message-ID: <CAL4WiirwF6bZwocErCthJ+TUu7wipRfSibRBoKWjjkA2nVSrqQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, 
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	nic_swsd@realtek.com, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 6 oct. 2026 =C3=A0 18:27, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :
>
>
>
> On 10/6/26 13:45, Jan =C4=8Cerm=C3=A1k wrote:
> > Hi,
> >
> > the Home Assistant OS recently shipped kernel update from 6.18.39 to
> > 6.18.52 which was followed by a bunch of community reports about fatal
> > network breakages [1] which had one thing in common - r8169 driver and
> > configured VLANs. This manifested as network stall early in the setup
> > of the system with dmesg events like this:
> >
> >> r8169 0000:03:00.0 enp3s0: NETDEV WATCHDOG: CPU: 7: transmit queue 0 t=
imed out 6125 ms
> >> r8169 0000:03:00.0 enp3s0: rtl_rxtx_empty_cond =3D=3D 0 (loop: 42, del=
ay: 100).
> >
> > As there was no change in the r8169 driver itself, I focused on the
> > vlan subsystem, where AI pointed me shortly to this suspect commit in
> > the range: 1517d1996b5236fe69eccd9d253f725e06996eb1 ("vlan: fix
> > skb_under_panic and races when toggling HW VLAN offload"), added in
> > 6.18.51. I'm not referring to the mainline counterpart below for
> > regzbot (447cbe95ebb9) as I can't confirm whether it triggers the bug
> > there as well. FWIW there was another issue [2] with a similar
> > combination recently in the regressions ML but that one seems
> > unrelated, as disabling EEE fixed that issue, and it doesn't fix it
> > here.
> >
> > I don't have the hardware myself, I asked for testing with this commit
> > reverted, which confirmed that this change indeed started to cause
> > trouble. However, it's obvious that the change itself is not bad, as
> > it fixes another issue and the regression is scoped to very specific
> > hardware/setup combo.
> >
> > Besides the revert, following workarounds were reported to fix the
> > issue as well:
> > - Disabling TX checksum offload with `ethtool.feature-tx off` in
> > NetworkManager for the connection (HAOS doesn't have ethtool binary,
> > hence this option instead of direct ethtool command)
> > - Enabling REORDER_HDR with `ip link set enp1s0.100 type vlan reorder_h=
dr on`
> >
> > Clearly, this needs rather esoteric setup to trigger the bug - I guess
> > most systems set the REORDER_HDR flag by default, however, due to some
> > legacy in the DBus interface that HAOS stack uses to configure the
> > network [3], it was disabled. Anyway, I think that disabling it should
> > not lead to driver breakage as we're seeing.
> >
> > So far it appears that this only affects RTL8168h/8111h, XID 541 -
> > there isn't any report of another chip/XID combination yet.
> > Unfortunately, as I said above, I don't have the hardware available
> > for testing but I believe I'll find some community members who'll be
> > willing to test a proposed fix for the issue if needed.
> >
> > [1] https://github.com/home-assistant/operating-system/issues/5019
> > [2] https://lore.kernel.org/regressions/353419280.954808.1790290283530@=
mail.yahoo.com/
> > [3] https://github.com/home-assistant/supervisor/issues/7248
> >
> > #regzbot introduced: 1517d1996b5236fe69eccd9d253f725e06996eb1
> > #regzbot link: https://github.com/home-assistant/operating-system/issue=
s/5019
> >
> > Cheers,
> > Jan
>
> Ok this NIC can not perform tx csum offloads with vlans.
>
> opts[1] only takes TD1_IPv4_CS and TCPHO (Transport Header Offset).
>
> There is no IP header offset field in the descriptor. The MAC assumes
> the IP header starts immediately at byte 14.
>
> So we need to change vlan_dev_hard_header() to take into account
> vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)
>
> Can you test the following patch?
>
> Thanks!
>
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index
> cb8f3cdbf1f732c55a8a3d69ab5445988c953205..3a518ff064465e8ab978c66a28bf7df=
579931256
> 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -54,7 +54,9 @@ static int vlan_dev_hard_header(struct sk_buff *skb,
> struct net_device *dev,
>          u16 vlan_tci =3D 0;
>          int rc;
>
> -       if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR)) {
> +       if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR) &&
> +           !vlan_hw_offload_capable(READ_ONCE(vlan->real_dev->features),
> +                                    vlan->vlan_proto)) {
>                  unsigned int hlen =3D READ_ONCE(dev->hard_header_len) +
>                                      READ_ONCE(dev->needed_headroom);

Nope, scratch this. I need to spend more time on a proper fix.
