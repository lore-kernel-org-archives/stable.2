Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066863822B1
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751501; cv=none; b=j3hzsmdlHqmZOknzkFeRKPJH4Do1C9O4kifqWGTO4KjTEMhQe+R0JmmBALm+CVIdwzt3LFCLMIjIK1cBQ8vwYO8PSHPTR10YuA+dk3FmWfiWcIDs1ncrv9udakzRTpY2wMsJZgGebbB1BbDDoyeUqqHxGJ1IzLVIvllLPoRTyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751501; c=relaxed/simple;
	bh=WiFLA9yIsaSjQGO65uy6XMFgjvqF6C0O48KGPGR5IAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9Xj5LpFFOSPzU8dWun3AtOLzcpMgLAy4af+eScNKu1+bYajTpcxQPgCLLD3JF/i5OF16EknE7McqbizPOP6NamYkk9i2BX96eQ91GeOxuVJOTK2V8HoXCH9fTqeouTt4Qbp2eddQLtUJoSHt+WirQ1iQIUMII0tBzNilHG+ILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRj+pyzO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRj+pyzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE94D1F00ACF
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787751499;
	bh=HfM5lr2mL1q2WkP1E6zRu0ypWHQyXIJSTRAPogksnNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FRj+pyzOdWz50U+YouP9GmUDlZvJJz+FgLpyjThjuQWjtQBb7Sra2hdnih6Cc3az6
	 gi5ZwjBQBk8l7LX8Wb4L69ZOHlJ35q2spINLOYQkiFC+9FsQeUGffEcw/EiF+c50hu
	 reaft2BNafxxgm/UETpsOXvueWvq3xteVDEW83UVuFZURD0OOdjftZcoZqe/ffUmwe
	 2EtzYmbzZ7AjNYvmJjxvwSLakpHE/qogggnxdcGVD4bxkKORtjHXKIrPASZsZ6E6Wd
	 wh8ybkWwerxijQhgRzDkynw26ZLTLCbXtF5B8YoytUtjoO8I2mnIWuNrVk3P7NRtVm
	 b3n9hw0Hwv5Ww==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aec201b582so932653e87.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:38:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr8kxvp4NqBIxSNKQr5rYuucXX9/IL6GQf5j+8XnmmDqmHvARDd+3tcuw7TtZrs2VgCLXsfTWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mtsdYyHbfuVXmgW84ZQf+IxSgAhzm1byZ9a/LqOwaM5RDvPlmx
	KUQ/OU4UKaxtgZMrWN7EYJqHOaG97X+bq7yypcDnCWykgr8uiX8uAhg76/zviMzbVwb0PcIWxfT
	CqlbCarhwkYlDqarB3Y8n39noU8ieZczTbCIRdiR8/w==
X-Received: by 2002:a19:5507:0:b0:5ae:bbd3:27e3 with SMTP id
 2adb3069b0e04-5b4a900a129mr1469735e87.5.1787751498522; Wed, 26 Aug 2026
 06:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819152356.904023-1-shengchao.guo@oss.qualcomm.com>
 <000076bd-b3fd-42dc-bd43-96ee9492a638@oss.qualcomm.com> <aoZVKWTtdCQSSvaH@QCOM-aGQu4IUr3Y>
 <06acd175-0078-43ce-ae58-567005f62562@oss.qualcomm.com>
In-Reply-To: <06acd175-0078-43ce-ae58-567005f62562@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 26 Aug 2026 15:38:05 +0200
X-Gmail-Original-Message-ID: <CAMRc=Meb72v3wJ+BB8ujjD-bxaCLuqWC+JFgmrz09BY5LZSuXg@mail.gmail.com>
X-Gm-Features: AcwNN1UiDy7IM184TnRcFe0sRHIgizvqFCHfyw15xidHEhJx8LfFXXFO4tCjMnU
Message-ID: <CAMRc=Meb72v3wJ+BB8ujjD-bxaCLuqWC+JFgmrz09BY5LZSuXg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: nord: Split QUP1 SE2/SE3 into lane-pair functions
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Shawn Guo <shengchao.guo@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:44=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 8/20/26 3:15 AM, Shawn Guo wrote:
> > On Wed, Aug 19, 2026 at 05:27:34PM +0200, Konrad Dybcio wrote:
> >> On 8/19/26 5:23 PM, Shawn Guo wrote:
> >>> QUP1 SE2 and SE3 pack all four of their lanes pair-wise onto only two
> >>> pins each: lanes 0/1 (I2C SDA/SCL) at mux value 2 and lanes 2/3 (UART
> >>> TX/RX) at mux value 1, on gpio127/gpio128 and gpio129/gpio130
> >>> respectively.
> >>
> >> [...]
> >>
> >>> +   msm_mux_qup1_se2_01,
> >>
> >> other drivers where this is necessary stick an 'l' before the
> >> lane indices, e.g. se2_l2, let's keep this
> >
> > I can see that for single lane function. But for lane-pair function,
> > it's not a new thing with nord, and the naming convention seems to be
> > without 'l', based on what I see from shikra, eliza, hawi and maili
> > drivers.
>
> Hm, seems like that happened by oversight, but yeah let's stick to it
> now.
>
> >> The bindings change must be separate
> >
> > I understand that's mandatory for new feature changes, but for such
> > a bug fix where both binding and driver changes are closely coupled,
> > it seems more reasonable to not split.
>
> Up to brgl
>

I'm fine with this. Krzyszof, Rob, Conor: any objections?

Thanks,
Bartosz
