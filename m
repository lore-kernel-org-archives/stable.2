Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006758;
	b=RWC0DDl14uUNGgZFbUL8iwvbadX30R9+UDwKtFhj1+4L+PyszFaJSyopT+FpJNJ1KA/3
	 mQLl3SYg0NiItrudCsT97G9qZH00LgPpAGJlVwAykF9qm2N0trLZCJfQ5sb6Zo5FW7WI+
	 rEEuUv8KOJS8+9d+5KQbnTbQRWv4iDbq7KS8Q44nwwpsL6zjQKtN90n0AE0ZwNv10wNbt
	 x+h4WFZshNoQ0pfg8rRVicJNwVUu+FjR6ObNCMm3T/2bIl4U+LDeO2HGkPpZAC+lZ85w+
	 w5IVbjMpEPcKvtrCjUw6xpIKxxnO3mpVTvAJFJm5xDKXTRNbBhuaimedy6cFHUtY2tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=TYbJ0YDvZta3sZP5deI3FncBa1pWQOd2rIMee0RSN/k=;
	b=vleLcd8H7BTyB7FYHLAYiXeecl5BCVPFAGHokAkm/7OESeofBVnhEm6lmYsGyGEwTbah
	 7cHFvnhE2pK4K7/PMJHl6ZRzNPug+r/i/p1zI7I95fOfjcMnOJ7c+6GhQaHn08VYLE0m4
	 MVw1IOZO25cvEbCBFLDGLf76H7Dhc+969aHPGeyuU5J3AYzZl3p7PY0NVPlIuEboz3iPb
	 Q8TchbQ+TFPLOQOKVkj9vS9zCx83r14sHC/3ur6HMHIoaqAuxuMkCxcGUGJHQOgcbGPkv
	 VDdDAkMu2TE4gegS97KceSwQP9UGCfEiqMz0H0kvVIVnZYTymh6huXW3CQfjNdqEPlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Mdkzogbu;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485EE606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 485EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Mdkzogbu
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36dbde64409so1774954eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006757; x=1795611557; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TYbJ0YDvZta3sZP5deI3FncBa1pWQOd2rIMee0RSN/k=;
        b=MdkzogbuvCOjZW2u1cOpwquoSmrH7mGhH7nHEELyp1adfeCMZ04GGRe8AKnagLrQQt
         umVb3mFHgnsTkzCQf5YbQDEYji2ymufna09psuXz5ELeV4QWQbJ8yE+hMWjHzmlFGQrc
         QEA5hJMQvl7NxHOP88aHSvrtqM5AITvaxXQIaikmcXkFZzb1g12BdquK4wcrhvOs7Gv0
         EerP1UwsPg/USuNhaj+QdJUXaXKSLnrjbi7fj63YfTe2tUY0+IqfoFb9qp8p6bGxY52x
         8GzBOr/4nVJgO5W8Lyo26QHynqkbuMYwCP8hndxxEY34/sW1R1hxksCa4Aoy3pSO+sYu
         dJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006757; x=1795611557;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYbJ0YDvZta3sZP5deI3FncBa1pWQOd2rIMee0RSN/k=;
        b=PS9BmekV2AuHdvUsvqfaX9Y2CQqCZd89zJP9zKhLRz12bw7WKOIGV0at+hN/H5Xmos
         KANWEvt+rxUC0o+tFyRbmlSVh6tZdYjB4Sc6W8FqvW870qBpre5Jq43bcDAbFTlSVId7
         yLj055ydVkjk7d7r/y2TGIUDOx3qRT7wYGFuyH1yreBOSxKyR5XaWoD6gCSCUSG9/TO4
         vL9BxPBJwdkud7JhUK6x5t55hWAf31Rpw3rIyMXOqfhkSu/gAnFRe9XbELyH1/KcJGoL
         FYXaRUqLbwNHQ1Hdpx1RltRHo5GRYRV/zZIvMh0Csl88LwrD1wGD0NWdB3ZQDXaMnpiH
         xPYw==
X-Gm-Message-State: APuU4Z/OtGDnxT+O3CC6lq3BZQThsXLii9wdTGSSceVt0eXrnnY5f4XT
	kqvkxxTTflmauwSd8bwqGZQZd6ovVBWGQNshOYkntddzjwuoHiZBJnLsm5Cywllpox6sawqXl8A
	ViANU
X-Gm-Gg: AZFdTZf5Sqlqu0Q4lTc9REVu/j9FQ1yIZ1se4qsILlX5l+ilVwCq2KDDJ5J6Cb7CDwQ
	xPuWcFwxcMtLRlHKkCWXnrA4c0g0OVPQwiQA9D4BXyEc6sC8a7B6NCBBwksBIoxT/iDPTpo9zt7
	n59Ghy7Rnw6qYOTNM3KILbeKaZNrhbEROrFPrFfEaA5Re4fE6Cnq/anvzhLXU5wSc6SZOjbyIvN
	CoitpD2i0NNfyHznBEpURg4FjokgJHHAnMv0DMxX/TjNJ17vQkTXCpwZp4coP4aH8I84xoZi3g1
	IwW7Pl1EOduwkPSg8XJaLQjoWm2Kiqm56I/MhojfLca+avkxu9kB1Y0kJ5fZOfl5cr6Mk2NhcK9
	TxcdjETjioF2gQuZRqg6Mzw8cm4BtU7H+xTyFJpyohYTJIuqXd2kONBVbfLCOXunxdPMYWmtC8O
	MPXx6q5GKdcQTQ7ecLWonGQOOhTcvL3DYQHgjGlUI2kAKi8lPtiEtJ0xdpKovsiI1KrJlaZZJe5
	9EAhTJw1OEwTTENA9mcT/4CxdhU7mMGpNLP72vahVqyL960RwfANXC3uLZ8VJ5jOb6R9VSLlhIr
	aSOGqi6zhEy1fhTLITghSQ==
X-Received: by 2002:a05:693c:69c7:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-3827f98a2d4mr2087016eec.8.1795006757031;
        Wed, 18 Nov 2026 04:59:17 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a630517asm8084557eec.8.2026.11.18.04.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)too few arguments to
 function
 call, expected 2, have 1 in drivers/d...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:16 -0000
Message-ID: <179500675586.301701.1674596041391478752@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.10.y:

---
too few arguments to function call, expected 2, have 1 in drivers/dma/ste_dma40.o (drivers/dma/ste_dma40.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/dma/ste_dma40.c:1695:42: error: too few arguments to function call, expected 2, have 1
 1695 |         ret = pm_runtime_get_if_active(base->dev);
      |               ~~~~~~~~~~~~~~~~~~~~~~~~          ^
/tmp/kci/linux/include/linux/pm_runtime.h:42:12: note: 'pm_runtime_get_if_active' declared here
   42 | extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
      |            ^                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/dma/ste_dma40.c:3306:11: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct d40_base *' [-Wint-conversion]
 3306 |                         return -EINVAL;
      |                                ^~~~~~~
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:7e4e6db0aa32ff882fbab551583f6825194c577d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  61c312b5c114d6e6f4e6a3c6685f001cfcff5e4a

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd8fc399c74e1a997d34aa

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd9ca999c74e1a997db95f

#kernelci issue maestro:7e4e6db0aa32ff882fbab551583f6825194c577d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
