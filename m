Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04FD42885A;
	Fri, 18 Sep 2026 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765063; cv=none; b=tca9uhHuXVdOM/oS8e69ZBOg3/rXFuMo1MJIieL6Xc/PZ+AsPWVZq1IKZu5XN7d/PaDArxqqNIqXnmLaCVf4UpVYcqQGMuNf3qDInHOTWGO+JUHegY7uXePgufmRDNCe6KWlQTNDvvSLu7rfNWtTcrfPxgUVscuXBrh1iuJFP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765063; c=relaxed/simple;
	bh=N0SHi8xKHinefEDAgMTst5UzFrhkZrh0J08pKF8Jvd0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i+lYeFQ9kvTWXiOISJ3EadcNIIrSOyMAqRBMt1sekva7ceC/Kl8rkJdkEYI8uf2RA5AtzlLWQnZzpiDINK5fDtbqKlC0YipaFh2l9JuLjcwW1TIOSqqn3uVDW5z/ntwiED2eFW0SfAlhLWoKBshTPZ5I3on9ugNCTq6WjL+xOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UeHxFe/U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UeHxFe/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2641F000FF;
	Fri, 18 Sep 2026 20:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789765056;
	bh=6zhKq5MrlmQB5MmNUgnIkrKHbJbgm7N+fP68EJa9Dho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UeHxFe/Uz8NCqN2Knd/+O1vgZ2/IKtZq4zfynuC/wEViOKurCFgnIk8L9/kB/pn+j
	 VH8ofGgxV++57+U5IuR2IeNrJNyPRNjBmjZyBA3fE13fAfNk9jgbsmdyKlccffS5Wn
	 z/YuL/0p7dpSbM37a3ntOsO2q2q8pSfPUxX4PqRQ=
Date: Fri, 18 Sep 2026 13:57:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shyam Saini <shyamsaini@linux.microsoft.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] params: serialize lookup_or_create_module_kobject()
Message-Id: <20260918135735.678bac31c1771e0226c00822@linux-foundation.org>
In-Reply-To: <20260918100712.3124994-1-xujiakai24@mails.ucas.ac.cn>
References: <20260918100712.3124994-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 10:07:12 +0000 Jiakai Xu <xujiakai24@mails.ucas.ac.cn> wrote:

> lookup_or_create_module_kobject() first looks up the module kobject with
> kset_find_obj() and, if not found, creates a new one with
> kobject_init_and_add().  The function is called at runtime from
> module_add_driver() since commit f95bbfe18512 ("drivers: base: handle
> module_kobject creation"), which means two concurrent driver
> registrations for the same built-in module name can both miss the
> lookup and race to create the same kobject.
> 
> The loser of the race gets -EEXIST from kobject_init_and_add() and its
> kobject is removed from module_kset by kobject_add_internal() before
> the failure is reported.  The error path then calls kobject_put(),
> which invokes module_kobj_release(), but that only completes
> ->kobj_completion and never frees the dynamically allocated
> module_kobject, leaking it (96 bytes) along with the object having been
> detached from the kset.
> 
> This is triggerable by unprivileged users, e.g. by concurrently issuing
> the RAW_IOCTL_INIT ioctl of the raw-gadget driver, which registers the
> "raw_gadget" driver on the gadget bus:
> 
>   sysfs: cannot create duplicate filename '/module/raw_gadget'
>   ...
>   Adding module 'raw_gadget' to sysfs failed (-17), the system may be
>   unstable.
>   ...
>   unreferenced object 0xffff8880188dacc0 (size 96):
>     backtrace:
>       lookup_or_create_module_kobject+0x47/0x100
>       module_add_driver+0x73/0x1b0
>       bus_add_driver+0x1d9/0x340
>       driver_register+0xde/0x170
> 
> Fix it by serializing the lookup and the creation with a mutex, so that
> the second caller finds the kobject created by the first one instead of
> racing with it.

You're sure we there's no race with module removal as well?

> @@ -20,6 +21,12 @@
>  /* Protects all built-in parameters, modules use their own param_lock */
>  static DEFINE_MUTEX(param_lock);
>  
> +/*
> + * Serializes module kobject lookup and creation in
> + * lookup_or_create_module_kobject()
> + */
> +static DEFINE_MUTEX(mod_kobject_mutex);

minor: this could be static inside lookup_or_create_module_kobject().

>  /* Use the module's mutex, or if built-in use the built-in mutex */
>  #ifdef CONFIG_MODULES
>  #define KPARAM_MUTEX(mod)	((mod) ? &(mod)->param_lock : &param_lock)
> @@ -754,6 +761,13 @@ lookup_or_create_module_kobject(const char *name)
>  	struct kobject *kobj;
>  	int err;
>  
> +	/*
> +	 * The lookup and the creation must be done atomically, otherwise
> +	 * concurrent callers may race to create the same kobject, and the
> +	 * loser of the race gets -EEXIST from kobject_init_and_add().
> +	 */
> +	guard(mutex)(&mod_kobject_mutex);
> +
>  	kobj = kset_find_obj(module_kset, name);
>  	if (kobj)
>  		return to_module_kobject(kobj);

