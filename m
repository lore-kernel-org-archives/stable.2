Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E82FFF89;
	Thu, 20 Aug 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216216; cv=none; b=TJtOSczSHvwrp/zq/LNPpkJLakHBNd/MLOwb195BK8Y+vH5tx0enHTZs1FHW7lAbV0WPD3eqJh0XRdD6tKn3T32aiXnH9BfE5IKGH3GJCzSPaYRQvT+8uQFV/7h3UQcM3u81y2ttegJIJ09focvxMBcLrhYzHBjAFa32A34/Fe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216216; c=relaxed/simple;
	bh=ZMD6wMTBFngrCdtrtprNQ4hUd68qrelj0AnHXVpKy/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeVnXvhf3DnG9CGQ18k8duwkChzBxR1utLIsBi8mp6nv1fSY0ajWtG4bN+NLKwtedvCBnJhNnU+A08XPqEHZIVq95QhjItoDWweH+3wbhW/OiFkqRRKFUzm4wSKq/MkrV2IxP2s2W71RfKZzGiB/vugxLhEFA0sPtBOCNEzMKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZJW5mFUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZJW5mFUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A194C1F000E9;
	Thu, 20 Aug 2026 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787216213;
	bh=mOHcAAEa0GFS2xZD8b5+LRpwoyIosu1c2F1zSe+Dy6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZJW5mFUKT5XCItRgh2tkWyrUDecLUNpV85LPLFB6PumbY8+220P4SxJ2c4Q7HKAVe
	 2wGEtcSP/YyXoI7jtIgaJUKd7d4j3yP8ddaiTKyeDzF3ig3etKlL/kcuWebNpndc25
	 MvKl5O9mB9QkxSQrIzycIIzePcvq/B2YobbPc+sU=
Date: Thu, 20 Aug 2026 10:56:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] driver core: avoid klist_remove() on unattached
 knode_driver
Message-ID: <2026082015-curable-overhand-306c@gregkh>
References: <2026082042-coma-moody-5b4e@gregkh>
 <20260820084557.129908-1-khiemtranzo532001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820084557.129908-1-khiemtranzo532001@gmail.com>

On Thu, Aug 20, 2026 at 04:45:57PM +0800, Nguyen Quang Le Kien wrote:
> usb_driver_claim_interface() sets dev->driver directly and skips
> device_bind_driver() when the interface is not yet registered, so the
> device can reach teardown with dev->driver set but knode_driver never
> added to the driver's klist_devices. __device_release_driver() then
> unconditionally calls klist_remove() on the unattached node, which
> dereferences a NULL klist pointer in klist_put() and crashes.
> 
> Only remove the node if the device is actually bound. Use
> device_is_bound() rather than klist_node_attached() directly: the
> latter is a raw klist API and does not NULL-check dev->p, while
> device_is_bound() is the standard bound-state check used throughout
> driver core (driver_bound(), __device_attach()).
> 
> Fixes: 94e7b1c5ff20 ("[PATCH] Add a klist to struct device_driver for the devices bound to it.")
> Reported-by: syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=87188222c77c0dbbdb4d
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
> ---
> Changes in v4:
> - add a changelog below the --- line, as required by submitting-patches.rst
> - add Cc: stable@vger.kernel.org, Fixes: points to a released kernel

Please slow down.  As my bot said, there is no rush, no deadline, and
it's the middle of the merge window and we can't even do anything with
this anyway.

At the least, wait a week between patch revisions.  If you wish to see
patches reviewed faster, then help out with actual reviews of patches
from others.  Constantly resending stuff like this doesn't make anyone
want to review this at all.

thanks,

greg k-h
