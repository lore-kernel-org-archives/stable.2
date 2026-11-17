Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794940770;
	b=T5IfZdzf2AazN5JbZnqI090K/gX4ZH3NC+TmJT64D+pV3tJLZ/zxtRKSf/5y2kAGuKSX
	 LNaFpSOzHj6HjNtwrq8rNLu+bdKFRBThVJxX1zjbZBO2yfa1T1EJx9jOnXmQSxijDhLH4
	 BYjksthUuyFGX3HcEfw1YS1YFJcNI+NVJT5igP4BL8zAZZGN2efiNhB0m1nCxa7mZ8+cj
	 2RFetHgCbebLEK6L7CRa3yuvhLQKvfuFWnwuFU9tMaMypVnThxo11jOcOKGYBDa0h5xq6
	 VlMg1BwNap+90U7aO5JAnuXykeZvKR9GHPVdytEvV2EjixYQ4WwEiNFX+6W7AmVAajw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lncRKJb281LFN/OuiZfN4zyt8y+KUOcywEPbnI0NV+o=;
	b=VpePdRXbYhOG7uoTYsC0fBm9XepQUWyn5HS+C/UND/KTPNYHU60BgOA3Qva/mt3G3hTq
	 Jed1zH2gKJ/XUaEkPKeWF2lRMTEDXI0s53ydoazgXUNTrNXfEevnqJFmZ9rH+Ts6WmnM0
	 a/kaeRa1Ehaq4VZzxxW2dpZ3FqJvEcLW3yKABdZ67S7ITU9HiGj9M2PQHBzq6nWwLw8Eb
	 fDpTF94eoKkhEvDZ3lQWzyXopWs1rKwU+F6N4ssepLAoYDEt6GlwlEz8ljYtWoN80MEY8
	 qHsuW9H3BQxRKLMa5ed4dcFYktkhKB+QfMcBXyWRWj+bzlabQ9Qpgxs4cuX/SwWBL5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n5apFKsH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE85606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 18:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE85606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n5apFKsH
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4919a880834so55130f8f.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:39:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794940768; cv=none;
        d=google.com; s=arc-20260327;
        b=KIQr3YNQFKN2ngfkEHzJZVR7ry8NC7Sf4iDxCwebRvEV4ZqzI5raU/XhQqgwEPbb5q
         NKYKUK44k8xPLBxG8FVcShVb38V4kRVezHW3wSwwd85XTeo26/SgTl8a8RXKVC9EzxLO
         y8EFzZdKH0C9VVVQzk1Lpxb5UaMgH/wGm2ZEIDKvtetF8CJIEK9dX73MQ42w5BrVnWEu
         NY5Nm+tot+8zY5th2lS7mAfC3Qqwf7wW/eHkH2kzqq7Tfc23/OwChdLDkrb/vmHV1xUH
         t8yquIDAI/ZD+pSfgYnPluYiN20jqtnittHsr0BIwSV2vrKoYQV8i2nylqyDpZPW80LF
         0SLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lncRKJb281LFN/OuiZfN4zyt8y+KUOcywEPbnI0NV+o=;
        fh=ndu0CWiM3OyXHNv5/+Gkmh3MIw/+A1QTDep+MB/HVh4=;
        b=hiYhynJGN5GJSu7LAIUrkQvMdzIWlO3t9Z2/eS2d7jr6vdN+jW5iPsyQ6NggAw5JPd
         FZemBIJS7JRQ/yab2mXzMWequfFR07oYesK/nSCtXCKX8GiBHPqFjgNSTYq72kwmjzwS
         KRkTSO5RfMOEBiWNIOv42vERj3XNcovepXujwjHG9X/6tj6rPwMSuybVZ2Ip+ns69d92
         eq6w/JGu4/nx82YOSq6FhjKMBFkUNck4qGHfThh3uF8Vk6jaQB27a4KOPN3BD8NC+tLU
         lbMF2OQaC3AwOkz1lCV7T8Q8PNlZawIZO44iZD2f+QfY0kMbj2fBLQR2DewpkHZCABEn
         34zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794940768; x=1795545568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lncRKJb281LFN/OuiZfN4zyt8y+KUOcywEPbnI0NV+o=;
        b=n5apFKsHwf1RkT73La0rNipFlNdFAyw3BALQ03opkhnzeT7XyhW1iksT9yArmvpHHY
         kpx8Dru2j5FSYl5ka+rCZmn+gCR3qiQJBQSInOTYAPc9s4Jt/QnNIGuBasdFnevNnvLE
         n9ALa2OSeEZEbFrDWZr9iH0a8sgmUroInfZw3/rCo9A1ztWfjYLIpBj0JS1c5P4kf3Ls
         wg4Ma2ddvz2TB9QeE0IvcTKLiAFr2gSU8Fmq9+K0u9smaJyTiN0q0zCPo38nKT2LXbHC
         5BJkQLiUWPSMdF1i2QB3ImuhOFCv5XOxM7FjT1ZdeFG3G/sKPxt3rq82T3Vqk+VWus36
         GynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794940768; x=1795545568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lncRKJb281LFN/OuiZfN4zyt8y+KUOcywEPbnI0NV+o=;
        b=UM5B9HBvawHYGS7i5CIOyZhKLtjgJz5F7NiJlASFe7Qx0AN374Aq9Ko3VZKW9FW9Mz
         sSEdrJJY6LR+HdJVe2/wJtAiN55kCrMq+nxyDkgS/8hVGHzgOPCM9wePx4wwMk62ASQF
         Rlux0WeA0jYon7FSUWmYn9dYZR896iy4fK1yTHdsliyidZ0iCVwycKP5tJm9kg0DPnkk
         YHHNbKJ0prfOP4Z43dDv2lRS5pUK8rxzMvWBpoukmYjkljafTOCARhWqtOs3AVtWBNvW
         mRkpinjHV2Baxszhz4ySeQ/zbKlR4QA7gqZVJUkjfNvsvL/NxsG1mStAwIS7Wg7HVE52
         fp4g==
