Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33944A409
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962440; cv=none; b=CgLcbuhBrmiGs0tkAX3eYA3fkbMa04nLPb98Yx9Tu1nr105cOyqqIOZjcd9EE7xWJLJDGWXFvEjmQp+r80yaHXWggQszR8qW245Sm/F+3SRJ0MoEz+Oe5dRXn/PLJuC1S9whsO25VsSVLHfSBoNuzei/PKjSgYRRHMuy25PMzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962440; c=relaxed/simple;
	bh=g6hFtLVrE/UjzzVSQQOzbX4cj/oiFJZYtfo2+FNowfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r97hv5iDKXaEgL6dMjdu0QtjM9xMyQz6UCXo63ygtDRSF53MQwNe5jiJA0Id8FMSgFS1vO9vNnNweDuVGO3yFWtcewtie/s7a0lmoJDH49xz5VWYPZ6hO3PjAcqFtE5pDnPXb3F1XlABrqXp/zesmrG163lSeA/XwtnAL/xOfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLGofGV2; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLGofGV2"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-353804b591eso6669609eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 00:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962438; x=1792567238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r9mA2qoZtggQ/j/8me9B77LmzqnDxoGP/VtqAIm/t1U=;
        b=eLGofGV22lAh7Oeak/ixXc9UNnueFHsqx74u4y3/lNauJF/lklVShsVb7Wnv8rrJOf
         NTJoD6iSFpflVhPyMXJW7ugQZiSyFbUvtEJQGVCT38hpyVnxJwFYNDd29Ih+CgFU1j/S
         mKIyQK2cNiESYEl+DjsBWazAHQVGgrjfS9e5L1qtfvhgA4bqa4uGTBwcPxZbPEJ90GL0
         FPyhOigURW0TqsIhtJ52gzsjXL7gisdb4CCGksU4lfHYT82Pt7t5vf6cuevHA8mnUFb2
         uioSroVQogYfzno6hR+CN0YbKBENPtRvNu9IJ4l1li7vgk6ICAQry/E/lJ8APFQLU1v0
         ICRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962438; x=1792567238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9mA2qoZtggQ/j/8me9B77LmzqnDxoGP/VtqAIm/t1U=;
        b=X/RrqcOUsrtGOYQvPfWZ0UfDbYOtSL990X+nboQFk6q2VzT7KjcQpTfN1hbM+OFhcE
         8xDnO+Kzrr//A/XUGafgWvBbd6FBdW9mZ9xRoJC0jso1FJDrmz8UMmij6nh+8nbFTsC8
         FujX304f81xGnGxy7OXGnKWDS0ZCPBr5DMp0vOVqMw/rEU6yH/ZlhhoRrG34JgqAZ84h
         fP1LC1uACYS+Z2eVqxq4n40c2IkDIfdkkPEnFQVgVyOaeOC5oPD53sbW7WKXVii5QR67
         yoQ9zft6vGLN/gbLrUcy2D7MDmAuvEhkRuhRabB3r8XQmaWnNF3lSJQIBJPXPZX6i/o/
         l9Lw==
X-Forwarded-Encrypted: i=1; AKwUvBwO9eTlyb29EqoefDBbDA/BiqbNxEeDi7wHt18mS+lCe1bFb00I9NFZFI75f3RkFF6RHs992TE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZtTBZX6hO9XtN9qlgpjxEezgBNRXTWax9iAXT4iVfgiihbFDg
	4Zj77mkMsQR1wNdHoW5T5fFHzAX5Rybd45r14YX/hdmlSFNhCTBaiQ3S
