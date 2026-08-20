Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F2438487
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226077; cv=pass; b=YIZzG2J7z2CATjE2uPczqkpCnJNaNLKPw96na8Cu6b5UPw5jeLf9r4acaAFZj+QpyfaI2v4My8boNyarx46kqoO4Nf4wzSg2+ulqYpGnbEh2F6BsTGrYphQA2lO0bM1QffvHM623UBv9unCq+mUqOSgrrAXo9F6rrvsy8zMQIGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226077; c=relaxed/simple;
	bh=6IQSq07o/Ir+aAEjXoSKNL0RcBsdUzy6t2o10QBBevA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzVQ8enZquQ2O+fwxSKKXp+3L/eYWxNOW0UfE+EaEPT7XG+naKj4eQfZ58pDxgVBpMi8RsOUb2dgvrqM2wvawgikb3T00sXr/c11EnIkf+4JYDCDzv/TyQP+QLx5etFxAiqOQHqk6b8EhVBTUtvhqGN2RSLcb1X374W+B9QXOYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAmnUN7l; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAmnUN7l"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-448cf99c133so808344fac.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787226074; cv=none;
        d=google.com; s=arc-20260327;
        b=Mek0YK9ukl45Vyz+91XlrNMidFStLm9vl7prCLveaVIshjSKT7pQGPqj6oZgWrpqHH
         QyLk7omYp7PTJJQeIOh0zKr0S4e3jqdPkL+1W2tk32ShXFVTUT8pQmygApSRk8Qb+Nhc
         2ZzR+Lbfea9KrvvCu8mk4kv1HjJY8L4YDm4lT9ovuW9bjR3rpyxpzzwc15rGbXW80qOT
         NEnhPw51tx6J9ExWhu6tgQPRk7mpDIu525M/b7q7d1fkP7WGj5Q03v/TkoKlicYiMpbX
         rDzQpaCpeUQSZDUioW1u8aoMSeWF84mRLTnRnZgPrSZpzrqjborJVoBA7FfzRVpnZOOd
         IaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Vwo1LenmOII7Z67ayqdNDGxIVSqjq55z7Fu8p8GGYM0=;
        fh=MLhVXBb4vfiuf9MQFZwkuNQ7eW3FRTqgTIQ789zbCmI=;
        b=YjGazzWJeuvAEZ4OFtyAlTyj3kH3eO5q7bkX6Vigo/Efh/8P6w8Be5ZMWt5AjC1eUO
         y/b9aV6lm5MGknOy1f1RUt4iQ+Gy5JW9fnU2g61WlqzlHNSqNMs1ldwk/7GJoEoW33Vb
         56HLkuC8PqDkKmWIZHUu9N9oNpSkWy0d6kEyoKdH7N31dcmpWBgvzaeDJVWbo4ni/1Af
         Q27up1xnNmkEM8ZVLHKRebEjtKggUVK+KOGMcVyUIFH7DEku2RxKQKeF67cE8cRf5O70
         lWTerzGJ+7pyGQtlzUk0t/WO9nlEtuJYU7vfzaObF+sjHIUppia93MBia946N8AdDkhF
         hkzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787226074; x=1787830874; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vwo1LenmOII7Z67ayqdNDGxIVSqjq55z7Fu8p8GGYM0=;
        b=oAmnUN7l6rholwSzuna4R5H2UIS5cXPSnJ0QgEsbVpDToxR0NdCp8hQQPVjMNKHQt5
         12jtPP6Dg4M6NbW/DQhL73XIbsBAalmgy48ZT2Q6VUMyJLqfehq3phU4iGi2tvYC92Kw
         1dCpAHy1wYjXWCY5N2gr88tiSEgxShSn5Uf9h6pSB3wzAn2Csd6ju8gAE+d1WueX2Qq4
         2iBNuMXyvpRVgMWsJpToo/sYrBB+UJQA5Dk7XoWthxGsUpmQ7GTGJGhufMZM8G2XbRWZ
         rA73sMS8HZzMDhexc5PbLa6kRT6SCcfwtP39Khz08nt+KWLWQ6xMdKbiqfMAC+qjTSAZ
         1caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787226074; x=1787830874;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vwo1LenmOII7Z67ayqdNDGxIVSqjq55z7Fu8p8GGYM0=;
        b=nxvY3ui/EKJaa1/KoHFnRKgaL12oNPkB1CxG5YQzA6gIp/+cO01gpueG2gvsza6wnA
         yqZUSGOGmYqYM6+s8lvAMru9TcFdssZR85Jo05jbBQe2bbQy0sVL3K0vYDBnn7eyqwRh
         NVmxnvot0YtQ6a5vKN+pYiyIlDHCuBe0y+3kfJK/yQzVdULJTPnUxs/2Hp1+KF9wtzjs
         gtvn3eWWASQGtOwcm8mjHkHZQ3Z6zHRPdU955Xp9jacuP8ZL/h/3xjC1ODOL3HzvymDQ
         lNtedROWkI8nzYuKMXYW6c67ZEvXtdlbx5nwHctLyf8esHxBSTQI2mF/i37gXUm7zvFd
         CRVg==
