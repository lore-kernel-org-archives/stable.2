Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8935F5F8
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935614; cv=none; b=Z4/6YAIkrCOrLfJ1FZ0EJ+3RstyI3Ksb03XCMw+9dIOo+NaO+AQYse1zCvK9CsgxT/iy4gRqSIAgsW18hCwIfBJNpVngmxa5p6JEs8wEzBI2WFB0/hd+M9/WtJAgXb0cxtlOhAzipxfWh5yitGAR1Pfdpg2u1799ADw9JDcSCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935614; c=relaxed/simple;
	bh=K/goC4AJrkO5X5CWpHMZBHdgUtrswgL/G2WnogRSeq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPTE7JNWChnIiX35C+8GQWgli3IZu2nrr5P364htIIBZrdhKkK2P8WqcDgf29niYsNBgj3D7lLkdgpz8WhF0gsrxJpuvxlNUM8nnVFM24+na6qfx+QSMw3NpJR5zqwVeA0zWlwd0t3iTkereilYVsUShZwkx54LkUS0DIZM2veU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=baqgU5RU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="baqgU5RU"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d58efc7356so12431125ad.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1787935613; x=1788540413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pBVClgdpKmfnkM4Cu3SaLQRKw2oS/EQYOdlTnpUMlbs=;
        b=baqgU5RUiLtxq3hbdjqp2LgIz0O8nwGxEMvno6sXlMZ8s8q51wBUF5BbJLNNtQjOqT
         xZhEa2eU0SAZDhnotU/1tjvxrHQ+ftK9/puNh/SEQdfOKkTdlSxEvjoi7urQHAFbVdYF
         +pSTyCYUAsn8ihnQzIbPUHiR4r+5Ko3s0+3ljAaJpfjoQ4J4iWA4Vb1kSwyxJFJWN5wU
         /8fxVq4Coc5aat2Od0aT2g5/PXvD+QeZ5+9039GQeqltupHRhCIj5/4T7F7z9egmFdro
         aYf7GIWyczwefLl+nYlscEPt7MNWrTiAMEhepO5yzgVGcSMGKqdaSIDyY0VAWbsIuj4t
         pHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787935613; x=1788540413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pBVClgdpKmfnkM4Cu3SaLQRKw2oS/EQYOdlTnpUMlbs=;
        b=GVqhKFfUiuGHIiJuETvs/7RYbk+0f9w9w0Aui+YvPHIkkj6awPgWZ4UAcDMc9/gMbf
         4cPWdanAkh4Ta1m6hdx1MHSLRl+61jzUB+gpAq70yuLX4Acj1CddWNsZ1tvWceH/+zQv
         jTqM96su3poOVxBhWTzeH5WWd+EHGbYVdH60OUwc4Ztx2VE5Nt8KjKraxrpIZJp7GDwg
         spi75AgwdaFs1GyRWRe+dT4MyFY8TjFk6voOWk3nqI+XIPV02awfxo8qmsE3pQ2Rz9Ix
         bLYhfHxfv1DduUIfDaLLNZbiIuhr3ka0+Vs32v/5Nh42nUdGB58KSgPThwRSX99tgo8u
         wC5w==
X-Forwarded-Encrypted: i=1; AHgh+RolU7Q2Gx7AbwRSkLyH3ta2hkg9lHw37gIJUAam+x3sEnntZFfErjNV2ASAx92RhIf6oqroBpM=@vger.kernel.org
X-Gm-Message-State: AFuF++kb9TBJ4Esrn6M8LQf0SBOf64A/jAifQAl7noRm/0Lqe1DDQDsl
	aTbaNKF5k9ktduqj8B8zZPSxe9ogJ6nHAvEnFbPf3MWENLRG7S2FZ8sJFuCFxT5NUMQ=
X-Gm-Gg: AR+sD13WRLiEKA4GQr6sWfqXkWor/V7YbcicMpXKWeK2KBgCdMzghOZZ2YJJPb9QbsQ
	IWiqULDX+DF7U/kZ/6Lp77kfab/tBE8OOub0dv5aHxgDdd5WMxP063Gzy8sqvbRgapoPcCGjEyf
	LzNir8mtW03MorvZzFvviyBEM395xU+T5/UyJLRk+hGmqSuCl0fPMyk7zjpyUvLqt22TN3QjpAU
	egjEpUKaS5zwj//Lft3av2DYYIipbWfMguLbGnl87K4lnMVNaF4uq/5h0ddB4qWsHj0SqNRyRAs
	kz5Bzg6Y0IzkvWBJADbVD+QF4pVx9lNv5Z//PIwZEfnZ20ODU0esU+srUP+xJ4I2O/dvVq3uf4q
	4/+rHeedlGbaegKmMTH6f+Aj455SoUTCaPRb5FJHnDhcNJLAYbfiU5T9FFWN9CdSrNd9cC6hS0Y
	xq0+dYYVejnq18x31xcNV3PdkGURu2xIXM1RzQa4PkACgnh8WiF6m7Rk0+hG8+mhMNHe7tghqAd
	nPTZKO9E8bfhFcnqGRSsc2v0jgiG3lgg1GXA9NOK7292ySJVJN4puSnghiQCXxYuajxgKvQQdI2
	66ju9w==
X-Received: by 2002:a17:903:1a26:b0:2d5:c099:16e2 with SMTP id d9443c01a7336-2d74e070456mr160099615ad.13.1787935612681;
        Fri, 28 Aug 2026 09:46:52 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net (c-73-240-212-25.hsd1.or.comcast.net. [73.240.212.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988a1d6sm7487845ad.55.2026.08.28.09.46.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 09:46:52 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Cedric Le Goater <clg@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap mappings
Date: Fri, 28 Aug 2026 09:46:49 -0700
Message-ID: <20260828164649.77283-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
References: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 08:55:57PM +0100, Lorenzo Stoakes (ARM) wrote:
> This is incorrect - if a huge PFN map is available (defined by
> vma->vm_ops->huge_fault being non-NULL for a VMA_PFNMAP_BIT VMA), then it
> should be mapped huge upon fault-in.
[...]
> Correct this by explicitly checking for this while ensuring that smaps
> continues to accurately report THPeligible statistics.

I backported this to a 6.17 based kernel and tested it under
cloud-hypervisor with THP left at the Ubuntu default of madvise, on
two GPU generations:

  - 4x H100, 128 GiB BAR1 each
  - 8x B300, 512 GiB BAR1 each

With the patch every BAR faults in entirely at PUD (1 GiB)
granularity, one entry per GiB of BAR, so 128 for each H100 BAR and
512 for each B300 BAR, and smaps reports THPeligible: 1 for every
vfio-device VMA. Total time in the huge_fault path was 4.5 ms on the
H100 node and 130 ms on the B300 node, and the VMs booted in 11.6s
and 32s respectively.

Tested-by: Saravanan D <saravanand@crusoe.ai>
