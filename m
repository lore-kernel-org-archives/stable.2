Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5E2D0C94
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136562; cv=none; b=f2UpieaSAOR3V4biYFMofJd8j/yjEPaRfL0Iptl1S6gx3tiW0iSjGAPOGNQeEqjcczkzC0+HL+UUGFij3kYaQSrTpCeuZiHV7BMHvLAoeQZZ4Qw5c2JEAJmx04AcgSni3frFiAvs359DXb+Kv0aKg41NGTUA44f0WTpY/0WZkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136562; c=relaxed/simple;
	bh=wPGpJXrbvWGdmi/PyI+IP++WuZrN+46ok4JK7M3JAw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dkxOSIfA6ILXXZ7Sftpg3T70wKkL8mizZYmOWXtddXocBoFWWOYGnhDoqAt+WwlPN3WEv7d/3rrRiuIB4Am9xuKKT13U2zj97SCnzJYQBb4Q8GdimwWmzgYLNjdqpLR/L2GYt1T61fNphrWrR+L+XRpovdZfTKudrRwuxsYnGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQBN5W+k; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQBN5W+k"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc18ced1a5aso1655558a12.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789136560; x=1789741360; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJWAlxUrrT7rtWuLjVBj4MVVd5pGHa0J3Df7Xl5rSwc=;
        b=eQBN5W+kXKStrNeBc/XqLocD0C2wZJ+1D5GnsHmID7Ep/EAT2hYF8l4phEOrnyiURd
         ysVOSxJ51aMBT2k9YTjKURr3eROG+LPceWpMJgbtaYOdtZSEf32+frVWl4To2xgJNKRt
         w3+0eP/IGqItjMCC6h1Kl7lthEYzCQ3SCMh7/VKgYbT+EHoQWokov1p6Epkk99YmH6cV
         P88JPsBGpim/gs5RMMWJE8tVq7ECgoGgFm+h+AOWKyBJpe7V44DwWGD9icMyH0brB6/Z
         icQ+9LEC8zpK/Mur7Y6Clbsw6tdfc/4i3dOzrxOCo4/tdWh3VFe9Zt3PlLx2PTU+yuKQ
         S/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789136560; x=1789741360;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJWAlxUrrT7rtWuLjVBj4MVVd5pGHa0J3Df7Xl5rSwc=;
        b=Lx0PZ51YnVrSa3HQuhglggryAeyFYCjMy0SfdbgANNK/5hH3ll50QDjyY6i7V0gqkQ
         +EbNckn8IL66iFqghaEqI/r6ftyaQVHFxWPzB/TIJ2wph4/HSWVUETyB3BCBYKM9orEK
         arImeas60uPsSaqOfNYLQSIXdzjONLHZyONFfOUkP1D+9Cq66lkb95Tg4R0lHt5tCg4Z
         AXCZOryhsZBU8x/qOhiRpfFxncNjumd/74mORAf1wj7aLbEyYpEeGfrq4bgCEAZ5NHPB
         4fFiP6kMWvqVE7aTzYIPHtfG+T/N4mwqkAWUYyeXYdms7b+G8ax4dP9Qov9LiG6ulCe1
         DKrQ==
X-Gm-Message-State: AFuF++mWdjGa54Ypu+E+pW0I6VkkZtEf5W8FYHo9u+d6cix0DEcxeIh0
	e6+mUzHIFsiBkYbdLTmeCnTN4Ym2hwP/cYMjpb2kn+r/PEqEuVEROPnlQdT4JiqCjcRMgPDcOfe
	oM5yNTg==
X-Received: from pgbd6-n2.prod.google.com ([2002:a05:6a02:64c6:20b0:cc1:577a:be35])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c70b:b0:3c3:bbe6:95c7
 with SMTP id adf61e73a8af0-3daed6813c8mr8313675637.17.1789136559640; Fri, 11
 Sep 2026 07:22:39 -0700 (PDT)
Date: Fri, 11 Sep 2026 07:22:38 -0700
In-Reply-To: <20260911120502.489632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026090915-drainer-judicial-082f@gregkh> <20260911120502.489632-1-sashal@kernel.org>
Message-ID: <aqQOroJmp1a3n-0W@google.com>
Subject: Re: [PATCH 6.12.y] KVM: x86: Disallow EFER.LME and EFER.LMA if long
 mode is not supported
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 11, 2026, Sasha Levin wrote:
> From: Yosry Ahmed <yosry@kernel.org>
> 
> [ Upstream commit e62392bf39ebfdf60d1d082799397fe1cbf8dfc5 ]
> 
> Remove EFER.LME and EFER.LMA from EFER reserved bits only if long mode
> is actually supported. KVM does check long-mode support before allowing
> the bits for guest writes and userspace writes through KVM_SET_SREGS*
> (in __kvm_valid_efer()), but userspace writes through KVM_SET_MSRS only
> check reserved bits.
> 
> In practice, this doesn't really matter. The true motiviation is getting
> rid of the #ifdeffery when initializing efer_reserved_bits.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> Link: https://patch.msgid.link/20260713181020.2735367-3-yosry@kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ adapted EFER changes to x86.c, placing the capability check in kvm_x86_vendor_init() because kvm_setup_efer_caps() is absent. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
