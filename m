Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262635675E;
	Mon, 28 Sep 2026 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790572780; cv=none; b=Wo6hwcH8zEr5OBxG8MkMLy7oiRUVpVM6RS5+L1kBZ3CO6Q/9giLrQ26gG6n42B3f3vnmIOG+VlJRAVeGptnpWDp2OAh6UZD4/oOEoPKlRfO0yxdtUgO61//bLTJuu6VBJJoOUjyMQJDwhH16CgJZM/6BZeFrVrQjf48PIEXaa1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790572780; c=relaxed/simple;
	bh=YPKQVqsSDNywa9fBdfYwq3UktAQvIm/zYcJCgkoaltE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CemQJrM0Sw5qjJvcDHG+cwTaXVfUOP8HTt0xoh2fLugOMktXXZY0ryX7ETQTf0bMth9YJ9oxrthsyoLeO034qbfb+LvyyswVcLorXW19WTQukRNj67pV/zcqF/It1kGBdLKge/guqgasPp3rSm6/+wL2MBQdABR0d7KrcpgGhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=DTv/Pq6E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RFCDWqhM; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="DTv/Pq6E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RFCDWqhM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 912211D00089;
	Mon, 28 Sep 2026 01:19:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 01:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1790572777; x=1790659177; bh=sWl5Azo2e5hnUzulydQcbmPGsWgNT7CK
	qsQPmSiz+As=; b=DTv/Pq6ENTW6xHFews7RvAHlLc8B+/osyrj0/agY0ydLar+g
	3UDn3ceDN5m2UDTcgpTKI1OPEHnaeKo4m9pXn/ZnIEuuQup4EazAjF6TjOWdpEys
	jjuNBBJnEKs5aW9SDOo1a2jeVmcXxIrIacBoSRi5PmlqyfdSuPEpQ2bHIfyg+6HI
	GbUCVingQd21Dxr7Tndu3schdadQTYNEJ3X6Hm9D0nyjVxik+fzaoqXvPCfDpqHs
	NDFvx7QZ9cR9xh53BWxuK48jNKv3ZftvOVWy55zCKMLiq7DYVH7hS7m4zAo8ViYQ
	cdzS077mpa8AY9kM/JMY7G/MKUZaf7x0qYgGQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790572777; x=
	1790659177; bh=sWl5Azo2e5hnUzulydQcbmPGsWgNT7CKqsQPmSiz+As=; b=R
	FCDWqhMt/kQ/kGsnEdlfsnNFSnwLcZ8W0rk5aYqsY6cA/mgjoFBq3rppRNns2RS2
	JWjvXcprp9aF+aEvad0TNoIwO+yaiI9dvNffiyHTL4yqxuLHDi8Em4a9UAY4pwvQ
	GYKFd3n0cfUXq8gfdi8XUIlWiShK7SyymcPkjz0UAOifBepAbgmWztGOXTlEwRxr
	Gg8LyEFYpvHruwlAUhUjo+m5s/PpXLR5hkXxp7/vNqNeTH4epRdrDeFdlihujjfN
	m1OaLrCYLvBuJzT2bPLTkKJzr8TWPCFGURnFAZUXCxq0/TEfm6gOB4SJK7m5xG91
	GLKToMXFyj52Vn2fzdM/g==
X-ME-Sender: <xms:6fi5aqHMG97hwkR5YBS9HM3APIEZ4ei9NYubfSKt0FGu02w5K1NDLA>
    <xme:6fi5amTlSl1MArzXBY5HDu33Hs1qr_gHzgaaIPVO35IH6NMfT2aXbn1meTrshKsL9
    4D2pyJZkXZyosp6ARwntSxnFcUztBTmuiTyrWYQEyGI4033rc8oae4>
X-ME-Received: <xmr:6fi5ajL6M0ESM8HZjE-iL1sPrCG6EkHIJkscrQB_xv6ay2_nZDlV7pr3oyae6X6ENal9OYPfUo-gAjEwSZ8s1piSWDs>
X-ME-Proxy-Cause: dmFkZTGcaOVbDMuWrlzWoHQJMCDUyjzfVKj7TXtUBmveGa8Kns+2wyybHfeyT+RDPEpic7
    SBFEN5Zl9BJjr3GyNSlA/ZK/Aa6RoxRUtTi9eiddwiVyAdOvm5MKRGUGOGksHvPqtErpIN
    /lUvN/YuJs5puk1rY13mzNtaNoNp34v01xBsK9wvVHfYvG0odWU2Au81m9kvyov6jBX4wJ
    JVJFxnnQJpu2MmZSyqQbeIljQtPYnzly8gv3BskkP+iyiGqWn6BfrhtUOfmHUshg/bncCL
    3isYFRyEhSzOVI1fump2Hgfvlc8lhzMViuMRUcQbDhSBsA9Z6TiJedNnIVmKdt1Fu2Zora
    EDO3yT3O8FUInXq6XCOz+UErY/Zj2x/X0rdU8Zi33bL6DkDeIBZfMoS/9h2I+N4vh8Lc4/
    xxs6UYOqdm0kUQxVUeSRlxxwJOpK0V97iaVgWMLS6e8hoQEIrIDh6V0t5I/ArSdEyLqVIc
    AjNGnHx3UjqKNJvb68kim+Nt/QHijjMcp3PRwnpd6roqKJAFjynZ/YlrlZAPZQwdZHzMbY
    SINzRsfUrtHCvoJh2XbwKriDGhxfd+bzZVgh+MSpdJ9e+dgsNjtUFi9klDKQCI/DFU1dHM
    gtMdUThWYvrzV0IDPlshwb0HQ6+zRBG+A5ASn42fsdJb49RbYHbkpGETLrvw
