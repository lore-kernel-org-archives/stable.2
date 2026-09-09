Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF163C13F5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982751; cv=none; b=lSak2sMpf32igzv91UN6A2b8GqOch5QAy5XiE2wkWSIH9f25K7C8OKfeHteLUsGVPlirTh6OqMpx9FkVA4lH3cJFkOPulwyG/9qF7Wrb77cFC5qsql4N0JoQV0NmmkBxiTBvN8tfzpgVCI8CyZEQ+tArGGrKjGAJq4XOuHdJP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982751; c=relaxed/simple;
	bh=9Rm+tBgNVRjYobl03pLy+QZc8ejHkh/KaIaKlECpzjE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIVKQ/exiHaAnDPWlXwJxi2OG86n850XxQVsO9j1YuBGCFbsngUNKxyFdxsn82bbiCQC3c+4IpUNemHUjiwBoLzCy6HeJyzsf0RO/GlR92Ohy9WusZZvzbOhhOAchiCO8yHpOcoIYMnx/BCYK+QBRfVL9ljyqpdnIeTtIejorl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Wqc3o6sV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Wqc3o6sV"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5301db51586so14819631cf.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1788982747; x=1789587547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1GUgXHgHoEl56pUUuNlJgXsrmqq8UKwhkWovOGCgHHU=;
        b=Wqc3o6sVJaV6tlhBxFS5tIYySDkREgBIDorYA/VwP01U90VqLHv1+lEtANetdwPO5c
         a9pV4HAZ3KmC8TEWW+Zws+XckX8fO4DAYaDcS5AWn3tc9XOHSblhEnDy5YcTngkSkJo0
         zdpgvSqG6xZ2wpdabS/GGzUIV375g5nXMkjYP4ocFjyZqKokqwKfA0WpETrkvm3dA6R6
         HC8J0fQfshR1DfbJYdR8pvmzAEiM+kiaw9XRiSYkg+6ZAmEf9izLZHTR6xaVOEw+iwSw
         xjcv3tVlEMuiejY2StHlmTACgHlnQCVhMJ1HDg3qtyU6PITPNYYH74oxGoXsMxx4l80T
         m0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982747; x=1789587547;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1GUgXHgHoEl56pUUuNlJgXsrmqq8UKwhkWovOGCgHHU=;
        b=QxzHcwpIJ/PHlZf6eJP47+7t68eeY7VwUd3s49ptJopKjjzFWyCj5fcWDvnXgtKxyp
         fFI4Vgt8VqkJtZQq5CkmrDstV4tG2jhiH+Mava3JzPvgCWmtfSxvpkR3bmqBmbq/6Cu/
         YA/621J+KwHHw6KBBw9otf7hOWJdkB+E42yYj/8maaKMv/MW8gqUcCeqIVm1DxTl/yRE
         gEphnXlNdVaolVxM+vQvxne5mtZ3qctey8Myn7M9R7/xuBVhz5IgVKfnlVJpFDYidi7K
         ZF+8h7rrI5jNPd8TwXCo9H65OqNlngGRgb/1Izo6nXvKjn7twh9DhlYQ82ujUsDO1xS1
         szkw==
X-Forwarded-Encrypted: i=1; AKwUvBz9492Q16G95zwqyDZr/gNVM0Z3shHxnd4skfmzhHF6WpkgifddzE4YQ8VqzcgaUry2EkU+14Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lge9iDfPfD2uPr71kw3iXUNyXsgIg+sJbaLUXojH/TxFPqGm9l
	AvDT+ImR3rGAtcTuAkwaX5TsiJN8Bzoh7mDTXZYIQ4uuo1fXNO3Hwrd2fs58u+O5qvI=
X-Gm-Gg: AYBFou1qxH20UeJxEQ80M4nnW6meks9IIH3oml5gAUA1EQ9ZiXhpFXFradV+jes+blY
	el/lfbjy/jREoB+FMxw1phRCpciC+lBq0BQKwWE0XGA953DqnoxVolLadeWIkdfttbyI36GakWh
	VWYs4OP/z+PPn2Owk1owMtQVj61VMkLrXExQXQWzOLKGff7Me0D+dF2G+UuArcEwPTxROEI7mDn
	kQHBON2kka67HZrgSIx4IJKS2AlVoll345F5LeNI1vCEjPJ1MzcPicsDZG39TnbhXpjEFIU/tbn
	OiS6RKfaBKh9fD9G1ByDkvYrlxcFXbXwVvDK1NHDS7iQcMSBbvoQkyLfClefxpvfY/ca5NtjAKU
	n8GMDALGguSKcwXLdNWZgggob99d4x9Ct10EbDGeTB8/QxHkrL8MNRzL6mRn8h5D6V7NCEg+MqL
	frwVRsH0YnrpCIEyiz986fhiKsXO2eQZwh+BRdBXzQmnrMas0OvSJOzi64DXw19Y3ECnJG6y7JB
	qmGcdv4Vb/bIMOUQ7trsPu8chsiwcwoMhwBoRJ6jSJsGZ3pOyH0gkKkFkbgGHILZTo=
X-Received: by 2002:a05:622a:1247:b0:52f:f472:bad1 with SMTP id d75a77b69052e-530549f9b59mr430060511cf.33.1788982747305;
        Wed, 09 Sep 2026 12:39:07 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541c94ddsm151964851cf.23.2026.09.09.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:39:06 -0700 (PDT)
Date: Wed, 09 Sep 2026 19:38:20 +0000
Message-ID: <20260909193820.9aac7888ba9d@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, Dennis Zhou <dennis@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb drain pass
In-Reply-To: <aqGilhgcEd0qaHjI@slm.duckdns.org>
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com> <aqGilhgcEd0qaHjI@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, Sep 09, 2026 at 08:16:54AM -1000, Tejun Heo wrote:
> On Wed, Sep 09, 2026 at 06:01:07PM +0000, Josef Bacik wrote:
> > +		do {
> > +			cond_resched_tasks_rcu_qs();
> > +		} while (cleanup_offline_cgwb(wb));
> 
> The patch looks fine but this overall seems fragile. cond_resched() was
> already marking "stuff that can take too long" but we need to use
> cond_resched_tasks_rcu_qs() if it can take *really* long. There gotta be a
> way to make this more maintainable. If always doing tasks_rcu_qs from
> cond_resched() is too expensive, can it be be gated behind something cheaper
> e.g. some tick based test?

Yeah I agree, it is fragile.  Every long running loop in the kernel that
only does cond_resched() is a potential multi-minute synchronize_rcu_tasks()
stall now that cond_resched() is a no-op on the preemption models most
people actually run, and playing whack-a-mole with
cond_resched_tasks_rcu_qs() at each site as we trip over them isn't a great
long term answer.

I'm working on something more general so we don't have to sprinkle
cond_resched_tasks_rcu_qs() everywhere, but I expect it to be controversial
and it's going to take a while to shake out.  In the meantime these are real
bugs that are taking machines down today, so I'd like to get the targeted
fixes in and to stable while the broader discussion happens separately.

Thanks,

Josef
