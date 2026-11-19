Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069115;
	b=slaHirwe6UNVjzEiHJcC7ngpWbHBRpAPRNaARdE7jRFPRRC3cI4i7xA2DSUlO0uj6bGm
	 eDxJdakA6r2U0AUTlRAaFfXqCkppweAn+sh20rV8nJPWsXMv09EZV6T6dSNCKTW2OCMy+
	 PNyxZsPTbFX7xo7ujJgv1CK3fW/Q6ALinhdHmTqpDevmo4E7KhQhZnDZGCJ57rjhPFxIK
	 U2aPB8/wawsB06oOl6i6HFYY/nF4MF9OiXJv0Vbp35p45LiV0nJ+3AmamM4ngXZLOfKe5
	 pYngQ4QVXroEU0pPJVFukaJpbE9J2nkFn1nsVOPd2WxtmXpOEODpSTms1EIWSXsp7vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=FkwRSQFDonsNjEAPB2zFYO6lMt6WVqW7I67T9GbDWzM=;
	b=pHyNSOhz/0AzT/zyfRP9VvOXWIdlqJVZx8wVGA6LmzswxRF5tlwFG6PlCqFGRcxaR4nm
	 2CgkxIa7WFRkGuEr6xy3ALVdv+n70ITSJYWFNinf/Rr6kwdYatbXvU7Pa7UDvcO6y4lzX
	 F++mauQatyvupFjKCbEzJrN3CvcHM0lmq7s/FKB51HwozGi+7hm7VW+u4s/GyBulbHGT3
	 Fb4aun5iTBUfXQmpkW8nfueBR/pR7b6flF+m3up68tE5Oc3ldZBUjhlld4dIMh7FMRMU5
	 UBUmOLHazOyvaYjD8MdL92WOrq/rP7loItBBkYAruR3ILPpp+txjMC0a6SRfg7go8BQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7XBeknV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD46606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD46606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7XBeknV
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-92106d5371dso7726366d6.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:18:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795069114; cv=none;
        d=google.com; s=arc-20260327;
        b=anvaYeF3w1x6o18C2U1QoBS6+6Dz4sNptX1Msol4gkQlKT/UIT1Q1KLD/a2cRRVXHa
         zgxr4VAZQ/lIzbekCdYHYH1cxkZi1F//g9QsiRHvopraw6ocKV6Pv1UcKwVaYwm9cY8D
         cp2Jg+4KEQ/w0bqsQvQp85nleBuTmfJvcpZ3EaXe1p6C6WAsAKq3HqWGqmi2YZtwXwIX
         WKuM7TMnYvmRQtLZ6Oie0Dhw8v1It2fkfCVKBrniJk8bNGN7YdZv1Pk4UiOFMA7fmcKx
         iFP0qvZFy0VS23ckna2/zAcCLvcVTeDO6qrp+Ez9/vqHZG4GICRnIMIrOMxFfQStpvx9
         ilSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FkwRSQFDonsNjEAPB2zFYO6lMt6WVqW7I67T9GbDWzM=;
        fh=zD5wSbWu6XTPcoa0xHul7FftLqnLGKoQDb0K9kWIrrk=;
        b=MNXjLCg/G8cojm9szQxOhMaYG/d4u0HjQGifQutlm/CD6DYbj3GHYlwSoLSSEw3DTC
         OCRSUYgANqwilQwjy8an1edBshnXr2a+9b9iDl0uWF0RQjYhtddBmAexWxwWqhw3mFeP
         v+4uiPcNozSzKNmtTbYkOFqKSUmQYhhHwpuiEkK12mbYExHq3qMecdSS7NcvoSzuwxYb
         KyXCRDUaeQX2qdByeimGfPfPpBWxzPruqdUc2AEC5uGX1vTC/h3mW9tWHUfpUV1/h+ee
         zo8mVEjU9zNU85PwzN0QApL4wfE/6Txd/kv+X+dPbe3wHATmSpQFrFeyxoUryvrlspDG
         ibwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069114; x=1795673914; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FkwRSQFDonsNjEAPB2zFYO6lMt6WVqW7I67T9GbDWzM=;
        b=j7XBeknV5sIlnxlFuRpkyMchLbY9nrTW1brjVrqw6QAEZr1JwjhL3KEueCnPsuhxTM
         hrOQJrwovvArkCYAEoSyjQrOADbOS53Ys+HcB61CbRLwrPncMi7Isz8FI3lSSbNNUANJ
         rGDpTrwmQYHyOUwNwpR19HtOTJVoHb28ANOaJxPaI1eVrEdANXHbOL5BqfvRm7rT9tat
         okT7uIfrVsHnV6SwOPhAQ7i4xxeXieD6bksBtKvCjuYmNCndxetspKINIZbOJ37mzzjZ
         eqdtbeipNAx9PmYuGxOqv2mbXFWP/eb4719QqFFDj3lIX7pSSjRLyYrh6F6K21f0vx/h
         LT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069114; x=1795673914;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FkwRSQFDonsNjEAPB2zFYO6lMt6WVqW7I67T9GbDWzM=;
        b=RjC7ri1OMkx70lDarwGWXb8SHcmx4sPxvBw0vOAcOnQ82/xMh9Hkp8NZvkZQWeYN+j
         s67MCtQtOJ8OJYPCsyA0dW07jI6+sCCV4lIWPsDDUWVm4S8EBN+dd+HS0cS9EZr5TJTq
         tZA+Tq0XMs88ueYW5QK8Gdk/BgasA0rJEmhaqSGuR30XP9gfVrBoUAPr47LpMANDXraV
         j6RfnXK1ff8QxGyQE7rjdoHDFPAUuFUEDtnMCySfZWd567XaVmHbRJmpOdtF5Z71Zgl+
         s9tOmP2hxy1s/DUskMYWw0W3gu666sHDFeJWBPy05V/3whbqV3Haz0+u7Ws6YkjxkDwb
         kPEg==
