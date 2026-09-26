Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3336495F
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419445; cv=none; b=BLSfw1svIfEq99i0qa2hoIwr9R9ZmlkxFOZD7jntYzXjnurVaRug3ReEAjsDRpFUcLO7OIyvu52hKEWDiSIQeaALWdhqn1z6G0+zf+cRnm84wx3sOCOy+Ba+P/gEAcxP7q6ZMDlJCBYB8asm+YDzg38laNxqUyE2zzEirEh8YBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419445; c=relaxed/simple;
	bh=MctTYdfGPj00J6w1N5O8ZOZ/SCKIeqWaRzqr1F43zWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcXuGm1aLagSQkYAFGUqa9woSxMk6A+beMzX0hYpZMq4zHxJ44rmrwhhjXr+uoi2wW+ck7sdr8Tv6AzUsq0tIhPxUE9+JHdZgOknRtQ3VW6ccgq5l8Cezc6JUKiEHbSZIENKIHtRQeyT0Qg0KuCrytadA5mGW+nvrAsGlaE7gjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qL/OhyO0; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qL/OhyO0"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90ce6d5271dso9249576d6.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790419421; x=1791024221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z53uSMUq2W80HZiwGXPg4CfzzfvAXSACVLwfmhiGvRc=;
        b=qL/OhyO0UDeziz00j0G366Kb02C7eN5TfR/RBO72sZejsQSCdwPG69FsN1NCoOnS7D
         ADSYvJKPSCfIGVUag/LhAMPfvcxZBEqa3iJmcww0jy/dk+BQvHCIWfiBON2Q010cp1m4
         X7xALojr0YtRqI2wnRmEzT8c8qiRdDhtWbf8edoZQjDgyzgbsnBxsHlmwNKrP6OvOn4u
         3oaBFn7t7FyaQHwFR2zZzf7uDDSZ/drROyQLXZ7Z9KTgHWPfbJI9OJ5Dj3AlHLi8Nhi8
         +Rc9cexAdUWCRRi/OBgaWZ8nY03nRDI7WsAo+XykjaqIe3nVupulrqbwkW9SuDOMUZXU
         B2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790419421; x=1791024221;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z53uSMUq2W80HZiwGXPg4CfzzfvAXSACVLwfmhiGvRc=;
        b=rn6E/T0BRpTh+nHpd0RcC2UF/+k9Yuj8E70X991z7CoVe4MFtgaA19auF0LjmecmAr
         3tVY5dibiYXG1IN0+vRnHLXO3DINMtopNMGQM+jSFMvkuwM2ZzD3aJ7F6IS+aafqPf9t
         Zjysc/6xZJXne+8a5jyO205k5KzNh4JPFnIYT2v7wSL9sdYvWejn128XsjQWO21VIoLz
         aEVDhxpKfI93i/PD8uDAO1uToojiVlDYooSJkiN/r7tpNIIJVtW8BSe+rSPte1Z3bez1
         C/kCTWx2vovobgRAaDzmt1GOtTnUUJLg83U7QIehaokpmMdjDvcN6w8yna/NOEMVlxXC
         VH3Q==
X-Forwarded-Encrypted: i=1; AKwUvBw6KaxOljBTZtuH5DR432JAGw470VE9l+4v7JSn4kEsedRJXzyLiLorDRXT7LAtArOOUJygTgc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaVaAnIvYjTd2xQEoAw1BVA2N3FXjkYZ6U4iobU6+nSQ153I/l
	S6lD7rx3Ai7B8T+rZZSBeKv5+L5nb0sBiMD0cKhFAzMPbRD/NTnRYaKYjx34GtOVVNA=
X-Gm-Gg: AYBFou2SxmO5pia5UO6KpKsj/UY5A5vb1Pm4hBRUonQUvBdzGr4Ceoq1uuP+bo2JSd3
	KbzCpRNlXz2Ip6Ph5cGfFoodcRXOv6kHd0vb3R+R8eJ7vmK6O4ht093u08TGk/wQjrvoNvGxe0T
	iESAXxYzOAb7nqtB6XZkEd7ZJI+mvAeVr4idPG3fgB7KsMlwdB1Xrd1XgvTqow2l5R+2KFLmQqQ
	dJv2raahVX+dzZyvYT28R0SXZvQ6y5/lzryfJ6Pf0oI4gF01hYK/7220WSXKYqE8R3FL69IR3RP
	S9it+s/ymXkmoHc0p2sEjnVKAzArZKlVEiP/Lwt4/80beVI4FODifXZWIG8NWCSh014jZ2WWHih
	CcHYLx/65JaC2lagWwNQiUTSZrT+R3c2OstJJSiJ5lbQ6TKlC4HaMTbxHdyrwe03WW7cjR+xRKS
	x1qAFaNPqNmhbgNEiBcYv3wMOd5gJ6nKwLHwirdezR+hh5IPy9PLSlK9ApLycfuDC9mF0jmzhno
	ct+oiGmD8nvlvYz6sELPzPrNhvj9Cqpo2D8+8b2Hc0+YpDoIOtf/mE=
X-Received: by 2002:a05:6214:3b82:b0:914:48c8:6961 with SMTP id 6a1803df08f44-91448c86fb2mr22359076d6.17.1790419421191;
        Sat, 26 Sep 2026 03:43:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430e6ccfcsm36688496d6.40.2026.09.26.03.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 03:43:40 -0700 (PDT)
Date: Sat, 26 Sep 2026 06:43:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, peterx@redhat.com, jgg@ziepe.ca, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/mempolicy: use vm_normal_folio_pmd() in
 queue_folios_pmd()
Message-ID: <arehr1Z86Vp4gFPa@gourry-fedora-PF4VCD3F>
References: <20260912034833.2952750-1-gourry@gourry.net>
 <20260912034833.2952750-2-gourry@gourry.net>
 <aqpyp7ouLyxGhJDK@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqpyp7ouLyxGhJDK@gremlin>

On Wed, Sep 16, 2026 at 11:53:58AM +0100, Lorenzo Stoakes (ARM) wrote:
> It seems that setting ACTION_CONTINUE or not makes no difference.
> 
> This is really just a long way of saying maybe you could just do:
> 
> 	folio = vm_normal_folio_pmd(walk->vma, addr, pmdval);
> 	if (!folio)
> 		return;
> 
> ? :)
> 

You are correct, I will spin a quick v3

although this will hurt to rebase the rewrite series on.

~Gregory
