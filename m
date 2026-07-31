Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D343E16A5
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491869; cv=none; b=XQkP2IDuw8hweWmMAEKPo6J6FNgjOArMLhQLQ30/flMr0v4aQVgxxoqgJwhJC21p4Bv8imQSaij2/RRInWxBIIZR1pNJjisfX1nV7L8jgY5n4I7EqJ3Qhy1ilzPt7m3meE6Xp5Ww/HcQb8sUOyyFLBeMaccRYHZAxU2eGOJkvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491869; c=relaxed/simple;
	bh=VwchdFwzrqix5V5EoMOGm9IcIsZ++l8Os9oUc2qDgGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAVh7mpvUDqrwtY/SV+1qPUlgmwH5noNHnMhoNBZ1QeeQ7HNYzDRLQwhMY9S1sjWyNHZmORypWihLPNBcuSVHjtjQYZWTMZWu6XL7MnZik9PIFhp8XpF84yD1l5KIVwQmLZqrj9bKynI7JgiE3rr6Qm3ZKLW+UQ2M2NJitkgfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q4mSgeKQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q4mSgeKQ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f7854678cso56172f8f.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785491858; x=1786096658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NmlDZ7ZG8UiYkJXMRTL4X0GdFki7ECb1G0iag5jiHHI=;
        b=Q4mSgeKQbMEMJ+dvu2CyWwzoIi/ec62camljBa/4q+xqLKg8QfyFlpeCYNHJCCrcJH
         XBvjZuzfqX1a239ipv6OcOxDRkz73GViApJpo4J3mwvJZK4z6lw8tZiGrLCNWFiYP8TE
         8DgTy9wBub7YBPZy7AdqsuHgOQmcoRZgibpfeFvhtbYSkTBXfNSvcpXyfUyovg8q8FrO
         7lUOg0d3z2LwJ9QJeVItOtmOZb29RAZirCGx58B2xD9njU+NGrd+paFg2QOFCNAGr1PF
         ELUTGq9r4u8nIeod8t2W4StFOPJAI1dedj89GdZgxw7EbYDUj5iiML6i3C8QgSc7c4cG
         qV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785491858; x=1786096658;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmlDZ7ZG8UiYkJXMRTL4X0GdFki7ECb1G0iag5jiHHI=;
        b=q2weoILUij9a/uImoMrx2GkS+ubStlG6JVRqasONN3T00E0Un3W1seHAhhZ6nFN/Wu
         t3fSaLRyywxKdHnMEna9c1UhtNShyTVCjOvfrG8JmHp1N2T9+Dd9eMszfqeDx1ixoI0A
         VRLOhwlKSkV25NfONq1o20eZsI8yQnb3bRty9hG4juk74lSEY+IeNaLS+A31ZC4e5MIr
         Cllr8Z0kU6sYxV2sHyKow6IjUDBtYzZ9blmfrDrCrKA9W14vVSy0tWYmiOHX/ZleA3ZW
         6dTHJksI0DeAtN2Jh7TdL9XOZLzlY9gKjgvd7pCZBY87AxVwi6hYhPM7F4Ef3FuVxcbS
         t0ng==
X-Forwarded-Encrypted: i=1; AHgh+RpMYsrk9btsFy5j9dQ+S/EE0md0/8ykG18s03cYoV6JnFDyhXOm1M4wkNvdkyguIusU1DVtZzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mCgpnqlwx3/1Dn6PR0u9t/z6RYgVrixcq96L3I+0n2/AzMBg
	M5IyYHgciu3gSdHrvPtrLt0IwqI2GrAELZJDsDGK3jvn18Y+7D9fqS2ooPowALZAfkk=
