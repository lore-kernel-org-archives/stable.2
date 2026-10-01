Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B59493D2C;
	Thu,  1 Oct 2026 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859699; cv=none; b=c+gV1TxMkSn8jShPOTB9csOXsGNPdTQI85al4Vcx+AvTtS0t1jJJq05kjAoq2F9audF7aBeYNqiIdVp/aFeR5lZTnxaEZqzWfF8/Ne9LJJaY7J4QYwb4/QuL1Tagr9lsMiye96MFvLY2P/p1SvryApqjJh+fU6hMr5ZgXBpVuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859699; c=relaxed/simple;
	bh=aYM8kuL4R9V0ZoKbWoFr2TeUgfNiLnh6WK+8UOczA0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9s2rJmI9MxvAGb0VcQajDXvRhNLkDsRsF5aeggCsqTrEGhNAu2hTN06cFI6Cnh5UmupuyWfhYC/jrXFUKYD/qbKuj6l5zIORIHFwcFVnI05QbnaHymUWmMb7/JOHaZ9+i5B/6UnLUOxUz7ztHzzFtq/BUBgJbjlvSVV3aYW1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdRZ+4sK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdRZ+4sK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72E41F000FF;
	Thu,  1 Oct 2026 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859697;
	bh=M4fP7Q2RZi+V4A/cdl0vS7LFLqAUgwwbTAklTftriPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LdRZ+4sK9ffUg+GHhtOGut4w8Tm9uzr+blbGD6yTPRzjT2QnelaRTLYw4/zRUMhyL
	 Q2NMGeYpl7dW8X9cHW2lqf5YuxcDhPbr4bd0uB8MNu1I05PkJrZfgwoOAS3Sp3RQrO
	 3m1js/sNpniDLO6bmgXIj7HkSaBrLx0uZ00t/h64Nv/W89OdStwON+9GRUN8jfXEMN
	 edl27Lo75oTtn1ONeD/rYDGgq0iGhFaDb3opb/wiNwrTIOYzavaHPMFrLfh9OiiGHF
	 HtFLWyJPufjnm1N3k5k9ZM7m8AdgmFs5vimTZWjC/CKmZVH10OoQ9NGLxa00nZw+UJ
	 okkjjNoJN25KA==
Date: Thu, 1 Oct 2026 18:31:32 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Georgiy Osokin <g.osokin@auroraos.dev>
Cc: Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] tee: shm: reject zero-sized allocations in
 tee_dyn_shm_alloc_helper()
Message-ID: <ar5ZrHihBjaFKf5U@sumit-xelite>
Mail-Followup-To: Georgiy Osokin <g.osokin@auroraos.dev>,
	Jens Wiklander <jenswi@kernel.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260928143113.1700001-1-g.osokin@auroraos.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260928143113.1700001-1-g.osokin@auroraos.dev>

On Mon, 28 Sep 2026 at 17:31:13 +0300, Georgiy Osokin wrote:
>tee_dyn_shm_alloc_helper() derives nr_pages from a caller-supplied size
>and passes it to alloc_pages_exact() without checking it. For size == 0
>nr_pages is 0, and alloc_pages_exact(0) calls get_order(0), which is
>documented as undefined and returns BITS_PER_LONG - PAGE_SHIFT. The page
>allocator then trips its order > MAX_PAGE_ORDER warning and fails the
>allocation; on a panic_on_warn kernel that ends the boot.
>
>This can be triggered by TEE_IOC_SHM_ALLOC with struct
>tee_ioctl_shm_alloc_data where size is 0.
>
>Reject a zero page count, as register_shm_helper() already does for the
>register path.
>
>Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
>Cc: stable@vger.kernel.org
>Cc: lvc-project@linuxtesting.org
>Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
>---
> drivers/tee/tee_shm.c | 4 ++++
> 1 file changed, 4 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>index 6742b3579..daa4af1e0 100644
>--- a/drivers/tee/tee_shm.c
>+++ b/drivers/tee/tee_shm.c
>@@ -343,6 +343,10 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
> 	unsigned int i;
> 	int rc = 0;
>
>+	/* get_order(0) is undefined and exceeds MAX_PAGE_ORDER. */
>+	if (!nr_pages)
>+		return -EINVAL;
>+
> 	/*
> 	 * Ignore alignment since this is already going to be page aligned
> 	 * and there's no need for any larger alignment.
>
>base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
>-- 
>2.54.0
>
