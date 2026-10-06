Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767E3CB542
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322060; cv=none; b=MhK+g8y3pG1yYKTHJT2T3VLFJI618aZ4qARwVz4r5xJ2ifVp/5xWnuaNZtGSpZ8S6MJTUDc95W4rmiiSRaGPBOzNN/DnuNMc0mKuY83JYlDUqvqgVE6pG4FX/yFJR43GVwMpDZbycn3DR0GIs+xYAvMMzzpbbCbwHbq/j8GiX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322060; c=relaxed/simple;
	bh=J518TeBei26VEQXbPGvt3y4HnC5DH/HWj48vtTb4u5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRUVMjTVmGNm/VTbcZ/okqIQ1FQW4zGzWIr6cwsz/lCfxkLQKWxwTFaZd82zlzXHdnrgoS9mSBuDdAA5MovaDXD+y632rR38TjZWlMSKe8tpmN3Oph6d+B0IZnPzGkmcMSKGf99GyFyzV6gh4bK4UyPqHcItEpuFE4Tkk9cg5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsznIeAj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rADkPjbu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsznIeAj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rADkPjbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791322058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLYqLTXYL+33FHGPoAQIFrwweKpAyRzDOJvC/lVBZus=;
	b=BsznIeAjSR3qjDG49YUmAnzW302ftg/0ULYsp3Mcp4/zF5A+j0jTngxhAINTR6LMbTEdIK
	j2R74Ax5mze/+00eh8XMWfhtaihip9PBJSw4PYSXVIBm+nzqkEGnXrP3hb4fowQgNQYL3M
	Hh2vQGCleIBwpB6n/YpvjYTKCtHGv3I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-lxONDCadMnuGy7Jd8dOSug-1; Tue, 06 Oct 2026 17:27:36 -0400
X-MC-Unique: lxONDCadMnuGy7Jd8dOSug-1
X-Mimecast-MFC-AGG-ID: lxONDCadMnuGy7Jd8dOSug_1791322056
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a17ec7a49cso2786315e9.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 14:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791322055; x=1791926855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZLYqLTXYL+33FHGPoAQIFrwweKpAyRzDOJvC/lVBZus=;
        b=rADkPjbuB17Ew5AFD9IEklGCqqKcmdwTrQ6CueORguw/J7rMCfCrXaPVZ21STyIpd8
         N5geO0+t9NJXJUXbr/8+VpLLyAu+cE9OQ5OhDak4lkrjh8w4wd8SrXSnkerj2JVjXIhF
         2DfNA7epkp7X/3zAZcu6L7rqFs3E4Kh/CmgaRd1EwGA+YLLVrDGgMbuHST/nCuhs4kuK
         /2hf6wpaEkacVcYks++7Np91ndzTQ8/dPEcJGr3ugieuycTBhU9pStyvaN9MzusuRgcy
         3TROJvZ6rbOCqQVYWzKAX2y4mMKkiwkVTYNeTtBMHio6U7cw3TWgHdK2yJlEYBNbRQri
         8ZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791322055; x=1791926855;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZLYqLTXYL+33FHGPoAQIFrwweKpAyRzDOJvC/lVBZus=;
        b=NGGacN9EF1aF0ZIXayo3Ses466Ra9bO8ZOv9vH42IwwiHc7u55GS9X8P/eUPpjfsWx
         pz1+eilb/K+6ptekeRK00WKoNm7hm3GyU+/H7G1inCmT4piTdmPNdtqzrGcFJ8XlMC8E
         Jq6uxLeTofzl+qGvWPl+VjHrnMoawc/abCFoEMVBv+P74f/ErIMsf2IcI3xilx7GWxY/
         3AO7gQwqB0liFz68ccUa9RTZJ5nOZsXezX0odQckpqScWlecQG7+v+7xkN9PqK4ZhPVy
         Br7pvTuyv/8T4tgsaqF/7pTqrm4eJhcqqptTf012NjleC5DG7r3SFrhz5wKcaoIdHyao
         lkNA==
X-Forwarded-Encrypted: i=1; AKwUvBwKxpVqLF6tBFlYEZkwSaeZ+l1ixF8CRjLEhK5eUjhJcAcOQu5ZS+DsJHFlxcYJriIMVEcVc5w=@vger.kernel.org
X-Gm-Message-State: AFuF++kuqQM8OfB9/l3a9limog5jCfVd0X4SilcG+Hb1j4G2diBMpafJ
	LoegCRJT5T749AzSjh+U/X0oL6aSNnzaVEFQtIXIGuok6zsnDHc1UUqwFSO/eKaMvVD25zpYG/Q
	3O/kgTt5kvE0uq932LdXcyepkZ/A5Td74J+ni2Kt60fSsd655fJg12+cjMA==