X-Gm-Gg: AR+sD11xxwAw55DNAGnW2brZoGlG07lBs0bN0Ez5SGQFsg/i4MfeExrq7OOhAye3EOX
	g4AkVjTk6s1DegKfh66iVPzn/2xkRKCwtvvvYdnVNqIsKyXYKMbQQBtORdfTyrwMjYSuUwHecwq
	Ioa6nBYTr9qGlCU+E4/SW+I5lmiPxL3G0Od8ZNCPFxCSrZWTkl9DqhU3EFTZUwU29xg5xVmcQTz
	RtOiOFVqduHrZ3zbJ7iFoPOa+SsVj1tnG5ZnFK/6/4ZrYeA7kLL9AHnMJWHwnFggjxTav50MJ0O
	aFs2jcsxIXa9+aIwRYDExbwZXjKbqqKu4RCBnIXNv2HjLwvSoPCjS3cFNqCHZhl8YF3f+m5FKBG
	6j+6Lolr87WlgkkkxZoBWBeM54VJaqjENGbHZvXLmwo0BuFPkLZXHuVep3WmjQY76SdNxwaupAv
	Cs/2PRmSO4FN9aVcvPUNcNrA46T/wY4slkMwIIvvlv++O7nejMPP4mKxXGenMhca1qXkJXXghKP
	Q==
X-Received: by 2002:a05:6000:25f7:b0:47f:90a4:ff41 with SMTP id ffacd0b85a97d-47fd2b8c565mr3417874f8f.58.1785491858295;
        Fri, 31 Jul 2026 02:57:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0d7csm2784687f8f.35.2026.07.31.02.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:57:37 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:57:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 4/4] panic: allow force_cpu redirect from an NMI
Message-ID: <amxxj4wsoqn5Ncwk@pathway.suse.cz>
References: <20260726190412.10891-1-include@grrlz.net>
 <20260726190412.10891-5-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726190412.10891-5-include@grrlz.net>

