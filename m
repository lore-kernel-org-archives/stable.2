Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4D3B2D38
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133111; cv=none; b=rIj+LvS5YjzmB7kOMU52o4+NTdXQk1/B0i+zvAy+G//BDpVPsT/WKy/jaaB8Fu/LDa+tS1Gc43gdbcBrgdMZiVTsLyIwVOaUDDX0dQt0Sasr59W3R5pvqAuQ0C8QLuWCOEumVEr6LP0xSqvc73pZ+NffptpGD54PTAN7WANqgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133111; c=relaxed/simple;
	bh=Y0FZ/q9NSwUqsZB5SGCkjziJIozUFUBCLglufUMfcpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVOkSTFiIfN5QCTJcw8O8m0HQzZJM9SZr4DCnMxNfUp7bY6mNJCDbFvs+r7mqwsQ+KZhxq45R+h2RAMkWJ5zY5kHSSprG462cfXlgkUHS5cn422/7nBasN2weSCiMCa/eNtkvRh0bvM9EM7dPo6zdvxHPio7VOIwZGqyFNYpIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGGmiA9p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGGmiA9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792133109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mFASAGD5AF0Bh7C2vAG6aEKGzuzewP8dQkUrCHzrXXE=;
	b=iGGmiA9p1mu+xPwM4JWvenvMEaRQ93PqNPw9axTAuR9DkEFq2Aa31E0rU7a61UI+vKOs+E
	tc1AeD7jZNwwTs9LKuWL/VBKS3bneeqKtNnhCIo1tzQn4ZXP7clIwmnZham6P+t017gZvb
	Fhk83FAMFNTzH7Z4NAV7BH3twQGdN1A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-_lIkf8fMMaS2vzUgwV6EbQ-1; Fri,
 16 Oct 2026 06:45:01 +0000
X-MC-Unique: _lIkf8fMMaS2vzUgwV6EbQ-1
X-Mimecast-MFC-AGG-ID: _lIkf8fMMaS2vzUgwV6EbQ_1792133100
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D6A81956050;
	Fri, 16 Oct 2026 06:44:59 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 946771956043;
	Fri, 16 Oct 2026 06:44:56 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Fri, 16 Oct 2026 08:44:58 +0200 (CEST)
Date: Fri, 16 Oct 2026 08:44:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	ruanjinjie@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: ptrace: don't warn on missing siginfo in a
 group-stop
Message-ID: <atHHttWKtnKHJnVQ@redhat.com>
References: <20261016024536.18938-1-zhaogongyi@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016024536.18938-1-zhaogongyi@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/16, Zhao Gongyi wrote:
>
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -573,9 +573,11 @@ static void update_syscall_orig_x0_after_ptrace(struct task_struct *target)
>  	if (regs->syscallno == NO_SYSCALL)
>  		return;
>  
> -	/* We should only be called when target is in a ptrace stop */
> -	if (WARN_ON_ONCE(!info))
> +	/* Only non-seized group-stops lack siginfo (see do_jobctl_trap()). */
> +	if (!info) {
> +		WARN_ON_ONCE(target->ptrace & PT_SEIZED);
>  		return;
> +	}

Perhaps we can simply remove this WARN_ON_ONCE? 

Oleg.

--- x/arch/arm64/kernel/ptrace.c
+++ x/arch/arm64/kernel/ptrace.c
@@ -573,10 +573,6 @@ static void update_syscall_orig_x0_after
 	if (regs->syscallno == NO_SYSCALL)
 		return;
 
-	/* We should only be called when target is in a ptrace stop */
-	if (WARN_ON_ONCE(!info))
-		return;
-
 	/*
 	 * For compat tasks, orig_r0 is provided directly through GPR index
 	 * 17.
@@ -588,7 +584,7 @@ static void update_syscall_orig_x0_after
 	 * Don't update orig_x0 for a syscall-exit-stop, as x0 now contains the
 	 * return value of the system call.
 	 */
-	if ((info->si_code & ~0x80) == SIGTRAP &&
+	if (info && info->si_code == (SIGTRAP | 0x80) &&
 	    target->ptrace_message == PTRACE_EVENTMSG_SYSCALL_EXIT) {
 		return;
 	}

