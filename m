Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93512D59E8
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791596595; cv=pass; b=KWC0VfgV+fZbBafbSrYwqRQSdG+ARJT8riTLWGNXlYgdkYjd97rUl7QqWZmIodBOyJaSJ4Cl0PG9dR0Ht9kHXbB7XHJ9i279iL69GvHndRQYjZA4p9/5Qeb6Hw6EY8uFESDy4i2kpABlehAJxVMHVbei33p9MIQ3wHl80fvF2s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791596595; c=relaxed/simple;
	bh=dLHjI842JfdyXNE0lCpGbDvN4U+EGuIm2s0SXDnWoww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2MQI/lr6YIM8D+YcFXLV1bap3PwP3EIYF/JR5Mm3Rme52+iRraRhahCnvk1HF6wv3vSngIoGm4E2ROtFofi8yaHE6TpIQyvNFdfbmO3riIMZxSfeYADyCgwLU4iphR6dWYg6+5huT0jova8rjRSwmwu4x7RItV2qMlTMKdN53k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyuU8v9u; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyuU8v9u"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bcb2ecebb4so175905e87.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 18:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791596592; cv=none;
        d=google.com; s=arc-20260327;
        b=OFwbNmf5fhm1RwRFRUh4Aelmw6NV4wbuQXSkrox5UvoGFecLOhT4JdkZNi6seBOb4t
         BDDr+0jEtXrKhntVPmSI0AuxQUKMkzhNTt7roS7hOUXgZjyfLEbJ+wYQshjKz4eynnfz
         pO27NfeekNpSm6ppFVKJTpcojT14J7dXWJqRfd07mFmbGoLp5sOg+wz2jhMtCZoII2qI
         h9NoBRuZUc9iNgp1fWDgqBsBitNrRs/nhf7ANzwbIjIKO6nEihvgh1zULlXLN+6QDV8S
         uX2gkkQDV+fRt/Qik6NFoDLaZK0Kq2V1bJ/Qs1OrWKNIQG4bOu61ts2daNFtiDs2T1B0
         uVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EyysmEI4Etsf9glt231lGx5fXVOH6sNcjfT+1NIiX/w=;
        fh=beyIYZUrCxNIBnHnavt9dGqBlrL6WyoAqtrR8Bvr4H0=;
        b=l3T/BY5udRIltmLNvpTHjzbaEMCaMKurOkA/0shUm57bvS02JRaZpwcNy1PjA+iA8k
         bRQ2Q47slbagsLAEcjwnHeGMp1CCRLiBMO7v76TRUqzcwWq/OeJG0hhz6sCI/nDFczzd
         3JljMZqt6Bw/4hXNdQToRHG/sdFsgetxXe0+prJ11xOtV6kw8Td3EfWd31bnpVxayTYr
         58pQMZgL15B5kf8aaEmRYeTpOkrriN6OZAY/KJDBOO1vd9G/X18wOrrZwJfXOEvquRHH
         olun0elzT8dOtzeZRXCPPhD6fiZ8uQtpZDO1+9v0TmI89KUTUGctJQiA6Q2ZeV+ETZxu
         Ufsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791596592; x=1792201392; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyysmEI4Etsf9glt231lGx5fXVOH6sNcjfT+1NIiX/w=;
        b=IyuU8v9uBMAt2Og+hiGQJOJlwHkTIx24PQ6rjHShK4vSDMBvCFV5kK3I+cJgzFuVC1
         aB5KIo+AdYB2vLOydrqpW5qjIwNCDAhaT0NOHyVzRXI1Uc85gg69RRQ4rNmBR/ApK/WN
         jxQZUrd0kuvmlSJeX3gm1qBp8A2jlMLe7RzJFMmId4/u7jObrHUczcsWFn1XWH85LMaf
         pXQ1CkX1eBAwlUA5YAkACcLwv2dkmJujTOZuTi/TYnmQKu7vA11h4p6ZOsi5q+jfHcOf
         wHD+Ax7b/4O8TnqqujtTLIqUuhYfPLu0NSUEjhCtubjnhv0OHItaTOZ0x+wVTWgrajZB
         AOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791596592; x=1792201392;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EyysmEI4Etsf9glt231lGx5fXVOH6sNcjfT+1NIiX/w=;
        b=XcS0rcyIPnjzLn9ELhseGNoXGjwFSLn/0Vu6ma0EaRS2cMlrrRai/P7Z5n7hZgKFCy
         1+NlKQ/6bNDs04ATaE4hbAwMVEt9Hk3ECDVXX838/CYPaVrwfJTppxNO/R4vaopCSQAW
         UqjUQJPVdfdk8j+DObu6v/BIDGOlWXhBG0NYQNsziOFJr+vYSwqbA2TxqFl+kGTR1Snt
         +u4U9J0wsNqBFHQsFl5dS3DQIOk9G0QreGnFl2jcqx1bSDtoJ0Kbff+NQ5o0cKI/8/hb
         G6tAiugB7FHjGPpJdF7A1NGpEzcyU3lgWNzRtuYJ9RYgAPl9EQDVL2cPvPk8Y2V+sC8T
         LYSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAUTB1qHjAXURYSoemC+DethF98v+ik/bWH3n/yVh85/oSXGIH1v0IHw0xy4aC1Gp07d9Xmco=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfTIvqzTLdi9dbdd7AAdSy5V9dqKr/ZTigJukFWQ8U/h+MgbtS
	cEGz9XHlSEp+UcGRxPesWdHpJRRfwF3Xg+cBwU2O6HMi8u0gXEQa1I8Hv+pJXkC4ZNqTI17r6u3
	Nthl9uLzjN1/F76CAXIJgHNGMIp/+Ykk=