On Sun 2026-07-26 19:04:12, Bradley Morgan wrote:
> nmi_panic() claims panic_cpu via panic_try_start() before calling
> panic(). When the panic later reaches panic_try_force_cpu(), the
> panic_in_progress() check sees panic_cpu set and refuses to redirect.
> The crash kernel runs on the CPU that took the NMI instead of the CPU
> requested with panic_force_cpu=:
> 
>   nmi_panic()
>     panic_try_start()              wins, panic_cpu = X
>     panic("%s", msg)
>       vpanic()
>         panic_try_force_cpu()
>           panic_in_progress()      true, panic_cpu is X
>           return false             redirect bypassed
>         panic_try_start()          already won
>         __crash_kexec()            on X, not the requested CPU
> 
> Try the redirect before claiming panic_cpu instead, as suggested by
> Petr Mladek. nmi_panic() now calls panic_try_force_cpu() first and
> claims panic_cpu only when no redirect happened. The requested CPU
> claims panic_cpu itself when it runs panic(), so panic_cpu does not
> need to be handed off.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -364,18 +364,19 @@ int __weak panic_smp_redirect_cpu(int target_cpu, void *msg)
>  
>  /**
>   * panic_try_force_cpu - Redirect panic to a specific CPU for crash kernel
> - * @fmt: panic message format string
> - * @args: arguments for format string
> + * @fmt: panic message format string, or the final message when @args is NULL
> + * @args: arguments for the format string, or NULL when @fmt is final
>   *
>   * Some platforms require panic handling to occur on a specific CPU
>   * for the crash kernel to function correctly. This function redirects
>   * panic handling to the CPU specified via the panic_force_cpu= boot parameter.
>   *
> - * Returns false if panic should proceed on current CPU.
> - * Returns true if panic was redirected.
> + * Returns true when this CPU must stop: the panic was redirected or is
> + * already running on another CPU.
> + * Returns false when panic() should proceed on this CPU.

Nit: This a good improvement. But it would better fit into the 1st
     patch which fixed the true/false return values.

>   */
>  __printf(1, 0)
> -static bool panic_try_force_cpu(const char *fmt, va_list args)
> +static bool panic_try_force_cpu(const char *fmt, va_list *args)
>  {
>  	int this_cpu = raw_smp_processor_id();
>  	int old_cpu = PANIC_CPU_INVALID;
> @@ -412,14 +413,18 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
>  		return old_cpu != this_cpu;
>  
>  	/*
> -	 * Use dynamically allocated buffer if available, otherwise
> -	 * fall back to static message for early boot panics or allocation failure.
> +	 * A NULL @args means that @fmt is already the final message, for
> +	 * example from nmi_panic(). Otherwise use the dynamically allocated
> +	 * buffer if available, or fall back to a static message for early
> +	 * boot panics or allocation failure.
>  	 */
> -	if (panic_force_buf) {
> +	if (!args) {
> +		msg = fmt;

Ah, I misunderstood the meaning of panic_try_force_cpu_fmt() in v4.
I though that it was needed to _copy_ va_list() but it was needed
to _create_ it.

It looks like a cleaner solution after all. But I think that
we could do even better, see below.

> +	} else if (panic_force_buf) {
>  		va_list ap;
>  
>  		/* Do not consume args, the caller reuses it if we fail */
> -		va_copy(ap, args);
> +		va_copy(ap, *args);
>  		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
>  		va_end(ap);
>  		msg = panic_force_buf;
> @@ -452,7 +457,7 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
>  }
>  #else
>  __printf(1, 0)
> -static inline bool panic_try_force_cpu(const char *fmt, va_list args)
> +static inline bool panic_try_force_cpu(const char *fmt, va_list *args)
>  {
>  	return false;
>  }
> @@ -512,13 +517,24 @@ bool panic_on_other_cpu(void)
>  EXPORT_SYMBOL(panic_on_other_cpu);
>  
>  /*
> - * A variant of panic() called from NMI context. We return if we've already
> - * panicked on this CPU. If another CPU already panicked, loop in
> - * nmi_panic_self_stop() which can provide architecture dependent code such
> - * as saving register state for crash dump.
> + * A variant of panic() called from NMI context. The panic is first
> + * redirected to the CPU requested via panic_force_cpu=, when configured.
> + * We return if we've already panicked on this CPU. If another CPU already
> + * panicked, loop in nmi_panic_self_stop() which can provide architecture
> + * dependent code such as saving register state for crash dump.
>   */
>  void nmi_panic(struct pt_regs *regs, const char *msg)
>  {
> +	/* Try to redirect to the requested CPU before claiming panic_cpu. */
> +	if (panic_try_force_cpu(msg, NULL)) {
> +		/*
> +		 * Mark ourselves offline so panic_other_cpus_shutdown() won't
> +		 * wait for us on architectures that check num_online_cpus().
> +		 */
> +		set_cpu_online(raw_smp_processor_id(), false);
> +		nmi_panic_self_stop(regs);
> +	}
> +
>  	if (panic_try_start())
>  		panic("%s", msg);
>  
> @@ -590,6 +606,7 @@ void vpanic(const char *fmt, va_list args)
>  	long i, i_next = 0, len;
>  	int state = 0;
>  	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
> +	va_list redirect_args;
>  
>  	if (panic_on_warn) {
>  		/*
> @@ -610,8 +627,13 @@ void vpanic(const char *fmt, va_list args)
>  	local_irq_disable();
>  	preempt_disable_notrace();
>  
> -	/* Redirect panic to target CPU if configured via panic_force_cpu=. */
> -	if (panic_try_force_cpu(fmt, args)) {
> +	/*
> +	 * Redirect panic to the target CPU if configured via panic_force_cpu=.
> +	 * Hand over a disposable copy of the arguments, the address of a
> +	 * va_list parameter cannot be taken portably.
> +	 */
> +	va_copy(redirect_args, args);

This is weird. panic_try_force_cpu() does its own copy when
it prints the string.

Also the comment says that it creates a copy because the address
of a va_list could not be taken portably. But the code below
passes the address of "redirect_args" which is "va_list" again.
So, the copy does not make any difference.

> +	if (panic_try_force_cpu(fmt, &redirect_args)) {
>  		/*
>  		 * Mark ourselves offline so panic_other_cpus_shutdown() won't wait
>  		 * for us on architectures that check num_online_cpus().

It would be better to avoid passing the pointer.

The main problem here is that nmi_panic() does not support variable
list of arguments. I see two solutions:

Solution A:

   Create a wrapper for panic_try_force_cpu() like in v4. But
   it should follow the existing naming scheme panic() vs. vpanic():

    1. Rename panic_try_force_cpu() -> vpanic_try_force_cpu()
       for the variant with va_list.

    2. Create the wrapper panic_try_force_cpu() with "..."
       variable list of parameters.


Solution B:

   Allow to pass the variable list of arguments to nmi_panic().

   Note that the original nmi_panic() accepted variable list
   of arguments. This ability was removed by the commit
   ebc41f20d77f6ad91 ("panic: change nmi_panic from macro to
   function"). But vpanic() did not exist at that time.

   I have updated this patch accordingly to see how it would look like:

diff --git a/include/linux/panic.h b/include/linux/panic.h
index f1dd417e54b2..a9128bf3c168 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -13,7 +13,8 @@ __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
 __printf(1, 0)
 void vpanic(const char *fmt, va_list args) __noreturn __cold;
-void nmi_panic(struct pt_regs *regs, const char *msg);
+__printf(2, 3)
+void nmi_panic(struct pt_regs *regs, const char *fmt, ...);
 void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
 extern void oops_exit(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index a483587fdd2f..7ce252268714 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -371,8 +371,9 @@ int __weak panic_smp_redirect_cpu(int target_cpu, void *msg)
  * for the crash kernel to function correctly. This function redirects
  * panic handling to the CPU specified via the panic_force_cpu= boot parameter.
  *
- * Returns false if panic should proceed on current CPU.
- * Returns true if panic was redirected.
+ * Returns true when this CPU must stop: the panic was redirected or is
+ * already running on another CPU.
+ * Returns false when panic() should proceed on this CPU.
  */
 __printf(1, 0)
 static bool panic_try_force_cpu(const char *fmt, va_list args)
@@ -452,7 +453,7 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 }
 #else
 __printf(1, 0)
-static inline bool panic_try_force_cpu(const char *fmt, va_list args)
+static inline bool panic_try_force_cpu(const char *fmt, va_list *args)
 {
 	return false;
 }
@@ -512,18 +513,37 @@ bool panic_on_other_cpu(void)
 EXPORT_SYMBOL(panic_on_other_cpu);
 
 /*
- * A variant of panic() called from NMI context. We return if we've already
- * panicked on this CPU. If another CPU already panicked, loop in
- * nmi_panic_self_stop() which can provide architecture dependent code such
- * as saving register state for crash dump.
+ * A variant of panic() called from NMI context. The panic is first
+ * redirected to the CPU requested via panic_force_cpu=, when configured.
+ * We return if we've already panicked on this CPU. If another CPU already
+ * panicked, loop in nmi_panic_self_stop() which can provide architecture
+ * dependent code such as saving register state for crash dump.
  */
-void nmi_panic(struct pt_regs *regs, const char *msg)
+__printf(2, 3)
+void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
 {
+	va_list args;
+
+	va_start(args, fmt);
+
+	/* Try to redirect to the requested CPU before claiming panic_cpu. */
+	if (panic_try_force_cpu(fmt, args)) {
+		/*
+		 * Mark ourselves offline so panic_other_cpus_shutdown() won't
+		 * wait for us on architectures that check num_online_cpus().
+		 */
+		set_cpu_online(raw_smp_processor_id(), false);
+		nmi_panic_self_stop(regs);
+	}
+
 	if (panic_try_start())
-		panic("%s", msg);
+		vpanic(fmt, args);
 
 	if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
+
+	va_end(args);
+
 }
 EXPORT_SYMBOL(nmi_panic);
 
I personally prefer the variant B.

Note that the above POC patch would need some changes:

  1. Move the comment changes above panic_try_force_cpu()
     into the 1st patch

  2. Add the "..." into nmi_panic() in a separate patch.

  3. The patch allowing redirection from nmi_panic() would just add
     the following into nmi_panic().

	/* Try to redirect to the requested CPU before claiming panic_cpu. */
	if (panic_try_force_cpu(fmt, args)) {
		/*
		 * Mark ourselves offline so panic_other_cpus_shutdown() won't
		 * wait for us on architectures that check num_online_cpus().
		 */
		set_cpu_online(raw_smp_processor_id(), false);
		nmi_panic_self_stop(regs);
	}

      plus it could the comment above nmi_panic().


Best Regards,
Petr
