Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140437BE95
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765447; cv=pass; b=X5AU2MQoJlWIV9gIxNONb//q2zAfFpKQ6XTN6Y3Co48ohaAAe+3vmiMwqTymwRN+RtC9SjQ6hGgVB22WV2/7DOvBm4EIwr+JlJvpzGkAhFSA1muuQVzCP4AS2vk5AI5F0EUICRvzOQMJEP29oeNEi2cYUnPjahK5ZICOvSD4ROI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765447; c=relaxed/simple;
	bh=6I/1+qMQ471+4RYnld66Y6RCA6m5prbOV7XKezci6Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDUyUD6ulNe4Z1JXYIYh+fT6y6eW3AE/6UAUJkSPK+2+n7aB9kRrH+1OrjlAOFHPt16bodlQtj/9jjh7LgAj7o6ig1/r/yf6T2rxK4aEYQAye97wLAUSu5HyNNmJocYd2axuVWiPjuS8dCbkgBaqHZ+dj+7WReNXnjblzHx6Yak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYo6voBC; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYo6voBC"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52de50e77ffso11778871cf.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 10:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765427; cv=none;
        d=google.com; s=arc-20260327;
        b=UMuOPaEA3rLxJP2F12W5v3H3ZABz6GkN4v5dEi0/1M8AeQKBOTfT8I8XNufzpMn00Y
         6geZBbE2mTBtLnxu4IALgRqCy03bq+0UHBdhhfAX3FJEjViVn9j32ReR6Gp4hy4Ih+69
         2q0QPv2YZd7/Hp2atb4aKzM7RL6VcUNiH2dYAXMyV8ClGmVWgRjHtIqKmoA4aceAI1QW
         wCUvXqSEZBCb7HDjDGgsqNasVmnqnZEj39vhlcJXTEb9xGEc9Tsa+ZY/41B+Axw5eEjf
         VoKrhHn0VJ72Ssi4A0IUU2DZcCYYAm85gDwNVfwXFrXLEd8MbZrL0gcqATjCVbvlvzNo
         bLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        fh=0Tlpuz24mwtAYJBdTUoU2z7qCFXTqsKgXfQmxKoUhXM=;
        b=k0Et9ellbT+lOy007A1ggYyX3T78RDcvCaEJ4B/7PnR7hXwyx08sSJQMb5bVYcqwRA
         hXRMkgIWAUwmHP99T+GVBYBLUMTHUADxeeFldTyCXZFqUmBavP95DIuYWIdXUIiGrgss
         lJKPtjmrHsMU5UfrntuuFQzZgy0Mr2xDoT5QULAIeZBXCQtIdo0cxboCZF9I5/8nXv7S
         bFEhbB6NuEuiK4DbLj5XJUc/9PMfDngI33z2lqzS4ei0LJUGUutXVMW0ceZrRz/GHae0
         snvOTJZQfqVr1h/6g/7H9GyQjL7wGmgV8X1fFsqqbzvoT0mj33SWA7gcBEq8L8wCABbv
         wJwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787765427; x=1788370227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        b=vYo6voBC/2BgFQ4SxwiD2n2bJd0GVjymeEjikMl35kpmLBdbj3NS+ATEh6MTsXyqeN
         x2+Ou/joYg0moRd7b5+C2fHD/vYehytTAipnHAKslOVZJFwbMk6SO2ZKlrX1kXH3/lOt
         9CE0b0S/lXKVdJsuykaDUPWbP3Orz24rAv0lEqxRce1FuHIOz1iWL5tCdHT2xAaWzemA
         LPK8dTKM3Ty7wgKLYUZXx7o26GJ6BHPcVw17LrBgDJ126Uux28+82Gn1FfVMdoCs7uIE
         Qmoai63ljmAoeGWb/eK9aZqyiNYk8bLfWNhsWmdaPptimLbIisT5uwbtukhoHO7g/kfY
         439A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765427; x=1788370227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        b=Swi5qg65zogC/UdaeCxberY1o/408cWTQRFcPpYAcm/2SVjYvElTZfDBV62V+oPor4
         Si16G1LZCi8inCOjyfmfpiFTQIJQGLPZfk5TSOIjo6u6nueKkVUjoJBHaZvXOs+C8rJu
         ZP1eNUNdAeo76qdGd9WYtOB6uRGJTe9qxi+gvK7tnElgrwtQiYtMDxjMsQqXoZns7Kx5
         GIGCdKVW4rFmTKuAfh4P3ICb7eHUWvEsL9ZD+IJ9/xEb8IccADKYuTYsbkKWVZXQzCd+
         gRfuBNMPiSMhPXjLHQAKo2RyvDaL5XZebP81/3MAq0E/NfIMCl4qaKIv1jcyqofIG8o7
         PVGw==
