Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13ED418348;
	Thu, 17 Sep 2026 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635735; cv=none; b=h+qbUtoW6svte/ypWI93DlNcLGHndRd60EsnCUoc8tfeGcf9fA/2+Cai4qdVJ50gR3Ws8YOAffM8yI/8J0yvCYemb7cxzQ8iyI29/JHgjU81d9dH7lIqcMmag1g7bHU1LoWtmgUOUaa4Fla2JdKHAJ+lQbTrLs2unc0T3xVmNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635735; c=relaxed/simple;
	bh=Zi+DMZp8+p02PpEKqT1zGlUz3dkdIf800Af+GA8TXmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvqalAy3yf0f2C4yajgAwE69SuJL3iujG9o2Jyhecomu4BcIEwCWvIxQs/5tBvb3pC6yAZ/hqwF/KMgRR1eCXJmu777w3IFVqC3sY6wLtpCJ0qAzu8LUx8PQWQp6aAIg4cqLKmvR9+thToUgfxBfpigLpQ9HVCyoTYadwFyODDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L4iyR69y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L4iyR69y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72701F000FF;
	Thu, 17 Sep 2026 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789635734;
	bh=tYZqO2sK3N6OEYW8bqzfgCa8OKi2eri9nkYDe+gQ2VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L4iyR69yxilKEbu1ExBzDA5RplPqHqqPKqKDxcy7Avhe6/LMXl/DQZJlDkvWB/SrB
	 UkHhy9/lYAaeQNJUwwDi7RI8vppSUTMfva0H2gDOcvGoHZsizxobuehIfgnr5cKTIS
	 XtIxa9r5m71DS3qsRoIlSyy4mB8pTL0dqqS0tNAE=
Date: Thu, 17 Sep 2026 10:00:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: stable@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	bestswngs@gmail.com
Subject: Re: [STABLE REQUEST] net: appletalk: fix NULL pointer dereference in
 aarp_send_ddp()
Message-ID: <2026091706-hazard-granny-8e45@gregkh>
References: <w3zxh3nycm6cdbz6mlgmfi6bnzhdkunbcbu5dwgho2yvxscbjj@ph7wsgy2cxcs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w3zxh3nycm6cdbz6mlgmfi6bnzhdkunbcbu5dwgho2yvxscbjj@ph7wsgy2cxcs>

On Wed, Sep 16, 2026 at 04:47:28PM -0700, Xiang Mei wrote:
> Hi stable team,
> 
> Could you please consider backporting upstream commit
> 
> 9e7f36ab5b7bf68463faa5f7b926fea8f35597bb
> ("net: appletalk: fix NULL pointer dereference in aarp_send_ddp()")
> 
> for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and 5.10.y.
> 
> It fixes a NULL pointer dereference when sending through a device
> without an AppleTalk interface configured.
> 
> The fix has been in mainline since May 18 but is still absent from the
> longterm branches.
> 
> The upstream commit applies cleanly to all of these branches.

Now queued up.  Note, this is deleted in newer kernels.

thanks,

greg k-h
