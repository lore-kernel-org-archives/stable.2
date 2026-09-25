Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103364AE107
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346536; cv=none; b=qo8BaxpW+veccfGenNYs/a8zunU99pmoeg6O10baUx1+AGz6zsIbfP2J4NJyi0jOniks+6vwVuV27DPaUjpY2N+RAVrsEPrBry8NtpTbo6rJ+yWSYinT+WYSiUoaHqyLNwRNjobeJBoHW3nJJAXUo2GgcUKpqLIvp2KgzgGOdCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346536; c=relaxed/simple;
	bh=vPABlXTvAHYs7re5yflf5KEOwi1Oo7wzBTr5T9fnK1U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n3hWJwYY0vy67eCQdx/po3vNVPfSVbGYDi3RC9wO4fLG2Klbew8rwtnUNx7HAdU9D4p6SyfN0F/vhIxFnXCElWojV/r9kbvJZ728aJMao0DOEEBZJPWyeBnm4YZ1h54PB33lHcmqw9rJIQIxAyN5xPIdh02YnyqlPbcKgByx7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gXZcrreV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gXZcrreV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 91BF21A101E;
	Fri, 25 Sep 2026 14:28:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65DDD6073B;
	Fri, 25 Sep 2026 14:28:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6F88102F08C8;
	Fri, 25 Sep 2026 16:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790346532; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FKzsy+CYXj4lbJ3LMsgqSQbf9iKfxj/uQZtvE+v+/n4=;
	b=gXZcrreVRlEjpngJOa2Yl3i0dkCM5F4NPD5I/aB+IuRzRf6Nhq0HF9cri+/gqhN1gvOXtg
	bL2sfg2mVWhVb24UAO9w4iLLbOfKmW0R+U8vqjlMIPSISI3n5CAJ0rDO+A5+iQt3OTMC12
	P1ZxqWArLYb3MEcs2uyDDx4uQtyIEipYxFXlO5AV9hLrjfvLMZs7LIESRyoTRsqNJSn3fn
	K2X4jE/dMnk2I0vQJF0IK77ABAFCElGexeELa6Vq0TwhPrJeYs4nvWtzKfixGMs/ZrigRh
	2ZsyhbM/x1ltcqCwHGcZoTvjqrnNH1/CJX65qg0Qxmw/BY8eCAh6w8NTjF+C/w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: dhowells@redhat.com, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 richard@nod.at, vigneshr@ti.com, viro@zeniv.linux.org.uk, 
 stable@vger.kernel.org
In-Reply-To: <20260917102550.2146806-1-vulab@iscas.ac.cn>
References: <20260917102550.2146806-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: mtdsuper: Fix MTD device reference leak in
 mtd_get_sb()
Message-Id: <179034653062.1166139.3563266165640465080.b4-ty@bootlin.com>
Date: Fri, 25 Sep 2026 16:28:50 +0200
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

On Thu, 17 Sep 2026 10:25:50 +0000, Wentao Liang wrote:
> mtd_get_sb() is called with a reference to the MTD device already
> taken by the caller.  When sget_dev() fails, the function returns the
> error without dropping that reference, so the device is never released
> and its refcount never reaches zero.  Every mount attempt on an MTD
> device whose superblock cannot be set up leaks a reference.
> 
> Restore the put_mtd_device() that the fs_context conversion dropped on
> this path.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()
      commit: 62ee3da38f41bef83c1cf250f6816a0ee187674b

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

