Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5F4E1C80
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775813; cv=none; b=ROw2wa3qOpWFeDLVAJLkacQA9WZ9qjFpr59dTrllAi+OMG9sA/HDnrU3AconP2exBKTSgHU+DRvowktZxbp6cmUVyg0mcQwNqXqxlCtcHMGsZM4y4xHORFtj6mZGGn60FTXEpV6EGz7/4GqukF+k3H0GFKYEsBvGVuMyIhwnH5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775813; c=relaxed/simple;
	bh=Wdr8c2wfYF34EUeooFoL0rONqBxFLbZbLcfLYRTNMbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egBvrIhzZ5UE4b8q3QZHmeyjjwDHydfrQSNEtFthHBkmTbEVsUnyRWld+ZEEC/uXH4wEOn1MIl5VGIKbKNr2yKzIkqLAa75/5eevF+UOZPcJfuOBPn4gu7u+NZudObFc5+LF6j2VTpHOTkdC+PKaXr77MGW2zR1FOCXh5+bXycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=S+twD0qQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOhiBFDm; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="S+twD0qQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOhiBFDm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9EC3D7A06E8;
	Wed, 30 Sep 2026 09:43:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 09:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790775784; x=1790862184; bh=R/q06XrBMw
	3vJGIgomH0JO9P1z+/81FA2TDId+xZeiw=; b=S+twD0qQmjGyyXni1n9IJdjbgn
	pndRVhXWpU6Xz8E1g8RkwDgPsvoY/R3cfVj8ROKPy7rXgvKm1BV5WrKt/ut5xoYi
	SZraWGDG3jnc+r/WHIqnLC06BV5U6kgenHESPU4g3TklwkpOOgMvEFbtAWCi2r+Q
	HhHN3HUUtstuWQvoLfM9WTgbQKfRTm3UXFUm78Rkd06Z1Ur7D4d7TN6FoWokmgEd
	MWUip6BzW9+2A/wsiJIUUXil+x/C7FhL3b4XaCTC1uo0daLdUEHC89YbbwC0D6Ke
	GdBY86Ahwx17gMbvZerX2dZmuonUa7YmpuA8dUcvxy0Bbu+razohWHmclB6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790775784; x=1790862184; bh=R/q06XrBMw3vJGIgomH0JO9P1z+/81FA2TD
	Id+xZeiw=; b=MOhiBFDmFuBVSpi9mon1CZ4ggfFiWhXYveKzoMs0W404tYiFL0K
	QZsc1zugzDqF09F6ih6NVT3TgjFx5oGVeetDFfhmNJr73TopNKLqZcLtAVLAhQS9
	cj/mF9rDqrwfkICTvUO0pcq80kQ2XUObU0hKDaBlxs2vsVHDgn6WRYSX6RSXSYSF
	T4HD2XMg7KOej/oqdoujvX9izJUAxtRewo19n37xMlQphaesBydc8G6E7injW2AU
	8+KRsTEkobVN+o+gk58BRw3A5ipI01zKa448C1UX/hAD0t/gMTkYaD+lH+UJRqlN
	XvnMqZaZQOTBqko7gscLB0T3bhmP3bdOPJA==
X-ME-Sender: <xms:6BG9as4SX2Gsdnp3F9A-usvRgH2Nn9Dgb5ySLQD8x66_6KN2KXGxOQ>
    <xme:6BG9ag8XvQomvlb8HI83XUZseINQI2LGODVeo25BJh7hGyreGurs2aPfTJCwqIUWS
    72coH1_gvT52oPtHVYYdk6Ii1w47uU1u3jLNKre0NoS7wJm2w>
X-ME-Received: <xmr:6BG9amEjLBWk09LsTpw9QAXhft7nntMaA6361AvW7-j0iRvUVeCqKT_KhGhHJQqlLn5wJI_4lZQFl14mnAlXggyfgpJ7_UTDjXLkKeKbmGI>
X-ME-Proxy-Cause: dmFkZTGcIHTRpi6ybHnLVWoKaKhHsJyXy2jHuar2Yx/7ajNNQEV+H2EVlExlIuezGNAB5h
    p2rngEaW/fvsHXsC7CuH30+X/+g2njBwecvkWrQUQgmcZaGJSmQ2iXSRQ6JSSQZiOK9ZrH
    e2zJhj+Y1DzXFme84Tu4GGIzFmOdDDkTcJ9ZXIKATXH3cvnKpX8HZA8E7VJWnP+Xc7St4D
    vldotRncYcg9pdXY9mpAgNHDvaUVRAC9LPNSbvIdY4kPmZU5t4OSozf//4NYB7hxsNsQYc
    WvUekE/3UBqjJTzj9nsD6gjm5u2CubRaW/SFHm2HztJlW4gd347efQAt41OU42Q+yaIsVb
    phN5pB1l4WtUYGUX4gQH0keeGCSLgxzIIbAkGO3GuiC5Ot1OziQ+mTbIiASLU3y+nolYfN
    knz9W1TSCTF/nL7IhfFk3O8WdShhoZz/UE9EpDhc54ihoT0aEmCoXPQlJ222Ylbm4Tz2UL
    3hnyoUqMQtjpe9YCh3SowY3gpuugN1/ujJN2zu3wZZgr8j5jmwi8sq2QeQvPUDpC3lYSLm
    b8W5LOAf0Ic3GgTajT3qjqZymqt4hH30UPLP+ONwie3ybxNfg+WYinlljAYdrEGdLFLjH8
    1mEzH7kOlOIQIgs5dNcOtrTBFq3S9dvQzXIllpKGAYHTtw1d5HCqX2j+trTA
