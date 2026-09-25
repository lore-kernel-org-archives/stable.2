Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D133B6354;
	Fri, 25 Sep 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346360; cv=none; b=jReVqsq6PTP4OAbwBOHXcNFSeKtRDMXVvqUmgQp26+MU80kJLUWWpgMk184mrp6mj087wKKenFz+py1oqBj+ZVm/T/YbcgPQjeA0xrF4/Ar84XS5R1j+okMgBeL46PpMqDChhstzckp6Ijzg4HY4YgfCb7Dj+o70aoCJQGeSAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346360; c=relaxed/simple;
	bh=LSOWlipYoobVQPZP1Xv8Wc4VrQqxj8hkL1O+YTQeshU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdZmuuSdyviNgTLO+WQiJAidF6W9lAgC3/MlPtcZIrEssD4wKZJTDXX03GVof7z/bPmo7P/21wRJwtxTtStXUO6aE5sE0IwssM/Q63eWcz2KaMqb/x/kqXMyluJHd2mCu6T3e+68ZM8wyvtFocgRictqq3cvVDwOmWcZRFBJUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqB/I6d4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqB/I6d4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FFD1F000FF;
	Fri, 25 Sep 2026 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790346358;
	bh=C6wBAoIl9fhz3/25qhvYixGN6g7eAW6OsiCg6fYvlh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NqB/I6d4zx/1FaHaIYYV72uWLbaJU/JwyQCMnQzWz9T4oVUON7mtSiMSsS0TmiBee
	 sAobsmx5+J3lpjRJAF9iFzVX55UC9gkSs5q3KAFT5XWUeuXItzUJAiHKZVWtOntT2G
	 uhILme6L7agGbXj1z4gTClQ5/7SM9KmF0DRZ8c/euDznmFEAu+uyTfaVAICL9Ou8bR
	 6K4zMOaM1VrdQnCSfrC3sLCEUj2BHay9odI0er1htuFoP6MAENY+NId51AjMR3yo7Z
	 Ms0OiiKWXz9GNs6a+nk+ugC+Y5zb9JHSVef/gnsAGKaEF/OuXtyr8B3RlRvJ8Vi4k+
	 E5fA1kGJ0QdtQ==
Date: Fri, 25 Sep 2026 15:25:54 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org,
	sashiko-bot@kernel.org, hybris <hybris@mojatatu.ai>
Subject: Re: [PATCH net v2] net/sched: cls_flower: exact-match ERSPAN key
 when no mask supplied
Message-ID: <20260925142554.GN13925@horms.kernel.org>
References: <QDISC-4CSL.v2.20260924114800@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-4CSL.v2.20260924114800@mojatatu.com>

On Thu, Sep 24, 2026 at 08:18:41AM -0400, Jamal Hadi Salim wrote:
> Commit 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
> removed the unconditional memset of the erspan_metadata mask in
> fl_set_erspan_opt(). On the mask-parse pass, when userspace supplies the
> encap option key but no mask (TCA_FLOWER_KEY_ENC_OPTS without
> TCA_FLOWER_KEY_ENC_OPTS_MASK), the !depth early return leaves the mask
> zeroed -- a wildcard. A filter keyed on an ERSPAN index (v1), or dir/hwid
> (v2), then matches every ERSPAN packet's values instead of exact-matching.
> 
> Default the match fields on the no-mask path the same way the with-mask
> branches default them: v1 index to 0xff, v2 dir and hwid to their
> exact-match masks. The union cannot just be memset to 0xff -- that would
> re-mask the overlapping timestamp/sgt bytes of the v2 header that the
> commit deliberately left to 0.
> 
> A mask and a key that declare different ERSPAN versions describe different
> union layouts, so the mask would silently wildcard the key's matched
> fields. Reject that combination. Have fl_set_erspan_opt() report the
> parsed key's version back through a u8 pointer so the mask pass uses it
> without re-reading the union.
> 
> This is a follow-up to commit fee10655709c ("net/sched: cls_flower:
> validate mask pointer after nla_next()").
> 
> Conditions to recreate the bug: add an ERSPAN encap-opts flower filter
> with a key but no mask (raw netlink, TCA_FLOWER_KEY_ENC_OPTS present,
> TCA_FLOWER_KEY_ENC_OPTS_MASK absent); dump the filter and observe the
> match mask is zero (wildcard) instead of exact for the supplied fields.
> For the mismatch case, pair a v1 key with a v2 mask (or vice versa) and
> observe the request is accepted with a mask of the other version.
> 
> Fixes: 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826025123.62758-1-ljp1205831794@gmail.com
> Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp1205831794@gmail.com/
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/netdev/179003833955.2160803.1077681716391858800@kernel.org/
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Tested-by: hybris <hybris@mojatatu.ai>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v1 -> v2:
> - Scope the key's version default to the no-mask path only. v1 assigned
>   the key's version to the mask unconditionally, which changed the
>   with-mask parse path for a mask nest that declared no version (nipa M1).
> - Reject a mask whose declared version differs from the key's; the two
>   versions index different union layouts, so the mismatch silently
>   wildcarded the key's matched fields (nipa M2).
> - Set the key's parsed version through a u8 pointer argument rather than
>   re-reading it from the union at the call site (Xin Long).

Reviewed-by: Simon Horman <horms@kernel.org>

