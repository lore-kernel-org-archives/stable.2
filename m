Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503253002DD;
	Wed, 24 Jun 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316470; cv=none; b=JvctE/nztQJBglGw/ZXF3ULD5sf2m4A/DjV5LLVRJ1Dc5x1l5YtCpd2ugSDlr/7tgaqQhHnbFoJWUG1dZTqiCWIk52N2yvmPuK51tL7KGf+q7iOdmiquQNs1rSuQn9c4kCheairuaJnbe2PNjL/Gtk2Z192EU827iOML5PffYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316470; c=relaxed/simple;
	bh=xh7ViXnNgYwHC7qNeGeR9ecHxFs4hpAP5kSmM5JL+Vw=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Bp4UuKV7NGxkBHLfXcW5yTorjaznV0KI6bPYhEgVn+kfxfezdZJiOz6uCN7qRf2xUudek9RWvcFtLw7FOa4zHquUZ09YA3thGQbT+Q3+jmn5ghyj0G5NY6/11xBGH4cvRCXFDNcCGDdl77bTQ5piXMkUz/VaUgTZoMRVkUtFJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b=GGxBrXow; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b="GGxBrXow"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=xmission.com;
	 s=xmission; h=Subject:Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xh7ViXnNgYwHC7qNeGeR9ecHxFs4hpAP5kSmM5JL+Vw=; b=GGxBrXowz7rXY1LiITAIg4lPTC
	YdXZosxxfln9aFYpwvraz7YZcUidW/vs744LrhfzZhTw6OyNOBuz7a5qSGv3SCtcAeq/As3YKsTb+
	00cenxSa3qtJxxhLi9EkuC96wjmgOlWVuVKkvgiH/gKKTYkSycrdcDejizLahl74m6UQ=;
Received: from in02.mta.xmission.com ([166.70.13.52]:42798)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wcPYC-001JQQ-Uw; Wed, 24 Jun 2026 09:30:04 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:59284 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wcPYC-00GnQt-3S; Wed, 24 Jun 2026 09:30:04 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Bradley Morgan <include@grrlz.net>,  Christian Brauner
 <brauner@kernel.org>,  Steven Rostedt <rostedt@goodmis.org>,  Masami
 Hiramatsu <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Peter Zijlstra <peterz@infradead.org>,
  Marco Elver <elver@google.com>,  Aleksandr Nogikh <nogikh@google.com>,
  Thomas Gleixner <tglx@kernel.org>,  Adrian Huang
 <adrianhuang0701@gmail.com>,  Kexin Sun <kexinsun@smail.nju.edu.cn>,
  linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  stable@vger.kernel.org
In-Reply-To: <ajpv5bW01_xtlZ6R@redhat.com> (Oleg Nesterov's message of "Tue,
	23 Jun 2026 13:37:09 +0200")
References: <20260622164029.11474-1-include@grrlz.net>
	<86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
	<ajpv5bW01_xtlZ6R@redhat.com>
Date: Wed, 24 Jun 2026 10:29:59 -0500
Message-ID: <87bjd0c5xk.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1wcPYC-00GnQt-3S;;;mid=<87bjd0c5xk.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19lMRvGX1KD9Qluxwju7Bauekh91GYrANI=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4493]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 401 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 10 (2.5%), b_tie_ro: 9 (2.2%), parse: 1.02 (0.3%),
	 extract_message_metadata: 3.3 (0.8%), get_uri_detail_list: 1.20
	(0.3%), tests_pri_-2000: 3.4 (0.8%), tests_pri_-1000: 3.0 (0.8%),
	tests_pri_-950: 1.17 (0.3%), tests_pri_-900: 0.97 (0.2%),
	tests_pri_-90: 111 (27.7%), check_bayes: 110 (27.4%), b_tokenize: 7
	(1.7%), b_tok_get_all: 7 (1.7%), b_comp_prob: 2.1 (0.5%),
	b_tok_touch_all: 91 (22.8%), b_finish: 0.76 (0.2%), tests_pri_0: 246
	(61.3%), check_dkim_signature: 0.54 (0.1%), check_dkim_adsp: 2.6
	(0.7%), poll_dns_idle: 0.82 (0.2%), tests_pri_10: 1.94 (0.5%),
	tests_pri_500: 11 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/2] signal: avoid shared siginfo namespace rewrites
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, kexinsun@smail.nju.edu.cn, adrianhuang0701@gmail.com, tglx@kernel.org, nogikh@google.com, elver@google.com, peterz@infradead.org, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, brauner@kernel.org, include@grrlz.net, oleg@redhat.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Oleg Nesterov <oleg@redhat.com> writes:

> Add Eric.
>
> OK, I agree, it seems we need a simple fix.
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
> -------------------------------------------------------------------------
> But let me add some "offtopic" notes... Why do we actually need this fix?
>
> kill_something_info(). But at first glance sys_kill/kill_something_info
> can simply use SEND_SIG_NOINFO? If yes, this makes sense anyway, I will
> re-check...
>
> do_pidfd_send_signal(PIDFD_SIGNAL_PROCESS_GROUP) allows to call
> kill_pgrp_info() if si_code < 0... Not that I think this would be better,
> but we could move this "rewrite" logic into __kill_pgrp_info()...
>
> Anything else needs this change? Most probably yes, but after the quick
> grep I don't see other group senders with !is_si_special(info).
>
> Eric, what do you think?

So I think tracing the basic kill syscall is interesting.

It uses an explicit siginfo.  It does that so it can choose
between setting si_code to SI_TKILL and SI_USER.

If the signal number is -1 it sends to every process in the
system (or at least the pid namespace).

That will require translation.

So either we need to add another special siginfo value to handle
SI_TKILL, or we need to fix this the way that was suggested.

I suspect just fixing send_signal_locked looks the easiest,
especially if you make the siginfo parameter const.

It would likely help to have a self test that detects the problem before
this is fixed and passes afterwards so we have some chance of detecting
if someone makes a similar mistake in the future.

Eric


