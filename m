Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A637C11B
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782702594; cv=none; b=PQrqElOMSW4Kqio8f7v5bH3CXnWLxe8723XYV/bswQe+kcN0kp/bwPyzLLXytoV/EsEJqBazcoeFyUavve/d34YZiM91d6VXZBaiUBGBDiuV8oOZZOmK/lireSwdZgl8FC1eTjNStMfOM/DhBDkzSFmp8KiRrSMHSR9S9ArpkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782702594; c=relaxed/simple;
	bh=F0iWEje7/MV0tnxuJSUIRvg2i47DdRhGwCk0uwhQBJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKUtFrrot6mW8+uVPAd3+40bwkIhwtZv8i1+wpZ9daBkg4AJnpIQT6RjP3SHbQ+2b2M+ymiwpJi+cQ4GiBQXa7Xnst6eARNa5+IwuJINuiiurX6oZMScFVsPruj/giMCDtp57Lkjzl2YaGJ6hFPFSfrTrj87y1wueqkU3rfL9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HSih7s7E; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HSih7s7E"
Date: Mon, 29 Jun 2026 11:09:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782702588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YO0isV/iaz4E4JsnEjuyOE0E6tksfr/W6JQI50/h4j4=;
	b=HSih7s7EByCt5a5CSSuNxhBWolI7qb8eEU7l5rSP9/BN9LwhnC2tDblXsEHO0UfEf0nbX9
	H8OHdwjcOB2wAnQoITApfOXIXEtcWeERgAtN4o13R+FXzmCe1TOTB9d1Uu8aZNQteSzvJQ
	1Drx91Mw1i58rUcZA6gScnixaj0TioA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Greg KH <greg@kroah.com>
Cc: Yoann Congal <yoann.congal@smile.fr>, stable@vger.kernel.org, 
	tytso@mit.edu
Subject: Re: "ext4: get rid of ppath in get_ext_path()" 6.6.y backport request
Message-ID: <chqvh46vg4mqhf4o2famjyd4hglltmgdq5kgax5bppk7a63z3y@uy4rzgtfwsoy>
References: <DJH66E0ZKMBD.RJREJPRY6MMD@smile.fr>
 <2026062418-upswing-scabby-0f83@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026062418-upswing-scabby-0f83@gregkh>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 24, 2026 at 11:38:42AM +0800, Greg KH wrote:
> On Wed, Jun 24, 2026 at 11:25:06AM +0200, Yoann Congal wrote:
> > Hello,
> > 
[...]
> > [ 6952.547197] Code: 2a0103f9 b9009fe1 b9000e99 b40055fc (79401398)
> > [ 6952.548170] ---[ end trace 0000000000000000 ]---
> > [ 6952.551090] ------------[ cut here ]------------
> > 
> > Reading the resulting code in 6.6.142:
> > fs/ext4/extents.c:
> > int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
> > 			struct ext4_map_blocks *map, int flags)
> > {
> > 	struct ext4_ext_path *path = NULL;
> > 	// ...
> > 
> > got_allocated_blocks:
> > 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
> > 	if (IS_ERR(path)) {
> > 		err = PTR_ERR(path);
> > 		/*
> > 		 * Gracefully handle out of space conditions. If the filesystem
> > 		 * is inconsistent, we'll just leak allocated blocks to avoid
> > 		 * causing even more damage.
> > 		 */
> > 		// ...
> > 		goto out;
> > 	}
> > 
> > 	// ...
> > out:
> > 	ext4_free_ext_path(path);
> > 
> > 	trace_ext4_ext_map_blocks_exit(inode, flags, map,
> > 				       err ? err : allocated);
> > 	return err ? err : allocated;
> > }
> > 
> > => Under out of space condition (what LTP does a *LOT*): path is given unmodified to
> > ext4_free_ext_path() that only does a NULL check (no IS_ERR) before
> > dereferencing it. And that produces the oops and then, the LTP failure.
> > 
> > Notably, master commit 6b854d552711 ("ext4: get rid of ppath in get_ext_path()")
> > never got backported to 6.6.y. But does add the IS_ERR_OR_NULL() check
> > to ext4_free_ext_path:
> >  void ext4_free_ext_path(struct ext4_ext_path *path)
> >  {
> > +       if (IS_ERR_OR_NULL(path))
> > +               return;
> > 
> > Thanks!
> 
> Please always cc: the maintainers and developers involved in a patch
> when asking for it to be backported, as we need their approval as well
> before we can do it.
> 

Do we need to revert such patches just like we did for 6.1?
https://lore.kernel.org/all/20260408010208.746177-1-sashal@kernel.org/

CC: Theodore Tso <tytso@mit.edu>

> thanks,
> 
> greg k-h