X-ME-Proxy: <xmx:6BG9atWtAkC7rLat3pAcBTcA7PNjv-TRT_0iqEvN1oATKgJyN_eyrw>
    <xmx:6BG9aq_KbTMbdsBR0Yvqus-03cA5F9czBqlEsSpPjmUYJSWaR5HAHQ>
    <xmx:6BG9ai6XnudcrEwW7Mbj0V9eAVmErxAddaa6uWciJytb3ZdUkK2khw>
    <xmx:6BG9arl0POYdmlgGvbQENdZ52FNFdrJpdGNzzpnLiRgh5YrgV_WrGw>
    <xmx:6BG9ai7Icn6WJqWF7bIkmFLQVKrqCrNbBYsRtoyijv2qcmUCd4Ijwhfg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:43:03 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:42:58 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 6.12.y 2/7] f2fs: Add f2fs_new_node_folio()
Message-ID: <2026093054-denim-imaginary-6e6f@gregkh>
References: <2026090957-stoke-condense-f9b1@gregkh>
 <20260912013222.1762882-1-sashal@kernel.org>
 <20260912013222.1762882-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912013222.1762882-2-sashal@kernel.org>

On Fri, Sep 11, 2026 at 09:32:17PM -0400, Sasha Levin wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> [ Upstream commit cfa809146f8223c2953e7553f830c0877921f9de ]
> 
> Convert f2fs_new_node_page() to f2fs_new_node_folio() and add
> a compatibility wrapper.  Removes five hidden calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Stable-dep-of: ce366bfa821e ("f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/f2fs/f2fs.h |  8 +++++++-
>  fs/f2fs/node.c | 28 ++++++++++++++--------------
>  2 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e1cbd3917b9d9..713d8907859a8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3740,7 +3740,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
>  					unsigned int seq_id);
>  int f2fs_remove_inode_page(struct inode *inode);
>  struct page *f2fs_new_inode_page(struct inode *inode);
> -struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
> +struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
>  void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
>  struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
>  struct page *f2fs_get_node_page_ra(struct page *parent, int start);
> @@ -3768,6 +3768,12 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
>  int __init f2fs_create_node_manager_caches(void);
>  void f2fs_destroy_node_manager_caches(void);
>  
> +static inline
> +struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
> +{
> +	return &f2fs_new_node_folio(dn, ofs)->page;
> +}
> +
>  /*
>   * segment.c
>   */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 1f4f68e56d432..6989e5afea551 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1336,19 +1336,19 @@ struct page *f2fs_new_inode_page(struct inode *inode)
>  	return f2fs_new_node_page(&dn, 0);
>  }
>  
> -struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
> +struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
>  	struct node_info new_ni;
> -	struct page *page;
> +	struct folio *folio;
>  	int err;
>  
>  	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
>  		return ERR_PTR(-EPERM);
>  
> -	page = f2fs_grab_cache_page(NODE_MAPPING(sbi), dn->nid, false);
> -	if (!page)
> -		return ERR_PTR(-ENOMEM);
> +	folio = f2fs_grab_cache_folio(NODE_MAPPING(sbi), dn->nid, false);
> +	if (IS_ERR(folio))
> +		return folio;
>  
>  	if (unlikely((err = inc_valid_node_count(sbi, dn->inode, !ofs))))
>  		goto fail;
> @@ -1379,12 +1379,12 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
>  	new_ni.version = 0;
>  	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
>  
> -	f2fs_wait_on_page_writeback(page, NODE, true, true);
> -	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
> -	set_cold_node(page, S_ISDIR(dn->inode->i_mode));
> -	if (!PageUptodate(page))
> -		SetPageUptodate(page);
> -	if (set_page_dirty(page))
> +	f2fs_folio_wait_writeback(folio, NODE, true, true);
> +	fill_node_footer(&folio->page, dn->nid, dn->inode->i_ino, ofs, true);
> +	set_cold_node(&folio->page, S_ISDIR(dn->inode->i_mode));
> +	if (!folio_test_uptodate(folio))
> +		folio_mark_uptodate(folio);
> +	if (folio_mark_dirty(folio))
>  		dn->node_changed = true;
>  
>  	if (f2fs_has_xattr_block(ofs))
> @@ -1392,10 +1392,10 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
>  
>  	if (ofs == 0)
>  		inc_valid_inode_count(sbi);
> -	return page;
> +	return folio;
>  fail:
> -	clear_node_page_dirty(page);
> -	f2fs_put_page(page, 1);
> +	clear_node_page_dirty(&folio->page);
> +	f2fs_folio_put(folio, true);
>  	return ERR_PTR(err);
>  }
>  
> -- 
> 2.53.0
> 
> 

Did not apply 
