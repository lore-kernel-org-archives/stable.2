Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA0416D11
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682937; cv=none; b=thaL4fEN+xBWKJg2pggapGxe+A9zCHCjIII8GwdxBHJJreZwBCFJG+XHvl+8hoxXV2CYky6gi3Dp/UcQdXP5qzi577bpDzUmGLwrFCv//mKfySSPO5kvsdCpaAVCUzLX6yg+R2f+efcwLAOYXM/IQS8dbghO39YQImmNuXNElBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682937; c=relaxed/simple;
	bh=vVY2EaDtzvujga2nZTjhEXTUHieD1avXuMBfVvd4CKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaOZ5QAaZ+HZ/9m/OMGMtJMMCJoOhilUsjZEu8PLwa18oKDAdOQyTdRqjfclaQzd3w/eQgf9JL/k6yfWE+clKSFIeHkYn/dVcRc58qSunhITyRsEE8TVilcNdeOs4U6W8LA4kOTQUfFlifo4R02ZQEHaRgUrLAzNUwy20pMSt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lvxK/Zdd; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lvxK/Zdd"
Received: from macsyma.thunk.org (cclpop0120.carnival.com [151.124.104.120])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 66ABSTTt019851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 07:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1783682914; bh=7PH3awSXy0gNkNK6WWrl3tJtP/O87biU9HuHXgXpyVQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lvxK/Zddv+a8nsSr0R53A1IFD6cfc3n33aiSuud73u6GxBahE/FDiZdcqSYlzhJlM
	 v71qVD9jeKRgJ6erRBd6z6qXtIHEBY7k0Q32EIotgtWUH3Omst0dkcu2vns+/XaOAs
	 JcBv/dzJDBSSb+2+xeGASfJ1iiEFW11uN/l25Q/UF6EWIigzFLjbrgpBdnpqQ9HXA8
	 K+vJ8ijDAn+6c1snaUF5rDmY/PfPaoxADzCcafYPYhS4iDWyzaRnvMaiwJpPm/Z26E
	 rh+uA8GQvKXlZTlFZRZQH0MgAIUkAkHDnm7Zmv3VhkEmAMFiAXs6FBhaB2dPRImUSw
	 hq8JC7U0qls5Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7530D94DCD7; Fri, 10 Jul 2026 07:28:28 -0400 (EDT)
Date: Fri, 10 Jul 2026 07:28:28 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Please consider 83f99de1b7c0 ("ext2: fix race between setxattr
 and write back") for 5.10.y, 5.15.y, and 6.1.y
Message-ID: <alDWUmORy7fTnorX@mit.edu>
References: <20260710023142.3748810-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710023142.3748810-1-michael.bommarito@gmail.com>

On Thu, Jul 09, 2026 at 10:31:42PM -0500, Michael Bommarito wrote:
> Fresh stable check (2026-07-08):
> - 5.10.y: 738ac465e4e9
>   fix shape: absent; upstream diff: needs-adjustment
> - 5.15.y: c86c4726e7f0
>   fix shape: absent; upstream diff: needs-adjustment
> - 6.1.y: 090666d3cc90
>   fix shape: absent; upstream diff: needs-adjustment
> - 6.6.y and newer checked longterms already have the fixed shape


And this is why the patches have not been backported.  It requires
work, and an AI generated request doesn't change the reality that
*someone* has to do that work,

I invite you to figure out a way to figure out an AI mediated tool
that can attempt the backport, and then run the moral equivalent of
"gce-xfstests -c ext4.all -g auto" to verify that the backport doesn't
result in any regressions.  (Some previous attempts to backport to
older LTS kernels have resulted in the kernels crashing as a result.)

Otherwise, I recommend that most users consider switching to a newer
LTS kernel, or if they can't to pay $$$ to an enterprise Linux
distribution that pays engineers to do that hard work.

	     	       		       	    - Ted
