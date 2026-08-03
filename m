Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0A2F49F6;
	Mon,  3 Aug 2026 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738426; cv=none; b=gD90t5ucEAlxNHdIjFU0RmlRiwjXWulL9N3VqQPAxr8UhcWdcGgysW3+6ucubderPC5K4DB+KgFDsU2J5XedBXMXKIENlquGq41iXKMx32hA1r+9OENGPlHEorH+vSefprvw1cpYAXe9JvEhBJZmiYdTyY401C4X5AYTGijlrq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738426; c=relaxed/simple;
	bh=QoxOce0MTtOwqSWW2lZbfe8qhvS9ScXFaQBCFy+pV6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdvKiI5+OcMtcoPltNRqxcoWC7gTFkUDPO/Yn+XGMLFv5o9PMueH07wrfQkISaqv82u+DJSkrt4+q7T4yzvcasssjYQJvSzhzLxFMbJAQ5WWFQKjkVmqcv6n5169guxYFtXXXb6nbsOvv3VkFVzrq+frIQzXkcPBZLuf6orUo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJMGAI0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJMGAI0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359E81F000E9;
	Mon,  3 Aug 2026 06:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785738424;
	bh=J2TTH5LL7SR8MG7wdePTdS0tlBznkX9a7DDPhTPfL7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VJMGAI0dXX40Cx7bKAQV0sBAFQk2iSIoYeFCEMESJ0fd3sii/WHVsqK+7nxyWfNjS
	 +u/uFNP5gxoqxozI2PjrLW2G90SHkYvd/MRxlN6et1m9pbc3+u6dUDVw2dsT1gv3Yg
	 v/8d3CjXzgwM2JNmjkc6Rp1anS3ndDn3nfPOWB4E=
Date: Mon, 3 Aug 2026 08:25:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: gadget: midi2: remove default configfs groups on
 teardown
Message-ID: <2026080342-theorize-everybody-9f2c@gregkh>
References: <20260730135811.1498-1-joshua.crofts1@gmail.com>
 <CALoEA-yuzdD9=gBy0s0VFc2yD5Kwga57LjECUWTTXdF2SHed8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-yuzdD9=gBy0s0VFc2yD5Kwga57LjECUWTTXdF2SHed8g@mail.gmail.com>

On Mon, Aug 03, 2026 at 07:59:17AM +0200, Joshua Crofts wrote:
> On Thu, 30 Jul 2026 at 15:58, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >
> > f_midi2_alloc_inst() creates default configfs child groups for the
> > default endpoint and default block using configfs_add_default_group(),
> > setting their internal refcount to 1.
> >
> > However, during function teardown in f_midi2_free_inst() or EP cleanup
> > in f_midi2_ep_opts_release(), configfs_remove_default_groups() is
> > never called, therefore never dropping the refcount and leaking struct
> > f_midi2_ep_opts and f_midi2_block_opts.
> >
> > Add the missing configfs_remove_default_groups() in the afformentioned
> > functions to free the structs properly.
> >
> > Fixes: 8b645922b223 ("usb: gadget: Add support for USB MIDI 2.0 function driver")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=eaa106d192c9daf37f95
> > Tested-by: syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> > Aside from testing the fix locally with QEMU and the reproducer,
> > syzbot also reports no issues after running `syz test`.
> > ---
> 
> Hi Greg,
> 
> Gentle ping on this patch.

It's been 2 "business days" since you sent this.  What's the rush?  If
you wish to see patches reviewed faster, please help out in reviewing
other patches on the list.

And as this is really only a syzbot issue, the "severity" is low, right?

thanks,

greg k-h
