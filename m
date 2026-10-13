Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF26516141
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901997; cv=none; b=fLXpVhjBTKG9+8CaTxBce+ec+0fubk5uu9VoBT2VwODDW8JxHk/vgoKZ4KmisjFWSyWSpY3xbBqwc8z9GvDl69ckofFj4ZUaeyVFp56oKX/98bAACvvyub8Cxh/KOFx5UZjBgYL+n/CK38BsI2zX2tPCsMRtiw/iHZzlU+jygJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901997; c=relaxed/simple;
	bh=yNua8yZyfzKx9mMiFfakVIbxsbgf7Q5tUSx+K4z679A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=R67/Szq9fAFMBXCJHyDgAWIi0m/noNWUvZOYbZw+jZ0+4MPzdozciBqI0l1XNBLRO0BPj8ul/+pJnUeG9/H06PAxZnItsPxhqdv73rD08nxKSWbpJqbWXtVA0L3ltEm4VuLcyki6IvyvRndh8IyoUPGQRTclNcVNc4TYycpc0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pveBdzoi; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pveBdzoi"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so800700eec.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791901995; x=1792506795; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2D70tRlN9hXWyqkkdtTDdIyLlgX6luaffedR+k/mZw4=;
        b=pveBdzoi54w414rTy9xKGgrsNzjwoRTWZT+OltmK6JUPwPnNfsHWtalKsGRbW4FOG8
         xFZZd/UIBXWiTjA/cSXIJkPsq4NlTpMRXwPwUUWNwDlCZ0dS3vcaN2UqaVu/yK5VOwAq
         VT7o2H2OyjbYYCMJo00aXd6JdTwJmqheCiMG13orSqvKdNiZMUDuHK8sv8EpqO4PqyE3
         x2t3Uw75FhqSV1pLy+oDg24zw6y4A+WX8CepBzGZjOo6Qi5f/DaGn5bHeKQNmRtfJmuM
         wcixDgdR6SiqcxvNfbrRDHvOzXaYHelS4HxSEn39/U6/w72Qm6XMDgynXr5+QqVh95uz
         U+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901995; x=1792506795;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2D70tRlN9hXWyqkkdtTDdIyLlgX6luaffedR+k/mZw4=;
        b=NrNslyp1ne3ANL2O0+lgNU3numxeZn1r1Hiqn7Ia2ZcH7ruiHrav6cfzTEHld070tS
         g/5aJ+ammMGyV2CjHxyJIueCSX1DK3jHpG4ulFth44zPNTvhg05dRYeWHjl76uNJ9y4n
         i/uQE/stc7I1k/GfxGPnshUl5gbDSO4uiCHE5pvkvSaXo9IWpOCiWjYL8VfDhiAzZoOo
         dzAtwRhj/85eHnkOjpKaPgRTgBQAxIyXaAVDYNHiGlaZ3NBY1A1dWXWvxWs/SJElj8M9
         MXZjp7OR/bUuWharK0QKkuUZ2zMVJDUj4liifyg/o3V7DyjYczGgV7ZOO+WTEMkTr8kK
         6MAA==
X-Forwarded-Encrypted: i=1; AKwUvBz9jDb9S/pp1Jo4EgzMJg3loD+UKSn3OLzmeEMomc9JRvFWmH48GGmrrADCho2DzXUyAD0UmO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIw3jkyzAy60/RyxJKEc83pHEQxepwKr0XAfH/PvE89wpiBH+E/
	AuPzEUdS4hoEjbrvUiYx+Uykn4ZPppB47JflFUjJg4kg8MeF2Q2n+fV2+5GTbFxm
