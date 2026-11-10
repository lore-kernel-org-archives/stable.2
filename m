Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342980;
	b=VZ2JLucV9oJ+IM0PIJC8//803WCFM6bAG/dnTNZTFdrPtEwvxGRcska0oB9oOIsjam5D
	 ncPXWZdcWH1UNFEajgcVHnKdqWAKwGs1h+ONYHtgki+Ek9Q1Ue07D5L0JEKCzJ3li8SzF
	 +f4sdfR7kARBJeo50RZphEvqAXol0s5u8hL8db+y1PPz/340fnqnYFVts/uJ9kHCQV+8r
	 Gkp0rrnBJAIQa9Ow4b+SKMCyJHTf8ScNOCHTASmIMgeQmFYX4nAzUivOeb5NQfV2tNYhQ
	 oI3bQfKHTIsDyUPkQN45Kj6zsFnkdPepgbLXw1nvgZ6Cy0IPdVw/Gfi5AB5YewLPthg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=6OZSyM/+htBjNF4ew/qY/xFoQA8rG85Tyx1BVaZ0pBw=;
	b=jCu/8LwOgodY1DY1aKsUqzRwBU6NqNkUyKfQhMJGq87wyJ78WYi8v7ZkdgjUbZSEx0zj
	 r3QB849KKN1OmWTO4vxkFEL2+MEUj7JcIOynyzJ4yPhDLyff04qcULKsqUEoJM0TrSH2T
	 OJj5Z0AyUWd9nVoPVV1/UVf+cMSxNoYpY90mGsarf4f0a4rvtiLdEiS4oTkQkIisSLsxm
	 NhiGgcPYmDnLdszJ9cYabwNB/A0oIWWeF4rH1Ke+o99Ivet3OCiPOFWp/72tL2KDpcZXP
	 SEusQ/+wEVRv/KIW9ceupT3t69jMwg/JzuoONGZ7brd09ufJHesSkgCr9NjV/xWgVfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Zhlmgyki;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405A606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F405A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Zhlmgyki
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91eb5559b34so18898766d6.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794342978; x=1794947778; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6OZSyM/+htBjNF4ew/qY/xFoQA8rG85Tyx1BVaZ0pBw=;
        b=ZhlmgykiQBV/u2WhbscMVXK6Y1sQWHXpEGuRYrJV+m+Sy3czagElgsbQnO1tXvrYyE
         CWJgwrNpGLXo/jy7vc02HPJ1guDdOMR+yIieWbTjFOIUywzwEzmrDSi2fWy+uJTgOpJi
         3eKYH+ZIruLGWW/orfEYMYLKZIY6i2n7TfKAhOGIZOlXQznSLR3WAOqO8h4m3BECmIoe
         owFFqVJQhHeGZTXJkCQ2I/PLDG3JdiU3QkgO6G7ZJUMg+ZOOlkNuJDi5ms/sAYPlKnXz
         qdYsk+ND5WxzhqnN6aaVqqrwnO6NlwrnerJ5QvQihQFDlj3YiKtwAR+nvymMk6ZSAbya
         QiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342978; x=1794947778;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OZSyM/+htBjNF4ew/qY/xFoQA8rG85Tyx1BVaZ0pBw=;
        b=SWzGJa4HCjTj3kal0LFPre7oeFQvLEJnflCFEJXNxOM4pFPFfYFjhP7iDA/RGWl8Ef
         t0v9CnA7T/mkIR42LC06Umrb8+8vevpC5MwmWmomy6d+nExa3dYBe+ECYppTo1lgINVb
         eRzSbpSbH7eWR81pVlk3Zm0u+uU6HpY7M5PggDNNU4obDqdhjC2Bp60PsuXXwRXfpx66
         0OhCdJa+x6TTKbFKYqRa0yeY1xa2uRTXYoNRf4w39rKkHGKr4PG4lHdeXW192bYRdp92
         ON7JZATrQn8SvDyTeHlTxdsIECAjIbfpTs9KPDu2fvpuc1JSxn1z8GtnGG4tfIQ98+Qm
         QPaA==
X-Forwarded-Encrypted: i=1; AL+hErGc+V7wYZGZx+z5zUCpHxgB49TpVthtP7HLJF20iVM+PgNr3e/tMyzOTRXleWZ9BAuZ+OvCuP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mvEZGUEmTLz6brvcfTOmheBrMV5lCJKaRsNUwqM9tiw9ISroT
	1Ijie/Cbom/NsTHpdTz4KqLfSQywUCqx671POUgQThwFpDeOmZ9gNIlLztB9/aUGS9k=
