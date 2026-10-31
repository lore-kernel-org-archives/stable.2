Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423065;
	b=C1Q+ohkCnNf5PqOjMKA7OWSkQeLr5RcyJ8PUAoACSBefVSM7nvPMLwToULR/awqrSOF1
	 XF0LXjgNsyYVKrafOSHlwb+OURwtPtrs7Ywln/VROAh+FjbOiOxinBLS3smfjk1WSUSKo
	 dnUcSaQJOMwvurXIRwjdgBubPYdMMw4i5A9iRI4Km2y1p+QIHf/NM0/8tNCDKtbX+3rV+
	 76WbTN7qSTIx+BF9XlmxoNJQ9Y4T31euuudGHKhEl4/0/hIZYSF2sikaXL52f0nFCWikH
	 nV07Ck/KzbccNAsBP3hCDONzTyJBw9QvNb5jVUztf6D+N9qKnK1mTAibBV9WkxQj/Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=l/QI/s2Simd4NlurOX/F3MX2RhfnYDNXJZycRfomMEE=;
	b=ae7tInUxKBGBsGApsBj2iBU7FBYB52Cm1Gng0j+S6YJ4+mUfxjdU6DVCd5g0UWVRQBLV
	 mLD1f/4jlgqWQDMcPOAT/FL+OWbXnYnGTFpySM98Agz3Q5TmZ60j2e0GMZbtd5H6mp5uS
	 KbDOc0YU1dC3EObpx+di5PKMdz9DTH5uBfjv1G7GOiBdfamyui+AGBurJDrp/OWrbbT+K
	 n3yDJloYo7C+3morFDyKI7QegT+9hbQ6SrYXqMYeSiIZ0zFq1cObXODEFZLEbGnWfqKyY
	 DBpbMgdCksMKucfkb1rSIMru6aiqrxuRdBDGo7AccXGaCeeQgMiiuXWYWkx6uSP0AWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIPoNmO5;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3B606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 05:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80D3B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIPoNmO5
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a058315c79so728567b3a.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 22:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793423065; x=1794027865; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l/QI/s2Simd4NlurOX/F3MX2RhfnYDNXJZycRfomMEE=;
        b=VIPoNmO5V1OQxB4l6O1dkqLBmvX+zk2rhrYb8YTB7BWlVPpY81tN5t3t1DZiqLjFZ3
         +jeZKnhEBsyjy5VX+QPsS1QM129K2JXu4wMaKpXOa3lhG+igKhCAW5CLOzcmYa3ghAN3
         jNHlbsl02hZIA9OwBOFNCX9fI/ASYXdY48JZK4jkOJELBUZbxdMpHuyGL5xgE729QJ0f
         1MtlMDWWCB5Nm8iA0D88MdqEnpEVv92cqvw4+cHvmI1SAg3nPzsxYzAd7g7KfpZpl1Km
         5Hnosy+BXODAwLuxyYatdlfKNlDzzmarjAJJagEndOf9EIA7uUm+vTybobJiNwnRavPW
         wfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793423065; x=1794027865;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/QI/s2Simd4NlurOX/F3MX2RhfnYDNXJZycRfomMEE=;
        b=DUQQDeguxsw2tGszNpPqem7pXT54iZocmOTyPJy+WwwKW75sgE+Ofj9X0Kmh/Dw4OD
         R4KdydlPu5CqSCyaZetbkrgEcmUOG0nhBChiBOdXGSgcbc42kRr+REk51syJOpLD1JH9
         vnLbtUUh7fYZ6c+XSd/bb0siJyZMIbU4T+8WriLHRiMf3DUqvkRMCFe4ekIm7QzhVMth
         QNfzbzq2+7HyaPaw/wnZbYFUIxB4xLN+dJT0nZTnS26dtekfhDIINdrVbFuDyh+sdg7L
         bebSEMnjRcK9m7o0o0i13kg1aQaJ3IH6TdZrXcjrn/IuZuUaxad+k4DZQaP0OpaSn5Dp
         nUPQ==
