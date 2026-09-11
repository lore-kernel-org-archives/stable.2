Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74C377ED4;
	Fri, 11 Sep 2026 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116450; cv=none; b=eHXHMABXdgxhtKYCjlLQ2q9Ei7aG98RyiwAhnR+Avfn40Ut9Iz4cgv/Qe8+tvIctE0vLmNX2Ey4qSznSSeQN0E5VkMzpkjy56I/9cK6x4id5WSXw7tPhFyhALtxnh5KKozbmgfrmt/tgUuU/DmclKcBQ0LD+7LfLOyegKBNibSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116450; c=relaxed/simple;
	bh=7sqbU5NhlGn1jaGkoMVet5oed2P//p9TFfF5dXOZpW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5BbxeoPgCu+PunZzGRr+Z1jcQ3S+k9xFNRh9uhim/4NieVS6MsCFe+kot0x9bwya9IFfbGsCFVaZhplaWTfdT27aqrRAzguk3JRlz5saYq6Xi4ExIUZvLKeBfArt4ueqOQ8q6nScpsvQ49XoJ6XZI+vStu+VfdyZB4zuiwwBN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=FF9Sb8v1; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="FF9Sb8v1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789116447; bh=7sqbU5NhlGn1jaGkoMVet5oed2P//p9TFfF5dXOZpW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FF9Sb8v1wH8Tz01M2JGP/W/KXQTX2mqLY3wyClB21ixk9ecbG3KEb7hWsR52qhXJb
	 Qtq/giI2+V+idw9uKDBORv5se9FjmjFjqcyA0Jau6cnSMo2oKlz7IjwXxrqZl7M3mS
	 sbU17qNjATVZSFN/6gy7VYQcBdLHYH+wWM29vd8cTaol09+xdzk4AiECX9odTrHc72
	 cnz2OI+XffsGkf1YBLR8lvImg0Zbtd0tDiSW7sHX3WtRDoVSGpIjCohAhG3Vf+SUxA
	 EUnbWbaPtPdXNOsp8fJMlyG4dFCrP4fYe2i2+eNSOv9Yafv2+6dhtjqf+FVBy1MNe/
	 OKmj40uK7ytZw==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id 3526441444; Fri, 11 Sep 2026 09:47:27 +0100 (BST)
Date: Fri, 11 Sep 2026 09:47:27 +0100
From: Sean Young <sean@mess.org>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Rik van Riel <riel@surriel.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/19] media: rc: Add missing locking for keymap
Message-ID: <aqPAH1Tye_3nwXYA@extorris.mess.org>
References: <cover.1788882189.git.sean@mess.org>
 <c957961ace516127981378f18ec20e2496f79559.1788882189.git.sean@mess.org>
 <3a466e0c-9db2-4b41-a1e2-a52d933d8137@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a466e0c-9db2-4b41-a1e2-a52d933d8137@kernel.org>

On Fri, Sep 11, 2026 at 10:08:03AM +0200, Hans Verkuil wrote:
> On 08/09/2026 17:51, Sean Young wrote:
> > When the rc_map for an rc_dev gets updated, locking is required but is
> > missing in places. A concurrent scancode lookup and a call to
> > rc_{register,unregistered}_device() could result in a use-after-free;
> > this could happen if IR is decoded during those function calls.
> > 
> > We also fix some ugliness like open-coded krealloc() and removing the
> > pointless alloc member of rc_map.
> 
> I would recommend splitting off the krealloc changes etc. into a separate
> patch. It made it hard to review this patch with that change thrown in.

You're right, this commit has become to big and needs splitting.

