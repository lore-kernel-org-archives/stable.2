Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442409;
	b=TN4EM3+PY7AfiJ7FVsmoqMErE4gD9wJeILoKGT/fh9fNSkUqBnof329ogtobYLM0TSjP
	 zE0FHhQKcs7u6ndseF2RRfdSmOxvpRYN1Rd9aPeTaXgV5YTzUGMeGWcPvVQeKVmh11ETJ
	 VraiT1Xgbw2AVrTCCJN8ipmam13413TPoho1jR5nL43uNW6A142uYyud1i9PnKl9clsc6
	 dH5vJ9OinJDxkmpAtdtILGdhXekz1QTOytp3EHJ3OX4fABDDBpqA4ud2d9rnRBK5pMuZf
	 5ZC6faBKt1V56bTwS6qQktSkmRaWEDBCFfq75X8g4WdmjXH62s9ScIFVMsThPFbmgPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5TU2bw9dZra1XsKruc6sjmGSbXJI2gRuYiN6+oX/+4Q=;
	b=G1q+EUeMPbUV44S3L8pVuYcEMVbr/BZw5xYYBHBm/z1p9RALX0E0f8oO1zTqGrt9GqXG
	 CyB4COkuDfL7JUppSiuu7mVL6f+feLdivXwxj9LQRstSp4WPtKaqowYKZMQIhhVcmkhSh
	 IOqXVHjR6sd4+atnq1TMm3228vGsmx9DXD1c57BnMlKbr+BijNrsRTEUVbXy2Ucn5WQju
	 jUYEnYJCI77i8Y2rBBLj+kSASLtGlF8ONUzpozNc/rfLWJOL7pPCMqD5S2zUVaOtmpDl+
	 jo4UcyfGycu2FEQsKFq4j/nL537L5jiEx2Yo4XReruFbQFDTCe0CjlhPnuHcwRMXqJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="qh2oa/PT";
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46F606A319
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E46F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=qh2oa/PT
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-918f75a68f0so36713856d6.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792442408; x=1793047208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5TU2bw9dZra1XsKruc6sjmGSbXJI2gRuYiN6+oX/+4Q=;
        b=qh2oa/PTZ3nuizLJeZdLuovrOnJisLWk0uJSVXpsLqbBDOrGiyH72OnRBgcPM0Kg+I
         0OqnRa646nBH5N44EN8ednjw6EDcuf02swSwOall9HGm+yrT2dBaKiByMBUDCg7HtZLa
         OS1J9KzDEDGmtR8Ly4ZQI0WUvw4fcfYehIun6xJVnsGwmteCu8VO1bP2jJiJFFC08eH4
         V6FYj2voeNTQETB+hw+hI1HmtM3Ps/T/h8L73ZtdRribrSgxfmgZQSRz3z9Fo00vS32S
         xw2PwznSuizP1KzDUnZpgfeaR3bYkiBH2dj6I+l0oP6GK9tEFmD5Ew4YpMxmxujUv5Od
         pTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442408; x=1793047208;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5TU2bw9dZra1XsKruc6sjmGSbXJI2gRuYiN6+oX/+4Q=;
        b=Whb6ZDd9I6cs1NJr3OxJgap8T8nhMBt/eyXenpDvSolzX7pKB2Exc9E8jRB+Evz8wL
         wof0YE02r1bOAved4s135QloEZs4y8ohAP8choHTMMIbxv97DfA1DbbFGEnDt/5MBZMZ
         2JDWrd27gBNWnXdR3bBOxZVwcnmzQDnj1tXked6MpcvwvDoWYvQUPVJGBaEkdqWJ8+rw
         8HCA2fZJrRpSnLvzL/3zhP4mlT++XT1ABe4yiSordsTrF4nFmxr1XFrDMnTDIGfaoD48
         tgqHRFNBOvtdeOHxABOjv42HA4MexS5P7J3xpFFsXCAU5yGrqS2kjJH3B1HSmhiqY3Xn
         0pOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOFUN4jyP6erEXOWx/cSNocSDeNigx5XSx+JYMZRkg3u60sYQwOUdND6vIq1ZyH6GkyTXjTg4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGs99D8T6VRbSblSxbFNt1VxpKL/u+M/WBGoRdLC5ft9PFlO4e
	IVZ3+GF4EzOWbXN0K8SLtd4Lx4q9g2RHJd8Y119a3vXuhgpCw0gLJbehhXSh1dK5OJ0=
