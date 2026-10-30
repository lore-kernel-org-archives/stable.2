Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793323387;
	b=sY9A8IbevS5dgNec0PmRz7slauAVthWekCyUosyTrZ/GjWO7HntGtzQOfsracIgxjqzm
	 OWGXGF04vTyItIfboQLufXY9EIQwJF1GFmgxpYr0VKyp8BRZtvJYgFLTmSfSIDV+rgzG0
	 Lg3qOVWcUkajBDFrx4N26MGJhkN78UafINAPpFI2yDwiZSw1RkRsANnfNHZ6JuucMXQpg
	 MrHXOwDWsovFKP1xK5j5bEZtQToyt8jj/uI0T82YqWmcLA0PaJAFuH4bAUhKXB1abju6O
	 3yWFRyxaCWgW5vPyhGDtPDiK5UFx9ivNeFQR1INYceaEs4k13a3Gvo+Wae+yVqJTM7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793323387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FUSuDub1ncyw6czLI//WC3zBoNv86c2l6fv9cq9Ok+8=;
	b=pbjovTFT5QFLUM2vu1xf85SZWxo4Eq6EeXmTmQd2Xqw9x9QZDbjsHtR2ZQppYWXbbhn/
	 q3Oj4lGEkoh8He8lEIiJfpMTzzD4BrnTMiRn5Db+EZ9vyKpmp7mC/m5nOvat4t1Kz+Lbe
	 9N/X/w4UnCwOT8vQhRaxVujfR0w/7yhvI3PXoqeaK7+l/q0BPuZPMn/hGVTy/AS1NIDmt
	 yKqTO3R40aDorp9KB7jW0VckSZyFXUDpjkQ/z1uOR5Ez9DWXX4+Vb0u6vt8nroE1mWvji
	 IqKjuljZTMbC2okiqM/tDIDh+/6502j+je8jxtalj3IxXDdR0xmxZ/xetiDTl8f1XFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EzaLtQqJ;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FA606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 01:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE8FA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EzaLtQqJ
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso77760a91.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793323386; x=1793928186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUSuDub1ncyw6czLI//WC3zBoNv86c2l6fv9cq9Ok+8=;
        b=EzaLtQqJ6OqUXGdR7rRbpFbGRT7fOwz+Sa2SLtFszsxQ5FR4Jca6FtaeQ5Ktfjdo2Y
         nLxC47/MsfZ3TdQIjPunsuX9mvhnTD5NbDhUvuGPKYICqMBuq6ZAXPCWTABVQBUHrSnJ
         ObYXJ+AmdAGpX6q8qiukzQXmqh87gcm2pZFiN/zO07YnM9gqqFN/Xn28U2Tx1UWCP4qM
         IrwxXVU3c7n9nMWWUxUaxZcEynKlVmJ43g2uQo9PSf+vFyuCzzhlf8h64Fh0MK8CqN1d
         lzxwJsu2kRwFpD7W/dAasdiZHDfybdksEQ5Q5WlLxLLGhW1BThl6ot/rXjO1d8RISEUZ
         0zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793323386; x=1793928186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FUSuDub1ncyw6czLI//WC3zBoNv86c2l6fv9cq9Ok+8=;
        b=fRkPCRQ8EoENrr9g7hKd2t3GZ5Slq8MLPgXsLWFy3rV+Xij21UI9AGsP+SOcLFfdXP
         9jpsUTeO1ZC+dkeAHk90NdKY9/P3t6iMIG7TawHFeH7tOvlMMeESmWvYplPft05OIAz/
         jZsfIFpTKScttHBvU3tUHVbYWSWcUPZxUtWEcKKCQn0dVCfnXH8U4WxLYv5QXhWEsuSd
         w6laRARI8BjkZgVShdBS5zaJlA4qOgWuU8P9aNhPbzrdherVN4sIIOlE+9WJ9RcGfUbW
         Rzn5XWoOdSadpz8z/aqwm4MdyKcuP3pFQTDt2/GfTgEvGXYRwrWdm8n9RTHKwg5aF+ii
         OLmA==
X-Forwarded-Encrypted: i=1; AKwUvByiDWEUu36nURBTxAzIKIWqEBk1qbav4O0e4enIQJO5tyhkNvZ5HIZegXAoFR1MuFSr8fppV4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGvUlfouK9cbfuiUCNjjTPBoAHd+7+yJDcSm79DjMgQBXPTR+q
	fTrCE0j7klwiQHnZerdNrfsR6zkXEfMbnAQBPrdf+YrNJBLGSJ0t9Khz
X-Gm-Gg: AYBFou2KMAO5Xh+V7Vs8CvqYYasQjOcdHg0gzStVzLIuQNNean6CKqM2Kx/nosF5MwL
	NTWIoYp0mOq4ZnuHp+A4tpXarfcLUFN0Xeg5lI40k38tL47dvZWWYKXHOqCuorveCj/AjPTr6La
	V60y8/+h1r2cBAAHZBlvBFk2OEh5A9BILmRMIFl9YwujCRbAGMBiJ/FWmYtHR+G4ZVlYGdg3ErD
	g4KiEp45LqECpbd0LWxwy3l3VaqTs0s2bY+LpStNK+DWu9tbViCq1YTJdn+7UJKeJDV6cDarXyQ
	eT76d+ScQn+PWtjuLEK6PyAlNwSHVLR9fm6ZWi4Pnw2PBu/JKJHGOz72C9gYrkDJ5a9bsA8nwF7
	aO2iw9lNB1vznVrx128nOIEkQyGlruBwu1zCI3in8U5A8NAyp6hVzUxDE+JErbIdjvcpStKe806
	jb2YnAI24yHtXHkgca9YgH6VeozC8QvzxLbB01SWJpsq4aIQpno6vvAPKjWTktlwFRPi8UWTlMj
	+c7HizzbWKT5AsgaQR/4HWRKwuboh4Zp3p9GoASkFu/92CfX5+t8xuPH/VykYn8kCVKQ8tD0QVs
	Sgp3cL2F9FyXNMDN3uvt/pAqGn/kdYQEA/SK1q/fi2oaa/ejUVkyxyx727gGw1gCfCsxltp3two
	ypAFWTi28vPjbVZGnH8LnkdgO2MdBLOxosXTOWjyhCHyj6kByRDM9iuLCvObvcA==
