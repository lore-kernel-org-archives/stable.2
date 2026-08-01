Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6F317145;
	Sat,  1 Aug 2026 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567250; cv=none; b=cgR7Z9DEDMrmMobO9Fq3D1qYOd0zLCuFJzCzBZwwQ4s82aI/CfEebYu3N4JWyvohYwp2HIIl8VoU/gkgvq+Y5S8oirsp9jA7q9B3M2WgimYJ2Rue9pMSPi9+ZSbrj9wBAW1xOZ3tlCZrYEP5CB1RO30H1oXgWdwx4xzyAj98hn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567250; c=relaxed/simple;
	bh=qeLrk5ZFcRVSYzKhnA6xD4LkDyqqzJ5qXSsxbjss8nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQr3+z+YxLplqtmcU1pmdQkJQygzYpAr9eR/AsfM4NmUd5UToaans2VsP506L+N0L+GfAVEbF2sSByinadGidF57mK2Vtw51czuN/Rt05fqZsPlD3bZ1EgL5ff0TCbHymbCxU96c1sqtYv2y34b2OZSGN6C0QeE//VUpbUVJGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HkDHSDh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HkDHSDh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE571F00AC4;
	Sat,  1 Aug 2026 06:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785567249;
	bh=XIJMaYWFvOXT7JzPQ1LRGZGcrTLPkCslwdiNmkT0MWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HkDHSDh7AKU7kcZUkJzhqZxP+8rBx+uTIzOgNaiaTaOf+BHo/HlgNEuFkoEWIr7/G
	 vycANYeGA/THUYcjjmarNIUuKE3/c7c7BBHr81oWBNv2Z2YDSnjnp5tc0bM1WD7VZd
	 3xGzgvEg81vhXTkSTWlKI+5acqE+YAOmaWRDMTXA=
Date: Sat, 1 Aug 2026 08:52:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: arnd@arndb.de, kees@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v8 1/2] misc: ibmasm: Fix static out-of-bounds MMIO
 access during probe
Message-ID: <2026080153-unthread-quake-ce1f@gregkh>
References: <20260718073253.96741-1-25181214217@stu.xidian.edu.cn>
 <20260718073253.96741-2-25181214217@stu.xidian.edu.cn>
 <2026073120-deplete-bronzing-481c@gregkh>
 <ce868846-52a6-47d7-96d5-1f14f1e9b5f9@stu.xidian.edu.cn>
 <2026073114-staff-turbine-9864@gregkh>
 <4b8fc5e2-8965-47a0-8be8-b12337398fe6@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b8fc5e2-8965-47a0-8be8-b12337398fe6@stu.xidian.edu.cn>

On Sat, Aug 01, 2026 at 10:58:56AM +0800, Mingyu Wang wrote:
> Hi Greg,
> 
> 
> > I do not know.  Do some research into when the hardware was made, what
> > it runs on, and try to determine if it really is even used anymore by
> > anyone.  If not, then yes, let's drop it!
> 
> Thanks for the guidance! I did the research on the IBM RSA hardware,
> and it indeed seems to belong in a museum.
> 
> Here is what I found regarding its lifecycle:
> 1. The IBM Remote Supervisor Adapter (RSA) and RSA II were early 2000s
>    management PCI/ISA cards for ancient IBM eServer xSeries machines.
> 2. IBM deprecated the RSA family and replaced it with IMM around 2008.

So if it was last shipped in 2008, I think we can properly remove it.
Care to submit a patch to do so?  If someone shows up with the hardware,
we can easily revert the removal.

thanks,

greg k-h
