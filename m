Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793836192;
	b=BD7Z9rnbO56qwgyIF8I5a5Qm/UmSvlXAuNfmD48cKQDfwzj8BsprIYIj9QQRiLNgPkCr
	 l656fUVfwmAos5Tds0Sr5JrkFlx+VfE4up/IpcvUSVDBVpwpgjo99ZRFm3L72GvuWf5Si
	 on0BWInVXBlzfUAkZ7otCB4l/tUTmL7L0L/Hx35Z5beVGjyQF0p03YF0SHwFPtsBqoX3U
	 HNbuoW47YFFSfuA2iB4G+lbd9TKzmnq4JDnzCjvt/AWpdzlIjppn6Jxe59BECtvDsdfcx
	 4HLMpI3JyfDCa9jnKUU0bg9zR7jCuI2nTH3N8v+bVOAWVoJvKs8fe2sLyvQyzyuyI0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NUKXnf2zRVnphDvWIJPgNPk0+Yxezthn/bgjikrOQVU=;
	b=1fl3cjFZCq7CDODfge8L573Yyi6/9iUjiqRxDzygCYdMGdN1I8+zLY3ZH08JQ8FYWMql
	 jLE3J0k5nvgyJtyiUR249j7i+uI53rb3MCkGGYuE67Q1AYgPJPpsqW9O9L9zuAkvIhJZb
	 yMtvbTq6gk0gu3+ylI6Vc0rnKvV8OPwCRCsIzrDwUQyvZlETSBAd4aOIkNZk+PdgXB6PL
	 /32ggdcerfQ9MuIehQszIP12rcccz+Hu09+8wdT4UNg3ViwRq3GYI/BHnC03Q8Q+Ma9/e
	 aS98Uum0gKDoZWjq+WQ6PFdYrt3tv4h2sX+IkyvEdCog5RBmxlsjq/C5O4uUgJPBWLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LOCKWL1w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF149606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF149606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LOCKWL1w
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso5173a12.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793836190; cv=none;
        d=google.com; s=arc-20260327;
        b=Y7ZfL4lStReHNay/nrSXy/NV6eCXXAuZxITurPAFbYhhDd9T507ho4HFyczqmgRg8M
         y3t/UxM4Wy0fpyP2yHYCHlD+oc4s6X4vs0YmeXshvOGjwcc3H0tyj4n6WynmdtZ5Xk70
         Ll+re62Dvbjx+iGEJV4R3HS56MFPTaplpjt7kYMs3nL16J63czQ3BxoNm/rDnvDahjFB
         9Mr68EKu8Ev3Ws+Ck+ewrPcmNjb7P4x15b9h3YVf3sN0IFPJg80Opr+bU9GM/F0tAaNF
         NXxBzVLT87WY+d8haQTAfVKTGqaSX0LyIp11OVeJVNtpqVnTLInyShlAo8Braikbl7vJ
         D85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NUKXnf2zRVnphDvWIJPgNPk0+Yxezthn/bgjikrOQVU=;
        fh=uGw1+Epxgm3HVC2CPMxKi1JGOxkLz+qZeYLiVpTThWg=;
        b=IY/J/2pJI7E9Xd18v0G7tpfdgYv6lj9nmnF4aIiRG5Lr5qiwhRPqfcmIsE8JNvBO+t
         1vKVPM+mkFyMYmfZ9wqN1mELoqfCVNUR2yemizAHyiv2XruFYBDx1kBu1y44B6yaimEH
         ikHIgxeTQt11t8FXeGU6t7PolQURhG4E2U8n2xP4YXjAHWJAghXCTZPTY4HT2ZLnPyhk
         D/ID/vBhNtzJOvgfbclu92NeKiJoEkQjS3oj7+S8XAaWWOEu7MsTL4zdTBPaW8Gc+TgA
         rxxQJac4ZGUi/hhKtAU1X/Dx5Yw8eU4ZSyjvsxvjQVfQhgoTrvTFXOeI28PkE1Gmfrfn
         K4aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793836190; x=1794440990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NUKXnf2zRVnphDvWIJPgNPk0+Yxezthn/bgjikrOQVU=;
        b=LOCKWL1wvKSW1uuETVBSc+7qqp1PzGIzHAP+Uros1fuOIBAPEzBSwpC0UJ+I1tzFVX
         f+gD9FJI+nKStfEI775giljQXjuR5F1aCTV/9gG71Dxtz/dNG9MddBnSJRJWFTC8pA1u
         KsWWbOC32wZ1UHU0b7SVXbxwcH7M6CDM38v0UUeeF30VT7eGffugx7+gw6qupZcATfOU
         crQGq8b5f8m5gVJt8wY/OMfA0BeZzHLvzdNvTvFOmCj5xJrQpWC4gJZK5rg6XLWD39y6
         fgfK6Uah7rxjWM1xdj2/wGOtdElIqqEGxTGfOs+5FFTJhcNXih9IYUmo1ffThwpLZS9C
         nEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836190; x=1794440990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUKXnf2zRVnphDvWIJPgNPk0+Yxezthn/bgjikrOQVU=;
        b=O9BSzB8uJ6bLAa6uVghUBxG2lwz03kTiErw6YMz8QRgMpngfQvp/Q6Yv4PupSb9SLl
         +JDFJ6MmjwUEHd4VQQcZAlIoL5GZtWVvo7QqZcISURUBIygz0u0hr4cDNxLNSgsd9dKV
         iNGGHKzfM7C2W5dYJD0hMGSqro7G6U4wM5dR9ckjAewdK/20FwSjTihFqbSGz4kFfXeA
         pkYJFsR7RXHWN/FC3sRC12tI+tpBxZ/Dv4QMZYSiJtfmXR1enjtSunEZ3H998N3aLmz3
         TckDoD8b8S18KkEN1IGpgtVxx6WQNF7yffx+YsHKYC4An72AWzare5biNaB69Y2cQSji
         TWMw==
