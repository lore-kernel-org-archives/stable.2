Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795546807;
	b=VP8j205YHu4V7laWioeEPde2rVpFRvn5ThsCH/aH8nJWZ0aXfDWpl5lzst310gEjlL3a
	 boHj1AbCexP7pADQ7h7tvyWvju4ZBTaA9uivRLga84lnSXuu2aI+lbCi0wUqg1tsgvNDc
	 GwZtQ4dXxLl3JTPdm7okjrVpItGnvA6P6mvSTJFvPSirRaWaBxq5jkk/Mt0OWyEhpuVaX
	 jsAxjG2BCgxYGxLAZpmShwwANnExkmjs1/R30uL0JhvOTXe96EKf2F1tNuhRc9vLBQidx
	 +gHK4El0tzeGIPiaBptwTIC41PVqw9fs3RfBJTZXZnhb13x163/KKv1EbGHZfTa7cSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pI18bHQi+lJnh+lP+mc40mct9lRe+QxMEvK17p079oo=;
	b=uXCNxerA0fwklR8QMi7AsdKZDA3Jj+vNWL8NmI/QkdaJ9devmipDJ5l/MA5ZZJBnFAoF
	 rdJ00yqad4kWqLnrI8TSDXjSq0MtUXIyq0ykY7J88Jt+TkOwI896/3AwcmiyaUa86ERbd
	 u4Mkfu5JUlSluUZHusrIsWTtBzPNI2I4f0dXZKIZPWXoHEP22T5VegmvOxegUuWZL0j+6
	 p+xCpsQZyp4sgi7fkkZhEc1lpnBIHIVLMjSbWbauAZ1O3AvxBa9Yzl4QNxcHDfPNDai+G
	 LFkY61wL/KcP8oEKgvr12bIq/kyAO6qymFaNeYXWzmRKuVQP8151EbgO0vN7RY7YDvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BSHRGF8j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C9606A698
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B8C9606A698
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BSHRGF8j
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb845433b8so139285e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:00:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795546803; cv=none;
        d=google.com; s=arc-20260327;
        b=FsUiA7lRr/odsZ1Ycund1pUWRjiuEz/AtPhbsnwgHsjDJ6B/2WVINosIacvb/OJTdu
         JQBt7zCt32quyyxiG7L2tZSG7WzlMuvOCUZ0kXxMRpOzXZ2lzsI+u2OOWgkuiKGq1gPg
         eizmbanjYjJv5uX97AC8mZvF6A1WX4UvW+v4/N1vIFu8igyy7Owa6w6JY9BWxbcTz38t
         ZHLQTADPOUcmW6Gqp6kL389hpo6Bel1CoGe0qUYshCL72H+hmJuBItLpHHvdedw4OhG4
         LI/opnw6QkjN63dG8M7j+1SVgpRJhwihcm04hjPIkRlrUBX/9Tg9bE69KUQQMzKhbEgU
         iFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pI18bHQi+lJnh+lP+mc40mct9lRe+QxMEvK17p079oo=;
        fh=Rv6UPHaE4htNCg42UrTlJ/wxv2Eq3zQPYwa/8yB3v9A=;
        b=i4yJ4e7SzjoBjYxp9vRO8O79QCtmUs8orfvXAzg0HjDgCWcMGskYn3rv2hks5BdW6W
         iLsj8KWdvpUn3pPZkfB47AnW6Q/8mRpEWLjsdqJvL6Hhkgt1Mbd/P/eOjLSGcn4D2D5v
         UbPHz9j9PzwAQWCX8FwEMx7NlIi2UWpy3l5AB5zD30gSp4RXzJLPxePb35Sd2AomEp66
         3XcB324SOGU/dTp0ZFE0sAVFP8LMVUdBQYLWipPloyDMBQ+U7WOFBhS7/5huqcqaBN3Y
         Ozbheq0ioRVBhgb/z4J33eEmXShwQVL0aKP7EW0Z096Uj9WNTpkZoD+nGBuDcChnSrXO
         iV7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795546803; x=1796151603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pI18bHQi+lJnh+lP+mc40mct9lRe+QxMEvK17p079oo=;
        b=BSHRGF8jOSIVT/X5yLBPZ5Px8eJI2o9bBmEJF/puKHGpS+UJEtovyL3ZhGpVb4Gbw9
         efrFX6XQ6m1PdozusC4S/B0UVGkabwZIsQF4hixK2+e424VWFxPpZraZBOvd+lQaHVTq
         APkzx4gIJ949uye76nUHu1oyaZ/f/mMBBawN7R+yATrPSRaY6WzUU4snJgAJ/aF85jeu
         iAjrhU0WXIpO7XxSla8ou6VpCJGEVxEytgNh6FE1+jV6ENTp+gDKT/FD9xEQu6QeUcZA
         14qPzrV1hOlB+5gTtzdmKsbyk27JmDFauvXS+R4Fvi4gPAufmjfiQH2CZe8jw69EsOft
         VHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546803; x=1796151603;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pI18bHQi+lJnh+lP+mc40mct9lRe+QxMEvK17p079oo=;
        b=A7dMDh7EWmyiypryADueaUTwEBRewNaMHi+2XWYOaBPmDWMS71cHERGQJIxzrn6Q6v
         1iiGiLImxWLNGjUGilvz5S5Gb7KeC0/TQhGLqhYDZXyP7t7q4jOq+PKcfRAKuDVyuyg8
         z9ItL/PjGkZMmO5//Jr/O79/joG6J8NzRn/rueXKGrgvXacgLojfWJqBnoKxijFGRGyh
         FeaBNquGTsh4DwafPd8XMuFJnzPfLPWNsS4xHMyJqAZaWpRsdo7d3TtR/jysfdoUdeaF
         BOu+21WYDYKgU8LthhZXvpi9xcv2GuNWycsJsLTn76qj7IW21cbddExrFJ7yHq3VW/wk
         vRZw==
