Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C44A5ED7
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567370; cv=none; b=Byh9JBRg3IRngIfppXSGKIkqKYbhpQ1mz/watZU7WRn00IE9M7ff8DFQSz2nJTPUIerTRVDGRVqgdUAW8pyqT0w8g8hIDmy7ZNyk02NQiKRclOCWJz5gSWZReG0YOW/jOSi7PvdbIsLNXzonVrbujyAe/INJKP+/LOCWTphnbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567370; c=relaxed/simple;
	bh=lk414wfpQrq5vp8DsPm/BTXmLqK0llvlOvGO27hPcTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzRwWu6aY8E7Eo0zv6QVzDY/ycW7aRIkOTy5vRr/RQNj3RgvvTsGuRWrb4ljAkd8jN7BXEGTjVDZ6Rveyn14Yf5H+4hYrjCfGNhCrBKNjyEDNcDDfIuqzY/vMXTyQgrsf9PHq9pJLHrbOMVtjo3XLkj3l01qJm//grPU31oWVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=D20xEvqI; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="D20xEvqI"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-939922847efso88199485a.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789567368; x=1790172168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QK04b22kulIc7bZXmZ0HJttAO0Z2ragkIvYz0XNFgzE=;
        b=D20xEvqIVoJEZfOuPpxfpBrh7OTkvZge2Xf+D6xaIhbZlibxC0E5elhiqMmvLhE0qE
         XgIJqyeMiL+BqQd5xnr26QgzFf00zc2dopCPXw7F+52dzRCohYDgGDrDKs3hv81LMBNb
         e2FJQYP+RAVxXWq8cqzD+mb8drq1isPAKltxToGYrIj5xmqF7+DZ8wUDElozbx4+qWMB
         FWMUMBR9Q2g1pK+09cUyiNtOe8anyw1nAva4Tgem4ThyrXpzmAkq9r0rnm6a1Kj6a/Qj
         +wOkvhKA/qPvaIE+6x3GktGmXQ9bCSJLuf4KBF0eGs0m46hEA2shaMoUe7Pdyc/39+e+
         6X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789567368; x=1790172168;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QK04b22kulIc7bZXmZ0HJttAO0Z2ragkIvYz0XNFgzE=;
        b=HvrvvA8K+LZgQb7UFwrPSIgWqlsV3IGq6tLWsPGGPAvc6772anbijEK0KM8ob4B/1n
         Djy1/c58zarVYiAVEffV7BSV2gGAWA/cKaD38K5DFrNk0bbBui8UMG/9yj9Wfrk9FVgZ
         RT2kvFgpHq3ZmAvaVFlDLCmprzkcSchywzGIvWdbWbPqVBBEG0PNsRuXM7uXoMkUcHdi
         YXDNRq1utVYHMSAx//E8N89lULWmLpPTeMYrRGwI9o579cfy2tRCMVSCpHt4B2KkHIlJ
         6AAoan47YFSPE7QZyBHepzY0lDYHFV0Ucoasv7f9KUOE11riEPbl6/SU0W1e8OvDwVAQ
         Cmag==
X-Forwarded-Encrypted: i=1; AKwUvByXqaMoeyVlkm1Pf2giINdGF68oyqMGGFz2s0dh5CPg4MGR9wrME/vj6q3uyA3iCcSj6O/GtAs=@vger.kernel.org
X-Gm-Message-State: AFuF++mFBT/9h6b1t0fSfdggqMnnl1kZiXpRF1OOL8FEIpGNiFQofAE2
	Q9brnpTeFQEOhkY1ZDrhZ5zxXek8uu8bW7NlzjY06zd7S4JSDG+ZuUNTyb3xht3b41g=
X-Gm-Gg: AYBFou0SkjfaI9OOPuKNN0wdGmgKMWjIrqzS9dYXNWJLyIiHtywVEpvL6nlmmiXgwST
	EcWvtvaEYmhTJPcBxoysHHf2H1TLZzKjHPoN4SJzcQR6N9SrL55EyE4/IX0NWynPxE2NXOmn1IL
	aWFlOnYwUpXVxB2tgmgNovHof7+jzXZRbRIaM7PfYJJ7hvjFdzMLEOlwnfZQ0+M3Y3hrsLN8Qym
	FShAQsnmc0qeaz55gzzDz4yxtpV4+7Xv77iPOpOwj1a3Kn4lX15Y+AsmbWhtOiJanZG+romO1F1
	4P5amFec/ceQeCEqqrvz94o+aWzJINLd/JJTLgy+cjZCoGqT9DFBmdLUIInGXpqOIDhRwQmpfUH
	ssJocb5AbAY+cNI+n08ZS9ocuBZAJjolKsDETa6jRUGkFh1ioMkFfNVLVFzVvSZ+xawxRrOW+5+
	9iun9WhMszY/Ggzam09UUYJyc+747I0U+u6D7LamS0vGJaU5RjMjq1QeQev995EYZ/M77WiwkeH
	JkO02jXiyGBa1Ic+aDYRvkCFLGkSWnZL4QQhq5NSJm9rwfL4K98saA=
X-Received: by 2002:a05:620a:2704:b0:937:19d3:3fda with SMTP id af79cd13be357-93bb785c5b6mr477815485a.28.1789567368038;
        Wed, 16 Sep 2026 07:02:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b780cfa78sm218545285a.2.2026.09.16.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:02:47 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:02:45 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, wangjiexun@tinylab.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqqgeOtYBcRdVqmI@gourry-fedora-PF4VCD3F>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
 <aqlzzwLOVT79Ti_7@gourry-fedora-PF4VCD3F>
 <aqqTtW3vjfzH8bcY@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqqTtW3vjfzH8bcY@gremlin>

On Wed, Sep 16, 2026 at 02:18:36PM +0100, Lorenzo Stoakes (ARM) wrote:
> >
> > relevant meme: https://i.imgur.com/W0N40BK.png
> 
> Content not viewable in my region :'( seems I do not have a loicense for
> that!
> 

google "reading other people's code meme" and find the comic with 

// this is bridge

:]

> >
> > No argument here. This function in particular is really horrendous.
> >
> > I think i'm now 4 or 5 stacks deep on the "Thanks for fixing a bug, but
> > while reviewing your fix sashiko found yet another CVE-worthy bug".
> 
> Yeah, I WISH it wouldn't do that.
> 
> I mean it's helpful to some degree and it finds real stuff.
> 
> But it's _where_ it does that and the workload++ aspect of it.
>

In some senses - yes it's annoying.

In other senses, it's saved me a lot of pain debugging my new work, and
I'm willing to do some cleanup on the way to new functionality.

Someone's gotta be the janitor I guess.

> > I suppose reasonable to say the goto is worse.
> 
> Yeah I know it's all a bit much of a muchness, and obviously my suggestion
> _duplicates code_ which is also not wonderful.
> 
> But the control flow in the function I think is a bigger issue.
>
...
> > I'll spin a v2.
> 
> Thanks!
>

Given i already started rewriting and validating the entire garbage
pile (see other response), mind if i just leave this as-is?  This gets
completely replaced anyway and i'd rather not have to go backward at
this point.

~Gregory
