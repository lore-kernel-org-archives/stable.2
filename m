Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E24183C9
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599014; cv=none; b=lBttUBj1G2P+um3xu+h5AewACee4OfTK9tLN2sSEmeTgTQb0l9lb7HpusSJQFBv4xiivaYy/tAJOUOXGyWohzexEFQNpGFrhfQxZmQ1qMV8m21edI6WgOZhseAWcRihTqilEt9/9TBg5+70DjD/1WGy87JCh9EOVKc/GC9nLgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599014; c=relaxed/simple;
	bh=FwTAhF0JYkOHxkz13m2r40n+x4FyPRy0WvVPbgp+ExU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biFoH2fXVBBqJ0jJsoMRV26CTlYGmPKIKxNkGejAhTPWEqmQiYFO5QYSGUaZldSSDlIGzVjBNhNyJ6QRtn3D4isPww1FY2XFUvaWbI51+TLiMyQtp+sKguNANFx6ITPuqM6xwErhyoDaP115V7B64QgLlLTGhlQtGDDIJBwslH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xnt4ysDa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8YLmXNn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xnt4ysDa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8YLmXNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781599012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+g/POHWh6E6oKv6JZbkNinsYGjBRuvScxGF7a7jfc8=;
	b=Xnt4ysDaanakPe0NXdSezpKrh1bq53sWL7ThFLgTwzPck6zRD9hcrG2T/88UIl5/BcXRJt
	98Lye6PuZL0S3j1uYzlQoDfPuQtynug32XuG+iu/wN8OxrY/POHAy7qH31JIVljc5VPZMq
	JBnzFhKzb2m4HhM1/KeS+tFX5iBXSYM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-GjOcsY_bNd2Get2FKXBgUw-1; Tue, 16 Jun 2026 04:36:50 -0400
X-MC-Unique: GjOcsY_bNd2Get2FKXBgUw-1
X-Mimecast-MFC-AGG-ID: GjOcsY_bNd2Get2FKXBgUw_1781599009
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef3aeeb41so2854506f8f.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 01:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781599009; x=1782203809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+g/POHWh6E6oKv6JZbkNinsYGjBRuvScxGF7a7jfc8=;
        b=J8YLmXNn54RPAB0bfZ0a5kFDft8M3n+OVni/03gZuuoOCFWESn/1Ox8kUpOz7qu4ju
         6OuBFdwQ6lf5SKuslog4AgdZKQCwsZQt7M33GTL7t30R1rFLw9s29YsKpUMfVgpQO72s
         fOvz90LobC6AOPe1xn5gSxLBBKGpny+8wCHJ0+J0JIxEWzPMkXrAkt/j+jX6eZCFJoIg
         bzIN8zm1f+oCSCdUJzjJb1dsnzsyiYjYdRvVQ1hHZCKD7NVMfrsPXOAbAIFkn9yffp9H
         WcnncRhn3xTCEwUR95JXaEYHPqsj9zUpWozv3v1cmVdrJHEsWLqC2qeztuh7R58UqZSu
         XhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781599009; x=1782203809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+g/POHWh6E6oKv6JZbkNinsYGjBRuvScxGF7a7jfc8=;
        b=atmVurYmDe88YVPV1jFH8DS8XD2Gt5HDqmWDjyVB8U2Xc+J0EknxCWRZ7zcBfr0pgK
         ybBBdnkHguDxgFVo0K6T8dSZ68Judvq7RHGA7fDoo3ybgNC9NLRiDEJvCg+h4y/WeU33
         8WmbPpycNLipdLtcjSrFxh4iwp8YJA87qw8C+VfhbxXKB/4FsGEeL5w1FeIL4eLHypeD
         K1hMYQEKQIqRlonD+IF2Y/hG8GCGN4tx6AX/dFnhTsBuv5J0J6bT844WCZYLkPSgkZdc
         LAWV9RtoMvf0UcTBBqZwuub8UVvhQs9HlUukz7gH/aktPt6bRy9y+5Ua048DE3Drhje0
         +wTA==
X-Forwarded-Encrypted: i=1; AFNElJ8QBiWIaLYpr7oNrTffDCD1bTqEaW1BXEPmknBMW+rVCVG3vRrcoJsYf79F6SmGWULoRG53uCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFVbsTjHBgNiGyvGWVgtK410lFSxMYfDgn50E6Jmf98vQMSln
	AdAp1UCC/Q/V4D468u3oPRoY0l9ekljtHm7OEnvCCwmMXHq01BO4c0cfkGeLT3jOHDnCFsyVCTb
	8huq7XaNlAb163VfJPjN1LvfS1Nxpi1nxKKt/0b7AuoWRXDkuWWnwYDsbjQ==
