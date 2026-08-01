Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7282745E
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584326; cv=none; b=mJACBlrCYLjypTl9ZR/ar2kcegACbv3kJ4wV7oj4aMt7Lxm3mebKFVJQGUr387xuoqK010ZBjl64wSavzMqAsnCHBAgYjAHs3bPlsitXxTyyhRmiGocBLGOQFDE0hmU+ERjl277oyTjwwnMW7Ag/eg/AIbHiGi9ItNdIACSPV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584326; c=relaxed/simple;
	bh=7CCSIq4hhpffLOWovMqtMAAul1pl5G2JEVRaxekG/eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGI6/Br4eE+sK8AKjW9/kOuuUpXAhUgNhulB7hzSZThcCRvp/BXv4mmeOv2Ay5p7Qg7VM+HcOoSk2sEb2aLeRFRFeA+zi0Plpxxw3Xyvx2BDYDsUeLHGzPibsMUWGyKZTTqWJ1o2bPL2UsMNQNKoyHCRfDIltxAt2octzdmUcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=eGUbmg4f; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="eGUbmg4f"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1751144a91.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 04:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785584324; x=1786189124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p+f2gJFRKiSHuvZrOCKoONo8EmCeMk/bZVo3Md0qG7E=;
        b=eGUbmg4fltNmQqArwASL3iOcZFLOMt0cPQhcDDBRarNoN/Np4J7yhpKNhnetrHSQnJ
         wKwrX87t7+OkUG/RCmUlRWnf1AQuS7B2RSzvyDTHM+iFIuXYncNFvUsgBlbPcCs0qPNh
         l5f7lQ2qrgo+Z3XPIabGhXyn66bEwGNsqt6OFda/yUsfA9FmudeEQo1W93gKA4xt1WVN
         YTS7k0EokNrHAIbJYrhwT+XXFwwkDN0GUrW1d9jkBy174z5iLLmIe1goztAyhmrl84kg
         OEMr5xSz//41LJC4o8XRu/LkLJkK0TWTGX+YEjJOiAUMxANV2+HLpEKbDxSXMT8lHIT7
         hPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785584324; x=1786189124;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+f2gJFRKiSHuvZrOCKoONo8EmCeMk/bZVo3Md0qG7E=;
        b=I8IJrB54BtA2cXwCq5GmgOIFCcN5qroOP93Mi+n4xlbvdJ2jue81uy2VWLYIVBpGWp
         YVA1RMLhAIixQ5ol7cauLJDWqTEnFwX21Fvfzxg5OmH9GqifC1q3rigvDLR7LZYteYnj
         1wj6ORe4ccE4ew5JnTYwNFuh6sLOn6pk0DY9Yr56oa8gKJSHg3INVZpBFYEMp8eZ9fYB
         3p2nz4oTWI35+P7ZTMJwGAh+LxG9qK/1Y7VeaeWSiDnWslODpusjCvO831E7VR2y8kPX
         qLKq3OFbe4HImmt+3eqsayr/ve7QjC49+mwbSiBhavkrh2Tapd2srhlUZCAPO1CrgmRI
         8KDw==
X-Forwarded-Encrypted: i=1; AHgh+RpLLvPWpB+u/tQsC+q2yfKkw+lja8G+FW2KVPkMB+9TqMvTeLPIkXlJ15zHEZIkvx84M2butQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4TdqUXoeJiWt7mKiGg/IRIWQAyfJdztrul818c5gqMTPMFro
	ovG/dfZioQ0Iog6Fdpu7jJlbAYQfLtWcvl4ROCaUc9gKpSRowd0kb0nVOk9AuelhemI=
X-Gm-Gg: AR+sD13wa022sY6IfqdpP0TYvlHS8AU7N1m25sOW7I6if/CKiaPV/0mVyVyeSXMDRyg
	LC2LreCVbelJYIx80h8pYJZfW/LpWCjNfS85XbjPww4p6Kpg6CcVdEOZFWvQtmTCnouLL4WBdEr
	jkmk428ixIZ2/nSofN/j0/C8FhpG0AL9BGpeVRNOVqMsa2tMdtyVbt2pkStVIMx8dagEstB6v8B
	n62I2/OkQqBgpeuE9o9fj1jNuhC1fA8/E1g6SgVo3eg78f0TKLxrF7OuQoWEO2BQgZ9r+zUaxW9
	K5dwvSOQK1Hq7ZqZ8JwF/7riqwOnvTIpVH5E0kKDRKbJ/BCwY1LdaK79HaVr8rVUMZlUKS8rEVB
	XBbzM/QHuXgYBS3BLXOHGx56ZNutPwOyY/fG+dN6l14krbRVAgNsCz4ly5+WjWBLhY/NxMB6cFW
	xxYRYOiIAdC8AT9RaqaGKG+s0TLM7SgIA0qMoiGZWMe9/v7HBExevbDGi8CjXmrFmQvQhM6wTM2
	Oj8DiBSqWKncEYFMhoMOb2jvjU9jkCsOcRNkEzyyWc7Yy253tAWnKmeZiG5PoHXBeFyNLHJWsmr
X-Received: by 2002:a17:90b:4a11:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-38fbc3f9a96mr2804697a91.9.1785584324474;
        Sat, 01 Aug 2026 04:38:44 -0700 (PDT)
Received: from Metius ([103.158.43.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4fdb80sm11588402c88.15.2026.08.01.04.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 04:38:44 -0700 (PDT)
Date: Sat, 1 Aug 2026 17:08:38 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: jjohnson@kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: Fix possible memory leak in
 ath11k_dp_srng_setup()
Message-ID: <l2m3df76j6tzdshgoecqx2fn3b2kzjsytqsxq6mpououga2wjn@zjxksj4z6iov>
References: <20260727105532.118164-1-nihaal@cse.iitm.ac.in>
 <041f72ea-7dfc-4d50-ac0d-e0556f037a27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041f72ea-7dfc-4d50-ac0d-e0556f037a27@oss.qualcomm.com>

On Fri, Jul 31, 2026 at 02:40:37PM -0700, Jeff Johnson wrote:
> On 7/27/2026 3:55 AM, Abdun Nihaal wrote:
> > In ath11k_dp_srng_setup(), the memory allocated for
> > ring->vaddr_unaligned is not freed when ath11k_hal_srng_setup() fails.
> > Fix that by calling ath11k_dp_srng_cleanup() in that error path.
> 
> Did you find this on your own? Just want to make sure you are aware of:
> https://docs.kernel.org/process/coding-assistants.html

I used a prototype static analysis tool that I'm building using the LLVM
compiler infrastructure, to detect this memory leak issue.
Didn't use LLMs, that's why didn't include the Assisted-by tag.

> FWIW my coding agent says this patch is correct but incomplete. There is a 2nd
> leak, at the switch (type) default: case which returns -EINVAL without cleanup.
> 
> Care to incorporate a fix for that in a v2?
> For that part you can add Assisted-by: Claude:claude-sonnet-4-6

I didn't find any calls to ath11k_dp_srng_setup() that passes any
hal_ring_type other than the handled ones. That's why I left the default
case as infeasible. But anyways, to be safe, I'll add a free in the
default case as well, and send a v2.

Regards,
Nihaal
