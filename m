Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF4199FAB
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063093; cv=pass; b=SFR19LUZnF/x4KhSBndE0zgX/6AGrWiFXYCzno/641DBd8eBNtPM76KWp1lAQz4n6fHjmVvXE2XXQIAdFjSi6DGBvauTYecUOdk8KV8wrYK0cMUwJv6eyH6Co8me6Jf5YxvqTOq/NhV/vZJY3M5xkm8mqD3mBZp1oFKDDZSWyJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063093; c=relaxed/simple;
	bh=MRJZIG7PpGC8GI3G9OdkHZpvyVmLP1ZrEzMgLyM7g80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caeB/qJ3GsbjupPJaxCquWy48lgRpLwjlieSEHGeWtB8f7axzH9bG7Z0L4XiHB+DER1QbFovonnnuzeuPYYTe4poA1vrO4kQwaubCJr0+IGcUOWe4VPhGCrHU5ZAom29D8WzLaSTk6b1YTbpIDF+T4XPbAR3ANr6PNl2fpyyJKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DCk7ssiu; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DCk7ssiu"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c01c79467so111931cf.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 17:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786063090; cv=none;
        d=google.com; s=arc-20260327;
        b=Q+PLRvJdhhXbkQn1pat9Wl3H0zyMyCnQlsBkKfYgfnnJidqOuzlou8ww1tc8j/mI81
         xsff99fKZZqkFUCxCPoPsnnuRyUTNn8WNgxLRlfbrMxtiARH0oZTG9vcPBRBskrqQdMn
         bgHkvRPhiszs48ZmnSdw19YHVCC6CEtYG+dN13PUcdRqRjX6/5SjS2084TbfDDhPYYzA
         rBX/NOoIP8RRLAalYWelYhx4ixU88oGIdJimSJordI1T+FTPZk6K8vOCzbzNpeTS4xZ/
         YjSoDBdyQQ7EgqIlgPE6atpd74MH95R0bn7F9cQDPKhNazyTAt9c6KQD2dUpeYpC+mod
         DonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MRJZIG7PpGC8GI3G9OdkHZpvyVmLP1ZrEzMgLyM7g80=;
        fh=OPXWjyHeXho7UIEBoloU683oznadYwpjKl33/cPT62I=;
        b=GfcYnBnLc4fcjcLlG/FvF8hPIRyP4OLdv1KKCNT07XjqnGoBN7At/JmwevcOoLn2EA
         srKd5gr+Fvu0INImNw0Qf6epahhigDkQkhUhImwGDeo4TpqakryZ1d3r5oMJlnW+IsAM
         UEjdUQSzsVU8xAwSr5q6Pt73mJpoW9mce6Ot5Fx45hMOGOmXoBNyWAiqW7iAnLoSp6lq
         y/Xf7xdWB4/J+vNhvQiZLfwtrLwKPvVu21XhNDwdA+WlYJsgjVh4tYKJcaozqRZfMMHu
         7omCVnvvtcYGAWqhzmW+ce3i+PJCtYx5OMC591GIksxcBMl5mFvVfdWqJeTraPi5OLAT
         BSkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786063090; x=1786667890; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRJZIG7PpGC8GI3G9OdkHZpvyVmLP1ZrEzMgLyM7g80=;
        b=DCk7ssiucwy1txMNEG9jcXv2x8Sc1k7Nmpv1dwJNy5Jn39IxmatXIHtMqLi5EDq5S5
         0j7wECjmkIJnDlc9JWJBCBZIPxtW0cT34K+b02+3UPP7PhtJu9vrHSlMoft478HWpTr+
         tjzh1pwKWnKwgnfa50FOEk1t7u+Du0Y+Co277MXquZ6boOXvr4Q1poYOLyHM+zZYS9tH
         cfJ/4/F1pXFdgfExgKF0PgvJs50qlzPO0+1+UGJFRuvbEnOFcd887yfGX0jIa4C8zfqN
         QXQB99xIXMNkKguXXuuknbtEJMIYGAUqi8u8uWAOjcwpEBoNw91ESYyvQHD1Ien8hHX6
         az8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786063090; x=1786667890;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MRJZIG7PpGC8GI3G9OdkHZpvyVmLP1ZrEzMgLyM7g80=;
        b=hNHDYmAsJXcIqPGpf4oHaYkcHVgvSlDQL4d9o9JAoUBqQUTAYm3wVR4PKN6uSsvr7W
         F4HhCRzwnibDij8LWANqP3D+xYKccPR9zZudUAv5yllG9/V28idFj7BITC14oPmOCpG3
         bY0xJVQVCE0vYr+31Ef9dY383jr0lbXxU6Q+C0iWVo7eVgvKWhRiokAqa8OXrJ+JE9GK
         GGgEQdYH4zu5/LWUru9+xGfBaYzB3lcA4yeKrF0IAptR3WJ0OcdUBgadajbO6azDifVT
         KFLbSSf18+7AOwrBSOmiDgSY5gx8goPqc3ZL4KXwEDZBDEJ2BXoiZ6WsnuyD6Z7qaAsI
         UKuw==
