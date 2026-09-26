Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9867B358378;
	Sat, 26 Sep 2026 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405590; cv=none; b=E0PTg37AZircOC1OyfVR+xct5SN4/YpimZFdhjdL6kMW/GLbf7GdW5rpFmth0klPQ9TsnbRNBs3hu42mktreK3t+ftDCpYwCXPqbX4PXmLPe3amKNUqw7akB8IM70ZsVLC2mne0fdkgfw59PlR1yQZKAn0+GwxLK56sgHVTwL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405590; c=relaxed/simple;
	bh=otNrgYeojKKEkX8bmj0Vz/di4vUWW7qFunxdMHB3FMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIRA0cg0kVZR9M661BQ+Ggin7IMjEePXZ2dBEUpk6bzOK5y4NODPK/jONAuJSPTk8x1SOGM5tbLzEHN20MPleDbTL+g1KWrUnrwHLrRnxbt5v1PlYXdZpf6bBTAO8b8u0g/Pg+drC0CnnpTrCBp64X7OhbKC/oMVUYfZ0lnizHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XeHXpijg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XeHXpijg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E1B1F000FF;
	Sat, 26 Sep 2026 06:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790405589;
	bh=lBDVtUJxfY3hJyG9YF8ws9q5NU+jH6zfcGctFfbQlRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XeHXpijg6kfoNJGjrBXwUs5hBB2GyhuKl2X1ViIG1rFdscXOv8pcRSPaPtb8pDKvn
	 tNYWh1qc/379WAT5fGc2AeIatqXa0+84KKAKzbihs0iYXJBZNhfdFhNmLkcFlQAXVA
	 cLkW9DeK9YKai8gyaRLb7fwN6+Hoc25QeIGCGH4U=
Date: Sat, 26 Sep 2026 08:53:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] debugfs: fix UAF and double-free in debugfs_str
 read/write
Message-ID: <2026092647-ebony-unlatch-d3d0@gregkh>
References: <20260925175831.3701812-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925175831.3701812-1-qwe.aldo@gmail.com>

On Fri, Sep 25, 2026 at 02:58:27PM -0300, Aldo Ariel Panzardo wrote:
> debugfs_write_file_str() stores the new string via rcu_assign_pointer()
> and frees the old one after synchronize_rcu().  However,
> debugfs_read_file_str() dereferences file->private_data without holding
> an RCU read-side critical section, so synchronize_rcu() in a concurrent
> writer can return—and kfree() the old pointer—before the reader finishes
> using it (use-after-free).
> 
> Additionally, two concurrent writers both read the same `old` pointer
> before either calls rcu_assign_pointer().  When both subsequently call
> kfree(old) a double-free results.
> 
> Fix both issues:
> 
>  - Read path: wrap the pointer dereference and string copy inside
>    rcu_read_lock()/rcu_read_unlock(), using rcu_dereference() and
>    GFP_ATOMIC to keep the allocation within the critical section.
> 
>  - Write path: serialize concurrent writers with inode_lock(), and use
>    rcu_dereference_protected() to read `old` under the held lock.  The
>    lock is released before synchronize_rcu()+kfree() so readers are not
>    blocked during the grace period.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

Did you forget an Assisted-by: tag here?

And how was this found and tested?

And what kernel was tested, debugfs strings were changed a bunch in 7.1,
what bug report are you working off of here?

and shouldn't this be multiple patches as you are doing two different
things?

thanks,

greg k-h
