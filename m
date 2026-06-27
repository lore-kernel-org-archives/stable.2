Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FFC25B0A2
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782548640; cv=none; b=Cbj4tdW5fhclRY7AkapqfSW91PxWldJwAsHI0ipZYFR5zpft/QKMavUd4rr/CUpGLTSv7m/sf6TaPJpGjDAr+BbgcZwJDfUKTBRREGiKCkmCrFWGdq5d28uuBv6PGc74mYy6v4cOWBlRV032Ror/NywhPMfsUz0QfXI8fpNKThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782548640; c=relaxed/simple;
	bh=pHyJuhYl/jaNnPl2SnkFl+8Jum7fL0oJDja08WRHig4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2p5iME+ZsSh7dC7BRKhLIPpyN3ysDtTFTzcJVNn2++FAAH9YLljIEqgAJyIZo4q2KmZ1CAhcKTezqPfpnaS0qWjpFyAQHoiYlUNaSTzNuAKrGV9to/MRQprKMkwey3F5OAHk5vdLKj3owuT/iqAJ1n6AoTKz0DII8OlfNy3i94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=H0gmiNq9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="H0gmiNq9"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-920f33347f5so155586285a.3
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 01:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782548638; x=1783153438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcCGwXLwtMV8RI4Wg+2Z1TCVKqOFak4eb3FLVCz7QhM=;
        b=H0gmiNq9AqOzXQOuybjVrCS0AKwAZb5Jqy+zMpxbmye02eq4Z8XXqpfaGCq9/ZX4Ei
         j+nrZlQJG0fU54EudXDJ6UGxCHG+CVViqhcDa691/nae0XsboPhYRqmFbOE+LwAqx1aR
         MSpd01uUr/2w4Y131lwNGqT3PXh6XfezPAhsjgEjh/cHvYSOtjbX7M+r7hOuhccEt2Mw
         icWwrdGQFol8w8fLemh+IuIUgANtMJgrr2i+NhbSDYjBnPZK3TdeC+pd+9SE5Fbcpwq3
         GzMTl0aHPk9jPBpX0hWStkHZOaadWWKU26ePs/CaXZXXY/N1NJ5nwu+iv5J/U0A8mCV3
         /BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782548638; x=1783153438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcCGwXLwtMV8RI4Wg+2Z1TCVKqOFak4eb3FLVCz7QhM=;
        b=nnEYGDYOFVYPJwF0VpE4jyRuKcFq6eyILQEzaCAfpRu0zzKIM3fIHEUX1ZXAn4uExu
         hCqttPHGwt3LCMRkpjoRaHUYaj5kM/w1c/6VqFJxJtBqeuUlthNnnU2c6HHkIe744hD6
         PDepjGEyC0iW8cYMESeF1KE6Tk40C/3ylmr6o00auTyfuinPPFTlLDgTWKklYuSpk225
         XhNY8CP+ztDXzFTZQF9vTOK+jORrxaSyVtCT30g0r0xv4xj/WSKGNVa1emrB21WBMvU4
         Pxps6jbnJdPKYnjWZTaOIMDKZ7MDCStypBjeR2DeYpDUgYTOdGeQMjoLG70pDEYMaUUw
         bHyg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ns8o63gwx3fTnh55p3z683p1QUv2e5DGbMc82xvpT9htOck6JXdvFGjvkRUrpauVMi7XmTUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV52KwbUDuf6Dma3QrBWkNokXZTAzoqzMOaji5eDPUmU9b9Cuc
	nyKfmV+4RBCC2cY5Jcj8aAyGOlxJ4+diYvVmh/6qlwGk/jLo1oVcUBaU/UEuKnzZb5k=
X-Gm-Gg: AfdE7cm0jv6UyM20RE9sK53hjNfCN8vU0aGgGf85HWuDxPDwzX8o4cDLiIsBE0+4O1f
	dtX90h5nU7zS/4euCT7uTkoM1jOFqtf/G394mW7IIHHKJrbUeQUGiZQLfmtdrjLwMGYlQdxEjls
	Y2CHAASPaMmvBbzHeTEDq5tuCT6m5ogzzdKwrRrshKM6P2OJYPJP5P8I7vt6ntMZGk2GNBlYmK7
	OUNXWZwbBPr+R3n8XTsdegag4JEHRKPLSAyoYSns/1JpqEYAMtm2qBo+BLOIWdsovRLQxwVltEu
	sGGYFebs54rSMkKqpNzXBLDp20Mw1l2IPpGz1Bn0pOir7n6ypCVsp0wvb6m2NDOFlrvTQAyB95f
	6V0m6xJvwvDYKGRNveyS9T3afcMjZKROERTWj4qdw8hME+d76GN0Kv17yxzyMuwD4D43qez5wpb
	2QqzkLGU8ZElI88bHrXHpOwjA/7+V0xwWdfzCGDciVXx4GujRdbB0fltgpT6KFiqR8i87PTCeOC
	vWqABo=
X-Received: by 2002:a05:620a:28d3:b0:915:f163:a8 with SMTP id af79cd13be357-9293d0ba9a5mr1471270785a.53.1782548637840;
        Sat, 27 Jun 2026 01:23:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004ac1b8sm1375302685a.36.2026.06.27.01.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 01:23:56 -0700 (PDT)
Date: Sat, 27 Jun 2026 04:23:52 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, hannes@cmpxchg.org, mgorman@techsingularity.net,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: flush per-cpu node stats when a node goes
 offline
Message-ID: <aj-ImLdFnKk7K6Fc@gourry-fedora-PF4VCD3F>
References: <20260627073107.523499-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627073107.523499-1-gourry@gourry.net>

On Sat, Jun 27, 2026 at 03:31:07AM -0400, Gregory Price wrote:
>  
>  	/*
>  	 * all memory/cpu of this node are removed, we can offline this
> -	 * node now.
> +	 * node now.  Fold any pending per-cpu vmstat diffs into the global
> +	 * counters first: once the node leaves the online set the periodic
> +	 * fold skips it, orphaning the residual on a later online.
>  	 */
> +	sync_vm_stats();

Sashiko points out this can deadlock on concurrent cpu hotplug, which
after a quick look seems accurate.

Has also made me realize the sync code is also racy with cpu hotplug
as well as it iterates per-online-cpu.

There are probably more races like this out there.

Will need to give this a little more thought.

>  	node_set_offline(nid);
>  	unregister_node(nid);
>  }
