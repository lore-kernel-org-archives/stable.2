Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D135416856
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975506; cv=none; b=HOpUy5llU/FpgAqRWqzqx69f0LP4CEwUYi1vX04K+g6Zy8KQa3281XMU1OljXgM3NadIuv3vNWursncy3IsH4yfBFx6RD3WlN5xDIVptWZy5qukznpgWSxVLhrKQnpqR08CNIYYK37RW4tfv3Us478mLfK1uF3Dt32sN+D17gCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975506; c=relaxed/simple;
	bh=m1kgZk/QnnIGSQq94ScRWI4VTjnRh3pMl09wcBzDj1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHjemeF7eTpt88BoBsVD71eKKIQQAZ+nTnDwG5VO5iCtkpYIevq6SNqtzuKT4/p/rgD6m/KwPa44+NIkRE1Xe8vjdpBaUW6rcbgeJ8v3uNquy3o5R0OnsWiiRncNp+Omj5JnHCVprJrsCw961ScYKC7HkRQWcNz8yUS//NjW/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TK6X8O3w; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TK6X8O3w"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so339009a91.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 14:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975497; x=1791580297; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1MttPZc2WbaNxCbcw+ABVFsYx0hSjd1yRWWbDI1AxA=;
        b=TK6X8O3w7PHvfTxBzEn1xNRHM3zaQA0YonJesndJSXm5l3EYOZYVb36I3wag0aCtTR
         yiV8MdiP5y954sybPn488evw3nTJX/tQXObdmqInx6TMfB/Y1hgF08r3/i+7RmLFmWWh
         dxy88du+76jKfsWBJX+4TavxwtCIvS17ACWCEoBBYNR61cHmrpgLhb7i6MVhj/4RRLD8
         AZUo1rR8W7KMQkvLGtiExv4djDf32tUlI1k3e83t6gAyKbiOh81MIL3vpd3ssVqndRNr
         3XPSgTNELMc67v09FkhiMQEkFJgevkuOjrzPYte3/OPYPmiZiK7ghsGN+i86vDL60CZj
         hNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975497; x=1791580297;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1MttPZc2WbaNxCbcw+ABVFsYx0hSjd1yRWWbDI1AxA=;
        b=knZjwYYoyPyD0YwQRe3xSYxs7DyxLvVn17ROiSS0tVBG6BjcD9dhrC511vwnQvjSYP
         gXUqpE9YzB99+Ld34QGlRRZVft/zzLDIHgsDtwNRa5lqVfC3ukJ3sFbybiPyLCBE8glo
         xdaT2SzpV50q8A7vqac5W7KiR5iOiOrR0lxsPu5NUbYqOtPNns6lqVJoeOCwRhU38J20
         YNw5iybc/ph43lmzjcRg6On5DZw9V8B5lv05UojPOmii7qbv2RhkItGJzVslXLzo1WZN
         KkPRTKu5QRdoEFNwDXa7otlPhU4UhK7AQsAGHlQkJez9ihA8iKDfEQiqGWXh5tBJM276
         J6zA==
X-Forwarded-Encrypted: i=1; AKwUvByzdr0gkHPjRbSSNhr6kDJNcg6IPCgvSErqeR/VN81tZ6Vay85BLM0JQFCsz5f1FdJit8k+U6s=@vger.kernel.org
X-Gm-Message-State: AFq9FYISl+sEKcwNyvzLCiKgGPzMe2ZE1IhfSIHywFAC/UPiVNb8n1wq
	XKRb4xO4qh0waisjp2V2OquIagcVn1gWE38up2Ym67Cu9wLs5CODTiLrRQ9qgv0BaYkmnaf3LV+
	Vy2i30g==
X-Received: from pjot24.prod.google.com ([2002:a17:90a:9518:b0:3a4:b4f0:b161])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f86:b0:3a4:adea:50c1
 with SMTP id 98e67ed59e1d1-3a6ced92fe9mr3693415a91.62.1790975496840; Fri, 02
 Oct 2026 14:11:36 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:36 -0700
In-Reply-To: <20260820123512.87236-1-duankeqiangcym@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260820123512.87236-1-duankeqiangcym@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097516928.4085781.4004685515336917376.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace
 makes a vCPU not-halted
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Keqiang Duan <duankeqiangcym@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Qinguang Chen <chenqinguang@kuaishou.com>, 
	Zhiping Du <duzhiping@kuaishou.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 20 Aug 2026 20:35:12 +0800, Keqiang Duan wrote:
> Force a vCPU out of its hardware-tracked halted state when userspace puts
> the vCPU into any state other than HALTED via KVM_SET_MP_STATE, i.e. clear
> VMCS.GUEST_ACTIVITY_STATE if it says the vCPU is halted.  Add an optional
> kvm_x86_ops hook to do the clearing, as SVM has no equivalent VMCB field.
> 
> When HLT-exiting is disabled for a VM (KVM_CAP_X86_DISABLE_EXITS with
> KVM_X86_DISABLE_EXITS_HLT, e.g. QEMU's "-overcommit cpu-pm=on"), a guest
> HLT halts the physical CPU instead of exiting to KVM, and hardware saves
> GUEST_ACTIVITY_STATE=HLT into the VMCS on the next VM-Exit.  That field is
> sticky: it survives VM-Exit/VM-Enter and is only cleared by vmx_clear_hlt()
> on event injection, or by vmx_vcpu_reset() on INIT / vCPU creation.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted
      https://github.com/kvm-x86/linux/commit/883719f57f5d

--
https://github.com/kvm-x86/linux/tree/next