X-Gm-Gg: AYBFou2LKOmj1TxmhsqP158waRML/2KY01nrvgRCsb2X5D6sGNeOHOEBGKR9c/2dYoE
	kLsFmX/q10xmmi8bFW2K3kLV7alDb2zqeT3qS/EwxgPxl2TO3jC1vmavD+8ILVEdAUd5+sd7LZR
	JtMSY820kR6KsZigtSW6IEQeQ8E8yB3kP55W1O78D//wJxlyaXoO8CeTvghWfHYVCIfHaO1OtR8
	sRieKf4nP/waTSSc0mCT6UBnewjli3eOyeFSKblw2yW92Nfg/34lVBumoED0yYvvRNNe3fie/bB
	nQBYfUkJI1P0vw5HrJ12GBj/TQSFMo5UuFgtlmpdQNSTv3nTV7mOcJRREQTcp2e3kb0eVGoX+ge
	Xn22dIFolF6iscMSKtsSAUdBdTe9sGrxZFVprSLhSujKpHL6BvgG+zLLGolOpC4BjQ9IDXAB2A5
	HWMJdBQQ/JeSCdcFTj77NWSRTJqjBVYeViNN+D1IbwNaXxHALcIp59bXYnyh6e5R0n+62HtCZ3n
	FvlLIsMrhzzy8TCJv2hY7SHxWDnx7+mMZOcP0edOrjZjgWvgGvj9mWsvg==
X-Received: by 2002:a05:701b:280a:b0:14d:c7ae:85df with SMTP id a92af1059eb24-16a5adfc08emr22045113c88.12.1791962437979;
        Wed, 14 Oct 2026 00:20:37 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a32eb7ebsm52219852c88.12.2026.10.14.00.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:20:33 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Subject: [PATCH] tracing/osnoise: Don't start a kthread in timerlat user-space mode
Date: Wed, 14 Oct 2026 15:20:19 +0800
Message-ID: <20261014072019.276178-1-chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In timerlat user-space mode (NO_OSNOISE_WORKLOAD) the workload is a user
task reading timerlat_fd, so there is no per-CPU kernel thread to run.
start_kthread() only checks for that in the osnoise branch:

	if (timerlat_enabled()) {
		snprintf(comm, 24, "timerlat/%d", cpu);
		main = timerlat_main;
	} else {
		/* if no workload, just return */
		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
			...
			return 0;
		}
		...
	}

start_per_cpu_kthreads() guards against this mode itself, but
osnoise_hotplug_workfn() calls start_kthread() directly. Bringing a CPU
online in user-space mode therefore starts a timerlat/N thread and sets
its bit in kthread_cpumask while OSN_WORKLOAD is clear.

stop_kthread() uses that bit to decide what the recorded task is:

	if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
	    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
		kthread_stop(kthread);
	} else if (!WARN_ON(test_bit(OSN_WORKLOAD, &osnoise_options))) {
		kill_pid(kthread->thread_pid, SIGKILL, 1);
		put_task_struct(kthread);
	}

The bit is set but OSN_WORKLOAD is not, so the first WARN_ON() fires and
the && short-circuits into the user-task branch. A running kernel thread
is SIGKILLed and its task_struct is put without ever being stopped, so it
keeps executing until it is freed underneath itself.

Any write to osnoise/options reaches this: osnoise_options_write() stops
the per-CPU threads before applying the new value, so stop_kthread()
still sees OSN_WORKLOAD clear. Re-writing the value that is already set
triggers it just as well as changing it.

  echo NO_OSNOISE_WORKLOAD > osnoise/options
  echo timerlat > current_tracer
  echo 0 > /sys/devices/system/cpu/cpu1/online
  echo 1 > /sys/devices/system/cpu/cpu1/online
  echo NO_OSNOISE_WORKLOAD > osnoise/options

The offline/online pair is required, otherwise no kthread is recorded and
no bit is set. Running this on 7.3-rc7 with KASAN gives a WARNING in
stop_kthread() followed by a slab-use-after-free in update_se(); leaving
out the hotplug step produces neither.

Keep the check in start_kthread(), where the related hotplug bug was
fixed in 0bb0a5c12ecf, instead of adding another copy to the callback.

Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")
Cc: stable@vger.kernel.org
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 kernel/trace/trace_osnoise.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 0e1265acd..9715462ee 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2038,6 +2038,14 @@ static int start_kthread(unsigned int cpu)
 		return 0;
 
 	if (timerlat_enabled()) {
+		/*
+		 * In timerlat user-space mode the workload is the user task
+		 * reading timerlat_fd, so there is no kernel thread to start.
+		 * One started here would set its kthread_cpumask bit, which
+		 * stop_kthread() reads as "osnoise workload kthread".
+		 */
+		if (!test_bit(OSN_WORKLOAD, &osnoise_options))
+			return 0;
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
 	} else {
-- 
2.43.0

