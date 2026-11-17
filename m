Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922772;
	b=EyWErOsSgJ3JQKChFJXz79aL8z3QbzwEFfiuxd8VvSkguEublWW+Elt6RlSpRtDuW9Nq
	 7NPpu/9eYnWedLmRlAYbm/jNmev/Fo5f2Rro4PobTNzZ2DZDrEhCUe6bUbuCtwJzHrSPz
	 Ttr5hIkhSDCNQFLHOgqJ3r0FPPM//i+LUkEaHgOOWP/vLsbxnMfppKHNkPVrwoKjYgzO9
	 VQnsbpLNxJ12GqcfS+TKAZ/QS918+fkRzvoXK4wFwaIti+82f36XEmKLTWs7gw02UPULb
	 g9ndmoOST4IGH9HVUzAdFGuQrMGk6QxKJWJoJJs+sd9ZLrOGzyO9mAuVZHG84iurgSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922772;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+vj5WHBOpvfWIdOOU2vveRF7fJbLzDa1R2TQY8Zim/M=;
	b=jSHRAOSqIiAtvUD5XQC/h5jEdp0COveFlyRde52/ikWWb9WbcSIJLazZR0UGKyzzq01d
	 rYT5NhtWYTygBFUZdTbEGzvsdEbPhYWpf2t/ZcH7iXXCMMmrCdrrZzjKI9fYCQWv/CW8i
	 L73I8EFQAHi4WA6aPc4SKYolsN23gTrdDINOPJf2xs70x+gVHWose7GcrQtUl+3+NWM8h
	 Jx09KLybOI27g7T8vQRcmRcR+kE2UNLUUJoZKJp9qBj3CltP8hDxbAdCp40wgtyMSzW3W
	 gghuKUzeIIn5kGqxIrpR1ijgXVlRl3r4oXEHHGYLv5w2h+en3jaBDd0uxCq+PaPB4Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E73qLr6x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6A815606A323;
	Tue, 17 Nov 2026 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E73qLr6x
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 80F1C1F000C6;
	Tue, 17 Nov 2026 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794922772;
	bh=+vj5WHBOpvfWIdOOU2vveRF7fJbLzDa1R2TQY8Zim/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E73qLr6x4QJlH+ZxnhmrkQJto+Ns5sNs9PEbdG8bFdZQRtJZ1mLnMOwFlchXSD706
	 J35gWl4S5vLgMs8JVTtEXrOndY+iUIwdNoRawFbdvxNcSDZw8KJ2qmURrd6UcQGli7
	 r93/AUDBq8DsAP84kQh9zIv6u2chrFfY3/RP3krXtq4zUjQj+Xu8iLm2ZUxG7iN32h
	 QLpevIgpU6+0AXJu/aq5cia+zeAwLfzYkDNAYsXbXNcN9XzRLKbeM8UFVEJ7jNmP/I
	 r4uhNbxnvfEMZlAFgP2YWjX0TT1vrUO2CU++gRvgo29TywvOEjxaPy60dZafPbo/pL
	 HT9qt2O9bD5hw==
Date: Tue, 17 Nov 2026 14:39:27 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] software node: make swnodes hold their own references on
 parents
Message-ID: <k3yo7tpvb33prcuuw2a2qthvuww2edb7tsszj5hxlkcfaurt7k@m2czeig46clb>
References: <20261106-swnode-kobject-parent-ref-v1-1-77dbd7213dd0@oss.qualcomm.com>
 <avxEGiacULc2eciv@hovoldconsulting.com>
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
In-Reply-To: <avxEGiacULc2eciv@hovoldconsulting.com>

On Tue, Nov 17, 2026 at 01:10:02PM +0100, Johan Hovold wrote:
> On Fri, Nov 06, 2026 at 12:13:28PM +0100, Bartosz Golaszewski wrote:
> > In swnode_register(), swnode->parent is assigned before calling
> > kobject_init_and_add(), which normally acquires a reference on
> > parent->kobj via kobject_add_internal() that is held until after
> > software_node_release() completes. However, if kobject_init_and_add()
> > fails before acquiring the parent reference or drops it on error in
> > kobject_add_internal(), swnode->kobj holds no reference on parent->kobj
> > while swnode->parent remains set.
> > 
> > With CONFIG_DEBUG_KOBJECT_RELEASE enabled, the random delay in
> > kobject_delayed_cleanup() may create a situation where - when
> > unregistering the child node and then the parent - the parent object
> > gets released before the child who's left with a dangling pointer.
> > 
> > Acquire a refernce to the parent swnode when registering the child and
> > drop it on child's release.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
> > Closes: https://sashiko.dev/#/bug/linux-82933c14-d212-49f1-bd2f-d4ab1e16fed7
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > ---
> >  drivers/base/swnode.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index 84a77ffa3dc4bbcca62bbe67c3390693500b01ea..986dcb933d2c9274e9000968f115d7fccc2d103f 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -843,11 +843,12 @@ static void software_node_free(const struct software_node *node)
> >  static void software_node_release(struct kobject *kobj)
> >  {
> >  	struct swnode *swnode = kobj_to_swnode(kobj);
> > +	struct swnode *parent = swnode->parent;
> >  
> >  	fwnode_links_purge(&swnode->fwnode);
> >  
> > -	if (swnode->parent) {
> > -		ida_free(&swnode->parent->child_ids, swnode->id);
> > +	if (parent) {
> > +		ida_free(&parent->child_ids, swnode->id);
> >  		list_del(&swnode->entry);
> 
> Why not simply
> 
> 		swnode_put(swnode->parent);
> 
> here?
>

Because swnode_put() doesn't accept NULL. I have it on my TODO list to
add it but this is a fix, so I want to keep it minimal.

Bart
