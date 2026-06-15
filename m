Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159C330328
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522360; cv=none; b=CNmzl1sj+KMe2FyCc3ZfhCDbnLXM+6MmIUhOTf1KJpuCkOEVGyRtP4UfUbw9dY4p1JllZeumlnl5GKIqEdkQlaFR5k9F2zyQRKNnPOUFyREWR/4nRq3kc7zNalJuyP2TO7W2HVLKQzALaWKOy6RV7lyFaGEAueuCPXkcCUZsHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522360; c=relaxed/simple;
	bh=3DIsUqGC96VZVDdHkEFPij9wdORi4Oo6AKf22v21DwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiOyyA2l/VkDgmReZ9DiaZigkDT+ncXLyzmHBdgOMb0iwrl/ewbkONIUJ2RZwcUi4pacFasr6oUAJhBBvQ7Ef/U08DTQcESn2DdflTjFobgKlzqXIgkvftR0j1YXoem5dc31xPftb5hgEEYi9PCCxV4BzdnCGlfOGjW6Lu9oIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hD7/V+Rt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hD7/V+Rt"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9159477c893so381732785a.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781522358; x=1782127158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DIsUqGC96VZVDdHkEFPij9wdORi4Oo6AKf22v21DwI=;
        b=hD7/V+RtxaxFnAPfyeNeJeH4NKZBr05DQdNW5+wMsaC1zZoMojCl0QN0GXK1RrKFoW
         dmOJZ6qy76bTnJQoxgfQpbkuckSWCmKZkDHj33yyLEqF8aNkNZexsJ5+4yszJoAyVV3Y
         EjxBPeHB/nWLI0/25+cLOu/Hk5AyC1sblttE62un4ule1Ul6dBrYuGo9WQuI551DU9zX
         QOEM3SPihDp/+W0q9kgY7AxZg8x1XtI/1Vfn2REH6wv9ZeWhaO5Mto17RnnKWcLnxqUJ
         bwnhaaGykI89y9evxm6Qn42/r3qjGLYW8lLmUC0ycFSJ/eg8uwvM1wEdLOekog31FFMf
         LIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781522358; x=1782127158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DIsUqGC96VZVDdHkEFPij9wdORi4Oo6AKf22v21DwI=;
        b=AWI6r0zlg6V2WJ+Zc5yKvmynt7D3SuqLOe336CqhOx6rdgx7wwa5v26+OckxkqQtK5
         XWFLrZIHu6G3urSjIRhbPHIA8HGNxb/Qx/Uy7tJRpZjtf+HSCKd7g+aA16MxRHk4rLXr
         CTJ7iAl1PBsPm/+yWdOfw1kslb3azDvingyWyDkNGQkf6PwZ9Yusemig0Ou1cWaQT+K1
         B8BwgA58Y9Si2IcPGtHxedpUoAW1KpdSHihfKDz9qlXx3bTrUSWmu2TO4Ga6mOG4o8M0
         z1NP2K7EX8LOrYttEJGgPjkPE7rthM0K67gyl29cI6Lwu9OS36nRGrEdw5DCmWVOYm73
         DGLw==
X-Forwarded-Encrypted: i=1; AFNElJ/kgQzVmv+c3tX1TAsyC7k/AIh2l2ojlYXNaddcYnH5EG2eSToRV+TD+ecsiLKMRK+2ZmT000o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdL76OTZ/3cwn2ra3b6c9AaPtzL5dB2Rmk5bvEraukCg/SJn4
	t8WQstwX9QlWQKCMbpERa1SsSboBfVsb3lE1PiIa3JPXeikELaK57vj8sGYiDKks0wo=
X-Gm-Gg: Acq92OGhWRw2YUbDSnO4oDC25zqTpF3hwVzzzD0eys7taxG/HgrXx99uHSTqAbBBn+M
	fh9IR1xWtYO3ojqZ2E/cI6uWSkGjfureVY3EdNLgrIoAzkgAOn4/QREUQGJkRvwjVi8O/RFAhU1
	oOTiSbMFOiuwIa5wdtCDTaJHCpezYB5XCSVzUqyYb+79GGkVyBfVTETVPP9RCoU4uLBDUyHsR3+
	4dge3vknu4+MQXN9kZZGveecBlj3gVO+3+RaSDWa5NASuBqBVdGSPVk1kKGHD2etPDIov3IY5O+
	R9zCzuu5Ufc65lFOAz+GLZ3XVnoGB9vAyvBZGwDtVCT9UaQ/5rfHA0tx2dkQLLcJYmz6mln3v8K
	WquMELSWkjm4PfyhqdbH+Bae/hu6mbb9q60JwGxYBklH6ZqFO/76MujkaxTDv/knXpiA82znBOr
	7UvL0+nuiA6WZGuSTREWDzdesirvF2myaIA6wW74071AMFVhHuMjflE9GjC9td4BZeCdQEOxZdB
	n5b
X-Received: by 2002:a05:620a:448c:b0:915:db15:4e36 with SMTP id af79cd13be357-9161bd156bcmr2061939485a.42.1781522358133;
        Mon, 15 Jun 2026 04:19:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (158-94-182-130.mclarenap.oninferno.net. [158.94.182.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7f16sm1071791285a.1.2026.06.15.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:19:17 -0700 (PDT)
Date: Mon, 15 Jun 2026 07:19:13 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Farhad Alemi <falemi@asu.edu>,
	Yury Norov <ynorov@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
Message-ID: <ai_fsVg51_GTtzT1@gourry-fedora-PF4VCD3F>
References: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
 <CA+0ovCgfHJHv5d1mzapWWvF-LhjppzDX8NPPLvCPZxPKg8RiYw@mail.gmail.com>
 <8d3b4561-92cd-4ebc-8462-5fb0fd659e8a@kernel.org>
 <ai_IHvyptWPcTD0y@gourry-fedora-PF4VCD3F>
 <ec4b4b70-dc01-41fc-ad58-e1c877f6a7eb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec4b4b70-dc01-41fc-ad58-e1c877f6a7eb@kernel.org>

On Mon, Jun 15, 2026 at 01:08:16PM +0200, David Hildenbrand (Arm) wrote:
> With newmems it's clear that it is guaranteed to not be empty.

I hadn't noticed he switched the patch from newmems -> effective_mems.

This needs to be changed back to newmems, otherwise we're depending on
a derivative value set somewhere else in the code being correct instead
of using what we *know* is correct *at the moment we need to use it*.

So yes, go back to using newmems.

~Gregory
