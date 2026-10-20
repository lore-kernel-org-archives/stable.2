Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517312;
	b=vf6LX6Nm/Cb2t0rp4ATyg9q6PVm2v2hNMgzKQG111P1SuI/7cquSn/37z8TRQXnd6md1
	 Q67WFGnvFXA4qlcWukyPankvgAVpBVZjDXaQB+YF/CUMfAYuyXHek/dXGIbH3W8O9QLLc
	 q4WozwM2mWvF2lzkHh45JskV/BqFge6k8LzA/Z+DpPWjBsj8XsrQozl0/gc8A07XxAzxa
	 aJiG2WF1bCgtJX6jzxcVR4ZpwUL/B5qdvVM5/qZIkoaz/S0qvtrwyPFg1K0krN8W/wZIE
	 ixCVumIosX0If5uk1d86FL0wEELVbS98cOFmL4bU26vsfmH0vEZviUx4yssQRgtUr+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=xd2xn7InKp+SrI7s/BHBhFnK8Dcvi3AeSU04cbSblZ4=;
	b=LU8GD0BXuegtnQIAWYFw7A+Z9Z/jUaq22jbMg5rstjmD2EWEyYroJTbFULlz/6aiA8wp
	 LX9IjY5SaP4mQx+9Cv8WNsbvjQREda2c7cU92unmrVHpvOi3bZLm+YJ9Ki78jwTMCJGEu
	 otY/LowwZOQJRqLRWh7/Fuh6OcB+UkT/HNF+N3CmecpwMOBlcR7Q2BGh8oCap6rYr+AVI
	 DCVhQpHrd2atoX9sPh7fHJ3gyQ+8N+YA/Hyxqf29je2nw8ONPKWlE3tNCpNH1xigPLTS1
	 XqiJoQlDFO9QIRAn8mmHJD0lFCSGk6pfzXh9B2/AfZU8mqdoRJp07e5xhTPdVSiYSuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VqsPYUNx;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B66606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B66606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VqsPYUNx
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91986c5cb75so36577726d6.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792517310; x=1793122110; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xd2xn7InKp+SrI7s/BHBhFnK8Dcvi3AeSU04cbSblZ4=;
        b=VqsPYUNxILRhN2J6f0RkpSt9C41C0GtOBBGNy9lUh30TaoJ8cFmYnc4f7MV8RhbUEg
         fjNikbxz7aba+FIbwa+l7rnSgJNEIiL6EIH59BHD65xXEDP+2saS2bc/9Kppla7eH2QR
         LeqYrpotYAE/qFJMi7bLoTf/UX9YXThgcevkEAuelTTxdmRTq0ylvTmIYshex3BgAOXZ
         O1Dxkk4PBQOqS4SeRTBfT6EAuuYeQ/sJpJ0rmoC4hRvvBQhon0LNYlzYQNSTZYSlI3bI
         T5lLrq0bUcbca3AocUjYu1NJMofNMnrRn1vt6GVLPEQWt2HlcUHgUcWiEif/EQZhl4cL
         VR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517310; x=1793122110;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xd2xn7InKp+SrI7s/BHBhFnK8Dcvi3AeSU04cbSblZ4=;
        b=Ht2wMfLPV7LY+TV4wdjij9R4o5UA3T6eHTpzJ2dV7+/P1suvkEF2yF1RXXhMiFN76j
         +eUgyPyJNRORpElvz1molEkddSHR2IIO0fVDRmqMWhaPVtHueAdIMFywAQAfiakDC3Ss
         isBR11ZN3hYJ9NO2NAIfgH3r1YmRU8h2HA/170rGmxIv34gBUuR9b93qw/bpUlRBGj3R
         maXupIiNUOg8uGu1ZcwCoMzQwIBCoYpJsSZCMkEzOwoEwZ56imHUE7jRsyvL+CdSumjR
         KeNqT+6/PPGCIdjoY2rGVS3pskC02+bDvovVdE8SDxjcQLTijPPLOag18b9ZGjwT0VtE
         aWsg==
