Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7352949E0
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790520838; cv=none; b=AG0Go0fOEcUgqn+oPaJANhjORw6RU5DBqx0o6kwLypV1uuoH3WTlk2v783W6vk8YyEzVXxn2lvi5n2+l7tfHPA9t7I/3FKW+BDKkjId+tRfb96FZK93k5WzCHf3enj0vXA/dtP5snf3KTOXyrdrd11EXE43Sp80RJyIbuU4vBA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790520838; c=relaxed/simple;
	bh=GMgd5qcIkGfHM0R2f0/vM75cGwqO1/hpBlPHt5/oXCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ5flOkaGpkZz5h8pJziJrO4PeL8HVcZFKWVjtcsjyEcIdKGYLnW7Lhh9WwFYoz6pWH8v9NmyQVwJ1v42GXR9e570CUbaXrGWPtZ2SG+OfjR4pmtUBAZYNgw2IqejfFS7i64nGeUXWQjZaNwYCl7GAsWyKU/mx6W3fpf5U1Lw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sw2gH9jg; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sw2gH9jg"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso7481165e9.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790520835; x=1791125635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=47QCiiWBjYaD7BMaolGfIqq4ppH5IxXyHRYQ4qkMx6Q=;
        b=sw2gH9jg+yxNTjEJZTUfJIk/nd55SkbP6OSAnnXp1+N8CmmWxvV94X/Mt+ARFRNBNk
         qWp1z8ZMmquXN7Q53GPH2XBRadMtI+Q9wRkkXarsBha3cbpT9AHjeY6k+AZnxgR5/LLp
         owknND5DJs/GHYNpEktw7E9bixBozIVNb1+KqkC1H87dwwfCiYkF/zzdqBbQK34+idXf
         UrjoUpyb0OMntqMnPfcev6gCwgAiy7jIr7pkFBNHcKxtP4GFigQitBU4XtC8J398eNXh
         CuMlji4rtpQXtvuD+bLDZhuUL7O419NiK6DV8mz1zDW/PJATjXDOavjkyCsh1G6vr1t6
         yfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790520835; x=1791125635;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47QCiiWBjYaD7BMaolGfIqq4ppH5IxXyHRYQ4qkMx6Q=;
        b=Okf57rFEwfPSW5r+3xgSvUV+vSPKmpxfCjq+IaBmNy6yRdXnDzdQiinFC35Xj3D0lU
         y0r8d1p0iUcH4ajxkzNgGTOxbnzBJtk3P6Wqk7i41/gRmpAq+MkZk3ppFpglt9IZ/Kvf
         f6zklUv/H5slqhpq+mMTsGNq7HXb78zMNOrdOZJ47d6jyIJC2aOHqbOb4yGYgk7SJn0h
         2NaWLug/0cC/ZkkoPVOEdic6LAX0Rfxy6dYZcIVcW48dFTWooyADyhRrHBKxPloMeuiv
         AUiNLK3ypFNP/8s3ucoB8tKN7fKiPgGwb5KTA3H7LMd/8ldFAxV+BUd16Bq6H3nrfbyN
         GTPw==
X-Forwarded-Encrypted: i=1; AKwUvBxpDTzCgtESajbiaGuvLjcQDK3RFhILQsiATHlNd+d2eusCLQ1qGYZLpU+xDDpMg7xWWb6XB2o=@vger.kernel.org
X-Gm-Message-State: AFuF++kBjK8zAuFmHYAO1b3azbiMIKS1vApjD4EXhXdcxvUvvHhEMSAs
	t788qPcFV3nEpjCRUC6uU6ma66REZc6cTmk1oAjKg6+HUTXf4c/q91Ns
X-Gm-Gg: AYBFou029M9W9A51yaVSiN7R+13gVGsyGNgZX1uIU2XQQYWeCy0j2I4rQSSySHv2Rei
	vPaHg6nb1nWT8dYXXTq14w1WwyuhGEEDR9qoqGJ5l+6VsziCkwbk13ilPfI4uKn8JJtYAdhtGHa
	b4nz4YRaQ5OxJ/oeLN28nnX2WZm0HCtJnIwoiKgT70oZ3jYd8bilw0h1FZgrMpSpf1e6xMG0xh9
	vQb+QmD2rMuH3suZ22z1DhGYH2WFqHd9tFxJ8iIbv6Qj9X4rjviv+7cNtbmknz1Msw/X18VgKBo
	FdBIcPWxqjzfD7PUZJ8BXG4zrWkIm16sG8KAyqLGWlPbhdNHRteUddsnlmZ8DcwQR11iDXpvcP1
	YdxWsw31hVYjgOEl5VXM9XnJ6Hk0QQRMEI0M7aSr6Hu0iaOgd+/ezmgsOPRt5KbG/DzN80Lq0Ey
	WQHtj6Dv9oObesvGRrZNA/5oenx6gr2zVCSO7qstqRVH2zkUOeEVeOx53YFpPN1hgkPhhYjQ==
X-Received: by 2002:a05:600c:1912:b0:49c:fc6e:8cb1 with SMTP id 5b1f17b1804b1-49fe66d811dmr186291185e9.21.1790520834817;
        Sun, 27 Sep 2026 07:53:54 -0700 (PDT)
Received: from gmail.com ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017656cesm60949975e9.3.2026.09.27.07.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:53:54 -0700 (PDT)
Date: Sun, 27 Sep 2026 16:53:51 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP
 self-merge
Message-ID: <arktxLzohm0cb1ch@gmail.com>
References: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
 <20260920-fix-dontunmap-partial-self-merge-v1-1-6ffb556f8f8b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920-fix-dontunmap-partial-self-merge-v1-1-6ffb556f8f8b@kernel.org>

On Sun, Sep 20, 2026 at 03:13:10PM +0100, Lorenzo Stoakes (ARM) wrote:
> The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
> operations that keep the original VMA in place.
>
> Historically this has led to a lot of bugs where non-obvious interactions
> occur between existing mremap() operations and the original VMA.
>
> Fix another of these - self-merge.
>
> Self-merge occurs when a VMA is moved in front of or behind itself and the
> attributes of the VMA permit such a merge.
>
> Practically this can only happen for unfaulted anonymous VMAs due to the
> page offset equality requirement for merge:
>
>                            |------------|
>                            |            |
>                            |            v
>         |...........||-----------||...........|
>         |           || unfaulted ||           |
>         |...........||-----------||...........|
>               ^            |
>               |            |
>               |------------|
>
> This becomes problematic if the VMA is configured by the user to
> mlock-on-fault, i.e. the VMA_LOCKED_BIT, VMA_LOCKONFAULT_BIT VMA flags are
> set.
>
> MREMAP_DONTUNMAP clears mlock flags for the source VMA and maintains them
> for the destination VMA.
>
> Self-merge makes this impossible (there is only one VMA) and incorrectly
> clears the destination VMA's mlock flags.
>
> This causes a leak in mm->locked_vm as clearing this flag does not
> decrement the counter and the VMA no longer has VMA_LOCKED_BIT set so it
> is not decremented on unmap.
>
> Resolve this by simply disallowing a self-merge in this case - the source
> and destination VMAs are kept distinct and then are able to have distinct
> mlock() flags.
>
> Update dontunmap_complete() to make the now-redundant self-merge check a
> VM_WARN_ON_ONCE() instead to guard against future regressions.
>
> Also update the VMA userland tests to reflect the change.
>

LGTM.

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

--
cheers,
jose a. p-a
