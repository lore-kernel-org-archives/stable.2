Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715390;
	b=lgIjgLnNBcgP6bFazZ2acnSuy6MOdcLx7NJhFqx2or8tl34WAfXOwN0BhwdkDchQeNRb
	 00Xpl8Ju5CeHXtdAgBUkzGn5/2XBFwv4WLzwe2EpEcFKLXEOdANWzwX80efoIkWV4w/ri
	 3SCDCEM05sagLIgwWOtOX9bjfPJMESuqGLfCharDxKGi/AeQYvkkNTG4nIa7LWPLM7VUX
	 bpgS0HNsLPcgao2zWZb654Lq8/ZlMtPu21JOQROPjNXuwjbx4m6JQxw1tr96CpmYcam7C
	 CXSh6qF1AOGS/YQAoeZSFIHs9W3WqFhuKpruAsgCf7+hc0DMEKux9KKKDDFYBaBMcSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ouBVtknwG+MP0jN8AhTfO47zIk3bNGvLbyRW2rgifEc=;
	b=AoOePyDSx2A8bxeH1RQPKoIbQZ/+KF8tArt8ppteqJp2aL10aXSbKdvqZJ3xH5m+tdGf
	 50zrKhAPfT082Q4TnSDid3woih/jIQlGsbNHXxc7aSYhQZzdRl4yY3Z7YNvrR9KStvn+F
	 SrcMQ3arsDvVoUTKiOoe7ntVAmrA6+Hu0dK7+Ehy2d6XC1Zxad4qW4MUZcd02j0FnAA5X
	 qI114BpYbTD7FY942sXlJ8XIXNwDNCHCpVf7e2GVhNBTL1JCgA62gAdxDXrb41yahS4EA
	 fGLO0/P8VRXL0pumvCj6FhlJmTH32BoSa9GkO4NB/m+oS4Pscvh49NQUnHJc9dCm9WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPaF3KLd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03095606A31C;
	Thu, 26 Nov 2026 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPaF3KLd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A787E1F000C0;
	Thu, 26 Nov 2026 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795715389;
	bh=ouBVtknwG+MP0jN8AhTfO47zIk3bNGvLbyRW2rgifEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oPaF3KLdlUtjc82qMAU9L96X3pShH/ohEB0DaOO+ZqbM/phFNVqyvO+ZAdu3kbRKm
	 1L/kf/gmIVQ8VhxUG5a6SDSeFsR9lfznHcKMlMqwtagtwuiZiSTYsLfNMVNxzCnxac
	 OiPNje8W/EYHotY8QRrcd4lDRVGIRjrygpspdcCfWHI9QRK/t3G/TFiKeXRWoWiq4h
	 6Q0PPmepML/+790kwYwFnifPjwAxuavCM3pED0FZdWjqVbTU8SOMc4vTRRFukByP+m
	 0Aj16geH6SdMaiQj4qItCnXnAO+OlQ21BBN2ucM/hyXmE0qEDn6kYI/NFoH8Eu3Rag
	 ZxXx1vzuLwTaw==
Date: Thu, 26 Nov 2026 18:49:45 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Markus Haberlander <markus.haberlander@rosenberger.com>
Subject: Re: [PATCH] i2c: cgbc: Fetch the status of a write transfer
Message-ID: <awhxAlhwF4QF3V6a@zenone.zhora.eu>
References: <20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com>
 <179568834099.302193.16315749597111506309.b4-review@b4>
 <awgwO98qx3zX4MaY@zenone.zhora.eu>
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
In-Reply-To: <awgwO98qx3zX4MaY@zenone.zhora.eu>

Hi Thomas,

...

> > Yes it conflicts (compile issue) with the series [1]. The possibilies are:
> > - I pick this patch in my series and send a v7.
> > - [1] is applied, an immutable branch is created, you rebase your patch on
> >   top of it, and patch is applied in I2C tree.
> > - [1] is applied, you rebase on top of mfd-next, and your patch is applied
> >   in MFD tree.
> > 
> > Andi, Lee, what do you prefer?
> 
> Let's wait your patches to get in first and then Markus can
> rebase on top of them.

as you are going to resend your series, would you be so kind to
include this, as well?

Thanks,
Andi

> I will now prioritize your series.
> 
> Thanks,
> Andi
