Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4382749CF
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744239; cv=pass; b=loIq3ghUfXXAWyI1qCFv+s90Cr2P4oLDRNGzbSmZeju6yl9O90GUS8Gg2rd4VFp2vFCkbfWLEyT7u+zLpedy6SVfSDgkQMFmW64ALk64EXwnMY/jsoxcyFleDo/XxRUMtMDTP+SEEWKpSL0W2kqzM16q8TyGWT1vYldz/Xw8Vfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744239; c=relaxed/simple;
	bh=r4IaJvvyIT6el7i2weVkvEk5QehixTD6dFSGgLsOExE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAMzFQiPutBr5RLrDaXMH0YE7d9H1xU/5gReJyLfSmGPxzFk0D4mYvPg/TtaNmsyYzfZzTlvsvkynQL3uz9MiIplvJU0fsFEJ/Cq+NO/zwqVkCJ7I3D7DtXWhCgT00LimpJnvT251cX9cwaAhOEkiglK0Lk8ukhDF8vGA5bk+go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiZ5FrA9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fv6lSR9d; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiZ5FrA9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fv6lSR9d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781744236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIF8cjycHSBcMVtLMb8AxYPq8NTa82BvKAmKc4vxWAU=;
	b=XiZ5FrA9DJ3vzWcxR9eY5D1tQ5TBU9UXTganM78Da/jawra+j1oqAtVqadp5SDK++e08MG
	A7IYq9M/ZrpxXHuF4+l5e9RN9RE6hpJONoIHS/8jSe3cW5kN8OYm9HOJtFL6hnTk/E/ZF0
	WOwDSsfijoyzIuQ7AFFWV942UylVUp4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-je63qzjOOOS3XOn9y0u-AQ-1; Wed, 17 Jun 2026 20:57:15 -0400
X-MC-Unique: je63qzjOOOS3XOn9y0u-AQ-1
X-Mimecast-MFC-AGG-ID: je63qzjOOOS3XOn9y0u-AQ_1781744234
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4862fcd9a3cso715825b6e.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781744234; cv=none;
        d=google.com; s=arc-20240605;
        b=ctIX5afMhzBJLGcGz6voSU+zGKDmnqWuPb5pFi4OCX5YcqDBPR0r+sg0qXVnWNBVku
         idivhaKZhHnR8eqBRHeH+8UZv7ymAhtlzvgZuxORr7wQQyOt72pk9mq9XSiZ3Xp7GGmY
         PqTMWlQJyvaJW7RKuzAKdzulGJ0ggHsNNxsVqB1/Xef1MFvv2HjRUsWWBNYyVFej7iIe
         cwfdPsTCbFGarLl23lvDcI16Soy8wa2aP61vYz7uDZLpB7gNubUNsGL50wVaGcsuRPbt
         zrw3W6Q3BPNlUnxwQa6KWU7ECZPQI2aOKqn+xuCdOPrmZrgsi1Cb/IytTT2aR+zOt5WX
         GiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LIF8cjycHSBcMVtLMb8AxYPq8NTa82BvKAmKc4vxWAU=;
        fh=yMh1RpebrlhVOsMIWIy/n2A2l2IK52rdqE546yhthBo=;
        b=VLTeS1DaKe7QF689zpQUvSKtn6QT/Hy3HfHHowiEa9ZdoUs7/jevwuC+bezDM0CXXk
         ei6+MjQE4KouSvYxBSA34VmM71X5t3FLs/L3d+UjKjTxaOzYJ3cKUN+AnBaTlcGq0ezj
         fUM3N6BjiEccxnDIaQ6/dPIRRdc0cnscs5aWKWiIe+HKCzGGUCXpkhruck9og6/3xERl
         /ng+WJwAMV7UW2CKIaCT6NIxZ70eKrG8vA+UkUipERFYw/aGNfznaBaHZ3wKcDC1JaPG
         zw2hmJuL5gGF7UCe4HD/P2zF8UPEjTLL6OVj7hJK6kvhtrNLjLPInowwhlRi0sg4PyOm
         ed4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781744234; x=1782349034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIF8cjycHSBcMVtLMb8AxYPq8NTa82BvKAmKc4vxWAU=;
        b=fv6lSR9d1Jg2nCeUtN9wn/iv29OT6Y6huLncqVvDO0hRz+MNb3dyugER7XQzpzFuXc
         SY5KacwgK1LPU2Ft2gjeUBJa2HqrLyI8NMlxka3szURpqFbBGIT6K/O5mLjoPCgDZgz1
         PYVxvcUlYSJYaZaWYwVQgFQFOa1pi4uthn07FzSxdEtYTH4WxKcfJX9Ylm3lYEZAc3x2
         mmJP9RiEWpbJcbAVPRtys0iUvyk52rBxPLchOhi9ve3Jer38FP3wmiJYGpQqxmeAsm7+
         0dUHbxaa7cT5s+k/evxzzAT0xRnli++HQ4DkEvJDJA7elEL99bIhYbo9F2mD8HHSfNqY
         WfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781744234; x=1782349034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LIF8cjycHSBcMVtLMb8AxYPq8NTa82BvKAmKc4vxWAU=;
        b=gxn2AK568mJcWzgrp5E5jRd7PbeFDXFgA5ednhXPTxMF6rfCip3lr7Ugg7NzDvbC0o
         SH8Aum7Og59J2h868xMQyg7jHzYg+/Nxk77lwCtDwJvMs2Rmwvxa7PcgSs7lgGfWaxsB
         H9kcnHI+dsfpLCOy9oQYoGEkvOeCj5KAvhEIJyO9O9CK+mrkol5diOCW/4ATJqlSI3V7
         NBEEzq0gC3wucos5n05D7VDxRxYVrDXxN64U9tZ3h+JY9OK1L1ljVZ1450QZ3OvoTQcy
         n80fJPeWAZ59Z4a3GxVwINKutWvJPz0iz50YTE4IVCU5lHfZANj1k6y5s4NcCEL2fn/g
         9fpA==
