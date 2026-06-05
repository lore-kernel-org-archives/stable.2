Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4B3FF89F;
	Fri,  5 Jun 2026 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642053; cv=none; b=NEdSurJHbhtJgbX7gzu0A97rEmK6La8LtNXAXqj3+xjE1A9OUOuj+QVes0D3VkvBO1+p56SoJ2O5LEui4yyXlE3gV/7bqTxXI+EkMY4xEqvrrxZX1j4siyUczqDkGhg7Pde+ny8EGXotWuMiaFvAhG5BcHDNcy0M4L5aNHBPYUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642053; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPgzKlpN0V7bh63oGN40cRLMN5IoPXRF0j8UFt0hN49uwT/i9Tp3bvNBSMUC9wBGitiW7gbWxOr8xbdxAWMYM8O24EU1HDPX1mwC8MlYgGwdbPDFDCDUczkjmLXcp6CbxCeo1xar+65T5Dx8tXyrVK8sX5C9RR5u2m8GGfmyRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V6UtR/P7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V6UtR/P7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=V6UtR/P7ao5H6NXHVW67cQ+kQR
	lzogiyQNE4VPvZ3bTAeikfaMj4RD7ECJzXh1VHZ/d/zWZ6LzDymNBAMi3Qw0m5Cd8BbkyILMHBAn3
	UY8Gkr3YSvvtZGiPgbIbRhQrJAk2F+l2wwtNa75qw+HjWMnEKsmMVitmSPKmrlFL/j/t3v9zSIpb1
	8pefOfRSYGKIxzMQK2rZT0QzSk5tZfl4tEE2qDojYf2R/nOnlI0yQRciQeTA+1iCX2OPgBcXXkZWd
	tcuvSmdOYE0vBOySM1e3DyuGrhhhBd1Nc/dMbGkJr6ODF6YX+oYk1bb4+mIFP/ubpg2KQyDntNvEC
	b1rHCVig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVOKr-00000000BMb-3bgU;
	Fri, 05 Jun 2026 06:47:17 +0000
Date: Thu, 4 Jun 2026 23:47:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] libfs: set SB_I_NOEXEC and SB_I_NODEV by default
 in init_pseudo()
Message-ID: <aiJw9ZTjOQzwHn-t@infradead.org>
References: <20260604025315.245910-1-jhubbard@nvidia.com>
 <20260604025315.245910-2-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604025315.245910-2-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

