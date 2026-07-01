Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545D42B72D
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907631; cv=pass; b=UXcP5pMZCLJYfv1xNwHcB9uufGktIsBJseF5orzb1DxpFoh5WKxOjfcXhhNmNF7rWHbbp9/lenUbJIf3L2oXzLDCV/H+9/3z9FsVgFo5zbCQsVNuud7qCNbSdgRjQOz3AqzYUTLzThRDXH6w1WMKmbZ18fuAXFHe/DC8bpOQ2+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907631; c=relaxed/simple;
	bh=9/m+39RgXBaNYdYcIO6pX/z82SuA7XEH4J+ByPOaFWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R153X6KxQBsX0DjciCMNH50CcHCheBCSvVDDmm3QaJ7L2hERrP55wceomhzTncyrtzZbzeH/rlCTmUluL83tws5IpeRJVYPtpRRHua/eC+fr2afuI6m7tCYmafAt8V0RcpNAPEdDWw86S7jV+xyuyDWkRHhRaH66WPYiKEh0toY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZWO54oX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFU0+raV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZWO54oX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFU0+raV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782907628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/m+39RgXBaNYdYcIO6pX/z82SuA7XEH4J+ByPOaFWM=;
	b=iZWO54oXz0Lyh4SQ0LD/2PzioT6EkOVeS0E8R9fS9IJyR/3BGz05L+Nx8mgeU55THT9jp8
	IEwe3m4aMoEMShOR/w2hBZG6j9ZiC3fcEjQ4hqkFudntRcAhHzQ4F1zmIRL+mVscEpQZ1n
	xjsSkboum+on8DKPNpYpBxG7iEH8Yc0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-nQWmmu0vObW7zFSIPemJKA-1; Wed, 01 Jul 2026 08:07:07 -0400
X-MC-Unique: nQWmmu0vObW7zFSIPemJKA-1
X-Mimecast-MFC-AGG-ID: nQWmmu0vObW7zFSIPemJKA_1782907626
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37f72223fc9so458628a91.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 05:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907626; cv=none;
        d=google.com; s=arc-20260327;
        b=LBwxc0+YziqubjCHA/gA09s9JxqEG7aIwNZcl+uWd9gD3nu/93mxRrw5X8ajI9gHpx
         EjVx1FuNJxiSY/FwKBmW9vWFPkHZnOGtiIsWPWvnkWCc1pU3DbWG/NJ/0K5jnGiBTBk1
         Ux/RrmcI+7aEgHwQBncoF4PLH9MzWBIzApnvLd8ns0X7cfGGKcTwY928nX/yof/iXWLc
         yf4LPU/nVrJdEnmrLWYl6UmVdfB/MkOgHslYLXn9PaemAYCHm8O8E0rykbS+GKjyiQAd
         AhyejlHLw0/PdxK5S9sEyIV1f/Zp+erFQZWVJvb9ue1In2GKe6PvEVgdxw5y9HgYFeGG
         Dysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9/m+39RgXBaNYdYcIO6pX/z82SuA7XEH4J+ByPOaFWM=;
        fh=sCFMgd+BZxzi0wBECUY0zuXjv5cdpf49Y7tePNHIJxo=;
        b=E/XPVMA8LCspcduUZfFa2sNY4BL6deEiyE/1LV29FFGkJxlFRYwwjObUmCiRyRdF8w
         vIEHRRgz8x/M64aCosUCGx0lTKF7h5EUrfuh3hAkitbOA7OXEM+37phbiP1uj9+8HLzb
         r3QY3SdBcv4sZdyaD982cK3h+6a6KoDSd3+yCnNLcKBOtDQr4HNoJZRMpYWp44XDlTtJ
         XBrLy0fmIYExq/9nHGQ5QBTD7V19n/hGAUkfS8QhZlnRjuQ8VzRqhtkODjaRGhFJCeMD
         jYfg2P19IP3lWL+7dUxWxYZiF5fg9im2FC3X30K0Uz6SHHYE0nLa/WXWu1D5Pbl24W9j
         D3Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782907626; x=1783512426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9/m+39RgXBaNYdYcIO6pX/z82SuA7XEH4J+ByPOaFWM=;
        b=OFU0+raV7+OGyjlcHsVfQ6B+arkv0Q09N9iqEZivR4KBmSrghuRRuCFLDOhU+9VTri
         EyF9x9Z5gq7Pu7kLL2yeJnBJ7hS3Ah8druw2Zk0WmKcb1WrLSSn8hGP7jA2p3vKuqn6H
         T58cUi+K+onHaAB2u53CvkvX+6zvVXRraVS6qDxoXwyTpco6tS0uR4IdqIZz/8DkYnx0
         4sDyYwuih0riJLQDP+qtVnnL/BHJoAHjd1Ci5A3ftD4X5O6jcn4xOZb/Ye6KErTIocyg
         jn9Dz8vF0WaPkAY8hfVnnb6ngvbt3MPTLF0kjgNfm90yxn5DiCtA2olLnObyUYGnUpT4
         UzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907626; x=1783512426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/m+39RgXBaNYdYcIO6pX/z82SuA7XEH4J+ByPOaFWM=;
        b=VL6H89b3tiJavkhGcUIZSCiMzBRKBaryNdMQh2T6IYouXalZ5eC6GZubbGwdoeF16i
         +Zi9BMRQ0fPSq5ch9Lfwh3YZh2EAthFlXKBo3a+IWGPV/dwH3YK14c1n5rjQmiml6cKy
         TmlYQxsPK7X1VggYWIaCBMD2pBiKmHdqr288fsaMG3uFp+6Bl6ZEbGlj05Xxt8jsvLDy
         psPNiGERuXJZREcZRysAhZEeDMVZCvWwC36dYu8ZeohJf4MgDhPK0eyjiFFMJyie2GMx
         VR6fRJLhxUJeQWr+97UQm0k2nFugNQtmIfohzSIjC0AT63By4JH8T/IlKXnxUYaSUT1p
         UUMw==
