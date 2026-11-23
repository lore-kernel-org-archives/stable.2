Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432050;
	b=PC4MDNk93WLLILJ8tNK6no9gMfcuEVfknnbaFxPXOHkOMhPPlXxsPEEe1wJGvIXXUl77
	 LtjYsCKGJIZsbZVH1JaQ9pyiP3Tw0PHTZjcBTKdh6tSd2Uzws0kK9g4aWOzDrhQOD70zI
	 ZQortkF1GN2amKLwl+h9abm4N5Uuy5r8q+BSqom1w9FLRvWh97LM+dkvM2mUnU5HwPskq
	 B2W6ao7na7dTsX8JhD323NaB7T+Kn2Nw7wK43fHFm53xGy8jXGFmU3qhogvWviW6J/dr+
	 JDqHTPfxan4CF4zYZ/0VwiLw4LyHzaucY/1h6LE2pTmgu+qLFDO1b88Xn2153KUOt7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432050;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:To:From:
	 Subject:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=6pR8SSegYg1KVe2AG81HovfC0ggHBRsxnqfkLUlHYho=;
	b=MM9ZJm+Yc1iZ3LSaBwvF9tMlvDuLjE8Ct7Y7US/AMSN/dpQGXt8vFQcscNb6tHrCjI4A
	 bpOv3U+/iuE+dcg3zaP5d9aC9DDLNjR7bSKfxrVfAWV9RXBPROFO3hS+tLMp53yeL82og
	 sb/3mKuiyDS1T3OJPt34dR1ApdOlGIEcaCgAbDZky4hh1643b2hF9A8uXy1nGRxcMzl1+
	 uGQXtXaLklsTfjneCwpB9RHLV3S2W7Nw8ZZNBZBjrrGwvrglbPxHXfCgrE16xZoy8ZOw+
	 tSItoxTRH4H5WwNXQwYxLEEYVk9W3PtFhQcp1KQqtADoEwAVYJgSRV8ZLe0q1f5dFBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0KB7+wZ5;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60986606A6B9;
	Mon, 23 Nov 2026 11:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60986606A6B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0KB7+wZ5
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 20A1BC69149;
	Mon, 23 Nov 2026 11:07:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 26A395FAEB;
	Mon, 23 Nov 2026 11:07:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A070F11E68321;
	Mon, 23 Nov 2026 12:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795432045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6pR8SSegYg1KVe2AG81HovfC0ggHBRsxnqfkLUlHYho=;
	b=0KB7+wZ55Ik74gigHduK29oowjMSoJnPIDU2lWOL4NJ24CeNXqNY1P8tEoZ1hRzXAiMYSI
	6ADnL6f/pMSLVh152j/UqF92+bJaMEIagBBl5Kyuvldc4rBvKTS39wB/e9MlN4K10Sn/gf
	fgxfiyxtOuu+Fhh79wX6MXzvSzZcTAYs1+Hc8oSp+nqGH/6AJSHScj1WZ310IFds2SDvLF
	Ry8y9BXpEXPglXsvB5IQkkhmxq/OYfmiqxRParwF/HKa9sOBn6Vl+QCvafiZdUvC2VYd2B
	u+mi5aVSC5HpKYcmuJGZsG5fMhE1wM5uolJTBicL1inXTRotS3SWIA8fNtm/XQ==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 12:07:21 +0100
Message-Id: <DN2JJHBVAPCY.2CNUCGCO781D6@bootlin.com>
Cc: "Roger Quadros" <rogerq@kernel.org>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Guomin chen" <chenguoming88s@gmail.com>, "Peter Chen"
 <peter.chen@kernel.org>, "Pawel Laszczak" <pawell@cadence.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4] usb: cdns3: fix NULL dereference in
 cdns_host_resume()
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261123044347.3273-1-chenguoming88s@gmail.com>
 <20261123075116.3868-1-chenguoming88s@gmail.com>
In-Reply-To: <20261123075116.3868-1-chenguoming88s@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Guomin,

On Mon Nov 23, 2026 at 8:51 AM CET, Guomin chen wrote:
> From: Guoming Chen <chenguoming88s@gmail.com>
>
> cdns_host_resume() assumes that the xhci-hcd child is bound and passes
> platform_get_drvdata() to hcd_to_xhci_priv() unchecked.  The child is
> created by __cdns_host_init(), but xhci-plat probes it only when it
> registers; cdns3/ precedes host/ in drivers/usb/Makefile, so with both
> built in the child is registered before xhci-plat's initcall runs, and
> with xhci-plat as a module it stays unbound until the module loads.
> Platforms that allow runtime PM (cdns3-imx is the only in-tree user)
> autosuspend the controller after 20 ms, so the parent may already be
> suspended when the child is probed.
>
> Resuming the parent, either for the child's probe
> (__driver_probe_device() calls pm_runtime_get_sync(dev->parent)) or on
> a system-wide resume, runs cdns_host_resume() while the drvdata is
> still NULL; xhci_plat_probe() sets it later via __usb_create_hcd().
> hcd_to_xhci_priv(NULL) then dereferences NULL + offsetof(struct
> usb_hcd, primary_hcd):
>
>   pc : usb_hcd_is_primary_hcd+0x0/0x1c
>   lr : cdns_host_resume+0x24/0x44
>
> Commit 87e4b043b98a ("usb: cdns3: fix role switching during resume")
> only skips the callback when the role changes during resume, which is
> not the case here.
>
> Return early when there is no hcd to notify: the host role can fail to
> start after cdns_role_start() set cdns->role, or the child may not be
> probed yet.  An unbound child has no state to restore, power_lost is
> only consumed by an initialized host, and cdns_wakeup_irq() already
> checks cdns->host_dev the same way.  Also publish cdns->host_dev only
> after platform_device_add() succeeds: the error paths free the child
> with platform_device_put() while the pointer stays set, and the next
> resume would dereference freed memory instead of bailing out.

Your commit is too long and robotic; didn't read!

Reading the patch, you protect against two things:
 - cdns->host_dev =3D=3D NULL
 - platform_get_drvdata(cdns->host_dev) =3D=3D NULL

Your commit message should say that out loud and give an exact way for
those two to occur. It should also mention the hardware used to
reproduce the issue, with full kernel panic log.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

