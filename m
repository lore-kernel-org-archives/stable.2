Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380412F8E93
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105547; cv=pass; b=cuKBIFEVdj4QnZMzibnGLPmKswFzRNTqo5r64XU+lCmhQ90PrLBf+W7/AnbPL8SrlKGInRh2tBeCBvXYvyohlxyVDT4MuP5aEoADQDQxYn50/YTHYA6oVpmQfLRYuPIr+PAkKU0ZeVBB0gwFaRo9ABFZMc5F+9I9SyRNnE08aBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105547; c=relaxed/simple;
	bh=FpXjpqJtbrwOLqBrqsKJuNXTJaSjpkAQDUa5P+dSgg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2pbgOh/oyy1XB8Jnw8qMZHBpQXKom3npajAzuI/KKy3Pkiya3VHRQ1ZVQMlS6Q9STcC8kBg6RYXmJndnyfSJf7CmjpRTrCaJ5B/VOXDFYH1Kgt1QU6lg/WPrYyy0whWQ8LtKFSzuocfWdj6MX36DNgj+74/8iDbWZzOagYyLCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHQ3xP3Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=paKp0qNb; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHQ3xP3Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="paKp0qNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781105545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qchl8yrNd0XyopghXMG0e590T2BZ39ReB9Ysnhbemno=;
	b=JHQ3xP3YY4CH2PqIkQr7q1y9SwGHPnSB4x5ZPKKovVOD9utdtPqDbsALae0vn0MlatZK/f
	96Fra6npXyv5xD1awx+dVS+XLROUyKUNfH+ilMMWZzupNDWZGvSGggPn0p7dPg5vXEtki/
	1qLJh+/zmEN1LSinnfd+2FDp96VD6+Q=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-mZw3WVFePj-3rGjhrKJHiQ-1; Wed, 10 Jun 2026 11:32:23 -0400
