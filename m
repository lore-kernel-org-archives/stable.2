Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2B33FE1F
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414303; cv=none; b=ENnntIek+szEmBtRBLicCbo5NtjkrkJCjxzDi+EOwK5U9ongVr0JMzfoiQLFZuPqR4ZA2QE7ztcxrCcfEyo1/1DQBD39jEzcpqP9btQpoWkjj/ZwTXonnmq7ofsjisy2gYW6gmivu1euMB6AhOY+fNsnLZZpF1OZFdkvUFK8+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414303; c=relaxed/simple;
	bh=iDve+N7evx9jp1p8KAV3wa7ACyFp1aa94T4I1qIEliA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nInmF5Rd4CjWXUMZCHC/1NcM7/ImW92DYpxqtZwYsbqw1gwsYRKsywh5XTemKLQnC4tTtItE+KcdqMPiLRs6JHmd6r9R3orIwZ/Q+Flyc63sHAce3/6dDobHVk4jKYE2M2PEgFghfRahxSdioNbzrzuDBQFhoApnsoDKk1Avgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OJUPU2hW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KqgoEHj5; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OJUPU2hW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqgoEHj5"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id B69451300300;
	Thu, 30 Jul 2026 08:25:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 30 Jul 2026 08:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785414300; x=1785421500; bh=TAiqma776F
	L/P3SaZWPcx2a3Anetpae5V1BAkLGVlLA=; b=OJUPU2hWpCJowcA7SWryX1STxk
	fHDL119iDWSlbL7WudxX6uuNkBVdDTnDv/rUhfjUZs+0e6RugKGuo59g3tUd6b5M
	EaVT4CdHEKRd5L/ex+N5qdn926Jp86iBYYurqv9yByo8uOnseyonB8BW9ejsKkW7
	Qnd+VvpNAQJQiaboyRk32DzuUKHHSKJ2CFQzJKxh8qnPZv/w0R3eVj0brrPLDjfg
	rIhSBvLZSCxEkdouiaJx/l1dlcNRqX3XSuWIcOqJeqH+QRhpy1b+Ef9Lyeg8OzPQ
	NqfOYWSCYE2cujo/U0YzEzIo64ftpw8/VuymBaTWHeKQ8YWfUq5HLRNYVBuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785414300; x=1785421500; bh=TAiqma776FL/P3SaZWPcx2a3Anetpae5V1B
	AkLGVlLA=; b=KqgoEHj5gcXDL6NVUtjBTovSFoZnZoJjcdWnZxSrVYttWHrpxRN
	fQKJpmnEbGyrKC26UEfAxXnlEtTK8bFF/7S5I2rp8LvP8GmuWC/jRcmA89BQ+azQ
	uXkAyS505sneLkrWPHkyT7qS+wmDcgabEUATcFIRrM5zdTshw0L67ZZ9++KqiPTP
	6+faVqEewt3h9FQfL0tXjBONefWV8J1/aGqVo+FArXaQ3afSwOURuVUxhLgsRg/S
	y+qRyjXmfzqmy9ZhxTn5d44GF3N7vES76/hqq5qbgc2QkpjQAkEPdiU7E/VNk5zh
	Beyl6RT2cCSoL0yXES1ZvpD30KQxYDgjIxw==
X-ME-Sender: <xms:nEJrakhUEOmsHgckjGkG3gkLGcDzNOJ4b4-vgSUQjnTpPOt9GYvRoA>
    <xme:nEJratJyFHhlavrn19hHE3oRd3McxRJ9BZNfT3qLfJActV7C9TAg5BAbDA4yt4T2t
    zVjiWEOkK9a78yU84lYdbSAn1jN6M1vPmr75PJXjmVzDV8n>
