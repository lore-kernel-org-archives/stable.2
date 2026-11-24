Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538094;
	b=aprskO0t5FgTRtbXXTu6e0LDyAZsoBRb3CITnX21aHjyhuJrn2ylc/kgvQI6+8dJH/E/
	 spgC9BUlHyA4CPT7yyGz58mG391wgneMJhvayO1dGoxnsjAW7ubM76Fm9RyR0RWyP9foW
	 mCKiS7mpdkuw3C9TBa2z2kihCTLKzQCCBk587/sozDsn2yY+8WBKh4GdcoY3piISHVrq0
	 tfdBP2RBpHdxwqrwGirhjV8dLIhZCzrAyPe7c3UF31ZyBYmkCD71fSjZhkBhtdotuGVjt
	 mfrWYZ3LkxGY7EzgX3vKhv7FBD+771/18hmeXBMvAboYNGrRNzCZJD2UM1RkUJkKMMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Kl1lMLuqhZH+LLqHtJT6QI0oIm+dpJplZfZi0YBu//s=;
	b=RcDq49h5ODCfEWvrRR46SpQKlM/4hpuSkcZBywbXdBWt5TI7t99rttslWzA3KL8QoYXL
	 GGyfSsn1B1n86EqlN0/GBww4qpbUJAbapEkIBHszrTxxRY6GZJhxgfa0gtncfkm56JvqH
	 EbshIUudVSRBKHyEB0+gmcBA4DOT5RWX7dI2HsnwQ8ZAd+10G7aNLLSJsjQoYZcBJ5Hkn
	 wTDi/hyBZ3vKrWi6LouOGGJhLQP/e7xtT29xvNJ5lRXN+BNZTf2+JeBTcm82hF0s5MJNl
	 y98OP86PJluJ2Rg6gGixGHEtkXVxIAVg17BncRpDFGBzxm67AoNe5KmYK3NuU7rxyJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TTfD3o0B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6056606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6056606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TTfD3o0B
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-533202fe429so948321cf.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:34:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795538093; cv=none;
        d=google.com; s=arc-20260327;
        b=ArHTGtfibPH772kkMRZetX18SNiW8rLmO0jsKYart1+9TVmf5CyB1Zq9gwQ7JU4DNr
         rz8G5s0mNrtl0WPj9pAKVxme+jDhuVPX2WjOxEkcfUhNweJvKZ6oncrijG/bFmJ1pByV
         kuSsAZkAbo0iUJT/dUp5bLee4tbXyDzXNtUjFSLUilpd3G5/KIynUm7Z/e/K3ssJTabd
         D3pjwCF91k7jH4AWtGLaQA1s/4zPfHBtTFMMofPVvfO4TOPzwSarPJbhMkssJ9sj1RGB
         gYFIw5p6QhW4SG78Rcke1kTzxZb9KjmyY5mtSCscGm4D5K3q1bWo/MHZYWI6YE0JjrH3
         +M+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kl1lMLuqhZH+LLqHtJT6QI0oIm+dpJplZfZi0YBu//s=;
        fh=vAGB4PQhFKRHPEOpXDdaGqdmSZF/qyDCCdjC50ltAzs=;
        b=FDU0JugtTaSdoQX8cx7T+vkqHaaR/5n43iFCuB6V0ggXgTdOodFva5Hg5qvmycoG8P
         io0RONKESaLSyq6Ifs1mlSw/ENw2GQtGZT3lzr8nxFkZUAcL3fp1Y6d8ENynoeb24kzG
         pQBOBE0O83yd2TNf4Ekq1reQRWQ1u0P6VNeypABAgESUQ+fitnl9AY9odooEAjwIJmxZ
         /PH8P/YdbbLm84Ro/GtObiHKuIb2jS8KYVL/18Fsts7oP6ckFacgu331h14e6PJ5brwV
         NWMw83dLsbhPmPRR1GFcRzFU1iJyH9Z8Td55iQiJNEGYAj1rCRv7FTYpyTK809h8QhTq
         zVxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795538093; x=1796142893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kl1lMLuqhZH+LLqHtJT6QI0oIm+dpJplZfZi0YBu//s=;
        b=TTfD3o0BLhOt6X12nwfcIRGVYb9Tg6G0UpEGPt06nCVhs3EsfF9sZRAiyiYtMmlDXs
         va/lM5ylYAkLE9JrjT9aBh8u9um5C/Aiabv/RVXBEvh4Ry6uz+n/mZKLchIW0wUwUKJf
         S9lnaf8ctnqeRyWRpCOysIX/jW/XAWDNMPOVjhTASxwjsn2JDkamO6yA+In3FFPD3s4t
         z8mybQii4457OpqE1phzL3POgdHqbEuIgmYlDo3X5wbXm4mzhtOQCV3r3AeXrvd8P0Dp
         +jkirTLgTpgytyL9hge009KHT5Sd3nlecoLqnplQ4NsT9QWnl5SZEi4TZ3KbNaYdUqX5
         GJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538093; x=1796142893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kl1lMLuqhZH+LLqHtJT6QI0oIm+dpJplZfZi0YBu//s=;
        b=heX8lamtYbuNBjmHoDXllDOlbCl0PbGZ738XSTXvHkTeSr8D+IZRmLtqAQqjqk4KTm
         trcGq6aK2eJiYtj1OEkFdhbE6tfWMM4u8MqfJe9bwK2Xz3un930O50aGh7j7WVhmuyLq
         nrZCo1CLf4JPb2CNdiKFPtywbxJjJYm1Cq69guphzuAAgJORlPPvYNhiWm1VvWSA3fN/
         2kCtf/fYyXqG5hBSzywISUo5xkFVermHwsQtZK3b8dDtcalZCi71K5qWVWMgiABnjkGy
         /P1rEs0qOr3hZRLRCiSYcwROB54V73puHtvRJrz316arMgtGEKcJ2ebVtmTs+7QgcyI8
         1wRQ==