X-MC-Unique: mZw3WVFePj-3rGjhrKJHiQ-1
X-Mimecast-MFC-AGG-ID: mZw3WVFePj-3rGjhrKJHiQ_1781105543
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6db540d17so12684756a34.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 08:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781105543; cv=none;
        d=google.com; s=arc-20240605;
        b=eIzL4D6sMllMjcQpXfYsog7YSX/fM9WOE9VdAEN9IVagJmqVxPDzp/vJ2XojUMQUtC
         nggeZzYZSpYFbQ9ZVxb+b/RK4xMPMRY6MAK9IZfm5qdq3u6XsvQ0ZMi7tEzsR6O0Hsau
         vc1vzjklwv0Fkrz7Ywd3wj2bJ8oiq+kHZaZXIe2D0A9eeJWze90HIPDTKA107cGyHZfO
         VNmnZMYN5rGZtn8J1mYFaN7VwYIkjlUznEhbAYA8zoc7oalT6GCKRRJSvBQ3TqWZTz48
         OJQUuJW7ZhCp4PcTReyrI6wuSEj/aiSoGzmgRIxvQ8mFNtA7UdmBhhNPSIhAfCFQ2XSL
         g0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qchl8yrNd0XyopghXMG0e590T2BZ39ReB9Ysnhbemno=;
        fh=x3e9LGL7fpfZ2iNhbk8gfwLB6+yh6EnjBNnLb7B5rfc=;
        b=gCKFYSEAy+bo2l+z/3AEL422thNhW9LMC0c51rvpLGQa9CY3rIkV1VU6s/0Ixviu3o
         zWKZAHYNSaFKyIhGm1jcU0LsM2nz+nxnpTz8q0HOtT20OF2qvxwjCI6zIqINtcLbXuOi
         mKfZXyQWm1hYGJjS8+do1xCkxE/wLoLUFUIV+5rT8e0jc1hpyAvAHIxOmXRQvyp78/9F
         qB6PK+fA8XWRIGWA9LuUQl7QDcSQ8JE5ghyB1ffjmAC8JMq31yA8ccsHX75hOoa1Zqp/
         AvqS5ztWnUMQ7Uhd9Naa1r0sr2DjZ/B9IRDmzlUB2i7pDxmhkaW4FFBdhR9yNP4qOYAS
         /7Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781105543; x=1781710343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qchl8yrNd0XyopghXMG0e590T2BZ39ReB9Ysnhbemno=;
        b=paKp0qNb0Sq613XTzizcGvSgmd1BPhge49i9gyGSx+aBrR6fTchs22BaveA7OaPCnv
         /xMy2CBs+t4c4RAqxftujJfoZJGE7wunR/mSWLy09mBhpntOq8zz5FC+gTB5FSYb8NME
         Pbw8Z22p4VAZdqUdQiDxpvuhvIDFU1pxpQ5KC8a2FruV7mWqZxr88ygQ0p1JCiz4XPsU
         h44c689krhsinmsU4V8Q+N57Y6HuK1/QfVWhxE8ty5ffoMo5U3HYdfX5ifzj0abH3QmM
         lHSNbWa0BxM/pYd9V1d0ljoBBFn07l7vp3S1ScK7LfrFbjalXV6iSn6/qd7QwJdYfdPC
         KppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105543; x=1781710343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qchl8yrNd0XyopghXMG0e590T2BZ39ReB9Ysnhbemno=;
        b=fcxBovF+Qq1S4UmwLolaXur8+xA4nB19BoqLp7fMEWO1XS8dx0xQr5CnHnwq/bMoPP
         xzJ45r9QQZ/25d6J+pDqACoWlCRXtY6FcFQhGje20jO+Gwo4L2m2uy3NsiHMm6V48UQc
         uQezPAK7q1TiQmDhucCmqacO+LrrObGrmQgtTguuzPiIwaaHLwe0FNFCqEkNc1kdQwVW
         RcdlrCp/Wu6qQ53gajISBpcS+L/4Ck+j65IKSHgquF216QMYUojVPaDwgnIwXOxaAK5B
         m+wy/yrow7SB0qqXMNwu/ldD1/kCcZgqUTmJ6XInltE1SAp1Iy+WoIOgDOSWn3Ukl5hM
         Ja9A==
X-Forwarded-Encrypted: i=1; AFNElJ+zdovh/C+nshhrtbV4juz3PV/Usf5YS2scvw4lNI7/QoPvW8IqJODxFWPBKEOzyd/tMbJWXRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEkk1QbLFosFtPL8UPBUNVRSoP7HX08MWG5LnFdOu4qfq2cxGj
	EvHvvG6EvfZVoRAsWOhoLh5DZ94wjOWesYKKuwpgAcH+41qTHA98tky5L/hJwI+VJWSm6GRCckz
	UKjJVxa+u5CWQy9xCNvWQ/BAd3yF5alFkCrIsQavSPzosV0fDN5L9722iryLBPDde+ivcWv51Z9
	06NmvIxQVQOm4QcyCCgZkqXx4AezNjby1imlLLNSBZHMs=
X-Gm-Gg: Acq92OGgkZ2dQGRdDuIQcRR1kW8atiV/tIX0z/1jVIaFSW3wKZnBgD4FgadTnXYbcv6
	CgGXoDVxAyt1YgfmS4sHvKwH6oxRRt34OrBmcIorWafbSAvvl2A2a2aSZK2PLVTnioIFuFdn5ln
	OWZEIiSsbeIsRz8bpI6kitejnizYKtSK+LylUToVRLV8l8wKTraG3sfGPPw/0KWGJFdBeSTgnNk
	sT235htORSDAlFV0DqJL+DRpGXDDn4a+SNFcifXQOYDCh7+
X-Received: by 2002:a05:6830:6a12:b0:7d9:ad90:5670 with SMTP id 46e09a7af769-7e70ca1f380mr18051882a34.18.1781105542897;
        Wed, 10 Jun 2026 08:32:22 -0700 (PDT)
