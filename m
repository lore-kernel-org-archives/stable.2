Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806787;
	b=jb+h7HiVrcIwxNBAyXwg701fdSGnhWTmrSGQ7w9/ObJWGUTr7qHYoJOlljYmyu6yoD3U
	 otA4tTF5gtQathYiXc5BEXNyghbaqWmNxY2vpr5dnnUd5TNp5Dk9o2S0MgYQvdVbDfH/L
	 uQgKw1hWbOSYP5OfkRzXAZojaqv/x86epwugGgAiJ4Sdh8buEHiZJhmACv4ZqKSQmVT3z
	 AlpjHMn7J696FGKbifYqiV54vO19tQ+YIUZLMQiCTcKLeRHks8pCykIsL3KMX/7Rl0qff
	 OHOMWDQ3AhaKBAkRNa4Ad2ZHMhogV+6ZsASrNVJDpcta1GvKQ7JcZjFFJEdi0VGINDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PwIJbRJBmxhNvtVEYVBcszZ+9KTP/NlP4a7yp3L2Bd0=;
	b=2kfEe7w0N+p/ZNv+AE1lK50oZccX/KTXw9jld2uje/bTSTQLZCp0hUbFvxIUObUVaSk4
	 +Xvz1fGW3/0dNOYhiQJKIgZ53VptvSh5kVv6OKPr7ttbgo/mEmcq/59FvvNILg4fAVznp
	 uKDviRWvK9TgJTAVXpNfot+2gcMvJqXgddutHDdM/TunyL/F71EEQ3xmXHa9q93Z6PUVd
	 k8KR1BGyuLORmSYjFsu+8Iwe658RBB8I5asoPSYcD5/wO4yvXy+a5cYiD9ujaURmlDqu7
	 GcsaiuK7bXD6m3rUZTz+Yke7OkEzQEklNfu1xXWzW2b26E1ioflenG9Fs7Pm522TMUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=qJuEGuii;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDED606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 01:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DDED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=qJuEGuii
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93cb9e9405fso69144685a.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792806786; x=1793411586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PwIJbRJBmxhNvtVEYVBcszZ+9KTP/NlP4a7yp3L2Bd0=;
        b=qJuEGuiiTo4qSSJz7+E1oluEgXCF5Q7bIkPpU+mVQJxKqdJQl0qn99fQARIHEz0SLf
         7Zq/R5fGJcEoYsDfI4rKiSj6X2gKELccAr9cvephMMb6R69nQL5BERqC1sdoe72MomTI
         nfJ1+BFPu8ya8iOaDBmS1HPMjKmwWP2cYv7U3FUlsTJBHFsyo/cnHwyxD57v1QJAf1uF
         EL9xd+P4nRtom4L07elrIoZWOPmB5+/hTi9vtr8wIVbw5rafwGWXAek60zJP3O4vNzkR
         w+j52awfLN3pFwyE80YIl7wuJOP4FQqA6jyPp/b4f+bgLReMowERYR/DpctJgX5Jj/lp
         Vi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806786; x=1793411586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PwIJbRJBmxhNvtVEYVBcszZ+9KTP/NlP4a7yp3L2Bd0=;
        b=njj6O1KkSqoxfvjKiDQf7sE2MIlqKwGdPZgyzXZ1osIfpkjQfwVaP+7NEY1x/9Th3M
         JyloQfUxHcYXObyLo1YLtwjJ1Fa5J68ScZ4lMFPvc1XesH0bFHxwijLWmcKDld8Fvkdw
         lDINsTBGxYWovkh6H8TYTmkN4h3PpsAhEm2e6DJStdxAArpyYsxN2In6cTiqi3EaFrOc
         FxldtLAH8Ob2H7zX4696sT1UJ8oivL13uYmDugpGRhWuQnqlYIyiiDzFtKtLs5zh1rqN
         VwH/o45TVZAsOqm5uhcG1HsQ/lXTNZlkq8RSeO/uuQHXMXul1HtfERx+otTqlJYfKpHm
         TqdQ==
