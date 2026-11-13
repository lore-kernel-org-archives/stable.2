Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794563293;
	b=jRIFo3U0LBQ3c9nNMSpHeL7q/FUKrhuNWRKJ0um06u9GGPYdKWurNBwzm9VjCl/5+yWv
	 BCTSCtB3J1WC+txkqJkU4nGJn/TTwpNPiMyqngJISEvKhSsEOWT69c3hEiVWPPfCEsobm
	 124RvXsXaBSdDCLy/K+Qki9cRuJrir57Xrznn6BVnHq4LdyT/ygkHC1RDFF7T7i0EkvPK
	 eSMFF+w+Rgrha/KypUNLYBQSzBaLuXyArapPHLAraSpMGNim47WMh6KaiEy2HRfPvbpNu
	 B4g6LEEdZPcGcV4Tyy6R0r8fIbMLdCWMIyP9uxtpp4CJRSUZKJfoV33J3knurk/X/aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563293;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=6H6K3uHq6NldMYMP3YlBlDnoWedZJbrPijCyuvU5TUk=;
	b=wG3dHvBX6XXCB1e5pZpU38/z7uKFU2yTyv/v2C5pAKpBGATZi1NUbTT8CuEDs+CxqfGB
	 4QDpXB/SBywLpnf0oRv0rCqnRU4I649Sa9OEEodqnxxGCC3FOBHUMunb5LBtOy1PLaYbL
	 3ScMt7VcgOtz73u2Wv5lTusLDkobdWAqHcPmMlNGb2uASBB9/wzKEkyXqd/orLSsLn/2h
	 roZckHxAgSbr0AmON8Oexgs436GOsfRv0UvYkZvJI4xIj62GmoOGM9UmQE3gkD17OOqDa
	 btUawOs6FmM3pxE06TyH4UgD/rqqTYMzGWLzwQw2KccdRMzdMgwyW0E9kJX/cohAwnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FqvcFHOA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B643606A31C;
	Fri, 13 Nov 2026 09:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B643606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FqvcFHOA
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 980D3202266;
	Fri, 13 Nov 2026 10:48:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794563289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H6K3uHq6NldMYMP3YlBlDnoWedZJbrPijCyuvU5TUk=;
	b=FqvcFHOAeaCHKc//EX4Sn8K3WgWUE9ly8lTAA/ubhgL1zyUhcTU49NYaJcy03/u2t82L2W
	UX6G9VcHfqnXq0mqWRNwteHo5xJBoP6Tx5BSLYqxtyEKWVOyKTrpB7xn/rSkr58/b1ho0M
	JWeoMnt1LU/QDcnnf7HcGVahrSiJf5eJWCif3ai//637c9+QsqtaIjPJh7owV9WMyK5ZQv
	Zsrk/Pm6XkdQf2tzoEi+C+QJWgvhy0nb/X5hq1t10P3gzd43rYDbd05at58VOHz4FYSE2m
	8hO6tH3vsmEcF087cew6LcawDaV5ueVfjeJm2N97h2mBzD2mWh4UttExg9DaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794563289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H6K3uHq6NldMYMP3YlBlDnoWedZJbrPijCyuvU5TUk=;
	b=F07za/cfOIcBUy3W+xv3VFmG0ykRp8tVU87RsKSyxqY1Z5RAwqaSKdOzAwj1nUT5I4Auaz
	1FiIIWP7NXflJyjVgGZlm6TsW+021zI7asuteUQUvTYP0SCvyeQCrVQT6rWK7+E3ODml5z
	L6FtPBs1/ytxW9zd+KS8kKZZ2TZaCbFHzmb6WzEwP6Ryp1L4uzTS5vZhmo+Y1Wks1A+WKL
	IQMN9NEhy4uFTCu6oOqcE8Tfx0NQlJnfCPiFqwqIkzYz9EV1V5c1r59r/mqTE3EI9FRrEz
	w5EXvwLFlS8IjRBQHzCJBQEEOC66XBFattdrbfPOWjN2Mm9uS4N463WBsTc56g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794563289; a=rsa-sha256;
	cv=none;
	b=DATszqC5RkaNaiZF3N020sjUU8Dt3zypTQz316EJeMEzE20YJJfUYsbGms8dgsEOH+0FTR
	0cuFWWXTi9H4nm9W66UQxLfGxRADGU+tgQZ/51DV+Dfpx8e4Sn74JcF32JCuDXslkLjKF5
	v+pnIT4/mhmfb0TEpcwwXIGIQwrwCJLDWGEoMEHDulMxaqszKhLbHGc7XEKlnVv5yGL9+S
	iBPXCJszLfz7yjoISZd0P6vmS2s2WaNYP4ay++qtT+8WTKLvsMQpCIc1MXQOUBNt1CfiHo
	GfKNzWN0sxP8v6b3JGt8u51d/JlSwOQKbio8i08p6Uk0XPjH10ZKbuU1pkoSyQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <b3fa092ec9390cf5bfe2f4338af68327be70e6e1.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/6] media: verisilicon: Don't hold the VPU in reset
 after remove
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Arun Iyengar <aiyengar1990@gmail.com>, Benjamin Gaignard
	 <benjamin.gaignard@collabora.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>, Mauro Carvalho Chehab
	 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner	
 <heiko@sntech.de>, Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>, Hans Verkuil	 <hverkuil@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 	linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org, Sergei
 Khomenkov <shomenkow@gmail.com>, Tharit Tangkijwanichakul
 <tharitt97@gmail.com>, stable@vger.kernel.org
Date: Fri, 13 Nov 2026 10:48:09 +0100
In-Reply-To: <CAEy9hNU2ox76TFKtdisqUHDxZ=3gPVBDBcjz_W8RtCpCpK5d7g@mail.gmail.com>
References: <20261112-hantro-robust-v2-0-18561fd48838@gmail.com>
	 <20261112-hantro-robust-v2-2-18561fd48838@gmail.com>
	 <c97eef1ba88daf83d231d2ecc78b47fcf524385c.camel@pengutronix.de>
	 <f212840b-92fd-4d97-a6a7-2768a55483f7@collabora.com>
	 <CAEy9hNU2ox76TFKtdisqUHDxZ=3gPVBDBcjz_W8RtCpCpK5d7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Do, 2026-11-12 at 23:54 -0800, Arun Iyengar wrote:
> > Le 12/11/2026 =C3=A0 11:19, Philipp Zabel a =C3=A9crit :
> > > If vsi-iommu accesses require these bus interface resets to be
> > > deasserted at certain points, why doesn't it request its own reset
> > > controls?
> > >=20
> > > Depending on implicit assumptions like another driver not asserting i=
ts
> > > exclusively controlled resets seems fragile.
>=20
> The AV1 node lists these resets for hantro only.
> vsi-iommu would need them in its own node and binding,

Would that more correctly describe the hardware though?

> and both drivers would have to move to shared reset controls.

Worse, shared reset controls don't work if one party temporarily needs
full control, for example to issue a reset pulse after timeout.
So this likely would require exclusive reset controls with
acquire/release.

regards
Philipp
