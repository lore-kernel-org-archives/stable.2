Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067844;
	b=CaT0AG0iv7xbcuDFo4sTa6ccJ4zOFryUdN10jPtkdCs1A3V1WBW2ySSg7WpkbR9wkB96
	 0Z/y9R+QGqzZVkVTcUgy58YGOA+zT/gAanllWuRyUElcbwI721pd+IsGSvck383yUUBHu
	 x7OplS0fRthkwAvtnnroZ5ObFpGocKbL7xBmB6eYhcZX9TUDeYIBmaVKhOuLRgKL7gden
	 EpHi/eYefJ9oN25cH4/OG37rfZs//m1zuih75TQteHKNjf1f6AVnGrRykcl1P7/00iJwD
	 kX8cYHHAUB0SHXsx52ataRk4KB5rtOht9Gzfekst2vUha1JAr2iT2B8eYrqh5E6RmEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=H5rRbzlaJI2FRetX43N3+DnSZ6B46YSoULdhiw/cIvY=;
	b=ogwFj5MeGvKG6NOhdjHPiCVZW6ZWEa0D2DRoZkveAA8jqWeImxUzdInn0LMaVFbqDand
	 VNtQZvAIyQ6HJb8XkjkRIeTT6o4HzK9nrqtTG5S5eTXLNMIRoSzLR0FNuyiA9kezRqmzl
	 NJP+ua60foTPm5tQ37pl5BxyMfSvkR0LG8HYyPTIQSiMuVUMM+zcQK796/y1a5pcuUcBn
	 MlF5ppji9+u3XkAHBXjEkKWVjUVw+qNCLZ4tKxbTRx1RAL7n4bwPnI4AKS4TxxxcD1ufG
	 T1dZWYFuVBcTecNB/e4NblefCQNgbU3dKOPxOwuSnVl9ZVR3jYJazPGnt2+8KnTLI/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="e3ly6p/V";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F7606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B3F7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e3ly6p/V
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9211efaca89so15795986d6.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:57:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067843; cv=none;
        d=google.com; s=arc-20260327;
        b=U65XToQ++WPtbZJT4zY4kfhZSFPV7w7bUg8AwFLvl9hnDalvN81kHbk6/MJzTsCBw5
         2U31DaWzrmxdZ7BpD6LG+gYGY9BxMJjJHWLrUwXFZk/0oVY4qtbHu2vjegmNd2HUabqE
         QC7ij2erKgAkq1wxWLQ1v2MUYlo7PMrM9SwSLa9iGe5HkI+Gygllnu9hVnQ3V+OQUfke
         LrtlxZlPyJpYvIgmiDiwkhSUoMBfs18tiPjhzc3PsjuYAPgljgRfr3X+ot4dF0aZjJlV
         DQdv3rx9f0eg/jkUv0inH3Jjb9W2wPUswdAk2aJvf8lariYzwi4NMIWPCRuUjKdoLyJE
         NF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=H5rRbzlaJI2FRetX43N3+DnSZ6B46YSoULdhiw/cIvY=;
        fh=hh64WXw32xDCPRIwo8kqdpPDKtEO7rcNvFi6kTS088k=;
        b=IR/SARh3hOgfx9TcBW0+46Umt922Y4DeyIbNxsUOKL5B2tUK3LlhnMeIjI3HFQUCjb
         9+QoYwwRiE37JfJsPc+kcdgYL7TJUQMpd1R45LOd+KYWa2WPKmpBxRUeA/+mEz8iwqUV
         O2veVGRHzDOm/sJTzaQ8rVVin1kCimCaKBkG1Kbaat0SfETkI+8Ag9Jp/Pm9aRqhOC6l
         aqobzkfLSmoaWRcAMsaUdZbN4NUfOh4r5ucuwJKjMFuP6wfLtdDFg9ng3eI0W929eQZ7
         GK1te0+OyCxpvuv+Hi+Y1DNuaKuwmdgcalJRZFk+2OlIGwkqmIxoRxTo7DZ19BmmhtBh
         OzQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067843; x=1795672643; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5rRbzlaJI2FRetX43N3+DnSZ6B46YSoULdhiw/cIvY=;
        b=e3ly6p/VcMbkz7GHnwA+DDMsgb9+xTUT4V2CfgVlyxvGaXn2AYPfAKTMnW0AW9j+tM
         8ZzwsU0R51MlnyXwZ1nYh4fP2dp3LSskwQQH7QRiNgfoHjb6R8qg/iX9d2mRy1ErMrqz
         AbggOFE65ExeyEWgmiZ9i5aOUH5z05zO2j3eBiwxX7aw0d+qJRN/I9ROtcIo73B6obF2
         9qvGr7a/baD9+IpUykV26ZFKiP1ESAWDPVsbk7VDDPO1gpWb+8d3eyvTObeNZ939W2Vs
         MJUvNeWcFzZ4M9g7d5+RG0WCpdCMeqG5fyc5ZEIeB2WC9ZAHroxUW0HhFr35+hcevbtk
         VI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067843; x=1795672643;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H5rRbzlaJI2FRetX43N3+DnSZ6B46YSoULdhiw/cIvY=;
        b=HkCp+CFrNAXbdufMhsuPNL36yylACU0FbyI0sINxGcaFIKuoRRJE6qA3DM687zsiwk
         7NPVLKLeHbn/Mrby1CoD4vDEhRqWPlxPVwA/Qimb0Mb4UDLhGod53mlRLSsalHlN0hDw
         JF/1/BnEgiA2vXpTjd/bb88eutzLpH2dlSUeKZpT9hB7cQfy9iUH+Y9Kk28m+rB81D8z
         Odr01GpgTXHwVwj4mstRPVL1I95ZuVXkMmST9rtK4h5HwM61Nxn4u+kaJ99XMq/mH1WI
         OMK8otaFMbrPh77SSPKuW3DNsZ7SxKuoU5xnHDCbB14Y03IWYihP6r9ehSplcAirXlVC
         wEzA==