X-Gm-Gg: AYBFou1DCf+EB2w0DBGNdcbrcE+nFjvYiAwm3O5Qsn6wMTQqIQrNGeWG+elkGdqGNfw
	G+Jf3ydiMXapktF5XY33eVOGail3wgx+aZF9fZ+x3Vvl9zggHd1le7h+R+eDgFjMrZJuKCgoYN+
	6Y1W1xTgVwctAhqegE3HUqudsFSbnPLj2EhxNJsGq3Y1AJ+OviS/yWdUFk7Xr6AzLXaF60qUBI8
	Im7Ic5eqzle//fX5AjwtcArbUtTHRE3g7qlFzN2+efwSW9Cms/TkcTPBnMU7uyX9OtBQMjKkB7q
	aCNeqE1+ZT4/zgNheWPTdUTU220AeISuXYICYVM6hJs/JiOkZQkJ0IqDZivGLpb5r1M9hTQTO8u
	Ef6A6bAVWVwtm2vyx7uaR6HXRlqzxt2A0kdAmk9r0YrPPm6ZLVpSHe489t6fOIRoFgTRBvyMYDT
	7A3f3fXQLO8HRqcD0Xc7e5EwwXWn+ZDhemjL3IDctqGZtulD2MvDMu1sMLPmltBsl79b2AP46VC
	fYHsz4JnxPDrzNO20681Y/ujFLLhp6qkLhDclYqGlhIaZMpG8zukKY=
X-Received: by 2002:a05:6214:d4c:b0:915:eb0e:321d with SMTP id 6a1803df08f44-91bdf3fe6b1mr160127356d6.46.1792442408212;
        Mon, 19 Oct 2026 13:40:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040da11bsm5657186d6.35.2026.10.19.13.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:40:07 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:40:05 -0400
From: Gregory Price <gourry@gourry.net>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, 
	brendan.jackman@linux.dev, ziy@nvidia.com, flyinrm@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: let the highest memory node recover from
 hopeless state
Message-ID: <atZ8ej_zL-D_FIIt@gourry-fedora-PF4VCD3F>
References: <20261019184850.3427905-1-gourry@gourry.net>
 <20261019201321.GJ371161@cmpxchg.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019201321.GJ371161@cmpxchg.org>

On Mon, Oct 19, 2026 at 10:13:21PM +0200, Johannes Weiner wrote:
> On Mon, Oct 19, 2026 at 02:48:50PM -0400, Gregory Price (Meta) wrote:
> > free_frozen_page_commit() clears a hopeless node's kswapd failures once
> > its zone recovers above the high watermark, but only if another memory
> > node exists for allocations to fall back to.
> > 
> > The test `next_memory_node(nid) < MAX_NUMNODES` finds only memory nodes
> > with a higher id. The highest-numbered memory node therefore never
> > recovers on this path, and its kswapd stays disabled until reclaim on
> > that node makes progress and balances it, or demotion is re-enabled.
> 
> This seems to be the express goal in the commit referenced by
> Fixes:. Can you explain why this premise was wrong?
>

tl;dr:  next_memory_node() is not the right check for what the
comment and patches say it actually wants to check.

on a 2-socket system you would have:
  if (next_memory_node(0) < MAX_NUMNODES) /* clear's hopeless */
  if (next_memory_node(1) < MAX_NUMNODES) /* doesn't clear hopeless */

despite the fact that each node is the other one's fallback node.

> The patch in question also only added another re-wake event. It didn't
> remove one. How can it be at fault for kswapd getting stuck?

Not at fault for getting stuck - it didn't fully fix the thing it claimed
to fix. So this patch completes that patch's attempt.


> I don't understand what "having more than one node in the system"
> means for re-igniting kswapd on this one node.
> 
> Generally I don't understand what the heck we're trying to do with all
> these patches against the hopeless state code. It shouldn't be that
> hard, right?? If kswapd on a node failed for whatever reason, let it
> sleep until direct reclaim makes forward progress, or other frees
> (unmap, etc.) put the node back above the high watermarks (which means
> enough of the unreclaimable pages were freed to justify a new wakeup
> in the future to attempt reclaim against new pages).
> 

Zi said the same thing, and I agree.

I didn't want to propose that in a stable tagged commit, but if there's
strong opinions here I can just outright drop it.

~Gregory
