Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F295346ADE
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963720; cv=none; b=rdkcbcVbXL8B49qOJ0+9gFfIEH/rholaquNXI/kvJOWjLKCCX01S2Z4z04YlonKkrTX1wfKv/SwLixD6PHaqW0C86jXKzLyerdOqgwjoG0RRNHWkA2JWYtTlPNch65gEFtGcjgj1lgY/+JwjJyu2fgFRuEpidbkJJXkNkkrPTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963720; c=relaxed/simple;
	bh=gT9s9oRpIiwyq5GIG9RUX0KOjdNXvmY7rnr7/TrhcE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/Vv/kwumsp9vfuT5Vw0hCZdjqKoOpVhN1F1tIrVL+DudWLqUc1Dbl3XuHxZc+ySeHbLPE6zr1s/piiZ/lMhdzZa3FExOu0sGD1SfAHQFh220QqRKIBu1aJ9njmoX52iWk0wEfZ9nBa+BtexDKeOOHukxCUYtCXXKS8SaajFT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gwIhX+za; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gwIhX+za"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2a818fc4so24722591cf.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783963718; x=1784568518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JDQW3Iu7NBoAVzUsdpY0L5+hRHDfdkqTfxv3iduKA6M=;
        b=gwIhX+za/qpfeQYrKqHRrT/NYBKqy1fcxDs86izaC5tJz8hrqta/fnluLKggVQBGGG
         U2KTuwo3SiCLMdcAnqO69f24xoLy2SBf/89SZ97ltuOXTbXuPu5xeLSKmEaABLf6aGdy
         uyDIKEj8dezMmaIR3yPRZbkYP6YPTqbOTIgv0xJhaA/s0+ML6gjpZ1GUBmgqbtN4pLsO
         235XCqM5efLvRbg6Q3OFGk045bDFJ45dNzI4CNo4EmxGM1+i5rqyPmEl8Ypl4liZpIFB
         sNMdL42Iuh3yJGA6PRbzsoCu19OR3I1lkjWMRu+JNQynmOro+/3HUvw3SOh7xIm2ikFu
         g7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963718; x=1784568518;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JDQW3Iu7NBoAVzUsdpY0L5+hRHDfdkqTfxv3iduKA6M=;
        b=ODnPTHcyfgDX/EDUEeSdp3Yf5vgBNjs8tWLj49b0KEJGwv1TVRBAhJgqpl9hPRzuq0
         rYrVfuYxH7drVWuRMhvR6HOzCB/7O6H0PA+ovaqRyjKCVaJf30fLQmnduIzlY1xn+5Fj
         vKdFLS9PUwU5KjnC52CFIWstF2wF3vggu2CHPDPrvriMvvxtZXGKAmGON8qXA5cz/o9h
         F8Kcd0+v3GEPb2947+EtDP57VJ+tAdy0UGVSm5tvLanXtakczLR7SnFYPZcH7Vs1Pqyv
         Rds/1+wT3IZfLhemmNzCk6V4tLHxpE9t/44HcNpG+QsaNFalkrdqpFLuk8V/LlGkEHOL
         qDDw==
X-Forwarded-Encrypted: i=1; AHgh+RoTBBZ/hIJLcSLZhZ1kHXlUQOMLFGBssa+flkq4UuOZk8pOJDUX2ywgvOe/T2RhzXfw1e2ZNpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfLuO/Yy6nU7U0+jQgQdBTSThXMkYLdf9c7TLQg/R7E621e41
	XHWER6bdmBgd4fOIzvxtGVGn+Agk3jLWP8Tb0wfKx1v3V9nmKaUlVxyOvr4XXdIWi9s=
X-Gm-Gg: AfdE7cnvVQj7s6cfHTV+q/MuhN2MWARU5aRhSoDvNC3k9Y3ulyIcVclXVN9ToRvLylQ
	92ZqJWkCuRa32u1nvHAh7Ns7vH3kvAEvKALIHjkONio0nYWy3XKqMlMSwwts4pojy0iCTRbzpOB
	59sxnelDz2SiCrR0gczzXBZYbWJ5JX8XJQEIRFKCQs9tXI9HR81b6prnUKMc3pUcdstQskAn+Yt
	kJF+OC9OH5ttkGSOFy0N5Ff0GhdMrc8My5BiNHtaaVHEVXv4jGOKoLr3hZqpYY9mPhm6snEjwm/
	gf45fB6V9MVGGEAQNbNRd/DdM8T+ZiOujU/Fhl7sXXw7UT3Ycv+IlNr+a/kmhKmqAqb8r+UL9Ze
	tQW8AcjucX2Gvh0ZxzWO7cWZ48jxaPMUZ1whlrtDa8z2DE8FCgzV/DeBLybas
X-Received: by 2002:ac8:5ac1:0:b0:51c:478:32a1 with SMTP id d75a77b69052e-51cbf06d972mr109410031cf.18.1783963717964;
        Mon, 13 Jul 2026 10:28:37 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b4fsm89742801cf.31.2026.07.13.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:28:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKSK-0000000Dmea-3sFm;
	Mon, 13 Jul 2026 14:28:36 -0300
Date: Mon, 13 Jul 2026 14:28:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommufd: Reject DMABUF pages from the access pin path
Message-ID: <20260713172836.GG3133966@ziepe.ca>
References: <E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn>
 <CD68F549BF3761B7+20260709050800.520607-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD68F549BF3761B7+20260709050800.520607-1-peiyang_he@smail.nju.edu.cn>

On Thu, Jul 09, 2026 at 01:08:00PM +0800, Peiyang He wrote:
> DMABUF pages are not supported for iommufd access pinning.
> iommufd_access_pin_pages() returns struct page pointers for
> in-kernel CPU access, but DMABUF-backed iopt_pages do not carry
> a userspace address that can be passed to the GUP path.
> 
> iopt_pages_rw_access() already rejects IOPT_ADDRESS_DMABUF before doing
> CPU access. Apply the same rejection to iopt_area_add_access() before it
> takes pages->mutex and calls iopt_pages_fill_xarray().
> Otherwise a DMABUF-backed iopt_pages can reach the hole-fill path, where
> pfn_reader_user_pin() interprets the union as uptr and
> calls pin_user_pages_fast()/pin_user_pages_remote().
> 
> This fix also avoids the lockdep warning reported from that path, where
> pages_dmabuf_mutex_key is held while gup_fast_fallback() may acquire
> mmap_lock.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn/
> Fixes: 71db84a092c3 ("iommufd: Add DMABUF to iopt_pages")
> Cc: stable@vger.kernel.org
> Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> ---
>  drivers/iommu/iommufd/pages.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied thanks

Jason