X-Gm-Message-State: APuU4Z9X0oGyGFDszBpvh89UhPtrvg88Nuunx2w0A1V4sVRcFczvVpJj
	m98GZC2sQ+VisnZhCdQgxFjAi83lFwjdTzvIRAxxZfS6DHbhG+4BUeSsB94qHAHyFQ0bpdsgJRt
	acPTwvF0HInu5xRaWP5UGC0rncqnGTiLF72idtugPENV9
X-Gm-Gg: AZFdTZdBv602WeTFmvlUoYmEXGJ5HkwI4UYSqbnFevQ+KBWoBidpvIp1CTrf6hqjud/
	n/jcfAbGxZgwRX7tdjEW1aGxb/+fABTYMXmZKKvaZhaiekTsVxbqhIhFZaGYvNWGauD1YMGKJF3
	W6f8FvhfnCgg5L5VTqmaJCoCdGdnh37J5gy9550xcXVYPNNtrccZYfp2t1aSWKQoEZt/lYxUizg
	HVfdDOFsOKY0ur9IFzciHcAE+89ZiXmhEfRMxQmFl3NH408tnSHvLCN5wjnSBwi+INbPhyvJiKr
	18drmnfW4UeJDQfvTDEralngnzusS7hGdrpiPStVU63/kchd7CAxUmr+1KAciM8J9HVcHXjUUpB
	yZA9TdndbY6zXGEdeKtEuLoeRMX7ytxsKE0VohgluNRcIXjC3KS5arbsWyY9pVcWajrd9X5ja4R
	ZDXJjeNzBDrqRrlPoSRQ==
X-Received: by 2002:ad4:576f:0:b0:91f:23e5:d4b8 with SMTP id
 6a1803df08f44-92114d58c11mr78514106d6.8.1795067843261; Wed, 18 Nov 2026
 21:57:23 -0800 (PST)
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
Date: Thu, 19 Nov 2026 00:57:11 -0500
X-Gm-Features: Aa3M54q6Q-aOvhfX83anAAiTanDvzi-C11ngUmJob3qki4Rq7-QTM1P9d7ediqk
Message-ID: <CAMcAce8CPKNbO41hBv7MygO4kXZHkHogGgW7dN75qBjeFrsEjg@mail.gmail.com>
Subject: [PATCH 6.12.y] Backport request: c83e2d970bae ("bpf: Add tracepoints
 with null-able arguments") and 6.12.y netfs_donate fix
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stable Maintainers,

Please consider backporting upstream commit:

  c83e2d970bae ("bpf: Add tracepoints with null-able arguments")

to linux-6.12.y.

In v6.12.118 (kernel/trace/bpf_trace.c:2365-2410), raw_tp_null_args[] is
missing entries for nfsd_file_acquire (args 0, 3), nfs4_setup_sequence (arg 0),
and btree_path_free (arg 2). Additionally, 6.12.y contains
TRACE_EVENT(netfs_donate)
where argument 2 is nullable.

In live QEMU tests on v6.12.118, eBPF programs dereferencing these nullable
pointers without NULL-checks all loaded cleanly ([LOADED]), leading to kernel
NULL dereference crashes. After backporting c83e2d970bae and adding
`{ "netfs_donate", 0x100 }`, all 5 reproducers are correctly rejected by the
verifier with "invalid mem access 'trusted_ptr_or_null_'".

Note: netfs_donate was removed in mainline 6.13, so `{ "netfs_donate", 0x100 }`
is a stable-only addition required specifically for 6.12.y.

Fixes: 838a10bd2ebf ("bpf: Add bpf_raw_tp_null_args()")
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/trace/bpf_trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2370,6 +2370,12 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
+ { "netfs_donate", 0x100 },
+ { "nfsd_file_acquire", 0x1001 },
+ { "nfsd_file_insert_err", 0x1 },
+ { "nfsd_file_cons_err", 0x1 },
+ { "nfs4_setup_sequence", 0x1 },
+ { "btree_path_free", 0x100 },
