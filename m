Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D7426690;
	Fri, 25 Sep 2026 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314222; cv=none; b=mNu4HClNeSwg3c/PgVPwkASYA0VeEzl6ptZrSeTkgzDnp600BbUDziWPRJZkbU2KmcQcofBfJ2AmsOXaWyPtGdIIQotSguY52cMA7+ltmLSqJNnHxDlCwPbMaGdYu66vN73zLVzwzT8LkqCbLzxLXZiFmUc3c0v74j2skDlTe4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314222; c=relaxed/simple;
	bh=Mhtq+1aGrHhZ35m9tOg8Zg/jtwtqv1LkO628Nmphg34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnSVpaG5c5n5DRBydiN4hmWNxnFzPRZlxo6Ll1/XwdArWmLTqMkCk32MUK+90iLwb16dA8GXIdnzxPQk3xq5TckBoOp1Z+fzH/CdBXXr3h9N4MsgvxUWsRtQD+RZ1xBzvQPshRYU2ZQI/e0ZybcoHPTBVX1dyiIB/AduldIspLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1AR3fCCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1AR3fCCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DA11F000FF;
	Fri, 25 Sep 2026 05:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790314220;
	bh=aecCSw0mS/lusjDCAjCGFCN7hvR1Yx7c6vMxr7RP+qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1AR3fCCOlg8Uk/pmNdGLoYAD2ZPT2DN6nNV2i1xfzOnzmlf2lsMHkuTIykVWHizUO
	 5wE+ZW3Drd4v+3avqEq90AKzKgor/eFFqoHAvEAbtskODLVqyXD0Gzt5efIp4CmELk
	 +kNrR5GYcC02qIMUXXi/Cnrtm2eHxaim0RXFe1Mo=
Date: Fri, 25 Sep 2026 07:12:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Ming Wang <wangming01@loongson.cn>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org, Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP
 whitelist
Message-ID: <2026092507-jurist-protector-c7e7@gregkh>
References: <20260920074500.826121-1-wangming01@loongson.cn>
 <4d5e2857-e6eb-43e2-b668-83e779aaa734@redhat.com>
 <2026092409-status-rocker-0fef@gregkh>
 <20260924092851.33737b1e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924092851.33737b1e@kernel.org>

On Thu, Sep 24, 2026 at 09:28:51AM -0700, Jakub Kicinski wrote:
> On Thu, 24 Sep 2026 16:22:54 +0200 Greg KH wrote:
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Ming Wang <wangming01@loongson.cn>  
> > > 
> > > Before any other step, please read:
> > > 
> > > https://elixir.bootlin.com/linux/v7.3-rc3/source/Documentation/process/maintainer-netdev.rst#L454
> > > 
> > > AFAICS this is actually support for additional H/W, just worded in
> > > very unusual way: please reword the commit message accordingly and
> > > drop stable from CC.  
> > 
> > Why drop stable from cc:?  Do you not want it in any stable kernel
> > release?  Seems like it should be to me, we gladly take quirk additions
> > and new device ids in stable kernels.
> 
> the irony of telling someone to RTFM while not reading 
> someone else's FM :)

I did, and it says to keep stable tags, not to remove them, unlike the
request here.

confused,

greg k-h
