Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33B41DDEC;
	Fri, 25 Sep 2026 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367805; cv=none; b=Zyhs2vVHwDJCo7T6+c+eEc2OzZj83Nf+NTSSzSJJSeTTKrDvAwGuTrz0Tep+IrZuk3RHAdnqBEW5zFZGfobCuZUp11yERMFO2GgJHWcBXK5t2lG2w+8PzvVRbS1Iai5AMepppyI2RWixbNWzvD4H0yCq6zqreiok2Zaz/DLLa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367805; c=relaxed/simple;
	bh=yku3ipPh57nbU+UgKjHx2/722iALfb4YCYhKbE75SZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+QymQlub1yJModUWToyt4SPXQDqcyK74C+docqA3oGooWSl97tqvdg3dpk35RPzXXrmvIE4wlQqz/oZhIbIyVuIqSlEG0KZtTJOfcexCoVyoSMSqEGXkobwEVgZh7lUCkbmujEaUqNtqApRw8ddmqFgg6H0RnTGadeE9HGg6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtXFoqh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtXFoqh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62E21F000FF;
	Fri, 25 Sep 2026 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367803;
	bh=be7aOpwVM70umZjqiE59C+n0H3rASjAY9dZun5+KBHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EtXFoqh75BWAK5V012E9A+bi+Qa0NXe57pOz37rERkyCg0JqZIK/MvNnra6gpyHjg
	 OILUO4/2Qysh8b96YxFvHPqvYh6JcFwkZnuXHW8E29ehpIh0IlJO4YPvgbIEKDRAUt
	 grGBJOtJW3j8eh4DYVrxCJDoMn0qx1tsum9YUy/dOcrNKRSyjfPbzYSOiaQPxIsZ2r
	 8ohqvQr9t74YPTf4HhG8AGossqe/aQa0ikcYTDrDEmtzwTbKitq70xuHBSN+HHv1Nu
	 G1CkCgMYGkpHGSuOK1QyhbymQq2ulHcCZA/XQ8zWeCFjWO14w91CZ/+gPFV1ZfQuE9
	 7g1LSZyxRMqZQ==
Date: Fri, 25 Sep 2026 13:23:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Ming Wang <wangming01@loongson.cn>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, stable@vger.kernel.org,
 Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP
 whitelist
Message-ID: <20260925132322.1798356b@kernel.org>
In-Reply-To: <2026092507-jurist-protector-c7e7@gregkh>
References: <20260920074500.826121-1-wangming01@loongson.cn>
	<4d5e2857-e6eb-43e2-b668-83e779aaa734@redhat.com>
	<2026092409-status-rocker-0fef@gregkh>
	<20260924092851.33737b1e@kernel.org>
	<2026092507-jurist-protector-c7e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 07:12:06 +0200 Greg KH wrote:
> On Thu, Sep 24, 2026 at 09:28:51AM -0700, Jakub Kicinski wrote:
> > On Thu, 24 Sep 2026 16:22:54 +0200 Greg KH wrote:  
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Ming Wang <wangming01@loongson.cn>    
> > > > 
> > > > Before any other step, please read:
> > > > 
> > > > https://elixir.bootlin.com/linux/v7.3-rc3/source/Documentation/process/maintainer-netdev.rst#L454
> > > > 
> > > > AFAICS this is actually support for additional H/W, just worded in
> > > > very unusual way: please reword the commit message accordingly and
> > > > drop stable from CC.    
> > > 
> > > Why drop stable from cc:?  Do you not want it in any stable kernel
> > > release?  Seems like it should be to me, we gladly take quirk additions
> > > and new device ids in stable kernels.  
> > 
> > the irony of telling someone to RTFM while not reading 
> > someone else's FM :)  
> 
> I did, and it says to keep stable tags, not to remove them, unlike the
> request here.

I meant Paolo did not read the stable one, sorry.
