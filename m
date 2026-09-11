Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB5453A28
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129416; cv=none; b=WXv9ahEa+0WFowp1ZLQr9QCsoAPo82Nk5GP9g6Z1Ai/b7hxe2n+sIIZ2bZwe539DkBAEq7LFo3jrxLv3S9+sZMApcNdQ346vfNJ06y1FlLsdD586c5b1baJ/CInbj801uDo1TKh6oC2wQ/AxLoIw0qhdoptwQ3a8GCozXTwb2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129416; c=relaxed/simple;
	bh=Rba+A5pnVBMGG6Tz4mAtVRNcXYTLljQpHl05prrlDnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqIYEBrBYp5gYTVnSoJv8EoEpCNhWq+i6mcrtw45Ie3uhBvUctsJT6ga6VQyV3ug0q2drrEkjeCGqChpQDX7DUy2/EFmOEzX7a484QkBkTP8/8zsl3NZuHCHdCUQbhFYhj6fO61ML/82ZJSqpGBTUDCqgNH276yEnteF9woG3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=jMdjuVVc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDfItkgy; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jMdjuVVc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDfItkgy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DA2811D000A6;
	Fri, 11 Sep 2026 08:23:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 08:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789129408; x=1789215808; bh=Tiei/YRY/8
	FOVzxdFIGpZyCohcTCb/in3Nl60RG+sds=; b=jMdjuVVcChV0NZe88KBb5TR6qz
	zoESdLtwnxJI/wWItun3rAZV4nQ2cwScauuv0qH1pHosNd689Ih8FQC7Zfsa48Zk
	t1FKkwLlnQgyzqgKb92BwFWAe8nDo6kTo8SHM48mXUqIQkJc+8CjNjsXuO772Zi3
	OKY7GRWG4M0XuzzhotPd25EGhp6Tk+gPX/hy+Zb5Co0gOKpYwO6iPZ2Fm/zjTy/w
	4DBaLSP52nhj1ltHgqsyJbB1E9RusTaItlVhe+xWdfetlkp8C4mDl+jaY9WHlA5Z
	zFKHn6Ujs5GwvMuBtnLc4NEjn+0ig3umW+fGuYlA3MVSeLKgDRwxr/ig4JIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789129408; x=1789215808; bh=Tiei/YRY/8FOVzxdFIGpZyCohcTCb/in3Nl
	60RG+sds=; b=hDfItkgyuFBUq7kL/p4Flku2mwoPoa8Z+nOJg49q9WW4Gis5+OU
	iJS9N/ewLs27KOLlPsU7rtYafZ0U0+E8nC/SNNLMXiIlWAM5kLVIty9bxGwf8npp
	l94bco2wWW/O3DPVHc+DGPFbJw415IPKerjja8JEMLHkXPhmAeO/GBbMQlWoM0JA
	CsXtYZjt97oEwHWrk8X/bkZ3Wc8QEoUJ3w5rjztxBjP0rtrupoNqi0qYd/reO7q8
	qNkmSsV5BSvwGxdvJU4z5pfbO6qKW7+cabPBDTf0mLW2fIteGobb7J7Td+j1E+lV
	sXA6jP0RuBPRVUKqx1sHacrWA8QPZRLBKqw==
X-ME-Sender: <xms:wPKjahCFfyxhBYgrVVcUoP3a0e0FrstprdZIZ7kcqizvXhJ94H2sHQ>
    <xme:wPKjapglgYM29o98dsUpJIMWJPo_knpFoe_gQTJ2J4DcjBkR2LmV9pssaqN3RWy95
    U0TxQDG9K4sBe4K9co6QeVZleoLsBf097XF_gUtdT-2P7wYHw>
