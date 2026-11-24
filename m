Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795536364;
	b=F2WN3dWu/IVz2k6w83g9L0K72lnLc3wWBe9JFc+3cczr4xlkNAd6mgYffVLhL46mC37t
	 GZhMMh4IUfess04xW2rOvfbhIDXtJgozEApK9gsaUfhjt6Ijwk/HaanD4bdrbvY0buBIo
	 ULVJ0bYBHrmkuRMQvodToqyFVMz/Ag+Czbk5w/29jVrWE0tY547kz0Stdl1SKjBf3hkpx
	 OKvxekS1xFTyr4LDJ1j0hvQjdqLiN+IRztsJN18AJrdghCXf49FCRsIGGmvtveLRubkSQ
	 /kIqNXSZ90cgpJnP9yU2+Ykz/a1o8N297eXkhNYlAtsjfmRETppRSka6oD4Oh+SmZeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i+X1zAbocrlZ5/LLPdVPcXdnhobUDrydqC0c9bKACg4=;
	b=ZbOnoW/mHaeLVqz7WtiR5zmmOkuzQGJzhTyr5mD1ulb4F+qVuFAElcbeo52o6CFRhFtG
	 eT6a7lePnjECLqMerN3ZL1hq5p3lJ4AwYQbfpFwrVVxkxct3NU7CHMs6NISvv22Zx+G/L
	 P0IRyDXTUToa/zfPrbXRnnz7TYUxWGsnR12WUb6lctFvz9sONnhMbQO0SNHYQI5hMjYIs
	 /Os0M4FYAaGiNDFbpk8ZLjzmunptqYKsH0MZs/8S4jk2EP17IZt+wufEEyjudoku8jJJL
	 1nEq4kHPQ/r9ZjZgCDZGr22fFAmToa3wqGUD4RxfZ9BQOpvk9+Xm/m/nkIRl3oayrtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="E/NXh2oE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E44606A338
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20E44606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E/NXh2oE
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso10376772a12.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:06:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795536362; cv=none;
        d=google.com; s=arc-20260327;
        b=Pd/aZFf3cwJnJ6K91Iv/ASCCfbLzb3choqo4m0xe+73T8BAZUbcQqWERasgqoOOToJ
         jbdU0Jo43jTghDR0bj6w8yooUJzNi/9cWW6TdzcWGGTz4DmEvmRuNSvHvyjcLsZwHcmZ
         0m6TzGYm7nA9DWfcEOQrfr/tGec5j/5BCMBWmnnzqcGs+Sa5WRx/9PGXh81lMYGgzfBj
         3Rakut+Z9dzRwmpV4adlaP2sNr2LDUV6XnOz04J3U4OhSG5aGAF61T1GNN2q0epC7ro8
         Kvyq0MUezYU0298kmTB/+LOqQZS4BQjVi6BBN0BmqADe56fcmoV9yGTOksayaa9wEejl
         7VDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i+X1zAbocrlZ5/LLPdVPcXdnhobUDrydqC0c9bKACg4=;
        fh=pSp/RfINbJJmiWzQrzTj/xzlwwtSgXrtDhKqTOEVdRE=;
        b=k+taEu06DEdg4pZwLPtu9fwhbUL2YHaBqPBvSDBoilj2tr2j4dPVBl6gcKbIQqHSdw
         31PGq0WDSsS53DLShgXQEysQ1mjdafM4B/TXnyJt3st3m5PmoTvqMzbwTKEJFDT86Czk
         Xz2vaf07YBnA5eV1DsROVt3GWhyQQzZ2aNLx5qfJk83eygzsq187lSXm6F8W7mYK25gQ
         DXFrleSDAzMjZ/JnEM9YRIrFaFY5s9lXeozsxz67+dQWqxw4jBAOAiqOy9mq6fAtJiVU
         DCbZHxM7QV73nHY2acPkFEtY/6DQYfgcXwqOj8egXAS3tQ9Nw38ic+V77eJ7SCzFhHAv
         Czqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795536362; x=1796141162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+X1zAbocrlZ5/LLPdVPcXdnhobUDrydqC0c9bKACg4=;
        b=E/NXh2oE2nEKSp1Nk9q/YlLPFggcAo4/RYF34vpQXstWnUL0v9VAbvpcmp70EeBgRn
         f2BF2jCWaA6bR9UN9EbZhPArzSmequgjr85BP6axfLkoDByL2qJCOW4VTUsIEsSfL2Nc
         TvwGUu8yW2CsGVHAMadwAwe8lxOiepnODue8PfCUkQmOVjnAofnNBX/ZtMaZyKark1Ow
         aF1bEwFqlKnP4bdaiVJWN4uVX3KqbQ+i1nWK57JbtB8lnUyGdTofAuhyGbPuCoC6mUk6
         I9y81VSMSAAVSUB/yIk6pqj8o9M8SKaUGemsg4aNAixUxGGz9k0DHm6ck4NpFQ3YVzhH
         VGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536362; x=1796141162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+X1zAbocrlZ5/LLPdVPcXdnhobUDrydqC0c9bKACg4=;
        b=GafENPAPwQ9sDx4oeZ3YXtjtaQF+n1FlZ0GVhJtGmOIWv1LNP/O93YKl2KZxQnQgGk
         M2n1T0EoimY7LEfFrlyMhH0HL2L/vbQwmPBPuXsUMwl38oMqA9us+5FbC4h3S2t2Lri9
         mT+b0CZm0MfH87Cm+N4bYtK73mfzw6W+R8H6jszyMw+fJPh77eq5Q9z/DSe6kMQXwSe2
         1SbwoG38IM3ANSMKFU+RtnJZoTfGZjFq10uNsjXvDFToNAT816tztRwvqc4BeobvwCxk
         NvVUrg58HUsug5CsTz7Gbl+/P9m5TI7tqrbEsLl9esdVTbrwEHpcA3/uVddGQEWMbr7l
         sdSg==
