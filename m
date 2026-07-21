Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC9030F80C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655684; cv=none; b=ncQ7Rp7n5SL0gs4u1TAK53Nsjsmz1M07zaBXwFHt07d4xCurb5rqLjFtWhtEZd6imwdukh15DUuUlo1qEZKErHQeysXY7blksPh54tVRdef9Dw83wR0eERJQXtVNXxAbHIJ9GXkqkhIq8IKC4fFJWdcTomN+IyaAccIcbYJCT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655684; c=relaxed/simple;
	bh=MDaAs7+vPO04a1qkYOwW5w3Sd1dy3fuKIq33jqPeaDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7GCdL5V1AlPYuVTt9I61obRqbvEU5741iWbI4Cld780T/rpQ2Dy9EnVHDQxYCP8+T5jyJ1dZQtultRIRXoxrPSISDUdc6oXsFiKiE4Z5gduVpcp3WrwIEvFljkejDgX5Wt+AbwQDL9Vqvdv1D6pqcDtfjQi/YTsix6yCzXnPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TolGeNQQ; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TolGeNQQ"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7d6ba548eso3036092a12.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784655682; x=1785260482; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wjdG+yWvya03OGIYxekLee1BWcLCKdhHp4gWKRrysM=;
        b=TolGeNQQRJHDOm48QsR4DmZGlL4TN+FuG42q82ciZAOC427oEgILNET0vTScH1jvjr
         n9GpQlXKp//5aG3+rYeIDiinRticCPjECTlQxR4K+xeiPvVIIVJw1baDDG8zM27Zzl+K
         RcPNST1WEKnzdue7/Xl7jl7tbgZFyrJEStulb2ggVBLIJ9F418HaNbb5HmlD2nBZAjhL
         Rvopt01fj03Zjyo8dRIZ9XAoXKAnrqynKO4JfXLJSmNCSCxJjx82dTgXhzc2f+Ml52RS
         yT2V+NYNLgGRpGqqKr8v5Mcj3N8qPKy4YKRgwYMUdQSLw3J2BlvaAeyKlfpQSm2TfR6c
         tweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655682; x=1785260482;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wjdG+yWvya03OGIYxekLee1BWcLCKdhHp4gWKRrysM=;
        b=EXcXuykI/wTjQ2NRI/OnupBbhfa/sk4pw/oVIoVY1T3Uu7C/2S+aLw6ZFqzWz1eg7Z
         jXkVSk7lAhyNADQSdLfStux4HTpfh7ameNA1eTdPOrajz96g5LbnVdW4WrS0Iib6trJS
         FWB7YAuMA0QFHCL/oAYo7xzgtRzXCw55/htyVSmVxjlrX60pI05x1LsGGUGaLiekNf7Q
         63KLnl68Wf4h6YAowpvbqS70Szuq1K0v3z9fQjb+mck4SpPHT5HGFtQ7gEH8lP2rgK4f
         AP0p1mHbxst5gtAhPt84ETrh3GyHehTU0xU3S3Qgs+sGNR2Ax9XfAkkscAlwGNri8FeF
         qmzA==
X-Gm-Message-State: AOJu0Yzs6vVB+4K3nTfLKmdXQRMdfp3YJ41ZNoKrp4uXd8LtqnP82BuC
	XlI0tSJf8PCmvTVoz1lLv8poHQcxVcYJpM6wey9qGiPi+MyUYNzJZBiVwT+4mmJMI6jRlWUpuRc
	LHmQdaQ==
X-Received: from pgax16.prod.google.com ([2002:a05:6a02:2e50:b0:c88:868c:a1c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:614e:b0:3bf:b182:94b
 with SMTP id adf61e73a8af0-3c3ad66a462mr22298548637.6.1784655681928; Tue, 21
 Jul 2026 10:41:21 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:41:21 -0700
In-Reply-To: <2026042008-thesis-flatworm-d8ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026042008-thesis-flatworm-d8ed@gregkh>
Message-ID: <al-vQXTtfnq-e7Mf@google.com>
Subject: Re: FAILED: patch "[PATCH] KVM: selftests: Remove duplicate
 LAUNCH_UPDATE_VMSA call in" failed to apply to 6.12-stable tree
From: Sean Christopherson <seanjc@google.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 20, 2026, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 25a642b6abc98bbbabbf2baef9fc498bbea6aee6
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042008-thesis-flatworm-d8ed@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From 25a642b6abc98bbbabbf2baef9fc498bbea6aee6 Mon Sep 17 00:00:00 2001
> From: Sean Christopherson <seanjc@google.com>
> Date: Tue, 10 Mar 2026 16:48:09 -0700
> Subject: [PATCH] KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in
>  SEV-ES migrate test
> 
> Drop the explicit KVM_SEV_LAUNCH_UPDATE_VMSA call when creating an SEV-ES
> VM in the SEV migration test, as sev_vm_create() automatically updates the
> VMSA pages for SEV-ES guests.  The only reason the duplicate call doesn't
> cause visible problems is because the test doesn't actually try to run the
> vCPUs.  That will change when KVM adds a check to prevent userspace from
> re-launching a VMSA (which corrupts the VMSA page due to KVM writing
> encrypted private memory).
> 
> Fixes: 69f8e15ab61f ("KVM: selftests: Use the SEV library APIs in the intra-host migration test")
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260310234829.2608037-2-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> diff --git a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
> index 0a6dfba3905b..6b0928e69051 100644
> --- a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
> +++ b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
> @@ -36,8 +36,6 @@ static struct kvm_vm *sev_vm_create(bool es)
>  
>  	sev_vm_launch(vm, es ? SEV_POLICY_ES : 0);
>  
> -	if (es)
> -		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
>  	return vm;
>  }

Can you retry applying this to 6.12.y?  This now cherry-picks cleanly to 6.12.y
(and FWIW, the very original patch applies cleanly too).

Oooh, I suspect the issue is that the path in 6.12 is x86_64 instead of x86, i.e.

  tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c

instead of

  tools/testing/selftests/kvm/x86/sev_migrate_tests.c

and git on my end is configured to automagically handle renames?  Holler if an
explicit patch with the x86_64 is preferred and/or easier to consume.
