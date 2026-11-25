Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625902;
	b=auOpG2R93SyW4A9XecNvXQyNXNXyTMf9ej2LYHwBk7QDs9jaoveA9mJcOrcPRJcXJ2aq
	 PwCFztUcwhfC3Q7Zk0Laidf4nfoMnwxNOVWNCAM2a/E8dJ8K8rnSw8Qpc0/2XCFRXHHHt
	 BXu1NV+HRzhOvv9cp2ZIW2pSi19Uh6wWekvsgi5qXva/+wgPGsoOmJbsPv+xcanVmR46X
	 QVfwSCTlNu/yeW0OS+xqZL9FVavgWk5vVFDM9vrkEAyxTmnt7EIos8RbDdHTnvhpjR95S
	 FWWXDc2buHhOByXCesKbcxq3ch/ReWWBXt1QfKhLB+AMHHUN6mOTSXWxi9r08fv0V3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625902;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VeaRMJr5MeN6pZeuCdvkhBSCAsTmvP8phUZZr3zTlcE=;
	b=ms7YeVJNgnLao9FeUng//8QZZ7Tpp6L+4L6ww6raFV/PkaUE46cfpfbhgrMOneoXAfJQ
	 Yj8vHl1M1srZRxoloawBA3bMU7nfuBCYnKAZQMmOBfj05NHJ7gbrsfvpX5gREMlRr9N9D
	 IRdT6h5a2NI47oTH9xk4u3lcfpeJRzcdo+3GdP/jzGO0ezW544smGisr5nseUQhO0m7PE
	 MiGKqy6PFEe007+kv4LbC8jyAR+dSBjqvsV31mLyAp8WICXvQ9O1LEmtZ0pqWfQtWjZ7q
	 I9MB9BVLgBQgmBx+eThmzTgJEheGnNC1cDyI9PKpgUVFjSxTb2OaiLBt+9IjXDD+4tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U9s78iQ4;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B167B606A33C;
	Wed, 25 Nov 2026 16:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B167B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U9s78iQ4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 072B62F;
	Wed, 25 Nov 2026 08:58:18 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 214143F632;
	Wed, 25 Nov 2026 08:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795625900; bh=Szbs47AGBw7DAENnZv9Xsgc+H6POhcnLH+71i5NxoB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U9s78iQ4n5uVP9leVJ/aLlJnv5O67E7SgX8wHk7l9krSm6na71RnT7vG/K4WebKA/
	 cUdz6A3SDQ/wGcSetyhDMobLFDeJtJPuTeUurN9+hdufIk56Ghfs1isogtR2R6zI8X
	 h16BVxJAFr0x8yRI1VaxGhezjyX0wO2QT8rktMcs=
Message-ID: <9ca5ad64-f884-4741-adbc-a54677fb426f@arm.com>
Date: Wed, 25 Nov 2026 16:58:18 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Use at least 2 bits per XP coordinate in
 node IDs
To: schouleur@snap.com, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 stable@vger.kernel.org
References: <20261125-arm-cmn-xyidbits-v1-1-6f7bee891859@snap.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261125-arm-cmn-xyidbits-v1-1-6f7bee891859@snap.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2026 4:15 pm, Sylvain Chouleur via B4 Relay wrote:
> From: Sylvain Chouleur <schouleur@snap.com>
> 
> The X and Y coordinates in a CMN/CI-700 node ID are encoded in 2 bits
> each for any mesh up to 4x4 (7-bit node IDs), and in 3 bits each for
> larger meshes (9-bit node IDs). The width does not shrink for smaller
> meshes: a 2x2 mesh still uses 2 bits per coordinate.
> 
> arm_cmn_xyidbits() derives the width from the actual mesh dimensions,
> which yields 1 bit for a mesh with both dimensions <= 2. On such a
> mesh arm_cmn_node_to_xp() then decodes every device on the X=1 column
> into the wrong XP: X=1,Y=0 devices are attributed to XP (0,1), and
> X=1,Y=1 devices to an index past the end of the XP array. Their PMU
> events end up programmed into another XP's DTM, with the port/device
> select of the intended XP, so the counters silently read zero while
> the rest of the mesh works.
> 
> Observed on a CI-700 r3 with a 2x2 mesh (part 0x43a), where the SBSX
> and HN-D nodes on the X=1 column never counted although the XP flit
> counters showed the traffic. Forcing a minimum of 2 coordinate bits
> matches the documented node ID format and makes all nodes count;
> the minimum had been there until the node ID refactor dropped it.

Oof, I guess it had slipped my mind that 2x2 configs are legal, but then 
come to think of it, for CI-700 I think 2x1 and 1x2 aren't illegal 
either. As far as I can remember there wasn't any reason for dropping 
the "| 2" term other than thinking it was a simplification we could get 
away with. Oops :(

FWIW I also can't see that it matters to go back to reporting 2 bits 
instead of 1 for 1x1 configs, where the "correct" value is arguably 0 
anyway.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: e79634b53e39 ("perf/arm-cmn: Refactor node ID handling. Again.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sylvain Chouleur <schouleur@snap.com>
> ---
>   drivers/perf/arm-cmn.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 68a096c1fe6b..5f369c7a7a35 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -406,7 +406,8 @@ struct arm_cmn_nodeid {
>   
>   static int arm_cmn_xyidbits(const struct arm_cmn *cmn)
>   {
> -	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1));
> +	/* Node IDs never use fewer than 2 bits per XP coordinate */
> +	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1) | 2);
>   }
>   
>   static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn_node *dn)
> 
> ---
> base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
> change-id: 20261125-arm-cmn-xyidbits-16076edf28a2
> 
> Best regards,
> --
> Sylvain Chouleur <schouleur@snap.com>
> 
> 

