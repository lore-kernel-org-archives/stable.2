Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2F048C3FD
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912969; cv=pass; b=aY35bPBCTxX4vJfg8lKGTJ5OQtl3nA8MjVSza+sFIgeKUXxsnN/LK/p+prYx+h+IDeZRThTZ2WsbR8uVtW5GX0cJ5mVZaZOsayHH6sJOvB6VZ9zLIj8HDzItd9GA+ScmWh6+ClX3tYCvCKxPRM9loP3RIlFPnMwDFvEiwux13HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912969; c=relaxed/simple;
	bh=N+n/R/mlFs2wkRiMkBtopMW3wGbtfZ47UIAhPinzCC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiM5/3m+O+Ihq56wZ2K+1SfBI9VoBN12TtMK3EOXw3/ZTJgmcVJSmT+hEhFR2nYViIuCwEKHW4cl7aakJslmdqhxxaw1Xg2CQtqMWIj96Iu0ksnYj0/crmdUpcXsSAOUPj4jlvi+AY7VKRRfF93B+/oxztJqvET8EtFUGXN4Q8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0TYYJLh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/Hzkdi7; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0TYYJLh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/Hzkdi7"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8jNV683286
	for <stable@vger.kernel.org>; Wed, 1 Jul 2026 13:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=; b=D0TYYJLhf1Zwu2jk
	spVTvuXD1DtrAeoeC2o9zHuxnGi5L2oNStqdVlMFzAka42qve3FCqsZ0imRiSjGS
	wY7ttgiTuQozDBsloMvMWMZ7rH/qOR9G1lDsmLiF7+3AQRgTZm29mCqmNwGw2zKN
	vUeqWlghwM2RkTREn3uRhASvg6bSZRMNTxyjChtRcJbcOyj43Bn47PrPRgooNtem
	izYRe/87MwRcAlgJr+M4KcqpvbGLoJprSrbUKhtWlVLLmIPX48qaTHAE596YlbJv
	Qs74Yv6HObEi99FocjmPI1rDGZPAdejjSZRzvLFUsQfNCiXq1CiD5iYcCYaKTrC8
	PAdhXw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqmgt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Jul 2026 13:36:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e56b2b350so129788785a.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 06:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782912964; cv=none;
        d=google.com; s=arc-20260327;
        b=ozfIwxjr9VsFVhUJrefMsd4FStjN+6jej0t2Io1v7YWmOV+lAf2D1z82w7vAXNe2a8
         uhdqGLvF/obiNyHlw1zbZFDeCWn8Bc3ZaLdtSJLoA7mmLAgbf9pPvbAaiSTPUlScQcty
         7C6XV7GmedyKXf4ETptOElZ3LlwROREPXOGYwUU5Ojs4LAoBOYHdIlfFsr+mE3DUmZcE
         LWOe4tZ6kW/EeVgYQnpl+MwDqHb9Cx0PpRCMV5tB3fqeY8nhv5VroSKIZzZLSBGqRPyy
         YHFMirZOPb1dUYUfPtclDntZtgXIhZ8GocwOJzG3eIaXFbsauFoGSItEpafj0FVfEgLk
         GdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        fh=pdlXT3o5aNlSrlSG14Y7Ix1Gf94mnkBd8ietngVWZUo=;
        b=N4ygTc5Nv2axATOnO2nQfMyOCv705hLAvadXTXuf7/ea8P1JykwabCfVhSaS4mVyTH
         GuMAE9cUeM2ZYI499sL1NRAyFJUf8kPQv0uvzN6r9v7HK5ebkmLLJi/06vnWSb8kPmIX
         Eqe6dWYBVe9DSZF5jy0Q3UCKVwM1QcmOb8V/0ynqfQWzbNtfM4Hks/ibVl+gfdC7Nz4q
         cIIwfnv1RIsXWgRyjGCG89YXY2yNRAep9cAyT7tgLFJGgIPqUvERlkLcTLcCVYOmbF9s
         oFdwtqjrLJy4tXwIstmFpVbNW4Qgxl0MOI411AKVBMom8aRxqWL/SWZ+sHaQ9DxGN8YG
         YF/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782912964; x=1783517764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        b=J/Hzkdi7UAfkvQ3JS+pBNsS3Qmx4/AV7Wjuw2Oh8ju62IMD4QCIsi8DVpTbiouooBM
         Rcm2GJbEmdUbxy+Tc3ChOTTQm7hJOvM938TBwM5bFgA4o2C2AO2+lMAO5TMybnLRSHmF
         QLShWKLlcjvI5yKmQ6Mwu4jxcPhKVXtkg+uo2PRdBGokaoUPmnFlQQW49W+GI91P/mM8
         737P8Heu+Qg3/8bZhhpaNqZxmFsxiIS3IqmrucpJR22QrEYxEOYX4bOgxfGLNUTycXxA
         1HWSCdbIzTxZKs7dwvsBdnBCIeB2WMujN8Wii1CvgsQCQmMwEdU3daGY5Pwffj5LsOHs
         hBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912964; x=1783517764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        b=MQyMNwAlC4/2qh/jCNr0lKurttjGtY6lmZIIiQwt0SpA0Z8wdXWALF8FJtnsHc18gk
         SnM5OnFqBcJRvJ4D1FcPFJhC0eoQ6oR7P4ThZSX3WooQ1ZPyVc8ROzF1P96RSU41D1hN
         UIXwwW7LtGro6/mCiEl67a73qD5RR0UefHq5kkc6wNUIaA9N3FxAVVmm+vL8wfFy9hMA
         E4E/fKRH7/JW0eoHSBi9a/p082toT4aSuEV9MGQR5BcP24sps3WBE6UaiOWIcXCp2fKS
         wBqmysB+6FrQ8xV+vMCWdHT/eB0yQOjHdoWnUcxanHTbicxxpyZXqkNfC2XyQO65LbPl
         +RwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+y9B+nObMTZVTuFnKaGPazQMIqYuyheRSw+w5oujE+hLPB3Jqs2hgydFyflrIXOUWXtRfEvjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq312wTtix3d7JsDEiGRXSJvmPMWm0pO1j/AdzTUiB0aGPVzZl
	qs7Dkx2sV8AxwMVkCjlA4HgMxUwZhkyLwRkBQ7ELSzVNNW3pOdUSp9u3ZjStVCIL8etw5s1phjo
	yF+Nyvg6UbOH3TmefpJYOTHnEoeZ4ZsBX4irsQo1Ew0wla2vCkib0yCYQglCSU9QpXrc2nwjxmR
	gXXC3qzcLYmSc/RLnYnpNi8uUFXsdOQZgzrw==
