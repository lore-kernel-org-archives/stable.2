Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC954655;
	Fri, 25 Sep 2026 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376703; cv=none; b=u+2rV2V9UHZuHrNtixMuVzfKIjRNXT8VXCCVYk4+K25Upb6tMmihKQwpfIGvURDnbcB63VQOUfRdRVMV7EFCXcTeU5GnzPtk/iVcP4DgRN7GDlFtZWNxhedPoVThJXb6qiKAEKD8KV4Jmn6Aj/68ta4DYRnNSlhqOJi1sByU+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376703; c=relaxed/simple;
	bh=+Qq1XzizP2Nbj3NODci1E51NQGp8F4tTMZSSovWr7yI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdkCbbLuPG3nd1mOQsm2s+l36DQy3cG1IE7AlFMFR7CgKwn4zGPq4BQx52NygOghHDvIwGdbJTctjfYfLbnd0Mmcw+8eyL2OYL9jJle4Sg1HxDLhE2x7LDBJ1ICE5v0I/RSvBrCO2x/EiS48M+gEMP82vFwaVukqsRy6pI5QOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwR5+EUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwR5+EUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CE61F000FF;
	Fri, 25 Sep 2026 22:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790376702;
	bh=MbNx6EIXWYHuOn4asqWDDh7qwHg4qgYpsS4KZv2Dfxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MwR5+EUf5+n0hGRh+eTzhtubsbfGwEP1HFsCTHnqiJH74aa7vm40DifBZAJsP00jt
	 8STDWDfC9Z18ikDC85X/i8nP3bsmqwc/DJiDgRSWOh4dh4P5lWw3at+Zn3z+y0+IwZ
	 RqaxXu+4Mms2bX92ifGkeLecQhh0Jor0BQ15V279FspzRvvq5qkijm4tea8Hx80cfQ
	 C/gJ7pCPNiGy+b43NATrBJHaMl0UEbHQVNTrw/Sqhr06J5MH6DcB4b7h9GeZTn1tNC
	 TMO2M9P6Vp0iXy/YB0+58FI+NfapcBWYg9LCe6wIMlcECFisGdyIhi94suCEzP2JVU
	 ZzzF+Jj2oM64g==
Date: Fri, 25 Sep 2026 23:51:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 alison.schofield@intel.com, ming.li@zohomail.com, icheng@nvidia.com,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/port: Clear cached dport pointers when a dport
 is removed
Message-ID: <20260925235139.47f78065@jic23-hlaptop>
In-Reply-To: <20260924212159.52920-2-dave.jiang@intel.com>
References: <20260924212159.52920-1-dave.jiang@intel.com>
	<20260924212159.52920-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 14:21:58 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Switch decoders cache dport pointers in cxlsd->target[], and nothing
> clears them when a dport is freed. Readers then dereference freed memory.
> 
> KASAN caught it under a cxl_test load/unload loop with concurrent sysfs
> reads (abbreviated).
> 
> Clear the matching slots from cxl_dport_remove(), walking the port's
> decoders the way cxl_port_update_decoder_targets() does on the add side.
> Scan all nr_targets slots, the target[] allocation size, and clear every
> hit.
> 
> Fixes: 8330671c57c7 ("cxl: Add helper to delete dport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Assisted-by: LLM
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
