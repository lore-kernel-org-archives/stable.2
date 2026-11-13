Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548047;
	b=MDvo15GKDo5Q3YbkjS2/a6RJ4WBUq1WkwBJDVsvNKZT4TIiC120me+aKJbv6aeJo8vW+
	 FV4gJp0vR6pd0/bG+Ll5Wzqp5UtWOAi+eh6QeAgXqa0oZd62PVZObqeFJE2iW8pgySNXZ
	 sOxfLL8BntpmG3FYGjh6RJj+tRjpmz+KwBU9J1PFrfi6UgSSM0rxOf58xq6BE68sceKcH
	 GCO9feYeHN/psjs7da7mQzepUiAncus8wcMtJTAXFAmdUBepGTq0jA8UhbeJW1dG3iwhN
	 eV7q+rybnQ9cUNrMDy2CcV0KWSsIDSk0xa/2xa1GqI1Ck95UN3pM+bFq3cbuVoE34EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0m+xqvVXfwi6bGLSM3IcTuTXSdD1kmi77WYfUfwTd10=;
	b=DtdpFg+5SrwI1Q4KNBPw4ETg0MIlAcGnzFnrXQWfWy2m3QUcXM2XzVDLbHYM6sYe6ljo
	 3mvFkg4EswlBPf4oqnCyXUfyWao1r4s3vyNoIaVLwfIqjTRcQo+bMtWcWZLoC6cjUxqoJ
	 B83L46cCvkfANxCMuYmXihc+IxRFcGI0vHYd1iOE0miEChGidS66bEgWne4ZSQIJU5gL+
	 EYBY2iBwFd4U3t8L6doIfaN+yOzj5Fp11ondy1ak60tk4ZbDOD3RmR0VaYAjCzdWOd6SY
	 M2tviGrAZmj1PTr0k9CTwx5ukSXX2jvvV/vehhhSIK9hQgeXFoXAa5vmnARtIhh2Zcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jj6AaXJk;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86660A3804
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 05:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A86660A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jj6AaXJk
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c445c95d553so98097366b.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 21:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794548045; x=1795152845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0m+xqvVXfwi6bGLSM3IcTuTXSdD1kmi77WYfUfwTd10=;
        b=jj6AaXJkRT5Pmfv6+IAZFmgZBvAkRdhZvvDMusvAuSoy7vHwcRfuzladEBIIChmNXP
         S2as7G55BFAlkrRJ//fSIuwPU7wYEnAxERZHxNAncyRt8ht//gRNruJMTs1ZYeWwawqq
         4LM6Dx6bvfd4gEy4/imQOA0ZEoGm6ifeQKp2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548045; x=1795152845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0m+xqvVXfwi6bGLSM3IcTuTXSdD1kmi77WYfUfwTd10=;
        b=vG45Oqj4EfXOj9qlaB1wQrpV+fKJalsu6fixlz1Mdc8uY+piXVs0J5rv4LQYFL0lID
         KYGGg7jcMOQDu99bgG6nU2AHoddMFAk+XaN0CYZ+w2wQXqlsMJP8YVN1TTChDEVchYD1
         xEpjJUkhJwBVBUwr/Xvx2eJEPMSpteLRjFbIa8JAXQKu8lcImydRFbiauKSiGrnPcpNm
         SBXDKPRgnfNNYkm4plHMknMN9cLQ/MGurrGLxR76Mn2SWxUdjUlG5k90e9rL0HLf0aiE
         VG83oJrChoa3PlOtjEc8ToEHcWLhYQeadmg6Zsca6qhzY0NygofVakOvH85LMOsxigPA
         97Hw==
X-Forwarded-Encrypted: i=1; AL+hErEpeMaWtXvLnEtP7k+lIiRFHsbfnO/rbnrxaS0PvqS4aAVe78OfCTqkeS3A9LafCGzLNFdEIWU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sxw4miWkCeH2jE6ZE4CdCRWjSRCUbQxVOTPeiQbwjSHnOI/lk
	91ABcDctSTA4SNG4Ds153mVokMh1NyM2H8WQuyy9XAMb4EauQl/A3nGFV3BnIS9RHoWGwwzkr3U
	LLzuVura3
