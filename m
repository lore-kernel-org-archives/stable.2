Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AD37F320;
	Tue, 13 Oct 2026 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901150; cv=none; b=l3xkF1aivkJop0TNREq9k5GskeIBhJLw2bWiOwgkVSuzxB97ckFJoXWiC6tztZzwd0de4G1Glxz1wEG9KPvdxWkmTyHFDIJ46L+n3SZRtBghPEkAGxM4Gx7Tt1EbOE5zkvrobJPsKmaUChRXaGrMu2heyLyeJIdFPYlPG4nsamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901150; c=relaxed/simple;
	bh=xaK8/D6bzpCc2TZ/0NvXfiMBcBAwciYEYnmZo7YFYQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8aSzHAfww8QhagsMrxyGdNFSrX8bUqz+r1iDfYaf/ewO/946ovcA0j80fh4hxOQ8yR48LKFPTvdXH/fLkXlfVWikZ3japdvDKXv7zrnJOQnhCuNe8QzuqrikYUdaAAAvG6U8mDMq+D1xS/oHS4btbRp3Dx2Am25yef69rDMP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D063227A88; Tue, 13 Oct 2026 16:19:05 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:19:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart2021@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: bound the FCP command data length before
 allocating buffers
Message-ID: <20261013141904.GA14323@lst.de>
References: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 13, 2026 at 07:40:38PM +0900, Yehyeong Lee wrote:
> nvmet_fc_handle_fcp_rqst() takes the data length straight from the FCP
> command IU (cmdiu->data_len, a 32-bit value from the wire) into
> fod->req.transfer_len and calls nvmet_fc_alloc_tgt_pgs(), which hands it to
> sgl_alloc() with no upper bound.  nvmet_req_init() only parses the command
> and clears transfer_len; nvmet_check_transfer_len(), the only other place
> the length is checked, runs later from req->execute(), after the allocation
> has already happened.
> 
> A remote, effectively unauthenticated host can therefore declare a huge
> transfer length and make the target allocate that much kernel memory for a
> command that never delivers the data.  nvmet-tcp bounds the equivalent
> length and the rdma transport is limited by its 24-bit SGL length field;
> the fc transport had no such limit.
> 
> Reject a command whose data length exceeds NVMET_FC_MAX_XFR_LENGTH before
> allocating anything.  The ceiling is 16 MiB, the largest transfer any
> in-tree fc LLDD can describe (lpfc maps up to LPFC_MAX_SG_SEG_CNT 4096
> segments, qla2xxx 1024), so no in-tree configuration is rejected.
> 
> A command declaring 4 GiB reaches sgl_alloc() unbounded before this change;
> afterwards a length above 16 MiB is failed with SGL_INVALID_DATA before any
> allocation is attempted.

The bounds check is obviously a good idea, but we really need to tell
the host about it using MDTS, don't we?

