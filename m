Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3848A8D3
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108453; cv=none; b=SW/9kPHF6ZtEV7aeUVZmQnM3uzntINCl+3rpQYSVP5W7Euw4OHjM7jEzlPlFXcEv+nwF6LkknrThcMuNU3ra/txkbhyn3XMJRNyaypf+npmeDIvWfJX+iVYDBLMSdyLMMmaMd96bTVostEmda8n0RF6KsfTCohtS+rAvv04TXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108453; c=relaxed/simple;
	bh=TD36+pd6PXJMXxKhayNfWFm4u3M0DOnYVVdbUGfjv1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCefewt9yJqVZuuSUNnzjE4svjCe96/w03T1Eb+0NWDmbIGDTa1Wf76a4i2XAD75Z4MF1UJlsj24YfKvXpBjWOWH1UhIX9RyRpa0eKXbQ6m8UG5xvbrKUWsaZiN2zPiupFRP474d3Zu369bwfJ2nmgZ8UZW7DVatlEVGXNSybeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eWT5xgt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eWT5xgt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070C81F000E9;
	Fri,  7 Aug 2026 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786108440;
	bh=Rs8eQNv5NKpIseCEsdAeoj1e2Grs80tpJVCeeVbgHxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eWT5xgt/NpwkPAFAez+P7d3wWIa3ELqo2viXQADewHn7WjXtfMHYov+kzsDtJQo0N
	 wEDRkXXDqXmkbx9u1g2/2WYGfwDFH1FCZ/deXvPd457XvOiZ4Rr/FTAVVBauAGISqU
	 eglRe9rEoF7TOxALutfuwjAi2gPNLMX5Vnve02WY=
Date: Fri, 7 Aug 2026 15:13:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, mjrosato@linux.ibm.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned" failed to apply to 6.12-stable tree
Message-ID: <2026080709-approach-tinker-d8da@gregkh>
References: <2026080507-senior-manpower-f5ab@gregkh>
 <cc046eb2-6308-4a3d-96a9-74b8787a44cb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc046eb2-6308-4a3d-96a9-74b8787a44cb@linux.ibm.com>

On Thu, Aug 06, 2026 at 11:13:48AM -0700, Farhan Ali wrote:
> Hi Greg,
> 
> This patch has a dependency on the following commit from Linus's tree:
> 
> 5618c53d96d1 ("KVM: s390: Use try_cmpxchg() instead of cmpxchg() loops")
> 
> Applying this dependency patch and then cherry-picking should resolve the
> conflict. It's the same issue for failing to apply 36f6999ecde3 ("KVM: s390:
> pci: Fix memory accounting for pinned/unpinned pages") in stable version
> 6.1, 6.6. Is it possible to apply the dependency patch and try again?
> 
> Also there were multiple fixes that we wanted to backport, but I think only
> 3 of the patches were attempted across (6.1, 6.6, 6.12 and 6.18). The entire
> backport would be:
> 
> 868d32ac72cb KVM: s390: pci: Validate AIBV and AISB before pinning guest
> pages
> 5580c9858f1e KVM: s390: pci: Fix resource leak on IRQ registration failure
> 8bf09b9b7d32 KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
> f86842e4d6c4 KVM: s390: pci: Fix missing error codes and memory unaccounting
> 36f6999ecde3 KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
> 8fa01be5a614 KVM: s390: pci: Reject adapter interrupt forwarding if already
> enabled
> 5618c53d96d1 KVM: s390: Use try_cmpxchg() instead of cmpxchg() loops
> 
> Would appreciate any guidance on how we can proceed with this.

Please just send patch series for the different stable trees, with the
correct patches backported and tested for those branches, and we will be
glad to take them that way, as we have no way of testing these types of
patches at all.

thanks,

greg k-h
