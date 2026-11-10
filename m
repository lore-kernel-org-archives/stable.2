Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301061;
	b=E5DJT5VQlvhmdXHxD8Rvnz65sehDdmCrZLw+R4KxOep0f4GalCwNMg6mnbftlX8ZzXP/
	 e6eY2HDFjA5xG6EtfW69EM6bSRHWbkVuLwo7VtE6V3OlDyFEEPVzx3tlN+ApwWYKZgb1b
	 IiuW1KnnwntN3lmPIzZEWJhBDxB4ejlRVj7qOxbgxsBSlybzoo2HalouAiB4KkXPdXQiv
	 fxZW1k0rkCI6yNF1yrwbCPtM6J0IySu1TazMiC2/o6aXNu/9j/47qqShw3G5PIVCHi6IH
	 dEQAzsrzEWGK1cfF5m+5goYQ4x2el/oQRp3NlmuDmi0IwqvX2SnaMwD9tB0mg4wBiGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301061;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QO3TC598PjuKBpjKdzTX4SuKJE/JMxeGN6A58UOqy2c=;
	b=AlLPBOC8wf43f34A5KOQgHMkJEZ+b91r1Ld47jG93McIVNTCke8GFiv/ytgrtakRIds6
	 9VX6lGADVT72OO7ci+LCQPllJ1fI2GOVvGLPyqU7PYp5NpD9458qhPuU7g2BLJGDoah/p
	 5h/yp6TCAhWU5m0v1T71DhwAb8fPrKRxswET7YWTBL5pYf+fNiIMnNK03bMbWUu9/4a4/
	 z9TyzCHnG6v5p98UTeyeYDpBr43utmDjDpTxIl2NqgRGqWDuLcJDZt1AEBmv+ak1lY5F6
	 l/IvTmA3PFVqnEmW2yicrAIPhp6wQLJn9eJNtBiaWoKi31DzUomEYy3DDBQWXYzBCWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohi12+lZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EB84A606A321;
	Tue, 10 Nov 2026 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohi12+lZ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E69361F008A5;
	Tue, 10 Nov 2026 08:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301060;
	bh=QO3TC598PjuKBpjKdzTX4SuKJE/JMxeGN6A58UOqy2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ohi12+lZlHUZQX+s905Dw9DFBrisQN0xiV0rzzgZu+NlzU3L15GiZsusvCdYmiGam
	 4teSigLD5V53HUroqi9496ujv8mEOZVuAgia2xpur7VXf1eIMZ4sWgcygaV5pEVXkW
	 0Lzo+/Qbp6IAHKHpOvy6MOaQAg7OvcWi+1nlQJbIM7GDU7h+Wc7eVoR2tozhPz52NZ
	 oImRSjVqJ6Wkk6PLCNvdrLmghlcdc6CpDzSOr4M42MknGXlaIxdVZ5Uk03gMyaq5cN
	 SiwjVohnF4x8w6vtnbiwoiDVtlB9NU3ALsTTtYoZgrpakukawkeLSHGrNVMsyRgOqA
	 oCGr0B5uVtSZQ==
Date: Tue, 10 Nov 2026 09:57:36 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] software node: make swnodes hold their own references on
 parents
Message-ID: <esbdzbsadwc7hym6aa6x3lirhs3r47w2wcygwshcb3metdh773@ersixahci2rm>
References: <20261106-swnode-kobject-parent-ref-v1-1-77dbd7213dd0@oss.qualcomm.com>
 <avIkbNrRtnJxZuYL@ashevche-desk.local>
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
In-Reply-To: <avIkbNrRtnJxZuYL@ashevche-desk.local>

On Mon, Nov 09, 2026 at 09:52:12PM +0200, Andy Shevchenko wrote:
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
> 
> ...
> 
> > +	if (parent)
> > +		swnode_put(parent);
> 
> This will be the second case of potentially NULL being passed to swnode_put().
> Since it's a static internal API, I would just add a check there and hope that
> compiler will inline and that will be optimized away on the cases when the
> parameter is known not to be NULL.
> 
> Maybe in a separate change.
>

Yes, I actually added it to my TODO list but this is clearly a fix, so I
wanted to keep it small.

Bart