X-Gm-Gg: AYBFou369S8YIyinYP6uSnXHe/4TEdkzFsC+Y3NywRgB7sJJCDl2bEQb4WezIDRQ4zJ
	805M8V4VEO+98ReG5XJKBJAjZSfwUQns2CUr/RYYwt1QwhESRpnpPHSVbmgTt1CBG3uqjNLDyvE
	oLSQAhG+6RHn+V+A3/zl+kKMIkbw9G+fmLI4wEN9GE4QCAU3yBQY9tD5xqnN0FimjzM0v3+6bQN
	+KK4DrNQS2wJG786ogB6FEvrjOcMKSl+ye2+t55FQaGLjpasVq93mbyNEcMxNiNuFg8EdP+oiDZ
	aRJUTIWljp9ScWI04L3iekqoqTIhqvzCxfcxveypUQLDA+pcBVbOuCjukOw7swTxEP9+lYq2Ffz
	8h7QlOFlc5uC5XGLGl439oFu4wnZAIzF4BPZkOAaYML5wioPl84Pepjh+68XfBvBqAdSlgWgnEO
	R+10HTU5uOU+JF6NJDhr7/UabWM4e243F/HXEUdThlpxiAyEavzQ0Xj7MEFWpYeePXL/OPqplka
	yRcxNnnKVTtMGvhC0aVLqrFUvpAbD3QqEBKdyv/dY8LgKB7ZImUtCwFK1YTv7+WHgEN+AdqYrTc
	t0RV+kZDvmRcmJTEdGuXpUm51p5k3iZm0ibNq1roi+j2Tl7tJ9JM6JhdAKRjB/s3rgzxeA==
X-Received: by 2002:a17:907:86ab:b0:c3f:7270:10ab with SMTP id a640c23a62f3a-c50963398f5mr99706866b.14.1794548045624;
        Thu, 12 Nov 2026 21:34:05 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b59398sm51271466b.46.2026.11.12.21.34.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 21:34:04 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-49134c8509fso548800f8f.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 21:34:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHN6hOo2scNyUuYq3otR8lnbC37aTKhIvk/2Uz0kNJXhaOEcWYxom2x47jw7M7Rq+ZT1Ij/0ww=@vger.kernel.org
X-Received: by 2002:a05:6000:46c2:b0:48f:db47:6ebf with SMTP id
 ffacd0b85a97d-49c729bb31fmr2136437f8f.38.1794548043513; Thu, 12 Nov 2026
 21:34:03 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110081946.38783-1-christian.aurichzm@gmail.com>
In-Reply-To: <20261110081946.38783-1-christian.aurichzm@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 12 Nov 2026 21:33:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XN+oAR+sgS1+Ri+GkoCK3gLKEvGM4RQ6RorpsKjsLO6g@mail.gmail.com>
X-Gm-Features: AclHuK8y1Mn1015o-m9cW0ZwT98Hu-8_Qa9FF-4FegCdyW6v_68cpgBnLgAX7B4
Message-ID: <CAD=FV=XN+oAR+sgS1+Ri+GkoCK3gLKEvGM4RQ6RorpsKjsLO6g@mail.gmail.com>
Subject: Re: [PATCH v2] kgdb: Fix buffer overflow in the qfThreadInfo packet handler
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Daniel Thompson <danielt@kernel.org>, Jason Wessel <jason.wessel@windriver.com>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 10, 2026 at 12:20=E2=80=AFAM Christian Aurich Zanettini Martins
<christian.aurichzm@gmail.com> wrote:
>
> gdb_cmd_query() answers qfThreadInfo with a thread ID and a comma for
> every online CPU, 9 bytes each, followed by the first page of tasks.
> Only the tasks are paged, KGDB_MAX_THREAD_QUERY at a time, so the CPU
> entries overrun remcom_out_buffer[BUFMAX] once there are enough CPUs.
> On x86, where BUFMAX is 1024, a typical boot hits this from 109 online
> CPUs (222 on arm64 and riscv), and GDB sends qfThreadInfo as soon as it
> connects:
>
>   BUG: KASAN: global-out-of-bounds in pack_threadid+0x2a8/0x2e0
>   Write of size 1 at addr ffffffff86eecc20 by task swapper/0/1
>   ...
>   The buggy address belongs to the variable:
>    remcom_out_buffer+0x400/0x420
>
> Page the CPU entries together with the tasks, with one helper for both
> loops, so no reply holds more than KGDB_MAX_THREAD_QUERY threads. The
> CPUs still come first, which scripts/gdb relies on to detect KGDB.
>
> Fixes: 25fc99991383 ("kgdb: fix gdb serial thread queries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gma=
il.com>
> ---
>
> Notes:
>     Changes in v2:
>     - Move the shared paging code into append_threadid() (Doug)
>     - Link to v1: https://lore.kernel.org/all/20261103190622.925741-1-chr=
istian.aurichzm@gmail.com/
>
>     Tested in QEMU with KASAN and GDB 15.1. Unpatched, connecting GDB to
>     a 109-CPU guest gives the report above; patched, 109, 128 and 255 CPU=
s
>     return the full thread list with no report.
>
>     Based on v7.4-rc1.
>
>  kernel/debug/gdbstub.c | 45 ++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