X-Forwarded-Encrypted: i=1; AKwUvBydzet3dVrSqWHfKBHsaXvyun1CemhDiJoMY/7xuGgaPZZYTOt4YxwjuDI7GzezKqSVOC8f3qQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIs8Mc+hlB7pGW+vlVTe6Syh/oCvhlDcNSnzfQFarIVVaPwh2C5
	jJeP+0v1GImq9DjcXaHfw1HEkxtHl5RWdrfsRxBoqjeGOFls7QnwowrvN8OImOIQFA==
X-Gm-Gg: AYBFou3J/wOyD8uiWNPD/7qke4onIlfRCLduJBhvTNWdfhDGiMFmCCD/iFQOOms/495
	i6vFHFUzeL/JioQ0aW3mxG5gxkk3fFjfzRi7oPkJITiusBP34aNsTEN7sWAJy07b+ypZ23FfRpo
	TobT7tY29mpuEd3fEyq4HHUUkI6IfR8+39zN62kMlyqZU5BsjuWq8OE2yDixk9+LYzeCd/jxRBZ
	iN7/FXJHDO3XUqYCUPC43wjf+GAhsGTemkKiJgMFknKYmMfcT6Xpy0ZXLeZjd9gDEz9qDsialGf
	86EGAgZXxCqmtW+8hSTvBz5lsgFxVmPsYCpPXJbqK6wtXAg/Va/YnmKOcXwECb/lJqvI0k+A7hv
	nIaFZRNABfCWYun72H+g8umw1JkYpiT5PL+eaZ8uFj1C01Z2ZpflrbmCJHfN++VXS6Fh0Svr2iS
	v5JJlugeVbnP0kimgi8F/lyrDTikgaVHmZaXx1CxJbsvn4lbiGeav9dcLrEPtsKUqS55/SyC+FN
	Pb4XJ/qFJr+nAcU63PAsB95N6k1ydazD82+oQTEEOtsexujHqtFx4OSK5yMJ/8/J7EE2Q6UCfuv
	pw==
X-Received: by 2002:a05:620a:271d:b0:93e:ad16:9590 with SMTP id af79cd13be357-940ef94e80fmr107135785a.36.1792806786139;
        Fri, 23 Oct 2026 18:53:06 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f06672d6sm62365285a.12.2026.10.23.18.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:53:05 -0700 (PDT)
Date: Fri, 23 Oct 2026 21:53:02 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: IgorpetinDev <igorpetindev@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: core: hcd: cancel giveback work synchronously on
 stop
Message-ID: <d95ba108-30f2-4c86-a47a-2b842b8cb25a@rowland.harvard.edu>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
 <e16930d5-375d-4d61-9e37-94dc9a83ba64@rowland.harvard.edu>
 <CAG21Q80vg9LdTRmFMC4aq7j=uEPWpEFNr3+1MLLUw_UU_cjd1Q@mail.gmail.com>
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
In-Reply-To: <CAG21Q80vg9LdTRmFMC4aq7j=uEPWpEFNr3+1MLLUw_UU_cjd1Q@mail.gmail.com>

On Fri, Oct 23, 2026 at 10:31:27PM +0300, IgorpetinDev wrote:
> Hi Alan,
> 
> Thanks for looking at the patch.
> 
> I think the bot caused some confusion by talking about stranded URBs.
> There are actually no pending URBs left on the list at all. The driver
> properly killed all of them.
> The issue is a race inside usb_giveback_urb_bh itself. The function
> usb_kill_urb() unblocks as soon as __usb_hcd_giveback_urb() drops
> use_count and wakes the waitqueue. The caller immediately wakes up,
> finishes removal, and frees struct usb_hcd via usb_put_hcd().
> 
> Meanwhile, the worker thread on the other CPU is still running the
> tail of usb_giveback_urb_bh(). Right after __usb_hcd_giveback_urb()
> returns, it tries to access bh->completing_ep, bh->lock, and
> bh->running. Because bh is embedded directly inside struct usb_hcd,
> this access hits already freed memory.

Okay, now I understand your concern.

> So all URBs are already completed and bh->head is empty, but the
> teardown path still needs to wait for the worker thread to fully exit
> before the HCD structure gets freed.
> Would calling flush_work() on both BH work items be the better way to
> synchronize this without the concern raised by the bot?

Yes, I think it would.  After all, it's just good form to flush or 
cancel a work item before deallocating it, if you can't prove that it 
must already be idle.

Alan Stern