X-Received: by 2002:a05:6830:6a12:b0:7d9:ad90:5670 with SMTP id
 46e09a7af769-7e70ca1f380mr18051807a34.18.1781105542352; Wed, 10 Jun 2026
 08:32:22 -0700 (PDT)
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
 <20260527103221.7f8b15b0.michal.pecio@gmail.com>
In-Reply-To: <20260527103221.7f8b15b0.michal.pecio@gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Wed, 10 Jun 2026 12:32:10 -0300
X-Gm-Features: AVVi8CcIFi48Gmh5pfw5m58cLkGGSeSLlDC5xzLbT6Lf4kshTJp6FIvjDpssJCQ
Message-ID: <CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXaFbd=ySXf8E5A@mail.gmail.com>
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command timeout
To: Michal Pecio <michal.pecio@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000002947e10653e7f36d"

--0000000000002947e10653e7f36d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Michal and IOMMU maintainers,

On Wed, May 27, 2026 at 5:32=E2=80=AFAM Michal Pecio <michal.pecio@gmail.co=
m> wrote:
> Adding Intel IOMMU people.

And thanks a lot for all the help getting this bug at this stage Michal.

I have just found out the solution for the bug.

It has been a while, but it happens that I had to dig deep down into
the iommu root and context entries after my last message.

> Context:
>
> Desnes reported xHCI issues duing crash kernel boot after SysRq
> triggered panic. Turns out, the chip gets an IOMMU fault, some other
> devices also do. Faulting address is a successful dma_alloc_coherent()
> allocation in xhci_alloc_erst(), no evidence that it's freed before
> the fault occurs. No problems during normal boot.

Recap:
After I triggered the panic, the system collects a vmcore smootly, but
does not reboot afterwards.

The crashkernel was not completing a TRB_ENABLE_SLOT command in
xhci_alloc_dev() in xhci.c, which made xhci hold the xhci->lock and
block a systemd kworker that was also waiting for that lock on
device_shutdown().
Basing myself on past code, I created a first patch that aborted the
TRB_ENABLE_SLOT command with wait_for_completion_timeout() and killed
the HC - this released the lock and enabled the kworker to finish.
However, after a few messages and test patches with Michal, we weren't
totaly sure if this was good solution, mostly because we noticed that
HSE was already set way before ever reaching that TRB_ENABLE_SLOT
command.

Iommu:
At that moment, I noticed that dmar faults were happening to the
e1000e and xhci drivers that shared the same bus. Michal noticed that
the faulting address was a successful dma_alloc_coherent() allocation
in xhci_alloc_erst(). This stated to point to an IOMMU bug.

Afterwards, I tested booting the crashkernel with `intel_iommu=3Doff`
and confirmed that it rebooted smootly after vmcore was captured, so
the plot tickened even more for an iommu bug.

Diging deaper, I started to suspect that the copy of bus 128's root
entry was being changed to have the Present bit cleared somehow. This
made me write a v2 patch for the bug, now in iommu, which instead of
copying the root-entry table, it disabled translation and allocated a
clean root-entry table immediately if running a kdump kernel: no DMAR
faults and smooth reboot was caried out.

Following this lead, I patched the code to dump the root entries table
using DMAR_RTADDR_REG before calling iommu_alloc_root_entry() (in
init_dmars() at drivers/iommu/intel/iommu.c), while also observing bus
0x80's root entry right at the end of copy_translation_tables():

   [Wed Jun  3 15:40:37 2026] DMAR: dmar1: debug: root[  0]:
lo=3D0x000000018a67f001 (P=3D1 LCTP=3D0x000000018a67f000)
hi=3D0x00000001f855d001 (P=3D1 UCTP=3D0x00000001f855d000)
   [Wed Jun  3 15:40:37 2026] DMAR: dmar1: debug: root[  1]:
