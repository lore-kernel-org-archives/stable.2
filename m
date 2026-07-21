Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27F33F594
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638934; cv=none; b=r6A4AeoJH4mhh3d6kcJrngEwk4FJXXgYH3MavIv3OMlVqQEhOMp6CmoBVXAlB833sgMi7r7cXAZ0g+Z3FSFoNX55mHtcgw2SO4n3t9CgjfbOp7QYs3jTnMIlimW9mNfIV6gnS2RFmkPFgkeZqmNDLBfdLPkbAQ8n7EZQQ8ImK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638934; c=relaxed/simple;
	bh=+DCrHFLSoW0VYsNZrSU6mj0mZzAaljdKnrfDGbIg4pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVWBfXGUoMZ8GVgxpQZPL3baj1qfPSieiZ4/x1W9wjKF7csp8TZR45hyxMqtkDTdlmuZtTtcwQtSHzd41/YHud/r0SNhSuj8MN/HUVIkJcZ97f65CzXhiQQiFKNZdxs0lDegNDZpD578WCjJbsIoOdeSNcZgT9T7ajfV1bXYzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=x3SnENyN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="x3SnENyN"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso6532747a12.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 06:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784638931; x=1785243731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xj5Jk9L5vRk00naBBfj1xpmzt1sYizYOkTxM4/R0a/0=;
        b=x3SnENyNx2zWVsQYe0z+GEOyYXMxJ/pWAohEkrBkyQ61dQMsTUzr4P/d2inciBG7XJ
         ij+C/7DAmF++qHLvBUk3c2mi4aNR8RbbNCc+ONZOzoNn/wGnJawz7g3n043vhSPoZ6Op
         68gAbJZmyUnXrNSQacLILquqfBw1xZsYRgHS1gjNe3CvtPCuSJ8FnpiL1V9AGv3FAZIg
         zYVfkHiixuV7j18YY0QKUVS7t9yoqzfhLb6FH9f9G/7rFJYE2dlsOJXHEACuy9NXpW8a
         lYNXRuc36H2v+AP4YVor4tnFuDN/lgWPy4plpKO6FdZDVTy8oU3zUe8PkfGGfoz/Vve3
         HzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638931; x=1785243731;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xj5Jk9L5vRk00naBBfj1xpmzt1sYizYOkTxM4/R0a/0=;
        b=KpM+XadqyNeegKRTfBrCMsY5VrDSyXtQ1VjCwyjH/4eIZmDNy6+1/JOJKVaRlfKSYl
         U3eYFcrVp0Z8SWuUXn2csr1JDL6FWGA68ERWqw4lYe4tw+BK9g+jcjBY3dIupjHXVdba
         MwVVWuDuLy/w6nSY5wd4vQSTIkviaOUprS6z+jo5vd+jnp/+yJQ4nu1GMy1vsP9sBHCy
         chSci2wRbgiPICjopRRHoFAfnC2vOoThL5h2YyDgUeVPgOFJ/Wf1IOOjnwdVtayMnKT+
         b7O2TqMNgCbSbHOPnsI8/oEkqTQrc4eF8muYsEpdJiEkV6LEuthW2FktZoTZhvsB0Fov
         moSA==
X-Forwarded-Encrypted: i=1; AHgh+RoS6KOuvBpoJ899K6CUd6BfO/IJ7zBjUhQjbfCl4KztFWGtLT9+gquXsdVtBixOBX2cyVHMCqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtPuJyCxXjcIt0a3xO7qfDV6Ekz37k70M6r3i1RkCKJnXsrx9
	NnZEFphqzmE92/2E+mm2xHkCl6/S9LBhxvvJyWAfbwyl7uWU4dMrZIpo3I7AgiYgHdg=
X-Gm-Gg: AR+sD11xzAiGVeq7fyP0MduD6MVgYIvC3IyHNma76k69ORNn7p4XpP+IbjCyZ0n7Qvx
	5UtNtW0bmxSd98atoHDIBbO1IB97Nf4F94bq+BPBKW5CL34vxEO7JYn2J3ttR9ejyvoCFl0ecAu
	hHzozfaMFRPvaSM0oNNwaHsXc8znpdd790bFnVsL3YfK+btGhbOGIku+INXxRpszf0yEBER4fkA
	9MG0jIpQ7TmTRKt7Dn1OT0MqDcVEM1CmsH/X0mAX56+wwgS5K3ff4OT/wHLVjcFNHbDoxabqQa6
	adFaNninRRAzX/biw7wc+R8ygb98UByjgSPUSuTwDrTzgoLwRFka+L4IxHE1IF140Rua/VasUC7
	hPwSSG+zDciWWyzlGXambsUGtp7zCoGqPdRz5zR8c8DsChpSgVTYfjaJ1iUBrCjXeRfaRDOPcvA
	s=
X-Received: by 2002:a17:907:9625:b0:c15:dd1f:f2d with SMTP id a640c23a62f3a-c1692413dd8mr998381866b.25.1784638930437;
        Tue, 21 Jul 2026 06:02:10 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26c8::3dd:26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c185c59624dsm581676466b.62.2026.07.21.06.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:02:09 -0700 (PDT)
Date: Tue, 21 Jul 2026 14:02:07 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH bpf] veth: convert frag_list skbs before running XDP
Message-ID: <al9tl_YzWmPXGweT@matt-Precision-5490>
References: <20260716100605.939654-1-matt@readmodwrite.com>
 <87jyquj5wm.fsf@toke.dk>
 <al3oXdjTYM_PziJp@matt-Precision-5490>
 <al9Q8yPOfQIVxvp1@boxer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al9Q8yPOfQIVxvp1@boxer>

On Tue, Jul 21, 2026 at 12:58:59PM +0200, Maciej Fijalkowski wrote:
> 
> Hi all,
> 
> I had an RFC that made veth to reuse generic XDP code path [0]. Jakub
> commented we could have a common pp cow check on both sides. My plan is to
> revive this work as this still causes page_pool issues when AF_XDP is used
> on veth.
> 
> [0]: https://lore.kernel.org/bpf/20260509084858.773921-1-maciej.fijalkowski@intel.com/

That sounds great. I'd be happy to test out the next version.

Thanks,
Matt