X-Forwarded-Encrypted: i=1; AL+hErG8Nh5/x7prKELmAwQF87/owsj4PmXy8v4vPMO5EZOP9JcbrWwV6K1pQi8O3H252uXS6XhqkFs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RRnUa8HMYucCshqpfBWP6lkqRp5PdHxC1tQW1qveJ0tsZZStD
	Z8rDFZV0OQFd7R61Cic6yOIRHdpqJUbPQMK+olG0rRpuILIBNbiBz1v5aJgltWsrK5VoqGDyEhG
	/CRI3qC0rZASyooQLAAiRPQZeJ85L7pIvR3nblxV2
X-Gm-Gg: AZFdTZdlR2LCQWWcpfSiUOMhAhk5j6qcyd32fI9BaMZYVGODVl48ExYpggyW0m778bE
	6Q7zBtIxTIwuOn3McvXr6JL9ATVUAgZtVr7gVtAUGwkNIc6xc1BQ+gbOlaoSyouMNUiCShXJGKJ
	qv2BuKtBodL9vWapC4t6oOafTxXsPx1OuNgLD2dbe2r4L+FGImW6RRNfteCToyxFVaDLBlIU/Zd
	NPAFjVz1jLlZly8da9p/aI2vabGEl6FvdIPsazmHnW/BHjMOQqCFRIaTAv3YFdSHpyddpcoydf8
	7cKDadj6+X0aKhnZ5fwa4OaaPNKo6b6EgCYC+c5/1QZbyY7l5z1C29AQGTclb0PDfZ8BHh6dgEZ
	JvaNiPJuQF9Fzdq0kMi5gQezq4qkrYEY2yxfhUMZj5bAqw04VctxYhaRuwtKymEGe1y43uEZuDT
	sCBFfBOsrDj403zJusC6xm7MQ=
X-Received: by 2002:a05:600c:4ba8:b0:4bb:5e6b:2dfc with SMTP id
 5b1f17b1804b1-4bb91646004mr2422425e9.13.1795546802578; Tue, 24 Nov 2026
 11:00:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org> <20261117-huge-pfnmap-fault-races-v2-4-276007e73bcb@kernel.org>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-4-276007e73bcb@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 24 Nov 2026 10:59:50 -0800
X-Gm-Features: Aa3M54o4WZZXMe5rkCzAWiCKTf4u9AcgtxpDdtwUOt0YCIX4IAOM1qzNi5J1mGI
Message-ID: <CABdmKX34z2s-7KE2+JwFSQRN3eGoTy8bs+KB_hWXw0YbF9msLg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mm/huge_memory: only compare PFNs of huge entries
 on huge fault insert
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
	Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Roman Kisel <romank@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Naman Jain <namjain@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>, "Gregory Price (Meta)" <gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:32=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
>
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
>
> insert_pmd() and insert_pud() have issues with this as they both assume
> that, if the page table entry being populated is not empty, it must be a
> present huge entry.
>
> This is problematic as if it is a write fault, it compares its PFN agains=
t
> the one being inserted, warning if they differ, on the assumption that th=
e
> entry is a huge leaf.
>
> Since the entry may be a page table, this is invalid and can result in
> spurious warnings.
>
> Equally, the entry might be non-present. Nothing can install such an entr=
y
> in the VMAs that reach this code today, but there is no reason to rely up=
on
> that.
>
> Therefore only examine the PFN if the entry is both present and huge, and
> otherwise simply return VM_FAULT_NOPAGE so the fault is retried and handl=
ed
> at the appropriate level.
>
> This is what already happens for a read fault, for which the existing ent=
ry
> is not examined at all.
>
> Target the commit which introduced the first driver which both mixes faul=
t
> orders and passes the write flag for the fix (since this commit, both
> drm_gem_shmem and panthor are prey to this issue).
>
> Reported-by: Eliav Farber <farbere@amazon.com>
> Closes: https://lore.kernel.org/all/20261112051440.16140-4-farbere@amazon=
.com/
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
