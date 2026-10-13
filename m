Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3D3822B4;
	Tue, 13 Oct 2026 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878720; cv=none; b=C3JpmjkL2SGxfCvQ+9NX4uZcdRsAP20l+08w/mdsjS5oKO3MjHILKVefXmvBpsP9nYlFvdJne9OTVA0sSkUUCUVjGm+H8KKQ/ibIIQankjFUJ1slqbHzo0HtP1iRZBwFr5D2ZI0E/19MJd/UqiTqR+RsW8+LUpaqBAdJzUtc2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878720; c=relaxed/simple;
	bh=joNvyENe9xeZ777E6zBFc0KzN8ZGZ8enwnURym1z9Hk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u/gv8OW+RRrfxeykiFGMF/H54wW8crN64UVG8eURGSK4kIE/Qpo3MugJ0ucFdP4mVPw4eWmOP4VpVw9QBu6NZOExE69Qu9O2aTS4NpetXv4sP9iTdoC9LT3OeuAvN9a0OCS9TPgTSz5sTfbcxFPpHtVKpLHPS+V5vi6cEgfto/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RQ8mVNZ4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RQ8mVNZ4"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69D84c2sA361824, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791878679; bh=n9dFj47xMLdOEJNEmjJraLFd8FemMFSBfxTHXKF84p4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RQ8mVNZ49HQA7YIR/dKfjRlpjIrkQz1dguTXW5xGCUeaf9yMByOwJAaUyDhkOXB/e
	 dV9ffTxJCh4LLq0A7YDAhUQfAo0AUWCZSvvgulWV0wj7Hg15iG3pWinp5rN+H355uD
	 uJQ0SsfvQkIfuJ8p7nbupwXuOvStpIM5Ckng42xxMNctdkcfnvXEf2vTeU5RFjW7Lg
	 bhAqd9TXKL2pD2LyQKlmtetNkwF7xng5jrkQU3fdHbmiDAppMLNJ/orJHsIyoHi2cB
	 ecB4BDsJQ+xb9tOyfzbZ2lehd9sDuiXCLN6Md7MB1Y3grnwlInUx4LsGb1V2Zxec8+
	 t0kyJp57SNEmA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69D84c2sA361824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Oct 2026 16:04:39 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 16:04:06 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::f36f:a844:4916:93f2%9]) with mapi id
 15.02.2562.049; Tue, 13 Oct 2026 16:04:06 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>, Linmao Li <lilinmao@kylinos.cn>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chih Kai Hsu
	<hsu.chih.kai@realtek.com>, nic_swsd <nic_swsd@realtek.com>, Birger Koblitz
	<mail@birger-koblitz.de>, Xiangqian Zhang <zhangxiangqian@kylinos.cn>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v2] r8152: Use BMSR to detect the link state
Thread-Topic: [PATCH net v2] r8152: Use BMSR to detect the link state
Thread-Index: AQHdVLexra3FlE5swkqMdmzmTHCGJ7bwLnWg///8UICABCHSAIAAVXKAgAaA7TA=
Date: Tue, 13 Oct 2026 08:04:06 +0000
Message-ID: <16d9caec96e8449d88ac456e8512f08b@realtek.com>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>
 <7a8d21bd-3484-4120-abd6-f7290f919b7d@lunn.ch>
 <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>
 <591ca604-b296-4469-94b5-957d9ba45ae4@lunn.ch>
In-Reply-To: <591ca604-b296-4469-94b5-957d9ba45ae4@lunn.ch>
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

Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, October 9, 2026 8:22 PM
> To: Linmao Li <lilinmao@kylinos.cn>
> Cc: Hayes Wang <hayeswang@realtek.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Chih Kai Hsu <hsu.chih.kai@realtek.com>;
> nic_swsd <nic_swsd@realtek.com>; Birger Koblitz <mail@birger-koblitz.de>;
> Xiangqian Zhang <zhangxiangqian@kylinos.cn>; linux-usb@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; stable@vger.kernel.=
org
> Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
>=20
>=20
> External mail : This email originated from outside the organization. Do n=
ot
> reply, click links, or open attachments unless you recognize the sender a=
nd
> know the content is safe.
>=20
>=20
>=20
> > Hi Hayes, Andrew,
> >
> > Thanks. Since the newer ICs notify only when the link status changes,
> > the driver cannot rely on another link up notification after the link
> > has settled, so v2 can leave the carrier off when the first read
> > returns the latched link down.
> >
> > Before sending v3, which approach would you prefer? Both fixed the
> > problem in my tests on an RTL8153B with v7.3-rc6:
> >
> > a) Keep carrier detection on PLA_PHYSTATUS and read BMSR once before
> >    carrier on, only to clear the latch. This is the option I asked
> >    about on v1.
> >
> > b) Detect carrier from BMSR and read it again when the first read
> >    returns link down, as genphy_update_link() does in interrupt mode.
> >
> > Neither depends on another notification. Neither reports a short link
> > drop that recovers before the link work runs: with a) a later speed
> > query still sees the latched link down, with b) the latch is cleared.
> >
> > Hayes, for b): is BMSR_LSTATUS reliable as the carrier source on all
> > chips supported by r8152?
>=20
> Ideally we want a list of devices which correctly do notification on ever=
y
> change of link state, and which are broken.

I think all of our ICs have the same situation.

> For those that work, read the BMSR once and report the down, and then lat=
er
> on the second event, report the up.
>=20
> For those devices which are broken, double read the BMSR.  The danger is,
> somebody who quickly unplugs and replugs the cable is not going to get th=
e
> down notification. The dhcp client will not restart, so the old IP addres=
s will be
> used, for the next hour to day, and the network is broken.

Could this actually happen?=20
I think it would take several seconds for the link to go down and then come=
 back up.
Wouldn't this issue occur only if the link transitions from up to down and =
back up before the driver processes the link-down event?


Best Regards,
Hayes

