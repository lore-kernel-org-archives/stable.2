Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706B4908DD;
	Thu, 17 Sep 2026 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646902; cv=none; b=GwRVGuxapG7dp+GPvmRYV7ZNy9U1cTZU+5rSKTrfqVPQ5fBHtuAUne0L29jejPjal6Vfh98yUOhvZh5GTlVE3a//ERl7gEP1OiK89VHYHqu+xzqQScVrc0uQOfFFxMA17jMTLbnKN50f+OXsyk/hwWaIBCmxljfkli45bB4kqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646902; c=relaxed/simple;
	bh=hHbT27kuqIlaiO3SIpprZ1HphhUZk1g6+IqTfKx3SBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPO4jUglovVyuZSiqXdNSWYb71EiuP9eYcolM+CKarjRosMmzXClxjbuQbUTlEaT5/PPyuZzTsChBVmmx19oKeJELB8+aIZvJnzojnj+j/Iw/UHyARQ9lMUNGcPwZTzadgyALTTdkS0wjLRFYGYuLkhmR557ksd/3f1/PGvx3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9nwaMKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9nwaMKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCF81F00893;
	Thu, 17 Sep 2026 12:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789646886;
	bh=ciOPc2jXkTRT4hhA5/7H/iIkZ4KsJ0K0tjd6lWke+pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O9nwaMKMeejQMy2k3h2s5MBhthv5N1sEW8K2ITD7Xj+cEzyjPjEar2Gbva2Kc2dpk
	 qvAtEVhUEfGm1wcPAJwn+foOcfbQzUL/td3mO4FaONtQt7Ju1ntPSbozhEoMpASv+L
	 xFZETbQIBRPMJXJ5jszyU9TDlLFDv2rIsO4wMl8GTR6L17UKKesrF8/htwK0rQhjl6
	 29BrSUHzDF5TYEROX/y1fjJcO1jfSLZa7u0kt6pr0MQLCNjtHBnKF0I5Js9WzM6+Ei
	 VI0ks2vfYuAA7a0VMwttU9DO7s4FV2803kwo7SjJR0RO4j9VHb/xoR7BsJ1ovhd4RN
	 QZnYRzkDZXY5Q==
Date: Thu, 17 Sep 2026 13:08:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>
Subject: Re: [PATCH net 1/2] net/sched: cls_u32: fix manual hash table handle
 IDR aliasing
Message-ID: <20260917120801.GA51261@horms.kernel.org>
References: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com>

On Wed, Sep 16, 2026 at 06:01:14AM -0400, Jamal Hadi Salim wrote:
> A u32 hash table created with an explicit handle ('tc filter add ...
> handle 801: u32 divisor N') keys its IDR entry on the raw handle, while
> the destroy paths free it under handle2id(handle). The two key domains
> disagree for handles in the 0x800..0xFFF htid range:
> handle2id() folds them back into the auto-allocated id space (1..0x7FF).
> 
> A manual table therefore leaves its raw-keyed IDR entry unreachable on
> delete (a permanent leak), and its delete can drop the idr entry of an
> unrelated live auto table. A later auto allocation can then hand out a
> handle that aliases the live manual table; u32_lookup_ht() first-match
> routes lookups and TCA_U32_LINK for that htid to the wrong table.
> 
> Key the divisor-path alloc on handle2id(handle) so allocation and
> removal share one key domain. A manual handle that maps onto an id
> already in use is rejected with -ENOSPC, and auto allocation skips ids
> held by live manual tables.
> 
> Conditions to recreate:
>   ip link add test0 type dummy
>   tc qdisc add dev test0 clsact
>   tc filter add dev test0 ingress protocol ip pref 1 \
>           handle 801: u32 divisor 16
>   tc filter add dev test0 ingress protocol ip pref 2 u32 divisor 16
>   tc -d filter show dev test0 ingress | grep 'fh 801:'
>   # unpatched: two live tables with handle 0x80100000 (the pref 2 root
>   # hnode is auto-allocated id 1); patched: the auto hnode takes id 2.
> 
> Also tested with a poc with a live u32 table on the block, add/delete a manual
> table 'handle 901: u32 divisor 1' twice; unpatched, the re-add fails with
> -ENOSPC because the raw key leaked on the first delete.
> 
> Fixes: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.")
> Reported-by: Sashiko (gemini + nipa) <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260822222049.114526-1-jhs@mojatatu.com
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: hybris <hybris@mojatatu.ai>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

