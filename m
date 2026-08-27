Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA1C4D2EF4
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856530; cv=none; b=EjuDU6EPn8P/F9WbyGqioMduFwXzl/QzxOdIkUbgiXUQu4g53Bg29A2IhlSviAIEFLT4fpXJvlbm51AM0siyudsxK24PSv1WRlsmv22VF1ge9234kHXcNR0YJmEeCZHj5RFSEqDbLsMhfNIUgCKBO0kemflqRjY1F13JwO7ufjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856530; c=relaxed/simple;
	bh=yb/lqOyr/nZMu11/OYRhUWyuYmFvZ8CIb30pEANJt9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+PT892/bBRtFlRnG5Jq0fzsly3bk/02kNKeeFmv85005SjQYsOiAhsrfowUXFkR4qxYbrP7oC6sTsrrUK9sJmZV/q5tD9R5ga67+7yZ49tsjHw8xhhka8VgmxX2kfe+deXKARK4l6xifKKy6A0cz580mXUZD6g831YU4Q3G9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=izNM/KdE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="izNM/KdE"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93903d81a82so12026685a.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787856526; x=1788461326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hGoSq2TdAc7iekoqeJsQuM/rBlzw2s8Vqw8atuDxr34=;
        b=izNM/KdEbnQTVpMy06rpfIO8M9zgLY5SwWQOrkSN45JMsAHmb0OZQYEf96X1uUOfqH
         TNv/vqSeK3DehoneP2IsHyIbHZlN/L7Uo/Kbo9wNsl/2F1FXSeem23BNT1h7dGYpFnJU
         mR7sFRPgwnbr1ikQcfcdalrqc4jKC852KOZ2cAA+DlmD/lDefnK+mWS6UvjqXUAs5bB9
         jGz50dzk7YBWq/MI9mTZfmg1ETC1rWLLt9aXqOwXlBfplp5xqT8drpMqJC5xOxM0IS5W
         YZ5G0bJvvQHNZfYBD7GRYo1Ax+pHGv8Q5Es2j7UKyMuV51gAG9z/yBv/4RzWQph9n88V
         y8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856526; x=1788461326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGoSq2TdAc7iekoqeJsQuM/rBlzw2s8Vqw8atuDxr34=;
        b=fIZPzruFZQaw0gNz7I4/Yv2l37O/1ymxA58/dLAyMg+T/mehApJJF8aQLPcydAySjc
         9gekRrAJvmDVOu8sZ6vI9JlE0P6yjLDSlngPL9pAXAsMisjpnbLPMIE9gMSVgEYdjzaX
         AsT4zdvNRUhMEnAWnfKYxZGVfTgL3UMeIajkmR50+UWUOyVBrpprtS+MMVCS2dpUUQGv
         o2WLQASK6f6XlvZh3sXEqxZMfkZ2P5aF9R23+cDJDvD5NlurB8TKCJCsLLtpqSvwxjPj
         yJ6OC5nuI8W40UspfM3OLLxzKtoWVOWTEuHxd6jNT114jcw59fz9ek9JKhVoQZ/tvHAA
         rWWA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6pko1FoP+mvXqezWYwErgfRSrbEuRwpICoMPuZIkVlwNV6SzTKn02lZFNhL8xfxJqzl7E3bY=@vger.kernel.org
X-Gm-Message-State: AFuF++nexuPwd8wbOBcS10sAlDlF2YowUjs+w1ahgbjyfqsHe4XBJy5r
	yI+4mS7x+Nmtx7cJxp0DJnU9Ksj84PXf79mDNk7x9ujHTIBw8JqG2NTjNS+rvnx/64E=
X-Gm-Gg: AR+sD12CXt/Nqsx5SK6HuwAfktdnDkdbS3WrqlEDybsf/BwX65TFLpGUNr2tvHcWH8Y
	42fG+qq+R3cZwHwIfauznbC0nmix/lnKLHWMDWkcEV42A7tge3xI/ag9JOOfCCQ+poXR/ZBHVFU
	nSMPiT9AasH4hIof+cw/mOQZnLBoBntj+iACa1ryzgo0BVxRAKX4c9rWvTs1bmUPvrL0vgcvsMc
	jcmJBhwqr58jXIm9RRDNbKkx2HmhA6Fo+SgsdlrZ//+p7TcBN5WFaUAZuZxjw25A4ct5TZJ6DtH
	5rVBNZdZrGHycTFZSuIAr1M1EzDAVY6NGjQfN675qSJg2Fcm1Kypd/EyiBT3PVmt1tVcEBZWN15
	fRjCadipasJLa0eV3+qXZGiriGO6MuKqPrwcVOY/lC/n5gt6Hk3Njgp3WqQSdxPy32HZeV57al+
	wIT8JqW0OVh/0qiyn0UBJGnInW+jqLyYUuXZ/UimPobcfWofrzeQXfCkj8qZ7DrWWx3U3XNLbI3
	z92BNnj1Oc6pS3sIlR37ecDeIL4tIFy+vR7CNPYNUdH
X-Received: by 2002:a05:620a:478a:b0:939:1459:efb2 with SMTP id af79cd13be357-9391459f1a8mr23802785a.24.1787856526365;
        Thu, 27 Aug 2026 11:48:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939137059f0sm26648485a.6.2026.08.27.11.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:48:45 -0700 (PDT)
Date: Thu, 27 Aug 2026 14:48:44 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, 
	jannh@google.com, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, peterx@redhat.com, jgg@ziepe.ca, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/mempolicy: use vm_normal_folio_pmd() in
 queue_folios_pmd()
Message-ID: <apCGce4hi_8gtyE2@gourry-fedora-PF4VCD3F>
References: <20260821144947.167382-1-gourry@gourry.net>
 <20260821144947.167382-2-gourry@gourry.net>
 <6d855beb-1d24-4a6e-ae62-ac9e05e358e5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d855beb-1d24-4a6e-ae62-ac9e05e358e5@kernel.org>

On Thu, Aug 27, 2026 at 07:05:21PM +0200, David Hildenbrand (Arm) wrote:
> >  	}
> > +	folio = vm_normal_folio_pmd(walk->vma, addr, pmdval);
> > +	if (!folio)
> > +		return
> 
> 
> I think this is best written as:
> 
> folio = vm_normal_folio_pmd(walk->vma, addr, pmdval);
> if (!folio) {
> 	if (is_huge_zero_pmd(pmdval)) {
> 		walk->action = ACTION_CONTINUE;
> 		return;
> 	}
> 	return;
> }
> That way we minimize checks on the expected path.
> 

Sure, i'll spin a v2

> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 

Thanks!

~Gregory
