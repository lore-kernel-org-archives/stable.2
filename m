Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F4381AE3
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347683; cv=none; b=Bn/3IVxlC4o45ZN4Sc8FDoqGRN9Kd5ijkMaRSjhyLBmuddaVocqdjorHf1dZi/Y3jxyOKniSnzOzRjJ943dFwQDmaHIlHZwnkigkCPna8pN00TOIs+4WkTMtKC2Khzo6f2mn9iCfBW5YyPBg6YeTrTCMhe+sLBV5Ct/X4OoDDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347683; c=relaxed/simple;
	bh=9EKST5B05XKAFf1wFAMVyTG8/m/iKJLAMvwmCnXUgI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECIr35PYdrSyGHk73ekXDITV1VvkTJFC3QKLVlJNwCPMSRPrbimR+shS/GtFXJQ1w959T3ABTE3HUBa063f/Lr2p+Mj6hsxRZtFgGoFg7bQNsubJuQiFlauI/RDLErzz3M+II1d7SHXrcngMnxVOGmmqsSixXMYESnP7Z0q3Szw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ttvyxnte; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ttvyxnte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6F41F000FF;
	Fri, 25 Sep 2026 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790347678;
	bh=cSh64e9SAJkh7HthA6iJ6xxEhKV6EPU3kT3c8oaZf6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ttvyxnte8Tjp9YW28hpZTBm12TloZ93dCrbn6z+r/3GePKxuB58jqrP4uNSUuf40v
	 8EFsp81h+38BfBFiNahdCy40A+84ZJ+ARDClzUjGevW1l2zlOAtp8XgsPzPB6bTYTj
	 TmkWkvH5duOk0/0wJEevDLNwSKD/0bRAdVhoB3IQ=
Date: Fri, 25 Sep 2026 16:47:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Robin <benjamin.robin@bootlin.com>
Cc: stable@vger.kernel.org,
	"miguel.gasquez@bootlin.com" <miguel.gasquez@bootlin.com>
Subject: Re: [PATCH 6.18.y 1/2] rculist: add list_splice_rcu() for private
 lists
Message-ID: <2026092530-trivial-vagabond-709a@gregkh>
References: <20260925-cve-2026-52988-6-18-v1-0-680b24895415@bootlin.com>
 <2026092540-jokester-certify-1339@gregkh>
 <JyCWa7ltR_KwJYUaBPJh-g@bootlin.com>
 <8TOvOdgDRsCPoDckusflIA@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8TOvOdgDRsCPoDckusflIA@bootlin.com>

On Fri, Sep 25, 2026 at 04:36:27PM +0200, Benjamin Robin wrote:
> On Friday, September 25, 2026 at 4:28 PM, Benjamin Robin wrote:
> > On Friday, September 25, 2026 at 4:23 PM, Greg KH wrote:
> > > On Fri, Sep 25, 2026 at 09:52:23AM +0200, Benjamin Robin (Schneider Electric) wrote:
> > > > From: Pablo Neira Ayuso <pablo@netfilter.org>
> > > > 
> > > > [ Upstream commit f902877b635551513729bdf9a8d1422c4aab7741 ]
> > > > 
> > > > This patch adds a helper function, list_splice_rcu(), to safely splice
> > > > a private (non-RCU-protected) list into an RCU-protected list.
> > > > 
> > > > The function ensures that only the pointer visible to RCU readers
> > > > (prev->next) is updated using rcu_assign_pointer(), while the rest of
> > > > the list manipulations are performed with regular assignments, as the
> > > > source list is private and not visible to concurrent RCU readers.
> > > > 
> > > > This is useful for moving elements from a private list into a global
> > > > RCU-protected list, ensuring safe publication for RCU readers.
> > > > Subsystems with some sort of batching mechanism from userspace can
> > > > benefit from this new function.
> > > > 
> > > > The function __list_splice_rcu() has been added for clarity and to
> > > > follow the same pattern as in the existing list_splice*() interfaces,
> > > > where there is a check to ensure that the list to splice is not
> > > > empty. Note that __list_splice_rcu() has no documentation for this
> > > > reason.
> > > > 
> > > > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > > > ---
> > > >  include/linux/rculist.h | 29 +++++++++++++++++++++++++++++
> > > >  1 file changed, 29 insertions(+)
> > > 
> > > You did not sign off on this commit :(
> > 
> > Hello Greg,
> > 
> > Sorry about that, I was not sure about the rule if I did not modify
> > the commit in any way.
> > I will send a v2 for all branches ASAP (but I may only send the v2
> > on Monday).
> 
> I have an additional question, I was wondering if it is necessary
> to add in CC: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
> netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
> netdev@vger.kernel.org, ...
> These emails were auto suggested, so I kept them. But since I am
> sending to stable, maybe I don't need to "spam" everybody.

 Cc: everyone on the commit, that should be sufficient.

thanks,

greg k-h