X-Forwarded-Encrypted: i=1; AKwUvByZrSlSg7Y4ScZgWWSAlLnk6uMwwzj35ofqmm1T3zwXfFQNCtWG/MmIOEAYv7kFq6r75h0ckK4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUNVWbKYnYuCIWcn5ub0ZhnSHMfSLz3AP0FIqvRQsbhj4mulNZ
	uVCG0bueATAAmFifj0ZvJDYCC2Cn/5/mlDSKQ0yl8qShPcTQcToZF6dZ
X-Gm-Gg: AYBFou1hU+XyIevDfX/4djQ1rZi+6i5sRNjE/HVJd06pkW9mvkQSp0UrzEXDmAzZlQs
	lUvTKWN0UEYe+KmXIkbkP++DN4H02J0y7wFiiAmIOnNq6QjE3ZMu8lilLQQbymphN34ZSJic6fV
	ekiJBQ10d+G29FNL85+74yKil8JZVuTOhgCGayhLiB7M6m6eeg7tgX3GLW8R7NX6ff0nY/6YdnK
	/3wqK6ub7xFIZsJwvyvStdIaIfDTUZUNc86e5fCZ1tw/r4/R+Fkuf4BM+TOItrZXVGaqH/K21jc
	gXblSPHibhKQ0dyx9h2OTJFZAj0OPX01dor96HzC7WQZHetv9n0sYBOX19ny1kFvSKUMJroLNzK
	zb+xnD6m7R6Mpha0AVcTcTb1GRGrRHY1hft5CuSV6mbfCu3lAs/A+d7bYm6Cj/htCGcZv0chYmI
	6fFzip1LaAXdmhdBQbjRe6ICcUoZA8DlG9SSmqMCnBuoH2hFE7y56J2QcTuLn3OlbjFat9b8/Dd
	tmObmOH80f+hXcQNESrrhv4B8nYm2ztvvtkma7G8VWsXZpu4YRBrYeWSl/nDmP/h6pKsDhN+QG3
	3JwLD6WgU9d3xGFlVkLZCeh5fn0lPaiwC8bIbvCGZrRdqJCp2qMTQWEzkJO8OdMT9Bk4IvtycEz
	+FNLjjESUCA4N8nzyS4NIN9CWrs13rbQe8w==
X-Received: by 2002:a05:6a00:2408:b0:89d:f19f:5dd1 with SMTP id d2e1a72fcca58-8a9bdbd069amr3521224b3a.33.1793423064583;
        Fri, 30 Oct 2026 22:04:24 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada9ad592sm502093b3a.50.2026.10.30.22.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 22:04:23 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 05:04:22 +0000
Message-Id: <DMIRF0WAH6DP.1Q88Y58797IJ4@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable
 programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "HyeongJun An" <sammiee5311@gmail.com>, <olsajiri@gmail.com>
Cc: <bpf@vger.kernel.org>, <simon@swine.de>, <ast@kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@kernel.org>,
 <tj@kernel.org>, <yonghong.song@linux.dev>, <stable@vger.kernel.org>,
 <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260822225444.2774461-2-simon@swine.de>
 <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com>
 <apC6-9YqBpOjFLGr@krava> <20261030012258.3005240-1-sammiee5311@gmail.com>
 <auUhrnOOUWY3Mb9y@krava> <20261031011900.1355507-1-sammiee5311@gmail.com>
In-Reply-To: <20261031011900.1355507-1-sammiee5311@gmail.com>

On Sat Oct 31, 2026 at 1:19 AM UTC, HyeongJun An wrote:
>  		if (!prog->sleepable)
>  			rcu_read_lock();
> +		if (no_preempt)
> +			preempt_disable();

nack.
The models are sending the same broken thing.
Pls teach them to read lore for nacks.