X-Forwarded-Encrypted: i=1; AHgh+RqToKfxVbAfXDrJcyBy7dCL6HM4Yvwwlofz0e2HUL/VsK9a8OrfdJAPSeeCCckS4CU0otgnDRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtANh18s5slUT14fRcCJQMSDvvww9uBkht54LNkFKNqgSbpcPA
	aBhO0ES6rnTQnRtCXuHP92YZjtrgxfKU9Vrq1ckPNGmiWx3xmMJj2XhcIiwgNi6DeXpiXe6p02Z
	jcKcFkEfXFsC7fg6RE0Rg0kHBmpPBkcBlzn01sEJ62+HDkWBUyck4wZPlKoOVAQ==
X-Gm-Gg: AR+sD12kGlZV88/2221NdTVS929W8Wfu1nKo/DN0+2q3HW1MIzohp8Y25Tjxi+RZm+L
	T+f0+Vfk17wpEoR3Kz8LLeYBNxpPlq/k5AAyCnOhNcgkZVfp/JVetsdoB17nB4fcPhQ1gbv7wx8
	Y5xKwm/59ZBPO1U0FLki6GqATeIlAI3O8c3EgyVuwywFj6lbDsbk2OSDimnSotRimSz6OO72sDN
	3VssS+sb9NKR6wav7R2I/N3Z2v/y6sDoZ8zdX6oTkEHI5gugzNWzLMKn8n5zSRa89/+efVf1U/H
	ZsOcNJSxhEVh9B+mhXOK7j2VWvEEK5Z1rprbN2IUftiP5uhRFZCdOpQOiT26Rr84m7oiIbonrHL
	NLaRs94+uZl4=
X-Received: by 2002:ac8:5893:0:b0:51c:104c:100c with SMTP id
 d75a77b69052e-52d106def12mr7006611cf.2.1786063089410; Thu, 06 Aug 2026
 17:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724014605.3377283-1-linkl@google.com> <20260806185414-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260806185414-mutt-send-email-mst@kernel.org>
From: Link Lin <linkl@google.com>
Date: Thu, 6 Aug 2026 17:37:56 -0700
X-Gm-Features: AUfX_mzsCL5eLjoVeX8KOZ2z_HBCF8ziBwe-qf9RCI-8JSE_RZaQA3PJ8CCVsKw
Message-ID: <CALUx4KSGtvswSARWZ9L8rbWsPmSorHaonaSWMT5UvQX9SQSqFA@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio_balloon: add VIRTIO_BALLOON_F_REPORTING_PM_SAFE
 feature bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Cory Maccarrone <maccarro@google.com>, 
	Taylor Scanlon <tayy@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 6, 2026 at 4:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This makes no sense to me. So there's a bug in the guest and it crashes.
> Patch the guest.
>
> There's just no chance we'll add flags every time some guest drivers
> on some OSes have a UAF.
>
> What makes this specific bug special?
>
> Trust me when I say UAF issues e.g. around hotplug are a dime a dozen.
> Now what, let's add another one around hotplug? And so on.

Hi Michael,

Thanks for the candid feedback. I completely agree that adding feature
bits to the virtio specification to paper over guest OS bugs sets a bad
precedent, and we will drop this RFC.

To answer your question on why this felt special from our side: in public
cloud fleets with unmanaged customer images (BYOS), we cannot patch the
guest kernel. If the hypervisor turns on VIRTIO_BALLOON_F_REPORTING globally
for memory reclamation, unpatched guest kernels negotiate it blindly and
subsequently crash upon PM suspend. That makes a host-side feature rollout
act as a latent crash trigger for older guests.

We understand your point that the spec is not the place for driver bug
workarounds. We will handle this compatibility gating out-of-band in the
hypervisor / management layer instead.

Thanks for your time and review.

Sincerely,
Link