X-ME-Proxy: <xmx:6fi5apZ30HbZ-TuAKnbrHCZMFIVG1I7TtZyyFP2x5_NhDg0JYUm7YA>
    <xmx:6fi5at-Kvx9mg3M6nauQPKK7t2ZZD3SuoQttV9322X-LELlCM1J8mw>
    <xmx:6fi5aibplZGuqS4PJ_tsiv5469JCLrOXm3Py8nUL2rDLpanoAhBwjQ>
    <xmx:6fi5apM9CdfSPJak9AFIbuDz9pTL2hMLYrf7CrBRAixW-tOlDFvCLA>
    <xmx:6fi5ahVN68NzHnhanmHAvgNBUqXYpZSqzCIqfi_R_Lu-MJJHHwWwg5Dq>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 01:19:35 -0400 (EDT)
Message-ID: <c4cdeb880a6eb8368c4fdc8de58f3b0bc6c753fa.camel@alistair23.me>
Subject: Re: [PATCH] PCI/DOE: Fix double free of a duplicate feature's sysfs
 name
From: Alistair <alistair@alistair23.me>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, bhelgaas@google.com
Cc: jic23@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Mon, 28 Sep 2026 15:19:32 +1000
In-Reply-To: <20260928035035.252394-1-donggeunyoo.kernel@gmail.com>
References: <20260928035035.252394-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-28 at 12:50 +0900, Donggeun Yoo wrote:
> When a DOE feature is reported twice, sysfs_add_file_to_group() fails
> with -EEXIST for the second copy and pci_doe_sysfs_feature_populate()
> frees that attribute's name, but leaves the pointer in place.
> pci_doe_sysfs_feature_remove() frees every name again when the device
> is removed, or when a later feature fails to register, so the name is
> freed twice:
>=20
> =C2=A0 BUG: KASAN: double-free in pci_doe_sysfs_feature_remove+0x117/0x1b=
0
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 kfree+0x11a/0x420
> =C2=A0=C2=A0 pci_doe_sysfs_feature_remove+0x117/0x1b0
> =C2=A0=C2=A0 pci_doe_sysfs_teardown+0x90/0xf0
> =C2=A0=C2=A0 pci_remove_bus_device+0x128/0x2e0
> =C2=A0=C2=A0 pci_stop_and_remove_bus_device_locked+0x1d/0x30
> =C2=A0=C2=A0 remove_store+0xd2/0xf0
>=20
> Leave the name to pci_doe_sysfs_feature_remove(), which already frees
> it for every entry.

What about adding a NULL check in pci_doe_sysfs_feature_remove()
instead? Seems silly to keep duplicate but unused names allocated until
teardown.

Alistair

>=20
> Fixes: 2311ab1820fe ("PCI/DOE: Expose DOE features via sysfs")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> Tested under QEMU (q35, cxl-type3, KASAN) on 72d3fcf802c4. The device
> reports its CDAT feature once, so a test-only change either registers
> its DOE capability as a second mailbox or inserts the feature N extra
> times into one:
>=20
> =C2=A0 case=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 befor=
e=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 after
> =C2=A0 no duplicate, remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no report=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no report
> =C2=A0 no duplicate, a name fails at probe=C2=A0=C2=A0=C2=A0 no report=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no report
> =C2=A0 two mailboxes, remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 double free=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 no report
> =C2=A0 two mailboxes, 3 remove/rescan cycles=C2=A0 3 double frees=C2=A0=
=C2=A0 no report
> =C2=A0 3 duplicates in one mailbox, remove=C2=A0=C2=A0=C2=A0 3 double fre=
es=C2=A0=C2=A0 no report
> =C2=A0 2 duplicates, a later name fails,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 =
double frees=C2=A0=C2=A0 no report
> =C2=A0=C2=A0=C2=A0 probed twice
>=20
> The doe_features listing is the same before and after in every case.
>=20
> =C2=A0drivers/pci/doe.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index ac95b1d2d9997..56605386c4c16 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -208,8 +208,7 @@ static int pci_doe_sysfs_feature_populate(struct
> pci_dev *pdev,
> =C2=A0				pci_warn(pdev, "Failed adding %s to
> sysfs group\n",
> =C2=A0					 attrs[i].attr.name);
> =C2=A0				goto fail;
> -			} else
> -				kfree(attrs[i].attr.name);
> +			}
> =C2=A0		}
> =C2=A0	}
> =C2=A0
