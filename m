Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86E83D669D
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581038; cv=pass; b=Bs+uSK91wjtpT0x9NPxXUOyIJ5WWnRH41/5jE6b2HYXX7V8DUxs9h0IVhH9+eo4P5ZeROMszHEOLvU2T/gIZZZI66IFL5NR3WNGsTeeb4rlV7C98gnBrV92cbF4KPRzycfqljBUxZwfWJ+0dl9P1Ntl0Ucz1qCxIUysOE2D7Drk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581038; c=relaxed/simple;
	bh=QJQ4NjCwE66XT02iioTKX32pf9F/+INr+LqpJhuBU4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2ORh4S2J0Mjj0yP/XIBZ2TMcfuiHXoc2yS6lqkSUKoxiKm3WmljVQ2toPvsc/EOdG25CI6xszssVLYEw/vKyOtSGeqpRfu3u/o6/gV4aGDJyFpfArAfSNrhInyfTVuUD7JJgpvGqLS0TmXtJ3ZjFasegdwgCDYtykMm3wit2PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+34F8Vv; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+34F8Vv"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a60cb94b80so2972131fa.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791581034; cv=none;
        d=google.com; s=arc-20260327;
        b=LklqDwQBfV46g++C1sFkHNR6MpGevgqj4dRZ77gApa+TYtCRRCW0sPM7mo/JK9yI1x
         gyA5C9vDq1EBD4YB8X+bZmylQYlmUjlLLGGqROe73GkUKQOQhR+XnJyezWOPUksDRF0r
         1B8GW8T9YYqMPQkNOCiC9ImdsCnDNpLq3KzWBbh5p2EiTOqKIf02wf+Oq1nQDPWjxl/n
         SoVo3ZqlJTPh0fd7pJ/NRtgDuDw9EjDQbJ7eSaMEWml77Yvcwgxyft4nFTO9ZG92HEWX
         PWwQXCR0A9Q9hKchpuDwy9scFzCou4Pt8wC+GnxdSDRm1WRA/Mi6L7xty9tU6kXGE/7u
         oJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0WSRCUE49PDYeX1lwnIRvdxVfyb7jQkBCqEh4RPFRb8=;
        fh=EAuMfGYI0S58uKIfdGGYpV2ZDlJ8aI3rb0XmKJhbkTo=;
        b=MHOgn0GlwwfS2Z7oDBijVrd4hsmCUGoO8eigNMTCN8ikOvdjCJhhXtuVr2qoM2C/Rb
         RMY+0GnrjbxuUJqxjT1/WkPRD0xRiaXWqtKDHMIW8MY4ehpY08awEFDRz6P8apjUxhZ/
         MPrVwmSsbwL2KeCeRSRuwd8YU6OLKSp1BthvpFK3AQQDg6j3CpVxInmnndwZiCg/Ut86
         ErYRvEA8kcPROWkINsDj07+k5YhWTiRmL+miduZfzq5vUzp336jzKj4m7lyzSBcXxHnF
         Zbb9zk2hETT2zfz8LyOoa4rI9qlbbqCienGSk1UZKrqpM8wrnPj1ex9+6+sEKmZlvZTP
         jMXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791581034; x=1792185834; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0WSRCUE49PDYeX1lwnIRvdxVfyb7jQkBCqEh4RPFRb8=;
        b=r+34F8VvigRXQh2KB16ngQx2oQhmF1RTz1OyuX5X6c68cWdzzrolW/H/mMCUQXlj2z
         oBUz6hURy3qTX7Jm2MUjzpNoWD7q0kba270s4MPZushLkd1kuRLgH7VFOBqvvFImPS4j
         +6Jsb6Z4lx/Sn6yChRVwhmAO3DeBBZLm+iZqctn4L7LT8KhvJKvgK4BgztAEVSCv+XFb
         4yptLdRUaQJGwbyn6KIE9iactb81TFGqhMsLmgQJV2HzpD/wmViu0CsQ5+bic9mP3pYy
         KMqvBwVa53u9wHRZIDPEaLxzU6iYoI/rTNgu4vGJ1XGAud2ebm37Tb0HZu9jFL/hiHom
         ZbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581034; x=1792185834;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0WSRCUE49PDYeX1lwnIRvdxVfyb7jQkBCqEh4RPFRb8=;
        b=o7cyzvwGaB2HT7FJOXD9+6mvCBTLzqc9aq3/853NTZbz8WtPbhOse71XZa5kovZWls
         nTl5XNrANeqKxUQgIuRH10U0zom7RVeEfLLbekvIByVDLI0x3as2KE/YVmIbdVpkpP+p
         aq5s34Djj2r7adB1Es8f4+pJnNL9L3RzBRL69vrmiMij7u0JQZFxI4FWn4rR7iv1yAvw
         Nzt3GZN3lj34oDvDSLy4JxpUd512dqhoms6yiW51TQllu4e2ySnMvpd8re1lHeebN2ug
         wfqEQVP2sGue76FIU1X3ZndOhsgKuwPV7arDvExU9oIoHX/8HLU69t3jtcyJjsFf/j2D
         D9SA==
