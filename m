Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E64C9001
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602730; cv=none; b=Nkv30QthlgCaBadbgG8TXLnt2+Vh1d1a08BedWDXyZcIRYt1cEXjJGkFbxcB86bZTl+mvvBJ9Tjp1/5WHiZxcos8OZdQKy9CPU/r0YlCzunsO4jHzd0dibOqjv1MPvrancMc4tJa/2t7TebrpIuZBAYk2HyZJcoMcAO6XKFlAmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602730; c=relaxed/simple;
	bh=u4F+lc3vx+jYByWGzH3MQLi5+iszxVz9Dw6kvDqbkF0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=PaJnlnBO06+Z2VGmehkBESJt+NaVv8vrFizduhFXqYxNdRx0iDoB3ctVQsNvXnEVkeuf2jrosQ88gmqWs8FK2DDpCxawgsWTkcNA52GIL+3D+bKAHyy1/cyp+p9YMHW2aY9Ejs51gJZxYf4y2xEFlcAtqX+clOITHONp3vikKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGls6xO1; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGls6xO1"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6d77b3455a9so18867eaf.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602728; x=1791207528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xh2NHRfJCMfylFQd8bfgqsz1kSEX8TvOZMy0ZzkkjyY=;
        b=fGls6xO1ADzKzPNZKWvTAVTnjV6uBTmCl2/YMAohZ2odC/r/01pOOKLxZoxWiNL6IC
         oE41e1fbu7vXfrcm63JvLB+RkXDI5OqQZL+SkafAND18uvS5+PiGR5B6hkXmmKw8KMWI
         Dncg9hrgmt6HfspDGi3MyJaA83gFUwmSweikGiRlsJN+MtEqsnpsFyDr2qwjS6szEAfi
         FoEQaLbCgfuWDOPCprhQHbvX1dn+Bd61oO5fK1XHDa7ZqvAyKL2j6lF1TijOvUaMen9K
         qjRHj2eX9Id2RsK0Yl0vTpWzdTQMQdio/Cf5zYJpLFvHPMVigeceNf+hd4CdxuVKEl+N
         FMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602728; x=1791207528;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xh2NHRfJCMfylFQd8bfgqsz1kSEX8TvOZMy0ZzkkjyY=;
        b=Rm74q//8EYumXgcJcah/wLjYx/j5xn8d4egyyyjbz8uCZ6iYtFQXHbGKUhcfi5H5Lh
         CltmBRQJHG7Ra3NBvxxdqXIa0Lz6hggOJ26ToxFwzvsikQ6pQDrsmVu8ETgEU9dHTDho
         d3af1p+nSAJfrsv6F8rfeNMlJ5hf12kXU6mBk3l7YKCXwYSEutSYlIapuIl1h7YwReob
         VhIsQZMeBexO1UOWSgspnv59CRmOuS1miAukkUwAYf9TAJmzPHVUZB2NJWnX6GoS4P+O
         enoQg3Dkhdp8CdJ/i2pYfIYcJGYxmULT6vHvgHjr0N3/cvFoqlrMLw06UGgQ3HwBRQqK
         mprg==
X-Forwarded-Encrypted: i=1; AKwUvByPblqk1Bc3YqOiokMb0CujRjGEGysYk5002S9be8dOh1kXlebUuN10h5RwoHg8KSqSAtSwpUk=@vger.kernel.org
X-Gm-Message-State: AFuF++nAqc48rC7dYd4BN2fCh3ZrisKS+ocDW7vSUM5V8isfnIV60+ca
	t6OxZ3ph0k+bX0urhKByFgrTT0w6tmWAwb2pY63KXxccFAtbEamRLUOEu2erCDTs
