Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795828227;
	b=DPTplReSeAYWADyTQOSGRcE9vgJ3Aen2ukHXCWX/25Fu8qWWZ0QAiimXkpjje6CPXivg
	 zdkCMRo7caAYpVMqPrEzol+vSwT4UwwEK3NiyOVeZaJdxHCWC3un+9tfz1Vhdb94SGoUk
	 XOtEtsVf8kQh0lTqMX1Q2ZvV80TksUaXYLdj+e6LVBuflfZVU5y+iWtLmYU5JHEQw1zqh
	 aFZdmhJmCnOVq+669hxY3birZHxoYF/GGFDWLXPwV0d/AYiRJG/hAFO99CAe9S0xE5TaD
	 hV1HQvo2FQZzfjxBjGHPnUP6yJCA+jMlzwcxBq12MJOrl0Ty13m9vVrbL1Z2knVjn3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795828227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LCoNBWE3kmGZQJ1kgw8zMrA5EDN0aulmwFxsRmULwsM=;
	b=iltXlF4S8Wm8jmtpNo85BwEs56BKxzcEVMMn8uMa+HAbUP6W63CvOeJEp5j1bswAkIyk
	 8gP6GaW/JS98vnB+ZS0nCPJPdDWa938oUhzggn5wlTCbu/r+BYdQBb1F1BfR2SkgJLF0/
	 MHwQJZP4JHb6Mjtoi9GS4OfoaImZ7HaBUyB83WmbZKjWTlEmE1jRwMqXWQGu+SIXU0VF0
	 q10FZJ8cET3qtC9GNDhG9FaT+4pqLKX4CrquqjK5/uGuHOIf6+FsG8ZFz2p6gPggoAThq
	 f4FkKH+pOFA4wCr/OOfYCV58lMV3QELsFJ4BBCZ7IlUjwQQxCh794ueex89sQIDCVbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.cmu.edu;
	spf=pass smtp.mailfrom=andrew.cmu.edu;
	dkim=pass header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=CWjYKGT0;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DA606A329
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 01:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 112DA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=CWjYKGT0
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55d03bfd477so96031211cf.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1795828223; x=1796433023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LCoNBWE3kmGZQJ1kgw8zMrA5EDN0aulmwFxsRmULwsM=;
        b=CWjYKGT0Rxh7o04L3TC/JfK+uf4hcTv5G/OYgTRB1iBdL4eDH3e/LFFIDSlMTSh10O
         nTeD3sJ2hsdOj+qUENGI6sv3VZx0OdZm7gaYArds/UnZMFzu0txNbil2P2V49E3BSbKf
         fBFWYtcAxrxOXqE8cE3CSJ7ayej+C8/WOWoK8p4TehPSmjK4cVdj6nW4QQnR0rVwFURz
         FQHMbeQFo/sRs/DRuW4xea47NphJ6VklMieXOE0gjy6FzMga+PUhUn4yGX9iJcyWCFRN
         dHlM28+px1j6+Lb66EZ6+U6goVgQsWG0+7hHxkb8jYPOwUJKOuA9bMOR7OUMQNy1D4tO
         ehCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795828223; x=1796433023;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LCoNBWE3kmGZQJ1kgw8zMrA5EDN0aulmwFxsRmULwsM=;
        b=O028xxCA/2SGf4a5JPmASfpzOtivXiS+Cu/Z7Iq3s9UZjDkTAJIsWev2g6MDL4FfyY
         4kx75hAVPy2nY0oeqsh1InQEK3m4O1E9feqSwPvIQEpE5Dpj/fEQ5A69rlf50PCtHCNC
         wGNVQDcXVH1GE5DwbfVrZbCsaRlj6E8JqLtN1VXFGNWo5BvCjDHLGhmAiLwGnR27avgw
         X+6X3nOm4XWozF/Mq+xyVwIAsUCHmVWWWXhMi2XX+fO29h7ZKZ/wi5v5qtoVUtfEBBAi
         Jt2ymKFdfWkOgq+XrEFHcvbtl13Z3aIbNu1bMrBQIiCkPKdpZptrf6EFQhZD+7N/8huk
         3Uog==
X-Forwarded-Encrypted: i=1; AL+hErEZJUkrxXNFwuvXJpLsbtE3FrWUSjLeKsugKshC5XF5KWZs30+HL5qSXdXlXJvbrFLKjAG7CJg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UbIaaipcr9fZVJpQpV60ziG0BzBO6R4+83RsBm9UMiWtVSpNh
	ukDepPZoQC3ArgdbVOQtgl9ZJtoHHZrHx5ES6mmNUbhx6ZwhNq11d8aSG0+Dv6ws+w==
