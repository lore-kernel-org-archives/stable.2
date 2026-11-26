Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661119;
	b=2HiblJxNpUGZDrl2SaU6T8CfkJHVzYFb1ejTdG/XMSFlz2HltIWBEH7hVIldLx9z4uOk
	 oGXA696WW8ZMdwpgtsftn64Qsjk2XWLZhyPcEWfd7beDxHBPoJ8yiyC6SF8PdNsqmLj02
	 KNNYhUK3z5y9ETm54KH5DGaV8EtI2go9Y8J+ts00ES2FvOpxavoGQ2afBlg0RK13bchqX
	 z4ckYp5eI+n31FN6epVvWYA4+WHbnpzlHkqTwUW/ClURsA5NwWssyHCSbV8MtqolNx2y7
	 HQBgPC0tnDqQQiC6iMVkjBQ+jShwTVNRNGBj2f4JikdcX6HIEiQSD7Vu9yJ3ABWp9oA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=D0zUcqm0LArVGjUdPeqXQxQsBa36gzl+dj/r8CT2+pI=;
	b=ln7XmIydLVMzFF6CWP89uB/SSwaKBdrKFoD3j99gDCSQt8grX7tBtVlo1g3slGlFBe1Q
	 lQYJaWu4xl6uGN9lNxjNVeZ/CiykMKKqPs5U7WSNdRe4TGaq6T2f+7EUpwBRZ29rI6pM3
	 j9aj+ZCZD94JO+1ymo24U4UZHxY38VS17TQ50Kd29FuaWg9kjXvwKhzNiiusI0JRFGSCk
	 5fbDbX66tuUqwZyFyoRaEVOAQv++CX/dexggcxVB+gXPrzM3p3rbOTX71xbcH2jny4iDk
	 K5RX7RrblfZGY/eMHG9m3FsYls6CgXjl8OrEDoJHkmkEomYMAss+ncsaTs+JxOXAwHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=T0nJ4ZjR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26FE606A686
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F26FE606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=T0nJ4ZjR
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67be1e468a8so6279213d50.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661118; cv=none;
        d=google.com; s=arc-20260327;
        b=pXHtIuvPixGWYWlVXjreM33aFv+3Ot67i1A2FeHVCoJEks9DR4T347r+84Uh552UE6
         8/J3eu1qy1zNpfpmnLNEXo/hRMj9Gz0jpyRW/04MHj2v+yP34cI5Wd29tAVleWT7kGK7
         rCX8rTd5lY5ynFBMTBtVCgT+JFJEPT/Rzka6zMQe270bWx6Z3mduUffZsSKPSGfLEcH0
         2OE7XWmWCV0ERCaJUAd0wt06HoV5qcgnyRffoKT26o6lfaL5e12hjaFt5xxG9rTTvJed
         S3PirjH5ZVwWGQGcqVeN8E8TLCv23U4rycvon9Rv6vrY4DPPhM+QPJrP4TRPwoI51jjg
         IBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=D0zUcqm0LArVGjUdPeqXQxQsBa36gzl+dj/r8CT2+pI=;
        fh=AIrBuAclZrkW2rl1AKI6uFjmcQF/pUVlMaxQw55Yq2o=;
        b=T/wXbmQh5jlrcTR714OQA3p4Uy4fNaGucpTZj7G3FLx5TcOupS+oZA5G+WdAYeOPhd
         Avm8z+t2ht6bZEKdKAW8Tg/dO1eX5rq+XfEZWO3xXgulRrOG12TdIPpNVmSWHwpks/FA
         7hyEcY0QWqwBWCxU5mxO0gZ2C93yhuAcbcYhY5HOz+n5ZpdBbcqPe6qEZt8Dt47F2tEE
         HKfmciqkyNKR+GesScvwUC6qiB7GLM225jNRvPqakrVKQB52hp2VmKDKELhNpm6z9HIE
         z+pmv0quDr05c8FauB/xM2Srvj8uzAP2Vrit8AuuiovtD/hdm/dzB1C5VOlpQ/VgIU/r
         N8Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661118; x=1796265918; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D0zUcqm0LArVGjUdPeqXQxQsBa36gzl+dj/r8CT2+pI=;
        b=T0nJ4ZjRXmyGh2nx7gflbplcqd2MWlUYLwSYxN6EXWl5fspT/s6i3ifGaLew3nt6rH
         8nNqfgZXX+DtxMsNqtlo8ypdAF9vgYp9QYAffWIbDIyVXUBm+jpMHnJrxOvCIHflNat1
         n4qtxmZXMVicuUHyUSV9oEfIRVOQ/9UnFcjO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661118; x=1796265918;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D0zUcqm0LArVGjUdPeqXQxQsBa36gzl+dj/r8CT2+pI=;
        b=yRaE2DlYg/hJSPuhP/T17UraKbcxQb9WOsnoW8unPiR5ha7LA7s3aYigtNwOMTzn7z
         +vlJOnvbSmxDix896ORqE+qtHqHkDipsH8FWVgofPyHCLeW+hxnSC0s8AUrmWTIf+PO1
         uwQyj0ZuY65p5B2Dy+w81Tdc3gItk0dtM2R+QVL/k5ZEH2FVEeGar3RUN5q42REskesM
         uH3a7zqnwhZ0rUvZyzhmF0NL1l5OkmzPAy/mN4p5fsr+H5sL/NuSHiNYKQYoZqNe1V0N
         /iNmz+KVIw/98su5LXCXzPzzDhe/SFN6h/e3pGY6eqd0sGa7brYAXCLZQxET6BgReIer
         6uWQ==
