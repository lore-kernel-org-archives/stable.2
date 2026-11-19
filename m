Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067688;
	b=e6619q2HU+eKHNA9njGYE5XgmYZd+IXG1+HI5kuP8SYjjnPj7gdDZoWzv22xUvD3XgSt
	 jsCF7UHRMS6MBSPIiZPc8rryMnRdfTLpSw0kXG85nbu7Zvk5nkvF9CTboZoONLlWfLcMh
	 wdkvmvN4VqtVrOcZZZ1X54Do6+ZjF18Mjv1nQ7bFRCLltM7CTfBvI/Txwyv4mHBhN0tDf
	 X36rzXH6OZGzscw1kFG20wfOwHRdet55f25OQPfKkV0Zm7E8CT+C5vsiX/C3XTNpKEAEo
	 DturD+fCvX7uqQqnRmYy07+y9x/srqfxjUtbuXvolrcPg8jTQtasIgOSL2Nz8ryrc6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=2wXXFuTcJDjo7rR6+VPIW5IMj/+AQeeJztZyV7rgklI=;
	b=iohpPFCxtrl3tiu1syFUWgQ0tGxyVdagWHqwvkHWWbpjaLw6G/DHZoeH+VbzBGJ6u1hX
	 vDBHXAypE5BwQoxJxS7eHa+I+lEy0/xhEhpEzI9phrzfcf0LPeUGFGgGQKIe6VKC3WkLR
	 FnlSii479XM/pAkN2TVHtwpigzRrGJQ0VvnReQbv92tIhkaw5bm0IZRDcn+9ttxN2Xnv2
	 9nRf6vDx2GEtfzVi8bICrlO6dkUqRYVCX2L3mTkdIAOyefFyyCUIYg+377wJjs1v2IuY4
	 HlfiqtAtZ+2eLRvIfdeYBPqCD15GbPqVOtsS2zeZ+xraxxUut1qK3ez5tzq3McOAtpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNjfbT2K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B3606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E55B3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNjfbT2K
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-92110499585so17736646d6.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:54:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067687; cv=none;
        d=google.com; s=arc-20260327;
        b=g7dFW0Drwpj7zSk7DyMa4bJh7lbyHQmKG55dpLLZxcDFIV97fJK56AlZAASpGgWpEs
         9VSHE1JyfPcPzjlB6+2SVC5/mNsTZPElyB1q6Ua3Tl4xlTDInJzq/zpZqUgbb7gJlEWo
         343tPHje38ab1PYggX2DKBHn3S7syxOkpriA6z17s8sGKroO9KAOCmWzPfFlZrv2FaRq
         90s+ukWDp/se4j9bPbJUlflj7JgygpmCoscvSeB4TUUxg1Ry+36O3/mL0SvrIUjSV6SA
         213J3Y69j4ETS9t9sEI9W3OwOaJ+D9MnH0s7hTru6+Z7drMEwf1IEGz+UICOjQTTgmMB
         qlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2wXXFuTcJDjo7rR6+VPIW5IMj/+AQeeJztZyV7rgklI=;
        fh=hh64WXw32xDCPRIwo8kqdpPDKtEO7rcNvFi6kTS088k=;
        b=iM+A2K1ZtD5EJRwIE1VD2yWl94hoKzRxj97/v8Gc7Dkn/rnNG4tX7hbTlISCZ5SjBj
         CInwOEbkBpdNdhe25enrPjci2kYz82MDkOSJtKzXpSsON7DmOm1hy3Ge8mQ/X3bFH+aY
         3xtJkl05SfBkIQ/Bx/G6SvjqlB7eewG7nInQWnj7+90xLjqwtFJ68ebplkzJy1Mqkzga
         PAvA5vM7N50ZqroLSM2m5/L9f0ktfKl83YXAXw1ggO+YpkjBgNzDVsJ6lnn5vcFN7sAo
         3oZJuwBNRbKteK0H8R6qEuDiNzEgiJAnB68zW/12IFIY1cTJWhpaavYok4++7vmIv7/o
         U0DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067687; x=1795672487; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2wXXFuTcJDjo7rR6+VPIW5IMj/+AQeeJztZyV7rgklI=;
        b=kNjfbT2KsYxh9KCeLeMMebhEDcSBb0PkAblsmhHIBjncr887FqFV+zOuw3Q9hKQULI
         y2yg31MFE3AMRDiLMbzL/BgdMbLbZ7KNo66DpXaXFh9/vRy6VBDfFChIQOp9/gngmOTx
         DCRtDRQey5Sk5V4Vdbg7oDx1rOa5cg6A2HczTwf1Wz7RY6heL53a1pPOXio5lES/pjHU
         E5O2dMRy7GWpCH7TkvBqbVKP8lRDcqla1yHNrtuccSuJ4cAhP9nQpuB6wQnDQHCjt/j7
         7WU6+/u8rLgfFNRB+t337D9wyhmjTPO7mfN4Pdis4fccWtOvtRtgd37W8zfXOufJXKBh
         Um2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067687; x=1795672487;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2wXXFuTcJDjo7rR6+VPIW5IMj/+AQeeJztZyV7rgklI=;
        b=rZEvIInksmF0Tkg6VoGvN32ifaNSsuQLk4lnz7XfS7jD9+65mO4094pxXLn7+N/jZ0
         l937CltO5xsNeBRjODhG/7JjKdTt9sn+drel+XL9fx+g3qLJ0TeXFiKJykqnksnnxIyV
         bQrFQpRcJhv0azIvuCItdUs2Z0resCuVZEvLGrYhMmHjBwbKjmDYtGUu0DJSYK1a5Jf/
         FfaRgfw+K/CUkPz0mJQMgia5ZAl/3DVwMS1dCyb57CR8wCmMe+GX62kN66SNQQKhhYso
         lEgv3FIsMxEQMEQlLhLA+S6hGQcZz3irmafraec6UBjdN97nNsZ2qVYu9SBoiVjCTkF5
         MJTQ==
