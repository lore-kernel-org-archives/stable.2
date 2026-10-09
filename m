Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7535849DB99
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538520; cv=none; b=bHsVPUmLvg15962a+llUaxEwrTwFt/3LZFOFVctKjaY1yGMt8gP84g3Wp31b/QgcAyXHcJhNvVmfUOAIOknJLkhrgnwyOk14W7rhgiGkPxpugNm/ph+A3g29s8Jxf6hdnIuvpY1BEpxmdjm8QZADLh/RZRF6799C8Rasm3HXaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538520; c=relaxed/simple;
	bh=/c8N48QbtXgR/eVlCX4e1X5WhhCM4Hemay3LC9ggKPk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRiE8P9NZR80i188JWnwwASTfrrGsNXuWMCZ7f2Ir3ueRJtVHgaaowaye0Bb6io634FbRVi6WAMOVj5N2qvZjVNXxpc1Q3ONHIvW2VsdrrBMyGO5yww0OKzSF8pQGaqQDYISzdWBadca8HbrDdUn89aNQSkq3HZ4Iv+ApFzpUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IGkscjq0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IGkscjq0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so33385665e9.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791538510; x=1792143310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oJvujCG6Ef+ooO87W/Kfsk5ax+KDA0Y6he4rHd/9/6A=;
        b=IGkscjq05/VuTlEGylZ0tPumx/YjRJcVe+CMB584AsxZF7ioC1ojWkI+S9bDCmadGN
         3oHbrjxTnv7iiCyYtEoFv36uKFDLWC5Ks+aHaqgwKE7NMq8aNdlbkW7I9PVjdKAcJCO5
         ReK9hv9QVku9rm58f0EwKFMEbK8X2oAlDHPNkPF7vRDBmeGt6Zbh7J+XfO2eckYsPNaB
         9T8meJ1AHhfiYFU9krpj0FKQc14PKjPzu/LQZXmx4wEKBLh2H8DULILBuDmwiiqN1l7A
         Mty11O2KjiKdmio2QApQxZXaEabmYonTxMpNUx26my94LdaMV9AgwUYFMn3gZNcerf/O
         WdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791538510; x=1792143310;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJvujCG6Ef+ooO87W/Kfsk5ax+KDA0Y6he4rHd/9/6A=;
        b=MAFWkxWyVsbIrQiNhGg9kWoH7dULSD7JNgL0QWtJAlBc/D4Qm5WuSvu1shf9hWSGN8
         Obzv7PR/hh+5JIQykVpqy0AtI8M219458h9ISy4LdPQJYRsglXuHKxclZhdn3gLpJpDD
         raCDY/qg9vkd52e4OtOhk/WTfcPyrSnb0P+WzlMgiXAaUd73WEbVNct4EMjGA4a6tDkN
         IvbaDX9GQorxJDp/Y6tN/Ob6RO0s41ZZ12aYEXmOwFINR2mhqltguPZ602LPfvBqzPfU
         hPEoVZbPu5kFZzDR+NyKpzQD+1Wx50hCx1WSNSoIWdlkuu1JX/hiiP+vG7ywI7pvOt+n
         nGGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSS1UPoTVqUbxCZFcjzpkgNOx8cEW7+B1INZLF1ZA5o+bZDFQhGEqFq8hMz5gEOK9hNn1tj7g=@vger.kernel.org
X-Gm-Message-State: AFuF++nTySntV0koVUssa89P7guN0a1Ydmmz27+zIObVOtjw0M1rwwEO
	AgDFZJxhsGl0U/8ljz/43Qlle/8nXf8FEKL1JTW5cc8QPIMhNa5PUrhwEsXxR+i9XMY=
X-Gm-Gg: AYBFou2FghBJU0z2oQggEvW+g4VPTRSWUigHsrz3uswPofLCrtlDgu1X7AnwwnYIVCA
	A0NdmPfjhmDEbX++M8Mm19+0Uc4VsSUH71OrUJdMBR80NKQI+ghc2X/KDLjKh/zA0d4tqh5eRWq
	8xsB182H/tL2eqQuNVtv2PiAWUDZ7HTn2m59k5vfhP4oxxRWzua8LPfJEJtBkWtxgp4bJbEqkFc
	g1pVdB94Qeyfink3UVAP0dvRyG/qA52FsRYxU/n7EzexAIeJKdUltbIz50wEYQIE+Ho9xwHTqy+
	si3qED//d4OtCxSh9YqOQBZLuzYRyYVN8fWftmh0k3Wu4dVrHcPdy3Z3jPl5GpgBWW0ea/3oouH
	9kWbgYWRIBhm6yuDkj9zJmBepbG9i7Lkm/ClZZwdCiL8J/X59U8JJ11bUBm39ZR33pzOb74I5fA
	ji/hj1YiSFbx6qfhomBBkxEd6L2c7t9ruYiTezZsuxuAvMIU1NyOWSE38=
X-Received: by 2002:a05:600c:4f10:b0:4a0:d1f4:b1d1 with SMTP id 5b1f17b1804b1-4a18e4bff89mr26548565e9.24.1791538510535;
        Fri, 09 Oct 2026 02:35:10 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:2696::3d8:4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea1021sm43339765e9.10.2026.10.09.02.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:35:10 -0700 (PDT)
From: Matt Fleming <mfleming@cloudflare.com>
X-Google-Original-From: Matt Fleming <matt@readmodwrite.com>
Date: Fri, 9 Oct 2026 10:35:09 +0100
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>, Baoquan He <bhe@redhat.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 0/2] iommu/amd: Fix device table setup in kdump kernels
Message-ID: <asi0gnLD2v2Ir5bX@matt-Precision-5490>
References: <20261002133143.3628181-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002133143.3628181-1-matt@readmodwrite.com>

On Fri, Oct 02, 2026 at 02:31:41PM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> An AMD kdump kernel booted with crashkernel=512M,high and
> crashkernel=0,low fails to allocate its device table because there's no
> memory below 4G. IOMMU init fails and, on our systems with an Intel
> E810 NIC, the ice driver's TX queues time out, so the dump never gets
> sent.
> 
> Since commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump"), a
> kdump kernel normally reuses the previous kernel's table. Patch 1
> programs the new table if reuse fails. Patch 2 drops GFP_DMA32 for
> kdump kernels. Normal kernels still allocate below 4G, because that's
> what the kdump kernel checks before reusing the table.
> 
> On an AMD EPYC system with an E810 NIC, the kdump kernel without these
> patches failed the order-9 GFP_DMA32 allocation and its TX queues timed
> out. With these patches, the kdump kernel reused the old device table
> and the dump was written over the network.
> 
> Matt Fleming (2):
>   iommu/amd: Program device table when kdump reuse fails
>   iommu/amd: Don't allocate kdump device table from DMA32
> 
>  drivers/iommu/amd/init.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)

Hey Joerg, 

I know it was Plumbers and ksummit this week, but have you had chance
to look at these two patches?

Thanks,
Matt
