Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBEE37B40E;
	Sat,  3 Oct 2026 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791017756; cv=none; b=NBFpXfKxrr8xEOX6qV0vMMlfKlfL+oSLiXd+1CIZWNqcbnHrfc6gCiGKus6iGHOBkD4mqy1sVCdS5AYbrcKfkodQP4xZiLNImIJxzfz/36MW/ZQnMnYFwameeojTErJvESCAdC9adrH2Myq6sCunZw6OlmM+W7+/lpkOnFPFiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791017756; c=relaxed/simple;
	bh=kTHrktZteEE+sofnb1g9qJHeyFyTrSxqySTtG+v2Rgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4CmUUypcjhyVHK9+5UkAZMLfx7MYORKYy7JWGi1VNAtr0C77Nfs7ByiMhiQ2779LJOAPim03PI/Nsn2SodzHwpDnUMmkkF391TqWxJxYAObmnsRTujiVi2dCYMkPk4jPTQalFgiH2pWFREt0zR57gxLIDdrdH1Me4UBGd+CwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPxFLYw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPxFLYw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8961F0089B;
	Sat,  3 Oct 2026 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791017755;
	bh=N7Y9hr1d6rNWQJdJJwZOij8ysdYgwFMz7LiXw4Or/Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LPxFLYw1Msgaf6cEB+RR2Je158MFSKPmdpK7CRrWPtqcxR/55IBb5JZgq5SGzMXT8
	 Rxm7jmMFhxFCri/8XAScsmYvDVaatVzY+SLCIstEJRVSKK/UGxrBFQWbwxaBHfy3cz
	 l1kyK0ETQLbBZGHooS6u7/CA6EWZ9ULazINtGbYVpM4uoCFBLvOfrQ4mpLFWTYPQS5
	 D8iPindiofDlnoeVmEQbjiUmEcCigssV2R8BQWHCB7HxSpjze3Rr8CAsGNNEuJGwu0
	 fkzkhsDDmbAcA8rbZFBdmLL8Z7MmGiGl3IIx2gakjE5eUD0ux8W7tQXR2WgjdW2ajW
	 pAdjJgWvzQZPg==
Date: Sat, 3 Oct 2026 09:55:49 +0100
From: Keith Busch <kbusch@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Karl Bonde Torp <k.torp@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: fix swapped ZRASF zone state values for full and
 read only
Message-ID: <asDDFcpl2pFFoH9O@kbusch-mbp>
References: <20260929-nvme-zns-fabrics-field-fix-v1-1-f99b6ffb49fc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-nvme-zns-fabrics-field-fix-v1-1-f99b6ffb49fc@kernel.org>

On Tue, Sep 29, 2026 at 04:25:00PM +0200, Andreas Hindborg wrote:
> From: Karl Bonde Torp <k.torp@samsung.com>
> 
> The Zone Management Receive command Zone Receive Action Specific (ZRASF)
> reporting option values for the Full and Read Only zone states are swapped
> compared to the NVM Express Zoned Namespace Command Set Specification,
> Revision 1.5, Figure 35:
> 
> - 5h lists the zones in the ZSF:Full state.
> - 6h lists the zones in the ZSRO:Read Only state.
> 
> The nvmet ZNS backend uses these constants to map the ZRASF value received
> from the host to a block layer zone condition when filtering zones in
> Report Zones. Because of the swap, a host asking for full zones was given
> the read only zones, and a host asking for read only zones was given the
> full zones.
> 
> Swap the values of NVME_ZRASF_ZONE_STATE_FULL and
> NVME_ZRASF_ZONE_STATE_READONLY to match the specification.

Thanks, applied to nvme-7.3.
