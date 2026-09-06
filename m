Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2025A655;
	Sun,  6 Sep 2026 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788734397; cv=none; b=FINYifN1we5qBMpdHFaKBs4M3ecakqSIkQlF7paex/mSmUuD3p/OY2U9ShXMwJ+Gb3bJX9e3meby6um2BSp564D8n1ABMS/6nTa7BMs90ZQx9RDOMKWZrF+dFuln7chuUaE6F+VvXOpnAYyZx6wRw8GRYmHaayAvVFPzkw0gKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788734397; c=relaxed/simple;
	bh=xZAX/1sQQgxlqyQ4K2MRmOwSG2+ejTZ/10GaF0N3Gio=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=JQYeYawVFXbHBkCtGn3ItGAIYslRHEv1Hjgg4cAcm+BaVxwJAy+jW8O2ygR3gzarB3q+vGhA4QOrM1CQ32+PCo/DgvINFxydyefz3y49qoA9ONcocS2jPTLcBGKOcqwALj86JWrQRv7G7l3Jv7IVVVv8/OrFwvISaK5pnxzg3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b=h9eLrw+g; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b="h9eLrw+g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=xmission.com;
	 s=xmission; h=Subject:Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xZAX/1sQQgxlqyQ4K2MRmOwSG2+ejTZ/10GaF0N3Gio=; b=h9eLrw+g+uQ2LjAQXuujd7FEa0
	s+cugeAsSbptAMRyAQf3Sw7Q6Gq0oaRvlD03ATJov1pAydRnFBT6uTzvpLrEnyJQH/VRyG5CCd1zi
	GPk/QxnS8RPJfMRD2r9k9Hvbsb837LynhJujefsHXT8KVgokqL8LmsyLWfP0OQriN8I0=;
Received: from in02.mta.xmission.com ([166.70.13.52]:37134)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1x3LWe-0084EO-Cr; Sun, 06 Sep 2026 16:39:48 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:60686 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1x3LWd-007WZm-Mn; Sun, 06 Sep 2026 16:39:48 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,  "Cc: Hyunwoo Kim"
 <imv4bel@gmail.com>,  Oleg Nesterov <oleg@redhat.com>,  Frederic
 Weisbecker <frederic@kernel.org>,  Christian Brauner <brauner@kernel.org>,
  Peter Zijlstra <peterz@infradead.org>,  John Stultz <jstultz@google.com>,
  Ingo Molnar <mingo@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  stable@vger.kernel.org
In-Reply-To: <20260905185839.667208455@kernel.org> (Thomas Gleixner's message
	of "Sat, 05 Sep 2026 20:59:01 +0200")
References: <20260905181551.738186850@kernel.org>
	<20260905185839.667208455@kernel.org>
Date: Sun, 06 Sep 2026 17:39:41 -0500
Message-ID: <8733vmatsi.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1x3LWd-007WZm-Mn;;;mid=<8733vmatsi.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;sPfnum=0;;;sPf=pass
X-XM-AID: U2FsdGVkX1/U2RtLE0h6yvQwwGvd0TsBg0iLh9lHKi4=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4989]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 259 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (4.2%), b_tie_ro: 9 (3.7%), parse: 0.79 (0.3%),
	 extract_message_metadata: 2.4 (0.9%), get_uri_detail_list: 0.66
	(0.3%), tests_pri_-2000: 2.6 (1.0%), tests_pri_-1000: 2.4 (0.9%),
	tests_pri_-950: 0.98 (0.4%), tests_pri_-900: 0.75 (0.3%),
	tests_pri_-90: 65 (25.2%), check_bayes: 64 (24.7%), b_tokenize: 4.9
	(1.9%), b_tok_get_all: 6 (2.2%), b_comp_prob: 1.46 (0.6%),
	b_tok_touch_all: 48 (18.5%), b_finish: 1.10 (0.4%), tests_pri_0: 157
	(60.7%), check_dkim_signature: 0.42 (0.2%), check_dkim_adsp: 2.1
	(0.8%), poll_dns_idle: 0.46 (0.2%), tests_pri_10: 1.71 (0.7%),
	tests_pri_500: 8 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, viro@zeniv.linux.org.uk, mingo@kernel.org, jstultz@google.com, peterz@infradead.org, brauner@kernel.org, frederic@kernel.org, oleg@redhat.com, imv4bel@gmail.com, linux-kernel@vger.kernel.org, tglx@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Thomas Gleixner <tglx@kernel.org> writes:

> @@ -1019,6 +1029,21 @@ static inline bool legacy_queue(struct s
>  	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
>  }
>  
> +/*
> + * When PF_EXITING is set the task is on the way out and has t::pending
> + * flushed already. Prevent queueing of PIDTYPE_PID signals as they would
> + * be leaked.
> + */
> +static inline bool task_can_queue_signal(struct task_struct *t, enum pid_type type)
> +{
> +	lockdep_assert_held(&t->sighand->siglock);
> +
> +	if (!(t->flags & PF_EXITING))
> +		return true;
> +

I don't know if we care but I just noticed that this disallows
using tkill(..., SIGKILL) or tgkill(..., SIGKILL) to stop coredumps.

> +	return type != PIDTYPE_PID;
> +}
> +
>  static int __send_signal_locked(int sig, struct kernel_siginfo *info,
>  				struct task_struct *t, enum pid_type type, bool force)
>  {

Eric
