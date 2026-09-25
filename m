Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED146EF75;
	Fri, 25 Sep 2026 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342005; cv=none; b=qV0EzonmSEy3cRGboTZ2CFflDAN/xzOuGRLnpWhHv1vzAWAitc06tI3pkv1WzGhbjg+ElEc2tDqO7WGtJbNBrhXUsjasCriiA8ZjNNev6zf2eoa0GSCOPkXcK9dstdLP5aCa2kavr5sHexvITaVHd6PozIwfoHj+qceePFPu4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342005; c=relaxed/simple;
	bh=/6gBip90GBXQDdZq2MPJw/zNYdq8kQI02YUI5ZI+vsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwQ87g2+QJMX10IHMVm2z4Vk9iDi1hhuRR9gOa/dZWCnymaPoY59f3TUMdAQs//JNW3h+sg6NC51ola3xiw6fYdtyRWPb+qwu4aAHkmirNW+sqxZ72LYnHaOsFbjs9mEnbq32dY5u7/o+JCGQzKh+BKDZrOTMH302kNfsaeKwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9MXET6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9MXET6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD3A1F000FF;
	Fri, 25 Sep 2026 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790342000;
	bh=2pUvtFKKkBhLOY/E+/Hhh8fL8Ve/qhFsisMU+/7F7Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M9MXET6ZxusfItvf4j6h820H+ZNZcPxwPS+FUzMcGJXI0QSF5nh3AdWz6bAJ+d3xh
	 xjBSU0gnQaYDTS85b8XyebzgHiP+BU/hTw091SlIE9gIb/7UcNSAt6yWsWXXQGX6r8
	 LVa6/X5aaH+wvE4j4SRybsgMTHywKKk4Td6qQ7HSG9RHnY2f19YMZfl5v5h5jX73KA
	 Ib3IxQUbNo29C5UK0saN34A36ZZqGHN/o4K6ePIpf3GKx3ToCvS0ms5wZynEI1k36j
	 XEFWdHr83Rf+7jP3UJfFp1M3Y59dme5l9HByE+23gf910Q0GZ+0z+6PgRWVfE8RfBE
	 yTNHtfWV35mzA==
Date: Fri, 25 Sep 2026 14:13:15 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, hybris <hybris@mojatatu.ai>
Subject: Re: [PATCH net] net/sched: cls_api: reclaim an empty proto on the
 error path
Message-ID: <20260925131315.GK13925@horms.kernel.org>
References: <QDISC-JCOT.v1.20260910090924@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-JCOT.v1.20260910090924@mojatatu.com>

On Thu, Sep 24, 2026 at 04:32:49AM -0400, Jamal Hadi Salim wrote:
> Two racing tc filter add requests on the same chain/prio of an
> unlocked classifier both run change() on the shared proto and both
> can fail: the winner's tcf_chain_tp_delete_empty() attempt gives up
> because the loser's handle is still in the idr, and the loser's
> error path drops only its own reference without a second reclamation
> attempt. The empty proto stays linked in the chain, holding the
> chain reference, a block reference and the classifier module
> reference until the chain or block is torn down.
> 
> Reclaim the proto on the error path of any failed request that holds
> a proto reference. The reclamation is emptiness-gated:
> tcf_chain_tp_delete_empty() unlinks the proto only when
> delete_empty() admits it is empty, so a live shared proto is never
> unlinked. A proto the request created is reclaimed unconditionally -
> it is the only owner, so marking it for deletion is safe even without
> a delete_empty callback. Classifiers without one (the check marks the
> proto unconditionally) are rtnl-serialized, so the raced window this
> guard closes cannot arise for them.
> 
> This is a follow-up to commit d4e359b3608a ("net/sched: cls_api: fix
> teardown of an adopted proto on insert-race loss"), which stopped the
> loser of the insert race from unlinking the winner's live proto but
> left the empty-proto residual in place.
> 
> Conditions to recreate:
> - CONFIG_NET_CLS_FLOWER=y; veth pair
> - tc qdisc add dev veth0 ingress
> - two concurrent `tc filter add dev veth0 ingress protocol ip pref 1
>   flower skip_sw ... action drop` (both fail in fl_hw_replace_filter
>   after publishing their handle in the idr); repeat in a loop
> - an empty flower tp stays linked after both requests fail; visible
>   as a bare `filter protocol ip pref 1 flower chain 0` header in
>   `tc filter show` with no filter entries
> - CAP_NET_ADMIN (namespace-local via unshare -Urn suffices)
> 
> Fixes: 8b64678e0af8 ("net: sched: refactor tp insert/delete for concurrent execution")
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805134049.927864-1-victor@mojatatu.com
> Tested-by: hybris <hybris@mojatatu.ai>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

