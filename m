Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7572DC32E;
	Tue, 13 Oct 2026 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901853; cv=none; b=Gxf950GIxNx4UlFFRyL/FFmOmZym8EGTQO0UqqutmGx5j5X75vCVuKNXVOFSsbWOUOFrIjQ9ifxt14aGcG6gj3JzOvbv/GLCK1CVPmtLzuthQK2r+DLYRHbTvj4aJC4v3iMDmsw+D2KTMnf04Ba6Ba8HeGDPcwSEoeFKVYq+7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901853; c=relaxed/simple;
	bh=7ftmANhW1ye5/jCMGeP3tBR2Narv/Ux6uRx0QYRyx+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE0gSBZqzta9ku+b3Mx8HFgqlxWjfNyQfeO8WKMPCEQojGeP1v66t+1wHdCp8uViJSnfBJL9X0lg02RD9G00VLjZ4B+JMSvAEgX3pefM4p5qQUx+AcV1t0nJju4W6UOZaA2pheZZ6muQMO93Ftf2DY7HkLY26o7Tjytrr04gcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2DC1227A88; Tue, 13 Oct 2026 16:30:48 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:30:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: free the bvec on file namespace range errors
Message-ID: <20261013143048.GD15192@lst.de>
References: <20261007192745.160060-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261007192745.160060-2-Jeremy.Jean@oss.cyber.gouv.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 07, 2026 at 07:27:46PM +0000, Jérémy Jean wrote:
> nvmet_file_execute_rw() allocates the bvec before
> nvmet_file_execute_io() checks whether the request fits in the backing
> file. If the request extends beyond the file, nvmet_file_execute_io()
> calls nvmet_req_complete() to return an error. This skips
> nvmet_file_io_done(), so the allocated memory is never freed. Repeated
> requests can exhaust memory.
> 
> Use nvmet_file_io_done() to free the bvec before returning the range
> error to the client.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