lo=3D0x00000001f8562001 (P=3D1 LCTP=3D0x00000001f8562000)
hi=3D0x0000000000000000 (P=3D0 UCTP=3D0x0000000000000000)
   [Wed Jun  3 15:40:37 2026] DMAR: dmar1: debug: root[  2]:
lo=3D0x00000001f8564001 (P=3D1 LCTP=3D0x00000001f8564000)
hi=3D0x0000000000000000 (P=3D0 UCTP=3D0x0000000000000000)
   [Wed Jun  3 15:40:37 2026] DMAR: dmar1: debug: root[  3]:
lo=3D0x00000001f8566001 (P=3D1 LCTP=3D0x00000001f8566000)
hi=3D0x0000000000000000 (P=3D0 UCTP=3D0x0000000000000000)
   [Wed Jun  3 15:40:37 2026] DMAR: dmar1: debug: root[  4]:
lo=3D0x00000001f8569001 (P=3D1 LCTP=3D0x00000001f8569000)
hi=3D0x0000000000000000 (P=3D0 UCTP=3D0x0000000000000000)
   [Wed Jun  3 15:40:37 2026] DMAR: dmar1: debug: root[  5]:
lo=3D0x00000001f856b001 (P=3D1 LCTP=3D0x00000001f856b000)
hi=3D0x0000000000000000 (P=3D0 UCTP=3D0x0000000000000000)
=3D> [Wed Jun  3 15:40:37 2026] DMAR: dmar1: debug: root[128]:
lo=3D0x0000000000000000 (P=3D0 LCTP=3D0x0000000000000000)
hi=3D0x00000001f856d001 (P=3D1 UCTP=3D0x00000001f856d000)
   [Wed Jun  3 15:40:37 2026] DMAR: dmar1: debug: root[129]:
lo=3D0x00000001f8583001 (P=3D1 LCTP=3D0x00000001f8583000)
hi=3D0x0000000000000000 (P=3D0 UCTP=3D0x0000000000000000)
   [Wed Jun  3 15:40:37 2026] DMAR: dmar1: debug: 8 of 256 root entries non=
-zero
   [Wed Jun  3 15:40:37 2026] DMAR: Translation already enabled -
trying to copy translation structures
=3D> [Wed Jun  3 15:40:37 2026] DMAR: dmar1: post-copy root[128]:
lo=3D0xe89cda001 hi=3D0x0
   [Wed Jun  3 15:40:37 2026] DMAR: Copied translation tables from
previous kernel for dma
   ...
   [Wed Jun  3 15:40:37 2026] DMAR: DRHD: handling fault status reg 3
=3D> [Wed Jun  3 15:40:37 2026] DMAR: [DMA Write NO_PASID] Request
device [80:1f.6] fault addr 0x1aba8d000 [fault reason 0x39] SM:
Present bit in Root Entry is clear
   [Wed Jun  3 15:40:37 2026] DMAR: Dump dmar1 table entries for IOVA
0x1aba8d000
=3D> [Wed Jun  3 15:40:37 2026] DMAR: scalable mode root entry: hi
0x0000000000000000, low 0x0000000e89cda001
=3D> [Wed Jun  3 15:40:37 2026] DMAR: context table is not present
   [Wed Jun  3 15:40:37 2026] DMAR: DRHD: handling fault status reg 3
   [Wed Jun  3 15:40:37 2026] DMAR: [DMA Write NO_PASID] Request
device [80:1f.6] fault addr 0x1aba89000 [fault reason 0x39] SM:
Present bit in Root Entry is clear
   [Wed Jun  3 15:40:37 2026] DMAR: Dump dmar1 table entries for IOVA
0x1aba89000
=3D> [Wed Jun  3 15:40:37 2026] DMAR: scalable mode root entry: hi
0x0000000000000000, low 0x0000000e89cda001
=3D> [Wed Jun  3 15:40:37 2026] DMAR: context table is not present
   ...