X-Gm-Gg: AYBFou1FJUYVsAMnJuEsgKmARBjqMd96GfA4Mlhty1soAAegIcI9Y8kQKW3a/bn5zwO
	wFrODMMeSrFtji9u/SAIKK97NmIA8jS+tDfwOTmm9p2Le+VVmO0uG2FlzGMARf5HhftU24dZjZQ
	eDeG52eO90RVJwu2lVjN1jsu6rq4PjY7vbrd3dgys7YYDVTkzDzJhwKyGCaM8iqHFPUtFBJMNc/
	JqoKKr9vj2XulucUslvWufThCtLdClEqXoi0x7Dbk/VFuE8yqtfeojoVX9S/emxWvnvJ2q+Ubgj
	DNuFeS9m6LlZBPpA99wVw5RmhYzc90J1nqZYuxRdZtRf3+v81FBkLP5b/9I6H7vExwbtt2hIkoC
	KkFnO2y+BMhy56WvYQdYfgfMxxAl7DTtj4lk+gnnmHJPmrGKPVUwX96XptBKQ5JI3rpNZTE5JLU
	Bnu/P0e5jDjd9tOGgjxroi0Q0NPQ12h74VMdjwMNAK+BvnokgmmWSQ7g/Zbkh3Yc4cC2oCgKeIB
	u1G28HlCoiS+Yzs36+EDntvWpinYweGNXzehc3I/fsNMuYG9dsbHmFBH++kDHxIK7tmR2W2NIUJ
	/WqLrTl9U/XtE7YRk4R4bdpJLsakqCQP9C4i0tdp4qaNb8WpjTsad0CHJ6rdTCoyjMw+N1qgbMg
	XdjaFPug=
X-Received: by 2002:a05:6214:4487:b0:91e:a3b4:9f1 with SMTP id 6a1803df08f44-91f03c0725fmr9307786d6.0.1794342977608;
        Tue, 10 Nov 2026 12:36:17 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f04c2b8bfsm1195296d6.22.2026.11.10.12.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:36:17 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 5/7] sched/numa: scan PID-inactive VMAs for
 promotion
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
 mhocko@suse.com, peterz@infradead.org, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@techsingularity.net, mingo@kernel.org, 
 vschneid@redhat.com, kprateek.nayak@amd.com, ziy@nvidia.com, 
 baolin.wang@linux.alibaba.com, nico.pache@linux.dev, ryan.roberts@arm.com, 
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
 usama.arif@linux.dev, kas@kernel.org, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, 
 hannes@cmpxchg.org, osalvador@suse.de, raghavendra.kt@amd.com, 
 stable@vger.kernel.org
In-Reply-To: <20261110150446.2452975-6-gourry@gourry.net>
References: <20261110150446.2452975-1-gourry@gourry.net>
 <20261110150446.2452975-6-gourry@gourry.net>
Date: Tue, 10 Nov 2026 15:36:16 -0500
Message-Id: <179434297609.2530531.2349001562856798404.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-10 10:04 -0500, Gregory Price (Meta) wrote:
... snip ...

Sashiko report feedback
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4249,7 +4249,7 @@ static bool vma_needs_placement_scan(struct vm_area_struct *vma)
>  	 * threads can help scan this vma, force a vma scan.
>  	 */
>  	if (READ_ONCE(mm->numa_scan_seq) >
> -	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
> +	   (vma->numab_state->prev_placement_scan_seq + get_nr_threads(current)))
>  		return true;
... snip ...
> +		if (placement_scan)
> +			vma->numab_state->prev_placement_scan_seq = mm->numa_scan_seq;

Sashiko took issue with these skips, but its reported impact is
overstated.  It tries to point out a pre-existing condition:

  prev_scan_seq skips an update on a rare corner condition, but
  now the same skip applies to prev_placement_scan_seq.

In modes 1 (placement) and 2 (tiering), the behavior is exactly the
same as it was.

In mode 3 (placement + tiering) the result is that the starvation
counter isn't reset - but everything still works anyway because the
VMA is still being scanned.

I can follow up with *another* commit, but it's really low impact.
Not sure it's worth the churn.

-- 
~Gregory

