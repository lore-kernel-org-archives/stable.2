Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415663C1D72;
	Fri, 31 Jul 2026 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496737; cv=none; b=jPVBrrBLk99aCYCoC1Htvxc0AXu0C7cGU5Q1oTajbEeQM5sxUVoqcqcCwXfR8AEj4/BQ8cP3P8DH4gQoZdQRcPPGGP/fjqD46xNf39+nRBOeiT/PBsQhS/VRds+RutfvyVTjXE47Zln/DHYn9cjRcbnU/tt9HqvUCE5z+j1ThDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496737; c=relaxed/simple;
	bh=oIoMwp58NcIgfO5XzJY22JFuRwrIPOn/TokXGHGyZrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfKeJquNo+QA8ZPHh95QPJhwsprgaAoivS15IzCgy7NKUzg7dNdyErnwJsC7AmwArQkwcrD+wnadyUILPkEIo7JUcpGpDGCWvueEL8O+FKf7HMvIqzSqxJ/WxDjm+pKC9YB+bvlxwZRZxTjydkZ2uWToUdozxLKLnfNZTlSUs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IqNGEqmJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IqNGEqmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDEC1F000E9;
	Fri, 31 Jul 2026 11:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785496735;
	bh=OMVsf6FFADiEju78k9prkh/Sipl46XF2I+mAWCBVD0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IqNGEqmJ8ehdEIgzEo131ieFE19Kw77O+9FOqJViEkf5gCmQyQncHMN4McpXHdgI9
	 gHH3TYmMuaRAgW4oxW99WnT1+l5PPxEPrZrHfGZE0ueyAihT6ROhFuCNrAv/Pg5/+t
	 hMWnQP3SxN4Cr3BmPV5m2/7kocRHFz/cltVAHS7g=
Date: Fri, 31 Jul 2026 13:18:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: arnd@arndb.de, kees@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v8 2/2] misc: ibmasm: Fix dynamic out-of-bounds MMIO
 access via malicious MFA
Message-ID: <2026073113-defy-shortage-2005@gregkh>
References: <20260718073253.96741-1-25181214217@stu.xidian.edu.cn>
 <20260718073253.96741-3-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718073253.96741-3-25181214217@stu.xidian.edu.cn>

On Sat, Jul 18, 2026 at 03:32:53PM +0800, Mingyu Wang wrote:
> The ibmasm driver reads dynamic Message Frame Addresses (MFA) from
> hardware queues and uses them directly as offsets to dereference I2O
> messages via get_i2o_message().

Ah, this is I2O hardware.  Wow, I don't think that's even around
anymore, is it?  Do you have access to it to test this?

thanks,

greg k-h
