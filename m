Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48E49B450
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573083; cv=none; b=RZ/TSuTaVg5u7BtOsjl05qg4z96pZf6gTj2IuLmngKj2mWKTNB8vNPcFksvuyp2MUSy9cDJ98I7EUK+Vx7xyLKHon0uYXTLrz7sgVdq36f+Ja+nHitqtR1V/qXjPo2m8qH7tdsAygUVL8Dl1wu2FxWFcWUQgyja+0FUYSoaQQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573083; c=relaxed/simple;
	bh=MSZm3L3WgvS/uJlzKYruSiBeiKAhMp7kcFZ+8BvZD9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUK2J7HR89yT4DNJGjz1QEqL2dcpiWd/Ft8H1CvurnnbKLYY7/QKhVyPZ+X57b/KE+/OWvNwM9G7/bTWBikdGGSHe1UOe3WNUIqic3m1dAnNsYiGsqoyFA6DYLWXsas9cJjSLPdWbQGgAT+aD75RzAVNpR9JVEFqU726hxa75c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lVH7kz77; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lVH7kz77"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76bcb1fso9950741cf.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789573071; x=1790177871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yrYalls8fAkvyVlQP9FlmP4RxEorGFK72anR8WExHtQ=;
        b=lVH7kz77hihe5ypICQsHpzMV0gmdhgnMWDxPSnat6p8LoLZoD0peFsMgsC7lrVs4Ik
         WRGJt9zs7PWX/FzihOoaCp+CxDpROSMhHhfwlxOBLQPdgK/xlJE2Wul9UigMRQV53Rqs
         nESg6VHg1fq90zHyqiVDsLEKGz6mbyiLJqxbEz4cPGDNP6SeDWjMxRMSmRLshEfuU+dx
         CBH1LaPUTGjc5vXhlZHM6mP6IKOksDhLzZPg85D7k8JfWI+CHEuZTydHjLuR2hB+V44S
         ov6llVPikUwNwOjVLHVbuLVcIJdmC2XHOPsIPt7DG/RWF9cQYj+X2Pb8O3x7RGrdvt+p
         xyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573071; x=1790177871;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yrYalls8fAkvyVlQP9FlmP4RxEorGFK72anR8WExHtQ=;
        b=wigV/tHbJw72wlpDpQjf4VE6EqmGLABVeYZHhTkNy/Ut2V/aIXt5+vvkyxa/7VS3+x
         b6aKLGIIH+JBh5jkctp7Z3Z4lHpDfc7Sc8KivM62eGubYGPynNeF+FtbsRvSL+JW2UuI
         EDb8STX+UvoLONmRsNTRiYLr4yfufF82k781A3+t+9eOzwRHDYRsmv0qh2GScDUI7MPg
         /VsRrBe6NwKWp7kgwyakhGtmrHXZJdZItor0D4hSkTS04L5hfG0ZOPM1Tr5gWGMnZ0/u
         fbj6Vs7zLTd/IM8xKznIjw1cCmrzS/6mZmrtdUmRuu5LDiv17gvORgePQUfdNO/IVHOE
         GscA==
X-Forwarded-Encrypted: i=1; AKwUvBzDr0IOUf/3b+B2Xt75OimohUL53LjmrJB5HZPR2H6XdaRFiW1K3vGXp4zU7l0A8a6wucm5U6w=@vger.kernel.org
X-Gm-Message-State: AFuF++lHVmas9M95xCC8C6JZfsbaA17Vv9FwK1/TFUqX06Y93SpFSD/y
	srx5TkD7bHV7vKADN+Ndlbkv5lfZ7DQz0Mh6Z8KBd62pEz5YGTJTUHaTT/ek5oErA68=
X-Gm-Gg: AYBFou3JA6TYnWqolFSRd3D+9LUKnGhLyz5Y155pPqQJQb+se5qG4qrytqdgtZm/d7U
	cEQD8Dc2rAQcbel/zlboxwBtrhi1Adg/FSmeAGBAtQGH8S9zvWEk6h3uY6Z7EqOE4YRKGLAwmKU
	wLSHJbfAyMe/Xb4IZ9bpgs04Pe8egMc/oJGBU5fMEdwRBR5/4PemOsOtih8d0uQEI6G3IFQR+D8
	7EgP8VSIwp7MmF62c2zd7BDQKGxFyGlmryoMlcVzlxE5x0CKQcu3jxMfAH5PpGUK2/9eOsYs5qV
	BJNHToiW8Oq3mEutebj5MwAjVXZKLoJN+7o7MWg4tYNPop0XzcK42xDrsjHuX15DbxM9EqT1TVU
	Ues0shFuednbyrPzZoicxi+rj1w0zNsCtoq9FsSYd6CL59At3seVBAScRF6J40iafi7QpiS7ccc
	21n/JqmPhR1DLusQW9+Ym7v9cWDryvKCgkknTvnED+r0JeqksxvHI7imqXbIjjwLVMbbegJ5JEE
	SQoI2EYcf8N5yqqilQLaqnDPv7IUU6D/cAEqmVw7WPggGv2kXoOVE0=
X-Received: by 2002:ac8:6f0d:0:b0:530:cbf7:6bb7 with SMTP id d75a77b69052e-5327f201bdemr54089991cf.49.1789573071567;
        Wed, 16 Sep 2026 08:37:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53262024a94sm24407431cf.15.2026.09.16.08.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:37:49 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:37:46 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, jannh@google.com, wangjiexun@tinylab.org, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqq23i9824-GWdhg@gourry-fedora-PF4VCD3F>
References: <aql65IhMobL5Al9B@gourry-fedora-PF4VCD3F>
 <aqqTbGMJL86TzDrf@gremlin>
 <aqqbB_nFAOGenDhy@gourry-fedora-PF4VCD3F>
 <aqqjW5dpyznijYLh@gremlin>
 <aqqk89oTigJ9LS2N@gourry-fedora-PF4VCD3F>
 <5437871c-d9ee-49d2-b24f-965c73c29c3e@kernel.org>
 <aqquDtEZL1ndymGN@gourry-fedora-PF4VCD3F>
 <46d923e6-5724-4df6-b0d5-8dda7c547f6e@kernel.org>
 <aqqyhkZqcXDUrzeb@gourry-fedora-PF4VCD3F>
 <4fadcda7-d96a-4cd9-9b0f-5d387b6f82af@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fadcda7-d96a-4cd9-9b0f-5d387b6f82af@kernel.org>

On Wed, Sep 16, 2026 at 05:24:43PM +0200, David Hildenbrand (Arm) wrote:
> On 9/16/26 17:19, Gregory Price wrote:
> > On Wed, Sep 16, 2026 at 04:59:32PM +0200, David Hildenbrand (Arm) wrote:
> >>>
> >>> LLM go brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
> >>
> >> No schlop like that please, I don't want to hate my life
> >>
> > 
> > You missed this part:
> > 
> > "I'm trying to be careful about not causing a bigger maintenance burden"
> > 
> > I wouldn't do that to you :]
> 
> I just wanted to make it very clear that I don't need another schlopped gigantic
> patch series in my inbox that I'll mostly have to ignore because it's
> un-reviewable ;)
> 

I would never :]

But *motions generally at madvise* if this isn't schlop i don't know
what is lol.

~Gregory
