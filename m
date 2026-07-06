Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C23803D9;
	Mon,  6 Jul 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348351; cv=none; b=Izr/o6U9utd2RYw14OQjPqSkvXlV1y2yzRdi7Lggzr3YDin0DYfOh+e6FfQwwb7TfTe3+HxVdBZr8adXupsEte6XDIpglNl6SMg/lwtzdfWqjT+QcZJpWZ/5Lhj6AsxVD6UonAJHOrEPuIqzbVeC5TQzlI6TBFHnr+sZ80ISgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348351; c=relaxed/simple;
	bh=ZvHFaeKoA4urRR/RrbPxmUCKy0/k0ho3/pMY9NQrV1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP+NKPDy6uHdMbU128lvKmO2z9oeiLkFYJbgQVyf9w5SkKVeQ8icXI58naAUUbmYwzME59SLtgumOFaRwxVHqS7QNovYVaM34EVCTHBnZ4ENRp2rJ7B/dAJP67uvSA9tzXCht9F1e4HDNmP0CYLGqqsd1V/rj4eibbs0Vxmvc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mx4/Vjxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mx4/Vjxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADF61F00A3A;
	Mon,  6 Jul 2026 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783348349;
	bh=qqtQclWVRJeGbyZnEKIXA2FoQaHc57BHwkaaAOGJLw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mx4/Vjxqicocsc5k3T84Guz67QN0zZxLht3ojcljR2SZ+zAq/aPRSdILCDgzOANRM
	 RaBNs2lN9+r0r3bgm7IFQVgkFyaViW6be8ZvIxO9ZlVSrfC1tZh2bHk/nuKV8cGqvK
	 DZqLPM0+iJWrDw/O5vX04OTDdWsZElA+irAo4HGQ=
Date: Mon, 6 Jul 2026 16:32:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Badal Nilawar <badal.nilawar@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Menachem Adin <menachem.adin@intel.com>, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH char-misc v2] mei: lb: fix incorrect type in assignment
Message-ID: <2026070608-reformat-pungent-aeb4@gregkh>
References: <20260706-fix_type_le-v2-1-586826351454@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-fix_type_le-v2-1-586826351454@intel.com>

On Mon, Jul 06, 2026 at 04:01:30PM +0300, Alexander Usyskin wrote:
> Fix the mix between __le32 and integer by casting
> the MEI_LB2_CMD constant as __le32 while using it.
> 
> Fixes sparse waring:
> drivers/misc/mei/mei_lb.c:284:32: sparse: sparse: restricted __le32 degrades to integer
> drivers/misc/mei/mei_lb.c:330:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] command_id @@     got int @@
> drivers/misc/mei/mei_lb.c:330:40: sparse:     expected restricted __le32 [usertype] command_id
> drivers/misc/mei/mei_lb.c:330:40: sparse:     got int
> 
> Cc: stable@vger.kernel.org

Why cc: stable?  It doesn't actually cause any functional change to the
code at all, right?  This isn't running on s390, or am I mistaken?

thanks,

greg k-h
