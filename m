Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329329;
	b=vCejq2Uw5nkpswz2h45VJfXqbYqv6OPidTKCce5xKxIbFTk94YzMqzOWzuoDe5ORcqfu
	 vGoT9VoPrLos/uHS7dv3MYPRpKTGY/4NtrEMJ86SqW53tV09UF/u9dJxUXMIDOAmfMORa
	 Ur0IX9yAeFM84vFwqhcLgpiYHN3PuU819Yg1KGQiEiDuB1t/uQTnWq7WhLW02wAS6eW2Q
	 NqutgVFaiurg5XDNAQY5T9sLWHHe6GMCbjFjeGR+TCKfedL5zi39SHwMGf44p0TQuS7hg
	 ytYohV/cLuTGvaIJ6A883DpX9ZdcKxKVfzD0GDakKNpgdyKorLFBa5Yhr0UqgzpAd0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329329;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3Gji4PS1UYdloRcl1Lesx2IkWjrNwKmjW6/XXfpdVnc=;
	b=kSVG9As17ZvJKlSVqbhQMg2IHnZpKuDmdK6gt85r7qd/nxiyEPmlxEcXUaOmqVAFFHRH
	 KKzWQedB7RJgoBbT2fAjhhzxNBjM6E0f8hoWLGhXXJQm11IlGvXzV3RWhn96T9SfPTrcA
	 n1OSvqHSh79BpNebuVrIJWqG5nL/l1cGmDC/PjivtYnR1+6LfBUFTg9/qdsgFq3YtmlZW
	 HIuaCn877CpLvNml/RvWhzTQFNhywbVtcxUWLpGgRoenbNjV2ZjXF4inDJVPUz8zP9ySq
	 n+kgnrTxfqqbAmAV5nitfltr/HpRvvc554B96XuDWYfiiCaX3ksHKbsApK1jZG96YRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dS1bV+xC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83A606A320;
	Tue, 10 Nov 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dS1bV+xC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E631F0089F;
	Tue, 10 Nov 2026 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329329;
	bh=3Gji4PS1UYdloRcl1Lesx2IkWjrNwKmjW6/XXfpdVnc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dS1bV+xCMJtvwKyRlLAcZ4Wq7v6lhi9eUD8QEcJfFZRzxBwMpoYhT9n/hSBR2U2ue
	 fCHrN/6LEFH0LtDyfSrEYHQisXcYD9wuyIuFb2/sRY56SOx6eXzqKf7/7kWldHBSif
	 s/u7qkZdPImqDqpBi0Eih5PQzJHHqvdZhCeiINDwwQK+Y8djyZUvY5/B9ZX1686FzS
	 ytlraQ+r8OiP3kfStFnOdM+cO2H4axUJPu85yG2FKQFMToOoZET+cA8bXRLluQqvjO
	 3iV9sM4RJMVXPd52lxnpGWk06w35DUWG99qDmF5uKIsV7eQ8rac1OYIDIKdyBrowFY
	 UD4r0UMGhimPg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 41D913146CA2;
	Tue, 10 Nov 2026 16:48:46 +0000 (GMT)
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] spi: sunplus-sp7021: fix clock prepare leak in system
 sleep suspend
From: Mark Brown <broonie@kernel.org>
To: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Cc: linux-spi@vger.kernel.org, broonie@kernel.org, lhjeff911@gmail.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261109045314.1211-1-zhaofeng2@cmss.chinamobile.com>
References: <20261109045314.1211-1-zhaofeng2@cmss.chinamobile.com>
Date: Tue, 10 Nov 2026 16:48:45 +0000
Message-Id: <179432932520.125181.17483707315108530090.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a4fMI93CitiVOJA1Ih9hW5ZmQf7snG1q2WcKXZMg4dg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+e73t5/zxT9travCrqnYXpuMca3iXl/MF+Xn/WGg9+
 +AWCyOdjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEzEZCYjQ89PUf4XIefyviZE
 O9U/+rY/ir34lPeZzSY3d8z4069uzMjI8CrySOpVjrhtBgofXVzvXj65NaRimXfpy/zX/fk/6le
 c5AUA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> sp7021_spi_controller_resume() enables the controller clock with
> clk_prepare_enable(), but the matching suspend callback
> sp7021_spi_controller_suspend() only asserts the reset line and never
> disables/unprepares the clock.  Every system sleep suspend/resume cycle
> therefore leaks one clock prepare/enable reference, leaving the clock
> usage count permanently unbalanced.
> 
> Add the missing clk_disable_unprepare() to the suspend callback, in
> reverse order of the resume sequence.

> @@ -508,6 +508,8 @@ static int sp7021_spi_controller_suspend(struct device *dev)
>  	struct spi_controller *ctlr = dev_get_drvdata(dev);
>  	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
>  
> +	clk_disable_unprepare(pspim->spi_clk);
> +

This does mean that we're stopping the clock for the first time, I do
hope this won't unconver other bugs...  Most likely not given that we
also reset the IP.

>  	return reset_control_assert(pspim->rstc);
>  }

We stop the clock with the IP out of reset, it might be safer to not
have the IP live with the clock running - that's the order used in
probe().  It's probably better to reorder things in resume rather than
preserve the order there.

-- 
Mark Brown <broonie@kernel.org>
