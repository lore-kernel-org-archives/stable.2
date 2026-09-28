Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18620378D74
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581142; cv=none; b=Qu8ycdjmrlgniWAYA+AsS3kG32eo4D7fxuzmpjdC9MQwiHZ8rFmYtlADOOtLt0iSKILYcHJTb8p946PC4GSwfMcMkIJKIqZy10bd5YChYwbfF+vaqRV57bmlkV/RN0lK6atmmc+3IwORt3M0Ox2f4aOICFJP9jwAQLNJ/lDUzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581142; c=relaxed/simple;
	bh=JYguKpWYYDdj85O8UNrflccHJDrj4xz7wT+IHO0o+TI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=epSAnW6e6pTnsNEa75QVjAtMqXVijD70m+RnnUgPHb6bQ1FG7yM3a6fvDFV1QTpE1RxpMzrU2bYnCSiucDKXMpmadXilgbIWniANP59G2V7EhtW0qGaAsNcpmWeXslgxoKtO+7IDtxXHcuKTLYf2y2DfVIdZg9AhmaZIdx+w5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSxOnD8+; arc=none smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSxOnD8+"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso16889065ad.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790581140; x=1791185940; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NrMGPZQfXAem1w1eTjPgNNpDrfOCX+chlCVcm7+bkR4=;
        b=CSxOnD8+FAiM1CguoaAzVBcp7KirSRa1BsTjvvt42KqpJ/9y5hIF4OSsxiqNEPKoLL
         f+LtXK0/nFALt/2rOrnnXzzq4D5g33A+HfiYMgIAECXgyB0avC1LMjtNPv/Sv0iUsDuR
         Laz7KJHY1h8fMh188aNXkeD/7OJnZO1Z0weHcZS7e6/i4nXSMfYDYArKuC//4cYmLMMd
         fvPXwstO9Sr8E85AA3zR7tTvGIhwPNxf63JWLzqF8wMcCtADl9mSBCmTxwKVX0P4hJFN
         kq6T63Ccmkg6YOBNRctP29Uh7x5yxc/AA1mjaUgnPlzXp8MncVCZqVJuNIhnZLBe9IR7
         vYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581140; x=1791185940;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrMGPZQfXAem1w1eTjPgNNpDrfOCX+chlCVcm7+bkR4=;
        b=fdt738kG1r+ePdNzf3Ck3hARRSVIPje0qs9HmTd/E8bfZBNgvCzjuRYwJpgWMEQ6l9
         e+HasUIjaYnRNTxuMILsHF1XXhy+cB4fhrSmgVhzzI3IvBSA1ap/2ppetr6jQaS/DGxk
         haPxAyyJpXSr37xFwo9goNm0/ZrIFdyE/G8OM/IqJiRGH/B7nO+8Bjh61+wBt1JWd+pN
         Le9IH6bIWmBAOel8om+wKdWqc/oO/CH8Vwdj23a90VBJVOmoReWPVlrIfLbIolkWmJKM
         5uQEVHV0y7v8UR4RaQd80M/vc7UAXVW3gwBfU+FX5xw09dD2UqT9CNUiyurkDayD9wXY
         capw==
X-Gm-Message-State: AFq9FYJQVxkp5i9vVXsyKPQxYddj849cq2wr89eydJAXr9Cu1X/05IT5
	QGqNzYYEdiIVqZEakHDh6qM6VJZG3GXsg+JIECZs1Nuj/w38t7v0W9bV
X-Gm-Gg: AYBFou2xWXJ9f9rkjeeS4cIeKw0VhoRvc8CR7AAg+ckn+f2cAoOhjuEvZeT2w1ZIjoy
	7KSzZxjwQJWTKJNyw6I1KvR4IxuO5kOnbbXRbMot208T+yVCc9K2WnrAHB8TEgWeuI3h4q05JoY
	mZ1Owr0Yj/Dk4MqyB6a732IBXSSQtUHO70GsmqQnvyQROROLuMIO+qB83SmeUDjywbXB+SqIoHt
	NKssiCQerQVmrf2X2EIyjGnvecYgxHPpqmlyoulXIMcnTGA+tFS0qom/DbyQmiMGZqMEfZ8sHLh
	lm2InUiLPtSCRw9wauzRk9368BfdwYCElgWH1CssiEiBJtx2yVtztXE0FvYh7LlQg55aYivPou2
	KH3Um+x/CBAdzbEpNtZi2pZLkymwHilSBRbu6YeA0i1k3BSbPX+BsC05SzG+H7E4Kl3j7/KjbL3
	f59ZFpQyXCURA0gGp5euSqL2g2g/zOsYKJdfxC50ifkc52HU0CMKxZVp3iOZWAWZF77+VfHgJ4L
	740Gshj50N3oyG/f+RL/obj2swNLy+Jm7/MWZ4lN33lEQaKRA5F8mjqVaRjwyXS7pFSRPMsS2sr
	GHHO
X-Received: by 2002:a17:902:fc4f:b0:2da:f7ad:cfea with SMTP id d9443c01a7336-2df7dd76871mr98510165ad.8.1790581140234;
        Mon, 28 Sep 2026 00:39:00 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91444763sm36663265ad.60.2026.09.28.00.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 00:38:58 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 07:38:57 +0000
Message-Id: <DLQS1EUNZG5T.1ZCONM8DQM45@gmail.com>
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH] bpf: Initialize IMA hash helper output buffers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiale Yao" <yaojiale02@163.com>, "KP Singh" <kpsingh@kernel.org>, "Matt
 Bobrowski" <matt@bobrowski.net>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Roberto Sassu" <roberto.sassu@huawei.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260927121400.1188165-1-yaojiale02@163.com>
References: <20260927121400.1188165-1-yaojiale02@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, Sep 27, 2026 at 08:14 PM Jiale Yao <yaojiale02@163.com> wrote:
> The output arguments of bpf_ima_inode_hash() and bpf_ima_file_hash()
> are marked as ARG_PTR_TO_UNINIT_MEM, so the verifier considers the full
> range initialized after either helper returns.  The IMA hash functions,
> however, leave the buffer unchanged on error and only copy the digest
> length on success.  A BPF program can therefore read stale data from
> the untouched portion of the buffer.

That's not a bug.
These helpers are available to LSM progs only and LSM progs
require CAP_PERFMON to load.
With CAP_PERFMON the verifier allows reading uninitialized stack
with or without the helper call.

Since commit 5da4a9f26fca ("bpf: Preserve stack initialization for
generic output buffers") MEM_UNINIT helpers don't have to write
the whole buffer.

pw-bot: cr
