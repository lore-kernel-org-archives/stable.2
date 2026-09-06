Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131B3AAF4D;
	Sun,  6 Sep 2026 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714807; cv=pass; b=ll4kNks3pecGcinHjxFd/fAVnvqKfxRn0161/ciYVuXRh1/wGVRMWZjiwj6lmRKaxuuPOxOLiY6ZYhyvF0pALK8/OpfO0KkZp7iutJ0+FUjSkD7YsFiaanJ9EIINYcz6TG50lcsucRsq7eMzDnoEMFN76z0S1/25yx6rLb6NsyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714807; c=relaxed/simple;
	bh=M0+2cKlBrvyN4r8LQbOKNSSRKwmEoldTCtgoUR4fRZk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=vD3xNvXPxJei2ZC0xrEo71QGe3K8lsYMnrscr8U7oOwJ/HB/QMOo+yD6S7UHiccIBOwUvlzqRw1YPRwdEyYNpzyevDnU0GRsml2bjsoZvbl0sLThw+oo5Ho5ouuT8gmEAeX0Tk1rXGjK47x8n2lbgVW1YF8y+MCrhutjKHF9+Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=i41ZjDYi; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="i41ZjDYi"
ARC-Seal: i=1; a=rsa-sha256; t=1788714762; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e0E9Q5AQB4LMiCVr6rMZBQ7xhFEYisM+fS1+OfowPt90xDfPogzo+vp3763IQvLLP+Bl5Rk8DvSpWAw4oN7b50cXpVCLPJj17lLbMMJRxNE89CFEGUDTw91D42KbgR/jsuFRVrbnYDIlU+L8+ksK+Dj+mKanvWk85uE+bGxZeNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788714762; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M0+2cKlBrvyN4r8LQbOKNSSRKwmEoldTCtgoUR4fRZk=; 
	b=SdkdbWxz+Esa48fTVY/zyAQcJwsm770EkFw02kfy/58CvGPRKN9PhwvqdPdEwPmeAz/spbZDpwsB602oCem8/c8xlU7VioESsICngIN1Z/m8QhInN7zc9+Y10zS7bGCvjv8Cluw+J2iwI4S1Pve8xrjnXeQxWYs7qxftG6ybHI0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788714762;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=M0+2cKlBrvyN4r8LQbOKNSSRKwmEoldTCtgoUR4fRZk=;
	b=i41ZjDYiSML73FvvOavEevNv+0YvVyOQBbTlcpkOTeSwGM2no7k3rB+Pko64ocQ4
	YUIzOgEbZFp7XSY9BmBolV7Voe1uaEOqxXfqQJ0F3xnz4ADHUilW0JDwNtEaW8KaMLn
	c4Pc/HOvx/1doIN146LUbTdyYfmpeN4GckQlMbqjI+zBgRpxLCp67ZaO4TzZfpgyoZb
	bm8kO7z89QTKL1DacCtr69PQ1zJdSwT2P5l7AO7vAlNdShiT+fC6iFdGubgwZT2JHHM
	97Vqp15n8YN8gZA9CUOpdQ4l1NDl4/V1qhBlcijGCsIzVGyXDNK36stwnM+mpermDxr
	j7IsxGgkBA==
Received: by mx.zohomail.com with SMTPS id 1788714758784682.0243427451376;
	Sun, 6 Sep 2026 10:12:38 -0700 (PDT)
Message-ID: <f66d7e55bb388c550e70fc425f1b911e40e0d578.camel@rong.moe>
Subject: Re: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
From: Rong Zhang <i@rong.moe>
To: Marek Vasut <marek.vasut@mailbox.org>, Bjorn Helgaas
 <helgaas@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-pci@vger.kernel.org, 
	stable@vger.kernel.org, Krzysztof =?gb2312?Q?Wilczy=A8=BDski?=	
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Koichiro Den <den@valinux.co.jp>,
 Lorenzo Pieralisi	 <lpieralisi@kernel.org>, Magnus Damm
 <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Yoshihiro Shimoda	
 <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Ziyao Li <liziyao@uniontech.com>, Huacai
 Chen	 <chenhuacai@loongson.cn>, Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <9f0d8887-9332-4919-bee9-c165361e2ea3@mailbox.org>