X-Gm-Message-State: APuU4Z9MGfsRwN7vKszy9qa9zNtmb6U7ZKoRaTd2qmtSo5yd2IX1A9vi
	rqZPLf4EEVPCJDAyBxSpzV9sKySWvzTEfDuAGjKaAE8s3wxSHH4suDFM4gNZmXu8O63WYm3B0UK
	s06TlsDEgjo47wEnFMU3RUH5VIvgf/l+pCJFULi75RK3O
X-Gm-Gg: AZFdTZc6ZjNKKcoAJnM8MXiOGnchcjatImQes6ikrFonDfbnCo3fzRRpBLm7gfLaEt5
	NAviYx3usoSrxz94Ri+p147QUizQqwzo/lsYlcbpspDz4OrOZxUB49Yvi1WWU41EeYtTa62fSjh
	U0sK1q1urDdK1/Ji/ttpkN2C4cHhk7LAhAAARMoq9yTosi/PeKTK0qafQtYEbpEfSYtnatZr6PF
	jBeZBbmiNerXy1Iqzgd6ZzVo2APIDy0c8bcmPO+s05lXs69UVAAmO5kXgprAL1BGXaSlHEj4UEw
	HuClpuo4Css0pYCdsWotyvrtfm9tHYsk/Vtu5eEZ/YCoFVwEH2MXhVd1A1MrCpqdbQy4g1su1lA
	Kvmhqpsby/mA3wJx4RZzrP2lWEDoUP5xJy5bwQzOcxz5RsrAm3zJcINhmSY/6e14F7p2uC4jReK
	VufVA0zSYDDK2GAPtrb7E=
X-Received: by 2002:a05:6214:c26:b0:921:2a5a:658a with SMTP id
 6a1803df08f44-9212a5a6752mr10383876d6.54.1795067686707; Wed, 18 Nov 2026
 21:54:46 -0800 (PST)
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
Date: Thu, 19 Nov 2026 00:54:34 -0500
X-Gm-Features: Aa3M54rooANSh0wfNk0OqAvnMXG1PqYBJ6QADkFC7Bv_KtJPFMbNTbyXd-BP-YI
Message-ID: <CAMcAce_2g8TiPUZVkexmxS3A3YoAFy5Tm_87nXUGWW=z+gW37w@mail.gmail.com>
Subject: [PATCH 6.12.y / 6.6.y] Backport request: 802eef5afb18 ("bpf: Fix
 memory access flags in helper prototypes", CVE-2026-45903)
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stable Maintainers,

Please consider backporting upstream commit:

  802eef5afb1865bc5536a5302c068ba2215a1f72 ("bpf: Fix memory access
flags in helper prototypes")

(assigned CVE-2026-45903) to linux-6.12.y and linux-6.6.y.

In both v6.12.118 (kernel/bpf/verifier.c:9403-9414) and v6.6.162
(kernel/bpf/verifier.c:8870-8881), check_func_arg() passes
`fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ` to
check_mem_size_reg(). Seven memory-writing helpers still omit MEM_WRITE on
these branches (bpf_d_path, bpf_skb_fib_lookup, bpf_xdp_fib_lookup,
bpf_snprintf, bpf_snprintf_btf, bpf_read_branch_records,
bpf_sysctl_get_name), allowing BPF programs to obtain write access into
BPF_F_RDONLY_PROG read-only maps.

We verified this on a live x86_64 QEMU v6.12.118 test kernel using compiled
BPF programs (bpf_d_path and bpf_snprintf targets):
- Unpatched 6.12.118: verification succeeds ([LOADED]) and writes into
  read-only maps.
- With 802eef5afb18 applied: verifier correctly rejects with -EACCES
  ("write into map forbidden, value_size=64 off=0 size=64").

Commit 802eef5afb18 cherry-picks cleanly onto linux-6.12.y (v6.12.118) and
linux-6.6.y (v6.6.162).

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Signed-off-by: BoBppy <inkxiao12@gmail.com>
