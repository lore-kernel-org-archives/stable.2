Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929381;
	b=LEE1GsRwJFHVlpLznmQun/tKyGDioaa3yTVn+5EqKowdbVQWONZEY/iUQbdGcqDZUvzC
	 evTFldSbbhhFMhviN/HyouUF8VWNPr2dmxAUaKOg1KutHfhJkJa1WBnTt5hZfnQnZC5QF
	 4f86eNfgSbwnNIQwE8QcCBkmka/JkxqJ39BHKrkKn0O3VXd6qTW71NKKWw0PimAIrRSLe
	 5r1HakdgOwLWlvR0GN79vjNLsYxHbvnB1T35wORiCWkpCcquO8haRnEmE+GGEwaJYkuRB
	 qIptLn11Sv3lke5lPMiPAkUhUv9Oy4JSDKJ0CXyk8tjVlRGWsZHA3OwYmdwZzgOgTNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929381;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=GjkzxdDNrHpcrRXQYuGZ1ch8vMOkUN2uuaOmdGbEb5Q=;
	b=UqqVPOAkG0qGVfdhvDvbSESAOnnHe20L8SXFdIepmschr0ZyIrRZdDYEXrgqcPZ+mTBs
	 AcZ8ONJdu691kqPKBjtRT/XdCjsJeZ2BFyzXelFchRMtx80boD2C9E63eHU46qq7amBv7
	 eRGZnDJYi8N7hzT32fP5r+nr6Oc47areWlzeirn8T78ZcF80oHqlHothZoCtaItH57wCX
	 TlIr1UEevaHWqx0l2XrCoQ0AsmXjRg9UeEw/qIL28x/WCl2egZN8A2fv0aMzmNT/FTMQg
	 aXLb4kRwYDUZIl+QL9LVpuRi3L984dKbSk6B3FOtIuqV10tgM5uNyRG3KfFNSBZiEvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Shi//a8+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45E606A31B;
	Fri,  6 Nov 2026 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Shi//a8+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DEE1F008A4;
	Fri,  6 Nov 2026 01:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793929380;
	bh=GjkzxdDNrHpcrRXQYuGZ1ch8vMOkUN2uuaOmdGbEb5Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Shi//a8+jokMV7YNWTI/vK0PThm2YAxJpcpyrErcuwvEbZuh1oFhsOrdrVFN1HL91
	 1aBX6mluUAmejHcOMKu7aNIREc/+lXQa3bnM1bfuP98AHMrFk667P4WC/BOAojE2fQ
	 jKYrUhJsYTEOVaW1iKQ+5N2ok6hcguPDNCwx2CI84/FhyM9xoNMLVPw6p54ptCT36N
	 JXOCEEODbnEeEz4UploEdpA6UoGlw3W88K2WuGbNLjwsMH1xe1e7XtjCvXo8RCmnBd
	 2dbBIeP9TAXk6C2lUTwFEGavH4DsJmY8iwxPGzoo9NogSXw7E3G0JMnWqSOgdLAXC8
	 XnVqdY5VxQ/iA==
Content-Type: multipart/mixed; boundary="===============0551742847628527584=="
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cf7d9bcb8b837cf8cae8db37cb9a0f53b977e7c59df6de47e8f416222d5f7ed8@mail.kernel.org>
In-Reply-To: <20261106010535.2137162-3-andrey.grodzovsky@crowdstrike.com>
References: <20261106010535.2137162-3-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v2 2/2] kprobes: mark ftrace-based kprobe ops permanent
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,rostedt@goodmis.org
Cc: ast@kernel.org,daniel@iogearbox.net,song@kernel.org,jolsa@kernel.org,mhiramat@kernel.org,stable@vger.kernel.org,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 01:43:00 +0000 (UTC)

--===============0551742847628527584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kprobes: mark ftrace-based kprobe ops permanent

TL;DR: Commit message only: the ftrace_enabled=0 problem seems unreachable in
this tree, since the sysctl no longer clears it, so the patch has no effect
here; changelog should say it targets only older stable kernels.

>     kprobes: mark ftrace-based kprobe ops permanent
>
>     kernel.ftrace_enabled=0 silently disables ftrace-based
>     kprobes/kretprobes: arming succeeds, the probe stops firing, and
>     re-enabling restores it. Unlike trampolines, they never had this
>     protection.
>     kprobe_ftrace_ops and kprobe_ipmodify_ops are used only by
>     ftrace-based kprobes, so FTRACE_OPS_FL_PERMANENT, as livepatch uses,
>     is safe here.
>     kprobe.multi, kretprobe.multi and kprobe.session (fprobe-based) are
>     not covered: their return path shares the function-graph subops
>     manager with unrelated tracers.
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
>     Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     Acked-by: Steven Rostedt <rostedt@goodmis.org>

Is the problem described in the first paragraph still reachable in this
tree?

Commit b0c857049153 ("ftrace: deprecate disabling via ftrace_enabled
sysctl") is an ancestor of this commit.  ftrace_enable_sysctl() now refuses
to clear the flag:

    } else {
        /*
         * Disabling ftrace at runtime via this knob is deprecated.
         */
        ftrace_enabled = true;
        pr_warn_once("The ftrace_enabled file is deprecated and no longer disables ftrace\n");
        return -EOPNOTSUPP;
    }

That commit also removed is_permanent_ops_registered().  After it,
ftrace_enabled is only 0 transiently: inside the sysctl handler under
ftrace_lock (which every ftrace_startup() caller also holds), after
ftrace_kill() (where ftrace_disabled already makes ftrace_startup() return
-ENODEV), and in the kexec point-of-no-return paths.

So the statement "kernel.ftrace_enabled=0 silently disables ftrace-based
kprobes/kretprobes" does not hold here, and this patch has no observable
effect in this tree.

The v2 cover letter says the change is meant for stable kernels where the
sysctl can still clear ftrace_enabled.  The commit message does not say
this, so a reader of mainline history, or the stable team picking it up
without a Fixes: tag, learns neither that mainline is unaffected nor which
trees need it.

Could the changelog say this is only needed for kernels without
b0c857049153?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42143371906
--===============0551742847628527584==--
