Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793409551;
	b=1MQYkBSWkwbzE/SZUOqA9a6uXsh40SIA0Tkdu0ETg1kI/kd5Vrh/99dB2awmjg8kYOgf
	 67y0uhQMdt0oknbIitQS5eNpedoSKvD6QvWzkOvBaIvvI2PiE8Hw7cm9y9sciTRgH7t8i
	 cCDpTc1lQIDvvL2cOIP1upM8rlYvb4bE3BUKqAOxsfSklYaCGYzGj4doD2gA9j62Pn1bz
	 y+HWp/x1wl/dpE5lwJqRnHGfKGxMe3T4b3LplEPFdHiavkyBRAzFBTKa5otAndOUjtN1M
	 GOtjS/XhvAoDTLv/BvqUGAH9ZZGuAFZxWpdZJapOEbMt0zAHbS5NrtpFQaX9qwji8oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793409551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DwpbmDZqZ6hn0LkssUbPizfgstUc6VwFL94186W+5Q8=;
	b=OZAV7kyvSOuWqM2KCzdssChD//bJB6/yBR+nOGDCHVxl058G7xQUEGCUXrinJ2HuGmyT
	 WFAaDQDBDNdcJMDXC4mYuwPaJ2lLFfYtzFI/Z/srQAwTVKSfV9ZLFot3sto6mLH5RrfKy
	 HaOS6SpX6cIQgj4z8vlXCEbX2kcObnt3VlODdxmO4JOtXKr6Gcv9LxAsNWUTJ11vUHGVv
	 a1jV17cwRwymX3svg7MVQYB8t0j+cMa8kx8Lg9foRyx+SzPwAF1CG4fxgpaT8fRX90Nj+
	 zQ+5yDEE5qIuQ+rHhPg7D0TmJAp6+4YNcB7dXIW6hqf8U2QR6WN8DKMX45sfEVwPwPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQgVHbPo;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B88606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 01:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1B88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQgVHbPo
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ea138a3497so8240445ad.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793409550; x=1794014350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DwpbmDZqZ6hn0LkssUbPizfgstUc6VwFL94186W+5Q8=;
        b=AQgVHbPo4S1WSBqsr0nB2KFdasPzUjaXOZKZlBGxxvmQoADfq72wmgmhW0dme2jcUN
         rxElviANBuiQPtyceq4iEFpn/WEvjYVD3BTRM/0+Z0TtvzU+cXoZDxGDnrWgb3BfWb64
         ZL2lYMGMpGOlM4QtsZjJCLm9asw291Pd7XVNKE6wHwzUQfzLvWxeg7j34+MBPKwJnJ+d
         +JHqZ85EW2QoLUHSyISu8OeaI/aupkj75S9/lp+19M7P97WXMfp8cbB0NFd62EJ3YXXf
         xPOiKQyDBQoR4CbfEbAUuuuCHIQ+DG+CjuAA5M6YCkgF4GQ8q7zKThr9LYu/dpDxAU2R
         JsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793409550; x=1794014350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DwpbmDZqZ6hn0LkssUbPizfgstUc6VwFL94186W+5Q8=;
        b=XvNDW2Olj+9YDcDg5dyajiIDBBbjU4LuJUaXhRAUfya993D/PxroRdknWaS0EgNOl5
         7zP02d4VXSgndovmNiHgXRw9Cg9dDAxPuAdjv4YHqBLCAsxfktNMkZxI2HcchCWDx1nG
         jxdSn0Rx7fDDeaoj5tWWDAXgV+5eSEWYUTpeV+T+qmMBX/DRfhmWQbKHVJOvKF9UdDjh
         D1M6F5Tr76do9fw553Y4robHBHOmkyJumiL+T4ZclUAJqxe+GTtRIihub1Q7iNdYYZbW
         a5hG8xZaZItlNf87QooFTNh2ob/iaoVm5tjR1ihcWctnwMfScw5On+enTkDUi7b6Xlr1
         YZAw==
