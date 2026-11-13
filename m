Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602654;
	b=nIVCOqWFpSxbhsY4u9A+Np15GTZdDfJN6QFcG0t6QuXVxioqCMQ33QgWncUP8AkW6/oZ
	 JntBfJ8CWD21KiAd1nxYOguF8yubCexmBkTLcAUlQ0gv7gt38TZu4hTZDHfjYWFYgoZBx
	 rp+uk0xGkRdydKkTV93sBgoR9t4kph1i3sk0OWcah/TbKxyfJXOdUlswoDL9Qk7oFXI2x
	 x7524xj7hIM7Z9gKROlOZH7lIx6k29u2whFr2KfWNhL0rRfRZrDhNIVZMuJB0+ZYdQ5Gf
	 o1J7HWgWGyyFrdRIyNae7OdUDLDWq+ljpHNVw2kTWd9UgN6/5D9DG6l/29c5ykGvH3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=NhL/M8HEMn0PgEwzPCvcTjQTkSJqxruxvyvf5fU6t/s=;
	b=d150aHmYTX4BGNtrDtSuCyv/LUAPx/G5yGED2i7SHfYCp3y/YLPVDkfd/bPWG1KVvGP2
	 DOUnoK9BoI8OJu9sT4lI4r6R5LjBIfoZZEc9ebxrSlQY4Yu05enMWmaRmKNoN/IzN8sYc
	 UTQhjuByuwsvpaFB46CoHMx1Hang73FSdbtqYA8b8oq99lsLOclgLzzMXZJDpKmpIHpqt
	 Vj9gJ0MdYJpiv1+lhPWXAkcL8JOsD4gxTwRjGV1DYko8EQEKfajkA3LAnOdl/IOYhoeCj
	 l6bEus8NMVCZDq9LF1qs0Isbc86dGkAcakotDh68gcavqXlcUgKetKkyANeXInzo71w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=RBpqL0ec;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ACD606A335
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13ACD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=RBpqL0ec
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91ea16d8072so18766986d6.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794602652; x=1795207452; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NhL/M8HEMn0PgEwzPCvcTjQTkSJqxruxvyvf5fU6t/s=;
        b=RBpqL0ec73lueiGVkPbG1IHqA/miVhGt/x78w0yuwuDBNEkC9OOEfuktHThNoxMzVX
         lEvekudGBBlWCuLH66HiQ6c3TH0C0kY7BRvuMJYO7RNsIeQnqBXAzvWt+6DJEdzekP8F
         dtd0byVRQC4qVGHuRQRcWHekZJU5cZZR2pT41sfu0D2VVOCcwrjNy6CfwVnDT9wJNaBp
         3j7ECdgERpI7+oLaPrDtP0BkTV6Stz2Q/u1OqG4IUa9w470NCAK7r7hIGdSgRpn3Ap4N
         jwI8XukywKVjkgaoD6hqy79iAK9/XG6F8QD6k1tdKDtXHxf+LN/i5T4RyMkE4okbmnGN
         QLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602652; x=1795207452;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NhL/M8HEMn0PgEwzPCvcTjQTkSJqxruxvyvf5fU6t/s=;
        b=mavEIYZEJxgpkFHtWwt1If+MQWhfT6n9m9D7LY0T13hTB5Dqc/DQ8/bxzBeHW53JA6
         ZyHu5O0mPv+c3rfvN40HguYztCLFnZVECDSFlE5BibVSbgzp/+k2GXpQMoEip3tPjc+G
         z6SMVzFEByhZhfIrhN2Nc+9G9lZZMYEjXtkNuVR899LPO/xFbsL4YZwbTMs4ETQeJ2y0
         qpM28ZkYQljcdeJkS+mcT5jZ7WxG/I9q26P4xc9DgqAalUIAxpl1sW8HeUmSY6le7pxL
         Cvj3E+XfABrq+aX5O9mq0FfGSpH7KLPSOJhSbMxtwT2SFly8CrlMK7sCKmTmAea9x8vE
         HuDA==
