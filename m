Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C013CA92;
	Mon, 10 Aug 2026 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786336260; cv=none; b=GaFLQGmQwd+fzmVKxj22+TAYvt1qa2537INffuFr/boGFwW6GMRlBck2xalrma7s3AnrplsATAvEPfAFvsh3I0UqnQwJ0FQ3uxwHSeNxfUmr1kmUdNZP91k/6XIh8LJnlvlLivFVlnfCmf0PT+HqNfNBxvIDDWzZcX7har2Ne08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786336260; c=relaxed/simple;
	bh=KOcMkOe+J6Ek8le34wfXSDv6HKoUNFKEl2sF+0sNKBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPsatnvc3m2OWggtNNFjR/Fh3lGAIo8NjbgAm4auvpL46a0TIeHWGv3oXQl60SyUzoe+N1EsA8LtWSfh3F2x3H1V6rKZB96m5pTsja/yMKhcw4/mnJFQ3yWSfjSJKWMg4+6zSJvPlt9NtvN5wvEj8YVUiiDTizeZNTUiTdv2BYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDMEcxY+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDMEcxY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786336257; x=1817872257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KOcMkOe+J6Ek8le34wfXSDv6HKoUNFKEl2sF+0sNKBM=;
  b=hDMEcxY+hmbcUiQtuY4bI6jebEq0xv1NcXkE5FILH8DojfVu18Zics3k
   pPK67hjHn6o+l2PCfivlhUaRv2srtNfMPHL0pb8LduhxtoXPMJxPBXGwz
   XeSXndedK228MSswRolms4sQ13fhUXUjYeU82svGFfX/3aqmPRvwqAK1B
   Ddf4UKVwXTUoMwonTdpmtg6P/txuL8cGRLNe0r6ANd/wsgSFZq+SHnMUF
   vMyRcHwCLm9YGz925zqWyO4PX0pBJqxlaWvUJr7VbDU+IQfNiFVsFGFqH
   9zKhaWJp7c7ZLm625miOtgrtyiEJHxWnzFSJkHXl1c1G5txihQVuN+s+m
   Q==;
X-CSE-ConnectionGUID: byn7mYLjRI6HYPmmG1PfEg==
X-CSE-MsgGUID: u1kav530RuaHAt5uMfyN0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98203710"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="98203710"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 21:30:49 -0700
X-CSE-ConnectionGUID: rQ7VZekHQPSpduDpPo2gnw==
X-CSE-MsgGUID: Bi/wivqeSlKwvEtgjLAmZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="266416683"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 09 Aug 2026 21:30:46 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 49B9A99; Mon, 10 Aug 2026 06:30:45 +0200 (CEST)
Date: Mon, 10 Aug 2026 06:30:45 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: fy15309206903@gmail.com
Cc: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: thunderbolt: Release the Rx HopID that was
 handed out on mismatch
Message-ID: <20260810043045.GA893316@black.igk.intel.com>
References: <20260809-b4-tbnet-hopid-v1-0-9a8c7f5f0ba9@gmail.com>
 <20260809-b4-tbnet-hopid-v1-1-9a8c7f5f0ba9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809-b4-tbnet-hopid-v1-1-9a8c7f5f0ba9@gmail.com>

Hi,