> > Add lockdep assertions where locks are required.
> > 
> > Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
> > Signed-off-by: Sean Young <sean@mess.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/media/rc/rc-main.c | 122 ++++++++++++++++++++++---------------
> >  include/media/rc-map.h     |   2 -
> >  2 files changed, 74 insertions(+), 50 deletions(-)
> > 
> > diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
> > index 88d8f7d4aab3..04204559959f 100644
> > --- a/drivers/media/rc/rc-main.c
> > +++ b/drivers/media/rc/rc-main.c
> > @@ -17,9 +17,8 @@
> >  #include <linux/module.h>
> >  #include "rc-core-priv.h"
> >  
> > -/* Sizes are in bytes, 256 bytes allows for 32 entries on x64 */
> > -#define IR_TAB_MIN_SIZE	256
> > -#define IR_TAB_MAX_SIZE	8192
> > +#define IR_TAB_MIN_SIZE	32
> > +#define IR_TAB_MAX_SIZE	1024
> 
> It doesn't hurt to keep a comment mentioning that these are the
> min and max number of entries.
> 
> In general I found it a bit confusing that 'size' refers to number
> of elements in variable names, when it is usually the number of
> entries. Perhaps something to address in a future patch.

That is confusing. Let me re-write it.

Thanks,

Sean