=3D> [Wed Jun  3 15:40:44 2026] xhci_hcd 0000:80:14.0: alloc ERST at
0x0000000e8a356000
   ...
   [Wed Jun  3 15:40:44 2026] DMAR: DRHD: handling fault status reg 2
=3D> [Wed Jun  3 15:40:44 2026] DMAR: [DMA Read NO_PASID] Request device
[80:14.0] fault addr 0xe8a356000 [fault reason 0x39] SM: Present bit
in Root Entry is clear
   [Wed Jun  3 15:40:44 2026] DMAR: Dump dmar1 table entries for IOVA
0xe8a356000
=3D> [Wed Jun  3 15:40:44 2026] DMAR: scalable mode root entry: hi
0x0000000000000000, low 0x0000000e89cda001
=3D> [Wed Jun  3 15:40:44 2026] DMAR: context table is not present

In scalable mode, a PCI bus may populate only the upper root half
(UCTP) when all devices on that bus have devfn >=3D 0x80. On bus 0x80, I
have e1000e at 80:1f.6 (devfn 0xfe) and xHCI at 80:14.0 (devfn 0xa0),
so the hardware root entry correctly has lo=3D0 and hi=3DUCTP present.

However, after copy_translation_tables(), I noticed that root[128].hi
was zeroed-out (Present bit cleared) and another (expected) different
value on root[128].lo.

In short, the culprit here is having a zeroed LCTP, since at
copy_context_table() the allocation of new_ce for LCTP context entries
currently governs the pos variable; which is later used to save new_ce
entries for UCTP at tbl[tbl + pos].
On the first iteration idx will be zero, old_ce_phys will be empty,
thus this moves the loop straight to devfn=3D0x80. At devfn 0x80, idx
wraps to 0 again ( (devfn * 2) mod 256), but since no new_ce was
previouly allocated for LCTP context entries, pos will remain zero
while copying UCTP context entries.  After all upper context entries
are saved, tbl will receive new_ce from UCTP at tbl[tbl_idx + 0], and
not tbl[tbl_idx + 1]. These will be later written in
copy_translation_tables() to iommu->root_entry[bus].lo and
iommu->root_entry[bus].hi, which causes the bug.

In summary, the hardware tables were correct, but the copy path
misplaced the UCTP table for bus 0x80 when dealing with a LCTP
zeroed-out during kdump.

To fix this, I created a v3 patch that uses devfn to better track
which half we are copying, so UCTP-only buses (lo=3D0, hi=3DP) are
installed into the upper root half.

I am doing some final tests now, but since this was a lot to digest,
comments at this stage will be most appreciated.

To IOMMU maintainers: should I send this patch to the iommu mailing
list and move the discussion there?

Thanks in advance for any help on the matter,

Best Regards,

Desnes

--0000000000002947e10653e7f36d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-iommu-vt-d-Fix-UCTP-context-table-slot-when-copying-.rfc.patch"
Content-Disposition: attachment; 
	filename="0001-iommu-vt-d-Fix-UCTP-context-table-slot-when-copying-.rfc.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mq88524d0>
X-Attachment-Id: f_mq88524d0

