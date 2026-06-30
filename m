Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE12DB794
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832349; cv=none; b=Gt7xN0ZIJD2Efs6bUlH59TuqJ+ROb0mFvwXkEjVlnDTxAZOOjFvW7ifClx5/P+4mRT3rY2E3V/E321YjQK1Y/ZqgGeT2r1soffvGU+zOtHUe2c3kAF6HxgPVH3hRdIw25ul2w0LfJ/15k3m515x15JjNsmFiKICw54EFEjRoVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832349; c=relaxed/simple;
	bh=PPb7LwoRuRfYmu8/Ofq1YjRYWdVv967WMagcT07Y2ds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BiUsWTIYgqRFKNKOtPzWG6JAG3CZB5wuU5sbBc9YD58S6/zcnareuA0MAndriuBGAUPuWry/ScjKqzvuX9Dgl9lDk6dOTujJVPOxtsV0kEj8ncOkBjRpYKxELRi4aGCS7A4EDKz37Q44gvDyrlrLSa37pIqPKu5VjHe5JHOoKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPbOB8hx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPbOB8hx"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847ad67cc51so336451b3a.3
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782832347; x=1783437147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+GLy3sWXadxiqMyqom/+rAtrEu0gob/aAStimBhbEM=;
        b=MPbOB8hx7nddZol4mdKUJx9Qh4zU7ITtWtk63SC5k6F0WWiM5f+RI09vig2Cd+psb1
         BmGl67cjiPqU7P28xF89SC4bpzxP6wV/+ZG+qf+kmSEkvvzl1HmgV+hmcAiQkKvzkNm3
         84bEV6S2UbAi7Iv+uupDZAxEUrJPgTWi0QyvxMZpCOs63GHUROVrCML/4l3Gn9WXG67r
         omriM67cxrvVmEbkrGpSmGgK3pKgTXKv+yIjrxCdWLipHcj4z685bho0hQfmOMJ/h7aZ
         5W1XJmPxVpPqwA2qR8SpY6hL/GYj9QFIqWk7gYIRtfru2OKuzDV6459XUHJfYSClY3su
         wl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782832347; x=1783437147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+GLy3sWXadxiqMyqom/+rAtrEu0gob/aAStimBhbEM=;
        b=Xw8c8maHC1FTAGS0D9jZAGk0ibVI4v1ZRpB3SX1jUFWKrriVhdS12U2PB31J1foe7q
         IzYRV8EGeeukjdxCpktL/7ktnumXVLWzmziHQRDpmBRtQePxjjeUMIohhPSuexxgFcI6
         doUbsOVIssZorbDhuGeu8P6TPeFyCPvGtvnj7NcRxT8ELheAR3/QaYvBaDQTj+9OGVoz
         mllw1AIFgg9B0vLy0nHaJ9lY9pgUwBuV+gxrvzdLZ91iIwUzNMVOxZbw09uDpHeoQ8Hf
         JoVi2HOCoWEV4RxiYRmcs0oAuAFnoypOm/a2eMlHKQo6lXwT176f2dmvjoCl8Hscyyz+
         wLeQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtCA5f9XfmfwqI/DmAAQjMIPpHd+qiD/Baoj50TDFzpByzH416A1VJKZycdhpqJE6pAopj7nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4GNnZTMSMrdsSA3eu8LO1PGJi2TnOXL7PnnxVRPb/LJ3i4BcV
	Dp9BEaILNflXKzLOMcMqTyyhws1KyKGWxdwEHB7jKy9tvajcWU3qlHueX0MDLNpa49eKat4HWKk
	W7zajqw==
X-Received: from pfbgj9.prod.google.com ([2002:a05:6a00:8409:b0:845:38af:5fa5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c86:b0:845:d286:1fb8
 with SMTP id d2e1a72fcca58-847adf22b13mr956323b3a.54.1782832346871; Tue, 30
 Jun 2026 08:12:26 -0700 (PDT)
Date: Tue, 30 Jun 2026 08:12:26 -0700
In-Reply-To: <20260630114701.319917-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630114701.319917-1-jinpu.wang@ionos.com>
Message-ID: <akPc2raibHy-QnPH@google.com>
Subject: Re: [stable-6.12] KVM: SEV: Unmap and unpin the GHCB as needed on
 vCPU free
From: Sean Christopherson <seanjc@google.com>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 30, 2026, Jack Wang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> commit a847a44f67eaf99faad905da38c080f0ba7ee02a upstream.

Wrong hash, the upstream commit is db38bcb3311053954f62b865cd2d86e164b04351.

> Unmap and unpin the GHCB as needed when freeing a vCPU.  If the VM is
> destroyed after mapping+pinning the GHCB on #VMGEXIT, without re-running
> the vCPU, KVM will effectively leak the GHCB and any mappings created for
> the GHCB.
> 
> Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
> Cc: stable@vger.kernel.org
> Tested-by: Michael Roth <michael.roth@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20260501202250.2115252-18-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-ID: <20260529183549.1104619-18-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Please document what you adjusted.  That matters very much, because I would much
rather backport 08385c5e1814 ("KVM: SEV: Move sev_free_vcpu() down below
sev_es_unmap_ghcb()") than shuffle things around on the fly.  That was the entire
point of tagging 08385c5e1814 for stable.
 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>

NAK, I'll send backports of the two patches (I ended up doing them anyways to
figure out what was changing in this backport).
