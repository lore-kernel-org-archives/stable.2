Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00321349CE6
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830730; cv=none; b=Lt02WQfKAtsi1PR9vo3tJQP3WqEJLrCN57hZ7KFdNxZ3TlkpsbPLy7YNF7/T7Fux9H+nxD/injLTgTtJ4WVfSGSMRdakmSXXRxY7C/1hO+1FEsUJ6KBoAvzi7uTu9qjxMEXCJ/XLfJiNAD4LnO6MmdZ1x4Cg2EfHYaFZgozmeLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830730; c=relaxed/simple;
	bh=/q6XtpR0sR9fw02i48k3vckGPMXCPX+g9spOGktbTGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EozgajDfBuarfW7+rQmdS7nuz5nIBzVXHV55e0MC1Z2sIlbPf2SVq0KAb6UIX2+BTsDrr6DiCMROJvGl0WsD9qbknwx57OOLROzzkAk5EAaketYOdbxhdSa4tF/hfc1MXW+N4RX6BmkKGeV96UWCCHDG3J6lbwVSLQ714zHHCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfAJrUjQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfAJrUjQ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84777e9b51bso3175436b3a.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782830728; x=1783435528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZ+ykOnpuz4GlNAG8Lxp+ssON7jaEsuqG2UOo0T+7uY=;
        b=tfAJrUjQ1CJ6AVVMs87NrCaTbRZtMaFpUikbQZJEvepYJj8Q3LUJcKHbcWLkUo9KmY
         s47xQABx5/IMQtHzkBHnGQvqGEJvAbLwm8aSMtCf3NsA3c4671naAgb0L0JnN3TmU6Y1
         P2BO+NFyhZ4AdXCa/YmecgkgUtFvuQBJTALtHiQWJCtGcA+LRdM5k7FOPpo48+q+o+xF
         iajmZdzl7XzhX7c7GN0jh7t0uqtpXZ8Ex+722xsXO2WekK0IfVv/n/dnzBTKd6axpkbG
         v0TzBsqATYdt2RtAtXzJh0Y368CDS0RcjcH3bXSj7couciDmUM0+1Z9SoKY9byUIEbVg
         kadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782830728; x=1783435528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZ+ykOnpuz4GlNAG8Lxp+ssON7jaEsuqG2UOo0T+7uY=;
        b=TeLdZ6GGoy5z5dHjvJcIbSexJjs9SEmHBOVRmcWEix2j7cKOwME1N5oai5JnR9ewtb
         yWSbdS6wHROvZ/fKAia1hiaLpmU3Raq+v5lXVwGOg8ZS6Vc+HyiR/19R7fqAnFE+11FR
         3cHGQSGwE2cuG8OWJMN1CznDsu/N2B8HrHwRAzqqF56pwNVSECfSTctPrPY+mPR205SJ
         cPQWZ1fPVd5jfvE2CD+3tlBlqdcJHtCvd98wsGOFQge6782/CgdLh6VtdvHSkQWSdGah
         m0/zVJIGnWPH1AaqTEq/nTSzY5UDGkLiu/Y0hVP9ON2tHCxFebXDLSrqaRxQln9oy0nZ
         m9mg==
X-Forwarded-Encrypted: i=1; AHgh+RqTGjbeBXF+Yh6pf6NDCxuxUaAGCXmORbZPcOe19CDCNX4P5kHm3Hg51XpGzl01Kt5ZL4qkQWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPc6qL34FIpFaEp1s+k8QftHAqZ4dVhVehTvY1F6d62n8aoe3
	3D26np5E/3LLTnV7depsoUpy+qsLmky2WKsmRsZPN/69ZZnckdj0FXGfuCBwOfbNTT6q35BaAmz
	iNBpKzw==
X-Received: from pfbml1.prod.google.com ([2002:a05:6a00:3d81:b0:847:ac08:fdf6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:430b:b0:846:1698:638b
 with SMTP id d2e1a72fcca58-8479f12294amr3318831b3a.27.1782830727773; Tue, 30
 Jun 2026 07:45:27 -0700 (PDT)
Date: Tue, 30 Jun 2026 07:45:27 -0700
In-Reply-To: <20260626193343.256956-3-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626193343.256956-1-jinpu.wang@ionos.com> <20260626193343.256956-3-jinpu.wang@ionos.com>
Message-ID: <akPWh6PelrFlotF1@google.com>
Subject: Re: [stable-6.12 v2 2/3] KVM: SEV: Reject MMIO requests larger than 8
 bytes with GHCB v2+
From: Sean Christopherson <seanjc@google.com>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 26, 2026, Jack Wang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> commit dcf1b2d4b0564a27e4ca7c654871aab4f9620046 upstream.
> 
> When using GHCB v2+, reject MMIO requests that are larger than 8 bytes.
> Per the GHCB spec:
> 
>   SW_EXITINFO2 must be less than or equal to 0x7fffffff for version 1 and
>   less than or equal to 0x8 for all other versions.
> 
> Fixes: 4af663c2f64a ("KVM: SEV: Allow per-guest configuration of GHCB protocol version")
> Cc: stable@vger.kernel.org
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20260501202250.2115252-4-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Same comment about documentation the changes.

[Jack: Open code response as svm_vmgexit_bad_input() doesn't exist in 6.12,
       nor does GHCB_HV_RESP_MALFORMED_INPUT (the literal '2').  Duplicate
       fix to split READ/WRITE paths. ]

> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>

Acked-by: Sean Christopherson <seanjc@google.com>