X-Forwarded-Encrypted: i=1; AL+hErH/y9u555rV/iKd7CrbYzR1/QNWX2CIRh4ZI+0De/XoxBiE+am1givM9gzaGReZkeHeqwcFLR4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/okQbwxQaEXHyZ5n1M/qYQAb3nGrM51brdq9Wfk60k7xdiEcBe
	OmITChGUKINGiyzbpYGiod9mCjg00fTAIBHHrL4XKVqsGtOKrj66vaUgyw4bhlrERvjzuPMahXi
	mebFnzHzfoSyJpulRStNCqiz1HT8n9tw=
X-Gm-Gg: AZFdTZdm3p2R0t0YIKmdfcnC0PD/YteDqJ0M+b3wdiADFb3C3nXOBkJy2TuHF5euR5g
	L/ErRy/jBVnhwix9Cf+r15gvAGV0hctRF5sxkskpBPVsDwET9ut6IRyXUL88oO75Lof8U3wDhSE
	ajrj3AfNMmPl2aoB8GmKDWlfl8YoXu2mi2oyGe2Dt3TAMylloIRUsmqlxWS/n/VN4UXRoh/ZC9Z
	Ca34G6/8kJDPNF0WoekqgUCg0zvYv/UK+HMRhSP8Sfx1J7rrz5YsId/oxUqrD7Xhu/xGdewSA+a
	P8iIefyCDnZIbFPI3oWG7V+kQU1lcX87HV8yPO5scfGvQQpShcTDtzHD8smHMGeA+pyTxldPCWu
	463eue13NRBkubwAmJRWzMtF6wUB2hdXt+20=
X-Received: by 2002:aa7:d1c8:0:b0:6b7:37bf:13bf with SMTP id
 4fb4d7f45d1cf-6ba1fadf982mr9292482a12.4.1795536362117; Tue, 24 Nov 2026
 08:06:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
 <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net> <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
 <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com> <awWz3nc_b8x3mIXq@gremlin>
In-Reply-To: <awWz3nc_b8x3mIXq@gremlin>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 24 Nov 2026 21:35:50 +0530
X-Gm-Features: Aa3M54pSMtL_EaeBSS6GmhvCgL293XFN6RiH4uS7LjK9j2GLa6vMCzrMZ8KZVJQ
Message-ID: <CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Pedro Falcato <pfalcato@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 9:28=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrote:
> > Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
> > that RCU unlocking move you don't need other_mm copy and the comment
> > that comes with it. VMA won't be freed until RCU lock is dropped.
>
> Yeah but they can be reassigned? They won't be _freed_ until a grace peri=
od but
> they can go back to the slab and then allocated elsewhere  right?
>

Yes, they can go back to the slab and become a different VMA.