X-Gm-Gg: AYBFou0Pf9IFvQ5ZScqu/8CT5OvQz3gYvLI7rjm0YFsgWjm2v8n33S/EKNTU4vKgd37
	yy9TUIbcnZWwKnbcAJwzPb/1t2X9l21XuqKrBmZ+yO/hos4ncYLXBloQ1ha6ueTOE9PEpWQaJcz
	sPc+oE//LfVDEk6adX5ShXj0UEnF3j/FxZ8Mz8B8Oty4dk+5iEw9nME3/6JtzgMKMkRC2hh8VWL
	fMzet5R2w5ueiqex6/gNLoLT9Wr0fC8HgepRv2fO8eqImgzjUUcP/8vz0LCHnWTMv36GTNRbEiO
	/LhgZfs1hQycAgxRt9+IfgFzHPOVgKZ0tOHhW4ThasCdNgx/aPotQ5rDzw6necLkXw1xwho=
X-Received: by 2002:a05:600c:468f:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4a1806508edmr1608115e9.30.1791322055564;
        Tue, 06 Oct 2026 14:27:35 -0700 (PDT)
X-Received: by 2002:a05:600c:468f:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4a1806508edmr1607885e9.30.1791322055050;
        Tue, 06 Oct 2026 14:27:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f51beffsm14516105e9.2.2026.10.06.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 14:27:34 -0700 (PDT)
Date: Tue, 6 Oct 2026 17:27:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sungbyeongchan <tjdqudcks0424@naver.com>,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] virtiofs: validate fixed-output response length
Message-ID: <20261006172721-mutt-send-email-mst@kernel.org>
References: <20261004123405.586168-1-tjdqudcks0424@naver.com>
 <20261006182408.1301152-1-tjdqudcks0424@naver.com>
 <2026100633-roping-stardust-a6ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026100633-roping-stardust-a6ab@gregkh>

On Tue, Oct 06, 2026 at 11:11:14PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 07, 2026 at 03:24:08AM +0900, sungbyeongchan wrote:
> > A short successful virtiofs response can leave the fixed-output
> > portion of the request argument buffer unwritten. The completion path
> > nevertheless copies the full declared output to the request destination,
> > allowing stale allocator contents to reach callers such as
> > fuse_statfs().
> > 
> > Require successful fixed-output responses to contain their complete
> > declared output. Continue to permit a shorter final argument only for
> > out_argvar requests. Reject positive and internal restart error values,
> > require valid error replies to be header-only, and do not copy output
> > arguments from error replies.
> > 
> > A header-only FUSE_STATFS success returned stale fields in nine of
> > nine calls across three boots. The fixed kernel rejected the short
> > response and preserved complete replies, valid error replies, and
> > variable-output controls.
> > 
> > Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
> 
> Real name please.

a missing space I guess?

> > ---
> > Changes in v2:
> > - Reject positive and internal restart error values.
> > - Require error replies to be header-only.
> > - Rate-limit malformed-response warnings.
> > - Rely on the existing FUSE pr_fmt prefix.
> > - Add Cc: stable@vger.kernel.org.
> > - Use the reporter identity consistently.
> > 
> >  fs/fuse/virtio_fs.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index f15e516ebcb5c..fffbe08d9114a 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -4,6 +4,8 @@
> >   * Copyright (C) 2018 Red Hat, Inc.
> >   */
> >  
> > +#include "fuse_i.h"
> > +
> 
> Why is this moved?
> 
> 
> 
> >  #include <linux/fs.h>
> >  #include <linux/dax.h>
> >  #include <linux/pci.h>
> > @@ -20,7 +22,6 @@
> >  #include <linux/cleanup.h>
> >  #include <linux/uio.h>
> >  #include "dev.h"
> > -#include "fuse_i.h"
> >  #include "fuse_dev_i.h"
> >  
> >  /* Used to help calculate the FUSE connection's max_pages limit for a request's
> > @@ -730,6 +731,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
> >  	unsigned int num_out;
> >  	unsigned int i;
> >  
> > +	/* Error replies contain only the output header. */
> > +	if (req->out.h.error)
> > +		goto out;
> 
> But no error is returned?
> 
> >  	if (len < sizeof(*oh)) {
> > -		pr_warn("virtio-fs: response too short (%u)\n", len);
> > +		pr_warn_ratelimited("response too short (%u)\n", len);
> 
> Isn't these ratelimited() changes separate from the original issue here?
> That should be a separate patch.
> 
> thanks,
> 
> greg k-h

