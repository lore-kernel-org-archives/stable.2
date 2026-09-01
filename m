Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94205485CDD
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788289296; cv=none; b=GxNJ1jK6EE6ZlRXzJ7QGxPJx8J1yqSYTFrv8nZc+pML4yua41uneNJLL8SVUWfoyKMHgrw+MilkAoXrR/QoMJg7M5qGJ76t9I7ATXDbo2xn5Kvk8CRTxfC4XNGIgPxG9bIYd6177ATkn+K+Gj7hoOA9fnKXO2Y38ghVwzO3CV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788289296; c=relaxed/simple;
	bh=VboPzb3Xkkzmr7vUeCkpFn2D4tyXtihjyp14vQmMl3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HAOF76IK2tjJat1POw0ZETMlRtcvNkjRFwJay7F9wMaymFASz7+42TymSSGF/oZpgULZlQWjDCOh3bhEIELrF1r03YoIKcYDAkCiQg2riVN5rO51/u8bHnw5WwKK7oEKDVuodUN3FO0PniyKhLAe1RumXuPDy3FydtvMnOu+l10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C7poZmlb; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7poZmlb"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-853402198efso158125b3a.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788289293; x=1788894093; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5z+izXEO5+nsfvME0WttTHU4Vm2k8iLkRaeBYf8t96A=;
        b=C7poZmlb2OoZg3b9cX+RDhVKwkiN85GWvsnTpfOpWo3ZsUCvQav+MU/kYB4557N7Ak
         nUnOi5t5EZQBvyGoq/3LVKxAibXLkWXIPDfUWzHl/0W1DHXnBpIyDkLMCGYjy1SrDbSZ
         pthW6pwKa7SMWZMHwfxAV0cFOP5KBdZvuL2wA5ussR6JioWCHm2tbhuhTSNSHlJrxmGj
         hUsCyqjerrFgWPRKCJYl67bI7utl9JO8rarn94iuDxDvS7LQjibnYQ4ZrA/L2eA3Zj27
         VqP2pmEHgPDcD3UhDcm8C/kLb41xu8vdyFY+jDGmZ3Yesj2WLT77gJcBzWzMqYwYGA6Y
         pwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788289293; x=1788894093;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5z+izXEO5+nsfvME0WttTHU4Vm2k8iLkRaeBYf8t96A=;
        b=GCvn8Y6kB92gMHvOiOyrZWsdG2mNEgeW0hubDYkzfSCbdDFZKcfMokM/+jD+qA4Hj0
         64jn01bWx4aYheJPK14SsphrsJdQRQ40QELTpL0DD5IZt2+FmputSwDqSWT7y+7BC2N2
         pCH3rnZOkHL9t3vp8OJfQM46yrrxH2DAK5L59iljZbLmBzh2MTckrIxDFgNIU0xAU/eM
         zG6Rwh5lwUdanQ+kr9pw9LmlluqAwhU6v1NgXNAFFwtWScPXFy7MVtXJrZXQi2qer6p0
         VBRAR3ecC2EhzZvUI8OO2RstsPtbWh8hXPYOyFe5R0gUUi23kTsoSiwaacE2NDeQ02wZ
         VEAA==
X-Gm-Message-State: AFuF++kroYocFa3VBP3r3FgyjM6bNXOKy1Sccu8PzFwl+m1rpc2JLwkU
	CIO7ZjPVAw7xwso/6B6DCUjlbeiZwDZyuqHhjsrwospX4QwX8GArNrF0F0D3mqM4cUKqAZYtjAt
	SiRFymg==
X-Received: from pfbeb17.prod.google.com ([2002:a05:6a00:4c91:b0:848:478d:6efb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fd6:b0:857:72ba:ff0a
 with SMTP id d2e1a72fcca58-85b5c0ec6dfmr14611972b3a.18.1788289293299; Tue, 01
 Sep 2026 12:01:33 -0700 (PDT)
Date: Tue, 1 Sep 2026 12:01:32 -0700
In-Reply-To: <20260831211010.1798943-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026083135-thud-surplus-53de@gregkh> <20260831211010.1798943-1-sashal@kernel.org>
 <20260831211010.1798943-2-sashal@kernel.org>
Message-ID: <apchDJDrXemR0paW@google.com>
Subject: Re: [PATCH 6.12.y 2/3] KVM: SEV: Add an anonymous "psc" struct to
 track current PSC metadata
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 31, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 00b9744a3688758c5c492756d08a1cd599a76965 ]
> 
> Add a "psc" struct to vcpu_sev_es_state to avoid having to prefix all of
> the fields with "psc_".
> 
> Take advantage of the code churn to opportunistically rename local
> variables to "guest_psc" to make it more obvious that the buffer is guest
> data, and more importantly, guest accessible!
> 
> Opportunistically rename inflight => batch_size as well, because there can
> really only be one operation in-flight (per-vCPU), i.e. "inflight" _looks_
> like a boolean, but in actuality is an integer tracking how many pages are
> being handled by the current operation.
> 
> No functional change intended.
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20260501202250.2115252-13-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-ID: <20260529183549.1104619-13-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> For the 6.12 backport, retain the existing GHCB response write because the
> newer VMGEXIT response helper is not available.  Also fold in the VMSA GPA
> tracking and helper refactoring needed by the dependent AP_CREATE fix,
> adapting them to the 6.12 gmem and MP-state APIs and existing reset hook
> without adding a new function.

NAK.

As the first sentence says, grabbing 00b9744a3688 ("KVM: SEV: Add an anonymous
"psc" struct to track current PSC metadata") only requires handling a superficial
syntactic conflict.  This mixes in pieces of d1a3c2162334 ("KVM: SEV: Forcefully
invalidate SNP VMSA if its backing gmem page is zapped"), and *that* is the
commit that's by far the most interesting.  I.e. pretty much all of this is
leading up to that commit, not these intermediate commits.