X-Gm-Gg: Acq92OHB6NL8NMRLCTlJRB+tk/qvr54m8ebAb4bTa7MVzLJekwtiPGoLdjjSjWledxw
	NeCqtVQqWOk09/Teo6T73tWr6AGA/CayHczkgOGHnJaH2EsfWtrcknufyBIFvyk53NH0sYNxyS8
	snGZVzeHyx84z5nFI1ZdXvDV+/x5kM1fMtN1Fh5zgCkxb0m6XXD1nciihoO2UPbjZRkRMwaDAQS
	t80yf0zUrtSENpYWmrc9ULaqv6QuMnNfC6Fn3uAGg8/2LWyz811GlDiVVT9GBkwA3nxj89P5s+1
	1ytzjoQYUpJPJ2BdzbVeH2LeeSW6dRajnEhS1ep/balsBkcsVuRUBfbFB5+4W2383prH2ozWsI2
	G3BLbfxaowNgaFQUG4OtLklDSfeB9XA0fMJz+79tZJyGrezwLnFxay/C0SBlOliBBgH3Ybkg=
X-Received: by 2002:a5d:59ab:0:b0:45e:64b3:af44 with SMTP id ffacd0b85a97d-4619f3b9ea7mr3616223f8f.36.1781599009371;
        Tue, 16 Jun 2026 01:36:49 -0700 (PDT)
X-Received: by 2002:a5d:59ab:0:b0:45e:64b3:af44 with SMTP id ffacd0b85a97d-4619f3b9ea7mr3616166f8f.36.1781599008675;
        Tue, 16 Jun 2026 01:36:48 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2ce361sm40648506f8f.31.2026.06.16.01.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 01:36:48 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:36:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com, jasowang@redhat.com, 
	kuba@kernel.org, leonardi@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, stable-commits@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <CAGxU2F6PDqHKLsW97qLUg+7hWq=iYk5qDAGUuxWSbdkyEDmsQw@mail.gmail.com>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
 <20260515114521-mutt-send-email-mst@kernel.org>
 <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
 <ag8EvTp29B-Q3nCq@sgarzare-redhat>
 <2026061624-harbor-capture-a5bf@gregkh>
 <ajD_FBEak8hKNdIK@sgarzare-redhat>
 <2026061607-risotto-getaway-c57f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026061607-risotto-getaway-c57f@gregkh>

On Tue, 16 Jun 2026 at 10:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 16, 2026 at 09:52:32AM +0200, Stefano Garzarella wrote:
> > On Tue, Jun 16, 2026 at 10:17:31AM +0530, Greg KH wrote:
> > > On Thu, May 21, 2026 at 03:15:54PM +0200, Stefano Garzarella wrote:
> > > > On Sun, May 17, 2026 at 09:33:06AM -0400, Sasha Levin wrote:
> > > > > > > What's the status of that fix?
> > > > > >
> > > > > > Stefano posted v3 and is working on v4.
> > > > > >
> > > > > > >  Should it be reverted elsewhere?
> > > > > >
> > > > > > Donnu. With the change we have no DoS but the socket gets silently
> > > > > > broken.  Eric felt given the brokenness is upstream already it's better
> > > > > > to work on a fix on top, not revert.
> > > > >
> > > > > Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
> > > > > follow-up once it lands upstream.
> > > >
> > > > FYI v4 is now merged in the net tree, so I guess they will land upstream
> > > > soon. I CCed stable on both patches:
> > > >
> > > > a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
> > > > c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full
> > > > buf_alloc")
> > > >
> > > > Both are related, but the second is the main fix of this patch.
> > >
> > > THe second one doesn't apply at all :(
> > >
> >
> > The second one is the fix of the patch originally added to stable queue by
> > this thread, so should be applied on top of it (commit 059b7dbd20a6
> > ("vsock/virtio: fix potential unbounded skb queue")).
> >
> > I'm working on improving memory management, but for now I think it makes
> > sense to backport all three to the stable branches.
> >
> > So, in summary:
> > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
> > c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full buf_alloc")
>
> Again, this last one fails to apply everywhere :(

Again, c6087c5aaad6 depends on 059b7dbd20a6 (as also indicated by the 
Fixes tag in the patch description).

I don't know what you meant with "everywhere", but I just run `git 
cherry-pick 059b7dbd20a6 c6087c5aaad6` on linux-6.12.y, linux-6.18.y, 
and linux-7.0.y without any issue.

On linux-6.6.y it's failing because we are missing zero-copy support in 
AF_VSOCK. So, I guess we didn't backport commit 45ca7e9f0730 
("vsock/virtio: fix `rx_bytes` accounting for stream sockets") because 
there were conflicts.  That patch is needed to apply commit 059b7dbd20a6 
("vsock/virtio: fix potential unbounded skb queue") cleanly.

Stefano

