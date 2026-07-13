Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914993002D1
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961611; cv=none; b=iMnHEqlugMDZtR91G+1HYJqplP0Lr8w2cqcJ+3g7+DBqVxxdYwjDH1j4QPGUQv1n43UX8MMu20r9zjPDEZ2pyRC2b79Tvp45FnQ8wf/om7YQZJACRRPQH9rYS6aLf2X0lBz5m0HGi+Cx/n8dLmf9f0fWRe/6fIS8VcZqG4AAlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961611; c=relaxed/simple;
	bh=W8h/pOX2A68/AN9GGx/hlGAI45Btx/6RAqn1jjPBzJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyPSkoMXm+kqqx8N/PyGiwNI/rKFUvAsXTe9Bhg6eRHEYT8QdFaEWYgIRVtFSpUHTfQayTtt5NK8dg1NOFShyDZT9zbn6uCRU6Av01lN7GIJ129G37jZeFU4sLbx6o1TN/oXV7sR0wliQlM5rFehxnyrr/GzS57vO3FgMOuNYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WdH04Eem; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WdH04Eem"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c2a76536bso32220131cf.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783961599; x=1784566399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1wy5cjU8bpodUKB+73h1Dg8HOClHzWqmvSatqxWWARE=;
        b=WdH04EemQd7/ddxFpnJx6/Ba7mOZCai2CIoZZdA3LjWi+IXyq70gmGXmYZVaSThPsb
         o42rA0pJQSel7PbvhX4gdEvmVoPhs+mk342SmDurClN7+uN1ZYh0aTcYIbgN8pN4c03S
         X17rOMqOEDLDipVofv2jZRTbgaU6bWPKZGZ/fX3oiCR5wTh9Ko6H2YqHKamM7Caj0ydj
         UeCcy0UzbMcM2dYq4rd7GWTmkWgiRbA1gZWFYxA1lqVO1zw69jCDI1h4+z7mb/Gi2HdO
         VPkbF903DtIHjEWV/SKdO1hNOxVFz38Vk/u1jbv/3oNSVfs+YFJWkKx5nh3ZX8NznQzx
         W+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961599; x=1784566399;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wy5cjU8bpodUKB+73h1Dg8HOClHzWqmvSatqxWWARE=;
        b=UZ6LKeXxFiJp0foxMBLM9qGZXZ7wMhNmTg18GfkvLO38nuzFwoh0/swp7FKZw9dwPJ
         yaUDZylzQ01vzfQHej6SVgxEvq+a/cE3dzmMqBs89N7r7QptjUGIBC+R3LEbPPwvv4at
         CFBqFPyvpqJOK2TwYPwDecdHOY8kz+kiD2bj6PP3+dhyvCsUNkHtEHLDK1oqzNyT00Ax
         2/t7KRyISAmmkGynPxX/LYOv69tTAjAmuTkmoZgF65C/GkZYygqRAjjJSGRyvMi7n3IQ
         CMWancjTf/EdRtTbv3J2VrJT9h9AkLCDQoRPUsF4QGftCK1K5xlJS2UQ448d3qZaSQep
         3gpg==
X-Forwarded-Encrypted: i=1; AHgh+RqyvelaCqsyoXF7uPzUilHY2HjzHSINJ2ES0BaE8VGonSA4oWuXvcB/eHuCX/xed3MIUEqwHUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ABlpQsJucwoilvI94mYEkWr3GA+tYq5qMAOSdmz+CGEDmRGM
	PPsuMnDYIbaOG/dyep3+JAB0A23h5cIm3MJ2/VS1FlP9SI/Jj1zBEtsHV4k+rrUIuGNa5y8d75C
	ix4DY
X-Gm-Gg: AfdE7cmEX42q4RLriZwVQyXRXLTtSJ7NU+uiOdGSvQiXBbAOdIBUWEPOn4JGbsuXKgY
	TDzb4qKNZpH7HQAffeqLERkpJK7H5cTz4KKewMkFTwJHVs5NawXeUORUDbaEYVQryDVVSGYIiCZ
	QqPC0g76D6CTwp4Cf6yQJUMXjv0uJ0Xf9jjuJPmyzE6TqvI3ztVMLZ9DX/fos3J9q0IM5nb3qbQ
	5VPTwCYgxJjSB4Yb6OfCeLlTXQLhbMF/66G3GcHk0Rj/l8ecfa5EL1g3YMadHMC19g+O2QNOPoZ
	V8WaK9vzFtF4zk2KqRkCsKaePqZNPyIJKResXjS9th02WFt/oxqv2a3ZxvpqXvEUidT/BLpdoeL
	WF0jq25UFqYQGSqdcDFnikBAgfPceneFoqjxFva2AnAs17qBVsWgWw5NKFrh8
X-Received: by 2002:ac8:6f12:0:b0:51a:8c9a:8fb7 with SMTP id d75a77b69052e-51cbf30ebd1mr99770401cf.72.1783961598776;
        Mon, 13 Jul 2026 09:53:18 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6e9f4sm88381971cf.2.2026.07.13.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:53:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjJu9-0000000Dd2s-2yX2;
	Mon, 13 Jul 2026 13:53:17 -0300
Date: Mon, 13 Jul 2026 13:53:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	nicolinc@nvidia.com
Subject: Re: [PATCH] iommufd: Fix wrong hwpt passed to
 iommufd_auto_response_faults on replace
Message-ID: <20260713165317.GE3133966@ziepe.ca>
References: <9D652384339C69D5+20260710122952.885325-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D652384339C69D5+20260710122952.885325-1-peiyang_he@smail.nju.edu.cn>

On Fri, Jul 10, 2026 at 08:29:52PM +0800, Peiyang He wrote:
> iommufd_hwpt_replace_device() calls:
> 
> 	iommufd_auto_response_faults(hwpt, old_handle);
> 
> passing the *new* hwpt together with the handle of
> the device's *old* domain. This should be a parameter mismatch:
> 
> 1. Semantically, iommufd_auto_response_faults(x, handle) scans
>    x->fault's deliver list and response xarray for groups matching
>    "handle". A group is queued under the hwpt that was attached at
>    fault-delivery time. old_handle is fetched *before* the domain switch,
>    so its group lives on old->fault, not on the new hwpt->fault.
> 
> 2. Historically, the first argument was "old". The routine was
>    introduced by commit b7d8833677ba ("iommufd: Fault-capable hwpt
>    attach/detach/replace") as __fault_domain_replace_dev() in
>    fault.c, correctly calling iommufd_auto_response_faults(old, curr).
>    Commit fb21b1568ada ("iommufd: Make attach_handle generic than
>    fault specific") moved this into iommufd_hwpt_replace_device() in
>    device.c and swapped it to "hwpt". This should be a refactor regression,
>    not an intentional change.
> 
> Fix this by passing "old" instead.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Fixes: fb21b1568ada ("iommufd: Make attach_handle generic than fault specific")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> ---
>  drivers/iommu/iommufd/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied

Thanks,
Jason
