Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F72D0602;
	Thu, 30 Jul 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417776; cv=none; b=aObwsmCmtsZDcjxx1DhXQdt7baiJLckFsjJF1nKETQjNQ0+kBrKKrPyqfIzrMEFBoD8RMwdE5YeymuzJmxc4GQcv7gJ7u5/QTFaGCD7xkR+KLIQMzCmXqd9mmNsQ4MbowVTbaszOcPaZGTITflRl5BmPlszdg6vB8KWHm/VLNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417776; c=relaxed/simple;
	bh=CntTlzOqY7sRhsnFam4H9ug20FHlY6+Oieu44o8YiMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u80TCvGxI4nWfqrQE4CyWA4jzOVI4qfvxHsNOQLQULf/0Vcu9krXpRToSNiafmaUtrhi18PCg8TFpsWrURhQPvKpPOJrwi10KDBHo6nelkmkLg/q4ck/gYczL06bVHHGxAc3OUGr94YOo9u+ZTcepnYjBVhfG//+j4fYwpQUWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vdAaQqUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vdAaQqUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F8B1F000E9;
	Thu, 30 Jul 2026 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785417775;
	bh=3NXBy8rLNLnm3OchtgNt6sw/f1z7mr1m0Y3YmJAxY1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vdAaQqUJJ4YRHSjGEDOVCXgBsIdTlf3jOar2eUGf1Gbqz13llX5QZIGC5GAL6V2SC
	 R9wQdcedBZ4f/ZZUQ//AN2lmZtbvj6Amt9Src9lP9Zgvyo/JA5Jw+e+QDjksVXZgFE
	 d2cD1SB86A6WnxO6E5r3Mma72EtPPLIHjQV6w1GI=
Date: Thu, 30 Jul 2026 15:22:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, yi.zhang@huawei.com,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: Patch "iomap: fix incorrect did_zero setting in
 iomap_zero_iter()" has been added to the 6.18-stable tree
Message-ID: <2026073015-entrench-spotty-b138@gregkh>
References: <20260728183303.333501-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728183303.333501-1-sashal@kernel.org>

On Tue, Jul 28, 2026 at 02:33:03PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     iomap: fix incorrect did_zero setting in iomap_zero_iter()
> 
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      iomap-fix-incorrect-did_zero-setting-in-iomap_zero_i.patch
> and it can be found in the queue-6.18 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I had to drop this, and the previous commits for this, due to lots of
"fixes" that were on top of this series that did not apply at all to the
6.18.y tree :(

thanks,

greg k-h
