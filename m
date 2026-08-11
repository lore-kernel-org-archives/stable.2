Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DD44B0493;
	Tue, 11 Aug 2026 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408755; cv=none; b=QRHlo96imM1+dUNMFkiuURLh01m7gV1kPhDVKem3hZ8NMCsjZTozwIdPLzwDC1c2pGnyIjTTU7pjBRV3HFyhfYeLJIoUitvp4Nmq5Xk+8AY9idl5rre2A77exZidk2gBWSIuom1LAIIk+GRz17iBXEkThM4UMnwXLZvIJHcdnTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408755; c=relaxed/simple;
	bh=rLbgo6GJwdWevV9Z3sJ+7Q1Pv0uzAld9/Pi1YdXy0yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPzfNM3QKVAZccT+YheGRU0JEPG9mT60651S2DpRKn8XEK6xY4kdI1jEzZaRqHNF97LD1ocaSHYlTH1jkHSIhm5OTSmFbmE73uglC95P/KBfB/RasvTvEMUcq4prY69x128pxYsxE74qRSl4m3IkdYgPZrx0HAjfV1h55MK1z5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2ocvKca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2ocvKca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3F41F000E9;
	Tue, 11 Aug 2026 00:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408753;
	bh=aP42WPQ5fnOZBn7zm5ygaXsFvMPeFOfcuO2bfOX+dSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D2ocvKcaCe5xCXYtSMig0h0SmK8f8HHnfxBJh8qGi5Re68hpkkGtIZD9zCZe8VKDd
	 ZEmCTx9D6w0TK0R8OEc/2c9X7pZ6gnu9KacOr8Ht5Uwb1dPQr+dKYqydETVTOIDqJ8
	 xQThJIQcYHVp7+PuLAS5T5/Z6wEttt0fahR08/GMsTIm04agCpMgoTbmGc2Wo7eH7a
	 jah/X/D4QQ3o4TG39+KBK8ZRlKc4TQc0dFnU3Fei/MB0wnvkUG2ACnbUz7JegS1gky
	 qR5g030Y0k/t9GsUIJulVfrPBK+wq91B7KJVmKs3Zg79Px2E7ZUrOjriJsFrT0nOx2
	 vYOYKrJ6SZUuw==
Date: Mon, 10 Aug 2026 18:39:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Solganik Alexander <sashas@lightbitslabs.com>,
	Roy Shterman <roys@lightbitslabs.com>
Subject: Re: [PATCH] nvme-tcp: fix host memory disclosure on R2T for a read
 command
Message-ID: <anpvL_lhBNSiMqgW@kbusch-mbp>
References: <20260729054602.1237120-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729054602.1237120-1-yhlee@isslab.korea.ac.kr>

On Wed, Jul 29, 2026 at 02:46:02PM +0900, Yehyeong Lee wrote:
> nvme_tcp_handle_r2t() does not check the direction of the request the
> R2T refers to. A malicious controller can send an R2T for a READ and
> the host will answer it: nvme_tcp_setup_h2c_data_pdu() builds the
> H2CData header and nvme_tcp_try_send_data() sends the request's data
> buffer. That buffer is the READ destination, so its contents go to the
> controller.
> 
> The command then completes normally and nothing is logged.
> 
> Against a test controller that answers every READ with an R2T, a 4096
> byte buffered read returned all 4096 bytes, split over two R2Ts. The
> pages contained stale kernel data, including an array of struct page
> pointers.
> 
> Reject an R2T for a request that is not a write.

Looks good to me. Applied to nvme-7.3.
