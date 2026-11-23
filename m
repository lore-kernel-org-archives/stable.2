Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436176;
	b=cenHBS3DwUkf2XIniVq2K9JeO0pThMdE3r91gJW5F6qa6Jco9s5/Q7/b6Qwz1CSQgXjp
	 x1iNp8ZzoIaKgKqL9KIBw84PvXr+FV/UGlF9j30Pevjh7HDqjnIkohFqzeIFbVH+sTsch
	 gf9qrcKeQX2gO2UyKxRoQ0gATBgF/RiP6uqED+16bLStOfhFjOqueRUnBk1/RiHKY4B5W
	 b4PTDAW8bp1mb26hEisRw05toj5zrCUGuXv1Ya6TlxrrVEgH+QbykzcxzKT0a3SyMBQ/+
	 TYmNLQoOJuffu9o/OvOfppsRuacJ/WyK6IND3X8bR7sY7PUUfohQfb+KR4sxUPKPU8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436176;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7PMvH4MJLUJBssBKQrNzF+Xd1hwnZZFgVfKZX0Ysmnw=;
	b=q7AzL/baEviWryC+B1SrZ8G3bUjX0qG5pOisaIgRkEpp2DkR7bfbZrOpLVpa2pjChjoB
	 eSRQpPaL91EcJ31RSrJ6kWEwM1Dob/R8rOLr/lrEHLYxZRaee+b4B8XT1jzfRIRrdyt3y
	 lUFKPK434zQlNVaZUzrO/J04gahXypdiAoP1Nfv/rLMCF30gyQ6HnD394n1hHY6Q2UyQM
	 0JxPRcN9JScvM3OMxhJ63breBk9Mozl/VOK6OWUkaLFq+GRvifguUJT2koQdSP809wnyj
	 u5tA2NwbKjOgQ8uGkpOOISiWXYHAtQhkbMvkcn67swBiG5NdqqS8ABaAi7kstWEFRLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u8wuQlXB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3CD606A32C
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u8wuQlXB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5AE1F000C0;
	Mon, 23 Nov 2026 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795436175;
	bh=7PMvH4MJLUJBssBKQrNzF+Xd1hwnZZFgVfKZX0Ysmnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=u8wuQlXBjD8j+8oJx6OODD4k7DLdBzPEg0ofZ3PMua93AS31gg6Aj4nnsCFvgNtAI
	 kHwoC/kpTm6M0UPtSDw5P3yn4lLZnwlMw4eDsoUDEGJxTwmhfGgn8PCdHW30+XnB/v
	 X6BSiNysB8QVNW39I9jKoe7VtawBazE1ffK7r/A0=
Date: Mon, 23 Nov 2026 13:16:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yi Xu <xuyi0562@gmail.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, bvanassche@acm.org,
	hulianqin@vivo.com
Subject: Re: [PATCH] [ Upstream commit
 085bb18a0b91007f04ddca13af30277c78040157 ]
Message-ID: <2026112304-aids-poplar-61f6@gregkh>
References: <20261123094502.44729-1-xuyi0562@gmail.com>
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
In-Reply-To: <20261123094502.44729-1-xuyi0562@gmail.com>

On Mon, Nov 23, 2026 at 05:45:02PM +0800, Yi Xu wrote:
> scsi: sd: Mark the queue dying if runtime resume fails in sd_remove()

This is a very odd backport.  Your subject is off, and this line is
wrong?

Please look at the thousands of examples of how to do this on the stable
mailing list so that we can accept this.

thanks,

greg k-h