X-Forwarded-Encrypted: i=1; AL+hErGN4LWgwfmOujkdl0ehYRUH5JePNslkcwrnt4YrHmfmaiyDMpRgPVUwYUpaBS1g7vQxMIXXZAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YQGuYRw96ofOEiDOZKEtziIrVQ1e5xqelACYf8D+ozDp1VFbB
	cfZ4V5NaC3qMrY1tV3+pLVoOi+bVdnyK2iLi4QZ4YSrxgI/vZIIz7pOyvVv17qEiQNrr3zOgs66
	L3xugLMOlI+pjkoMTK9BrdYI3ioMWbt+YCvnyVgiB
X-Gm-Gg: AZFdTZdIPBLZ+avGSTupnMJQW7LdS70kBgySujXuCbLNPds0agcAEzahdBuV88fJdyc
	cUKLgQ4pZOz7Teft4RH5l4k0z0bu1ckQ63Dp4qvSavBpCEFJIgyL0Z6GpxzFSRehImkmN2+ZyWt
	7wHtyu4oSspj0H8PjW7jFBuAIUmCTaDcK1Rx0nvxGFPYGYaCAX5ZQd/pL3QUbqf74X2a5qzRrnA
	Jz6/74jvrsxZtvUpaLh0k3a3Bro2zlMpVvht3tcA0OYY2sk5pNo0mzUptAdJBteRVIgKgmEFVax
	G5GOU+HMdktT1O5pXBfGt56NhSA85TPywIGcVa09CzWzdhWQL6gted6ss3AxLQaWzhFm6Gb4va2
	/SA5rlsOEKakw591vuD9li9uFyd710p2+vCsZIOoBtRho+RhYE+n+VCQiJHOhu2SfHGziHwmgky
	tMtjz/apY/q7zSTC3BSTsXF0XJnAPpu5YZfAJihJIb2xIklBXguCAK7QdrDn3ym5wJtihD1W4ZZ
	min9pyPpIjzO4k1gaqYONoCEnu7bNfvmkwNqw==
X-Received: by 2002:a5d:4b41:0:b0:4a3:8b21:51bf with SMTP id
 ffacd0b85a97d-4a63f182f83mr533473f8f.48.1794940767380; Tue, 17 Nov 2026
 10:39:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org> <20261117183043.GK1813469@noisy.programming.kicks-ass.net>
In-Reply-To: <20261117183043.GK1813469@noisy.programming.kicks-ass.net>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 17 Nov 2026 10:39:15 -0800
X-Gm-Features: Aa3M54pKRYI09jyRw-sTO4FGJp-XI-xiu5wM8zF3drrRidtrcRZTdo0aa8zBllU
Message-ID: <CAKwvOd=9pjhCnreMvoAH_0PegYg60ouaZL=BAjB242bE48J23g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/topology: Avoid unsequenced accesses to jiffies
 in sd_init()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:30=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> I don't speak enough C legal to actually understand the Changelog, but
> the actual change seems daft. Is this really needed?

I would imagine a delta of the disassembly here before/after the
change would make it more obvious (one less volatile access, which be
have arbitrary ordering between initializing other members).

But I guess I'm also curious why jiffies is defined as volatile
anyway? I thought the usual guidance was to use
cast-to-volatile-qualified pointer during access, rather than declare
as volatile?

--=20
Thanks,
~Nick Desaulniers
