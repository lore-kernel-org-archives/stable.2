Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684585;
	b=D3ZC1YHFcCy887JoaLh7E9UO3suyQRqxHunRTMr9OXSHo7pLrIjP1HAz35Mjx30Wfa0d
	 0OFBqAP1jfIgNN/fFdFF2YPQgjkHYs1PnB65l9xJTmdaBueXxCZAfuO2AAPeZEBjAAA48
	 X2oJRKCZuS4NshrbNlOiEbfFyccLc+R+bqFgwCPTy3g9a2QnDaNPddKqAMLS2DMYQRpV6
	 AFAX4lKA6pDr9xtW2xL8yDyuTYA0A5mpzy/gjNE9i1M79OcWelZ0O3O4S8VGx2/cNfk1v
	 3al7Jpb8PTM/B7hfH8UCJL0kUYpEiK9h+z3fd6GgzhU3UQDbHcB/6ZYmwFhCEmAgZ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684585;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FomIFRqNcDYe4Uif/pDykgM4WPczRC7lkjTQd1DRayU=;
	b=HhxfUfKwzbtKjdWVaH7926zJyZKq4aG3UaLI6uI708gORFxxf/LZklWzOLZuRPc9aPny
	 jyEH7TywtfP5vSV+JiD+BJTIP8MP/diOP1/jTf3wQIdnL7wMduYy6ye7Q85LVRVmZKaM4
	 Zsm37bafRMwUrWQEiGyT0ufpbWRcVY8T1KEuCWEjYF5QUwVsBDbaMspsnAzTkOpNMFZTL
	 qr/zPOa6H7Noap1OnUIu3lQ6ORvmaW9wjCEKBwyZO9FrRjDVdPd5ze8ZrrF79/91VWQyu
	 K2MhM2O0NEmx/VmrCp7QEz+MxDbN/Di0BEh8xs/Cp7nHMk2aBp9+s9otsty1WuSJiWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmniaB5V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826D606A31C;
	Thu, 26 Nov 2026 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmniaB5V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639B41F000C4;
	Thu, 26 Nov 2026 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795684585;
	bh=FomIFRqNcDYe4Uif/pDykgM4WPczRC7lkjTQd1DRayU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JmniaB5V7A0mveMIagrKxgCcQ8uJ0ii87tekcvPqPkPhYBIH5BH3XgkekYNep/4LI
	 BLxXyp1WNtGnta7c7Av13In9YwMH0XQHyStVt/FLEehaBuWzd2y1lVgLpxqq3oq47N
	 FhCwPcMSwUtC6M+4nLJdHkLPFKuH/N6l/QXalKshvAODAqA3Iuz/fSUjSqhzQ+WLuu
	 uy8Iy8CV1Y41DTWm42KXwyWqfVn/y7E17Mb5pBFlpVzKf+SPR156CYD1uJTeH+sNQ9
	 22VN0nwHrVL2ZcVsSlVfOS1lnbpoqav8Jdah77zZZPtyBrpfvhp0upGJoNPNcZ6VxL
	 JCvFYNE9QAO/Q==
Date: Thu, 26 Nov 2026 09:16:19 +0000
From: Lee Jones <lee@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 05/10] remoteproc: imx_rproc: Avoid stale mailbox
 pointers on request failure
Message-ID: <20261126091619.GD38590@joneslee-macbookpro.roam.internal>
References: <20261123172140.3547896-6-lee@kernel.org>
 <20261124032344.5314-1-peng.fan@oss.nxp.com>
 <awZ-XC1efo5QQvNI@bombadil>
 <awZ_HjrhS3Uiyssd@bombadil>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awZ_HjrhS3Uiyssd@bombadil>

On Wed, 25 Nov 2026, Richard Leitner wrote:

> On Wed, Nov 25, 2026 at 07:23:37AM +0100, Richard Leitner wrote:
> > Hi Lee, Hi Peng,
> > 
> > On Tue, Nov 24, 2026 at 11:23:41AM +0800, Peng Fan (OSS) wrote:
> > > Hi Lee,
> > > On Mon, 23 Nov 2026 17:20:49 +0000 Lee Jones <lee@kernel.org> wrote:
> > > 
> > > > imx_rproc_xtr_mbox_init() stores the result of
> > > > mbox_request_channel_byname() directly into priv->tx_ch and priv->rx_ch.
> > > > Because mailbox channels are freed on stop() and detach() and
> > > > re-requested on start(), attach(), and system shutdown, a failure while
> > > > requesting "tx" leaves an ERR_PTR in priv->tx_ch, which is later
> > > > dereferenced by imx_rproc_kick() and imx_rproc_free_mbox().  If "rx"
> > > > fails after "tx" succeeds, priv->tx_ch is freed without being cleared
> > > > while priv->rx_ch retains an ERR_PTR, causing subsequent calls to see
> > > > both pointers as non-NULL and skip initialisation, leading to a
> > > > use-after-free on priv->tx_ch and an ERR_PTR dereference on priv->rx_ch.
> > > > 
> > > > Request both channels into local variables and assign priv->tx_ch and
> > > > priv->rx_ch only after both requests succeed.
> > > 
> > > I think Richard Leitner <richard.leitner@linux.dev> is working on this.
> > > 
> > > https://lore.kernel.org/linux-remoteproc/CANLsYkx=M_TXN10qAcQC0be065TYnzfOae6E8ss-9DTj9MzogA@mail.gmail.com/T/#ma2f8e4c332d47e5bdd1787f82f4dd2feeafc67d6
> > 
> > AFAICT my series fixes a similar, but other problem. Mine is about the
> > free'ing order and a possible race when a kick occurs during
> > cleanup/close. This one is targeted towards the setup/initialisation.
> > Therefore IMHO this is a valid, fix for a different problem than mine.
> > 
> > What's your opinion on this Lee?
> 
> Sorry, was too quick with answering and messed up things, as this fixes the
> sashiko finding, not the "my" initial bug. So for me it's fine if we keep
> this one, as I have not sended mine yet. ;-)
> 
> Therefore please feel free to add:
> 
> Reviewed-by: Richard Leitner <richard.leitner@linux.dev>

Thank you Richard.

-- 
Lee Jones
