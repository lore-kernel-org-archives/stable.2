Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795370703;
	b=fs+JAmaAjlvbA/faVMAR7vpi8pEeNa0QMKM6qlOKMlQTBozcsPiQhnikodFjgXtqDv1f
	 MMiSm33dDUukt9p9gktMy7CXkVyln1rdmzMrO4i66/h0QH/h9o83+jf3km+eyXeiDXSsf
	 F+zmFVxdKSpBTUJ1rw1o57cI8B3XBmNKawfKskQ2KrLE+H8wRla1hxlmkyXVll0gJgYb0
	 FXgR3JQoCzo8tfmdMgf1IZbMhPIsVzq51fjTEDop+a9Smjug1FAof+fmeJQU7JixpPm3u
	 OVWdBoD7ZHQiEYIzLSCXNPkrTiYo+xWtLnAYmgfhXoxluHxIbyUdOxt+Xr6e2OrGKYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370703;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=4vSZ2JJSVwAY0NqZGHRtfxYhZq5IzJWvftuhqfw7Sfs=;
	b=bZnqSd67Lzm4KiCOhd/glBHuVE/92yojZbyj+IqZbivZEMoVSCU+ftgofbmEMPiM020k
	 phZo132B6/WdCjdNjQPOvMBNx8/GSlnfs+vVR+LdDDGwWelX5PocEB5+5ExctI4HYdxly
	 OU6JbrP3dzVD7e7lQsPDs1Ew0p3zbxzwo10pwZUD9ZU9vp8aen1FbewqTVG5vP4siR89Z
	 S7B39KpJ4MFA/Sch2Ir986iyvdXkeDLjAhfJCumYbV4u2W6M1tIB9LEXaEU2JALa4329w
	 3bf0w+aEjxcayBolXB2i8oC/V0ksXLuD2h9TLLJCB44IPSje+nOkqw7hVkRfdrSAswA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KWc2+l5/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A7606A320;
	Sun, 22 Nov 2026 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWc2+l5/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795370702;
	b=cD1KheEIeiKbyo+lN1/QLKNfyxqci8e04GvXSufAjuglvUnyTZn9EZjOdW2aeudYo6h3
	 /hS9EgN5oI0sl27ubpzrY2o/p+/nzeJFCTLz0ajxYP+EqO46L9rRh8Y6l12dEbZqP8cqa
	 JUi2XkEH0nXroEaKXb/uz3Qva1RNGloNxJzi+WjbPxUy8Dd7bSUH7bLIQ57VZ5V9pTdHS
	 /LaGX528bFQtVVmxjA4Pu8aBRdyMQRFCZdey4wY9zL1Vgs4U+NraYKYhJJEtm7hRMBow7
	 YHMcvt9fu8wbt0u+qgo476IWiIcHBKhTqwQ2Vl3sXILdTp8MZIfmjHvY++PCwC14hKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795370702;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=4vSZ2JJSVwAY0NqZGHRtfxYhZq5IzJWvftuhqfw7Sfs=;
	b=Ka9XXr6P/M4ZHaNmR0NUtZVCdvT3kQF7cUmKyCXRjF1uDbQBgBY6D/6Wn539uqS/P6nB
	 LTTToZFlbo3bee+1be12QIoirraEYvnq9hHQj523IWpJiYKWzaAo/udOO/arAOpfA7eYW
	 RZhWQEsDK/RFn/YBDAQdbAIji4+k86SfQkjBeJ8R848Q6QH4YHzQleyUkv9FzscavyIjl
	 CEkwpRrLeY1wIcFrGy6VnIglBUT2zrfYwOLPb+STupu9DV72SM6TyDrtzFXHzPhovSu+i
	 fydNf08PdnEfBKLm7xphNhyuMDIBkxCj3CH7DAnyzptvaAkkgP0HzFcB02MHkKIW+Ag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 339711F000CF;
	Sun, 22 Nov 2026 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370702;
	bh=4vSZ2JJSVwAY0NqZGHRtfxYhZq5IzJWvftuhqfw7Sfs=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=KWc2+l5/uNAx2O8t/TcyWEqYjtw3wA/8rCSR5MGC+56NIAv3cOK2vNVFOsIRXl4o0
	 DfAGBb04shGpULwTGoZQEvisHH9ga3uwpD6iN2o6UBYCdggSihXWVicV7TVvEP5d+i
	 QjZULTKMzlThA6HyF4UisggEyywhr/w+7SLSDjU9Yyvwbt125mXeBvQ+R4LRPlciFC
	 /XQSZVY7+0L6m4CgjY8tPlRoju5ZxW0skweWYdecy0Vf1P7hoZcu8ayAsmV4xcuVWF
	 ILnF8t/O2J54wqoUU1cOWn51PMIyTPKHJNcA1otYX80fKt+WV4hf+0bOo1CdzI9hMr
	 GpbVxxKVqZrbw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8D7754C16A;
	Sun, 22 Nov 2026 18:04:57 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Subject: [PATCH sched_ext/for-7.4-fixes 0/2] sched_ext: Fix two gaps in
 dl_server protection against RT starvation
