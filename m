Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793114490;
	b=pE3tfG8tbCraKnMz2Zf/fV2EVvEe4fTOUwKM5+EVzvACN4hdO3BND7h9NAm6yuziwtwl
	 gEpcQsM4NQcnkSwGlkn8HZoxR/Ifw8MgarxAJXmVYk/3XbQqonu/ufP10oJthVBbal9hW
	 Drlf46gyuJTEhN3anbSFVbQI8Lz7wDyrhJCEmIGAsBr3qAap6ohTFyUCJvy0cfKESw3Nk
	 KMCYzms5FFyM2beMzhxydPeQBLKa9curatedsgF8Ge5ZBw8sBkNX/7toCsDAj9SBPnsSs
	 JsmxuLLM3W8gSyqOcPmNoEylT9numnwxE6pEBrzGOlcRJo2BFmYuZufil8+F6U1XSww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NxM/SdWC3JhodFrjdCzECkyQ1tsAfroiL6zHs8mPuAM=;
	b=lCblkF9+QAZGZD/W2aKy63THpPC+RVSvq4rl5ft3BtSwYOkpybVnBx0BS41tET4PkJL/
	 x1o5/YPpSQqjFVkSbHejqxEzHG5lc73r9qobtO/evcES3yPmKsejODQ5WWjqdHqyqV71c
	 73ZD1A7TOw3LiJitisJCQ1e4BD4xciJS4yiU5LMQ3DiOwC5/0nqUnoB8S4Ea7h1O7J1iK
	 S5/Wt1uvGjiOa/ZmnYW4rh+HGPk2KfQ4Rjj6mL1D76Utjs/2PrE0h1GK7nmb6uzYkOITR
	 +payIqmgOIBIz4Jv601UcPxMrXtom7N4AoxaLzvXZMq2zFB/CKDSogIZoHVjave52xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VxSejD1G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39815606A320
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39815606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VxSejD1G
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-533202fe429so405781cf.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793114489; cv=none;
        d=google.com; s=arc-20260327;
        b=U8OLF6wrW9HY9c9Q0dmMOANarY+cl0PZJyb0ihseON3vscg2z+Cq22J3MYZlqgz3ED
         7ChhQ/9sTLoTzcz6pDNl7ByTXlQW2avy5GXRAeWVZfl9q2Zpk2UbcemvjXHevjQXPD6l
         MEW0nmAtIHvUcJ1F5NRSiemRr8RmT21SR2ntAJpzA1ysG0hMLvPE+HDKI5Ez6pUrleex
         ruOC62o/n7vQcZcztWPbhKz3T6BqE/FXd1TgAntv0IFIluu5xwK/cY9Rh36QDbvqqy29
         1jlYZRM30Igp6YykA1ZbiK31bOvW8QoTLerIh1kj5f79k6CCYmiJnhNy9ezobjrEM+V6
         MCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NxM/SdWC3JhodFrjdCzECkyQ1tsAfroiL6zHs8mPuAM=;
        fh=O4Tj80lpj4/NihhIS3vuLcu0OnhbkirjDfmkxLepx9Q=;
        b=sHxsAQLW3VpoUMgNRXeYr5O1bsdkWzKlzNAr+pvLfMIxs9P53vQCCP/3mL5iVfVDdn
         YjJt6Bj03HbYjaTjyoAFPdntlalAAXh1NEJDEVEwA4cZjju7OAVAJErnbroFwi7dHuZ8
         BH20I7CL0DffBN5FizUjT543vsLaeLTn3gOQAKLvTv6znEMK2DKQg1KZTwzpICF9BvxF
         9lTEAJQWxOYDtZJY/vQ+iD14wZjsOIrrHc1yNiS9nFwD3YcROF/K6sAWtEZlYj9DClVi
         rkmUfsGcvaaPCd+A9R5GLAv03eBhpeGnpYfxiRF0Q4g3bAUmWn4J1mtLXt8ZaJmR87Kf
         Estg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793114489; x=1793719289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NxM/SdWC3JhodFrjdCzECkyQ1tsAfroiL6zHs8mPuAM=;
        b=VxSejD1GY4Qc2u3eW5yvsiYM9LBwpqsts/mjdAkJVQ/2lULtq9froTo4Cgq7uu5dHv
         DHWfY55AT8HWvd4LKYMeOsmwEfRUboaavssASngFTT5BRbMV57W7++Suo0neLAwmTQKA
         FUagRvaiXngimTt6jzyu2ETpXw9JB1GL/lXc4ZRsqGlzvsxoSFRfG2jmnX5CRNOuzuVx
         +3fsQgjP80RTEKK3IXzsQypHyhKt1ckPLS+duuV4Jeu8IuSIAXeNx8hPlvIc0/9bwYtf
         RueBJIYhFbqJGbx2cbiM7nQiJsCcEKd1Zvutt/C0qoKHtvmUhUKUhl/7jB8sfTsTx0SS
         dLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114489; x=1793719289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxM/SdWC3JhodFrjdCzECkyQ1tsAfroiL6zHs8mPuAM=;
        b=h0cJTjWD4Lzw5VaF0zH+DaObICQAu4V9OW63gaYvDSMq07j/8vrQSNEQ3ztTnmzOxa
         +ToNch6Mw4A5hqWtxz1C4UaDSoKn5fDt28aVLWx0atHWbQ2Hjp/u8i8C4n8kjgj0CVwy
         I9UB/ZbxSe7FwZchMw9bVNyBAnABxLSF2e0MrXFu/rIpEtT+5L5t73sFRjT/lFGQ4/q8
         7DpOkzvjv0+Aaae4YuvqjDi3W8NDdLP6FZIPQzugsGlDVxLeQR2DP4KUGUgfeBa8qZOd
         +EdEN8/vFtftYqMlgtwEipxhOI10/+djjAa2zbQI9oEC8SbFqh+XDRutU60JNYC/6Mtz
         keTQ==
