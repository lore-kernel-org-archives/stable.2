Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D236C588
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303446; cv=none; b=NISQRvaqjDqzy5UtAl87ghM6g5DYa9tgwbVDAV7HPCFgfHdCuIPrPcyO61EGf69CDFO1fI+57U1ujIbeHbrDyXQswKdE38XG7PTH3ItifEN4oWwXo3nAvkUpNfqvjDsYZNR97UwwgE+YL3zZPrSMDy1QKkjQezs8VTQ7CsF8N7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303446; c=relaxed/simple;
	bh=UR5X8ev+sXvoh4DWo0AfCRUwK+rVOYInYW98Q8YiFq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fxvC3ZxwUs39CjYlG4v/e06xu1SA3Rp+qxomav2KvtRPerFVfnLM08+Oa4dPSwZP49R3BT0IkbFkjsG2Sk+3tfwCEKopuPc35s0HPRw4S+6GW4gPm6yWw9OlEueFHHhernut8wCpiaMujbdoTCGy/C3lbDqjkSXXZLb0MopSEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lNchfynB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lNchfynB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4DFF91A106A;
	Fri, 17 Jul 2026 15:50:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22A3C60361;
	Fri, 17 Jul 2026 15:50:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B73511BD0B3F;
	Fri, 17 Jul 2026 17:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784303442; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9QEdUhXnOpkNw6m+PIHAktD3+IAu3Yyyek4pNRP4oFQ=;
	b=lNchfynBlEDqyTPM5NTF2tbmVqQ5kfwOLr8rHEOQGIqqXgsf1lnkwmVKFMLfArm6UzMv2k
	o5ChZav4CR9bs/h9OBLkM46FtzJns2lmnzaGBHkSC9Lwi8HQzulQ70JUey+18DT3Ny9IeJ
	jEzX3Bi9iRANZr/J+xwpeeNAd4PZSrjN0LMfJ9n99Y+b9UqUunGAtR83zhkz1oHs5hbNzq
	p1RIiYy6iqMhDk00OiYnifStrK4EaawxB5CQxkYVXYDAT8/JD7aVYY/zcg/yii+vDYUyvG
	BeAfEbDtCjamMzjr8TCGQUrhlak+QS8z1snYnJhg18dhdDtHii1HPp/FDhqxvg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Linus Walleij <linusw@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260708014906.1463-1-pengpeng@iscas.ac.cn>
References: <20260708014906.1463-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2 RESEND] mtd: afs: validate v2 image info bounds
Message-Id: <178430344123.4129650.17126577356118122779.b4-ty@bootlin.com>
Date: Fri, 17 Jul 2026 17:50:41 +0200
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

On Wed, 08 Jul 2026 09:49:06 +0800, Pengpeng Hou wrote:
> The AFS v2 parser uses footer[8] to locate the image information block
> inside the current erase block, then uses the image information
> region_count to walk entries from a fixed local array. The footer offset
> and region count come from flash contents and are not checked against the
> erase block or the local image-info array before use.
> 
> Reject v2 entries whose image information offset would underflow the
> erase block calculation, and reject region counts that cannot fit in the
> local image-info array before walking region entries.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: afs: validate v2 image info bounds
      commit: e9290031f736e99ad17c25c00311c92c266843b7

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

