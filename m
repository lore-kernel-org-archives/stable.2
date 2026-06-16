Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83730E82B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592603; cv=none; b=tXekGkRvHENXZDVDVNo+8Btn2LdUSP8XdZp7lbuYo6ayOjTgKlgYvArHTaeFzFEumAa7Zob1h1MtRm9KRNlciu9VKgS0PgBCpFIKRhsso1AvDU5ZDizaQqWcY4RppwbsMxzHg65cCepDRBbua8ra6/C0kcDSxSifftgqOhqcoxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592603; c=relaxed/simple;
	bh=aCec2jptkVAVbYkZaWA2BZJ1YQqHHL0qLwYlMXuaUFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4Rmm8in5VCft01FbgYyW/5zeBPZfagGy13A7oMs5T/NKM+XfuNAk5GLxXXCKLEXk/H/aQCplEiRoC3k4+athOiBo3LxWZOBtblc6qQyM2rHyvnbNFDM9Rn0akpHw1/WX+FV9IO3mkl9vennwAZSLdQAMHRVDCZiymJCVDSyTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P3qBhv5s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P3qBhv5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47E61F000E9;
	Tue, 16 Jun 2026 06:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781592601;
	bh=fv4VksBQV064B6NuyRKAtJRTmKtVucI6YfcEYMmOnmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P3qBhv5sSJ5YDrGtB8Yr7wCmJyEfhbJ99Epgp/lSRXcsSxrBPjjp13mwP89gfmXlo
	 RSu58ul4VnVeJxekzW4YY+i65f4b12DPV9ubHzoZxp1nFhA/PoxfBhmtsZr4Cwc9c2
	 8rPPUe/TXWk3XyKZbkzf09weYmYr5odjztJANdqU=
Date: Tue, 16 Jun 2026 12:18:56 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kevin Berry <kpberry@google.com>
Cc: xmei5@asu.edu, bestswngs@gmail.com, chenglongtang@google.com,
	joneslee@google.com, pabeni@redhat.com, rnj@google.com,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
Message-ID: <2026061640-crunchy-patio-be38@gregkh>
References: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
 <20260506202842.1788682-1-kpberry@google.com>
 <20260506202842.1788682-2-kpberry@google.com>
 <2026061617-flyable-civic-a986@gregkh>
 <CAMAJAJE+w+vYwcEzkZoNDwoAC3PzJ54sGGr7s+5edBW3JJFKHQ@mail.gmail.com>
 <2026061614-trunks-outcast-6684@gregkh>
 <CAMAJAJG3Ox-GPz+t05On6F6pJt5rFAvo2AcMW9jJmG1O4EGOLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMAJAJG3Ox-GPz+t05On6F6pJt5rFAvo2AcMW9jJmG1O4EGOLA@mail.gmail.com>

On Tue, Jun 16, 2026 at 02:41:37AM -0400, Kevin Berry wrote:
> > That worked, thanks!
> >
> > greg k-h
> 
> Glad to hear it!
> 
> It's also worth pointing out that because the fix for 6.12 was done
> without the ce7a381697cb3 ("net: bonding: add broadcast_neighbor
> option for 802.3ad") dependency, it conflicts with the c4f050ce06c56
> ("bonding: 3ad: implement proper RCU rules for port->aggregator") fix
> commit series that was applied to other trees. So for 6.12, I think it
> would make sense to:
> 
> 1. Revert the fix from this thread: 3453882f36c4 ("net: bonding: fix
> use-after-free in bond_xmit_broadcast()"),
> 2. Apply the patch series for c4f050ce06c56 ("bonding: 3ad: implement
> proper RCU rules for port->aggregator"), namely:
>     - Apply 4440873f36553 ("bonding: 802.3ad replace MAC_ADDRESS_EQUAL
> with __agg_has_partner")
>     - Apply ce7a381697cb3 ("net: bonding: add broadcast_neighbor
> option for 802.3ad")
>     - Apply 6b6dc81ee7e8c ("bonding: add support for per-port LACP
> actor priority")
>     - Apply 4916f2e2f3fc9 ("bonding: print churn state via netlink")
>     - Apply c4f050ce06c56 ("bonding: 3ad: implement proper RCU rules
> for port->aggregator")
> 3. Apply Xiang's original fix commit: 2884bf72fb8f ("net: bonding: fix
> use-after-free in bond_xmit_broadcast()").
> 
> That should make things consistent between 6.1, 6.6., and 6.12 with
> respect to those two fixes.

Please send a patch series that does this to make sure I get it correct.

thanks,

greg k-h
