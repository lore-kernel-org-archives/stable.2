Received: from sonic308-56.consmr.mail.ne1.yahoo.com (sonic308-56.consmr.mail.ne1.yahoo.com [66.163.187.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD283B27DB
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399471; cv=none; b=MgWOxwSVXWl5WkcNegyhV8N364ijAa2db8mJIVq2ueZSsQSsFIP5hcGEnmoDbp4/y9i0I8b/pnpoubS/KrVHjJhLYT4EFcJ5kH8+qW1tYnSLJSH1xxknTCTzNdORcC9j94WZDakl2KFSsjSbVBu5ZnHtFGZ6/GXYac96zRx94VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399471; c=relaxed/simple;
	bh=s4Wa0qWjE6AXVdv0c07yVbuoJbOretYa3cy6R6vDmBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAfxnEGh/tary/nQhqocZS0YZi/j8eDxByjHtSMssJ+ZvLwWvXAmbNbxCrQWZLeqV8UefdaVscv79IMFdT0SiUYhT0U7+AiJa5Yxy2qqSeojbDuvnbG7xjuKQo5kaLopuM25UA9khz8L3cGLKFKfHbe8XTrwc0tSElR3DNddMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Mftj8Xoi; arc=none smtp.client-ip=66.163.187.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Mftj8Xoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787399468; bh=s4Wa0qWjE6AXVdv0c07yVbuoJbOretYa3cy6R6vDmBg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Mftj8XoiwjUMux554hqRkf7T1wliS1ItsWLWFLrIvWrEWGaY2wmqZAtseHXv/t5UFOcb1PvmuHcIy6h9P6+i/AWhTVz31QRV4fU9o0Olr4J+2ClA6KHmT+wZ2OBUstuUJtvsPHhzFFOpBP7QzvUIZmZ5UQzM/lMD6ViHQGMMLf6/PgfEJLPJci3lQvqKhNDuXnm6ALQNo8rq5V5Mcg6RorPoVxK00dHptt8UEZrW2wd/s+F741B2YuuAATvMi7ZVfH+FCGhbh+RcqK53lUWmPxxMJYFpvzinJCvy7cvEnyJtDQXkGBpi79J0CPHLkCWoCk6quj1q6n8xC5+y2B7VCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787399468; bh=dC4Q45ptksuTNzmKKAylXM1k7x7EW25lnPbE/bmLC13=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=au2iJuL9ZUDv6zowniTp1R33GrTe7LVc/4/eCCetVFOYFpHFg4+SNYoEe8LJo5h048RbtjRqOKiBNPdu+IPIC10ZQdBNjmw8o33vPRICY3ehj18XkK5uei2t4bOJVhDxjNhLCGNqA/FpJLV9DdLrtMnLV0ijSLQMEEDMN8bY0I60efHZCF91Tw9SDdJEtSJjrGrhjc8yAJQCHgZU69tKU5AKohipXWH1KKC7PCdRdbhRc0cdwXwD0kHyHhEm6i9OVeDyDk5a1gzrJwxSivXGuxmk3JN+0mLmMeFjtEzUNKOpqA8HBUzqbl/aZowikdRaoR8oSbp/0AGepkIgMyF02w==
X-YMail-OSG: dsIeJhoVM1lHJZPUUvoNlnZ0qVZ8ALlP8UZRvcddlcOM1KWfx063_B50xgy_dXe
 zup2O1KAqs.klqN8wWJnwO.0KGHJfCZCsNAdfnmxRexgXN6r400ZV6ZZps9PCCY_JOUsR.r79tQi
 M2.2mCAWuwtqhsp2tNU6HFiQbNppyL3xsAQ9JsrndyjMcHh88HdPHkdeRGnfhQ7.7FhuMMlrA7kq
 5VMdp.0u7CNQERpORPP7nMB1DWnR.k81ZBnGV7lCM5a90W0oG_KqK8yPwnusRVeIhJoRztFFNPbo
 _cAA0F85Ar9ENJOOFBpPJ15mIKL84y5cpkaGZSbM3V1rgqPgvGXi3pj66eyqiVEHWz5Bwn4oZA_j
 VQu8Iuj2RaKh4ZHWVFMo_p9vW6POz5Z0qJ40HUfGQnGwl6l8Z9fvENhwTyIGgDB7Z6ZFaex.Wacv
 UcsgA72YvOn4e2NIcWAnTH9zzTziW1t_af_KhVGf4uWh85rqiNwcNZWDcy7zcOgTqPHc1Zryw1ru
 dv8zq_sKlm9eWlPCNwhBn9rX8Jn6PaHD.90Dak7AlkXzUctaa8UWNfVS8qh20lbUyw9HJSseIs6Q
 7nviZl_JgvyiCJsIl98Nn91iWNdgGKwYKKZrgzQse59C3mAgFop9h_wgtrRLbRz8Q.FbrjiRP9P3
 l53DpXxzBmYjDYSlPsHxlaH9pK_LQLExh7S7kIBqpysA9wMDthrYSqychPYm7tk_PTUiIT3sXRq_
 _426Ljcxda5bqnY_1GHHD99.7egU9JnUG7AVzavoTjmuKVg._t9JDn2U4DvJWM.6.3W3Cn15oiDH
 QI8g4gIYedmNIcYnz4PBqv7GrN.jJNvzbI1DnF5EiqvaY5GIXbpMemeH6etzoXr7fou1QUI_Oj6f
 KTN.us9MW7NAbfWqPEdMqetw74EZKKQ9mQSXJ6W5jT6gObwednntSCj6O0CoLtpoQpsRLrifLj4_
 ST8wfYTP30ejxr2T56nsbzWfIY0FYdAYPiPYGpy1.m1x1XVMkFnl1Zub28yoTFNhXJektJX74E7S
 OdH.abXNdMh6LZumC2ET9z1L7dvsbn6DMyFI8QDEKz.oJJpUm1sDdm.rZf8kpCvOn1HhH5TiOUOu
 QmrFCeWZvHOScxLGYkE6LADtIgbtT5hEkGtkg17lJeZ287kWt5uNtNQn9NYfSw9hEx3R5U4vcR2_
 nCZrn6sYhrUf616Bp8mGfCakNY95JqUkllCsS5hnjLSLoFja9y34KXmjpvITvvdzh21zh0Se9lS7
 Yg5FPkCs2s5omhBmcytLovO54XD_TUzmgDMfew9jLsl53IeSGXbT_kcrjRUrHPWLJFBMyOADcyah
 RoxCMt1feTE0TLa0sJJGFQACX7bzZL8KL3ZXseMWVFRiFyf5TRH0XB5p9WZqSIrJo4SkRKQuZ4WA
 3bSFtdhjr4fe.nSPhdsvBE9rzeAYoVH8NlN5WNuieMkrYP1kjclDtBU.A9L8xq7nQrLSNGoS_5g5
 jbeCE0DF4_w8emc_Rv32De0MCFORlgZeJo0coMMR_.2NCYZ9ug4GoF95V8Byhvt9AyJuGSIcgHao
 l0G44OSG02BAbN_hu5p.mawA_nTcXKUxbzXMpBOo5GmJpYDgUrb7VCn7FsfAHLlrYkWh2kip30P6
 eq2vuUb35wLyY14_HLW5X2rgGJ.tzs52d.cQmphEpmR_ExPayVY6AI_QDU4ZdZhgiGpyfTKeSL3j
 enhEypHhgFLydw2Wyv7yPnxW5u5_hn4pbxz_7OdjHC.pNwZE1SrTWH5W1AARNV2DwqTcDzZlgpe2
 j7t.VHFYXcd3XBnuPpuJwL11jc6cn7HsmOp5gZRJzVdelbARsuMVdmv0RHJAnxfqfCAyvZtFBVGk
 gimZxoiWJuSws5WS3XF07JpYuVDrBpgmSIxpks4E08ZSB_RcG_8O_imgHGgOqERhobMGipQMqRBX
 2eKkc8.WOTX4c_qEBCEiBozLm2cLt9mepkXps.MIpNPhg8e_VHS5Y6VrXzJDNVjL4VZjVICU9xpI
 QMCXIW0rruoei5v0TyGqEg61zht0cYHb9X2djXSXJf7xA5DyvWzAsn2BuPQJs2II6JZ_c5okr3so
 Q56rRtPraMc5_dNNUSAgPUqyf9eFCBg.g1MK5Pcj4p5Ssb_N3NffqOqlgYPBZl7ciE9lRmAEG_N7
 piy4EN0Ctb8vLXsro7jwvmIOOewBapg5tiRwHan2YDPdo3Eie7uhxQPF3MHRXFRVUGmaTn3pmbGc
 4FHg6Hhy8jZClbZKk9lBnI1qMwCJ6HD_TQOcnaO_8L73ilnc7goZk15gXDJjEnP1c7DbJ27Hf6oo
 ecszofmeMttpuIy2ofA9nOCGhk4orX326NQ--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 8f0b58d9-8ade-450f-86f8-2ca7c74bfa99
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sat, 22 Aug 2026 11:51:08 +0000
Received: by hermes--production-ir2-cddf86dcf-wdr5c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d9e6700a592f300a4cd05ef193b7d1cf;
          Sat, 22 Aug 2026 11:19:50 +0000 (UTC)
Message-ID: <8286b42e-0314-477b-ac2e-4b410a97d833@yahoo.com>
Date: Sat, 22 Aug 2026 13:19:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks
 enabled
To: Jie Luo <jie.luo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Stanislaw Pal <kuncy7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Brian Masney <bmasney@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260730191353.557494-1-kuncy7@gmail.com>
 <aeeeebf9-dbd4-4f57-847a-5f495b3236a2@oss.qualcomm.com>
 <20260803091003.15285-1-kuncy7@gmail.com>
 <8af46926-fecc-4396-973e-2290ae285998@oss.qualcomm.com>
 <cd5a25ed-76a3-4f1f-b924-06bb685ff426@oss.qualcomm.com>
 <181944c2-2484-4384-9c91-45cc87f31955@oss.qualcomm.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <181944c2-2484-4384-9c91-45cc87f31955@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26380 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Thu, Aug 20, 2026 at 01:39:52PM +0800, Jie Luo wrote:
> The CMN PLL output clocks do not depend on the AHB or SYS clocks. They
> continue to operate correctly at the fixed rates even when the AHB
> and SYS clocks are disabled.

The PLL outputs keep running, but the AHB register interface does not.
Once autosuspend gates AHB/SYS, any later register access to the CMN
block hangs the bus. That is the bug we are fixing.

> On IPQ5018, the CMN PLL provides a 50 MHz output clock that is used as
> the reference clock for the connected Ethernet device.

Correct, and that consumer is hardwired in silicon — the internal GE
PHY and uniphy blocks take proxied this clock without any Linux driver
calling clk_get() on it. Therefore no device link exists to keep the
provider active, and CCF rightfully gates the bus clocks after probe.

Adding DT consumers would require touching PHY and datapath drivers
across multiple subsystems just to create artificial clk references.
That is not a stable material. The v4 driver fix is minimal, correct,
and self-contained.

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