X-Forwarded-Encrypted: i=1; AL+hErGqLKvpdlF5NUsnaKN9SIdbreKO3FakTIn5yw5NzRkrdyIYDpdh/lTZru7kuQMsS87xdVjMthM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ozATa3SeMcFDvTohO+7gTW4klBOBCsxN+1DcUelar5wqUNFo2
	VPwkaThoIuduj3AMLtxDkIpY2U49q97VtJ8NpWj0KksMCrXj95AhthRp7jXso8ifvNQ=
X-Gm-Gg: AYBFou3SVAXv3YP9juWVG8ZFG9IAEx6UqWm8ztHAYXlDbi7MIcv/qF8JAzNONyVIGhx
	sQEipKfE+Qu+Okh9nqJLF9ssAYg07QfAc0NowmTbl5922NYvcEtayNVIUCiRUsatYHRYdkq26e/
	7JrNpDc3hgwFdRQhXHVnha/caOoyFHq/lvr2Yoj5ngIanCwUXLkbq8BSxiOFKjg19LcDAQ7Hzpj
	a9luLfEy6LaMyvdmTIeS7iO/2fcegmMsKxntJXJT0hPQVJpiLFC+shs4ZFMYVcIx5eZQHFqayql
	z7q/y6gnXK1rt3bozwYgeNUTZ805zRjdcUxVtCajNe6X++rCdAzEXvv20habUIOkS762nECrqJ1
	prKdINMShfFe9OYG8EOVNounbfbaiRgVlS8Pt/YMC5X1DfOqT/UOGbrQa+UyVfeq86+K3j0OpPX
	B/lLf/v6yj5Vit2SL+sh8Gf/Iquxu5y8nIr7aUV29lukhtfnF9prJFVZxQCxaJ9rbeo8aC8wkbl
	9Q6cTgntf+G4ZmjXXLMb61k1SMPWwAs9l/Bvn3Vo8AV/f0aEDJXRNUPhDjbcQy5bfZiiodA37K+
	PdisHSqNncVkgzRau90FkvLORX61/v98zvX+4f4vDPy2Hyxrj7KmBFDreFCZQ5EWDq0Jk7FrDk2
	N8VyxTjA=
X-Received: by 2002:a05:6214:450e:b0:91e:b670:f9f5 with SMTP id 6a1803df08f44-91f2401477fmr56726586d6.3.1794602652059;
        Fri, 13 Nov 2026 12:44:12 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db49c5sm28150796d6.41.2026.11.13.12.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:44:11 -0800 (PST)
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
In-Reply-To: <179434297609.2530531.2349001562856798404.b4-reply@b4>
References: <20261110150446.2452975-1-gourry@gourry.net>
 <20261110150446.2452975-6-gourry@gourry.net>
 <179434297609.2530531.2349001562856798404.b4-reply@b4>
Date: Fri, 13 Nov 2026 15:44:10 -0500
Message-Id: <179460265050.482102.15374067770225444971.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-10 15:36 -0500, Gregory Price (Meta) wrote:
> On 2026-11-10 10:04 -0500, Gregory Price (Meta) wrote:
> ... snip ...
> 
> Sashiko report feedback
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4249,7 +4249,7 @@ static bool vma_needs_placement_scan(struct vm_area_struct *vma)
> >  	 * threads can help scan this vma, force a vma scan.
> >  	 */
> >  	if (READ_ONCE(mm->numa_scan_seq) >
> > -	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
> > +	   (vma->numab_state->prev_placement_scan_seq + get_nr_threads(current)))
> >  		return true;
> ... snip ...
> > +		if (placement_scan)
> > +			vma->numab_state->prev_placement_scan_seq = mm->numa_scan_seq;
> 
> Sashiko took issue with these skips, but its reported impact is
> overstated.  It tries to point out a pre-existing condition:
> 
>   prev_scan_seq skips an update on a rare corner condition, but
>   now the same skip applies to prev_placement_scan_seq.
> 
> In modes 1 (placement) and 2 (tiering), the behavior is exactly the
> same as it was.
> 
> In mode 3 (placement + tiering) the result is that the starvation
> counter isn't reset - but everything still works anyway because the
> VMA is still being scanned.
> 
> I can follow up with *another* commit, but it's really low impact.
> Not sure it's worth the churn.
> 

I will refresh this next week and just address it in another commit.

-- 
~Gregory

