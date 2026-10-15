Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0324E4A1
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792032435; cv=pass; b=D2EXdHHtx75fYMS94WuS9N7u9kMPrgIq+EY327A0BReGYWIspMzuqV1HW7et4Sx72CLZvDn9AsDSs1hIu490DfgUWLAOorq8VSV5cSUaqS+KmpuCABPKewlmz+xUpiHoqFktRAmBLk2nx/BbI+rPzfu5YhdlBRIUytC7iq46oVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792032435; c=relaxed/simple;
	bh=16GbWlEqbR86iNc8/Kds0QNYGdsCxKka1B+rvUYPHwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5WuIPjmW23IOGnzBlWtVhWAbn0b1Pa8OqMQQiZZB0HMSSwLMfEuEQsL/3d4FvsFlY9k4mW05JO1Rcy5WNhYsWd/UjDV0EXNRAaoQOgwwgTJmGyLdOxuJFjBJysc3IvLIba3F+gzjmjAuhYa7AlllN+zJWuNclJU8MBIbUbSN90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9zBFT4g; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9zBFT4g"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7c03a445cb8so712647137.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792032432; cv=none;
        d=google.com; s=arc-20260327;
        b=RDC3tTAjZ7y2Wm12/AGrSJ+GVXVmRR9J8Wd8uRUNGNrraui4vLm/nSVq2BC1+7hcF0
         W5Br9ifLn8n1vTFgEbzvzzBBUT0l9AjtCiHMn8DAku3jxPA3QN5lMxeKQIuarCjnCHoF
         sXuSGgFzZu2vnZB4fePB8D+0nz04SS5O6Y0yt5pz9fotcEj7aHIyStpCwCKZm2advgS/
         iGNznSECeoylrOWo0IbkgO+lwzgpNrLiiOJ4Xtn4+kb5Fix77zG2+FzUyUV4/4gPg+TJ
         6euDqVFVRtNjjC486GxJ+1XnkPuja38oQJFrP7ef7dABdVgdAlm4qQT+G/AgIIwB1cTG
         sd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=16GbWlEqbR86iNc8/Kds0QNYGdsCxKka1B+rvUYPHwU=;
        fh=erCfbJKlcAdmUQdrPta3NI/Nxc1uASgeRAGf0nTI2C0=;
        b=XDQyDGgyQVRx+whV3xweZjmF0W8GZ2BMY6m3MeQo+NlLKpG403aMrhbL3JkypfEKGQ
         lsLdoOyW9bXtI6kFoY8LY3tQWTjvn4rbZ1/iL2T+VdIl38l1suRGK7vv2zMmmDm7XAUE
         s79jOiQZWDzdhTtUrk1dF85XBMLz1Nd4dzNDJTFZmeZBlWn30/j+oLVF1Cv8q0JfanNQ
         jHaNP28zI06zG1HHE/KRW+IoSmJRC0dqSvX+ROuAWmI6rXxMSx1MrtX9hk/nG4XqW9JG
         690cU4D+wQHX6+kKMX9Vr641L7RtdyNWGbeawyktv89is09A3c96AvKNb8v8nEh3Et4s
         wC1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792032432; x=1792637232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=16GbWlEqbR86iNc8/Kds0QNYGdsCxKka1B+rvUYPHwU=;
        b=b9zBFT4gV60ABLnctWyzzCBBtfC0buozh2D43daZBmRKfRwgGXt6IOFI5Ept0ZVKAg
         BVjCk73hML56dFXbOMWeC0839/alJYTdEc8BiEaEzZryvW0u7UFhIp5bumMaBMeAhJL7
         ulqNk/Ikzp65yx01NJ/4jHv/YS87Zha6YpTiR9sCNrpR63XZhwq+irLetuIRMYJsr6hx
         xyfpx8JjjmMg416JP9Jr15rfYGbWhnCeS1gZeuvZsOLSmq6hNiwRDzbKYIMOn1J7EIF7
         4WRuiuq5c7WmWKGHQIQFlp7tKjolB6HIs1a8zQGC9hcLAHjCDjwKc1HyjlTn+iwkMaVe
         FZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792032432; x=1792637232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=16GbWlEqbR86iNc8/Kds0QNYGdsCxKka1B+rvUYPHwU=;
        b=alYrNMbTGAn4h6GjCnfjZAc5bN4yK4FKVA3i/dv1gd3/EQ//gpDdqgo3DlPbaDarBG
         QA3jyaKMYgshFeCUFId8U7gJ/2AwwwPbUWpERF4pVmT/UiV38oUeZLoiJtOU9hsuXR1k
         xjwQW6/pb93JzmM6AyaTq9oLqkxKe/8BJCw3ebBp7f+RdzW6qCXD+TLy/+Ch3VjPQRKh
         HxjcCGwXr31ieyY9oqyU8O7l/GX1i57EkdcnRUbWG5vf0mARAp4KufsHnkKAY6tGP7Ug
         Lu2lI3um6AvSoV67C/pUyvrrDfXOUd5hjf8/R1UBDVHBO2P9OnBF+sYhM0Gmvy4YP+VP
         70Kw==
X-Forwarded-Encrypted: i=1; AKwUvBznWmZX65lrPYN5ixq01gqrrH2yvp487BNSTdn71dOKejlWlks+6ydQpIeqZAAtzxkXENkEGQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkO3Tx4WvFIzx6+g0JidLsl4OSwEYmQmRvV7/gwnVIBpM0NPTD
	8EE7Zo6bst0YY/ZRvmwuq8zkGy4+TJGszz4lmPamzO4QQ/7h0095JQOqIPC8S8lG+O1DPjxe9Aw
	Wq9UzcAr2obp6DoVxpr/lPHS17oWkgNI=
