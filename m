Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123212E7388
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604512; cv=none; b=NX0WiuAyrlG9JFAr54DtrsUEPB9Ta1KOb5vHDUaTVaaone3A8Mo1sMrGJ3JblCuyBBZVBwkW7j1LiBBT3R0GnlFZFKkZCQZZx4IWBo7+cl8qNe6DMjmyrkDsUnvseVPO9IkMU4pxhJkN9wI2MbOUogpk3VJ6Lc1xq4F56OIsnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604512; c=relaxed/simple;
	bh=fXsjiN6eTN+wejpC+aES5Y9JD9oLQdMfLq0AYbS4o3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A56R4NmTuut8cEwzxy6veaMudUO4JW2bcs9nOOcmJKIxjuHEx04YJaEmy7BBTs/1GHXhY2JhV/3FR227aOhGEW+K9EDBZtppEuaRBRoq2brr6r7KAoFaSEgeBxrEkV54pK+rlqyCt1NfuNOtlM6kOM0clQllGAXkx0oN3IeMSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZdaLUyP3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZdaLUyP3"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8478ff5d801so3654393b3a.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783604510; x=1784209310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TqZ6gSD5FKoEf+kRjMwloxjdQe2NH3vzfgHgIMmv9+Q=;
        b=ZdaLUyP3F7jnnDJe7b5JCvFsgs83DVmWAG8S6Y84TGqNRkI8qFDSy3CQvn8wEoEQhO
         naRwbC+2fZJ2UWrcsnUpfh0jTG22ZR4CwH4nU2DhRnTYLiiPNh2NURnxKW5sNGe2zPLB
         lOvxU6/7hg8IHrOVorC26InJ17jVstdt5oqTKYUpaGr2jBI/KQU3UDwjdiF7VQ39Hcul
         AXb58vUJ/eGKpRATbDelAgiD+qInek21/fps6lr1CIFl6DMMPaTAIxsBC/+tyeOGGQT5
         bzm48xKCApPM48kCUEfcogOFylLXbnp4WJsaEPyUU6gyvRTA7qeJLLAoNX9cM81/GF41
         /kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604510; x=1784209310;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TqZ6gSD5FKoEf+kRjMwloxjdQe2NH3vzfgHgIMmv9+Q=;
        b=erJydZedLzuhvV4PgKABk8T26sBNITqBPFoSi0AkfOzUGcnvk/zC6NzRMR17DP3k8/
         qq9PGdN2/hjWNuSY1Oglh8d+rcZTMCAFbkEHtXWMQ83hIotB4kbQZiNpN1cN0VAtNyXs
         zZbgd0TtVZH2cIHHkOJDw0arWca6Tgolud46BHJ9waCK3n6yOf4RxiuC2w8zOgBeIXfj
         quT4mACPRPhj7db0HngRp8mCR6Vbjg3ZpuiMIz7uGRIVpweIjq4rdEU8PQYmI+wgfLyj
         qlnwVCrmQjrK025PsGWCSRjms6OvmUh8khmzjk+to7e5x/zheWbodGiiidEgQIocLKpI
         MNuA==
X-Forwarded-Encrypted: i=1; AHgh+Roq3QBZAXrbsclKese/zeWZsLUnMBDFQD3vr6rOizMCA+Oj3Uq+RBs5jcZ0dnqL4S3zF8FCC/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyapI6hJhfLcpXMs71Bvh6Q4Jwa8vD7dRSz6TY/po5dJfH1PX6A
	qySr4UDgVX+iSgDg3ihaL4BZpcynrE8GWZA6lrAKsMu2ptKvWk6Zn2Jmm5Dt5uOtJO+ojOEk1Oy
	MIti47w==
X-Received: from pfud15.prod.google.com ([2002:a05:6a00:10cf:b0:847:9be8:84d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:148f:b0:847:1d73:f753
 with SMTP id d2e1a72fcca58-84843410e48mr7508657b3a.45.1783604510194; Thu, 09
 Jul 2026 06:41:50 -0700 (PDT)
Date: Thu, 9 Jul 2026 06:41:49 -0700
In-Reply-To: <9d376736-4879-42f2-b798-56fd2d1ab05a@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
 <ak4NdJSK60zKD8Uy@linux.dev> <315e969a-4ab1-433e-91c5-2308f1975281@linux.intel.com>
 <28ec0a5ac5c46448df5983cc7f9cbc71f6014e8a.camel@intel.com> <9d376736-4879-42f2-b798-56fd2d1ab05a@linux.intel.com>
Message-ID: <ak-lHS2edzxcmT1j@google.com>
Subject: Re: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD init
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026, Binbin Wu wrote:
> On 7/9/2026 12:20 AM, Edgecombe, Rick P wrote:
> > On Wed, 2026-07-08 at 17:04 +0800, Binbin Wu wrote:
> >>> Maybe it would be better to check for a mismatch and return -EINVAL?
> >>>
> >>> =C2=A0	if (init_vm->cpuid.nent !=3D nr_user_entries) {
> >>> =C2=A0		ret =3D -EINVAL;
> >>> =C2=A0		goto out;
> >>> =C2=A0	}
> >>>
> >>> That would make the mismatch explicit instead of silently accepting a=
n
> >>> inconsistent userspace snapshot.
> >>
> >> I chose to use the snapshot value to follow KVM_SET_CPUID2's style.
> >> KVM_SET_CPUID2 kind of uses the snapshot value of entry count.
> >>
> >> But returning a error code is OK for me.
> >> Let's wait and see what others prefer.
> >=20
> > It does seem safer to reject input than have some implicit behavior.
>=20
> Yea, had a second thought.
> If there is a mismatch, the userspace is probably malicious.
> It's safer to reject the request when the userspace is suspicious.
>=20
> Will send v2 to reject the request for the case.

Rather than add a separate if-statement, I saw lump it into the existing sa=
nity
check on the cpuid field:

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 6ff1469e91cc..10b4db17fbd5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2797,7 +2797,7 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_td=
x_cmd *cmd)
                goto out;
        }
=20
-       if (init_vm->cpuid.padding) {
+       if (init_vm->cpuid.padding || init_vm->cpuid.nent !=3D nr_user_entr=
ies) {
                ret =3D -EINVAL;
                goto out;
        }