X-Received: by 2002:a17:90b:4cc8:b0:3a0:c276:1ec0 with SMTP id 98e67ed59e1d1-3ae897f673emr509552a91.28.1793323385932;
        Thu, 29 Oct 2026 18:23:05 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ae5b9sm1670397a91.12.2026.10.29.18.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:23:05 -0700 (PDT)
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
Date: Fri, 30 Oct 2026 10:22:58 +0900
Message-ID: <20261030012258.3005240-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <apC6-9YqBpOjFLGr@krava>
References: <20260822225444.2774461-2-simon@swine.de> <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com> <apC6-9YqBpOjFLGr@krava>
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

On Fri, Aug 28, 2026 at 12:32:27AM +0200, Jiri Olsa wrote:
> > my understanding is that preemptable kernel doesn't mean that
> > bpf prog can be preempted by user space.
> > only by kernel.
[...]
> hum.. non-sleepable uprobe prog is run by bpf_prog_run_array_uprobe
> and it disables only task migration, preemption is not disabled and
> holds rcu_read_lock (which seems ok for preemption)
> so I'm not sure why it wouldn't be preemptible by another task

It is preemptible, and the private stack gets corrupted when it happens.
We hit this in a uprobe/uretprobe based tracer and reduced it to a small
reproducer.

The second writer is not user space. The scheduler preempts the task
while it is inside the program. migrate_disable() keeps that task on its
CPU, but the CPU can still run another task. That task hits the same
uprobe, runs the same program and writes its frame into the same per-CPU
private stack. When the first task resumes, its frame holds the second
task's values. Neither uprobe run path disables preemption:

  bpf_prog_run_array_uprobe()  migrate_disable(), plus rcu_read_lock()
                               for non-sleepable programs
  uprobe_prog_run() (multi)    migrate_disable(), plus rcu_read_lock()
                               or rcu_read_lock_trace()

With PREEMPT_RCU, rcu_read_lock() does not disable preemption.

bpf_enable_priv_stack() gives a private stack to every
BPF_PROG_TYPE_KPROBE program with at least BPF_PRIV_STACK_MIN_SIZE of
stack and no tail call. So classic uprobes and uprobe.multi are
affected as well, not only sleepable programs.

The test: four processes pinned to one CPU call getppid() in a loop for
10 s. The program fills 16 stack slots (a 216-byte frame) with
bpf_get_current_pid_tgid(), spins with 200 bpf_ktime_get_ns() calls,
and counts runs where a slot no longer matches a fresh
bpf_get_current_pid_tgid(). The JIT output confirms that this program
uses the private stack. The controls do not: one adds a tail call into
an empty PROG_ARRAY, the other uses a single slot.

Clobbered entry runs / total runs, one 10 s run per cell (7.0: one of
two runs, the other was within a few percent), x86_64, 4-vCPU KVM
guests:

  kernel         preempt    uprobe      uprobe.multi  uprobe.s
  6.12.112       voluntary  0/288000    0/296000      0/288000  *
  6.18.56        none       0/272000    0/288000      0/288000
  6.18.56        voluntary  0/272000    0/288000      0/288000
  6.18.56        full       497/272000  481/280000    501/280000
  6.18.56        lazy       0/280000    0/280000      0/288000
  7.0 (Ubuntu)   full       1221/856004 1202/864004   1158/856004
  7.0 (Ubuntu)   lazy       0/840004    0/848004      1/856004
  7.2.10         full       649/296000  654/288000    642/288000
  7.2.10         lazy       642/288000  622/280000    655/288000
  bpf-next       full       700/288000  595/280000    619/280000
  bpf-next       lazy       634/288000  670/288000    647/288000

* 6.12 has no private stack. Its JIT output uses the task stack.

The return probes gave numbers of the same size. Both controls stayed at
0 in every row. On 7.0 under lazy, each variant gave 0 to 2 clobbered
runs per 10 s run across repeats. bpf-next was 7.3.0-rc5-g763187dbbf83.
On 6.18, lazy stays at zero while 7.2 and bpf-next corrupt under lazy as
often as under full. We did not look into why.

In the tracer this showed up as copies from another task's buffer
pointer and length (wrong bytes or -EFAULT), and as return probes that
found no entry state because the tid in the frame was not theirs.
This was on the Ubuntu 7.0 kernel with its default lazy preemption, at
one to four bad calls per million under steady load, and more when the
host was busy. It went to zero once the programs stopped using the
private stack.

On the fix: I agree with Andrii that skipping the second run is wrong
for uprobes. It is a separate, legitimate event, and a tracer that
counts calls would silently lose it. Disabling the private stack for
uprobes, sleepable or not, as he suggested, avoids that. At load time a
classic uprobe program cannot be told apart from a kprobe, so this needs
either the load-time marker that was discussed or dropping the private
stack for BPF_PROG_TYPE_KPROBE. For uprobe.multi, expected_attach_type
already says BPF_TRACE_UPROBE_MULTI.

Until then, a single tail call into an empty PROG_ARRAY keeps a program
off the private stack.

I can turn the reproducer into a selftest, or run any version of the fix
on these kernels.

Thanks,
HyeongJun