> 
> Regards,
> 
> 	Hans
> 
> >  
> >  static const struct {
> >  	const char *name;
> > @@ -105,7 +104,6 @@ static struct rc_map_list *seek_rc_map(const char *name)
> >  
> >  struct rc_map *rc_map_get(const char *name)
> >  {
> > -
> >  	struct rc_map_list *map;
> >  
> >  	map = seek_rc_map(name);
> > @@ -202,7 +200,7 @@ static int scancode_to_u64(const struct input_keymap_entry *ke, u64 *scancode)
> >   * ir_create_table() - initializes a scancode table
> >   * @dev:	the rc_dev device
> >   * @rc_map:	the rc_map to initialize
> > - * @name:	name to assign to the table
> > + * @map_name:	name to assign to the table
> >   * @rc_proto:	ir type to assign to the new table
> >   * @size:	initial size of the table
> >   *
> > @@ -212,23 +210,33 @@ static int scancode_to_u64(const struct input_keymap_entry *ke, u64 *scancode)
> >   * return:	zero on success or a negative error code
> >   */
> >  static int ir_create_table(struct rc_dev *dev, struct rc_map *rc_map,
> > -			   const char *name, u64 rc_proto, size_t size)
> > +			   const char *map_name, u64 rc_proto, size_t size)
> >  {
> > -	rc_map->name = kstrdup(name, GFP_KERNEL);
> > -	if (!rc_map->name)
> > +	struct rc_map_table *scan;
> > +	unsigned int alloc;
> > +	char *name;
> > +
> > +	name = kstrdup(map_name, GFP_KERNEL);
> > +	if (!name)
> >  		return -ENOMEM;
> > -	rc_map->rc_proto = rc_proto;
> > -	rc_map->alloc = roundup_pow_of_two(size * sizeof(struct rc_map_table));
> > -	rc_map->size = rc_map->alloc / sizeof(struct rc_map_table);
> > -	rc_map->scan = kmalloc(rc_map->alloc, GFP_KERNEL);
> > -	if (!rc_map->scan) {
> > -		kfree(rc_map->name);
> > -		rc_map->name = NULL;
> > +
> > +	alloc = roundup_pow_of_two(size);
> > +	scan = kmalloc_objs(struct rc_map_table, alloc, GFP_KERNEL);
> > +	if (!scan) {
> > +		kfree(name);
> >  		return -ENOMEM;
> >  	}
> >  
> > -	dev_dbg(&dev->dev, "Allocated space for %u keycode entries (%u bytes)\n",
> > -		rc_map->size, rc_map->alloc);
> > +	scoped_guard(spinlock_irqsave, &rc_map->lock) {
> > +		rc_map->name = name;
> > +		rc_map->scan = scan;
> > +		rc_map->rc_proto = rc_proto;
> > +		rc_map->len = 0;
> > +		rc_map->size = alloc;
> > +	}
> > +
> > +	dev_dbg(&dev->dev, "Allocated space for %u keycode entries (%zu bytes)\n",
> > +		alloc, alloc * sizeof(struct rc_map_table));
> >  	return 0;
> >  }
> >  
> > @@ -236,16 +244,26 @@ static int ir_create_table(struct rc_dev *dev, struct rc_map *rc_map,
> >   * ir_free_table() - frees memory allocated by a scancode table
> >   * @rc_map:	the table whose mappings need to be freed
> >   *
> > - * This routine will free memory alloctaed for key mappings used by given
> > + * This routine will free memory allocated for key mappings used by given
> >   * scancode table.
> >   */
> >  static void ir_free_table(struct rc_map *rc_map)
> >  {
> > -	rc_map->size = 0;
> > -	kfree(rc_map->name);
> > -	rc_map->name = NULL;
> > -	kfree(rc_map->scan);
> > -	rc_map->scan = NULL;
> > +	struct rc_map_table *scan;
> > +	const char *name;
> > +
> > +	scoped_guard(spinlock_irqsave, &rc_map->lock) {
> > +		name = rc_map->name;
> > +		scan = rc_map->scan;
> > +
> > +		rc_map->size = 0;
> > +		rc_map->len = 0;
> > +		rc_map->name = NULL;
> > +		rc_map->scan = NULL;
> > +	}
> > +
> > +	kfree(name);
> > +	kfree(scan);
> >  }
> >  
> >  /**
> > @@ -262,38 +280,38 @@ static void ir_free_table(struct rc_map *rc_map)
> >  static int ir_resize_table(struct rc_dev *dev, struct rc_map *rc_map,
> >  			   gfp_t gfp_flags)
> >  {
> > -	unsigned int oldalloc = rc_map->alloc;
> > -	unsigned int newalloc = oldalloc;
> > -	struct rc_map_table *oldscan = rc_map->scan;
> > +	unsigned int newsize = rc_map->size;
> >  	struct rc_map_table *newscan;
> >  
> > +	lockdep_assert_held(&rc_map->lock);
> > +
> >  	if (rc_map->size == rc_map->len) {
> >  		/* All entries in use -> grow keytable */
> > -		if (rc_map->alloc >= IR_TAB_MAX_SIZE)
> > +		if (newsize >= IR_TAB_MAX_SIZE)
> >  			return -ENOMEM;
> >  
> > -		newalloc *= 2;
> > -		dev_dbg(&dev->dev, "Growing table to %u bytes\n", newalloc);
> > +		newsize *= 2;
> > +
> > +		dev_dbg(&dev->dev, "Growing table to %u entries\n", newsize);
> >  	}
> >  
> > -	if ((rc_map->len * 3 < rc_map->size) && (oldalloc > IR_TAB_MIN_SIZE)) {
> > +	if (rc_map->len * 3 < rc_map->size && rc_map->size > IR_TAB_MIN_SIZE) {
> >  		/* Less than 1/3 of entries in use -> shrink keytable */
> > -		newalloc /= 2;
> > -		dev_dbg(&dev->dev, "Shrinking table to %u bytes\n", newalloc);
> > +		newsize /= 2;
> > +		dev_dbg(&dev->dev, "Shrinking table to %u entries\n", newsize);
> >  	}
> >  
> > -	if (newalloc == oldalloc)
> > +	if (newsize == rc_map->size)
> >  		return 0;
> >  
> > -	newscan = kmalloc(newalloc, gfp_flags);
> > +	newscan = krealloc_array(rc_map->scan, newsize,
> > +				 sizeof(struct rc_map_table), gfp_flags);
> >  	if (!newscan)
> >  		return -ENOMEM;
> >  
> > -	memcpy(newscan, rc_map->scan, rc_map->len * sizeof(struct rc_map_table));
> >  	rc_map->scan = newscan;
> > -	rc_map->alloc = newalloc;
> > -	rc_map->size = rc_map->alloc / sizeof(struct rc_map_table);
> > -	kfree(oldscan);
> > +	rc_map->size = newsize;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -318,6 +336,8 @@ static unsigned int ir_update_mapping(struct rc_dev *dev,
> >  	int old_keycode = rc_map->scan[index].keycode;
> >  	int i;
> >  
> > +	lockdep_assert_held(&rc_map->lock);
> > +
> >  	/* Did the user wish to remove the mapping? */
> >  	if (new_keycode == KEY_RESERVED || new_keycode == KEY_UNKNOWN) {
> >  		dev_dbg(&dev->dev, "#%d: Deleting scan 0x%04llx\n",
> > @@ -373,6 +393,8 @@ static unsigned int ir_establish_scancode(struct rc_dev *dev,
> >  {
> >  	unsigned int i;
> >  
> > +	lockdep_assert_held(&rc_map->lock);
> > +
> >  	/*
> >  	 * Unfortunately, some hardware-based IR decoders don't provide
> >  	 * all bits for the complete IR code. In general, they provide only
> > @@ -397,7 +419,7 @@ static unsigned int ir_establish_scancode(struct rc_dev *dev,
> >  	/* No previous mapping found, we might need to grow the table */
> >  	if (rc_map->size == rc_map->len) {
> >  		if (!resize || ir_resize_table(dev, rc_map, GFP_ATOMIC))
> > -			return -1U;
> > +			return UINT_MAX;
> >  	}
> >  
> >  	/* i is the proper index to insert our new keycode */
> > @@ -479,16 +501,18 @@ static int ir_setkeytable(struct rc_dev *dev, const struct rc_map *from)
> >  	if (rc)
> >  		return rc;
> >  
> > -	for (i = 0; i < from->size; i++) {
> > -		index = ir_establish_scancode(dev, rc_map,
> > -					      from->scan[i].scancode, false);
> > -		if (index >= rc_map->len) {
> > -			rc = -ENOMEM;
> > -			break;
> > -		}
> > +	scoped_guard(spinlock_irqsave, &rc_map->lock) {
> > +		for (i = 0; i < from->size; i++) {
> > +			index = ir_establish_scancode(dev, rc_map,
> > +						      from->scan[i].scancode, false);
> > +			if (index >= rc_map->len) {
> > +				rc = -ENOMEM;
> > +				break;
> > +			}
> >  
> > -		ir_update_mapping(dev, rc_map, index,
> > -				  from->scan[i].keycode);
> > +			ir_update_mapping(dev, rc_map, index,
> > +					  from->scan[i].keycode);
> > +		}
> >  	}
> >  
> >  	if (rc)
> > @@ -524,6 +548,8 @@ static unsigned int ir_lookup_by_scancode(const struct rc_map *rc_map,
> >  {
> >  	struct rc_map_table *res;
> >  
> > +	lockdep_assert_held(&rc_map->lock);
> > +
> >  	res = bsearch(&scancode, rc_map->scan, rc_map->len,
> >  		      sizeof(struct rc_map_table), rc_map_cmp);
> >  	if (!res)
> > diff --git a/include/media/rc-map.h b/include/media/rc-map.h
> > index d95ed3e96de2..f167c37179c8 100644
> > --- a/include/media/rc-map.h
> > +++ b/include/media/rc-map.h
> > @@ -148,7 +148,6 @@ struct rc_map_table {
> >   * @scan: pointer to struct &rc_map_table
> >   * @size: Max number of entries
> >   * @len: Number of entries that are in use
> > - * @alloc: size of \*scan, in bytes
> >   * @rc_proto: type of the remote controller protocol, as defined at
> >   *	     enum &rc_proto
> >   * @name: name of the key map table
> > @@ -158,7 +157,6 @@ struct rc_map {
> >  	struct rc_map_table	*scan;
> >  	unsigned int		size;
> >  	unsigned int		len;
> > -	unsigned int		alloc;
> >  	enum rc_proto		rc_proto;
> >  	const char		*name;
> >  	spinlock_t		lock;
> 
