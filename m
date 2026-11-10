Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309311;
	b=5LkZ3RctDaOQqsNL5Km+dOLoao7luC6OM7S1H6Z9gkTz6hkSpIqokJK9/4RETFwdymGc
	 oBsrRvqXqc6nsDtp5H2ER3ON23YmunD2cs4NPnfn10dg6Rgm2400gMG78g5jgE26WTREE
	 oG8OFlJPO8FZxcKwH0I68RVxNYLf4QUf3/vngc92aFCAq1Al9VoAcDfFgBCB78bCzzVt0
	 hd71AKztnx83yiDNvaZq/77UWgYe6Ny0iiEnHeDnt6cA8nNulOGwP9XyUJocLOYyKGgWm
	 HJksl/uVhohXLVpiY+3/l70+vtp4v0qN74vJTSCdx75wWpN1uaRB+hDCsG34Lx9eBIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309311;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FdOVbvcKdFgkXdU4BMS1bRcFn7D8v8NDtVISXLeDPZI=;
	b=VIjon5Z8SQE37wNkpiNx9HzSyL9UI6yeFCS0GMCAu5lRHtRswibJNLG1NmfEP4TQRmQq
	 jll3ypextmErZ9w1kCWrmQ+hitsL/MFoAvAcehXdQYds3T2qsFrja1ly306bZUBPgBW8P
	 Vk93dIv4fZMyaPJJ5Ur4ojtztcCw3RRclKyThzzaij+aak37v9LMnkpvo6h8m56AMpWfi
	 CHW5ZI+XynNZHw1DxUr54P+lekS4zokNQ2YfGqGBdhoG8g7XbwjbVNmO7MGos/33j8FQt
	 IJm0lIXW6+0qJw1CBaauKN+PLHuQa7h8fyiKwTzL5eTKIy8AlWIkjyPFJzcfEU3yZqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DmSzA/cc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC45606A325;
	Tue, 10 Nov 2026 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmSzA/cc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D131F0089F;
	Tue, 10 Nov 2026 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309311;
	bh=FdOVbvcKdFgkXdU4BMS1bRcFn7D8v8NDtVISXLeDPZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DmSzA/cccKoAot6OoPurM2eGxFwrqjl3PNn6sOlcK4MuqbckjFlQ+1BWNuMwZ18uV
	 8DxrZdxy3xkHKQtR+GuKDIG6/gqLfvYi/nbSqPKwnoa2J6XxxZFPKHoZ2a4z148+Lw
	 d3AQuWQeisrRNd5ySpoaq5vg/sMal+rztXbpjzUb861zOUxtMiXQNXFG+JdEV7Y69V
	 zeisfrr1LV3CrtP5aRnQKZmY0Dy6fnp+A/R20vGrLJHgd3zlz065lQCiucM10Ut0ML
	 EBvsuSkeX/ZGI/JJhQFqLr/Vah+kHGVoai9NPIqWgzpAZQsw1OG6uJVtXtZgDJ3P/b
	 g7/meQIMiZCzg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQjoi-0000000AuCa-2Gte;
	Tue, 10 Nov 2026 12:15:08 +0100
Date: Tue, 10 Nov 2026 12:15:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 2/8] i2c: core: fix swnode use-after-free on client
 deregistration
Message-ID: <avL8vNRJdZric-mu@hovoldconsulting.com>
References: <20261110085125.2535508-1-johan@kernel.org>
 <20261110085125.2535508-3-johan@kernel.org>
 <avL4x_clSegBu-Qi@ashevche-desk.local>
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
In-Reply-To: <avL4x_clSegBu-Qi@ashevche-desk.local>

On Tue, Nov 10, 2026 at 12:58:15PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 10, 2026 at 09:51:18AM +0100, Johan Hovold wrote:
> > If a client has both a primary and a secondary firmware node, the
> > secondary node is accessed via the ->secondary pointer of the primary
> > node.
> > 
> > Use a temporary variable to track whether the firmware node is a
> > software node and remove any software node before dropping its reference
> > to avoid a use-after-free in device_remove_software_node() when
> > accessing the secondary firmware node.
> 
> ...
> 
> > Fixes: df6d7277e552 ("i2c: core: Do not dereference fwnode in struct device")
> > Fixes: 1c24e5fc0c70 ("i2c: core: Fix double-free of fwnode in i2c_unregister_device()")
> > Cc: stable@vger.kernel.org	# 6.16
> 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Hans de Goede <hansg@kernel.org>
> 
> Can we keep these two Cc out of the commit message?

I prefer to highlight the authors of the commits mentioned in the Fixes
tag this way.

> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---

> > @@ -1066,14 +1067,14 @@ void i2c_unregister_device(struct i2c_client *client)
> >  	else if (is_acpi_device_node(fwnode))
> >  		acpi_device_clear_enumerated(to_acpi_device_node(fwnode));
> >  
> > +	fwnode_is_software_node = is_software_node(fwnode);
> > +	device_remove_software_node(&client->dev);
> >  	/*
> > -	 * If the primary fwnode is a software node it is free-ed by
> > -	 * device_remove_software_node() below, avoid double-free.
> > +	 * If the firmware node is a software node, its reference count
> > +	 * was decremented by device_remove_software_node().
> >  	 */
> > -	if (!is_software_node(fwnode))
> > +	if (!fwnode_is_software_node)
> >  		fwnode_handle_put(fwnode);
> 
> Do I understand correctly that this is a dup with the platform device case? Can
> we make a helper (on swnode API level) to cover any other existing or potential
> case to avoid similar issues in the future?

The bug is different, but the fix is the same. This all gets cleaned up
in patch 4/8.

Johan
