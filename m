Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC513AE71C;
	Thu,  1 Oct 2026 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856503; cv=none; b=sah5GFsPmIkFiw6I8Ahh/EPES/h61GnTDxCXBM80tTdOOAULbJzJ4sH2jYKHYqweudXmgKbyrVsXinh63UDG5aKDB3W8I+muA4XbA6bo2An0d3exbe1rMw8juFLQDUGMaPr0cfyVtnG/YmS1Q4JeoET3+Kiky1ozEzY6pvKbfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856503; c=relaxed/simple;
	bh=lQqObY9wJw1ryU4e1iRCcObLBG5wLe+a2s2XLdHBhUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTLR4bkRSwTWVPvpay9QbDdxemSRrCNnAm9t/zaV9hRzmtFXFNn15wF7ChupxLxIX7AwamwtZ1GApvk6v/lPMbuyov1hv9kVWV64Ox4W59BeT04IY8JGB6WxvAhrsHjiu99VWw5Ayoq00NDV+HdZWSQKTu9Eyo3VbzCFaBy7lm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jhU2fX0S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jhU2fX0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04401F0089C;
	Thu,  1 Oct 2026 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790856483;
	bh=p6LV3W68TcyZMyH7qsUALOR/0REEYV7OftxrXkIXaFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jhU2fX0S2p03+kVwHCivDDisFZvCwqmENmY/QGJdkRVa5+SWuyz/fBtwS9kUvNFHX
	 OQOAaH2v+5VPvVH3wYxEXJ+cY4AfsugkfcDs7UfpIdQ7YqfD5lWqSFuyGDfV8fczKj
	 OgKGFdwFyk6jjvgXejRnafzRYb4NnuW22miBSRpg=
Date: Thu, 1 Oct 2026 13:52:59 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: nirbhayykumarr@proton.me
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] misc: mei: prevent reusing disconnecting clients in
 mei_ioctl_connect_vtag
Message-ID: <2026100107-handshake-french-7080@gregkh>
References: <EMSkNBZm4uu_WZkFgR0kROn545GxY2HBpddaVmMEc5GggQEgOo5yFDDeY8r5Imj5te7fffDZwld1HeGzwFBtFZomlgCTvAetlLTaTaHHJQY=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EMSkNBZm4uu_WZkFgR0kROn545GxY2HBpddaVmMEc5GggQEgOo5yFDDeY8r5Imj5te7fffDZwld1HeGzwFBtFZomlgCTvAetlLTaTaHHJQY=@proton.me>

On Fri, Sep 04, 2026 at 03:59:58AM +0000, nirbhayykumarr@proton.me wrote:
> This issue was discovered using a custom multi-threaded C fuzzer
> designed to stress-test MEI Virtual Tag (vtag) client lifecycles and
> multiplexing over /dev/mei0. By concurrently racing rapid vtag
> connections against file descriptor closures and streaming I/O, a
> race condition is triggered during client teardown.
> 
> In mei_release(), closing the last file descriptor holding a virtual tag
> invokes mei_cl_disconnect(). Inside __mei_cl_disconnect(),
> dev->device_lock is dropped while awaiting the firmware disconnect ACK
> on cl->wait.
> 
> During this lock-drop window, a concurrent IOCTL_MEI_CONNECT_CLIENT_VTAG
> call on the same UUID scans dev->file_list. Because
> mei_ioctl_connect_vtag() only verified pos->me_cl without checking
> pos->state, it matched the tearing-down client (in
> MEI_FILE_DISCONNECTING), repointed file->private_data to pos, and added a
> new vtag to pos->vtag_map.
> 
> When the disconnect ACK arrived, __mei_cl_disconnect() called
> mei_cl_set_disconnected(pos), setting pos->me_cl = NULL and pos->state =
> MEI_FILE_DISCONNECTED. Because pos->vtag_map now contained the second
> thread's tag, mei_release() skipped unlinking and freeing pos. The second
> thread then attempted to reuse this disconnected client, causing packet
> demuxing mismatches, continuous CSME hardware link resets, and DRM/i915
> display freezes.
> 
> Fix this by:
> 1. Validating pos->state in mei_ioctl_connect_vtag() to ensure only
>    active clients (MEI_FILE_CONNECTED or MEI_FILE_CONNECTING) are reused.
> 2. Setting cb->vtag during callback allocation in mei_io_cb_init() via
>    mei_cl_vtag_by_fp().
> 3. Demuxing incoming read packets in mei_cl_irq_read_msg() by matching
>    vtag against cl->rd_pending rather than blindly dequeuing the head.
> 
> Fixes: f35fe5f47ed0 ("mei: add a vtag map for each client")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
> ---
>  drivers/misc/mei/client.c    | 24 ++++++++++++-
>  drivers/misc/mei/client.h    |  1 +
>  drivers/misc/mei/interrupt.c | 65 +++++++++++++++++++++++-------------
>  drivers/misc/mei/main.c      | 24 +++----------
>  4 files changed, 69 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> index 5f648481024..b10c483673a 100644
> --- a/drivers/misc/mei/client.c
> +++ b/drivers/misc/mei/client.c
> @@ -379,7 +379,7 @@ static struct mei_cl_cb *mei_io_cb_init(struct mei_cl *cl,
>  	cb->cl = cl;
>  	cb->buf_idx = 0;
>  	cb->fop_type = type;
> -	cb->vtag = 0;
> +	cb->vtag = mei_cl_vtag_by_fp(cl, fp);
>  	cb->ext_hdr = NULL;
>  
>  	return cb;
> @@ -1313,6 +1313,28 @@ const struct file *mei_cl_fp_by_vtag(const struct mei_cl *cl, u8 vtag)
>  	return ERR_PTR(-ENOENT);
>  }
>  
> +/**
> + * mei_cl_vtag_by_fp - obtain the vtag by file pointer
> + *
> + * @cl: host client
> + * @fp: pointer to file structure
> + *
> + * Return: vtag value on success, otherwise 0
> + */
> +u8 mei_cl_vtag_by_fp(const struct mei_cl *cl, const struct file *fp)
> +{
> +	struct mei_cl_vtag *cl_vtag;
> +
> +	if (!cl || !fp)
> +		return 0;
> +
> +	list_for_each_entry(cl_vtag, &cl->vtag_map, list)
> +		if (cl_vtag->fp == fp)
> +			return cl_vtag->vtag;

Where is the locking here and elsewhere in this patch?  WHat prevents
the list from changing while you walk it?  And what prevents this from
changing right after you get it?

thanks,

greg k-h
