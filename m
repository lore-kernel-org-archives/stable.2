Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F13BB10D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466800; cv=none; b=mVcStFw9PwBwygd1p9/Tut0yoEHZf9wW6CZpL2dNFVBrFjidGZXwB998Q2IulAH3xUDl/hIzgJz5VJeYUKdOX7XcIdm+XWJIY1GFtr3kwyl5UtkN8Kx5dwZqsJpgdcux+SDIUn4Kw0ZXsiRAaRE6jvROxbkx1a2hsvVedtPPJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466800; c=relaxed/simple;
	bh=9XEkSyx4rpuWC/zLRuDgN3PFQFALOZecikzTfjtec/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qcu1DI1Rfm6tPqkIMi73u0yvMk1wf8UxcOle8cMGdR2Gi5sxCE23FPfZTTzQX9QwfKN0FZi+WHtdltXcndBx0ex5nXSc3EAGoUyuhlsfbTMfJ3tedMtoMW6z0xu/FkkNFVe/BCtWE3mrdZcLSvHx0RFqiWa6wxLwfrFXcfKFNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=hOVShjV6; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="hOVShjV6"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-915b5ce94c7so73485985a.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782466797; x=1783071597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rbYFlDOdrRKL62BQTd9+XWo+imzEYyLX5XadmB2EubY=;
        b=hOVShjV60QH/eoDP8knLL7NSLULzmaWYTo9I+DNSVCI6GNNNfwS2izxk8lml+MhQz8
         08Hj+zFhXkXNKGID1+P8Uzs8H+5hRBZ8JScyija1mli22sYmy6o5WoKsjTfBpZXIDKNu
         g05svHcQFli1+lJ0c4pxhaTStLREG91gj+6RX22HGVErXF9pu+wxj+4TRtetsAoghHIL
         Onpss8D3UQx2G4mV6usvf1ywa2f2xakXfDhjgb6uPXyxFFvilboDG1VyZ8k2stmhRne+
         uqSngmzU9aP7DLIuao63USjZuKHaPc328PYDhJqw1Ue5DYVdNTsuGA5CkDSKAQL82ish
         uUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466797; x=1783071597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbYFlDOdrRKL62BQTd9+XWo+imzEYyLX5XadmB2EubY=;
        b=F4OZGrVB3KY9jO+HEuj4EJPrUj7Kba3pY8JjI6mNQdfuw2G8nUwZK+2DaRGBzaB6rz
         wjp3zK4NhEFxlqawYE6e6aCcknORnneUDJp9pxkaGzyl1tn+JpuwVEyHBLZ7Jy6VLhZx
         4rIrHjq3whzwDhiNaHvuJcTh62sESLxQQQbb1Yu4IvDe6WGjx2uja8zdlrxVvGA6OZNN
         ibobiKDGshRV3XEn/HesXSzlvHR2ChDXIOuK5eKAYdrV5Px92ewCnVGuD471LETJ4jaD
         D4vQBPGYzKA7LMFsvQbewn7HSVX1G3W7OcOXPDI3hjnq3sSvFDNetyVVGnXKblFUnsxb
         FFwA==
X-Forwarded-Encrypted: i=1; AFNElJ+7QY2lop5SD73cB5jcjhz/WAzjoh5/xfr3RL3ZD4LZrKeci76pVfXxQM3k8XPyG4FNUz6iGSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLtOplmg17nI2TkGxPL9YmfPFXFAawdCWRiWyfxLZEWRdPpARN
	tpSctBHTSYp4JZNt5eXPa42+e7WsoUxpImEtW5WveOv2QeUl8JFGpAH9vnK7Jrod84I=
X-Gm-Gg: AfdE7ckx49LedSqol6UzGetxErH0hHqK8U0vzwfT72fnaOd1FRfeNCZBexAqpX5Odq5
	wDLs6xKsJaq8ljtW94LIVR5I+6GV4Zw4+u94qBfQQ8+jGxLQx8lw10HhjoG83CQnIVAYybU7N0Y
	c84+7qn0jB1NzUbNoIROI4HU0tbZR3DPZzdLPUXxKvfxFDNCgPEMEBUePWIa1jAhC/jrrci5vb/
	QQtmm+wWMFhGheEPP6pWl7sp7SIgcA7YFkYe8KWzBkgmO3eQp4H0ddJ/pIIUGs7kncTV77QI5SB
	De42ycIM4wa9PIueP4cv7rus13axM7k92/f7HLY6WGusosgwJix6sXNb4OBESJ8kVzNFpjO6oBD
	Q5B6BYvQxUZfUi+9l4ToaIi85O31mVNYNPGq1XqM0dgee/JB4Fc1FsY2qC7XZlmSfUq/NvHfTvr
	BK5QWHtdekDRI=
X-Received: by 2002:a05:620a:4056:b0:915:8f76:8005 with SMTP id af79cd13be357-9293cadf811mr996276785a.47.1782466797609;
        Fri, 26 Jun 2026 02:39:57 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd391b22sm1107164385a.2.2026.06.26.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:39:56 -0700 (PDT)
Date: Fri, 26 Jun 2026 05:39:56 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Harry Yoo <harry@kernel.org>, akpm@linux-foundation.org,
	david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, muchun.song@linux.dev,
	peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
	roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <aj5I7JAXWlTHRyEW@cmpxchg.org>
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
 <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
 <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
 <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>
 <5a0c6597-6b96-4781-a71b-fd1298b2b7bb@kernel.org>
 <c0e366ec-ee5d-42d9-ba33-7c630660e8af@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0e366ec-ee5d-42d9-ba33-7c630660e8af@linux.dev>

On Fri, Jun 26, 2026 at 03:04:17PM +0800, Qi Zheng wrote:
> On 6/26/26 2:48 PM, Harry Yoo wrote:
> > On 6/26/26 3:24 PM, Qi Zheng wrote:
> >> On 6/26/26 12:59 PM, Harry Yoo wrote:
> >>> Observing a dying cgroup should be rare anyway, it's worth focusing
> >>> more on readability?
> >>
> >> While it's rare to encounter consecutive dying memcgs, it can still
> >> happen, right?
> > 
> > But is worth saving a few instruction in a basic block that is
> > unlikely() to be executed?
> 
> I don't have a strong opinion here. Hi Johannes, I'll leave the decision
> up to you. If necessary, I can send out the v4.

Yes, I was thinking what Harry actually bothered to spell out ;)

The race is rare, multiple levels even rarer, and even *then*
mem_cgroup_lruvec() is a quick inline.

This way you have one block to handle that one rare race
condition. One place to put the comment. No labels, no goto.

Simplicity wins :)