X-Gm-Gg: AfdE7cm2hf3iYdbvOWdZyDHAmJuPEw9jkYLjmRFkIAgyhEQXLp9h6lbA6ZJiyTfwTIF
	FmaHSSEDtHg9wnc4YTyu3rk4YMO1dxeyn0hbd7SlBAPx1nmwyQqpB6P6uJWsfQgJE4NC+EphyIv
	UMTJnIMDIQjHW2xJHJRV+RSr7I63VQRrqp3JMyXvH4OCnIhhMs7JWTzapNhdODFrxlcPLGdnHKK
	y0L5DKlE4vf7AQRmPvdDhTiYThGZGkzfgyShyfXv4kfmneif7f0ozGWy85o7CZe291rJqCqu6JN
	RjzDPML6eg==
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id af79cd13be357-92e7853d109mr199457785a.70.1782912946766;
        Wed, 01 Jul 2026 06:35:46 -0700 (PDT)
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id
 af79cd13be357-92e7853d109mr199161785a.70.1782912918609; Wed, 01 Jul 2026
 06:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
 <20260630180219.GA4139943-robh@kernel.org> <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
 <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
In-Reply-To: <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 15:35:07 +0200
X-Gm-Features: AVVi8CfNT2AJJTgPBXfFVJQmZjW_-a9Isbc3rycVEtJcwbZkpqGBU1gJZohgDaU
Message-ID: <CAFEp6-20FXTOKQ6EPuR8OUDkqE4JXcUbXaFy7kRFt4fzszPQCA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SzlRFmcZUkgeZbg8dpC1AaC1cjWQzHpI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0MiBTYWx0ZWRfX3+DjBuVTjsPq
 3Oqc/eH4JbmyCowgY5zd5PDtg7cUs2T0j21wq5hv8SyYEHzJexLtdKupgyzkUMuIZhsKzVhGJSc
 FbZVpmAU3p4COij5FU82TKOXoalredEmIuHHimlqOFsFMB/aMK9GP/muCdGCoPMrBjK/e97pfmC
 AXl1XKveRNn8X8F/4WKNqmTBlew4mu7zCKJtuiZ98ZgSum5Y9CwCaqHNlHVm9eaNkmOqYuD7Kdz
 +VIHLIDE5N5BC+eRzylBPnkfCnH/nYkOQLj8Ijx9cN5dbi3GxLDkMIjlT+uDh16+SPIrtlIQEWL
 FmjU9F0DHKI4poWlMN1ra1Q3N237UdMZB52UGsFxcv5HUKu0GO/K6y47c53JVMMSiTHQgD0Fumj
 atTirVWx+DqDe9va75NCxkJVVgZ1b/+UoRuqXHFNeC/BqD0CPPSZaaCYAPJPw0hcZj28tXoK1RD
 j1rLNSy5r0qoBxT2C/A==