X-Forwarded-Encrypted: i=1; AFNElJ84EV74p1BbjznCwqdbCVzosE0F6ddf+5sVMumcum8FBfB+jDIVSMBYYbMZUKHX7IVhkDyq9KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kF0va2+IacggWMdzdJ8MR1/Jh9P70CfJgK9wGk6h9+J1NDEV
	iO4Mf1eqAru8mRM/QBTYLVcw2FWHJgeCPdtgwglAKZ6KI9ns7e3QTUha7NCc4zgod4rIub/1Kbj
	Ian+hA4ZOkAAG0B9kVAngzn02zHCEkNUu5E5ggikZF8GoFCkc7BLqU34c93XsXc84b/vYslfpH9
	tMoVLhKJ/1OHkSeSqoNZQaRlekjT19c6Qy
X-Gm-Gg: Acq92OEMQPUko0LRkfCggOBLei/YghsXz3xrE/44U4cxHY6w0SQu0na7K6Y8zyKmaa/
	aK55gBkuURUqudLgSlDG5CQMbx5gDvCmTFXXEyN88d1K3mhb8Wu5BFr21HBY+6iCLn+SpdkNtP8
	1if1x7tM0R3lveiw24DUUQG53gGJ2SaRj4uLOmves/ib0UMGXFDNALAkD1WZsndlkHf9IFIwKz9
	JdGcW5CMHu/oUb/p5rNE3BGD6kz
X-Received: by 2002:a05:6808:3442:b0:467:13b5:8ae6 with SMTP id 5614622812f47-4895d0e6f4emr242151b6e.4.1781744234297;
        Wed, 17 Jun 2026 17:57:14 -0700 (PDT)