X-Gm-Gg: AYBFou1HqZC5KGWhFQTC4dIQe7m8FyKe6LozJTNGzNBlcEArwqfn8rkMv2MhqG6LPm5
	oXBO+CBPjtdFpansdX31+me6WtBqwysFl4h5ansGB4uI71vWs0fGyWaNMqxfHSZH6gwyKl+mC8T
	aHaoNyEreqD2/4SNrq8402x4407gV2Uys83fAiEnV20R1ZX0xyVb2xRb9K9JZmKn4S+BOkd8/O3
	3U3IfNe1FJtOQ/hGcOplAxYT1d2QKM9L0yIsvHr1YyRKHUOWLigqdFP7aHafmKXmnBctSCnFUBF
	I7y1p0qBlSYHGH//nInO0sYT9P+k38Ev0VZfUApJ7bkNC+Fws8jPZkcUKlTAgkbD5D3LiomBjzp
	NM3c9nFq88ZVuvs71wVFlGgD9op1ciDDasl3wvIVcuSxFDyd62XAWN4yCtUfkFP12Ac4P/Wg=
X-Received: by 2002:a05:6512:2309:b0:5bb:7ae3:bbe3 with SMTP id
 2adb3069b0e04-5bcde8c142bmr1156652e87.37.1791596591709; Fri, 09 Oct 2026
 18:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009210449.971057-1-linmag7@gmail.com> <20261009210449.971057-3-linmag7@gmail.com>
In-Reply-To: <20261009210449.971057-3-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 9 Oct 2026 21:42:59 -0400
X-Gm-Features: AclHuK-vtZnBj66F3yVBEX9kA7XqzAvRwZHKT-o048qUxLS3G15CGfwGYGZihvM
Message-ID: <CAEdQ38Hu3OvqD1KtcEKLb55aCzPu6+Dd+uA-YQNfxzfv9kfRsA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] alpha: run check_mmu_context() from finish_arch_post_lock_switch()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 09, 2026 at 11:03:47PM +0200, Magnus Lindholm wrote:
> +/* Alpha has no kernel preemption; these callers cannot migrate here. */

Nothing in the file says who "these callers" are. Something like:

/*
 * Also called from kthread_use_mm() with preemption enabled. Alpha has
 * no kernel preemption, so the task is still on the CPU that ran
 * switch_mm().
 */

> +     /* A deferred shootdown can also invalidate a newly allocated ASN. */
> +     cpu_data[cpu].need_new_asn = 1;

That closes the zero-slot case. I went through the window again with
this in place. An IPI that sees asn_lock zeroes the slot and the hook
reloads. One that arrives after asn_lock is cleared flushes the
context PAL_swpctx already loaded, and the hook finds the slot nonzero.

The hook's __load_new_mm_context() now runs with interrupts on, so an
IPI can nest inside it. Both are loading the same mm, so the worst
outcome is that it gets the same ASN twice. flush_tlb_mm() from process
context has always had that.

Reviewed-by: Matt Turner <mattst88@gmail.com>
