Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108FD490BFB;
	Fri,  2 Oct 2026 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790943263; cv=none; b=mPtgOli9NnypeS6yakLDXgOb9APcuXrjpl/bkzyOIdZQZQ40sDDKzmMWezsTQfrLTzV7sYGSU3EBh7Q3GUbn88AqAiGE4S+LJfaNq6s0l3od1LtIZRAdShbB5f5zvjPoSjw0fzy3f5JMAO38RHeAEcNq+HDbs+uooYyWP/01m9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790943263; c=relaxed/simple;
	bh=nIt68TE7y1O0CfVvkllv8sjdcnXQbkPNc87TN1h2iIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyOe5Z4xdQxJP+nUj9OrfUbtjs/DbI2k9qI+TLyZ2S5YQxga9rp612TD5+oU+Ll3WkL6EVV+R30SipLgShbOiBxqeB9Iyn0BLwSlx0pLa5U4E79+cmdngRH7HulMPU6EnEgkeQDBvxgYnsrIgamRnQX13xpDxluO5Q1RowbxvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A+IsQuXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A+IsQuXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9911D1F000FF;
	Fri,  2 Oct 2026 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790943252;
	bh=q9BR54I+jgzETkj91nIAVu54D+wwlaq9nSE6W3+tQOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A+IsQuXrscQEGtZq2o0OmJvM3nq8+2evlEr7FFnwOgPZRqB8Txd+OZU3E+hwWJogd
	 WedeoJbUM94mqiTUUl8awPK1rXGpPw22NJVPomobY53CCts2+JppZcEjI4BnTsULVa
	 icYTx60ETs261xYH9T6J0NFubxvIpcRbbvJPINwM=
Date: Fri, 2 Oct 2026 14:14:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jungwon park <jwpark@whitecode.co.kr>
Cc: stable@vger.kernel.org, gnault@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 6.1 000/982] 6.1.189-rc1 review
Message-ID: <2026100245-diffused-handball-90e8@gregkh>
References: <a1a0f247-e847-4598-9b84-9840ddbf50b4@whitecode.co.kr>
 <0f382474-d85d-4736-8ee8-e934a96ae2d2@whitecode.co.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f382474-d85d-4736-8ee8-e934a96ae2d2@whitecode.co.kr>

On Fri, Oct 02, 2026 at 02:16:50PM +0900, jungwon park wrote:
> > This is the start of the stable review cycle for the 6.1.189 release.
> > There are 982 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >  https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.189-rc1.gz
> > or in the git tree and branch at:
> >  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Hi!
> 
> VXLAN stops working after applying patch-6.1.189-rc1.
> 
> all VXLAN packets are dropped (only the "dropped" counter keeps increasing).
> This appears to be caused by the patch titled "vxlan: Pull inner IP header
> in vxlan_xmit_one()" - 667b5d5945e8947868fef8d75bf3ce4accb81b30.
> 
> It seems likely that this patch was written before the change to
> skb_vlan_inet_prepare() (net: tunnel: make skb_vlan_inet_prepare() return
> drop reasons) was implemented - 6dedc8c2a4bfc64ef07410634e944c0506eb98c1).

Thanks, I'll go drop this from 6.1.y, 5.15.y, and 5.10.y

greg k-h
