Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4EC3370EC;
	Sat,  8 Aug 2026 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786182035; cv=none; b=j8AcGVDrjgNiOOYkFHA+W3t40dl9t6WAtrizvTJxLyA3HrtRUq7Q7rTpsfy1qWUZW8qg++nkfGfy47h4orW7VRRwq1JS2jUFAy1d6FcTs3L06NXaSlqAUV19He5fXPOqdvCoQN2/cnjZyP4UL7tEmJNYAU8uxHsouOaNTN7bpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786182035; c=relaxed/simple;
	bh=gRV1kwqU5RHQTHlQfpmYtdV6xt00OI6I+Dow0n6sLoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oezDV5E8iLzTBleSMhMTYWYB2/RAHGwnUlBe1ucgYhQPJT9XPMGBhrmXJnsxE2hasuBMegfw53YRzJDLPahOX3M4QlzT+QkJQeN325INNGL7McZj1Ptta6GmrSw2YcuDxYOXvlQRe8O4YxKWoVfRzjcgvCJFQrEMIQ8NYxzuVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Oo3tU8Ay; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Oo3tU8Ay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=VU
	MOOEBQX+6lir6ARl1Glb8AZ5ih0WCL/+4lwXJl+Vo=; b=Oo3tU8AyMnXEomyka8
	r6FmDIHXVz0qz87Sd6P1Aqhe2Fc/zwaqmn2NjlKptlmUcOS59EblX23BOe0NHIfV
	SbdSEZdY7mPpNxnKRGoCfHHuIGFKg+TbmB5GNkSMiauqZsYm9jiqL+NlyHuZrGfT
	g7T/Bv1/wvXxjqtsOMJDDDCRQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wC3DONb+XZq2dtFMg--.6252S2;
	Sat, 08 Aug 2026 17:39:40 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: akpm@linux-foundation.org
Cc: andreyknvl@gmail.com,
	dvyukov@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	qiang1.zhang@intel.com,
	ryabinin.a.a@gmail.com,
	sh_def@163.com,
	stable@vger.kernel.org,
	vincenzo.frascino@arm.com
Subject: Re: [PATCH v2] kasan: fix cache shrink race with CPU hotplug
Date: Sat,  8 Aug 2026 17:38:05 +0800
Message-ID: <20260808093803.3138988-3-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808003921.fdb0df9ee4417b38f15e8c68@linux-foundation.org>
References: <20260808003921.fdb0df9ee4417b38f15e8c68@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3DONb+XZq2dtFMg--.6252S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1kJrWxXF4UKF4UKF45KFg_yoWfWrb_Z3
	48CFZ3KrZxXF1Dta10yryUJFZ0gayFv342q34UJanrAryYqF95GF4kWrnIgFZxKrZ3JasY
	yr1YqrZ7G3sFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUj2Q6DUUUUU==
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwh3NLWp2+V24IAAA3f

Thanks Andrew,

On Sat, Aug 08, 2026 at 12:39:21AM -0700, Andrew Morton wrote:
> AI review suggests that there's a pre-existing quarantine_size
> accounting flaw later in this function:
>
> 	https://sashiko.dev/#/patchset/20260808031459.3032812-1-sh_def@163.com
>
> If true, I'm surprised this hasn't yet been reported.

I'll take a closer look at this. If it turns out to be a real issue,
I'll send a separate patch since it's pre-existing and unrelated to the
hotplug race fix.

> Also, I'd like to see a need_resched() wrapping that expensive
>
> 		/* Scanning whole quarantine can take a while. */
> 		raw_spin_unlock_irqrestore(&quarantine_lock, flags);
> 		cond_resched();
> 		raw_spin_lock_irqsave(&quarantine_lock, flags);

Good point, that makes sense. Would you prefer that I fold this into a
v3 of this patch, or send it as a separate follow-up patch?

Thanks,
Hui