X-Forwarded-Encrypted: i=1; AKwUvBzTLkV8gpGibTyaaGFhV0rbtl+sHw/TLUZ9QB2RqDE2dlDcXDAit5KFUKBIZT9pWBSMZ2FKYWo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9G2nO8528XEE1Fu3FH2OBjZSn5hJjN0/BuGj+sdI3cfGDkRsY1
	51AEf4+fiPfuldOCxSxLSd3w0/5ESvSC1ExgEZ36tqWMnAb5IVvHcIIrgQHAFnP75W1tC+sOynE
	4hVAqmsBBk6wdwW44V6CCa6dSqbUU24DTr1LM0RAR
X-Gm-Gg: AYBFou3pY+cO+LH7BCVtdwnRb4iKGY0E9s+ANwVyQyRYxS5GEtApcZ23quUpp/Tl00U
	4Fr2iW5BwBPWW/i5RbFlSEWa1sHParSP5QGnpnCMBPZQxJMwg9uoV6qtf0e94gBX9jnL8JK/Q3N
	x72mGVhu6w93QcAHQAILs0cJhi9o9Lq/MGSh5t0WxgYcEwBiUY/2z9dhUVj+BRNv9BvT2XXkAZZ
	mFSMPS7zu69lKKSHLmBw9knf7Mv3RB+7oCQh3xxHBY5c7suU43QNapmc2ZEOeONnCOTqfTrscWm
	kY5ppeIyh18dgPiCsX8UiNg4fn6TKP+oZILbYLgqeg+051EPWMpIT6hmf2IftabGhe+8f5wdB8y
	zldzBe+jjMlCm16hvcvjqoZCV/ocZdjHRz/xXhLC3ebfzirKKyErNZxeY+g==
X-Received: by 2002:a05:6402:515b:b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6b57bf23d30mr13524a12.7.1793836189727; Wed, 04 Nov 2026
 15:49:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020234535.3182385-1-jmattson@google.com> <20261020234535.3182385-3-jmattson@google.com>
 <auuZcZhBhrkZd9qM@google.com>
In-Reply-To: <auuZcZhBhrkZd9qM@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 4 Nov 2026 15:49:37 -0800
X-Gm-Features: AclHuK_NOce6L67eEel5xBWyuJ8EA4SaVhlYOcLwPr6ufXLfVFjSolSkCGb1uQw
Message-ID: <CALMp9eTpWP6XSYPJQjBwPsNWmPzLNh+EDGivMFZsUnixqpGkVA@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: VMX: Refresh LBR MSR intercepts on full MSR
 intercept recalc
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Like Xu <likexu@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 12:45=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Oct 20, 2026, Jim Mattson wrote:
> > Re-apply the LBR MSR intercepts in vmx_recalc_msr_intercepts() if the
> > LBRs are currently passed through, so that changes to userspace MSR
> > filters are reflected in the MSR bitmap.  Unlike SVM, which can simply
> > rewrite the intercepts in either direction, leave the bitmap alone if
> > the LBRs aren't passed through, as a filter can only force interception=
,
> > never prevent it, i.e. the bitmap is already correct.  Note, clearing
> > msr_passthrough to force vmx_passthrough_lbr_msrs() to re-apply the
> > intercepts on the next VM-Enter isn't an option, as doing so would
> > leave stale passthrough bits behind if the guest LBR event is no longer
> > active.
> >
> > vmx_recalc_msr_intercepts() is invoked in response to
> > KVM_REQ_RECALC_INTERCEPTS, which is raised on MSR filter updates, but i=
t
> > skips the LBR MSRs, and vmx_enable_lbr_msrs_passthrough() does nothing
> > if lbr_desc->msr_passthrough is already set.  If the LBR MSRs are passe=
d
> > through when userspace installs a filter that denies them, they remain
> > passed through, and the guest can access them without exiting to
> > userspace.  Conversely, if a filter forced interception when the guest
> > LBR event became active, relaxing the filter leaves the MSRs needlessly
> > intercepted.  Either way, the bitmap remains stale until the guest LBR
> > event is torn down and recreated.
> >
> > Only x2APIC MSRs are exempt from userspace filtering (see
> > kvm_msr_allowed() and the KVM_X86_SET_MSR_FILTER documentation), and th=
e
> > filter is honored when LBR passthrough is first enabled, so KVM's
> > behavior shouldn't depend on whether the filter is set before or after
> > the guest enables LBRs.  Drop the LBR MSRs from the comment claiming
> > that they can't be filtered by userspace, and clarify that
> > lbr_desc.msr_passthrough tracks KVM's desired interception, which may
> > not match the MSR bitmap when userspace filters are in play.
> >
> > Fixes: 9254beaafd12 ("KVM: vmx/pmu: Reduce the overhead of LBR pass-thr=
ough or cancellation")
> > Cc: stable@vger.kernel.org
>
> Meh, this isn't stable material.  Unlike SVM, where LBR virtualization is=
 tied
> to a pile of other crud, if userspace wants to filter LBRs on Intel it sh=
ould
> just not expose LBRs in the first place.

The functionality is not equivalent. For whatever reason, MSR
filtering can be modified dynamically.
