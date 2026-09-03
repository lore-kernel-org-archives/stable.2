Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E072264AB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 04:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788410403; cv=none; b=QqPxjelLy0wksVaNroBlD9Z3l8m3h3I+NfgiuebR5z5lNu8MHkUy2+GzLN2GSJq8kNJENISPuBskBVQLkv4ow3Yi2SlJQYW4DHvuJkGFrNGAMafWbYRips5WQIvyR+HZrDSodcDO2WSS1rPL1mJBFprBsTbXN0O+O3nQf5B4/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788410403; c=relaxed/simple;
	bh=/P606v70YQqG4bk9UtMxrdEWW3SX3PorcPW7buXmNnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aox6LhgcgFupAC8oC2BnCal5T80eq/S+LkRo9zWrblmF7HitI4JCysMshOdCEMSKC2kcdwULgHAoY3sS4EbXC478xl1WFiCM1hitvkTsaXN/LvKBZvOG+SX770AdtVKS96I+GPnbo/lkRf0KcGH8EQ68lCcDuETCFTN6+sWEylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QZpqht/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QZpqht/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E5C1F000E9;
	Thu,  3 Sep 2026 04:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788410401;
	bh=QIF+ZEsQAJ2ehlhl8j44PmBo3HKk7trkW9rRNa3n5Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QZpqht/ySI4VT9FpXq28gxUF3EMxr94tombtyN5IQsOCt7y32Kn1Re+KzYXjQGz+o
	 hgYnT0oOLJcUufiUj0vCBl4NTIO2g2I4kdxgKk4WUmONqg5q9pb9wkTNrM8Eo9AkbP
	 0nu0O7rO4R0QOszK444c6lqAdO3P/EPXN0mw4O1U=
Date: Thu, 3 Sep 2026 06:38:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Qihang <q.h.hack.winter@gmail.com>
Cc: john.johansen@canonical.com, georgia.garcia@canonical.com,
	security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] apparmor: make unpacked rename and attach strings owned
 copies
Message-ID: <2026090337-batboy-underpass-9507@gregkh>
References: <CAH78GvvERK9_hkKDa=Td8vK_89kZ4SPRb9J6UW5L0sMRPiUOBA@mail.gmail.com>
 <20260902160138.74264-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902160138.74264-1-q.h.hack.winter@gmail.com>

On Thu, Sep 03, 2026 at 12:01:38AM +0800, Qihang wrote:
> unpack_profile() stores the optional rename and attach strings using
> aa_unpack_str(), which returns pointers into the policy blob.
> profile->rename is later freed with kfree_sensitive(), causing an
> invalid free of an interior pointer on the failed-unpack path.
> profile->attach.xmatch_str can instead become a dangling pointer when
> the original policy blob is freed after compressed binary policy export.
> Use aa_unpack_strdup() for both strings and free xmatch_str with the
> attachment.
> 
> Fixes: 736ec752d95e9 ("AppArmor: policy routines for loading and unpacking policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
>  security/apparmor/policy.c        | 1 +
>  security/apparmor/policy_unpack.c | 7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)

as this, and the other apparmor patch, are now public, please just do
this work on the public apparmor list, no need to get security@k.o
involved anymore.

thanks,

greg k-h