X-Forwarded-Encrypted: i=1; AKwUvBwJM5Blj17f+JqFZvUrYOUos7T46bKcJ6Qyx+/FOgBi09EdTAKuLg0wA6pn1g9mTXKqr+nI4Kw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU/4W0lRw1GZxYqdbNOZ1iKP9f3LT9YT1ibsSz1RAQHLlxtybC
	wwfWVMq8OVPv3pDXukEwW49wG/KFB1v5RJ5i03s8M04hoKR5SsLcWImVOOTeL1WHoNc=
X-Gm-Gg: AYBFou2XHMq1ObhXQmyyCRg2wdgZhYMcgw4Yz7dP/8MV0cD5KtATnEOIHoUqLDyUI+l
	enys4qMrCT2bdoxsBNtGmVs2h/ocuBDPIDUP9eakO0luDNT8yOaO0DqP7yYoIoRDoREPdS0SOg4
	bcljdXDVDMa5ukXiEWjvyE9yYVY1bX2vs+2W3e2d9b+7tzE3IZj64gtZi208I5sSo3jA9nUZvH2
	mb6gMxKdnMj5osb1HoqRt0BeBcV7kUpFMEm+fgVv49dbVQRYfxrM9cHSQdfU79JJRgoZtSJkVoD
	2oD5P04clzNORY4T83DwSiYktyltWB7EFhcAHv1g2gXKUL2rIS3UfvEHS39RdhdfRw7DhHPTA/0
	4mHGUbjYo/zpU/n5O75RE3Md5SaeOyBbSF0XunJ7TLif2VwDiB4vxs3YdidgQUpNunwHcVjlMrm
	jYRSlVh0J6LnyCLVeQ15o3KT8lUuc8wGdJJ9xia7gICp8WdrW+thnIy4egBDfKIb9AD+UkzrHkj
	fqpLp6JyoAiQs/b61lTPTSK/AdIn749pmRq/n281gjHDDALTW+mclxx
X-Received: by 2002:a05:620a:44c3:b0:93e:c12c:9b70 with SMTP id af79cd13be357-93f29df45b9mr1944842885a.75.1792517310522;
        Tue, 20 Oct 2026 10:28:30 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b72cfdsm3288526d6.12.2026.10.20.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:28:29 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/vma: avoid broken uffd merge on mremap
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, shaos <shawnq1@163.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org>
References: <20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org>
Date: Tue, 20 Oct 2026 13:27:36 -0400
Message-Id: <179251725685.2936366.12518786742522387392.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-20 15:55 +0100, Lorenzo Stoakes (ARM) wrote:
> Userfaultfd often causes unexpected interactions within mm, and does so at
> the intersection of uffd, mremap() and VMA merging.
> 
> When an mremap of a VMA occurs, copy_vma_and_data() calls
> mremap_userfaultfd_prep() to notify uffd of this.
> 
> However, mremap_userfaultfd_prep() simply drops the UFFD context for the
> VMA if the user did not register it for remap, i.e. didn't specify the
> UFFD_FEATURE_EVENT_REMAP flag.
> 
> This is OK for the VMA itself, as upon page table move, move_ptes() clears
> UFFD page table flags, using vma_has_uffd_without_event_remap() to
> determine whether to do so.
> 
> However, this doesn't account for merging with adjacent VMAs, whose page
> tables won't have received this treatment, and thus latent UFFD markers
> will be left around.
> 
> Worse, it'll break UFFD for any VMAs it is merged with. This is very
> surprising behaviour for a user, who will then simply not receive UFFD
> events for VMAs they ought to.
> 
> Resolve the issue by explicitly checking for this case via
> vma_has_uffd_without_event_remap() in vma_merge_copied_range(), the merge
> function explicitly designated for mremap() operations.
> 
> Also update the userland VMA tests accordingly.
> 
> Reported-by: shaos <shawnq1@163.com>
> Closes: https://lore.kernel.org/all/20261020110748.959870-1-shawnq1@163.com/
> Fixes: 3cfd22be0ad6 ("userfaultfd: clear flag if remap event not enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