X-ME-Received: <xmr:nEJrap7tS3C-wabEmm5t1z-rImuqaKx5QRrPn3rIk_fUzN31YaAV2TejwcVu9KoAXHrKLLRlcgrO55lhEoob0f1n_5bTttLgJUNt8b94uTk>
X-ME-Proxy-Cause: dmFkZTGBdzjjPaLZ2A47ww/7lq9fTuhxRaaXXsbm5r9/DqGjIiUp00/irxn0+F4RBtYnrz
    NPJxiisPmARvfktcgSjCYrL1PXWE8s8qRRD9yuI4j5XvrXGGZVPyXoek+VgJvoFQT8oGMo
    Il1Etafk5F4GjEhPg3j6+UP8IVBcZ3T9C6VEKOQNYv7tMer1J5sL2AfYjANmSIvNulDKyQ
    0rI7oBRDNUrKwG0u7qEZTN2EiYRKSCK12k1s3li1YVV/290bfLO9twNd9PGOPPiTpQOA3n
    Ptyl35PrhawVahwTD3FE2HM1vixUSS7apQV3lptQRbVrb+GmUktthdKG3LSWJs6O2RrDEq
    fuzkH6IDerXqJBuzESIBBLltsAHkqpeKdC9Mrrl9hTvSVof4SpK/D+1nZCc0F9HRW0gQ5Z
    BZsPiikcQENaaE6xbZBX2jKYE+BNJQnlTNYalGtJdx3R9kNq/5dzXhKxskGP3FjMW9x2IL
    7r+Gq30akdfISyDh3AiRvPCYDzCwYpuiBeCojrUDi+KBEWzcWoZo1B97NS5sL/UBA+KF01
    QLu+m51707TollnNYvDq1n+sC9i2OpH5ERIerOng1jrgSATxQCpXxGyNRM5N3GlRzOZlAU
    1DTmcX1Gm3+RMFtuhmdwZ4qofcR8Q428JirUVclWS7txJXSlegCaPevvcEFg
X-ME-Proxy: <xmx:nEJraphfba323O8yD_GZrfDsBiqCUOZvn3m32Ufb-A6WcsQIwbLFrQ>
    <xmx:nEJrav_xrWXhaudvyqQA-VtdzGCDymzCK4Y22BCjOd2N-qS2MPm2gQ>
    <xmx:nEJrajcXFXtu2SZntBlZcAgxfdCSGsBSbXuwIfSzSQkaOxHggDij2w>
    <xmx:nEJrarly_FZhiPichsd-8vqOX1dC-FsMPUw9ecBrOlkSpmuOjQtoKg>
    <xmx:nEJragAcPtbMLLhzf_mIxsGZNAHNrHMjgjU-bvoQ45EFoQwG-DZ1Ay1g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 08:24:59 -0400 (EDT)
Date: Thu, 30 Jul 2026 14:24:46 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y 1/2] mm: prepare to move subsection_map_init() to
 mm/sparse-vmemmap.c
Message-ID: <2026073039-tag-sabbath-ac64@gregkh>
References: <2026072034-plow-sliceable-b741@gregkh>
 <20260724164505.471020-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724164505.471020-1-sashal@kernel.org>

On Fri, Jul 24, 2026 at 12:45:04PM -0400, Sasha Levin wrote:
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> 
> [ Upstream commit fead6dcff83b02f8d6dc3c1ebbe4e09c05c54ee5 ]
> 
> We want to move subsection_map_init() to mm/sparse-vmemmap.c.
> 
> To prepare for getting rid of subsection_map_init() in mm/sparse.c
> completely, use a static inline function for !CONFIG_SPARSEMEM_VMEMMAP.
> 
> While at it, move the declaration to internal.h and rename it to
> "sparse_init_subsection_map()".
> 
> Link: https://lkml.kernel.org/r/20260320-sparsemem_cleanups-v2-11-096addc8800d@kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yuanchu Xie <yuanchu@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 721a73e30c9e ("mm/sparse-vmemmap: fix DAX vmemmap accounting with optimization")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Both of these don't apply :(