X-Forwarded-Encrypted: i=1; AL+hErEM3GNE9uLIM6WuEnzXisO3A4b+TKASa1aJ7fiBC12ei+ofPADiYUE6ZdjzdaFi0CnuS1opbzs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tkn3fJRnpuS9dWiEUDhD+F5ODfkv/sjULdFviHbcAzxncAutY
	dcOzRJGzOk81HxRq8G5TJXb/pnzoGocN24Ze6WqWdWsAdY/i3dSnohNju/zRCk1oDB5QhYx/QuM
	8AzATTkLFuFcZ3W51Q+uXU9/F6RFusXlW6laI6YeX
X-Gm-Gg: AZFdTZfLeHiZItH4/g3dXMbuWcKlaWKU/pUFNIybyKJkNfVq8EmIqPHdsicwCTTcDe7
	rzK2bJbpBZdtlQHZirvRxQv0YeTTJrSGr+yrcFkOTym4fuE5hIL5wSSYCasENfYdpqMZl4nRD+U
	NecmIWSU9Wbb3x/lXHy4t6rgo1S9mqf4bMNES26+q5cVHx/crohOFOGkeDHOfnrGO0o1cTCHwKW
	ayNZ+1bE9qcEv0uw7+XHAKvBoBsR+cuX6rx2jZllZ+pSIjRCI5DUeoR1A5NtdK26GG+XtyGuads
	/blh0SpSqoZ98I6bcdMNa0sDjVrr+gzIGhrGypxDZb1hDH7lKRgBlPFznT+m7Z8cwWhHVSOh/MX
	hr2J3CLvbZGUJ1AY81iBdm7ITyX4p9qHR9XqVCrofGcuUYYhgB0GZOK4qYqaH9dMthZeor4zp9K
	H5o+oWuPfKOXEcRwjVVBy05bxdKIY=
X-Received: by 2002:a05:622a:5c13:b0:535:30a:76c7 with SMTP id
 d75a77b69052e-55d88102d7dmr59797711cf.3.1795538092021; Tue, 24 Nov 2026
 08:34:52 -0800 (PST)
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
 <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>
 <awWz3nc_b8x3mIXq@gremlin> <CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
In-Reply-To: <CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Nov 2026 08:34:40 -0800
X-Gm-Features: Aa3M54psUndAWw1N5lTEQVLz0Ca1-n1kspbSD8lWK-ihjsexo1mFnquPILpy9Cs
Message-ID: <CAJuCfpFuDCUPTUi3SuAhmbtw5tubRZ0+YEY3PotjyJ8Or8pdQQ@mail.gmail.com>
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Ingo Molnar <mingo@redhat.com>, 
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

On Tue, Nov 24, 2026 at 8:06=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Tue, Nov 24, 2026 at 9:28=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel=
.org> wrote:
> >
> > On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrote:
> > > Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
> > > that RCU unlocking move you don't need other_mm copy and the comment
> > > that comes with it. VMA won't be freed until RCU lock is dropped.
> >
> > Yeah but they can be reassigned? They won't be _freed_ until a grace pe=
riod but
> > they can go back to the slab and then allocated elsewhere  right?
> >
>
> Yes, they can go back to the slab and become a different VMA.

Yeah, you are right about that. So, we either have to keep the RCU
unlock in place to keep other_mm comment valid (my personal
preference) or update the comment next to other_mm to explain the new
reason it is needed. Either way is fine with me.
