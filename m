Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DCB3446C9
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785144; cv=none; b=CmJtL0gqxFA4mZAVJ1PIKEK4w2ot/n7GpJLreGY8sMuvAker1mxfM72KwlsxriHWhYLIPTMlPhAR0HVHj/MwD3fmPmqMTODztNWKxpYaA6sAVVgwrJjgnCKrEgLGKfPeiBXfZ2RHG+tEJx+nKK/VQed5DUDBwAcT8NqJpo9QZVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785144; c=relaxed/simple;
	bh=lCnQkqEcnAuVhVKI8VK8T1Nky8MXYsIIAssTgtxhdA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJm/AO/u8qX5ZB9ok7CXvPIAkwKQXmUTlQffU2i7LFuUZTUJn2f+jCLY5QZbzxjN6qvyjvvwvrePwGZD3w5sYEgI8LyFTS0HGh4/b0JTCiOK5d1OrTZtxxmUQ8OakjaUKTLz2nNsrKJQKb0Jqk1DB0W09HNf/rWWu6UWoh6A3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HT35FGNM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qrlfyFNT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HT35FGNM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qrlfyFNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783785141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GQsJAkqOxpmPMDLvAmr6k9Ihtgwa7qxpwDTrH4YfZ0=;
	b=HT35FGNMhLLxx2tRhBsITrCo5/zjuED4XwrVet8L6a3Y3ZDOY0OFqiggik1f9eO6JK9ufH
	IDz5gfHF4WBSa9Xfm/QHxLXy32+k52pWK7Wkl1aJ1lKTAD05B8KKGAJc6JNgkAlq54L/Rv
	l7y0kPe6Hpl7FOvXdDFzdLvirYpEjUo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-HdURchCbM0ag6uqvyeR4Hg-1; Sat, 11 Jul 2026 11:52:20 -0400
X-MC-Unique: HdURchCbM0ag6uqvyeR4Hg-1
X-Mimecast-MFC-AGG-ID: HdURchCbM0ag6uqvyeR4Hg_1783785139
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bdf90adaso14168655e9.2
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783785139; x=1784389939; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GQsJAkqOxpmPMDLvAmr6k9Ihtgwa7qxpwDTrH4YfZ0=;
        b=qrlfyFNTmk6Vht4B+tULJd0k1c1zHpEkKIuWjHFoZnXTcy05azR54+ANowGwVFz1Y4
         Sf9jdPsjvdKaPgkKkLFoLTXLfe3HxA+E/G1z4BbESxEi7968PVmWYvmDkZzNgUH/ZO7i
         Pq1PP6nyv4uthMA21HdQTUKNHKsgKpE1v3f4LTSY2l79V4Fwv8eNvAkXjJ80IDRh0F7V
         tOId22j8+FX9jJD2P6xy2G9Dr0lPx/39A4KoH2PT/4FzAO+h4XmQysWE0Ckiz2QrwDKV
         ejg10aHlMfIiDToB0yVwJEi5YjC4U7jZAHe1O2teA3ASpQ/45slictiq+Rckl86Rj8Tx
         WPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785139; x=1784389939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8GQsJAkqOxpmPMDLvAmr6k9Ihtgwa7qxpwDTrH4YfZ0=;
        b=KDb7sGeF0cwIgSfZbl9P4GVCUDQUYV1QNUC0x8hwgdnJTt/4tKUySjFNP/DBv9J3fb
         a5990PMXGsgn+5CCczXmbJMi2VAK8A1fUf279V9lnNz4wh3nyUMeGHUfxkbDMPERGTK+
         XlId6rDOSM+i+Ly4gOXuU7FlqOW80EH7W2Y84w9XzLwEZAmDRkUZ87aNbklp/Ws7P47r
         +ohy/Ts1fGqhZIakXbGWwOwuRdVeUXY4fVT63jZggg0LX9FLvRRJ7TsZYihsr7kOZz//
         P95rXSizpuoSam9EmPzfeoO0MHs3Ml/22lHVOYSO8mIgLSZh6Oz9nRWvilADh4vc1jYY
         /UBA==