X-Forwarded-Encrypted: i=1; AKwUvBzW9wVHLLzcknsWx7nO/ZfqVxWnat994vJTCBPdggLghtqbwCoWRxgQ6STMbt2UeXFyudP2+vM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTTaJEZxU+iStlC2lf1BxN0XH6jsAlfeghQWQccBLTIz87C2LC
	emrqN7YP/cUJY292TtJjZjS6kfTqttNOSQ1PEkrV/t/GxRa6EYNKWRMG
X-Gm-Gg: AYBFou3biUOJGOjMc1RliiRHZgXgcZYxlymq0XncKQU3+7gF+Cf3x6MHANgQxM8fqks
	GDUdwWza/3e7L0Sd8ocXcStd9RVaEt+Zvzci4hWIVHcV4F6eL3KUGXLWaJzxbv+khpEKWgh1rpy
	BFi3d8YyM3q03yuyBE/9Wry7vLpJ0xx0G618TaJeU/5SKbKngd04ZDmHDRvvW9HoZbqOicUGJne
	M+ME8a4IKeAlykqIiDQaU0DkMUnaIRB1q4VTGR8PVcFncwP5FHa//m+iaJmXbxtCNWtWwA6ZWTD
	MFz1EEpGR0E46528Yq+ufKeeY3xmKYhiAgpNIYd1A8WTMfCdaTtnUGiE817+nk3JvG3jaykmGlZ
	dpNByzOJM0i0A32NUnjxI/ITV+RakS8oZ2D0agkuMhiAZIk3JluvH9v/v4vOU7KprNsGliYxcTc
	skHP4BPh5mjtZRCppTPYmoaqIgy25A5V3pR94qzIzNDmT6BmkhDUqmEsHRJK2EthWVB2++CXypE
	jah+E3U3hOO77jjNJ53ZxKOCZi57nTkdmWjFKzFHHFz/Ybq1JVPRMrddeLbWAP4WZkoV++kXuzM
	LFQc04Us4SDg9FTwBoymaAWIo+Pa7ZQK11xTLuCAFbWcVldJnkCBjf6kdKHcOuD2J0Sof+2Uyjc
	3aC52EhzZacJlAlbCJS1yaiGX0LzSRyAgi2q3wyLZ
X-Received: by 2002:a17:902:f70c:b0:2e8:3566:b53f with SMTP id d9443c01a7336-2eb364b6208mr35727365ad.33.1793409550153;
        Fri, 30 Oct 2026 18:19:10 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392aa7bcsm12348125ad.67.2026.10.30.18.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 18:19:08 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: olsajiri@gmail.com
Cc: bpf@vger.kernel.org,
	simon@swine.de,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	stable@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	alexei.starovoitov@gmail.com,
	HyeongJun An <sammiee5311@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
Date: Sat, 31 Oct 2026 10:19:00 +0900
Message-ID: <20261031011900.1355507-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auUhrnOOUWY3Mb9y@krava>
References: <20260822225444.2774461-2-simon@swine.de> <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com> <apC6-9YqBpOjFLGr@krava> <20261030012258.3005240-1-sammiee5311@gmail.com> <auUhrnOOUWY3Mb9y@krava>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 31, 2026 at 12:01:02AM +0100, Jiri Olsa wrote:
> could we add a BPF_TRACE_UPROBE expected attach type for classic uprobes?
>
> but I think we can't reject attaching an unmarked BPF_PROG_TYPE_KPROBE
> program to a uprobe if it was JITed to use a private stack, that would
> break existing users
>
> thoughts?

The marker plus the libbpf change looks right to me. I ran your draft
against the reproducer from my last mail to see what it does for the
programs that stay unmarked: every program built with an older libbpf,
and every loader outside libbpf (aya, cilium/ebpf, bpftrace) until it
learns the new attach type. Our tracer is one of those.