X-Forwarded-Encrypted: i=1; AKwUvBxpsQ07BKZ/n85MzKPJwSlVB1kK0nABLdW3ftFBqJS35+Q8UrDYlY7t7AeBiiMpaf/jzLye/Ro=@vger.kernel.org
X-Gm-Message-State: AFq9FYLey1Clv+vwH5JKVhLageNwJp+zAxnITPCTCfro3Qc1YYRubAG/
	2Nc5iC8ntAD/bmGEqcGK/2+MRBKrRJkB2NpkLXI5N6KmRof4QOHGGHkfWJvBzERcDJDIw2HDSOq
	tAhKqVqwqUvpc8i9xQo4NRErZdwJFwLE=
X-Gm-Gg: AYBFou1D392qeKzE/UO+LKRH/j9sT8v3cea8QzlWfMTvm2rRH0wxNnjvPsFA5oa4Lv/
	nDMIIqGyOEEVMTWB2q1DKzIzk1IdxcS+2nZxax8ifcM8vvw7dY4DxoeJmxLF49gC/hrqtz7S4FQ
	VfXwBfp1ZzBIWE7n3IX9OI8k1JGfR44+jLr77yVE+utotIaekFvvUfpFof7evUzqo3TWoVH7/Y4
	e8bG7Y8t+w6FDIuzOqnwm9dNuUYEtfC9NvRUjk23zGr2IfBOqmZh1mCUuMkgFPI5DhQy43p7O2K
	aqk+qE30GiLiGO+j2VfQ1FPV8QkAhmR6PM5KSg+rBC5dyNq3KldFFeSxe33HV8pc
X-Received: by 2002:a05:651c:b0d:b0:3a9:9856:aa8f with SMTP id
 38308e7fff4ca-3a9c55db18fmr9884551fa.7.1791581034241; Fri, 09 Oct 2026
 14:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926041943.1124650-1-oss.patchbox@gmail.com> <askjD1DxFvrV5ND3@p14s>
In-Reply-To: <askjD1DxFvrV5ND3@p14s>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Fri, 9 Oct 2026 17:23:42 -0400
X-Gm-Features: AclHuK9Oo9BEgQkUPo5pIErQItBppE_Ru1rb7SmpvCfvBKSwmVbbZBnq9jbCxTw
Message-ID: <CAGG=RgA04aBS1QkTWoW-yjMZ0MxB0x3bTM47_MZr-yK04DPDVg@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: virtio: Synchronize virtqueue teardown
 with rproc_vq_interrupt()
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 at 13:23, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> > -     list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
> > +     list_for_each_entry(vq, &vdev->vqs, list) {
>
> How is list_for_each_entry_safe() no longer needed?

The first loop only clears the pointers with RCU_INIT_POINTER(). It does not
modify the list, so the 'safe' variant is not needed there.
synchronize_srcu() is
then called once, after that loop, to wait for in-flight readers. The
actual removal
still happens in the second loop, which keeps list_for_each_entry_safe().
