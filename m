Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179382;
	b=NcS/4jeAgS5HHfvbTZAfNbhjFOBvonbi0RXjbLJCSCNafafS+VMAy+iY4ntTGGS5mIvk
	 Br6f6iO3dipjPChDo+d99dEj7GAB/fPGSfAa+Tv91dlYzXol2PTBqRk5ABefdjepds0Q6
	 Dnq6jpSxJha8MZLYZeP9m5MffepqzYNzBMlUmPlTMuLr0spEyYIi29AaQ8hiAZSE8iMYp
	 Yjws7khUycr2ZhpAq25Jbi7luZWbbh9J8hnvqD7zSyPppnFUQh+YTkVcAzpp8gbG0bDi/
	 ZA/yquvWy1k9s6eTw32Rjvi6EaSxsahRLBniI7dylAa+S7JLqi/B0d6kJSoYetqIb8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179382;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4tHEZR59lDYVr+fhdFj+FUs0FiPn002eYNVr+WYQCIA=;
	b=4U94pUeCwL9sRsAY9sVnQFEkrUw+UzBtjcOo3bQkrwDaAI03pjXRWbDinP6UNQ+JAaQ/
	 PB1bRgnHSt9MCgvHJgf0evtz3i476u8gVBCnWDbJvMSkXwL1ygzWCbp5FIs2Ni4kqAUQz
	 UIRJRUCSnOBLCNgJqYLBq+h8DHJp5Ro6vBQiz8Kb34MQFwLU59LLSxo5JEhjZ81L+dOyb
	 kz7JQLwXHffGhRpeVEUnxAbZfIS14JwoFu0IvNtUoydglD/81OfzmpKiJ6EBNv/sh4dHn
	 OgLYwc1gA+2OkTxnOG7SGv8v1obkQRkqWFU9MfRqf7Yz1Fs5bDubYSCRoKW0XNKdT9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPWx6dLS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E401606A337;
	Fri, 20 Nov 2026 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPWx6dLS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011211F000F4;
	Fri, 20 Nov 2026 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795179382;
	bh=4tHEZR59lDYVr+fhdFj+FUs0FiPn002eYNVr+WYQCIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dPWx6dLSwD9IYRQW6oKFbpr/3h98v74i9vLgZP01p4U9hURHt5brRB5qTo16TVIah
	 iMHyrqQMTr4VgsdiAGE4m8zExFWV3iCTTm18XHktauQqYsIhxZGI1WuNx7BTMYKby1
	 ivwQ7m7734fYd7fF+zcwFil/7oljtLYjc1gomtkQxXwjBi/+A4JuZftjgQxOtXCb7T
	 YB2XPXQiPL1/rF3JOD5Nr4GV8wek5I9yKuo+72/o8M0+qNVkgGnjTqtzqXpX3iblOv
	 pz24g2qw+v07l152iGMivYa+d7AQLZYGdUWOcsqvYFgGgeMQ9B+j9szjrPZLW7HPQN
	 bkgBDQtYe0Pug==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xUOA6-00000005sSW-3bWk;
	Fri, 20 Nov 2026 13:56:18 +0100
Date: Fri, 20 Nov 2026 13:56:18 +0100
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
Subject: Re: [PATCH v2] software node: make swnodes hold their own references
 on parents
Message-ID: <awBDcpQeoibHvy4W@hovoldconsulting.com>
References: <20261119-swnode-kobject-parent-ref-v2-1-7ff8bd54e526@oss.qualcomm.com>
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
In-Reply-To: <20261119-swnode-kobject-parent-ref-v2-1-7ff8bd54e526@oss.qualcomm.com>

On Thu, Nov 19, 2026 at 11:57:19AM +0100, Bartosz Golaszewski wrote:
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
> Changes in v2:
> - Simplify the code by folding the swnode_put() call into the existing
>   conditional branch
> - Link to v1: https://patch.msgid.link/20261106-swnode-kobject-parent-ref-v1-1-77dbd7213dd0@oss.qualcomm.com

Thanks for the update. Applied to driver-core-testing for 7.5.

Johan
