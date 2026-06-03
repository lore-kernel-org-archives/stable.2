Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75423B38AC
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500260; cv=none; b=HfRzlo5muyIs1hM47poC5hVuc8B7LTy+Iaq0jW0phHgMwIL19k7MnPAD8k2HXSO/bSiQPJs2Pg47G0fKMj/sz0Sd97gKJnauI6r4xhtBQlXkqf/Qo0o4F075kBHrPoMcW5GurqHRY7SFxq6LKtBpA1FsFSaFR5lLcVTbNOouxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500260; c=relaxed/simple;
	bh=y2MzPoG0MBmV9/S2CGOi17yiKJyXbHXPrURfp3Atgkc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=f/AF4/0NMx1VvzNPf/xPZ45jAxopO68B0eCqgcaW+iL2USPsazL16LXLl4tkFqKu576HEhpABt0MqgP1gWGmJQhi9EbmeyHGT1R5YiTWdvZ7WjdK5HXrU2UNaMn0Eh/RE4P09A5jMD6OZlHMsOaaxwdDqljo7QFqI5suxPcAojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+ZSKX4Z; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+ZSKX4Z"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c858d69bde9so1991471a12.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780500259; x=1781105059; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=acwBnprFgwqGQFKcy6Zu5y1vKCe+2/zpivoZrYetfHk=;
        b=n+ZSKX4ZO6fXZWVJSLJCCrokYWO2iillfnIsrkhOqSFVlrdcKMjqoIe79+KCX+34bd
         8CUXsh9ne1F7TyOtZ+mZocplQ+K+GEvo/N3CdkxOWe486ftFobP8i+ccQckIzlnpMmIM
         mWO1IkO7n89CKudClVO1Uxackh7QON0sX3F3BhiYc5eJvXx4eXLI3xMkG8UMwUgFw6Oc
         8sfX8vJ4WqiXyz//Cy5iy/K4i/Ocgz+SB1Uske50mTjWHcW5NL8W0ZRJDVXPkk2y2FvN
         Y1gIfVWXa9MfHZnmWIbfHss0NFmIVo/TZpl4osk9azJhAjtlyAfdl38yJewkUI58rD2K
         37uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500259; x=1781105059;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acwBnprFgwqGQFKcy6Zu5y1vKCe+2/zpivoZrYetfHk=;
        b=ZYq+VbpsYBemE2/8Tckb4wR9j55mEto5BOgeYwcP4vARVBDWCyUd5aWpygRax0E/41
         4fqN2qM+IIkfyGsyfNw1T5j3VYmrTcYncKGTguqWBytlKyjYo+3BAsw5P9WaYjLh3FMU
         TVxTSxAi2jNFJ9nthWq/SdOchra/rNBXEzsCut+AF8Q6/Y5GktGQDXWsj54rxSCcKG7m
         aEPkY4zanlewxekdSkRg/sF6BdpWGx/+jTTfc+c6KGiT2kxpaqg6qedQfqN0w2il8Iyh
         nCkrDWvsWVQIi7aGtGacFl0bl+Tl7o73lXaRboZ2T1Senyn3uM6SCDpQ01px2aDhZK1n
         adAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n9lAIlsBGHIuD1jnuAPff4QSefrp55X403WsB/A0P26E/REimLmuEh5RBYflsi3odBKuNjuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRC95//4wOuda6s7rM5hS+WfrHop8idOLf40FriAYs/nfCuzca
	Cwmu3LACa3cFrpSCSsYm5Juf4JukL1k3VjbWfffpis4BY86daWV8Bx6E
X-Gm-Gg: Acq92OHkK0iwW7B00o7ZaZpraLWOmvdULg6k906xLl/Mpv7z7ig05WRWpzZpAhqfvXl
	RWrXx+4SveZindkLMJ2yWezQPLycDhFuNIxv551Z9LwJ+SB4GVKQX0htMR4S3BbDPq83ZtLY5N5
	mcYotJYU8CHznCjvYvucczKV4PlEUWS1OzxSyfISZ5FeKtVzLmXiLycY2fuBCsbtKTcLDt7TK+X
	gJkfqBG2Frvlo3QM37tZq8yX2MKi/LA4y2jQpR+cb5gIVWVKnDJ7f7qCEA66hA/YSTou36MSC9b
	cNmMZLC6/qorc41B7X49Y26eOuJVJoNOU6uYHupp0BitLXE6pajpZ9sJzNFnUMyTu+1W35bXYK0
	cH/3w6s3+dcG2gpSerbPWmGRpiXgyfYn5O1ORawBtIcJX7pYUKaoEWaIms5OhDlx5iqXU8XqyXT
	mM50JgV8E0cBMJblL64ydj7Jc+dD+fFqCu
X-Received: by 2002:a05:6a21:691:b0:3a2:d68d:9e78 with SMTP id adf61e73a8af0-3b49732971emr4778730637.4.1780500258903;
        Wed, 03 Jun 2026 08:24:18 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df043ce0sm2671767a12.11.2026.06.03.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:24:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260603141539.47620-1-amachhiw@linux.ibm.com>
Date: Wed, 03 Jun 2026 20:41:15 +0530
Message-ID: <pl278xrg.ritesh.list@gmail.com>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
>
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
>
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> hypervisor rejects the request, leading to a late guest boot failure:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>

Thanks! It make sense to return a proper error code to the user (VMM)
while the VM/VCPU are being initialized, rather then the guest failing
to boot with a weird error like this, at the time when kernel makes this
H_GUEST_SET_STATE hcall.

> This situation should be detected earlier. Rejecting unsupported
> 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> invalid H_GUEST_SET_STATE hcall and provides a clearer failure mode.
>
> Add a check to reject Power11 'arch_compat' requests when the host is
> running in Power10 compatibility mode, returning -EINVAL early instead
> of deferring the failure to the hypervisor.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Cc: <stable@vger.kernel.org> # v6.13+

Sure, v6.13 sounds fair as you pointed out.

> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changelog:
>
> * Moved this patch out of the v3 series [1] as discussed here [2]
> * Addressed below review comments from Ritesh:
>   - Based the PVR validation on cpu features
>   - Fixed hcall name typo
>   - Stable backport

The changes looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