References: <20260903202706.GA2234456@bhelgaas>
	 <41f323cbed2da4fa3913dfd62b5595bc3d5228da.camel@rong.moe>
	 <9f0d8887-9332-4919-bee9-c165361e2ea3@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 01:07:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Marek,

On Fri, 2026-09-04 at 23:53 +0200, Marek Vasut wrote:
> On 9/4/26 7:42 PM, Rong Zhang wrote:
>=20
> Hello everyone,
>=20
> > > > In light of the last paragraph above, that the MRRS has to be limit=
ed also
> > > > on all devices downstream of this particular controller, I would li=
ke to ask
> > > > -- does the Loongson controller have the same limitation or not ? I=
f not,
> > > > then I would argue this quirk should be isolated to this controller=
 variant
> > > > ; else, I am happy to start on the core patches.
> >=20
> > ACK. I agreed that it should make our life easier.
> >=20
> > >=20
> > > I don't know if we'll get a real answer for Loongson (there's no
> > > maintainer listed for it, hint hint :)),
> > >=20
> >=20
> > (+CC Jiaxun)
> >=20
> > The driver was introduced by Jiaxun without updating MAINTAINERS. I gue=
ss
> > he'd be willing to be listed as a maintainer.
> >=20
> > I don't work for Loongson, but I do maintain several MIPS-based Loongso=
n
> > devices for the Golang community with my colleagues and personally own =
a
> > MIPS-based Loongson-LS3A4000-7A1000-NUC-SE mini PC. I do some PCIe
> > experiments on it from time to time for fun. So I am OK if someone want=
s
> > to list me as a maintainer or reviewer :)
> >=20
> > > but my guess is that it does
> > > apply to all devices downstream of the Loongson controller.
> >=20
> > I believe this is the case. Maybe Jiaxun can shed a light on it too.
> >=20
> > Just checked the kmsg log from April, the firmware seemed to only clamp
> > MRRS for devices directly connected to the root ports. IOW, it seemed t=
o
> > only clamp MRRS for the upstream port of a PCIe switch, so
> > loongson_set_min_mrrs_quirk() had to fix up downstream ports.
> >=20
> > If you need more information I can do some more experiments with the PC=
Ie
> > switch card.
>=20
> Please look at the commit message [1] , that lists the exact test and=20
> the PCIe NVMe SSD which triggers the data corruption (let me know if=20
> something is unclear). I think any PCIe NVMe SSD which is non-HMB with=
=20
> MRRS on the SSD size that is > MRRS on the controller side will trigger=
=20
> this issue too.=C2=A0
>=20

Unfortunately I don't have any non-HMB NVMe SSD, and it's unlikely I'll
get one anytime soon due to the crazy price. Before the AI supply chain
crisis, I bought several NVMe SSDs, but I chose HMB ones as they generate
less heat and consume less electricity.

> If you could reproduce it on the Loongson, then yes, it=20
> is affected. You might have to disable the current MRRS workaround in=20
> the Loongson PCIe driver though as it might hide the issue.

Due to the lack of non-HMB NVMe SSDs, I can't reproduce the exact same
issue. Theoretically I may try to mess around with the AHCI controller
(see the mentioned commit below) by manually overriding MRRS, as my
device's firmware already clamps it. We will see...

The firmware of many Loongson devices (except for some MIPS-based ones,
see the commit message of commit ef61a0405742 ("PCI: loongson: Limit MRRS
to 256")) already clamps MRRS for most PCIe devices, which has proven
that the 7A1000/7A2000 chipset does need the MRRS quirk. Therefore, you
can just go ahead with preparing the core patches without the need of
waiting for my test result. It seems that your approach is not going to
change the current fixup effects in a significant way, so it should be
fine.

>=20
> Thank you for your help !
>=20

Thanks,
Rong

> +CC NXP, because they have similar controller on MX95 (and others, but=
=20
> the MX95 is closest to this I think)
>=20
> [1]=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3D37ca1997d2eeec86ad065008d6387fd15d18934c
