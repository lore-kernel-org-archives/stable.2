Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531138655E
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494928; cv=pass; b=hpffnaOzbWMrwtJuw4QTfd81ip2GF2+QVwga4FF5CLm6VNbfAcNEIA3HEHYRoBkqWJ956RZdvnoo3CAzopcmMvjG5/ZZ89DMh89hEQ4MWZD2v9dt0dvWRlORoyEGmThVXfrp68ULxofKZEPgsBbi1sERuZZFU+vfedprx5DT5II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494928; c=relaxed/simple;
	bh=fUZzaM1SKbqdW3JJHyHXI4KVGCOzVMsele/HgdjkKFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9eLRDzaYggcEDkqpwOm6oc42YOlNgHiml8epRPc5/k2SmHnQWAMxOS8TDxbrefat/O2+AcdaEYONyOXjs+0LJs68ElkMgt+KgkfQueEX9Ew9bQx/aoX4ZD2irSdTvUQUfEWKne5L2yke017NV0YHWRt3gG797Xo0Uun2ZNnHOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boMZ8f53; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boMZ8f53"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e762768f3so347745985a.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 14:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791494926; cv=none;
        d=google.com; s=arc-20260327;
        b=QBY/qANGopYplEZn3cCs6W+PikTq7PdCTWUXlpXcLJh7pCBiyiVcdt/MobnJtUUxu5
         Q/MBL89PimF2hAtR9oiim5Wjk7HN9e9h/KamQe3rs/N8ov4ouzHe9fqMVkxDrXJNB4vK
         thaopjVc4+cEWb32qRrfQLpHXB3/SUqfRznijywx9FhG8IK86x5RkLMp7Q0rfW0M9A8Z
         RrqyBlhDNUpvwIx1lF+8tDMoAqmgxDtnWropBLqwJkf8TY68RuVgBj6cTER/Cr04Q5HN
         BXkPl0XVqXl7+Uo3JqmydQAUig9XbtAbjG3h2eB+CEmPCd8imCn9ChAgRt4kDuwag8Vk
         YyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fUZzaM1SKbqdW3JJHyHXI4KVGCOzVMsele/HgdjkKFk=;
        fh=QUrzrspW7bm6VM+AsWf6T6C9X1kaCFtnsXk9w/ohiM0=;
        b=B+pNH0V9JUcGr/4oA/XltnI0V5A3nPvrAUh2E4bt4g/SdfTX9AmPnhOB9Uy1p4b8L6
         2qGMpcXVIMY3Z1X9r1QzyS7pndy0WOc2VHv+TJvUALyZWX7m2x1Ulwik4GXUpvKky2zp
         kwJ4wdO1P7Gc2XBJFVYiwpBAGoxAauJwUT6IcsLHKZKiavX8cyGPiAETFRlo9TvHtrpH
         qpZ3TJU/dhh5qOvQhPuJ73Z7Kdq6xBFpH8CfxoiVRlgvTObXD7vznXjU3z1yt6Y3Zkln
         magCH2BBDyHzuPqZvtVCL7diw9JNFovpPhD3vR+kX7Q0mYMBACHZKUup2pVk4vvu0cNW
         ILTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791494926; x=1792099726; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUZzaM1SKbqdW3JJHyHXI4KVGCOzVMsele/HgdjkKFk=;
        b=boMZ8f53+xBhpSoVelH00iqF8x10h4+meXcCUWzBHey8LjNmIfIVbqZmmEexbcTvFG
         he446YJcgGPHFugkGuT+roTmak2ktCciJDrvpot1x4uFeglIt5J51H2kVJr6dNjYh8i5
         waL2C81DMo+uWA4Y9xJ8oB6HoZDVO/v9z7g6gEgQ34I1GhC3xgITDexMZcsg6JpfDvms
         oW9iR0m4gngNXJdKONDh86YLKQiehEjEwd4FR2hevPc1K4zNDMShkzfzitIOyzUS36SJ
         7pXGO79LLqfEyk8KtRfUicykue68ch1AanFvcdGVPhJYB7o++Mqq1aLlj5LjIFgB1mqI
         k3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791494926; x=1792099726;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fUZzaM1SKbqdW3JJHyHXI4KVGCOzVMsele/HgdjkKFk=;
        b=IH0ytB27qh4c4Z/3P7sg8SdsDlRgROYTBNfSZa10mzCQQcourMQSIYfweF/qttMPqy
         jAJNQ7AUS3p3iDAdQVqdOq4JAW0DM7RkRvT4Jbg8d84YGYxB6Cg/zgBP6mcnCaPaxyve
         aHkmpVKQAThcAYb5Dj9yS27PEB5JbLZhjU+n0YTWnb1ZyP9BgONP9kk6qDFTUJ7cVonK
         xgJ7N/Muneb1lXrgBVC2Q0LNSIOLWs3sqZ+8GSCPtC1PsB6fD8Im256b4fpouM7hAA8y
         XmawGI413zUSBgB1RYQXUDh8yjrHXJCCOUGoSjrsli8l5wVkwapbWPVXfzoqoGe2Cxoj
         zEWQ==