Date: Mon, 23 Nov 2026 02:04:53 +0800
Message-Id: <20261123-scx-dlsrv-v1-0-87c342d8246e@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQrCMBAFr1L229UmxFa8ipQiyUu7IK3sSgmU3
 t2gn8MMs5NBBUb3ZifFJibrUsGdGorzc5nAkiqTb33nnHdssXB6mW7cpxCQw/XmW1Dt34os5fd
 6kMUZaUT5XPKq3J8D/91wHF/iIpeIdAAAAA==
X-Change-ID: 20261121-scx-dlsrv-7d44ef45820e
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, sched-ext@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795370696; l=2617;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=aSZAQoVClVkjxIB0EoJguj0WIv5tGQ97jdqS31tG35g=;
 b=iUyXsA1PyOnncV3w4VClrZYRB3zpFeScduXVAaZZYivIZA9bs7L0zuYlp3J+jZbID2ExlGqcV
 5LsITTAMHt5BAs5BS9UGBOM2rTwcQZSHpE0hiqglBTYuUjpqAOGu5pe
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com

These patches fix two cases where a dl_server should protect tasks from
an RT task but isn't running. The starved tasks then hold up the
scheduler disable. It doesn't finish until the RT task stops.

Patch 1: in full mode, the disable attaches fair_server only at the end.
Tasks move back to fair long before that.

Patch 2: a CPU's ext_server restarts only when the first sched_ext task
is enqueued there. If it stops while tasks are still queued, nothing
restarts it.

Both came out of one stress test (scx_simple, CPU hotplug, stress-ng,
SCHED_FIFO spinners). The patches don't depend on each other.

Tested on sched_ext/for-7.4-fixes (8e156b9218f9) in an 8 vCPU KVM guest
with PREEMPT, PREEMPT_RCU and NO_HZ_FULL:

                         no patches    patch 1        patch 2   both
  patch 1 repro          37/300 stuck  0/300          -         0/300
  same, KASAN+lockdep    3/100 stuck   0/100          -         0/100
  stress, KASAN+lockdep  hung, 4 min   hung, 2-5 min  1/3 hung  6/7 ok [*]
  stress, no debug       -             2/2 ok         -         3/3 ok
  selftests              -             38 ok, 2 skip  -         38 ok, 2 skip
  messaging [**]         1.849 s       -              -         1.821 s

  Each stress run is 15 minutes.
  [*]  The 7th run stopped at 2.5 min. A fork stalled for 75 s with the
       scheduler enabled, then went on. Not the disable hang. Cause not
       found.
  [**] perf bench sched messaging -g 8 -l 1000 under scx_simple, mean of
       15 runs

With patch 2 alone, the one stress hang was the problem patch 1 fixes.

Patch 2's cost: during a scheduler reload, ext_server restarted and
stopped 238 times in 41 ms on one CPU. I also ran an RT spinner with
sched_ext tasks on the same CPU, under scx_simple and scx_central.
There, patch 2 changed neither the restart count nor the time the RT
task lost.

I didn't test on bare metal, or with other schedulers outside that cost
test. I didn't write selftests, because both hangs depend on timing.

I used Claude Code to find the issues, write the patches and run the
tests. I reran the reproducer and reviewed the patches.

---
Hang Zhengyang (2):
      sched_ext: Attach fair_server before tasks fall back to fair on disable
      sched_ext: Start ext_server on every enqueue

 kernel/sched/ext/ext.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)
---
base-commit: 8e156b9218f9f1f8b866d8e253145afdb01cf289
change-id: 20261121-scx-dlsrv-7d44ef45820e

Best regards,
-- 
Hang Zhengyang <hang.zhengyang1010@gmail.com>