X-Forwarded-Encrypted: i=1; AKwUvBynLnhI5AzlOTtCnUTmhjFj8A7GsqPhTJ4bR9EuWFFyVeOd1mdHyJlaWPyaRUiUyI0lL1QabDQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJa9kUTe6VY6hpJJ9T3Qc7f/kUJ0HIQPN9G+sZ1B3UbvvvxomXj
	vD/qnIs9/XHDLO+RWAIkR61LTt82b6UWcItilEF3E4NIGXkSmaFQaF7KdNqm9nCUqEknc8STcwU
	vlckvWDBkFAdk97TmSCZr8aBJ9ONPUd6KKWsMwBJb
X-Gm-Gg: AYBFou0kUXRx8IR/qzVTqVgjEBgvLVO2kkCHDAxOpMPZeTkIeTTK1DfeG6SU+29wiGf
	I+KI4hyEWXbF7rk7Rktp4KBcPs3loM+zFtRwO4l3XUAymPpfsTx2fPy7ak6vuqX3tfeIQZAFhT+
	tv9p8ltoaTCF5n/l8OFJuAP6YlbTQif8l0wfXyd0TAxGqUe06vl7aWcBXZcwvOdK0t5jDbRsQ9o
	rYAPxO0SLFW7ZRW5v5MKDYHQ+PYQm1yGJqwdNkyqN8F2AZytUzl4Rw0UXvaqMK5G8NecqtcydEx
	FyT42C9fxN6uqzG0fXros8CZWxWEKNXa5skHNmg+HIlZAz8uu3kIt783g8pHTb+T4UWoek0+orx
	CasSl5PzxiRyb27umyAqJCsYTjIwllDbThAS6m3l/q0S07Aej47wNhzLgrqpomSQ8kYs=
X-Received: by 2002:a05:622a:4087:b0:535:8515:b4e5 with SMTP id
 d75a77b69052e-53e55c28435mr21394481cf.6.1793114488268; Tue, 27 Oct 2026
 08:21:28 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202610271154.69RBsOlq045164@mse-fl2.zte.com.cn>
In-Reply-To: <202610271154.69RBsOlq045164@mse-fl2.zte.com.cn>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Oct 2026 08:21:16 -0700
X-Gm-Features: AclHuK-Woavtv1Cz-seB3sJDtW9u6Dt6v2zVol6SMqMjeJi6wKjBOrgCgGvWdGE
Message-ID: <CAP-5=fUbpxz9HQV+BRd62Yk+mQ5Bq-G3XvcK8ea3W8E3BqM6jg@mail.gmail.com>
Subject: Re: [PATCH] perf machine: Fix NULL deref in thread__resolve_callchain_sample()
To: lv.yating@zte.com.cn
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liu.qingtao2@zte.com.cn, he.yilin@zte.com.cn, zhang.cheng35@zte.com.cn, 
	ye.zhihao1@zte.com.cn, shen.lin1@zte.com.cn, dai.hualiang@zte.com.cn, 
	stable@vger.kernel.org, hu.shengming@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:54=E2=80=AFAM <lv.yating@zte.com.cn> wrote:
>
> From: lvyating <lv.yating@zte.com.cn>
>
> When recording with -j stack, resolve_lbr_callchain_sample() can
> dereference a NULL 'chain' pointer while resolving the branch
> stack.
>
> $ perf record -j stack -e branches:u uname
> perf: Segmentation fault
>
> Fix it by checking 'chain' for NULL before dereferencing it.
>
> Fixes: 29be60c93d2d ("perf build-id: Mark DSO in sample callchains")
> Signed-off-by: lvyating <lv.yating@zte.com.cn>
> Cc: stable@vger.kernel.org

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>

I wonder - this failure points to a lack of test coverage. For LBR the
main coverage comes from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/record_lbr.sh?h=3Dperf-tools-next
Could you help expand the tests to avoid regressions?

Thanks,
Ian

> ---
>  tools/perf/util/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index f86b3b7df742..10a88c070814 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2858,7 +2858,7 @@ static int thread__resolve_callchain_sample(struct =
thread *thread,
>         if (chain)
>                 chain_nr =3D chain->nr;
>
> -       if (evsel__has_branch_callstack(evsel)) {
> +       if (chain && evsel__has_branch_callstack(evsel)) {
>                 struct perf_env *env =3D evsel__env(evsel);
>
>                 err =3D resolve_lbr_callchain_sample(thread, cursor, samp=
le, parent,
> --
> 2.27.0
