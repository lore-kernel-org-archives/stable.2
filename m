Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A92233723;
	Wed,  5 Aug 2026 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888416; cv=none; b=hT+1ApmkpmEMEe9kNDvQ5oJeIVgLBXF0SD+TzN/I5oTymhvHqpgFyNLV9hxr89670ZzEmEgXAUhGRbRoXBi75U8asKQf124S0vocTquu10zcdG6mvyQlsMRZSIYX5yfeZobAbaM1+M0ClthqfJafvTLU3XpwRbi+r+qz2TqCztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888416; c=relaxed/simple;
	bh=Gj6pPKwL+wKGgG/tCBPzy2c0o7o+L4sFvKl6Ef5bx3E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=vD0e47T6f6pi5DppC3Fzk8jH3qLrZi/k6B+xYxMEvFIBRDn4maEvyvU0pX66JssDFQOU+sSoR59MSTDI4guT2G5NB0pAHEYx8XtPNoMcbW0ZSJ7s2ZZZSwCKKWbKL9EEm45pBgthJGakYcfzDeDfrwvtLUw841aMeo1dKJFTNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzgzDjhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzgzDjhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F9A1F00A3D;
	Wed,  5 Aug 2026 00:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785888415;
	bh=fQGXTT1iD4XOXkRDxR3dG4pIjyvECfsrSvRyXf46TZw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=VzgzDjhi9Ja1W5hLt58pREs7AZFSvpvy+GUFRil24u3tV25E8RAAKfLuev7/BOVmP
	 vHrhIqZhEvjxvB+PAVngR+Oc7nuvxKikPu/g+GEGygo4OY3dKClZNCVXwp1HJEleR+
	 vxA09ZFsznPAeqmkWkTOlIEyfzrVBmq3rM33fMghLrZbdudoWcu0Fzdw3HRuXOwX21
	 Goe8hzAwyafEPHVULdX1pg5cN7/3/qGFxy4somCLRZzzRVSSf48H8Le4EmPr1PlG5Y
	 T4jU8POAIlgo2zsnrojq27axy/FhY0EDnxLvcOMc844HsFlT2JPUauNxRn0NyO2qpZ
	 po8godmRCI81g==
Date: Tue, 4 Aug 2026 17:06:53 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
To: Yifei Gao <gyf161023@gmail.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>, 
    Latchesar Ionkov <lucho@ionkov.net>, 
    Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev, 
    Christian Schoenebeck <linux_oss@crudebyte.com>, 
    Juergen Gross <jgross@suse.com>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] 9p/xen: fix refcount leak in p9_xen_response() on wrong
 tag
In-Reply-To: <20260804213550.3409638-1-gyf161023@gmail.com>
Message-ID: <ebcebd30-68e2-1650-f0e6-b69e4239619c@kernel.org>
References: <20260804213550.3409638-1-gyf161023@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Aug 2026, Yifei Gao wrote:
> p9_xen_response() looks up the request for an incoming reply with
> p9_tag_lookup(), which takes a reference on the returned p9_req_t. When
> the tag does not resolve to a request in REQ_STATUS_SENT, the function
> warns and continues the loop without dropping that reference, permanently
> leaking the p9_req_t and its msize buffers. The reply header, including
> the tag, is supplied by the backend, so a malicious or buggy 9P backend
> can leak kernel memory on every crafted response.

Most backend are trusted, including this. So I would avoid "malicious".


> Drop the reference before continuing, mirroring the equivalent path in
> trans_fd.c.
 
It doesn't look like trans_fd.c behaves like this patch?


> Fixes: f66c72bea129 ("xen/9pfs: receive responses")

This should be 728356dedeff

Aside from the above, the code change looks correct

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>
> ---
>  net/9p/trans_xen.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index f9fb2db7a066..8eea0da8797f 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -203,6 +203,8 @@ static void p9_xen_response(struct work_struct *work)
>  		req = p9_tag_lookup(priv->client, h.tag);
>  		if (!req || req->status != REQ_STATUS_SENT) {
>  			dev_warn(&priv->dev->dev, "Wrong req tag=%x\n", h.tag);
> +			if (req)
> +				p9_req_put(priv->client, req);
>  			cons += h.size;
>  			virt_mb();
>  			ring->intf->in_cons = cons;
> -- 
> 2.43.0
> 
