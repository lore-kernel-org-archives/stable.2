Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A13DB337
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646428; cv=none; b=bcbnmaQCZGZxhXmJ1iKA6tnLPTWOMIaUnSUNZS8C0RvV9r65hJqv/J9YPCgEXF9uyDg2rMJ9rFGjZgkkYTtZDkhGTrKewKrn8dTxP8bG3wZTpp38r50wQtjxWLoCx01g43Qaph/kKMbkkVc69lrIrue/SI2TMJ64izXKlklDa+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646428; c=relaxed/simple;
	bh=MJpAjeL8gGvLuSsCwNIvRKi+YIEv9RIbRN/Bu5A17Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e14F4KPylVrSZH4PGQ1sNT0aElqWP8A8rTTCIJDmwfYuVsl7JlrOMkPlg6dNePywniqCas3Oo5KZEE4hI80NGmLYk5rBn/+sQQJmUaqnv+yIU6pvUMCgOs3B2Jf7CbE5sIrtw3tY/ANfg3XdQTcqzP3QQfNK9KpUxbNIB4UeXhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YVql98C3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YVql98C3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99CE1F000E9;
	Tue, 25 Aug 2026 08:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787646427;
	bh=q1CeSoNcgs38Q3ks16SHl984wd2aJ0/xEEdERGFkGXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YVql98C3iFj+j81iqPO80IOq0EJ6YPHi+SHvaiNaCdYIT6dZ5pH6myguUT+HKTWH8
	 1PkdgZg+tqmhXxSCeuejuaARRITycE4g/qIT1C/kokOZRLcw83uh3ht90p9Q8TeVxz
	 p80FHb387DSV0zfg8z8jIg9bg979Qf93dl4MfGKg=
Date: Tue, 25 Aug 2026 10:27:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jia Yao <jia.yao@intel.com>
Cc: stable@vger.kernel.org, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 6.18.y 1/3] drm/xe/guc_ads: allocate UM queues in a
 separate BO
Message-ID: <2026082510-monotone-denim-3d07@gregkh>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260825034224.642641-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825034224.642641-1-jia.yao@intel.com>

On Tue, Aug 25, 2026 at 03:42:22AM +0000, Jia Yao wrote:
> Move the UM queues into a dedicated BO (ads->um_queue_bo) and avoid
> CPU memset operations on it, which eliminates the CPU as a potential
> cacheline-polluting agent and helps maintain consistency between GAM
> writes and GuC reads.
> 
> We also need to ensure the base_dpa for the queue is contiguous on hw
> where this is used instead of a GGTT address. Another good reason to
> split this out to a separate BO.
> 
> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Link: https://patch.msgid.link/20260804165057.129529-2-jia.yao@intel.com
> (cherry picked from commit 6af05de0dc19bbf3aaeec2020fe48b37c834b811)

This is not a valid git commit id anywhere that I can find :(

confused,

greg k-h
