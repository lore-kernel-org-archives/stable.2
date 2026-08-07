Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05238947F;
	Fri,  7 Aug 2026 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111139; cv=none; b=ZInRs1+r51HO0GZVPMIHOu16PTOJ8AYzscBIr3og1XDuzZg1uzefnR4YIC1hwIHJD9qC5/6HDuOU/7Iasym1+qGsKr8Jd3BN9bQrmQZaysnn+I73NMrln2dMc3euv6S22wotVGcifCGVNYis6PAd26q80nmE1RwqAhKueioX8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111139; c=relaxed/simple;
	bh=ga9YwrOPByLdYiHYo8H6DvEk34V4v2367x//laxUrRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SqVQd8WnWz77yqKnI+GskovTkyDW0ZScMwyvKa9t7FeVXKcNlYJSc124Zce/8IF4UwW84mILXVGnC7Uw2Lq9fWJ6263gP6srDtCGTxT6V2w4NQD33VdBUJwcRvPqr3Kyt2Mp0pDzDniG6Y70eCUwPRZzCSKsC5MYZ4hTjT6saCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ScjCdzgX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ScjCdzgX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A7C124E4113A;
	Fri,  7 Aug 2026 13:58:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C544603F0;
	Fri,  7 Aug 2026 13:58:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A28C11C37949;
	Fri,  7 Aug 2026 15:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786111128; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ga9YwrOPByLdYiHYo8H6DvEk34V4v2367x//laxUrRs=;
	b=ScjCdzgXo+20f1TJ6yi9Y/gKNAsJXE1WMAzB6zofImyQULjEyDv5RGjTT33PlmgCknlKbS
	VJSaztZ959rp0Y7HWX9dRfOBnoycM+h5mLttSH99O4Vv5pymAx8bXhTBppiznhFVqOvQyF
	YzaOojK9GvGdrS+wNZEmdWMausOaHCKSaVsTsUC9udre0NzV5UMqu4NyqmFt6Cngzb0JYq
	06vrCjL1Wp4j/LwTVG/wwMtxZmQXRgKbrzpKdNFC9Wh2fj+On6LT39EgskXzsYwQu5m8Ax
	nuRQ1dDgw5P2o60WVuWk6wasqhQa9V9IKYH2LBTIfRFDfupQVAzfR3uDMSfjHA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Chen-Yu Tsai <wens@kernel.org>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Samuel Holland <samuel@sholland.org>,
  Richard Genoud <richard.genoud@bootlin.com>,
  linux-mtd@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mtd: rawnand: sunxi: fix H6/H616 controller timings
In-Reply-To: <20260717-submit-sunxi-nand-h6-h616-timings-v2-0-225515107640@gmail.com>
	(James Hilliard's message of "Fri, 17 Jul 2026 11:33:56 -0600")
References: <20260717-submit-sunxi-nand-h6-h616-timings-v2-0-225515107640@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 07 Aug 2026 15:58:46 +0200
Message-ID: <87ik5mav6x.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi James,

On 17/07/2026 at 11:33:56 -06, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> The sunxi NAND timing solver currently applies the original A10 NDFC
> timing characteristics to every supported controller. The H6/H616 NDFC
> uses two internal cycles for several setup and hold intervals and has
> different delay-field encodings, so the resulting clock and timing
> register values do not match the hardware.
>
> Prepare for per-controller timing data in two behaviorally focused
> patches, then add and select the H616 characteristics in the final fix.
> Legacy controllers retain their existing setup-cycle behavior and delay
> encodings.
>
> Tested on an H616 board with Toshiba TC58NVG1S3H NAND.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

There are a number of checkpatch issue. Can you please fix them? (except
the camelcase one which is fine with timing names coming from the ONFI
spec).

Thanks,
Miqu=C3=A8l
