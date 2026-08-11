Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510544471C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459467; cv=none; b=NvQEWSPyV71ZLDS2n9zxu5MAbtZ/B2nOXDvCUuMv0yFybqC6EC96o/pgegmiisYqOuADHU/es79QCTpLT48K6kO9fpls3MwEWcSu7Weh7CR4GW8zxBHpP0Sdkgauu8sLlueArYcy0u2SjTG6140bwlt00iWQJUcjaI5KDfkktRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459467; c=relaxed/simple;
	bh=z7M237ruQK7gHK+Tu+KiQLo1PpbdrIFE0xtJTv+oKEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EBUFx179qof7TuuMKlp9pIWaAPGM7Pde76OMgzwb2CFiCM2AJzTYEVSP2U/82+/4TZC02JLJXukWQAOfNTEmQ/kd7Dr1oMYWPgADYZmKhwSwB9MULxPLgjIbNcuMOhKZmezRsvl3Bsply5m2ioClGeoPtcZE1kwesnZ2rjn9efs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/jUQlgJ; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/jUQlgJ"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8484b9fb055so7779490b3a.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786459466; x=1787064266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnIOn+7Rt31kCAO2bTU4UwHzTf1viFKgNwstMdN6akw=;
        b=d/jUQlgJRnxhy8XZx1HF54pRmognoU2MuX63Z4aSC15ksNvqhE+qGRfWkiZEt3aFPF
         xw1vKfMhSpeN96p/6l6hFumT2ATcb1Vz9QFNEUUe1/3Ld45TgxkbW0hFuDBA/HqnI6EZ
         lYpQ4VM8tFgrxEIyBJQXOyzIM7sO23SvSSSQWkPUdsRuxwMKgz96W1Jb+ODwWMWBoO/A
         hOCwBXN66A3fqjJPMGRr0epi0EiJZ6KFcFJl/CCZ7lBlTPu3NQYXmIpo8fku2HYsoqju
         KsDAdq6RZ6b9uZCO1741AiqFCs7JC+j8tzmDI+/tiRJEqJxuqTSoAvyvltkLWvrUnDxH
         exhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459466; x=1787064266;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnIOn+7Rt31kCAO2bTU4UwHzTf1viFKgNwstMdN6akw=;
        b=S0y7qGOC34tfMbWhK2D0kd0uUCvOMFUGVb3f1CnhzqN7AKS+vdZtQKjiss0pcF6w0A
         00MCOjwLMUtAHFZdmkcLsz5CaXG7s46ZQkwgA7nTj+okrilBqz1WXyHM1gufutCg0OPO
         8NuoPWswGQaujBjBarhr5BdSXO3EUtsOzMyIdk1CXFHed5iqVnAOa5Iu+WJiX5wdMWUz
         EMBivATUdAtxkD/T+FDihoLsefRZRgwBX1Vy8XfMqvDImR4GpX15srJuT+ckj1WXjum8
         W/4Im01udJBx764iJVLZKBKJHqIyYQGuquV4MemntpfgOtdSNwnXxexV+BBIECGfSneU
         IgCw==
X-Gm-Message-State: AOJu0YzGAvpusDfyjD4042YPEBUAi55ype/A8gjA9zdaVpguTbAmmd9k
	B/jPC3txqpOQSG9qiK6nonqwRL/bNK6G9rEGDl65XTBP8RxEwTHOfGobaAh5/AbjhTd99qlY40a
	R4sNkxw==
X-Received: from pfbhu19.prod.google.com ([2002:a05:6a00:6993:b0:84b:62d1:9fe3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bc0b:b0:848:4faa:480b
 with SMTP id d2e1a72fcca58-84fa8690a0cmr4269757b3a.12.1786459465618; Tue, 11
 Aug 2026 07:44:25 -0700 (PDT)
Date: Tue, 11 Aug 2026 07:44:24 -0700
In-Reply-To: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
Message-ID: <ans1SMXHmdB3uEoe@google.com>
Subject: Re: 6.1.y status: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete
 root *after* making MMU pages available") / CVE-2026-64561
From: Sean Christopherson <seanjc@google.com>
To: "IP over Parrots (with QoS)" <opensource@rfc2549.ca>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 11, 2026, IP over Parrots (with QoS) wrote:
> Hi,
> 
> Commit 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root
> *after* making MMU pages available"), which landed in 7.2-rc5 and is
> tracked as CVE-2026-64561, does not appear to be present in
> linux-6.1.y as of 6.1.182.
> 
> I checked with:
> 
>   git log --oneline origin/linux-6.1.y --grep='invalid/obsolete root'
>   git log --oneline origin/linux-6.1.y --grep='2abd5287f083'
> 
> Neither returns a match and it doesn't seem to be in the queue.
> The commit message notes the invariant being violated was
> introduced in 5.9 by f95eec9bed76, so 6.1 looks in scope,
> and both hunks sit in direct_page_fault() and FNAME(page_fault)(),
> which appear structurally unchanged on that branch.
> 
> However the announcement[0] only mentions the fix landing in:
> - 6.6.148
> - 6.12.101
> - 6.18.42
> - 7.1.6
> - 7.2-rc2
> 
> Is a 6.1.y backport planned, or was it skipped deliberately?

Now planned.  The fix doesn't apply cleanly to 6.1, and the resolving the conflict
isn't super straightforward (though it's not thaaaat bad either).

https://lore.kernel.org/all/anpVAhjqvBvIuoa0@google.com

> The security tracker [1] for the Debian 12 stable kernel (6.1.y)
> shows a vulnerable status.
> 
> I do not have a backport to offer, so this is just an inquiry.
> I am happy to build and test a candidate on 6.1 if that would
> be useful.

I'll post a patch today and Cc you (unless I get goldfish brain, in which case
I apologize in advance).
