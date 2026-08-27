Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999124963BB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851661; cv=pass; b=mxraZ32pi+6qJpvrUnvtZobx/+vIQu5t4fyoSTQ5EkSzLklENKuHvjd9vD544A6a07inS2bPQMKcGWSUpeOTDmGFJ2wsxFJOAkxlu5HSRo1IK2WtDC/UXytnNTCYI2bvmal7MtTbiaTR/vBgKuxjXDdtSBtw1ouZWSoLgzULFqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851661; c=relaxed/simple;
	bh=HvwT6T6j+NkHVCIiwJZYKviDkprWnij+Zd4dVGP5+4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7KV1PQ0Mysc72QxNUCv63OI1tmdYrAjgMS1UtPE+DhaWxXArQgGdag1oQ6uKh1WUy8xxnjx4ng7oBFovQDpZvIB84t8aWMoRtqEE7K/iS7Sl83Fmt4fYoEX2nJj/1Y+eEx28sWUfYDfh1lPB8p4Y+4d4aKeke/KhQ0cCsPbAWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqebu9kI; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqebu9kI"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39f20d19895so596021fa.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787851655; cv=none;
        d=google.com; s=arc-20260327;
        b=V+xqrbnlZIasUNwH5TEA+eL1uCI8KPIY8N8vVDOATRQblXkDuSWtaBnIEq5lyFD9qt
         2P89ld/zcs73UC+aQUwi5dBlTZvBqez8nulEsLjgJO91WXSBoWfsUdQxXSDb2Sb0W9MH
         KhJJkFJlCIA3d2W2rnyEzCjOO5dwyGZou3q23Pa6Zvdayy8vaclJz0QstiRVLs8S2n2o
         wwwfnoVy9w6TI9gDOUewXqYjjzJvGIexzB4plPT64cUkL8q3adfUGVa7t8ZEfgU5AYLB
         rYjFHCq09tkomN5YZX9WjszzJMPt9wqKjS9HAsZub8WDryz9YBlpT7kkXpoZHUx4Hfh3
         epJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HvwT6T6j+NkHVCIiwJZYKviDkprWnij+Zd4dVGP5+4c=;
        fh=Jpkq8AsyAs2Et2stxGqDs089E6Ty56Qm9UlgTC96fJQ=;
        b=SWjd2vbtub/i7tK9kMDPCK7rNfQ2dDlZXjyMF/8Qef76F/dgnJgPkRphWyyB3l9BK3
         0VnWrYcNJJ4Ec/y/SyPqaAg3qOSLF+Cl7JtaKfdbvuYzcohzaZqZaCW/e5ZOisvEi7yS
         UWkCatQmRjN8iOPgYU16rH3KqmqMSdAmxoMq/z3aKisPyJBFoXorU4l5oxyRe7bZebAu
         Y3voyyrOrpMX3dIKretCdvKDBFw29tP2YWSbCP0Erfh94L/qO3dezlbixaVd934lQRgA
         OjP3k72gVNC4GwIrQud/5L3KFdPkaONC0DaCsJUAJfKMVp6AAbsOe0rq+0PEWIPRS0ZH
         gYug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851655; x=1788456455; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvwT6T6j+NkHVCIiwJZYKviDkprWnij+Zd4dVGP5+4c=;
        b=eqebu9kIn1KdNwwDWR9qsI1okv8GRHyA7WCPkRLt5s/V/9miIz5qmq+h/pfFg6HLDy
         ytpDDnnx1hk3HNruDfyT+413QN6AIG1j33eWVnnrgFVjNON0909xUr3zM74oLpd7i7Ck
         WDvWTsI84NMonhzQ8+Mb1OMfbZc5Ag4NF/3f9/OW59+DAXycr2VGA/uNy0o2lZ8zRmdL
         7zX4jTy14T6kiLLh9uD/Z1cPZDgJGKeoX6PU1lia+8er9D79yDfpFP1M7OThfSXi75JW
         ojx89OwyRy03HG3pIKrca6F3NN9XURrJjM3EGZ2UafMV6vUuzr2Ny0YuWXdKIQJeD7aq
         e3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851655; x=1788456455;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HvwT6T6j+NkHVCIiwJZYKviDkprWnij+Zd4dVGP5+4c=;
        b=qJZQ/vhJCvqTJDCZdf8FM6bb/Dcn3AmpW37xzg6tTpRPDM+g1WCjICm94ihp+AYvmQ
         oFb9NfUH2bIxvPp2q1v0x39KFThKbgRN5Orjnde56CWQg3P6zCUtqX69iF8S/qfGaGqQ
         NGlPkBZsyhFxRHDb+vcGAoOuuKBew7/lkmrTL4KTIGaWfDoV1y3XvV7cXZLDLSB8MQ+r
         B1Gc3Erp4kob3X1K9caOZHxnLUqhttbQ+xsv0qaw5x59JYnOpmEjothaocTmI5YkUwc1
         ocxbYrlkETScagYTLru5MHGY1kQ7rrZeOdiyqmBBb/MqUVpTh9smJ7Ct6qSuLhBmUVYx
         2ASg==
