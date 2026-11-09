Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226696;
	b=ZB5VS4K09JzfGWC0S1jjYCkey5UB17qNydLA+5jil4rCh3cqY5aURanGLnah+PNhmFXc
	 XmQAtirOzPzwpqRLucaeU6v7dejl2G85ufkNVQ9gLzP7khA4lP0sZ94gnYVxsIvv9UTDx
	 WGtR5NMZkuK33CP1ToEoNNU+3enlFhv6UdVDIPjYhbnR2sStMwcOerwNhxoFBSVxEyv4B
	 jPBOIBeUynoqYPE3SpM462d5x+GiQ0EtVBmZblIb+YV1qfMOrxlzE01VdCtTr0ezsgQ8x
	 vQ2v2jzOPPacRLczEzu264uk0MmJXDOImPRuVRzS7X2lUunH7ElVAW50ObWHSX+nIbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226696;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:cc:Subject:
	 In-Reply-To:Message-ID:References:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=OBdiK9l8kFT4f0yo7evXfhDN4v7F5oYM4pE8DacBPJ8=;
	b=KciCOMYWnfpTelha9JSh9iorJYYCFA1hcARhn38NZUb31URZNnc3Yc/oRl+Q/KRrIGDl
	 oqu58aMOpMZjv+9FlabHDv4e8jLN96mtdDpfYDaoEHjMYA8uO11/y5jlAdNnSlF54LPEg
	 KvVnE35GkzgBnrLH7UINkuWP+o9VNbUhp5RTXxST0JvEfcTRm++rvXhqVvat8hx112a5Z
	 JpFd6i+9CIZHaO18+5bNvPTuXWBy7MsdFg/cdfRQHnqxwTpoW0xc+eR2e3qXbOvFBGveX
	 tpYntR/eq9NNBogIqLjQLdrvs17xvvsz73aXKhoYXnUwSgaYfntMoKuKFM5dsotPvkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eqYMu1q9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2081606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2081606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eqYMu1q9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794226694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OBdiK9l8kFT4f0yo7evXfhDN4v7F5oYM4pE8DacBPJ8=;
	b=eqYMu1q9Z9yX8Hn/u+rRWNpukZBzIZRw/Y5q6NSkTrHGOSk/DjzhYfeQqJF6OyZyVow+Cc
	1qcZz2ylDRC/UK0IJc/gbAz+smCzyhWhLGX+CQk0pvLOofwUgxSFJltCvYiVvo8vRgCot4
	r/wGdQYdK7dfmxooSQFY2KX+Yb1cGxM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-B2yFbfMxM02T4zTZ50vSbA-1; Mon,
 09 Nov 2026 07:18:11 -0500
X-MC-Unique: B2yFbfMxM02T4zTZ50vSbA-1
X-Mimecast-MFC-AGG-ID: B2yFbfMxM02T4zTZ50vSbA_1794226690
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12EC3180055F;
	Mon,  9 Nov 2026 12:18:10 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23EDA18004F5;
	Mon,  9 Nov 2026 12:18:06 +0000 (UTC)
Date: Mon, 9 Nov 2026 13:18:04 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
cc: Josef Schlehofer <pepe.schlehofer@gmail.com>, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Ignat Korchagin <ignat@linux.win>, Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH] dm-crypt: defer async write submission to write thread
In-Reply-To: <0197be1d-1257-4597-aea2-1a065fe0a1d5@kernel.org>
Message-ID: <4093292e-1fa1-dc18-b185-18dff61a32bf@redhat.com>
References: <20261105072708.30722-1-pepe.schlehofer@gmail.com> <0197be1d-1257-4597-aea2-1a065fe0a1d5@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On Mon, 9 Nov 2026, Damien Le Moal wrote:

> On 11/5/26 16:27, Josef Schlehofer wrote:
> > With no_write_workqueue, kcryptd_crypt_write_io_submit() submits the
> > bio directly, even when called from kcryptd_async_done(). An async
> > cipher may run this callback in softirq or with BH disabled, where
> > submit_bio_noacct() must not be called because it can sleep.
> > 
> > Submit inline only when async is false. Async completions are sent to
> > the write thread, as is already done for submit_from_crypt_cpus. Use
> > the async flag rather than in_interrupt(), since callback context
> > depends on the cipher driver. Sync ciphers still submit inline.
> > 
> > Tested with cryptd in QEMU (x86_64 and arm64) with
> > CONFIG_DEBUG_ATOMIC_SLEEP, and on a P2020 running 6.18.55 without it.
> 
> Originally, this was added to avoid write reordering for zoned block devices.
> So did you test this change with that (scsi_debug or null-blk) ? You can also
> use an emulated NVMe ZNS device in QEMU.

So, should we disable asynchronous crypto operations for zoned devices? 
Would you send a patch for that?

Mikulas

