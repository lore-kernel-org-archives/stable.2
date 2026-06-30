Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E49344103D
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831233; cv=none; b=qjE8J4bk3Ycz7G7TbhlUVJUXEqyTB+dMiWtrpiDWVNGLFyJwpNzBJA+Ae5gdmjwHhzxCerGBrWAipUWFkSr+S0woPJfy9ESZrTB6hdCNfskR1LW83mBM/zbzShH4/qoSLfZIQlY56LzcZbCsx74J6URSqvqEBF57qzCChWbWLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831233; c=relaxed/simple;
	bh=5CZOlNrVfmpKhf9wVQPec3NkLOYF/sQETf4anpXsN+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RLJTuDgIKyVBQHPzXKT79Oj6aykFx/gIiEhfNW/xj0z2wF3QlpqggTdZ4dLOVOoUzzruzQ6mAGxOzhuHy6nWMAbRx6aaQ0t++qstv6toesaxDJK2OUf1fYbg4RC1F0VngmxwsjnTYTLmVaAFIlbX0JhnVugnRmHTScnvfXrvlLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LFCZY82Q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFCZY82Q"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca3b314193so7434465ad.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782831228; x=1783436028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QoY0cS0yI/iJvCcKwj8KTmO32onUzpcMjXVD+VuRptU=;
        b=LFCZY82Q2gEs4lEov5Wht9YMHGBe/kbJuFojwSLUF5mIxiJ2d0OuFNe0c1I266cJsw
         MdPuIzpLXfJEBmFRDbHdvt+lz7pgWxam2bZdsgQ9pYS4ErOm//tVeVgg1hyETRuT4DIN
         5xc1NE2wWOUFEWOoWfqSWqSuUbTXG9VSG0pkl5kF2YxszOasC+OHkY7MrPz9YhUIFsAE
         b20gJUa6+n6UT+vxDdJAjLPnsOqxBt8X2vvRaAwjvt9fDNZe05IQsas+eH3CIi38kGBK
         pam7VSRNObGGvIf7cpYw4F1MW6VXdtm1qVNkHlXrQ4v6etFdZ5o3m4lTLuMg+5wla5pd
         E32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831228; x=1783436028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoY0cS0yI/iJvCcKwj8KTmO32onUzpcMjXVD+VuRptU=;
        b=NZVnSEOcNl/4oze+sEp0rcyArahBJ/wk1lFcAlb0EGr7k2tfDYA1rxPNEV3mHQ7Bss
         x8t5v82ES6G5PB41L60udnevvai7JXbR/qW6iKsTkTZZsQfLGac39VVd4Xr7Aa41n5pb
         lR+9LgNqUZ5ZRBag5UEKbFHAnf30pBrnvBaDVTdLEZIjfayxwhBp1ogJ9EzJnqS37+OG
         89ySEaE5ke2pldP4DGvGz736fD1gqd0YaCgrLTzczV6oLH2nMjkU6HiQdq8YMcLzEzbr
         Nk+tT+CIPuJFpb7HiUQkV5WzZv3qOCaSis03dOQ1CZs1SC7Qy0kSbh2NM2/Pvpnr2AiB
         MIEg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1kS4nY7RnEkZhIUuyBKrDT2AjEGDbCwgZ2CQ/JO4LnTgXy21NmhPUVkoMCLts0HRCJJMCtus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8menQoXxqAlHiz9fJM3nR/6u1WqxV1sp5ZI0QQxpdy0992aO
	OJMi4NsZhVj4v0FpbF5NDHFwYOQF5422CRO9BlSryILzvPI6XIxxpBPDHx88KoDNHahLpDjPBAT
	ZV6t2VQ==
X-Received: from plbjx15.prod.google.com ([2002:a17:903:138f:b0:2c6:a589:6022])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea11:b0:2c8:25c8:85a6
 with SMTP id d9443c01a7336-2ca2d52e7a1mr31713865ad.2.1782831227796; Tue, 30
 Jun 2026 07:53:47 -0700 (PDT)
Date: Tue, 30 Jun 2026 07:53:47 -0700
In-Reply-To: <20260626193343.256956-4-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626193343.256956-1-jinpu.wang@ionos.com> <20260626193343.256956-4-jinpu.wang@ionos.com>
Message-ID: <akPYex6hm5MoHXs9@google.com>
Subject: Re: [stable-6.12 v2 3/3] KVM: SEV: Ignore Port I/O requests of length '0'
From: Sean Christopherson <seanjc@google.com>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 26, 2026, Jack Wang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> commit 3988bd2723de407ae90fa7a6f6029b4e60238c58 upstream.
> 
> Explicitly ignore Port I/O requests of length '0' (or count '0'), so that
> setting up the software scratch area (and other code) doesn't have to
> worry about underflowing the length, and to allow for WARNing on trying
> to configure the scratch area with len==0.
> 
> Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
> Cc: stable@vger.kernel.org
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20260501202250.2115252-5-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