X-Gm-Gg: AYBFou0UL0VLfeBJGHovsJD2dm0pDyuyXCUwYMA6cfdJCl2uu7rG9E4PPdtq3wh8nr/
	LEZshG3BmAEeVm4BtGYa3sptQkUXTZclYX1jO0gK1qfyEhjXsZwfe5vJqyK8rV4CWjLu9BCtZc8
	amEgtrSCkKylImaYMXk2uUOTmv0qgFIQJMZkIuocEMBNBDahIRSWeVXaEFDu5mwC5dpM9b6GAxn
	zpHtWVC3d2UEvFbro5QceyP7Hf6KtgvtkSZ+TdNZhhTj9Ki1ipcbNX5tLfK3XFKHm2cz6QX3KI4
	tYSaoMxmFrKn1JM02Q/7QF8LwIfdFbZSqai3UNiAkYeMT9MZXo5hN/G4aQ3VP3XYon2m5jxDQrH
	LJ4smUbKCiJDx7+mFQJoXnZVLvQu2I1HWHGrtXWUw9fAst+sJYmcBcWmHHsMmx0AmT0MmS1YjtQ
	9wXrR1a+0mfG2C7ryUXtX/bjlkxUOYTgu74GLU4NAzwP3X1Vl5nWP5xGFzZXkoFs6dlSl3BrvF2
	5RWaytEi6OHS3ukPa3oEvtBgIa5nqsSLKkIdLjV3hou1h6aN08ORQ==
X-Received: by 2002:a05:620a:2888:b0:93a:ea:b00e with SMTP id af79cd13be357-93c43d9e0eemr2013943785a.30.1790602206503;
        Mon, 28 Sep 2026 06:30:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813a443fsm151650285a.12.2026.09.28.06.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:30:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [RESEND PATCH 1/3] KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
In-Reply-To: <20260928122837.8782-2-amachhiw@linux.ibm.com>
Date: Mon, 28 Sep 2026 18:57:16 +0530
Message-ID: <v77pjykr.ritesh.list@gmail.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com> <20260928122837.8782-2-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> The virtual-mode HPT hcall handlers (H_ENTER, H_REMOVE, H_BULK_REMOVE,
> H_CLEAR_REF, H_CLEAR_MOD) call into book3s_hv_rm_mmu.c, which accesses
> memslots via kvm_memslots_raw().  kvm_memslots_raw() uses
> rcu_dereference_raw_check() to bypass SRCU lockdep annotation checking.
> This is safe in real mode because the entire guest entry/exit is wrapped
> in srcu_read_lock/unlock inside kvmppc_run_core() and
> kvmhv_run_single_vcpu().
>
> However, since commit 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual
> mode handlers for HPT hcalls and page faults"), these same handlers are
> also executed in virtual mode via kvmppc_pseries_do_hcall(), which runs
> after SRCU has already been released on guest exit.
>
> A concurrent KVM_SET_USER_MEMORY_REGION deletion or move can therefore
> call synchronize_srcu_expedited() — which does not wait for this thread —
> and then kfree(slot) and vfree(slot->arch.rmap) while the hcall handler
> still holds a raw pointer to the memslot.  lock_rmap() then writes to
> freed vmalloc memory, leading to use-after-free and memory corruption.
> Because kvm_memslots_raw() suppresses lockdep checks, this race is
> entirely silent.
>
> Fix this by factoring out the 7 HPT hcall handlers (H_REMOVE, H_ENTER,
> H_READ, H_CLEAR_MOD, H_CLEAR_REF, H_PROTECT, H_BULK_REMOVE) into a
> helper function, kvmppc_pseries_do_hpt_hcall(), and wrapping its call
> site in srcu_read_lock(&kvm->srcu) / srcu_read_unlock(&kvm->srcu, idx).
> Targeting only the HPT hcalls avoids wrapping non-HPT hcalls that sleep
> (such as H_CONFER, H_REGISTER_VPA, H_PAGE_INIT) or handlers that already
> acquire SRCU internally (such as H_RTAS).
>
> Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
> Cc: stable@vger.kernel.org # v5.14+
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 70 ++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)

I had looked at this path in depth earlier itself. LGTM.
Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
