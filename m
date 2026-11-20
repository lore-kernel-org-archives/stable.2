Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187040;
	b=bwxpgupXqqmlPOva0gQWeZtdQ3qeY20PisVSzyYB3sZjkrF7Nfrb+L+0J0yMBrhIssXD
	 U1idOp8nWoaNnz6Nrps9xVDnvwNBwtwPL8byPdlEJ6bSSSvmp/ZinpI7g20s3BMT3yPsb
	 +yJth/esi9fm4drFJ0mttd0pymxDDVWj8vVIL+k9pvKfPRITeeid7Upb+ZAWBKn0YC1GG
	 +gVrY0Ta+3fb8GXeN7Ojk5t1G22vDxy3HbIjN4wDinRdJikMLFlUb9OZUuhjRM1CGdkxI
	 +KdLip4f1EyBpwLCY+IL1pmt/XKOHfz70Ew1mNPEYZNcmt5k9fxOcl2zZtBqQwCZDcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187040;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=nOuVgZq6Hoapw7L/D5ylHIq8Pkp+9ypRHxYDY/1QJPg=;
	b=x8j43usYAH+37s8+WUKhvwj/QT2uwV2DTshP+GXUDOTOp8FsEACCXxf5IR9NOOIGxpZU
	 cPji/LbBD2xJNxJl++i+ZhEm8tQyd6jFbnDJE+JLgQjN5egFId/LjYq4MAo1yxGW8J8Ky
	 vlUXrfINONPJwwH3mRoyRgpr+9bH1XFhMPA26mdz7/5aAIyVw+Axs+BDwn+/XZ2xLfrSu
	 5pjgtRQQ1mj7op7LkFkyrty21dLw3Y2yQQIJJzU3YuhI7Nxr1N4Qe+53xHxudQ46Hb4aD
	 ExLROLL5/UKdSLlQjC2CRs48KEhdpZrVE1ihEmdfzyIH7nm96YXDtVjL9BvQUWjimDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mPhrbuKg;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98B606A330
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B98B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mPhrbuKg
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4203E1A174E;
	Fri, 20 Nov 2026 15:03:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1719B601B9;
	Fri, 20 Nov 2026 15:03:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 996E211BC02D2;
	Fri, 20 Nov 2026 16:03:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795187032; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nOuVgZq6Hoapw7L/D5ylHIq8Pkp+9ypRHxYDY/1QJPg=;
	b=mPhrbuKgkGFfVq1M+FbaSdJNag8+QMHghjsqZt1xBr+JSbTyJbmRizNcemC1hdW7PrwiFo
	WP/wojGAB/Zf+e+mFgQB+urYvFAnZlVlICelhyWemfGFuu2yZV0N7X3cQgjOs2hQLLgOlW
	iHBdI/vYsUVY2YNmMw5ULtLnu2+lt4KYDv/eQvSAg1pqV/QE/9vEvMM8m4Qhjar3ubDuvo
	y+fEYGsrkXhDaTEnooWdnXvYipsXmQoLZpKcDO8/4fxenAEFjI7ZxUzctGmOqST0TUQ+6s
	GaT7fMt6QPaxwSAzSoFTvyxU/a3nQ/FaNmuJIx6v6jE7/2niftHYZcKITa/u2g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Artem Bityutskiy <dedekind1@gmail.com>, 
 Manuel Lauss <manuel.lauss@googlemail.com>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Thomas Fourier <fourier.thomas@gmail.com>, stable@vger.kernel.org
In-Reply-To: <20261108-submit-au1550nd-resource-claim-v1-v1-1-8f4c694fdd39@gmail.com>
References: <20261108-submit-au1550nd-resource-claim-v1-v1-1-8f4c694fdd39@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: au1550nd: fix the memory reservation
 check
Message-Id: <179518703043.3404688.7884533552313535041.b4-ty@bootlin.com>
Date: Fri, 20 Nov 2026 16:03:50 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 08 Nov 2026 13:55:11 -0700, James Hilliard wrote:
> request_mem_region() returns a non-NULL pointer on success. The inverted
> check rejects a successful reservation without releasing it, and proceeds
> to map the NAND registers when the reservation actually failed.
> 
> Reject a NULL result so probe proceeds only after claiming the resource.
> 
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: au1550nd: fix the memory reservation check
      commit: ba3893473491d9810f1dae8ddef38d9d487d630f

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

