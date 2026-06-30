Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A8285CB6
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855969; cv=none; b=m3JnKK2PJtwknyZMtIpw0DMU98byU0h7Hm3DHe5SYd1fWpt/IEoVjLL8ad2FNmG28LTMOVPaFhMgd2Y1VcOBsO8k+B0VNCBIl5sdOGlVBMJfYW3lEw8O6C8XKrKWndumiplYH2tHtz6vSNkN35/6M21ZMgKZB/tABmMuzfwy3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855969; c=relaxed/simple;
	bh=QWuxanpR96XxW/AQtuxKdVFi5wsx2VqMS5+/jhKwVBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4VQ396hGwVwkPWx45PUioZF6k2060T16veCAyDqKaSxxeuBQb9dm8qmO6y5NC7yqHJzySwbTEXgnCoPIscaoOTO94KIf8sKKQbFPowl5Il//qQyH/8Vp+o/a+Y18IUYeuQ/MKm1YB+AvtjaaHAZNvabLEzKYc7NtuJnj0so1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7/fwntI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7/fwntI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC451F00ADF
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782855968;
	bh=pUvDaNXzQAJTqE61fbo+DfZd1bDU6D/qLMCG5IKiMGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=D7/fwntI/3EHRu1rhEkf/Sxm5cxtWYBPvIyeiHr4BbeE+U3AC8KziRAH/U9R2kZMS
	 qnVlrScxXMTR+aij1253AguCwtOB36ZJlqGONrgVB0aIem+0zGFOPt2bkghO19pNQA
	 0L11F8QdXG3xIS9oH+cULaOedAwOQpsrBZ8+RmrxF+WXYCsMkF8ip8T0M2sh/dSMah
	 zEJrNBRx53ziG79D5Bk6qHq/Ay1OkwovDv8nf9b1+5iqiKFwvZNA6/ZlQIlt+gGpli
	 OcoR5vcOBHqTjCfrBl6hNTosFoPsoO5PxYZ505Drx/3wDSyHCEo3Fw7RyinOJ8sFFX
	 N8ihdn7Dk2vHA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c128c8c7a76so257922566b.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:46:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpgI1z6kukT9PVqKtbNk6Rp6yzxKL+nNGjhq275kx+N8nra2V6qJ1vR04T+klwCMel4h8zZnfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZndaVxVB/UGzyHXfjJmmAW5Enlf6hem6gR6XhoLq3py4GhM53
	SLLGqX/shNNTFYNYIBInJYX++2md+NLi+eVY/4KIvP+weqQ9JcU1Db8Ka0QhcYMmcehrEe5WBBE
	3dH/ikk2Y/YZ7s8mfanEKpJruLm/BiQ==
X-Received: by 2002:a17:907:6d06:b0:c08:580e:899a with SMTP id
 a640c23a62f3a-c129042e82emr232092166b.10.1782855967114; Tue, 30 Jun 2026
 14:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
 <20260630180219.GA4139943-robh@kernel.org> <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
In-Reply-To: <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Jun 2026 16:45:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
X-Gm-Features: AVVi8Cc4MorOqwfKhUItBpWtyYeUsNNDkbig_T10OqzF2nSF1JgV4ariSeJFQ-w
Message-ID: <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	daniel@makrotopia.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 2:59=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Hi Rob,
>
> On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > > Child nodes of a fixed-partitions node are not necessarily partition
> > > entries, for example an nvmem-layout node has no reg property. The
> > > current code passes a NULL reg pointer and uninitialized len to the
> > > length check, which can result in a kernel panic or silent failure to
> > > register any partitions.
> >
> > That does not sound right to me. A fixed-partitions node should only be
> > defining partitions with address ranges. I would expect a partition nod=
e
> > could be nvmem-layout, but not the whole address range. If you wanted
> > the latter, then just do:
> >
> > partitions {
> >   ...
> > };
> >
> > nvmem-layout {
> >   ...
> > };
>
> In our case, the nvmem-layout needs to be associated with a specific
> eMMC hardware partition, nvmem cells can be a simple sub-range within
> the global eMMC, each hardware partition (boot0, boot1, user...)
> having its own address spaces.
>
> That said, your point about not abusing fixed-partitions is valid. I
> initially dropped the compatible =3D "fixed-partitions" from the
> partitions-boot1 node when it only carries an nvmem-layout and no
> actual partition entries, making it a plain named container node. But
> it's a bit fragile if we want to support both nvmem-layout and
> fixed-partitions.
>
> Regarding your expectation of a partition node being a nvmem-layout,
> do you mean that the nvmem-layout should live under a fixed-partitions
> node? Something along these lines:
>
> partitions-boot1 {
>       compatible =3D "fixed-partitions";
>       #address-cells =3D <1>;
>       #size-cells =3D <1>;
>
>       nvmem@4400 {

partition@4400

>           reg =3D <0x4400 0x1000>;
>
>           nvmem-layout {
>               compatible =3D "fixed-layout";
>               #address-cells =3D <1>;
>               #size-cells =3D <1>;
>
>               wifi_mac_addr: mac-addr@0 {
>                   compatible =3D "mac-base";
>                   reg =3D <0x0 0x6>;
>                   #nvmem-cell-cells =3D <1>;
>               };
>       [...]

Either this or replacing "fixed-partitions" with "fixed-layout" if you
want to make the whole boot1 partition nvmem-layout looks like the
right way to me.

> That makes some sense, this would require extra work for the
> emmc/block layer to also associate fwnodes with logical partitions,
> not just the whole disk/hw (hw part), Is that the direction you'd like
> us to go?

Yes.

> Also, Note that regardless of which approach we settle on, this
> specific fix/patch remains necessary to validate the partition node
> and prevent NULL-deref.

Fair enough, though the reasoning for it would be different and
perhaps should give a warning.

Rob