X-Forwarded-Encrypted: i=1; AHgh+RpwDdafA2Mu4eAQcfOHyUH99mRxzif6S5r30oqGA+69zYuKJntYLRkvZm1CKBJYKYEbLaPkqQs=@vger.kernel.org
X-Gm-Message-State: AFuF++mXS9bu9JlV7omx+6e83bja+vQcCdasnDJpSnya8cpsEogYAqJz
	UOR+WP+R1cTOMiD3hC9U6VKX70ban4JsEFePOpu8SBxBOPdy95P5kCu+b7e4ApNGXlVSIwSqkBR
	aPOtwtUP8kQobiHYZsp4eMKzNnGbeYWP6kIcebWhV
X-Gm-Gg: AR+sD11Z/JQ+iiuZAHRywxofMeN9zzitjuQUXRBPzOoOr/GJkpcMcBr/bKMzxRyuI6k
	aJPRJ3f28oAk4GS44C7CuKKoiH142o6xDwpRizgog/M9tHrgc1sGHuJctgV4FBL/kf0t0rft+2p
	p7ZTKujl9ZLTq9jxXOZOyaHPgDe0GSaSZ9dV0Oyb/zkcMrBD53OHFxp2qO4iAroQ+FJrcKWsLil
	34D9jcnmH5fNbSjxXnno5aO2blBYENSWVpEEWhiHZ2kvhoGnMoqwtAtfo+ZmD1XB9u81WpdpQGr
	QxRYGJeIHxmCa2ki5JinlxZZJZtwpLRL/NMdlcLfmoEIiatSvKWpDFFVnS6aHgRsC5xidOrAloo
	DmcdlHI0u7oZ/7f1jVQYSS3eLvNoXFl6zpjHxC3TLls8eMQM2V55boEuqR08=
X-Received: by 2002:a05:622a:3d4:b0:52d:7b2a:93f with SMTP id
 d75a77b69052e-52e422d73camr87475071cf.3.1787765426178; Wed, 26 Aug 2026
 10:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826171344.4133-1-blbllhy@gmail.com> <20260826171344.4133-2-blbllhy@gmail.com>
In-Reply-To: <20260826171344.4133-2-blbllhy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 19:30:13 +0200
X-Gm-Features: AcwNN1XFn8gzzgrjQfG4ZiFeGArbznLUn8IBe3QpZkDe5XgxFwMYGCWbJrGLGFE
Message-ID: <CANn89i+5+3-u3T0Tbu_NeDSc2L1_Fpqtf_inKB5k0tN=9SUaiQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, yhs@fb.com, kafai@fb.com, 
	andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:14=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
> rcu_read_lock(). Since commit 0baf26b0fcd7 ("bpf: tcp: Support
> tcp_congestion_ops in bpf"), icsk_ca_ops can point to dynamically
> allocated BPF struct_ops memory that may be freed concurrently via
> setsockopt(TCP_CONGESTION), leading to a use-after-free.
>
>   BUG: KASAN: slab-use-after-free in _copy_to_user+0x37/0x60
>   Read of size 16 at addr ffff888013505260 by task exploit/149
>    _copy_to_user+0x37/0x60
>    do_tcp_getsockopt+0x158a/0x2460 (net/ipv4/tcp.c:4585)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
>
> Fix this by holding rcu_read_lock() around the ca_ops->name access,
> using READ_ONCE() to load icsk_ca_ops, and copying the name to a
> stack buffer before releasing the lock. Also annotate every explicit
> icsk_ca_ops store with WRITE_ONCE() to fix the accompanying KCSAN
> data-race issue.
>
> Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.co=
m/
> Cc: AutonomousCodeSecurity@microsoft.com
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.c=
om>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