X-Forwarded-Encrypted: i=1; AL+hErHbPGtzNtMtiHa/T1nDieVmV0gZOUB6nIjEHiC1+P6h2EXUP2vwNnRImSL2U8WDbYCFrheqhSU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6hbdh9/WiKB5N6oYBs/cHOva78dmaAm+n3ugTGpW24ruZsGU7
	KUQufPtwzkewp2Ivf4a6t1pBtcyy/veVr/CdcZKaaizujhtp8UPUYPw2HKbGn4855PshygVna4E
	0TlOR517ithQpPDZKVvEBexpK+qWjAeA=
X-Gm-Gg: AZFdTZf3oS5MjXpR6JdEv3a3SmPb7flJ00fASeRrroty21N5nqpmrNQeTCJlLqDh4T0
	M8PTW33erWns9yWpFsS/4fiJ6eJest71SxJr/Afwyz0Sznzh43lsG866Hx8MZ90bc0Fp2axdMEf
	tVm5v23xDApbwf+FAULoTM+cXlfxwo9TQbcCol4HX9rai8U5ToBmatScyEiwF/sCk5fgY71cydr
	qCeGd2cEN1djgFz/YTi+c7Cv5ZKC2kfBx/E1V152fVKqsxiwG2bFRaQPpF4WULGSCvRUkj0tTAf
	FQ1++gk49ePj8OHwh1/a7j5O+Y4SRfVPfOVgf/741LsyalCuFxgHXWB1QjM4J9aJOnY91Q2i4Rq
	XzRYArJfoj477MLhOjF4m8fGEMpFQr5KlXMGUGWwXqvZ4ESzbAViud4C13iR1WL6RlHM7vKsi7+
	qYcQcHiahxLcc6SGl7iA==
X-Received: by 2002:a05:6214:627:b0:921:2c0:a46 with SMTP id
 6a1803df08f44-9212de35a74mr2230366d6.2.1795069114246; Wed, 18 Nov 2026
 22:18:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:18:22 -0500
X-Gm-Features: Aa3M54qvL-gkZG-PDrhf4v1NxnLtVHwK458mPPxFaslFbH2AjBYMlncoZPd-AZU
Message-ID: <CAMcAce8_ZR9xr8KJe6kvDNxr-JW2A5Ya5tn_2SO86hn7oR1KCQ@mail.gmail.com>
Subject: [PATCH bpf] bpf, lsm: Remove bpf_lsm_release_secctx from sleepable_lsm_hooks
To: bpf@vger.kernel.org
Cc: security@kernel.org, kpsingh@kernel.org, matt@bobrowski.net, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

security_release_secctx() invokes release_secctx LSM callbacks
(selinux_release_secctx() and apparmor_release_secctx()), which only
kfree(cp->context) and never sleep. Because the hook is non-blocking,
Netfilter callers legitimately invoke security_release_secctx() under
atomic, RCU, or softirq context:

  1. net/netfilter/nf_conntrack_standalone.c: ct_seq_start() acquires
     rcu_read_lock() and holds it across ct_seq_show() ->
     ct_show_secctx() -> security_release_secctx(&ctx) until ct_seq_stop().
  2. net/netfilter/nfnetlink_queue.c: nfqnl_enqueue_packet() runs under
     rcu_read_lock() in packet RX softirq and calls
     nfqnl_build_packet_message(), which allocates with GFP_ATOMIC and
     calls security_release_secctx(&ctx).
  3. net/netfilter/nf_conntrack_netlink.c: ctnetlink_conntrack_event()
     allocates with GFP_ATOMIC and calls ctnetlink_dump_secctx() ->
     security_release_secctx(&ctx).

Listing BTF_ID(func, bpf_lsm_release_secctx) in sleepable_lsm_hooks
lets BPF_PROG_TYPE_LSM sleepable programs (lsm.s/release_secctx) call
blocking helpers/kfuncs such as bpf_copy_from_user() in atomic/RCU/softirq
context, causing BUG: scheduling while atomic or RCU stalls.

Remove bpf_lsm_release_secctx from sleepable_lsm_hooks. Verified by
line inspection on 7.4.0-rc3 (20eef29b7c84), 6.12.118 (bpf_lsm.c:347),
and 6.6.162 (bpf_lsm.c:337), and live QEMU BPF verifier runs on
x86_64 7.4.0-rc3 and 6.12.118 (lsm.s/release_secctx: LOADED pre-patch ->
REJECTED post-patch with -EINVAL, "bpf_lsm_release_secctx is not
sleepable").

Fixes: 423f16108c9d ("bpf: Augment the set of sleepable LSM hooks")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/bpf/bpf_lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 468e63d..c7d683e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -368,7 +368,6 @@ BTF_ID(func, bpf_lsm_path_chown)
 BTF_ID(func, bpf_lsm_mmap_file)
 BTF_ID(func, bpf_lsm_netlink_send)
 BTF_ID(func, bpf_lsm_path_notify)
-BTF_ID(func, bpf_lsm_release_secctx)
 BTF_ID(func, bpf_lsm_sb_alloc_security)
 BTF_ID(func, bpf_lsm_sb_eat_lsm_opts)
 BTF_ID(func, bpf_lsm_sb_kern_mount)
