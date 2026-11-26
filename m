Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702138;
	b=oiP+/QTWcqBrfR0w2QYimOT3Wr2mD6lypEPovNjEaLRgM9IOeVuNKTtuvr/vHeH8l5Yp
	 x71Wh517pss11wcdI5accGuBtgGAdyBNbC0tyu1lSFMv3miZfYrN7OxMTqVuVjjDr/Nk4
	 /FTuulQINzEfdCRYwxiXuBmnKbmAHzq1tyn+lZHobSyoL7ZYNs4T22RqVjiagOKV/w1NH
	 lIC2EsaDYmNgMdcOs69VJaAy8212A4H2w49dPPl/YFNr7PQS4tdEUqZ0GshAyps7fUKq9
	 9wFtNzugr/RLQ6AlmET+6K+1UQsLg6VBLjIBfcFRosxT3awpLIXSN7frJUhgk0J4kNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702138;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ycz4zN8OJGHkVYq0dR22YPKKxsW4H2gix6T/uO2MvZc=;
	b=1nK3b9Khxmvb4rKYQmGbfVgVjXGNY7jeZOId0mJvyvKY60bSTLGIBR3mUgpUoHL0R3Ip
	 7idioKvQFtRqggJqnGO52/7ZG4TAO/O12nXmJ4hO/2R+Y2wbuHUqIDDlCG+gK5ekouk/6
	 QCQl5HeyL2LzDXvfKQzt6Hn1bGtjXOAlDHkER1jUtS4G7zsCfREZRmpXIqID9j3n7FFry
	 L7l89HlR1Fk4zmQLZ6AdfUy3RGZ871lEfvhdYCc5GrjbqPe5RoD42MH+r+MUdHWMuVBoP
	 Sbh7hOUekUe1aTrA8nPk5K5WnwFjrn4wC2tNHWQYRSiIEpJbL7gHKfRckHN9HyL21EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJOsD03i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CB606A331;
	Thu, 26 Nov 2026 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJOsD03i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352F91F000C0;
	Thu, 26 Nov 2026 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702137;
	bh=ycz4zN8OJGHkVYq0dR22YPKKxsW4H2gix6T/uO2MvZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SJOsD03iiSTrVhmnyD961u/NuqqW5Devu9pnbYz5JxC7dUJP1I0Bqcipy6wgRXLLu
	 EvESMbVecbwkkgAmq2uFk5XFlkofzP/HkwUNRrxxED4BhoiOyemaaaiaum5WfIGB7L
	 CHBkT5dv+GKkLRgKBkO95lxLVXkKN7c+RJqrVQ0uRl+QDeMbpEdgr7mYVNSG9s63x3
	 t96VMLSPOLUtkLhho7Su00TPCx/1yWJKxS0hlyFN5gysJLkJxJOKazDUuQI6iICGtb
	 jwo970nEJ+jERI24GXm49GO3GCozCvRh6PDX2PRcavUdp2HbuJPdqPzpvoqyMGYqzw
	 9cio0Kn4Ff3oQ==
Date: Thu, 26 Nov 2026 14:08:52 +0000
From: Simon Horman <horms@kernel.org>
To: Yuqiang Sun <izaiahsun@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	m.wilczynski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: Do not free a preallocated node in
 ice_sched_add_node()
Message-ID: <20261126140852.GA31322@horms.kernel.org>
References: <20261119055731.55798-1-izaiahsun@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119055731.55798-1-izaiahsun@gmail.com>

On Thu, Nov 19, 2026 at 01:57:31PM +0800, Yuqiang Sun wrote:
> ice_devlink_rate_node_new() allocates a scheduler node and stores it in
> the devlink rate as priv. When the parent is set, ice_devlink_set_parent()
> passes it to ice_sched_add_node() as prealloc_node. If allocating
> node->children fails, ice_sched_add_node() frees the node with
> devm_kfree(), but priv still points to it, and later rate operations
> (setting tx_max or tx_share, or setting the parent again) use the freed
> node.
> 
> Only free the node when ice_sched_add_node() allocated it.
> 
> Fixes: bdf96d965a20 ("ice: Add an option to pre-allocate memory for ice_sched_node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
> ---
> 
> Notes:
>     Bug was found by kbound, an internal static analysis prototype.
>     The fix was written with the help of Claude Opus 5.5.
>     
>     Compile-tested only (x86_64 and arm64 allmodconfig, W=1, sparse): I do
>     not have E800 hardware.

Reviewed-by: Simon Horman <horms@kernel.org>

