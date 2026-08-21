Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D066411A08;
	Fri, 21 Aug 2026 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291981; cv=none; b=t4LQGA6PDv93r8SWfTPwn2jAIcpbN4U0mOM/FWFrTPPfw3u92/pgVIi/IAJRaGjHddKwBOA29xmRxL5gkfG9GiSjkLU/FeSLL3nkHbree/8a2i13QRQh+e9HciD7/qCgFtTEG2AZHNcTQGRhJxwTfle3f7v+mNFFM7/pMlfd+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291981; c=relaxed/simple;
	bh=cnkNiV1wh6weooJASTUIAmIywSmf3fhIWXQVnZedVz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsalNPnNGiCJbUd8A11CUIiDz8FDWo8+CnYIxJfi2YcP6jhAk527ugpbAk0Ny+2oSEQvCS92kC3uxhnPEgHLjw0UJVX0oHuAX12hHXzTInARpQs180zo/jl3Uwv1Ktly/uAG4emG0gElila6PCNbCohFXaaen3iXsjfYAna6lEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tuo028z3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tuo028z3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1BD1F000E9;
	Fri, 21 Aug 2026 05:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787291980;
	bh=jowWn11DgLwD3zm175NNTzJhQmZcmo1gx64DuB5w8SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tuo028z3djike+PT5TikmsZOg2FBk6LWVdtuKvThI/d8VkizsUujDMI1SSR8njpmf
	 LvC5AFA0Q1OYfWRkFOMbDd6LONcKbz3JInM4w2CW9Oi2bQNMzN9WC5CctLZCX6byIv
	 Lh9KiKHqM4jcXIZq/xu7ZGRG/FvpootzTyCj/80s=
Date: Fri, 21 Aug 2026 07:58:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: liuqi <liuqi@longcheer.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
	syzbot+22ea20ef3afb6785b122@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb-storage: ene_ub6250: serialize card type probe with
 scan work
Message-ID: <2026082128-hamstring-graph-b209@gregkh>
References: <20260821055358.1058653-1-liuqi@longcheer.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821055358.1058653-1-liuqi@longcheer.com>

On Fri, Aug 21, 2026 at 01:53:58PM +0800, liuqi wrote:
> usb_stor_probe2() starts the usb-storage infrastructure and schedules
> the delayed scan work. The probe then calls ene_get_card_type(), which
> sends a command through ene_send_scsi_cmd() and the usb-storage bulk
> transfer helpers. These helpers use us->current_urb.
> 
> The delayed scan work also uses us->current_urb when issuing GET_MAX_LUN
> through usb_stor_Bulk_max_lun(). The scan path is serialized with
> us->dev_mutex, but the post-usb_stor_probe2() ENE card-type probe is not.
> 
> If the ENE card-type command is still in flight when the delayed scan
> work runs, the scan work can try to submit the same URB again, and
> usb_submit_urb() warns that the URB is already active.
> 
> Serialize ene_get_card_type() with us->dev_mutex, matching the locking
> used by the scan path.
> 
> Reported-by: syzbot+22ea20ef3afb6785b122@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=22ea20ef3afb6785b122
> Signed-off-by: liuqi <liuqi@longcheer.com>

Did you forget an Assisted-by: tag for this?

How was this tested?

And as before, we need a real name.

thanks,

greg k-h
