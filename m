Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD03C3F45;
	Wed, 19 Aug 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153498; cv=none; b=BbGjpDQR/8hPF2bp76Aga77ZNkLjBWpaV+0cQI0f3mVB2zZ0SpdMoEsN5Jmo+1hZd0yOYsh4HqVQ9yJxnuZos0Cbkv+bsoDtu40xGsOuxKhWoIscZhFabLFIhl+kFckqyPa0h4xnY+rD4WKJ5Z4Xz0SsHK8JhB1mrC2xFCOQAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153498; c=relaxed/simple;
	bh=ofOcxyyjwJVhoVMw0060hYFT/nHC6gueyic7ggCCu4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgevoG60CHPcKH04VPrLYkf52PWUDOF6NGtdray8VE9dYA5aXINJPLhIlueMQr+b1t6TD4ujLQTIs7RSnICW80Rh62mgiG7cwKl9yfqYEVD+FnZkWfqUQBRHwc3+CxfQg/zUmninAB0bLXPUvZpGCJPtrr/sKiagCLYbf+/HsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYEH1Drq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYEH1Drq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2A51F000E9;
	Wed, 19 Aug 2026 15:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153496;
	bh=ft0TIVIhK6YqJWjdjM4hVMOESHGBcv8kDRRUI2xbzJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FYEH1DrqsCq6I+Oy1IuCybqPUnwn5wv3cwkagbn94vxpYdIiY59WGVFSg13DHcUNW
	 Y3hqjAwwnD2FaKf/0yDq9UFSWDETwsubhwlJMtGWpZxyvWrWNJPv6FQoQqmfQRiN5M
	 9S3B7QQAOzhO9YZbPDU0S3bvBOkyH0KUrbC1tNlnzVmhJKqfheAZ5Fjvrldr0qfbAL
	 3OJhpHdcnO0RyvHtGRZR4BzTfD4F8/7F8CvhBsB6Kd+LMSojTVPrS3l6w+jf++jt/f
	 9JZ8s9lrvafFq1rSxPw1W5UUTQg9mI8HJK7TDZs3f98zqO1KahRqtFjARVm5ldpq/q
	 am/Cbv2piClug==
Date: Wed, 19 Aug 2026 09:31:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: check the data direction of a C2HData PDU
Message-ID: <aoXMVth65hKTNjXk@kbusch-mbp>
References: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>

On Tue, Aug 18, 2026 at 08:04:05PM +0900, Yehyeong Lee wrote:
> nvme_tcp_handle_c2h_data() finds the request by command id and checks
> that it has a payload, but it does not check that the command asked for
> data to be read.  A controller that answers a write command with C2HData
> therefore reaches nvme_tcp_recv_data(), where _copy_to_iter() hits
> WARN_ON_ONCE(i->data_source) and returns 0.  The receive path turns that
> into -EFAULT and resets the controller.

Thanks, applied to nvme-7.3.