X-Proofpoint-GUID: SzlRFmcZUkgeZbg8dpC1AaC1cjWQzHpI
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a4517c5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=bM2Xkg4KEcMkddnjsM8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0MiBTYWx0ZWRfXxvgdpNHUJ6gS
 m6pB8BHvQZ2iNm3LnaxoFJz/tMR59RxS+R8Uv344T9BlY5dyz/zkxsyqB2zAF2hzNKI4tjFhZvW
 mtpHe9lPM9IgNjm1yEafiUHzU5iYhxU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010142

On Tue, Jun 30, 2026 at 11:46=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, Jun 30, 2026 at 2:59=E2=80=AFPM Loic Poulain
> <loic.poulain@oss.qualcomm.com> wrote:
> >
> > Hi Rob,
> >
> > On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > > > Child nodes of a fixed-partitions node are not necessarily partitio=
n
> > > > entries, for example an nvmem-layout node has no reg property. The
> > > > current code passes a NULL reg pointer and uninitialized len to the
> > > > length check, which can result in a kernel panic or silent failure =
to
> > > > register any partitions.
> > >
> > > That does not sound right to me. A fixed-partitions node should only =
be
> > > defining partitions with address ranges. I would expect a partition n=
ode
> > > could be nvmem-layout, but not the whole address range. If you wanted
> > > the latter, then just do:
> > >
> > > partitions {
> > >   ...
> > > };
> > >
> > > nvmem-layout {
> > >   ...
> > > };
> >
> > In our case, the nvmem-layout needs to be associated with a specific
> > eMMC hardware partition, nvmem cells can be a simple sub-range within
> > the global eMMC, each hardware partition (boot0, boot1, user...)
> > having its own address spaces.
> >
> > That said, your point about not abusing fixed-partitions is valid. I
> > initially dropped the compatible =3D "fixed-partitions" from the
> > partitions-boot1 node when it only carries an nvmem-layout and no
> > actual partition entries, making it a plain named container node. But
> > it's a bit fragile if we want to support both nvmem-layout and
> > fixed-partitions.
> >
> > Regarding your expectation of a partition node being a nvmem-layout,
> > do you mean that the nvmem-layout should live under a fixed-partitions
> > node? Something along these lines:
> >
> > partitions-boot1 {
> >       compatible =3D "fixed-partitions";
> >       #address-cells =3D <1>;
> >       #size-cells =3D <1>;
> >
> >       nvmem@4400 {
>
> partition@4400
>
> >           reg =3D <0x4400 0x1000>;
> >
> >           nvmem-layout {
> >               compatible =3D "fixed-layout";
> >               #address-cells =3D <1>;
> >               #size-cells =3D <1>;
> >
> >               wifi_mac_addr: mac-addr@0 {
> >                   compatible =3D "mac-base";
> >                   reg =3D <0x0 0x6>;
> >                   #nvmem-cell-cells =3D <1>;
> >               };
> >       [...]
>
> Either this or replacing "fixed-partitions" with "fixed-layout" if you
> want to make the whole boot1 partition nvmem-layout looks like the
> right way to me.

Well, now I think both approaches make sense. We should support a
fixed-layout on the entire hw-part/block, while also allowing it
within individual logical partitions.
Support for the former would only require a small rework/addition in
this series (to have the hw boot partition a fixed-layout) . The
latter could come in a follow-up series, as it would require some
additional fwnode logic.

>
> > That makes some sense, this would require extra work for the
> > emmc/block layer to also associate fwnodes with logical partitions,
> > not just the whole disk/hw (hw part), Is that the direction you'd like
> > us to go?
>
> Yes.
>
> > Also, Note that regardless of which approach we settle on, this
> > specific fix/patch remains necessary to validate the partition node
> > and prevent NULL-deref.
>
> Fair enough, though the reasoning for it would be different and
> perhaps should give a warning.

Sure.

Thanks,
Loic