RnJvbSA0YjI4M2RlMmMxNTZlMjcwZDE2ZTI5MmFjYjEwODg0ZjQyYzBiZDEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZXNuZXMgTnVuZXMgPGRlc25lc25AcmVkaGF0LmNvbT4KRGF0
ZTogVHVlLCA5IEp1biAyMDI2IDIzOjU3OjA1IC0wMzAwClN1YmplY3Q6IFtQQVRDSCBSRkNdIGlv
bW11L3Z0LWQ6IEZpeCBVQ1RQIGNvbnRleHQgdGFibGUgc2xvdCB3aGVuIGNvcHlpbmcgcm9vdCBl
bnRyaWVzCidDb250ZW50LXR5cGU6IHRleHQvcGxhaW4nCgpXaGVuIHRyYW5zbGF0aW9uIGlzIGFs
cmVhZHkgZW5hYmxlZCBhdCBib290IChlLmcuIGtkdW1wKSwgdGhlIHZ0LWQgZHJpdmVyCmNvcGll
cyBjb250ZXh0IHRhYmxlcyBmcm9tIHRoZSBwcmV2aW91cyBrZXJuZWwncyByb290IHRhYmxlLiBJ
biBzY2FsYWJsZQptb2RlLCBidXNlcyB0aGF0IG9ubHkgcG9wdWxhdGUgdGhlIHVwcGVyIHJvb3Qg
aGFsZiAoVUNUUCwgZGV2Zm4gPj0gMHg4MCkKc2hvdWxkIGJlIHdyaXR0ZW4gdG8gY3R4dF90Ymxz
W3RibF9pZHggKyAxXSB0aHJvdWdoIGNvcHlfY29udGV4dF90YWJsZSgpLgpIb3dldmVyLCB0aGUg
Y3VycmVudCBjb3B5IHBhdGggYWx3YXlzIHVzZXMgdGJsW3RibF9pZHggKyAwXSBpbiB0aGlzIHNp
dHVhLQp0aW9uLiBTaW5jZSBpZHggd3JhcHMgdG8gMCBhdCBkZXZmbiAweDgwIGR1ZSB0byBhIHpl
cm9lZCBMQ1RQLCBuZXdfY2UgZm9yCkxDVFAgd2lsbCBiZSBOVUxMIGFuZCBrZWVwIHBvcyBlcXVh
bHMgdG8gMC4gVGh1cywgVUNUUCBlbnRyaWVzIHdpbGwgYmUgY28tCnBpZWQgaW50byB0YmxbdGJs
X2lkeCArIDBdIGluc3RlYWQgb2YgdGJsW3RibF9pZHggKyAxXSwgYW5kIHdyaXR0ZW4gYWZ0ZXIt
CndhcmRzIHRvIHJvb3RfZW50cnlbYnVzXS5sbyBpbnN0ZWFkIG9mIC5oaSBpbiBjb3B5X3RyYW5z
bGF0aW9uX3RhYmxlcygpLgoKQXMgY29uc2VxdWVuY2UsIGRldmljZXMgb24gYnVzIDB4ODAgd2l0
aCBkZXZmbiA+PSAweDgwIGZhaWwgRE1BIHdpdGgKZmF1bHQgMHgzOSwgd2hpY2ggYnJlYWtzIGRy
aXZlcnMgcnVubmluZyBpbiBrZXJuZWxzIHdpdGggdHJhbnNsYXRpb24KcHJlLWVuYWJsZWQuIFRo
aXMgZml4ZXMgTk9fUEFTSUQgRE1BUiBmYXVsdHMgZm9yIFVDVFAtb25seSBidXNlcyBzdWNoIGFz
OgoKRE1BUjogW0RNQSBSZWFkIE5PX1BBU0lEXSBSZXF1ZXN0IGRldmljZSBbODA6MTQuMF0gZmF1
bHQgYWRkciAweGU4MTc1OTAwMCBbZmF1bHQgcmVhc29uIDB4MzldIFNNOiBQcmVzZW50IGJpdCBp
biBSb290IEVudHJ5IGlzIGNsZWFyCgpGaXhlczogMDkxZDQyZTQzZDIxICgiaW9tbXUvdnQtZDog
Q29weSB0cmFuc2xhdGlvbiB0YWJsZXMgZnJvbSBvbGQga2VybmVsIikKU2lnbmVkLW9mZi1ieTog
RGVzbmVzIE51bmVzIDxkZXNuZXNuQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5jIHwgMTAgKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11
LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKaW5kZXggNGQwZTY1YmMxMzFkLi43Mzc5
MzZmOTQyYTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYworKysgYi9k
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKQEAgLTE0NDMsNyArMTQ0Myw3IEBAIHN0YXRpYyBp
bnQgY29weV9jb250ZXh0X3RhYmxlKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUsCiAJCQkgICAg
ICBzdHJ1Y3QgY29udGV4dF9lbnRyeSAqKnRibCwKIAkJCSAgICAgIGludCBidXMsIGJvb2wgZXh0
KQogewotCWludCB0YmxfaWR4LCBwb3MgPSAwLCBpZHgsIGRldmZuLCByZXQgPSAwLCBkaWQ7CisJ
aW50IHRibF9pZHgsIHRibF9zbG90ID0gMCwgaWR4LCBkZXZmbiwgcmV0ID0gMCwgZGlkOwogCXN0
cnVjdCBjb250ZXh0X2VudHJ5ICpuZXdfY2UgPSBOVUxMLCBjZTsKIAlzdHJ1Y3QgY29udGV4dF9l
bnRyeSAqb2xkX2NlID0gTlVMTDsKIAlzdHJ1Y3Qgcm9vdF9lbnRyeSByZTsKQEAgLTE0NTksMTAg
KzE0NTksOSBAQCBzdGF0aWMgaW50IGNvcHlfY29udGV4dF90YWJsZShzdHJ1Y3QgaW50ZWxfaW9t
bXUgKmlvbW11LAogCQlpZiAoaWR4ID09IDApIHsKIAkJCS8qIEZpcnN0IHNhdmUgd2hhdCB3ZSBt
YXkgaGF2ZSBhbmQgY2xlYW4gdXAgKi8KIAkJCWlmIChuZXdfY2UpIHsKLQkJCQl0YmxbdGJsX2lk
eF0gPSBuZXdfY2U7CisJCQkJdGJsW3RibF9pZHggKyB0Ymxfc2xvdF0gPSBuZXdfY2U7CiAJCQkJ
X19pb21tdV9mbHVzaF9jYWNoZShpb21tdSwgbmV3X2NlLAogCQkJCQkJICAgIFZURF9QQUdFX1NJ
WkUpOwotCQkJCXBvcyA9IDE7CiAJCQl9CiAKIAkJCWlmIChvbGRfY2UpCkBAIC0xNDg0LDYgKzE0
ODMsOSBAQCBzdGF0aWMgaW50IGNvcHlfY29udGV4dF90YWJsZShzdHJ1Y3QgaW50ZWxfaW9tbXUg
KmlvbW11LAogCQkJCX0KIAkJCX0KIAorCQkJLyogVHJhY2sgaWYgc2F2aW5nIFVDVFAgb3IgTENU
UCBlbnRyaWVzIGluIHNjYWxhYmxlIG1vZGUgKi8KKwkJCXRibF9zbG90ID0gZXh0ICYmIGRldmZu
ID49IDB4ODAgPyAxIDogMDsKKwogCQkJcmV0ID0gLUVOT01FTTsKIAkJCW9sZF9jZSA9IG1lbXJl
bWFwKG9sZF9jZV9waHlzLCBQQUdFX1NJWkUsCiAJCQkJCU1FTVJFTUFQX1dCKTsKQEAgLTE1MTIs
NyArMTUxNCw3IEBAIHN0YXRpYyBpbnQgY29weV9jb250ZXh0X3RhYmxlKHN0cnVjdCBpbnRlbF9p
b21tdSAqaW9tbXUsCiAJCW5ld19jZVtpZHhdID0gY2U7CiAJfQogCi0JdGJsW3RibF9pZHggKyBw
b3NdID0gbmV3X2NlOworCXRibFt0YmxfaWR4ICsgdGJsX3Nsb3RdID0gbmV3X2NlOwogCiAJX19p
b21tdV9mbHVzaF9jYWNoZShpb21tdSwgbmV3X2NlLCBWVERfUEFHRV9TSVpFKTsKIAotLSAKMi41
NC4wCgo=
--0000000000002947e10653e7f36d--

