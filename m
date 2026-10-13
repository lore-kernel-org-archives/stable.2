Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17451CF7C;
	Tue, 13 Oct 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905750; cv=none; b=F9jIIvr75yfiuKGTyEdGb+FEDL3+Xw17ozKd/jaEuklYgGII2JaWU4lPgW7xYC+GOY4l7aCew7irBvtt+X9zLgSU1jOZUYAbYGa1l/quwytjK2QMljMfIh9Eh8u+GTmQIVlHxJ0CeKKNArueKACrKyIRB9d1bm49aZ1vsrzWpyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905750; c=relaxed/simple;
	bh=boyc73gv139M87em0nPx/69TvtcnLNcJfXoybX5CCpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs5eeOPsxFFyebvVGkLxCvv7Oq0E/gn3MrLrUSWWn4p2W64420VNWw+oNeKXS9hAJW4TNGzOz5C3vAFzGRUi8VCKPxH85iiKYyGwcIragXEZmfpzEMJoZzjTI8IAinwdUIArbdNHTWq+BlxWwbKkmo8o8Xql/7Ii1fA6NjG2LKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcxDw81H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcxDw81H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419D31F00899;
	Tue, 13 Oct 2026 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905749;
	bh=ViVk/UJdTZ8NQ5i6JGNkTMSAT6XRO2LDCoE6DGQFLI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kcxDw81HQ7HejwIfhHp+87ycVc/7AdrPPBtFePGGbgtqN2cRTdqa+V5oJGzCXxQj4
	 y02gXEKbNNT00q6UmLwKs2FSIQaw9S3ru+Jar6cpyzixBlVmyLHuhrVjwk/gsIiCa2
	 nJq9dDshCVW3zx3UgIMi6Lpd5fCVHTP3X5QxTOGACepXEbBPXiz7UXyVMqZelS43cu
	 0jMrRkCQbTredUjL4fHGORPEdNGWjVICcKpv1Rnb+Hxo/FdKp6IUeoUtra+cZ1thlH
	 gZuvtjqci8J4CDnyoufjPkw62nw5MCG8JZCQG6kWO2xBL2OjTDE9N7NcAHO9OFnSJS
	 OSLNvNb6UOyFA==
Date: Tue, 13 Oct 2026 09:35:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-rdma: don't complete a request after a bogus remote
 invalidation
Message-ID: <as5P01gemus69jzJ@kbusch-mbp>
References: <20260928153811.1466359-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928153811.1466359-1-yhlee@isslab.korea.ac.kr>

On Tue, Sep 29, 2026 at 12:38:11AM +0900, Yehyeong Lee wrote:
> When a remote invalidation names an rkey that is not the one we handed out
> for this request, nvme_rdma_process_nvme_rsp() logs and schedules error
> recovery, then falls through to nvme_rdma_end_request().  The request is
> completed with req->mr never invalidated, and nvme_rdma_unmap_data() hands
> it back with ib_mr_pool_put(), which only puts it on a list.  The rkey
> stays valid and still maps the pages the completed read filled, so a
> controller that sent the bogus invalidation can write into those pages
> after pread() has returned.
> 
> Return instead, the way the local invalidation path below already does,
> and leave the request for error recovery to cancel.

Thanks, applied to nvme-7.4.
