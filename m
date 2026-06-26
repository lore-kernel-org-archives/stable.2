Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0AD3F9265
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484168; cv=none; b=ugAP7zfF+EZNjGZoFCjdXN2YYOjCJOOhYq/PIAxJgRRTEOz65loQ9T7sq7kA94jApGRyex8qkLk+2vMTTQykwCGxoSQsbZWqToYusVuEPzSxfOJdsWhV3KR9RX7yCbkyQyMIknPSD18jCAS8Bh5ttU8xDIumPu0CP/eZmdeFWW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484168; c=relaxed/simple;
	bh=BuiKi8nT3ANJ0o4TFP2alv/b/UPldMGvXxUInb2vRhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKEQeoUvKBqfrkn6FxwQJRDWtJc5nEpSw4DqAolTTZcOOZPYrJpSp9Cp1/JmaZVswyr4vitPTVSEHHCoVAVdWR+N0/Z+zzfldlDatwb2CfWXkL7tQVwxWB7dPK4caopndv7/jtNhLK0QM+ix9cSGRALF7xVBDaXulB4OLar0Nfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hS1WJce3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hS1WJce3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782484162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxjc3mAVcsKzV3pEhXiWe9V3Wg4iCKIdlp1rzL9EcEM=;
	b=hS1WJce31DTLDKgDiXDnbULlUl+NaDXBOX80GTYp5tHDfX8YyD/HaLmW59jxh1agmttw2l
	lu5AuZjjpmYArdpeuwQYeKop6IoQg1n8V6gMymfQv2nU39ZX9NO2XtN22LVZF0FdVblKyb
	2p3xo03fItB0lWL/A5u6Nmc0eBUb9x8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-1w9T0iaePlKv9JowjsO52g-1; Fri,
 26 Jun 2026 10:29:16 -0400
X-MC-Unique: 1w9T0iaePlKv9JowjsO52g-1
X-Mimecast-MFC-AGG-ID: 1w9T0iaePlKv9JowjsO52g_1782484154
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04F40195609F;
	Fri, 26 Jun 2026 14:29:14 +0000 (UTC)
Received: from fedora (unknown [10.44.33.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D59721956094;
	Fri, 26 Jun 2026 14:29:08 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Jun 2026 16:29:13 +0200 (CEST)
Date: Fri, 26 Jun 2026 16:29:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Bradley Morgan <include@grrlz.net>, ebiederm@xmission.com
Cc: Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Marco Elver <elver@google.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: avoid shared siginfo namespace rewrites
Message-ID: <aj6Ms6uygc1vtySn@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622164029.11474-1-include@grrlz.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

To avoid the confusion, let me reply to V1 again.

Acked-by: Oleg Nesterov <oleg@redhat.com>

IIUC Eric is fine with this change too.

Andrew, can you take this fix please? We will send more changes on top
of it.

On 06/22, Bradley Morgan wrote:
>
> send_signal_locked() rewrites sender ids for the target namespace.
> Group sends reuse the same siginfo, so one recipient can affect the
> next.
> 
> Copy the siginfo before changing it.
> 
> Fixes: 7a0cf094944e ("signal: Correct namespace fixups of si_pid and si_uid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/signal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index b9fc7be1a169..d72d9be3a992 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1181,6 +1181,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>  int send_signal_locked(int sig, struct kernel_siginfo *info,
>  		       struct task_struct *t, enum pid_type type)
>  {
> +	struct kernel_siginfo rewritten;
>  	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
>  	bool force = false;
>  
> @@ -1194,6 +1195,9 @@ int send_signal_locked(int sig, struct kernel_siginfo *info,
>  		/* SIGKILL and SIGSTOP is special or has ids */
>  		struct user_namespace *t_user_ns;
>  
> +		rewritten = *info;
> +		info = &rewritten;
> +
>  		rcu_read_lock();
>  		t_user_ns = task_cred_xxx(t, user_ns);
>  		if (current_user_ns() != t_user_ns) {
> -- 
> 2.53.0
> 

