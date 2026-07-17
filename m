Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB8372EF3
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303449; cv=none; b=OY/ypSTVPNvFn27q5AhfNzMmASlsTHGLAUu7cSJzd1XaYlZvYcFiXzG6o2DIQwyR7Vq3aj4uvbG/hOaR2MU2yj+d2x9Mr5RjKInqvYkeZ+nEQ5JWLe0jVDX3lJYfkF5k6YomY8f160UIn6AC9DxsDRFTwAkGCGTFydUmhDRjlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303449; c=relaxed/simple;
	bh=yWRh2ATa6DlWCmB29X6GEdezVqc0OLUGifFyAU50Xvk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G1BwW4/uSUMuLT9w6yGbDlWs5clWSJIFm7sQcD+ZJZs3Lao8STmkIPjvrtJVV/XQ7hwPSYDa5M/gmx9JIkKbltOYRaWQUfbvcHUpKQu7zvnw7wgvgIVlbk2/c8aF/Z4P3v/xavC2ALVLOOaum0+gyET/kS+GOhfE42yyKGnEIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LLJ8pPhy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LLJ8pPhy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 608A51A106A;
	Fri, 17 Jul 2026 15:50:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35F5260361;
	Fri, 17 Jul 2026 15:50:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AB3511BD091E;
	Fri, 17 Jul 2026 17:50:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784303445; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zHJZHOXUegGzTwvPHuKaTnOorkibtpxMhJXaYRbttLI=;
	b=LLJ8pPhy2IQAdaZDjmGTRfcdinAtyzSd5tGt7HBYzzMXRdLRaD4HipVVDKrdg1/HxUFDnk
	7TO7uBLWIipCbO+RgfWoDzN/FavUecAHUjSdGgLtsYPXTSWPCQtUnVWTVqgKKCYe1OYRLK
	Bbb/ezYaxdCqSPAfr1vWMsoMik3kOBpGz3VCkoTjeYEZnqKkSlrpmPJXUBLJBBae7hjWz6
	OUWO1svZmpxfSJtzAxshZHjJpPX58xzfIdotd3Ijc+v3E5VGAZrUTl5MIYI03di2pb+NDH
	AFXuru5JPz7Lbk3rPnYwz+QLZR+69JFP+ahBlfHICmvJtUQfwB797PxU/B/aHw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: raoxu <raoxu@uniontech.com>
Cc: richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <11D80ECD6F2BBA62+20260713052203.3130998-1-raoxu@uniontech.com>
References: <11D80ECD6F2BBA62+20260713052203.3130998-1-raoxu@uniontech.com>
Subject: Re: [PATCH] mtd: mtdoops: free page bitmap when the backing MTD is
 removed
Message-Id: <178430344401.4129650.3604183866653317016.b4-ty@bootlin.com>
Date: Fri, 17 Jul 2026 17:50:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 13 Jul 2026 13:22:03 +0800, raoxu wrote:
> mtdoops_notify_add() allocates oops_page_used when the configured MTD
> device is registered.  mtdoops_notify_remove() detaches from that device
> but leaves the bitmap allocated.  If the same MTD device is later
> registered again, the add path allocates a new bitmap and overwrites the
> old pointer, leaking one vmalloc allocation per remove/add cycle.
> 
> This is only visible when the backing MTD device can disappear and be
> registered again while mtdoops remains loaded, so the usual static MTD
> case does not expose it.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: mtdoops: free page bitmap when the backing MTD is removed
      commit: 956e7da12c114f13c63d126ab1d79c3b6a819060

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

