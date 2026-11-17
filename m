Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923229;
	b=gaolA/VeDK5ALLajMleTlG/ufuTpXAvZIs+9UEd0T8TRdsgFgs2+4177Q6A30ZZBs3ia
	 33JJ6/0S/whl1DsRancEzF9ls68Z3zTWEq06Z0VHf+GrQ09sEah4SOupZKWvL9Tnu58UV
	 gkQCxC/Lexjv5ygwP8NTSFrL7OYBuWTmx3xBs9mROOgjXHb95S+JZYRCCoWqBsi3HZ+Hu
	 oursNNzXCX1LrPAi3LxmivA/OOt3Wbrvl0eZcobOmFMAm+SaaQHXl2OrszmGHfC/SDgbb
	 oMhe8N4ggSLgow8e/OF9WZUM4BZui1zGvfnDH4/bKDq28RLzmDQ9xJsnDNeJNSI1HnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923229;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8ymDBll+m8njIQXnZhzBbLu14ANrEaXlecK0b9Ys2iA=;
	b=bLsWuH83oua0wqVDzsGQ3GJgOs6QbMqPSlGnpeOIffFMqLWXKQrkgCI0Y6kwdgPJZiEA
	 GQsCS/cdCzFn1CA33eA9/UWAX3mG+Um4k7APmKD08fAd6gu1x+3UMJbHQ6tP+W1bTnoEB
	 fu16QyZ0PaP8ttiyBHtkNNP6SPtEejcCHWVIpQH5zRsQAInDH99ETW0DkOWaVtCNXD+o2
	 9t8CSKQo5hU64wRp8molZVV2Adko+ldXH3IcjEczBPY+d97LLOqdVyREd+YafYLUTsy1M
	 7nebjLWlVmTugANeRisNbxhRNa1WpNg0ijlbiAp6OUT4PacMYy73zPNil3qH4NAzIPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZ5dD1TX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51F606A31C;
	Tue, 17 Nov 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZ5dD1TX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AFD1F000C4;
	Tue, 17 Nov 2026 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923228;
	bh=8ymDBll+m8njIQXnZhzBbLu14ANrEaXlecK0b9Ys2iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YZ5dD1TXczNz8vy5JFg/Cbdwz8n5zn4twRanmeNYDUkn/gzKNyoewoS6v31CeqFGA
	 EeHo/w3G7pPaDdZIb3kfKf+GV3SgmOzi/DNjF7MKyS/FaHqpvzBUE1DwQ/+cMQ94oY
	 rAsdzN4Y2G2qUAB1OQIwmz3hvBdYDy8Y83PGxKBHh2+lrMy3OVK8RpMgxwVb+oVfQE
	 00xxwNOOiQr1cFltlgVkGiFdaPqcuz20LvUmrghFa7lagRSgg+tCaWK527M3vf3g+K
	 PGR9/7t6VmRuwUfybQLduE1GK1P1voR4Q3J5Nw6VEbr8xWBgl4OUybiGgMoEG6EH1k
	 BD+X1ME5MKaSg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTJWc-00000004N0p-0reK;
	Tue, 17 Nov 2026 14:47:06 +0100
Date: Tue, 17 Nov 2026 14:47:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] software node: make swnodes hold their own references on
 parents
Message-ID: <avxa2k9HyHX9CvYl@hovoldconsulting.com>
References: <20261106-swnode-kobject-parent-ref-v1-1-77dbd7213dd0@oss.qualcomm.com>
 <avxEGiacULc2eciv@hovoldconsulting.com>
 <k3yo7tpvb33prcuuw2a2qthvuww2edb7tsszj5hxlkcfaurt7k@m2czeig46clb>
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
In-Reply-To: <k3yo7tpvb33prcuuw2a2qthvuww2edb7tsszj5hxlkcfaurt7k@m2czeig46clb>

On Tue, Nov 17, 2026 at 02:39:27PM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 17, 2026 at 01:10:02PM +0100, Johan Hovold wrote:
> > On Fri, Nov 06, 2026 at 12:13:28PM +0100, Bartosz Golaszewski wrote:

> > > @@ -843,11 +843,12 @@ static void software_node_free(const struct software_node *node)
> > >  static void software_node_release(struct kobject *kobj)
> > >  {
> > >  	struct swnode *swnode = kobj_to_swnode(kobj);
> > > +	struct swnode *parent = swnode->parent;
> > >  
> > >  	fwnode_links_purge(&swnode->fwnode);
> > >  
> > > -	if (swnode->parent) {
> > > -		ida_free(&swnode->parent->child_ids, swnode->id);
> > > +	if (parent) {
> > > +		ida_free(&parent->child_ids, swnode->id);
> > >  		list_del(&swnode->entry);
> > 
> > Why not simply
> > 
> > 		swnode_put(swnode->parent);
> > 
> > here?
> >
> 
> Because swnode_put() doesn't accept NULL. I have it on my TODO list to
> add it but this is a fix, so I want to keep it minimal.

swnode->parent is not NULL here in the conditional block.

Johan