X-ME-Received: <xmr:wPKjajMgIqaaLOs5Niw9v8F0mf5fJnHoDHxBybfJf6wlqRRgve94JixGvEoRn4O1_4tnGb0Ta-mhTPiXFo_XdgAfPcIYAlsBcRuUhDUF68M>
X-ME-Proxy-Cause: dmFkZTE+6EtaDKw1FhMvfcnRri4SgjWYnFWmAFh7um+ZvIT5cPTnfVndZwC6eLRXypZhk3
    AI0iNquSPX4B7H3xQILtOD+Xt7tVM6TgXZEe70ofy9xhNdmKlffYIbIQiTT3bq4yoou2mX
    ozVD81Fc2KVz2hT/rbH5rU6DbeQwImUVE8e7X2rCGdkaYMCW9mDV77hgd02M+WQ54LJncU
    ighyqUn0fvyhPecQJQZfefjgWNLf3cjsMCdUEZ3I8cLOH65nF6Jeq5CJTdjPsfYgPPpijy
    JOKb6DBUfkXR/3O08kKWgs8OhJQD0ZOmsmLvGPGO3pJrYm7dpKCGlYfY5EiM29u2FOlDmf
    wgLHhFOtiWior3mWEpF3OfdFLtk3uzIEnTvWNQFfoK4nkWWzKnSA8mkjH3ki3epMDlWLja
    et8l6OlQ3DPZ4ZYN+fJCx5X9eyzH2UErvSTjASLzuw5hOHfCHi0Ew25WO01wtD6c7rOIsn
    mCrWT4sFQbjUhFwtoLMkxAB9aDjQ37fWeeavJZfkzr5fx0WigJBy/WCPVzWKqb4BH4qRd2
    wHP6Klc/95ExQoLoZKss5/cDvxjSvPZIc/ZHgxoWoE5Am16VWilO1wWC9iP0jOBGo8REcJ
    LY5EYe6B3qwrUYDwFqh+1/K6cXIlD4JRF+EO9JnORyq3NUh96+VjrV3nKLWg
X-ME-Proxy: <xmx:wPKjap-FMS83NyNFRmKU_4r2htrwJx3t-dBu0KQx5YqrhuIVp4FRpg>
    <xmx:wPKjakcPein1BVN08FmCIE5fT39W5pQpT5TGMPKJxR9lJ1mdsBdiGA>
    <xmx:wPKjaowr2iw9ojO9SdteOYpWgaKkqVfa4tzznMTBNQm6izFvttW9bg>
    <xmx:wPKjapInMjBEGM0gRVh8u8z9rUMDQEA50KprtysPEjWCqXYott_Xzw>
    <xmx:wPKjamXGy9-UuLdX4aBFYBgujgCDq5RioD4s66nN90Idd69buHnzUed3>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 08:23:27 -0400 (EDT)
Date: Fri, 11 Sep 2026 14:23:18 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Bryam Vargas <hexlabsecurity@proton.me>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 7.2.y] dm-pcache: bound the logical key offset from
 persistent memory
Message-ID: <2026091113-recent-cloak-163c@gregkh>
References: <2026090433-ebony-snore-69ef@gregkh>
 <20260910001829.3751733-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910001829.3751733-1-sashal@kernel.org>

On Wed, Sep 09, 2026 at 08:18:29PM -0400, Sasha Levin wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> [ Upstream commit 97fc4b53dbe4a983fdf093243067fa6a64562307 ]
> 
> cache_key_decode() takes a key's logical off from the cache device and
> later indexes req_key_tree->subtrees[] by it in get_subtree(). An off
> past the device forms a subtree pointer outside the array, which
> rb_insert() writes through during replay.
> 
> Reject a key of zero length, or whose off+len (computed in 64 bits)
> exceeds the device size, before it is used.
> 
> Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> [ adjusted context to account for the missing cache_seg_id_valid() check. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/md/dm-pcache/cache_key.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
> index 51dd1ccf4e2fd..c98005d16fd6b 100644
> --- a/drivers/md/dm-pcache/cache_key.c
> +++ b/drivers/md/dm-pcache/cache_key.c
> @@ -90,10 +90,19 @@ int cache_key_decode(struct pcache_cache *cache,
>  			struct pcache_cache_key *key)
>  {
>  	struct dm_pcache *pcache = CACHE_TO_PCACHE(cache);
> +	u64 dev_bytes = (u64)cache->dev_size << SECTOR_SHIFT;
>  
>  	key->off = key_onmedia->off;
>  	key->len = key_onmedia->len;
>  
> +	if (key_onmedia->len == 0 ||
> +	    key_onmedia->len > dev_bytes ||
> +	    key_onmedia->off > dev_bytes - key_onmedia->len) {
> +		pcache_dev_err(pcache, "key off %llu + len %u exceeds device size\n",
> +				key_onmedia->off, key_onmedia->len);
> +		return -EIO;
> +	}
> +
>  	key->cache_pos.cache_seg = &cache->segments[key_onmedia->cache_seg_id];
>  	key->cache_pos.seg_off = key_onmedia->cache_seg_off;
>  
> -- 
> 2.53.0
> 
> 

Does not apply :(
