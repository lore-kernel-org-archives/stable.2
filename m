Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794917405;
	b=lXbvW7fUq5I6VQ6tix+CJlKp/HY0TA2Xa4obrIZ+02Jme3YOnGRvktG/NInfSOusluqC
	 CelO4eTNUlUNxM/nNve5r/pdctfr8jtg8MxCGf8hFZUY5x8VfpBeiqJvfodATYjQxKdCU
	 FrnhAXU77P55xq/VTNFpAfa8X+NfPC87Rtn9GutAsuA5qfiS/9iY1RhcPZ//4bBcxQqtr
	 NDSh9ZNZO2mpj3fWiDvF0qJNTK9V/QjEmYkYP/RJEmuCZdlaY2RO94zJxzwMTX9ijSOFa
	 LBUyJw+6RGAnpJ7Ubt4gXGdlH+f3PBK1KDzp92QmOI6GzBeU6qGQr0iXpwhhUXbdyIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917405;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=z23KUivcgsPQdbsSbdcK9l9mI4AN6C05hWnHHj+0i8s=;
	b=5kgxD1NeBlvB6KMTq2rXkVRZsJbDn4LSfb+LHvd8pSWmtonyfY+bpRwkSeGiWMWNPm1d
	 40d0PbqHIPmsssSCfgnOB9JZzpHgSHmrZ4SAdN8YXoVvD9PDfgpovJMDHkfizhru/R5O+
	 zEoAzjQu/YBbsevfXXmXF6YJ0fvgziFqBs4xbwMEGSi5irdhJUB8Y0lDihg1YErS+0DtY
	 Lu/UrkI5t759cFEICgeXGdWeTVgo+303lcm3vd1cex0ay9QRMjaay7sTinPT7npkXkgIm
	 g+HlTkvQvtBo7SXdRd0LA9/hdISlBCgiL5wEBrgbj4tiBOlDjV5xzFp8WJg1N25VHXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f84GBbx3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298D606A31C;
	Tue, 17 Nov 2026 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f84GBbx3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379C31F000C6;
	Tue, 17 Nov 2026 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794917405;
	bh=z23KUivcgsPQdbsSbdcK9l9mI4AN6C05hWnHHj+0i8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f84GBbx3MvXsoiFV4Ab0bKtjj1R6VPH/xR0oaGsFWFwlKLP9N2cgR+ROtnh+V5acF
	 EWXaZM89jnxscfUCsQZydqsGilgF+QXVyXKSNNsqlP6SLsPITGvtBca1Bask0U1xcU
	 UkEACo2J7VxwjW1VocqgCnya0SPgg/eLtPlleGQYNAda33X9XqLmMDBe+DOFC7e/7M
	 n0kk4emJdBmM3i0S09CNdjQbcPHKLvW5XpPA2q/rMAMT53ZVTalPfBsk+RONOqklDU
	 vb7d1/HEE6uFDFX9pIVCDOTYIwfdR4rKKgvt2fbnYS4JeD64/LmFWK1KeSTJJEkprE
	 RQ6ofso9fHDxw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTI0g-00000004A4M-2IOB;
	Tue, 17 Nov 2026 13:10:02 +0100
Date: Tue, 17 Nov 2026 13:10:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] software node: make swnodes hold their own references on
 parents
Message-ID: <avxEGiacULc2eciv@hovoldconsulting.com>
References: <20261106-swnode-kobject-parent-ref-v1-1-77dbd7213dd0@oss.qualcomm.com>
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
In-Reply-To: <20261106-swnode-kobject-parent-ref-v1-1-77dbd7213dd0@oss.qualcomm.com>

On Fri, Nov 06, 2026 at 12:13:28PM +0100, Bartosz Golaszewski wrote:
> In swnode_register(), swnode->parent is assigned before calling
> kobject_init_and_add(), which normally acquires a reference on
> parent->kobj via kobject_add_internal() that is held until after
> software_node_release() completes. However, if kobject_init_and_add()
> fails before acquiring the parent reference or drops it on error in
> kobject_add_internal(), swnode->kobj holds no reference on parent->kobj
> while swnode->parent remains set.
> 
> With CONFIG_DEBUG_KOBJECT_RELEASE enabled, the random delay in
> kobject_delayed_cleanup() may create a situation where - when
> unregistering the child node and then the parent - the parent object
> gets released before the child who's left with a dangling pointer.
> 
> Acquire a refernce to the parent swnode when registering the child and
> drop it on child's release.
> 
> Cc: stable@vger.kernel.org
> Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
> Closes: https://sashiko.dev/#/bug/linux-82933c14-d212-49f1-bd2f-d4ab1e16fed7
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/base/swnode.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 84a77ffa3dc4bbcca62bbe67c3390693500b01ea..986dcb933d2c9274e9000968f115d7fccc2d103f 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -843,11 +843,12 @@ static void software_node_free(const struct software_node *node)
>  static void software_node_release(struct kobject *kobj)
>  {
>  	struct swnode *swnode = kobj_to_swnode(kobj);
> +	struct swnode *parent = swnode->parent;
>  
>  	fwnode_links_purge(&swnode->fwnode);
>  
> -	if (swnode->parent) {
> -		ida_free(&swnode->parent->child_ids, swnode->id);
> +	if (parent) {
> +		ida_free(&parent->child_ids, swnode->id);
>  		list_del(&swnode->entry);

Why not simply

		swnode_put(swnode->parent);

here?

>  	} else {
>  		ida_free(&swnode_root_ids, swnode->id);
> @@ -858,6 +859,9 @@ static void software_node_release(struct kobject *kobj)
>  
>  	ida_destroy(&swnode->child_ids);
>  	kfree(swnode);
> +
> +	if (parent)
> +		swnode_put(parent);
>  }

Johan