X-Gm-Message-State: APuU4Z+4H2iiw6jjiGnqPh1LhLLBf+i6vGJNvTqhfEmS/e2STQTl/G8B
	rh425U0F3/MKWo8H52xNrvY5AUagrsT28MXWfNT7M4I4nMcIGwu5TBTMbqezVoD/PAtnpBrGv7N
	jS3lWQI/H+s/eHt7SdhVnh+gY24OyMKfy5OtIRponsHntU7iBMdmVEqc=
X-Gm-Gg: AZFdTZcFgwvLzKPpoyVz7m9+ARpMsUJvCfhttulBv8DrGBueHUAaUSS7ssrBVHSigDk
	9Rlfz8vosCxINk6bIbpcm0TUqoitn0wIAIz583u+vkEmM4Q7Nwz9FV03tqgB7GEUgso0owq0wsQ
	UgU2usAe9Wc+zYUXckczY2oXgZ5gZ6TwJJKhQxhpMztURx7VkLR3cuV6g/W7l+XOIbfLXee+Iao
	gh9KaRd2pguek6waxf5/wvLcabKCjjZEa5ckbe4/wg4Q4/D8iTpdKs2mqVJl7CvciTDFxsiS6ny
	AKG9IUeH1r8M3INiUrfqG0Gw71j7MhvWCPQT9JfDWYrwplkCzonqMz1CpoujacyojpV4snjMOA5
	Xj+W08O+yYw2btxBuI10QY2nzsdCG7OzJ4YxNlZavZzLZwTQGkkmUXlBoMl+uJ32udLuVksZ1Jz
	i6xaQnc4PYP6QqPS0OVC3Y9wn955HmXlgQX5XInmFNbefOIDU/4anDq2FGZR6FcyWS+dB+VJAOd
	0ll1bq6HNE69JPUcbFeC6PWYA+T65XOBLhmS27NCbOgvcxUsCtVdiIojw==
X-Received: by 2002:a05:690e:190a:b0:67d:ebad:8c79 with SMTP id
 956f58d0204a3-67df43cd1damr9240466d50.26.1795661117914; Wed, 25 Nov 2026
 18:45:17 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:16 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:16 -0600
X-Gm-Features: Aa3M54o_FkKMyMPQ76iVqaRJQDs_ogTl2m96GprmqGGhavz4dlD9Q5rYhhV_j4I
Message-ID: <CAFaZ9ep64RtaNeyK42OVLSCwD_g-E5RqjP4qbK0=45unkG=Zag@mail.gmail.com>
Subject: [PATCH 5.10.y 2/2] pid_namespace: prevent TIF_NOTIFY_SIGNAL from
 interrupting the reaper
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Christian Brauner <brauner@kernel.org>

commit 5c0985dd3c32fc2bbd0e8beaf13cf52cd97376a2 upstream.

Since commit 7fea700e04bd ("zap_pid_ns_processes: clear
TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING") zap_pid_ns_processes()
clears TIF_NOTIFY_SIGNAL before every kernel_wait4() call. Otherwise
kernel_wait4() doesn't sleep and returns -ERESTARTSYS if
signal_pending() is true and the reaper busy-waits.

But clearing TIF_NOTIFY_SIGNAL doesn't fix it. It can get raised again.
For example, klp_send_signals() sets it raw against any task that hasn't
transitioned yet. And it keeps sending it until the livepatch finishes.

The sleep loop waiting for pid_allocated to drop has the same problem
and it doesn't even clear anything. So a schedule() in
TASK_INTERRUPTIBLE returns immediately.

Use a no_notify_signal guard. signal_pending() will ignore
TIF_NOTIFY_SIGNAL and the pid namespace reaper sleeps until a child
exits or free_pid() wakes it.

Link: https://patch.msgid.link/20260824-work-tif_notify_signal-v2-5-6609e42b3157@kernel.org
Fixes: 7fea700e04bd ("zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL
along with TIF_SIGPENDING")
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ adapted to 5.10: explicit save/restore instead of guard() to avoid a
declaration-after-statement warning ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index e032b1ce7964..2c525208b6ad 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -174,6 +174,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 {
 	int nr;
 	int rc;
+	unsigned int no_notify_flags;
 	struct task_struct *task, *me = current;
 	int init_pids = thread_group_leader(me) ? 1 : 2;
 	struct pid *pid;
@@ -219,9 +220,10 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * kernel_wait4() will also block until our children traced from the
 	 * parent namespace are detached and become EXIT_DEAD.
 	 */
+	/* Task work must not busy-loop the reaper, see signal_pending(). */
+	no_notify_flags = no_notify_signal_save();
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
-		clear_thread_flag(TIF_NOTIFY_SIGNAL);
 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);

@@ -277,6 +279,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 		current->signal->group_exit_code = pid_ns->reboot;

 	acct_exit_ns(pid_ns);
+	no_notify_signal_restore(no_notify_flags);
 	return;
 }

-- 
2.43.0
