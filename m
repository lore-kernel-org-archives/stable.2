Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7F39E9CB;
	Wed, 10 Jun 2026 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078429; cv=none; b=qAkFxWzz01KjMPX5T6zaV88Km/4fhjQbsbGts7ooHpNvpz4h3+XxtnSl34zo/eOPOwZ37+iRrPQZHjCoZ8nHgjKeEOeURjOZ06Z3f3rJ4jLRU1Etf2sxeK1XQ61jqJ6u3kYquSCQh/U/nMd9wobIDqjZKNeIhIZLjIZ2mcnvPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078429; c=relaxed/simple;
	bh=UFE+ldR7lcXNh3SHD18rE+16XwFTkitXv7hvr/QWd50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kYPelQFYfSoBOIrEVVu7NA7PaFqeKgF12Kp3BPt3C1cAorHniMzlUyf4LL6Bk30cVMC6nMxbdc5FLMiazhVNGRY34jeOeOU4M/P38mnxOifBQyeTKVIU737yJ8HJR+2DHekvDo6woXXHLYeLyjuHFViA7L0M8DzMBfphNdZtiNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mrRbiJ3J; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mrRbiJ3J"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65A7o1uB5976202, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781077801; bh=7v47yqvVpZTp5S18TprUYuBRl8n7DAHP9QsHUvLllDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mrRbiJ3Ja9ennWwONqzm/oUr0n7DGTAC3wx8+66r7a5Pc5foxUZXrBUGcImi27/35
	 jYuVB3Z3jeBhkcc5YotMXnAUl0mZe1xv1Wt31RAwy03uEK8lQv0RyxWF/mLpz8afyg
	 LpRU6ZhHHH75MknYKd+h4PXI2ok3bIxw+Sowv8b1tZtjEMjQwyKtD6WOANUBaK1nSA
	 RiHIJzvOfsmunbSECiB6N1CeMsyQ5pdOw83sJKommvwpLadkXd0jW9Nfl15FbBPTv0
	 nzN7lPqMYLPkW7Jt7UgL6mzVZIGtOXNx7ph3rsdN52leBx9MGltu3o1JADNyrLlxtN
	 ZB0MNcvpsg/9g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65A7o1uB5976202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jun 2026 15:50:01 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Jun 2026 15:50:01 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Wed, 10 Jun 2026 15:50:01 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: David Laight <david.laight.linux@gmail.com>
CC: Simon Horman <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>, Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net v2] rtase: Workaround for IP fragmented UDP packet
 hardware bug
Thread-Topic: [PATCH net v2] rtase: Workaround for IP fragmented UDP packet
 hardware bug
Thread-Index: AQHc9ArcvLfvYqn0fkOKy9pKm3m4Q7Y0hZ8AgAEzauD///PvAIABntKg
Date: Wed, 10 Jun 2026 07:50:00 +0000
Message-ID: <d662f59d9be04d9897fbd5b9b2ab3d48@realtek.com>
References: <20260604101356.15611-1-justinlai0215@realtek.com>
	<20260608190627.182292-2-horms@kernel.org>
	<1340406ab190498ab857ad9017529722@realtek.com>
 <20260609134334.3225b076@pumpkin>
In-Reply-To: <20260609134334.3225b076@pumpkin>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

David Laight <david.laight.linux@gmail.com> wrote:
>=20
> On Tue, 9 Jun 2026 08:20:10 +0000
> Justin Lai <justinlai0215@realtek.com> wrote:
>=20
> > Simon Horman <horms@kernel.org> wrote:
> > >
> > > From: 'Simon Horman' <horms@kernel.org>
> > >
> > > This is an AI-generated review of your patch. The human sending this
> > > email has considered the AI review valid, or at least plausible.
> > > Full review at: https://sashiko.dev
> > > ---
> > > rtase: Workaround for IP fragmented UDP packet hardware bug
> > >
> > > The hardware parser incorrectly interprets 319/320 in a short IP
> > > fragmented UDP packet payload as standard PTP destination ports and
> > > treats the fragment as a PTP packet for further parsing. Pad these
> > > packets so the transport data reaches RTASE_MIN_PAD_LEN before
> > > transmitting to avoid triggering the hardware issue.
> > >
> > > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > index ef13109c49cff..b686b84e15fe2 100644
> > > > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > >
> > > [ ... ]
> > >
> > > > @@ -1247,6 +1248,52 @@ static u32 rtase_tx_csum(struct sk_buff
> > > > *skb,
> > > const struct net_device *dev)
> > > >       return csum_cmd;
> > > >  }
> > > >
> > > > +static bool rtase_skb_is_udp(struct sk_buff *skb) {
> > > > +     int no =3D skb_network_offset(skb);
> > > > +     struct ipv6hdr *i6h, _i6h;
> > > > +     struct iphdr *ih, _ih;
> > > > +
> > > > +     switch (vlan_get_protocol(skb)) {
> > > > +     case htons(ETH_P_IP):
> > > > +             ih =3D skb_header_pointer(skb, no, sizeof(_ih), &_ih)=
;
> > > > +             return ih && ih->protocol =3D=3D IPPROTO_UDP;
> > > > +     case htons(ETH_P_IPV6):
> > > > +             i6h =3D skb_header_pointer(skb, no, sizeof(_i6h), &_i=
6h);
> > > > +             return i6h && i6h->nexthdr =3D=3D IPPROTO_UDP;
> > >
> > > [Severity: High]
> > > Does this check fail to traverse IPv6 extension headers?
> > >
> > > If an IPv6 packet contains extension headers, such as an IPv6
> > > fragment (IPPROTO_FRAGMENT), the nexthdr field will contain the
> > > extension header's protocol number instead of UDP.
> > >
> > > Doesn't this bypass the workaround for the exact fragmented packets
> > > it is intended to fix?
> > >
> > Thanks for the review.
> >
> > Unlike IPv4, IPv6 does not require extension header parsing for this
> > workaround. The hardware only treats IPv6 packets without extension
> > headers as PTP packets for further parsing.
> >
> > Therefore, IPv6 packets carrying extension headers, including
> > fragments, do not enter this parsing path and are not affected by the
> > hardware issue addressed by this workaround.
> >
> > Skipping such packets is intentional.
>=20
> I thought you said that the problem only arose with packets that are
> fragmented by IPv[46], in particular short final fragments.
> If your hardware checks for extension headers then doesn't that mean that=
 you
> never have a problem with IPv6 packets.
>=20
> -- David
>=20
Thanks for the review.

To clarify, the issue is not specific to fragmentation.

The hardware performs additional parsing on packets identified as
PTP. The issue is triggered when the packet is shorter than expected,
i.e. UDP header and payload < 47, and the parser attempts to access
data beyond what is present in the packet.

For IPv6, the hardware only enters this parsing path when the IPv6
Next Header field directly indicates UDP. Therefore, packets carrying
IPv6 extension headers never reach the affected parser, so traversing
extension headers is not required for this workaround.

I'll update the commit message in the next version to make this
behavior clearer.

Thanks,
Justin
> ...