X-Forwarded-Encrypted: i=1; AKwUvBysN2FGHoezzFkJEq9jZsy/dNPn1dX4VDJUUAoJIwOgKlCMYDbOWB+7IguCuXZgUjcKMD4q+Ck=@vger.kernel.org
X-Gm-Message-State: AFuF++n1CYTmOn8Q5oZ5pE8nuWCGd3eVucWldGOicRrD1175Z1nUbDMU
	bKBtGAO8AluwR5ldkw/2ZvIW/uKAf9As0g6NXmnv0W7brahfNy1fqgIK8tJvaA884KYc6BtlZxS
	q9vjvpkR54G4BU0k0HoIgZCNYyf0ipZI=
X-Gm-Gg: AYBFou0UV2DMFphC2P9Bg+VgpU3VTggNQ6cNuCoeHLlzkVIdnGdVz+kOYm06IjWCvx3
	40WiIlvJk/4wa+zlse91y4pIwt2C/MfL8IPlhtwgmn+hEfObZcJSOKZBekTJhGnhcE4uxeNynOL
	KLZnEuBJzaetwCrtuSVyoVp85y6zDveWmyxYy7bqnD8/CpzTd50KzEL4cq2f0GcqktN7eTe1uR3
	/Px4QepA/CcCbDdLt8jdYJqx4dkQ4of/0kUKKM4NNvhc63+/+KRiNnzZSQMFzzyJs1RveGQ38m0
	UtME2LgR1HzYk3BWKAFKZcZq1yVia7dZqlvo3wh08Nc0DbacuAd1Piv+vyCM64WRRikfUBvft2m
	Jv7tZMu/FKJXHXA==
X-Received: by 2002:a05:620a:1b82:b0:93c:88ab:3482 with SMTP id
 af79cd13be357-93e9b733306mr1312623185a.29.1791494926142; Thu, 08 Oct 2026
 14:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923074903.862898-1-linmag7@gmail.com> <20260923074903.862898-7-linmag7@gmail.com>
In-Reply-To: <20260923074903.862898-7-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 8 Oct 2026 17:28:07 -0400
X-Gm-Features: AclHuK92lc0jnVJwnxxG37gDnBiAxy_73BctfMhsZYZmEx4Gt4Oo78g8F0khWvc
Message-ID: <CAEdQ38EVzFdn49rBj9Et6JFGiE0amUFbxunqzP1qf4FGZLS=VQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] alpha: invalidate the local context in flush_tlb_mm()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 23, 2026 at 09:47:49AM +0200, Magnus Lindholm wrote:
> The uniprocessor implementation in asm/tlbflush.h already has the missing
> branch. Counted over a fork-heavy run, flush_tlb_mm() was entered with the
> mm not this CPU's active_mm 2934 times, and 632 times while otherwise idle.

With the hugetlb series applied this path gets busier: every hugetlb
flush there goes through flush_tlb_range(), so unmapping or migrating a
hugetlb folio from another context ends up here with a foreign mm.
That might also give you the reproducer this patch lacks: move_pages()
on another process's hugetlb mapping, with the caller pinned to the
CPU the target last ran on.

Reviewed-by: Matt Turner <mattst88@gmail.com>