X-Forwarded-Encrypted: i=1; AHgh+RqK6SOS2R9UAyHFZjCRNVIJ+uOZXBhhoyyjacDxh7Y0V+4Ff4Zo+FIi65IUdBswIrXMA13TMe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbVFBYacUkvMWSVxmmjiPeHH5ED9+ibmpdhmHtePIJsYqTVp+Z
	bF063kxik+Aq2HUfhHwQ+OSL2twCfCcinMtLouF5jX9Syue4+xVlNIU+eoLqKAF4HA5qtYudD37
	/MpraSbCkhJw/6eSB0NNUUlduJ8B1AfHzKT99Lb84Ve6rwDpXhRABC7Dry94S4Og1SdV1EFACXd
	NFYcTBaXZZ539NvbX+oc9UnVGt9aZzJmpK
X-Gm-Gg: AfdE7cnI7AlRkAb7Dnlaqgv/EWAiiqyjiuJcEc/oavI+jZC5XlzWfjEyItROCLu+VUY
	XRa0q5Uzo9y6b2Pf851xDlQ+fBfeSOQ/CeKBB4rnaOkDwzueufDuIGMRBolvjC9hJYQn814pw+n
	dvhpuyQRvZB2psyJgeXTlzFXumSzIfk8KO1ERBPtGOZz7IV+tR8zOgy+pfwrJZxAx+EEQAWDPn2
	h1EOI3QEy4jizzQmzqOkCe4Ysr9QJdZFgfwohIomma5VNAH2J8GRA==
X-Received: by 2002:a17:90b:4acb:b0:37f:d6f3:450d with SMTP id 98e67ed59e1d1-380aa1313ecmr1402121a91.14.1782907626392;
        Wed, 01 Jul 2026 05:07:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4acb:b0:37f:d6f3:450d with SMTP id
 98e67ed59e1d1-380aa1313ecmr1402085a91.14.1782907625931; Wed, 01 Jul 2026
 05:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701101826.894848-1-sgrunert@redhat.com> <20260701101826.894848-3-sgrunert@redhat.com>
 <2026070107-estrogen-semantic-31a4@gregkh>
In-Reply-To: <2026070107-estrogen-semantic-31a4@gregkh>
From: Sascha Grunert <sgrunert@redhat.com>
Date: Wed, 1 Jul 2026 14:06:54 +0200
X-Gm-Features: AVVi8CeRQTqgN5cj_Z4mp2mNGeXSYNgKCI3KC-weO90OjIlH9BN804MEvO8IifE
Message-ID: <CAPre7xAbrZssWtLkVbLnEzcea5FxSZk12ZY-PpRJ4xC+w5n3Dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] usbip: block SET_INTERFACE for isoc alt settings
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, valentina.manea.m@gmail.com, shuah@kernel.org, 
	i@zenithal.me, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 01, 2026, Greg Kroah-Hartman wrote:
> What commit id does this fix?

The limitation goes back to the original import:

Fixes: 4d7b5c7f8ad4 ("Staging: USB/IP: add host driver")

tweak_set_interface_cmd() has always forwarded SET_INTERFACE
unconditionally, which is fine until an alt setting with isochronous
endpoints is activated.

> Why is this not an error? And if a user sees this, what can they do
> about it?
>
> > + return 0;
>
> Why isn't this an error?

Returning 0 here means "handled" in tweak_special_requests() semantics
(!err = 1 = tweaked), so the URB is completed with success and never
submitted to the HCD. If we returned an error instead,
tweak_special_requests() would return 0 (not tweaked) and the URB
goes through to the hardware, the isoc alt setting activates, the
transfers fail, and the device disconnects, which is the problem
this patch is trying to prevent.

You're right that the user can't act on the log message though. I'll
change dev_info to dev_dbg in v2.

Thanks,
Sascha