X-Forwarded-Encrypted: i=1; AHgh+RqoEM/RfwsKZFtNe6f/ouminuzdLzuwUMetIIVpEVHZ0YCoKpqpwp7dsBdRspP0hVvN+eq3kbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDu/CSB7G+SKdRuC/v2QVgaaV1RjHoQ5G4NasMtxpFzHKDeJE+
	aGf7+ukvgUTubjOcUSj7oYZoOxJrLD9epI7pTYhNG9JwnaDnM+TczpqLi3Mymsfdd6KJK/FLs/q
	cM1t0UdPspo2uhZyRYend3sZZ5O6yFSk=
X-Gm-Gg: AR+sD12h5GzXtGFSPE4NfbFeCH21g8hysEfzfreKrHGt8aZs35tRJTgMNWhJlZaWgTO
	lUgm1RcWFmCREt/lxDpyGvRuz1HiWW28+6V0ZUDst23cxYSJLd/Fi6kK6F9DAT9h7TeoNRFfP84
	1Q3msr11neXMIyQM/4nUGtDGpZ1ROmvDrI/lav675YOjjraka7nBT2j237TxCw6SNFc8ZXo2y54
	L7b7xu8qY3DuYWHw0Q+YR5d+K8aDNBQQNk2HwyoOB8W1xvFWHb6ah6fG7nkZfbj5bDcuH23Ok/8
	sAlLE1dCmYrlD7p8fHuzS1PCclGiJoKxMdSiqUbY4Mwi
X-Received: by 2002:a05:6808:f8b:b0:4a4:cedc:6859 with SMTP id
 5614622812f47-4b2cdb56ae5mr4743085b6e.4.1787226074349; Thu, 20 Aug 2026
 04:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819034652.98938-1-duankeqiangcym@gmail.com>
 <aoW3fOhPuFY7Whia@intel.com> <aoXJpPDqwu4IlmdX@google.com>
In-Reply-To: <aoXJpPDqwu4IlmdX@google.com>
From: keqiang duan <duankeqiangcym@gmail.com>
Date: Thu, 20 Aug 2026 19:41:01 +0800
X-Gm-Features: AcwNN1UfnbAUM-lAYdJoYYjFA1U-KlBYqSG4e-dhdBg2HrmLwz2RWuNdt-gRAwk
Message-ID: <CAMd06XcxqNassViy4hqFpJ-Qm4aV5k8dEZG1wpDOGAs_YMp2zg@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Clear GUEST_ACTIVITY_STATE when userspace makes
 a vCPU RUNNABLE
To: Sean Christopherson <seanjc@google.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 19, 2026, Sean Christopherson wrote:
> Thanks Chao, I knew this sounded familiar!
> As suggested in the above link, the call into vendor code should be gated on
> kvm_hlt_in_guest().  Yes, vmx_clear_hlt() already does that, but it's a cheap
> check and makes the common x86 code easier to understand.

Done in v2.

> The other difference between my suggestion and this patch is clearing HLT if and
> only if the vCPU is being made RUNNABLE, versus clearing HLT if the vCPU is being
> put into any state other than HALTED.  In practice it probably doesn't matter?
>
> AP_RESET_HOLD is unsupported for VMX, SIPI_RECEIVED is deprecated and is now just
> a variant off INIT_RECEIVED, and getting out of INIT_RECIEVED and UNINITIALIZED
> requires stuffing RUNNABLE or going through vmx_vcpu_reset(), which explicitly
> sets the activity state to GUEST_ACTIVITY_ACTIVE.
>
> But I think my vote would still be to do:
>
>     mp_state->mp_state != KVM_MP_STATE_HALTED
>
> because I can't think of any reason not to?

Agreed, and I can't think of one either.  HALTED is the only target state for
which retaining the hardware halted state is meaningful, and as you note, every
other transition either can't be reached on VMX or goes through
vmx_vcpu_reset(), which stuffs GUEST_ACTIVITY_ACTIVE anyways.

Keying off "not HALTED" also states the intent more directly, i.e. that KVM
only ever drops the hardware halted state and never installs it.

Switched to "mp_state->mp_state != KVM_MP_STATE_HALTED" in v2.

> Side topic, I think we should officially take an erratum in
> Documentation/virt/kvm/x86/errata.rst to state that KVM doesn't support save/restore
> of HLT state when HLT-exiting is disabled.  AFAIK, there's simply no sane solution
> for SVM, and that would justify why the kvm_x86_ops would be clear_hlt() as opposed
> to set_mp_state(), i.e. why KVM only handles taking vCPUs out of HLT, not putting
> them into HLT.

Agreed, documenting the limitation makes sense, and it does explain why the hook
only takes vCPUs out of HLT.

Thanks for the quick review!