Kernels are bpf-next 7101b10cf281 with your draft (jiri), your draft
without the attach-time rejection (jiri-noreject), and jiri-noreject
plus the run-path change below and Christian's v3 1/2 (jiri-a).
"unmarked" is bpftool with the current libbpf, "marked" with your
libbpf change. Same reproducer as before, one 10 s run per cell:

  kernel         loader    uprobe        uprobe.s      uprobe.multi
  base           unmarked  672/288000    655/296000    661/304000
  base           marked    620/304000    669/304000    592/296000
  jiri           unmarked  attach EINVAL attach EINVAL 0/296000
  jiri           marked    0/296000      0/288000      0/304000
  jiri-noreject  unmarked  573/272000    640/300000    0/296000
  jiri-noreject  marked    0/288000      0/304000      0/304000
  jiri-a         unmarked  0/304000      0/296000      0/296000
  jiri-a         marked    0/296000      0/296000      0/296000

(full preemption shown. Lazy gave the same picture on every kernel.
The tail-call and small-stack controls were 0 everywhere, and the
return probes matched the entry probes. uprobe.multi is always loaded
with BPF_TRACE_UPROBE_MULTI, so it is marked with both loaders.)

So with the rejection, unmarked uprobes fail to attach with a bare
-EINVAL. Without it, they keep corrupting.

For the unmarked case I'd suggest disabling preemption around the run,
only for non-sleepable programs that were JITed with a private stack.
In the v2 review of the sleepable uprobe series Alexei wrote:

  disabled preemption was an artifact of the past.
  It became unnecessary when migrate_disable was introduced.

That held when no program kept per-CPU state across a preemption point.
The private stack brought per-CPU state back, so migrate_disable() is
not enough again, but only for programs that use it. Everything else
keeps running preemptible as today, and sleepable programs get no
private stack (Christian's v3 1/2). With this, jiri-a is 0 for both
loaders.

The comment above bpf_prog_run_array_uprobe() already says, for a
non-sleepable program, "we take the rcu read section and disable
preemption for that program alone", but the code has never disabled
preemption there. The run-path part of jiri-a, which also applies to
bpf-next as is:

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 580f89c450b5..c05292ec4d6a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2825,13 +2825,24 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
+		/*
+		 * The private stack is per CPU. With only migration disabled,
+		 * another task can run the same program on this CPU and
+		 * overwrite the frame of a preempted run.
+		 */
+		bool no_preempt = !prog->sleepable && prog->aux->jits_use_priv_stack;
+
 		if (!prog->sleepable)
 			rcu_read_lock();
+		if (no_preempt)
+			preempt_disable();
 
 		run_ctx.bpf_cookie = item->bpf_cookie;
 		ret &= run_prog(prog, ctx);
 		item++;
 
+		if (no_preempt)
+			preempt_enable();
 		if (!prog->sleepable)
 			rcu_read_unlock();
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index dfac5e1b8f40..a5721759750a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3166,11 +3166,16 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 		rcu_read_lock();
 
 	migrate_disable();
+	/* Same reason as in bpf_prog_run_array_uprobe() */
+	if (!sleepable && prog->aux->jits_use_priv_stack)
+		preempt_disable();
 
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
+	if (!sleepable && prog->aux->jits_use_priv_stack)
+		preempt_enable();
 	migrate_enable();
 
 	if (sleepable)

Two other notes from building your draft:

- The new case BPF_PROG_TYPE_KPROBE in bpf_prog_load_check_attach()
  returns -EINVAL for kprobe.multi and kprobe.session, since only the
  three uprobe types and 0 pass. jiri-a lists those two as well.
- Not covered by these runs: the same program attached to a kprobe and
  a uprobe, where a kprobe run from an interrupt could enter it during
  a uprobe run. The reproducer only attaches by section name, so I have
  no data on that case.

I can send the run-path change as a proper patch on top of your series,
and turn the reproducer into a selftest for classic, multi and sleepable
uprobes with the two controls.

The run-path change and the test kernels were prepared with Claude Code
(Claude Opus 5.5).

Thanks,
HyeongJun