X-Gm-Gg: AYBFou2f5atdZZYrcN0hjXro8ygUGFwooAhX6z6LLZgWWQXmSiRfJ9PTimKDvKNfgm0
	mbyGYS/UPhQvquVa/xFXjRqotRt2jgYv9JmXuOJsFNchnzSXvDMa83BY01gs4uvLjA7GG6nxnhQ
	DVtEZLd2Ckyeqb49YFwHNagLQtMIv/XO4DZ7lWfjoNCMXpM8agxZRSK0tQ8t2jN+qES+bMpcNmB
	AUoTA8wdhFCThRE+2Q2qRNbmZk8iz+kR1/uS0otdvUj9Tsdwgj+Q1zX1/5iWtkg+4WI6uFcizZ/
	2A6iE8P/iO0sOygwVX2KIHH8tdG0ajj8ulBn5irJDtrsMZUgMrXWqLvJQdLObw2L8+BIMi4P+OA
	BHiOTHtwXpJFEb63Pygs14oQZ7IOi3kA7FGdNXcCYyIeJQJMrd8GtsSj3rfeiDcx92fis5oKSHh
	3kfznd0TQqRKcZFhGyCwdWMwWy5Gxh/jo7YU1MAfZJPOs0H64Jl2L1i6RbdoOgSxt21KhpNaITy
	X/t2sAi
X-Received: by 2002:a05:693c:821a:b0:35c:813a:1c81 with SMTP id 5a478bee46e88-35c813a23b6mr2871023eec.18.1791901995288;
        Tue, 13 Oct 2026 07:33:15 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d20dsm47942824eec.12.2026.10.13.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:33:13 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] KVM: PPC: Book3S HV: Take SRCU read lock around kvmppc_h_page_init() call
In-Reply-To: <20261012082922.218799-5-gautam@linux.ibm.com>
Date: Tue, 13 Oct 2026 20:01:51 +0530
Message-ID: <y0c1r7s8.ritesh.list@gmail.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com> <20261012082922.218799-5-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Gautam Menghani <gautam@linux.ibm.com> writes:

> Since there is no srcu read lock around kvmppc_h_page_init(), a
> "suspicious rcu_dereference_check() usage" can be triggered by running
> host linux with CONFIG_PROVE_RCU=y and the following code in the guest:
>
> plpar_hcall_norets(H_PAGE_INIT, H_ZERO_PAGE, phys_addr, 0);
>
>  =============================
>  WARNING: suspicious RCU usage
>  7.0.0-dirty #227 Not tainted
>  -----------------------------
> ./include/linux/kvm_host.h:1074 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by qemu-system-ppc/2093:
>  #0: c000000354197ab0 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x10c/0xaf0
>
> stack backtrace:
> CPU: 30 UID: 0 PID: 2093 Comm: qemu-system-ppc Not tainted 7.0.0-dirty #227 PREEMPT(full)
> Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.60 (NH1060_158) hv:phyp pSeries
> Call Trace:
> [c00000033e1bf430] [c000000001b3dbd4] dump_stack_lvl+0xc8/0x130 (unreliable)
> [c00000033e1bf470] [c0000000003da964] lockdep_rcu_suspicious+0x1f4/0x290
> [c00000033e1bf520] [c000000000231424] gfn_to_memslot+0x1b4/0x1c0
> [c00000033e1bf560] [c00000000023637c] kvm_clear_guest+0x9c/0x110
> [c00000033e1bf5c0] [c0000000002714a4] kvmppc_h_page_init+0x160/0x1a0
> [c00000033e1bf610] [c00000000026c040] kvmppc_pseries_do_hcall+0x1930/0x1940
> [c00000033e1bf6d0] [c00000000026fb18] kvmppc_vcpu_run_hv+0x268/0x800
> [c00000033e1bf7a0] [c000000000246b30] kvmppc_vcpu_run+0x30/0x50
> [c00000033e1bf7c0] [c000000000241ed4] kvm_arch_vcpu_ioctl_run+0x364/0x530
> [c00000033e1bf860] [c00000000022b870] kvm_vcpu_ioctl+0x1b0/0xaf0
> [c00000033e1bfa50] [c0000000009b4514] sys_ioctl+0x144/0x190
> [c00000033e1bfab0] [c000000000034330] system_call_exception+0x170/0x370
> [c00000033e1bfe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
>
> Fix this by taking a srcu read lock around kvmppc_h_page_init().

Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