On Sun, Aug 09, 2026 at 02:28:00AM +0000, Fan Ye via B4 Relay wrote:
> From: Fan Ye <fy15309206903@gmail.com>
> 
> tbnet_connected_work() asks for a specific input HopID and treats getting
> a different one as a failure:
> 
> 	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
> 	if (ret != net->remote_transmit_path) {
> 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
> 		return;
> 	}
> 
> That call ends in ida_alloc_range(&xd->in_hopids, hopid,
> xd->local_max_hopid, GFP_KERNEL), which allocates the lowest free id at
> or above the one asked for. When the
> wanted HopID is already taken it does not fail - it succeeds with the next
> one - so this path returns with an id allocated and no reference to it
> left anywhere. It stays allocated for the rest of the XDomain connection.
> 
> Forcing the branch by occupying the wanted HopID first shows the returned
> id is a live allocation, not an error code:
> 
>   LEAKPROBE squat=8 requested=8 local_max_hopid=27
>   LEAKPROBE real alloc ret=9
>   thunderbolt-net 0-1.0 thunderbolt0: failed to allocate Rx HopID
> 
> Release the id when it is not the one we wanted, matching what the error
> unwind at the end of the function already does for the expected id.
> 
> Fixes: 180b0689425c ("thunderbolt: Allow multiple DMA tunnels over a single XDomain connection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fan Ye <fy15309206903@gmail.com>

This is okay but should you also add assisted-by tag for the LLM you used
to generate the patch? I think that's still required. Ditto for the other
patches as well.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
> These four came out of one investigation on a pair of ASMedia ASM4242
> hosts wired to each other. Apply them in this order: the second one
> touches lines the first one adds, so it needs that one underneath to
> apply at all, and the last two want the first two under them for the
> reason below.
> 
>   1 net: thunderbolt: Release the Rx HopID that was handed out on mismatch
>   2 net: thunderbolt: Mark the connection down when bringing it up fails
>   3 thunderbolt: Report DMA path teardown failures to the caller
>   4 thunderbolt: Stop waiting on a path pending bit that never clears
> 
> This one is number 1 on that list.
> 
> 1 and 2 fix two separate things that happen to be reached through the
> same branch. Neither depends on the other for correctness - each leaves
> the other's defect in place - but 2 edits the lines 1 adds, so it will
> not apply on its own.
> 
> 3 and 4 do want 1 and 2 underneath: the warning splat that 2 removes
> fires throughout any prolonged run of link cycling, which is what 3 and 4
> have to be measured across. 3 makes teardown failures visible to the
> caller at all; 4 stops the teardown paying for one that cannot succeed.
> Note what that pair does on this particular router - 4 leaves the first
> failure to be reported and silences the rest, so 3's new signal fires
> once per adapter here rather than on every teardown. 4 is the one I am
> least sure of, for the reasons in its own notes.
> 
> Found on an ASMedia ASM4242 host-to-host link, where the branch is
> reached on its own when the peer drops out while a connection is being
> brought up. Cycling the interface down and up 200 times over 80 minutes
> hits it 23 times across the two hosts, no fault injection involved.
> 
> I am not claiming a user-visible symptom for this one. Every one of those
> 23 occurrences recovered on its own, 19 to 21 seconds later, because the
> XDomain connection ends and its ida is recreated along with it, which
> also disposes of the leaked id. I could not reach the branch twice within
> one connection, so I cannot show the HopID range being exhausted either.
> 
> What the patch fixes is the leak itself. The patch that follows has the
> measurable effect, and does not depend on this one - they are separate
> defects reached through the same branch, and with only that one applied
> the id this path obtained is still never released.
> 
> I could use help with one thing. The only way I found to reach this
> branch is to wait for the peer to drop out at the wrong moment, and the
> XDomain connection ends with it, so the leaked id goes away with the ida.
> If anyone has a setup where the branch can be hit twice within one
> connection - more than one service on the same XDomain, say - that would
> settle whether the range can actually be run down, which I could not
> show either way.
> ---
>  drivers/net/thunderbolt/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index 98893732bc6e..e5199a87ea7a 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -647,6 +647,8 @@ static void tbnet_connected_work(struct work_struct *work)
>  	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
>  	if (ret != net->remote_transmit_path) {
>  		netdev_err(net->dev, "failed to allocate Rx HopID\n");
> +		if (ret >= 0)
> +			tb_xdomain_release_in_hopid(net->xd, ret);
>  		return;
>  	}
>  
> 
> -- 
> 2.43.0
> 