X-Received: by 2002:a05:6808:3442:b0:467:13b5:8ae6 with SMTP id
 5614622812f47-4895d0e6f4emr242131b6e.4.1781744233829; Wed, 17 Jun 2026
 17:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430014817.2006885-1-desnesn@redhat.com> <CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
 <20260502235517.089ba5bf.michal.pecio@gmail.com> <CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
 <20260503071749.6abda137.michal.pecio@gmail.com> <CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
 <20260503213111.117db3a1.michal.pecio@gmail.com> <20260504093118.615ff480.michal.pecio@gmail.com>
 <20260518083339.507e24bd.michal.pecio@gmail.com> <CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
 <20260522110328.0d3eecd8.michal.pecio@gmail.com> <CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
 <20260523022944.59799d83.michal.pecio@gmail.com> <CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
 <20260523102815.5c05c70a.michal.pecio@gmail.com> <CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
 <20260527103221.7f8b15b0.michal.pecio@gmail.com> <CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXaFbd=ySXf8E5A@mail.gmail.com>
In-Reply-To: <CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXaFbd=ySXf8E5A@mail.gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Wed, 17 Jun 2026 21:57:02 -0300
X-Gm-Features: AVVi8Cf7Uiv1UFfqctPnTUuo9KLx6CyYhY3_twtj7WI22l-VLlYMs9UQJvgzio4
Message-ID: <CACaw+ewuPm-eOACKX3Ux0UwJBRSftoBm7H+rxE2Z9E7KzWb5ew@mail.gmail.com>
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command timeout
To: Michal Pecio <michal.pecio@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello IOMMU mailing list,

On Wed, Jun 10, 2026 at 12:32=E2=80=AFPM Desnes Nunes <desnesn@redhat.com> =
wrote:
>
> I have just found out the solution for the bug.
>
...
> In scalable mode, a PCI bus may populate only the upper root half
> (UCTP) when all devices on that bus have devfn >=3D 0x80. On bus 0x80, I
> have e1000e at 80:1f.6 (devfn 0xfe) and xHCI at 80:14.0 (devfn 0xa0),
> so the hardware root entry correctly has lo=3D0 and hi=3DUCTP present.
>
> However, after copy_translation_tables(), I noticed that root[128].hi
> was zeroed-out (Present bit cleared) and another (expected) different
> value on root[128].lo.
>
> In short, the culprit here is having a zeroed LCTP, since at
> copy_context_table() the allocation of new_ce for LCTP context entries
> currently governs the pos variable; which is later used to save new_ce
> entries for UCTP at tbl[tbl + pos].
> On the first iteration idx will be zero, old_ce_phys will be empty,
> thus this moves the loop straight to devfn=3D0x80. At devfn 0x80, idx
> wraps to 0 again ( (devfn * 2) mod 256), but since no new_ce was
> previouly allocated for LCTP context entries, pos will remain zero
> while copying UCTP context entries.  After all upper context entries
> are saved, tbl will receive new_ce from UCTP at tbl[tbl_idx + 0], and
> not tbl[tbl_idx + 1]. These will be later written in
> copy_translation_tables() to iommu->root_entry[bus].lo and
> iommu->root_entry[bus].hi, which causes the bug.
>
> In summary, the hardware tables were correct, but the copy path
> misplaced the UCTP table for bus 0x80 when dealing with a LCTP
> zeroed-out during kdump.
>
> To fix this, I created a v3 patch that uses devfn to better track
> which half we are copying, so UCTP-only buses (lo=3D0, hi=3DP) are
> installed into the upper root half.

0001-iommu-vt-d-Fix-UCTP-context-table-slot-when-copying-.rfc.patch

> I am doing some final tests now, but since this was a lot to digest,
> comments at this stage will be most appreciated.

FYI, all of my last tests looked OK.

> To IOMMU maintainers: should I send this patch to the iommu mailing
> list and move the discussion there?

I meant as a new submission to IOMMU maling list, since this started
in xHCI at the usb mailing list.
Of course, that is if nobody has any comments or objections to the patch.

Best Regards,

Desnes