X-Forwarded-Encrypted: i=1; AHgh+RpCJwOzr+UOWQSHN1T/NviHuXRKQWtEkaSX7uT2hxcAkT5U9VE9jwBumKGcMnrGzwEdUVH+Uvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2ZH5jGgp+oRQ2N49ZjdwRLKpgO/Foj2x5ohRVlBNtZdPpU7S
	bByxZbsTSjkvtRXYnKViG2cTVY9LMB3qYhPZ6fAY2gbVAORBoaaZ5DebIBffMEcId0ewNSUk/+w
	Wbdxy3wVjfAmTovWI1CeUTVQOVJgpzR9kDnzsqcd+j1UGJRuEUWrRD3P4Pg==
X-Gm-Gg: AfdE7cmNgLoabdyy1jxYfvM90rdkIX/kAryl7JiamQLIMcEHpYSF0npYGFkI6mmQX5E
	rytgUqK0dOh2oACP8Pk9Onb6vwRXK1JDdhNwsg5FMrqj+QmUzLmkmjtlfeQDyMXeFwLPrb/rGwO
	aMm0lbCCN1L3kbA63NN3UKGr/ZsNvc2Y7bqKGHRjU+l7iUIcvPBO90owV9HRjOSf+VKuDjQC7sr
	gJ9b60VS8V4HQhNBb1ObiXULsF3gXYC7u+icsyFjRAcS7VNHtZ7Yw1crb6JQlGEAVLBNuYRsFRi
	9iMPkg10sneC8rnOmzfPkUW5lH2sPH7e1DrEC36AZlpm8yyVX2M65StU8nhA7yGl+Bhs1bVQLNs
	iwCfNn5Gy9vNIGQUu8FDTay45b4+9pECEpwM80Ggu3g==
X-Received: by 2002:a05:600c:310f:b0:493:d115:d835 with SMTP id 5b1f17b1804b1-493f87d5800mr26790745e9.8.1783785138879;
        Sat, 11 Jul 2026 08:52:18 -0700 (PDT)
X-Received: by 2002:a05:600c:310f:b0:493:d115:d835 with SMTP id 5b1f17b1804b1-493f87d5800mr26790445e9.8.1783785138430;
        Sat, 11 Jul 2026 08:52:18 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f373csm375363835e9.14.2026.07.11.08.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:52:17 -0700 (PDT)
Date: Sat, 11 Jul 2026 11:52:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virtio_net: validate device stats reply records before
 use
Message-ID: <20260711114248-mutt-send-email-mst@kernel.org>
References: <20260711150754.2918392-1-michael.bommarito@gmail.com>
 <20260711111503-mutt-send-email-mst@kernel.org>
 <CAJJ9bXwUtQ3pHqZ=AMuwaNLs16pmujiMdeBQtB5kFc6JjM-Pug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJJ9bXwUtQ3pHqZ=AMuwaNLs16pmujiMdeBQtB5kFc6JjM-Pug@mail.gmail.com>

On Sat, Jul 11, 2026 at 11:29:56AM -0400, Michael Bommarito wrote:
> On Sat, Jul 11, 2026 at 11:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > Why does it "matter most", or at all, there?
> > Host can always deny guest service. In fact, this is how cloud vendors
> > charge their clients, by denying service to whoever did not pay them.
> ...
> > I'm all for making things easier to debug even when the device is buggy.
> > But I'm not inclined to add tons of hard to maintain code to
> > that end, and I would be worried broken hosts will come to
> > rely on drivers working around them.
> 
> I am always confused by the CoCo threat model to be honest,

Confidential computing? It's vague at points, given the term covers a
lot of different hardware. But one thing is clear - it's about
confidentiality.  DoS by host is empathically outside the threat model.
On any virtualization platform I know without exception,
host can just exit the VM, done, service denied.

> since it
> seems like some people care a lot about maximalist reliance on the
> contract and other people are more practical about how many other
> vectors exist anyway.

I don't really know what "vectors" or "the contract" are here.

Making a guest recover from a misbehaving device has as much a chance
to reduce security as increase it. So the only benefit is
robustness for users/developers, not security. And that
has to be weighted against the maintainance cost of the change.
This one is too costly, I judge.

>  No hard feelings if you want to NACK, but at
> least it's documented publicly now for people to consider.
> 
> Thanks,
> Mike

