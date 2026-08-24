Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F40382F2F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608166; cv=none; b=FQEFnoFJrQMTIlWGdsDCvkQAcum0GBpjlzi18pbsGzNKcB+50f5F1Q0dsNyxvWJoN9ULgXHt8ainTnqzm8VWb/5GOtVEN5m11/OUmR7tUAwsPJe4CljpoU3ep7I60XgTNVu7B/4zGbmBpNrFlAddfzVjVGwVBK3na0B1vxnlbao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608166; c=relaxed/simple;
	bh=DdTBAQmYMGrMKj5qeC5Xmn1n4sUZQvGckJhixywAtpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KTM14SYHd/lCNXJbaymSwLmhi6Bpe3GKja+uS9QC3cbVg7TF41UwzhUyo41yDdP29NpiHM2954+JWYflR7R35bV/XosGvDTLElmC0+ndRPB0uns6DDs1n8+4eUz6Ywty1jTgacYJohIxcYzNu3BgkWPAL74nLp6xdoC+RLecdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E6kOBltD; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E6kOBltD"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84f7002f9afso3332102b3a.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787608164; x=1788212964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fjc9nPW/BJpn6YJpX0n6jTXAEmBsoOmQkD4iHgcEHec=;
        b=E6kOBltDQCmiTQcXEvf0G2dHqNAi3mv9UWM/IqWJVujzt8idiNgwOUEPjgSLmuJYUB
         pBaxKSWYO1nqCaEHpT1SjDsztKrmHkUnJfLiT6TOrZARNJgQN9qbv0PyhE50NS4xMjHn
         nYUIipJiUS6T7GC8YAhAZOATG7dG+yMoOjNkTgF7xoP+HrrcKEiJsScD3i3ferZZOHUt
         nGtInoZzMASKZyqyfS8uWVP3i8G2ho+vwqgrftZ5CduNW/3ZJhKAhGyrS0FXWNeuSfr3
         t04gw4BN65O/LLnaTC7q2nY6ur3tq1Ryqbu7v9taEhmocenGRxwnMIlpVvSL3W0winNr
         bhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787608164; x=1788212964;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjc9nPW/BJpn6YJpX0n6jTXAEmBsoOmQkD4iHgcEHec=;
        b=Gim86+ynFHimsodKerjo4nEKdllZy17FrCt90lbFMB7yM9RSeDo7LsDEmWFx8/lpOI
         fMrdPBdKf1rb8y+J6BVYKXRi3A3tAn4mufmpkmtvhZbLxfSI1JFuoSFe9O9lNc0a686I
         fogGts0WPNNhRKmpxxh93IEeQc/kyeiK4i3F1yXHnQbw5o91GXxwAjRiBAUwZIEeI9qP
         e6xg11a6IzRk4yz8l1isoeK9n1Y5OyDx8rmgpL7OIj90Iqi7H5nKdGd/47CCeD2LRX7K
         VV8cnKAr4PFw0rka8Hq6wACoDG3AzTCdgHeFCNkljbmSmyd3657eRJA3JiLBvAs6rhxt
         eYbA==
X-Forwarded-Encrypted: i=1; AHgh+RpvZrxsIqK3nYpzsoW6MICnDd47ycbw+yrDJKmZkzJJneHxXM/2iAfOoEeY4fUPbZD2VOEBwyY=@vger.kernel.org
X-Gm-Message-State: AFuF++nAzjnol7r5k7aTiaXlspG7mSRKi4b0FXW0IGFKLHtIMZOFs2Sv
	NA5thlKCBE4d4ZWy56aOO6cosF2FGqXRNFVwgR52EQR0IHyYRTdd11oaY/Hd5rNws04MayWLQUA
	OpMjd+Q==
X-Received: from pghp7.prod.google.com ([2002:a63:fe07:0:b0:cc1:507b:e025])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca8:b0:84c:1cd2:142b
 with SMTP id d2e1a72fcca58-8523c8f0862mr3243509b3a.9.1787608164138; Mon, 24
 Aug 2026 14:49:24 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:49:23 -0700
In-Reply-To: <303eb59af516335e288647c19254928f89fa833a.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
 <aoyEMBz-SYLigbGp@google.com> <303eb59af516335e288647c19254928f89fa833a.camel@intel.com>
Message-ID: <aoy8Y19RV_Dgm7Te@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "nicoyip.dev@gmail.com" <nicoyip.dev@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026, Kai Huang wrote:
> On Mon, 2026-08-24 at 10:49 -0700, Sean Christopherson wrote:
> > Alternatively, what if we have kvm_zap_gfn_range() acquire SRCU?=C2=A0 =
Nesting "locks"
> > is a-ok, and two of the three users of kvm_zap_gfn_range() have had thi=
s bug (see
> > commit 074c00800719 ("KVM: x86: Use SRCU to protect zap in
> > __kvm_set_or_clear_apicv_inhibit()").
>=20
> kvm_vcpu_srcu_read_lock() doesn't allow nesting lock of KVM's SRCU.

No, kvm_vcpu_srcu_read_lock() doesn't allow nested usage of itself.  Commit
2031f2876896 ("KVM: Add helpers to wrap vcpu->srcu_idx and yell if it's abu=
sed")
added the protection because we had multiple bugs where KVM would clobber
vcpu->srcu_idx and cause a deadlock by leaking a grace period reference.

> Doesn't seem to be a problem for this particular case, though, because
> sev_handle_rmp_fault() calls kvm_zap_gfn_range() after
> kvm_vcpu_srcu_read_lock() is called.

kvm_vcpu_srcu_read_lock() can nested inside an existing kvm->srcu critical =
section,
just so long as the existing critical section isn't tracking its grace peri=
od via
vcpu->____srcu_idx.