X-Forwarded-Encrypted: i=1; AHgh+Rq00aV4gA8eiaViEnuTQH7dtMSU3oqAY74668owOaeTtDVXYJMKTdQ6wdM0kXra9SE1Zx0Ia/M=@vger.kernel.org
X-Gm-Message-State: AFuF++ljENimci+Xcog/Z+QVj0mVRQnjwnjr/FsPuTwHp4v6z4X9ZYTP
	Hs5t7uEJ8ceZ98vkhKRxar0yzpTG/ziT5/LR7So2m6AwKChyiUsT3zkicajqtUdAw0HPaTmNn8u
	C9XX4HSAKHAd4u9mJ8Zu9FO+H4BTbIAk=
X-Gm-Gg: AR+sD11wAZ+0Gy5/pJKK4AMWPvBLFjeNKbFaSCpJKkNvWkDCgE8NQCe24JGLJYolcYC
	NY4NLnx19BEZxJz3I9VmVoamMLgOuS+c9Cpw1PYngyu1X22AADeNpSbwVNfrXFLZcgMO3Zx6Y8S
	NeY3kMlddQtvfwiNqF44KI5jfB7fJVEN0RFE+OF9Qn2N6mfy4zoYMmByVW3OjsRts+sLWtAXpmn
	vfQP2krhB0hZaN+y5iBPz9Xo+AWWXHDOa6bPi6TL/kG91IpNxhaERkhAfjBdvHgEuag0A/0KCKt
	9Qret3Xh7HIarIy1yGq4Vg319zoIWuWKtRQZ+1VINswnS9pLsqnEJON0dYNVv/vli9nPAGRfls9
	7PCFjs0cLfwK3j7BwUfm/6QRm5w==
X-Received: by 2002:a05:651c:43c7:10b0:3a1:980f:5905 with SMTP id
 38308e7fff4ca-3a30187d5eemr119801fa.3.1787851655217; Thu, 27 Aug 2026
 10:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827130335.6606-1-gvalkov@gmail.com> <20260827130335.6606-2-gvalkov@gmail.com>
 <fbde1932-5433-48e8-b352-bf27eb545149@kernel.org>
In-Reply-To: <fbde1932-5433-48e8-b352-bf27eb545149@kernel.org>
From: George Valkov <gvalkov@gmail.com>
Date: Thu, 27 Aug 2026 20:27:23 +0300
X-Gm-Features: AcwNN1XMmtv8Tl2z9UfKPdkvBE_-gNrpL34xpH-g_gnIEgIMH3CQYCP7LMwA5gY
Message-ID: <CADOrJmY5jZvn8zEu-jCntGChXSY9wRd3bsOy1GB0EWNTY9GK6Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] wifi: mwifiex: add dt flag to avoid conflict with
 platform reg domain
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch, 
	krzk+dt@kernel.org, francesco@dolcini.it, johannes.berg@intel.com, 
	kees@kernel.org, miriam.rachel.korenblit@intel.com, rongqianfeng@vivo.com, 
	wenst@chromium.org, rafael.beims@toradex.com, avraham.stern@intel.com, 
	error27@gmail.com, s.kerkmann@pengutronix.de, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, chunfan.chen@gmail.com, arend.vanspriel@broadcom.com, 
	peddolla.reddy@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Aug 2026 at 18:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 27/08/2026 15:03, Georgi Valkov wrote:
> > WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> > from the mwifiex ROM, which conflicts with the platform regulatory
> > configuration on units sold outside the US market. For example:
> > - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> > - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> > - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
> >
> > When the system boots, it detects a conflict between the user selected
> > region and the radios, e.g. BG FR US, and applies extreme restrictions,
> > preventing phy0 from starting on any DFS channel. phy2 works.
> >
> > Add a device-tree flag, which allows affected devices, where the radio
> > conflicts with the platform to ignore the incorrect regulatory hint in
> > the ROM of the radio, so the platform regulatory domain can be used.
> > This does not allow the user to change the regulatory configuration of
> > any radio. It only allows phy0 to start and operate according to its
> > certified configuration.
> >
> > The change affects only platforms which explicitly define this flag, and
> > helps overcome the incorrect behaviour of proprietary radio firmware.
> >
> > [1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
> > [2] https://github.com/openwrt/openwrt/issues/9956
> >
> > Tested-on: WRT3200ACM, OpenWrt
>
> OK, so this comment from v6 was not about binding, but this is still
> wrong - there is no such tag. Just make it a standard sentence.
>
> Do not introduce OpenWRT rules in to the upstream kernel.

Dropped the invalid tag. I hope this is suitable:
The change has been tested on OpenWrt and fixes the issue where
phy0 does not start on WRT3200ACM-EU when a DFS channel is used

I sent v8:
https://lore.kernel.org/linux-wireless/20260827171937.28878-1-gvalkov@gmail.com/T/#t

Greetings!
Georgi Valkov