X-Gm-Gg: AYBFou2uj8W9/Bedv+cokMS47ZvBqJjugcMIwBM+fg+gMDEFbZJxq4eymGS6vk3Y3H6
	T9/2IKMylQHoP9ZUj2+vvYLtAtwchsXPZxJwrAV819Wc4A41DTJOKhdiocxFmZigr49VC23o3JE
	G5PzuVCAgc6cfxSMBb5nHdWykgHmwUOToyUi8ObgsjAjlmKbR2I6UTaZzMTpgH9VfwJLpp3LP4G
	C/V5axcd94YgpQR6/ad5W8Rd3LH1kHDl2Q5vWwbrN+StiNrleFLp9vBr9+GJ9EgUhWFW5Rrpwjy
	aIYAwS5VViGOVPO0IujrhdFBRbDza8ru9e2J4QIhMPXvD1yTUObx38nroBbVq6vKmIuBYU8ul4f
	3H95CyPRQ8/ryQvLaX9Y7ngL00cKFvk+Epx1Enau8kme3n+JojcvLAAtnh4kM8u3fVsWuWmnQUu
	ZQ5oG+358xHwy5SA76agS61gTfLIlFwj1DYcXJIBsfaxDL
X-Received: by 2002:a05:6102:418b:b0:7c3:2f13:d905 with SMTP id
 ada2fe7eead31-7cb3668b831mr6416805137.3.1792032432146; Wed, 14 Oct 2026
 19:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
 <871p9v4a1x.fsf@bootlin.com>
In-Reply-To: <871p9v4a1x.fsf@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 20:47:00 -0600
X-Gm-Features: AclHuK8WjfPBl-snALh8yjK0sT9hEMdsL68lGw63Y8O6sDBZaP8Ds_BfAoAdcJg
Message-ID: <CADvTj4oCVOBiY-55OJt3xFaOiBrFVixmK=AmTRt40iEisDSO2g@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] mtd: rawnand: sunxi: support the Allwinner
 randomized OOB format
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Masahiro Yamada <yamada.masahiro@socionext.com>, Boris Brezillon <bbrezillon@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 2:06=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi James,
>
> On 14/09/2026 at 15:09:46 -06, James Hilliard <james.hilliard1@gmail.com>=
 wrote:
>
> > Allwinner NAND firmware leaves the bad-block marker in the randomizer
> > data stream. On H6/H616 it also places all protected user data before t=
he
> > first ECC step. These choices differ from the mainline format, which
> > keeps the physical marker plain and maximizes the H6/H616 user-data are=
a.
>
> [...]
>
> > Assisted-by: Codex:gpt-6-astra
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
>
> I am sorry but I do not want to proceed further with this series.
>
> Even though I am not capable of finger pointing what is wrong in the
> diffs nor in the commit logs, I do not understand most of it. I cannot
> clearly explain why, but I have had a hard time trying to understand
> what the commits were doing.

I think I may have identified a substantial part of what made v6
difficult to follow. Format-specific handling was interspersed with the
PIO and DMA transfer paths, which also implemented similar ECC-result,
OOB retrieval and erased-chunk handling separately. Reviewing a change
required following those interactions across several functions.

v7 01/16, "mtd: rawnand: sunxi: centralize OOB handling" [0], separates
those responsibilities without changing behavior. The transfer functions
retain command sequencing, DMA ownership and randomizer control.
Per-chip OOB operations handle layout setup, marker transformation and
interpretation of completed reads. The existing formats share their
read-interpretation logic.

The Allwinner addition in v7 16/16, "mtd: rawnand: sunxi: support the
Allwinner randomized OOB format" [1], now has a clear boundary: its
layout and page-classification rules live in dedicated callbacks,
selected through the opt-in attach path. Its erased-page and bad-page
policy is separate from the existing formats' interpretation.

Common hardware helpers remain shared, but adding this format no longer
requires scattering format-specific branches through the PIO and DMA
sequencing. That should make both its behavior and the preservation of
existing behavior easier to review.

[0] https://lore.kernel.org/r/20261014-submit-sunxi-nand-vendor-oob-layout-=
v1-v7-1-5d3fc6ad2da1@gmail.com/
[1] https://lore.kernel.org/r/20261014-submit-sunxi-nand-vendor-oob-layout-=
v1-v7-16-5d3fc6ad2da1@gmail.com/

> The risk is that nobody would then be able
> to further maintain this driver and I am not willing to take that
> option. The kernel policy so far has been to ensure readability and
> maintainability, and my gut feeling is that this series is going
> sideways wrt this major constraint.
>
> Also, from a Linux kernel point of view, we generally just do not
> support vendor specific layouts. I already told so Richard Genoud back
> when he was working on H616.
>
> With this added to the pile, I prefer not to merge the entire series. I
> can still take some of the fixes if you feel like they would be relevant
> anyway. In which case I invite you to send a v7 with just the few fixes
> you think are actually relevant outside of the randomized layout
> support.

In v7 the behavior-preserving refactor comes first, followed by separate fi=
xes
and optimizations. Patches 1-14 do not depend on the binding and Allwinner
format in patches 15-16, so they can be considered independently.

>
> Thank you for your understanding,
> Miqu=C3=A8l
