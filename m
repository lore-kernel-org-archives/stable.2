Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841DC423EA4;
	Thu, 24 Sep 2026 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267333; cv=none; b=Kz+gWPxUoi3q6qD3PeSc+zuT4vFiH3Eml30M9W53N6KJLtjG069NvsHPAt2K1PV+NI0Z7Kjd825u/FXK/GjbH35SMTvkVgAdGenFtT7Kn0I+uJCG+rl/dQAIvI8W3BIb16jkRBbJOK26Dw+ElfxQPjj/7O573PubK9PxWMc11j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267333; c=relaxed/simple;
	bh=YnZbS1EiA3qaTDvUW8jL3goGhUe5+L+sFXn5O6+DZMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L31w1TBvcDqZG0GB33zpx+iHxkhz/c8UFY/Zpco/9Jx1rxML0cTxbwuOPukFfTReW0XJBZKExPkhCCJA2cbM5MAFpKceBxhSkpBwu23zY7eBenwlXscGySpv2gXc2rOpRLLZGnHt72I5E3LUNDEaZq5AyutjOhLkYT0EWQCMSps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc/q3Tor; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc/q3Tor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F531F000FF;
	Thu, 24 Sep 2026 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267332;
	bh=OGUBjtQQqNIoNqDGQx7x7cjkm1bMNG7o69XN0+n8L90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qc/q3TorthjB0CyIjPDJjDgKflvq624lBhJrqTXlYDAkmBGWl8ryYIoaC6LVKo2E/
	 /8u3B3shBjn/KNZgSvxZ1tiEZUBNoM9BkdlcEkaNbcxHSHTr0PprA7ZV0gRvhT31Ob
	 LKftJl3aM19vQcXyUK2oVvHXUqgnj5YJ6+m4f0SC+3Y+q2eZo3bawJSdQmVxEx/qb4
	 lWWJsI8ITqAT0MyRUvGJxEVox1fTG6+fxc7C/kvlCQ4Sb2dmCAhznQ2Y70byfWJwt2
	 iD2cBAXgz9rmEkCGg9Iqzt/fQZm/Z0z/kgQfAIf4iLri8TrQ4W57qePW7ll/S2LUVr
	 euBuPMpKeTPDA==
Date: Thu, 24 Sep 2026 09:28:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Ming Wang <wangming01@loongson.cn>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, stable@vger.kernel.org,
 Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP
 whitelist
Message-ID: <20260924092851.33737b1e@kernel.org>
In-Reply-To: <2026092409-status-rocker-0fef@gregkh>
References: <20260920074500.826121-1-wangming01@loongson.cn>
	<4d5e2857-e6eb-43e2-b668-83e779aaa734@redhat.com>
	<2026092409-status-rocker-0fef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 16:22:54 +0200 Greg KH wrote:
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Ming Wang <wangming01@loongson.cn>  
> > 
> > Before any other step, please read:
> > 
> > https://elixir.bootlin.com/linux/v7.3-rc3/source/Documentation/process/maintainer-netdev.rst#L454
> > 
> > AFAICS this is actually support for additional H/W, just worded in
> > very unusual way: please reword the commit message accordingly and
> > drop stable from CC.  
> 
> Why drop stable from cc:?  Do you not want it in any stable kernel
> release?  Seems like it should be to me, we gladly take quirk additions
> and new device ids in stable kernels.

the irony of telling someone to RTFM while not reading 
someone else's FM :)