X-Gm-Gg: AZFdTZcRHlTyLlbay+DF+jeUKcV6VSgUEhHMcOXC7/ayd/F4z+6dx0jtinL07c7iI7z
	8VdPHimwDOAKSdXcYCg7p0VWs6T2/vFDREv1GVy2fnOCe+5+tKE+/1xB7SqQqUpxchsIc9sz9S7
	pEfLDFEB9600kB74t131bHqfzkmxF6DxLzlQ0tp/cWs7pCkhauIGe9GPht6ri2PKgEit2XoaYjo
	C0RSLtAOfnPLTtpSLIAktiTNJkCbBHhmbc2BW943LXhoASOouwBky4kO6qobDtLgpw3Wmyzdq2y
	QFfHSV/dUd/wW8AXaxwbVySbio9Cv+R+1Jy0jXe1+0Z6KqNuIlU7RQ32nrIUgJ7bOWAJRAcLaB2
	/pEqzKR5N52mGNFwzrOm5bHfGcAf4BtwfH6XBqeuYh61YnjUWr066dOzai+ojd64GNrXw6eTuMs
	Ls/qqSNQ+vpGn8dpZN7K5pDgRQFauAaHtaPwuFIoJjPZzC6HY2lUhQofhHCFxUHDGRsHNoNgj6V
	5sRt7FVCXz9I/rkeq6ldXS66EjVSojhyVD29gEKICA/u42hzAWX8ednavV2xA9nnL7Dewy18mjc
	VSRHg9Ma9J4HyRD+wiDyoOIX48xrhjjaaMbhKDsIcstks0ecow==
X-Received: by 2002:a05:622a:428a:b0:535:f92d:5c00 with SMTP id d75a77b69052e-55d76af8921mr488959251cf.76.1795828223013;
        Fri, 27 Nov 2026 17:10:23 -0800 (PST)
Received: from cs.cmu.edu (tempest.elijah.cs.cmu.edu. [128.2.210.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b3a0csm229263356d6.14.2026.11.27.17.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 17:10:22 -0800 (PST)
Date: Fri, 27 Nov 2026 20:10:13 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Hugh Dickins <hughd@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>,
	Alex Shi <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Muhammad Usama Anjum <usama.anjum@arm.com>, linux-mm@kvack.org,
	Andrei Vagin <avagin@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] coda: never point a file's f_mapping at a
 container's mapping
Message-ID: <20261128010821.irhzl7qcqahz6onx@cs.cmu.edu>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Hugh Dickins <hughd@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>,
	Alex Shi <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Muhammad Usama Anjum <usama.anjum@arm.com>, linux-mm@kvack.org,
	Andrei Vagin <avagin@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
 <20261127-mlock-madvise-mprotect-ai-fixes-v1-1-e46b2b1eb435@kernel.org>
 <20261127124428.f1f66c6244d3e5c2811f56de@linux-foundation.org>
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
In-Reply-To: <20261127124428.f1f66c6244d3e5c2811f56de@linux-foundation.org>

On Fri, Nov 27, 2026 at 12:44:28PM -0800, Andrew Morton wrote:
> On Fri, 27 Nov 2026 19:45:40 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> 
> > Coda file systems stack differently from other stacked file systems.
> > 
> > On mmap(), coda_file_mmap() switches both the Coda inode's i_mapping and
> > the Coda file's f_mapping for the mapping of the container file. This
> > causes two problems.
> > 
> > Firstly, the container file may not remain pinned, at which point this may
> > result in a dangling reference in coda_file->f_mapping, and so a
> > use-after-free in mmap() or lseek().
> > 
> > This can happen when you open the same inode across two files, mmap()'ing
> > in one, which assigns the i_mapping, and open()'ing another, which assigns
> > that i_mapping to the file's f_mapping, if the cache manager gave the two
> > files different containers. Each file pins only its own container.

Coda uses open-close consistency, so between the first open and the last
close the cache manager does not make any changes to the cached copy, so
every open is guaranteed to get the exact same container file.

Now that happens to be the Coda cache manager, I guess changes that
would enforce this at the kernel module level can be useful, but
dropping f_mapping, I think will break mmap for us.

> Yeah, I hit this while getting
> tools/testing/selftests/mm/memory-failure.c to work on all Linux
> filesystems.

Did you test this without the actual Coda userspace? What was the
cache consistency model your userspace was using?

Jan
