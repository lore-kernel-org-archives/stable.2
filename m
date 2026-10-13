Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B537A494;
	Tue, 13 Oct 2026 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876304; cv=none; b=dgRwZGX4dnnvWI4eDsB6FsJU0gsXLL4+irTV4bkbGOpA/1SeqyP/9Bk06ZzaGhOEkCTlBrUdThAkoGiGSVUn6//73dehFhEsd/a8hh+2V6AdK4H8tVLRly0KvrRGUDuGSaPXMcDdcZVclF4ZGabEsXSORUup5qWg1n+aoeX0GZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876304; c=relaxed/simple;
	bh=+jqlOOVP9Uc1zicDqqX1IpO6ruQ8VUj5Gljj/3Ms3M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwS82yXIE3Wttk+0w+QJ3htcjxSZoSj/qh/wWApnIjnfDf0GNMYVI7hm8gaJxiczE0083Di5EM+MJ03W+sDCNFkxHQsP6qpLZX5LHVRLn1pFvmdvnbHr1TbxHYK+/RxWgBTqF6cBfX/vK6rN4xEXzDtishEonpEwHiwsIXenmz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e11O6YTi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e11O6YTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5801F1F000FF;
	Tue, 13 Oct 2026 07:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791876302;
	bh=MX3exE+PNIoksGaAKxwFvW16GyNfRCtJVH6qszpzC6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e11O6YTihaFw5HLTmOrVNUpd3yH0CQNHlo9kJXwA71jmv8s2uRTujg53A392ROYsu
	 oi1R7q8KOIL1OvEtB2z/juz8xDYpANpKG4/jchv65PdZgf0goyhjCmERV5X2oNFgz7
	 hvXVhIKBVJXJyHtcRPpE72t1bp8V99eR72srNukw=
Date: Tue, 13 Oct 2026 09:24:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>, kartikey406 <kartikey406@gmail.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	johannes <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1.y] wifi: cfg80211: release locks on error in
 cfg80211_wext_siwgenie()
Message-ID: <2026101341-designed-defame-82c0@gregkh>
References: <20261012154246.1233496-1-guanwentao@uniontech.com>
 <2026101331-bullpen-carnation-3533@gregkh>
 <tencent_7D240953233FF6C810CA7875@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_7D240953233FF6C810CA7875@qq.com>

On Tue, Oct 13, 2026 at 03:00:01PM +0800, Wentao Guan wrote:
> Hi,
> 
> > On Mon, Oct 12, 2026 at 11:42:46PM +0800, Wentao Guan wrote:
> > > This error path returns while wdev_lock() is still held, so one
> > > malformed IE request can permanently block later operations on this
> > > wiphy. Route the error through out to release the lock.
> > >
> > > Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > Closes: https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/
> > > Fixes: 8b921a899346 ("wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()")
> > > Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> > > ---
> > >  net/wireless/wext-sme.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
> > > index be121fa36c514..ba6d8827f64b3 100644
> > > --- a/net/wireless/wext-sme.c
> > > +++ b/net/wireless/wext-sme.c
> > > @@ -352,8 +352,10 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
> > >  /* nothing */
> > >  }
> > > 
> > > - if (!for_each_element_completed(elem, extra, ie_len))
> > > - return -EINVAL;
> > > + if (!for_each_element_completed(elem, extra, ie_len)) {
> > > + err = -EINVAL;
> > > + goto out;
> > > + }
> > > 
> > >  ie = kmemdup(extra, ie_len, GFP_KERNEL);
> > >  if (!ie) {
> > > --
> > > 2.39.5
> > >
> > >
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> > It or an equivalent fix must already exist in Linux mainline (upstream).
> This is a trival fix for these stable trees, the problem is not existed in mainline 

Then you need to document the heck out of this why it's not upstream,
what upstream commit fixes this id and why you can't just backport that
commit (or commits) instead.

And get the needed maintainers to agree that this fix is ok and for them
to review it.

> >It must either fix a real bug that bothers people or just add a device ID. To elaborate on the former:
> > It fixes a problem like an oops, a hang, data corruption, a real security issue, a hardware quirk, a build error (but not for things marked CONFIG_BROKEN), or some “oh, that’s not good” issue.
> Its fixes a lock with out unlock, and we no need to backport f42d22d3f79639 
> ("wifi: cfg80211: define and use wiphy guard")
> and guard for older kernel tree.

We have no problem backporting upstream patches to resolve issues.
Please always do that instead.

thanks,

greg k-h
