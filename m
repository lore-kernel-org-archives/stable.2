Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA646C849
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807932; cv=none; b=KvOa7zU9K6XLp+eqTdi5QKio8NidNeUTu1gNChae3+rR5ZbgPorAqcAivYvroTb+IZtma0lAAxgeJq+vr2lY+522+P4QevMCyPctzS2pgAEqf4kxiLqMVUKo6Dk173Y2WzpUBlXSI8vmBTeIVFr7Ikkqx9ltPRr/FJMhXVquVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807932; c=relaxed/simple;
	bh=+tyotRnLu0g1WmKLBehpS2t6CZeerzYl834hP2cfgEc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrKyFIWdLMFIlkkcIJOctSiTfbjhgXetaEKASGJAcCO1gTNXT4eIAjraU33on5aUV1pn1XoUoLaYDv4egb0haMAuqmN5Mq5s3A61MkyDThvHAM6dE/O4AAiPJcpMri8PgQdpZSQyArQeR+8Ji21tcj5UnsAZHr3CdxthR8C3p/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pNbs+mro; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pNbs+mro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791807929; x=1792067129;
	bh=+tyotRnLu0g1WmKLBehpS2t6CZeerzYl834hP2cfgEc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pNbs+mroBU1EfxQM4PN714I20bY8vpLfcS2CEjISbdafyXfP/3O/Es8PIYe0b6KXe
	 NPb3JESJz/6pif7ltkKeZghh/H3OmVBr/bP3GsrfIYLZjMxHuUIq+xykYzgbf8r6vX
	 miIGka/pZYahCX80u3MgkSrIJSBmNGgHfDscejeXJ+lvz5ret6CRjbhPXrEV8REL9z
	 zj/nOukLRh9HleN0ScHRR6BBOLA1HbjxoUVsIszX/fyJ23ihNoU/0s8bVFzyX8VEh2
	 kmSIEHBx99GwbzeY2bJtdK2WKc7XrCqJTmUXkU8eDESxZzVP78QbACiy9SmOk4SRAO
	 qUh6mdAZQgNmg==
Date: Mon, 12 Oct 2026 12:25:25 +0000
To: Thorsten Leemhuis <regressions@leemhuis.info>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2] i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL
Message-ID: <179180792331.14777.16389002783262980921@pm.me>
In-Reply-To: <a64dc5d0-eb09-4482-b8b3-16d8d015e2bc@leemhuis.info>
References: <179173732257.29426.7905170638383807320@pm.me> <a64dc5d0-eb09-4482-b8b3-16d8d015e2bc@leemhuis.info>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: b5b7e05147e20ddb6d3421be287e44ac8c51055b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/26 09:07, Thorsten Leemhuis wrote:
> Not my area of expertise, but from a quick look it sounds a lot like
> this will be fixed by this with will likely be fast-tracked to stable
> once mainlined:
>
> i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
> https://lore.kernel.org/all/20260929041444.9837-1-daniel@quora.org/
>
> Could you take a closer look please and maybe even confirm?

It is the same problem, and that patch fixes it here. Thanks for the
pointer, I had not found that thread.

With the 7.2.9 driver plus the patch the keyboard, touchpad and
touchscreen of this laptop work again. I have sent a Tested-by to that
thread.

#regzbot monitor: https://lore.kernel.org/r/20260929041444.9837-1-daniel@qu=
ora.org/

Thanks,
Birk

