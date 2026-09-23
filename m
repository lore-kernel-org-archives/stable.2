Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770044781F
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147574; cv=pass; b=qIJU8UlU2hAo5S0nQtDomXwL49m/eFfj1c/mQqmmSYmCKmh7WQ+yKy2QocWjY838ogmiVqzF+CAo1LN7l20wq9l4ZvMepbuM5kQD3IdIdt17wKiZzr2ZuvAd78+WUlp6TVmwsG4VLem8BwaIaOq5oQCtAzqogAgDWR4lAiayabs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147574; c=relaxed/simple;
	bh=ePal1IXH2Ui+jY7Cm11lrIQVvYsSFG8i9kUMaDDpZ0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYbRJwesfjCIQIBtZs4N7aJEKrdDX38Zv9iGCRIjgTOB6R8JcGnuo8B9qXySXL7rUvs4OVyInMVsb+TlJhlKVhiLtrJCF0NGn1qQ/5mZWZEhPr3ig/sbAhQVNc7VZtizx4vprrCdW1xu+YjvzloxvTaT9X4ZnAB8VN0UD3ZRjN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3zjMH1X; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3zjMH1X"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5311edbc154so5421501cf.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790147570; cv=none;
        d=google.com; s=arc-20260327;
        b=knP+9IcAC1iFrxxJPtlvG3islL+VRNhdDohM24PzKkGpLl+z6b4WLzcCytIdPvirpN
         t/r4+znPl1riui0Zgr8Qg3o1l62HGRSSbqt+OSVUGw611sjz4qgH4nRWXkSgKwWypkAQ
         XkDCdI4plRcJ83pD9jN6jcvQfIsiEs5vty/ZO7FTKlpNpqush791nZwdxnhYWauFSvXS
         AXV5qdta4B1L7Qn0mmKuSjJujstDMombkPnW1YSB/a21V2orsc7jh1PRLhMsvrbjWpJs
         qFLQI9ruKkBLrGrrGg4PAe166wRvpJBU0MgtyVNJd1dATMumX2mIoFBXwRZBp/rb2L63
         RXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1fux143jdFR0Eh4CQI0otQKDHPnWvDD/S8UKWh266eU=;
        fh=0MP2NRWYKwh6AQokXoCDHW3z34o8fZpkgi1b72oM9Ok=;
        b=YIPfPuH6qqhczqjnaOmGpIymil4gSg2rOotYWGXXdvkJ6rbWeE0c3Ja4VFZX8rWi1Z
         jziK0QNneCUQio6kqdmTFJZ6q2GCGeppiDPZqPBfJM5KFo3fhzJE2qcvrDlmzFkmTz5j
         6LXphqYj3cAwQHeW5hurW7w2aWB4CDRcl5FWoX4+WURWyBIhulIWe53NV4XgyZuhpBNS
         ztJ65hVwPW1REPMyhmhb699StcuIeu1BLpvkHLRR9w7z/q2JPf5QKvJtDGibMzci82on
         ouNyT1LTHRALCbUY33f6H/ccufMQc/BSh0xE9vn1xeZWtw4Kl3nqjPNe3CnQ7H3umUf7
         Mv3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147570; x=1790752370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fux143jdFR0Eh4CQI0otQKDHPnWvDD/S8UKWh266eU=;
        b=A3zjMH1XSRyIaUt1e+cOag0/yivvNrxTdz0HbGqTddQ+5CwbBdwvSwHJCtN27OG8dL
         KTlhPz+5T1JU1r4bUHZyY9U34RFKZ6ZM1qCiOVD94l2c5lKuXFBtwOP12Rio4Wjhhkvl
         iOtkfz0bpSblEgE4vQ/c3Jp689CsYy6iyVXnOZch120cpWS3a/K/3tWoudlULvvqpzgx
         n2mAnNG8e4xBN/7roKUZ6cjV522ReCLKNRJYXX8DWExNMXCKY0FnsfCwz9mAJx9GJMsJ
         MGUZoG6knjFDUKx+2Z31D5TjL5QhGhc/TRyFjA9d6YcPMPHHHpW3/CZmRp8XOvni5xgg
         eR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147570; x=1790752370;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fux143jdFR0Eh4CQI0otQKDHPnWvDD/S8UKWh266eU=;
        b=0kVWzIAp5TEwInlPn5q6woSSACdhrjLq9NK2I+RklPFWO1hbah2tTeCj0aqcAwYQom
         DFii89bW6eFqCnNNaWwai855GdLInRcQoGPmG6QlsKNfWC3uWqycfsEI74B5tGnjArbN
         thO6UzS+CCq0mewIzpwWmWigElV63IbV0JZ2nEcunuazs0TUELcH+739k3IHz1sqnPjt
         8GE7Ne3xNMcHZrD7jWFADTXYtR6Q9XRBJf5Y6oNNAAAUeVQobEJoCYc0S2pHsxiNvrBi
         /9gXei7H+wLKd8fnrExXyqt5mNtiyEQZeWyqBxqHpvqqV+cxk1WdXQKHTv+j3wW4XmSO
         oRVw==
X-Forwarded-Encrypted: i=1; AKwUvBzFCXI+bEHj3GnvpdXQNWEGhO+QrmZTI2pLOIa7T2vI4gJ1moMpZ5oqHEstrhb3ast36kqSxoU=@vger.kernel.org
X-Gm-Message-State: AFuF++kLA1aSDGndZNYm7lx3z8CkGqRLpx4qrVgeXtZXuAR8NEQkuI8A
	5gX+iLwPcQBEa7sCUlYvo6dSWsjbpa5GnCUnp3yrkCAvaJ3pJ2nORzH+3Mh4xy8MgDL4BkpoRvl
	j4dhYwkRxg58zu21q0nvDz3NtfHhjaOCzCw5k8NIAGa8l4y79+/PC7mqYPPE=
X-Gm-Gg: AYBFou0R7mBJAoXoaeB7vnlE9uPeCFTu3UDj+qU8Rm0OMVJdEejVo6dbCRtjJU9jeu1
	+vlJGyRaHnYHg+ImAJaIzd18b25oodMC5mdVY/jUnhMBbszQRlzre6uDjL7oJVssdhCB9x66/4x
	ChG+mZOiyjnMTUvTL6WPtjlGg3UnXd3JD4eoHNmkcDu/4Ugsx0Q7xOLi15gGN5nIR0M+AKRNzn1
	ZtCH9g7Eb9k6GOtxQ/MRsEKQ1ERDkW2mbTaGht/VBTUYjwYsZmv6GJuVjo4j4AFj14ZMCeRwHyN
	I144kzbHsalCo/ZhENOmz2QSQskofLeVRkogGmpaDz/P8ulmht60aBnjed4BRjvkTMElyglNRcm
	t1ypp+odnZ+tCiLqp+shSWCpbKaTXuBKobhVVaE5faXiu+NCG0e8Ad1YBaphE5vA5taJc
X-Received: by 2002:ac8:570b:0:b0:530:e01d:6001 with SMTP id
 d75a77b69052e-532eac6cbb3mr31883801cf.11.1790147569115; Wed, 23 Sep 2026
 00:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 09:12:38 +0200
X-Gm-Features: AcwNN1VwyXdqxc5s0wWZvupLP8rtkXVbaVkNw_j7qxnCeeIIfDCdM4_fvPpPjkA
Message-ID: <CANn89i+fsQdMeMcc6zk_Vp0WtckLQBTmrQ_fbb9rm44L8kSiTQ@mail.gmail.com>
Subject: Re: [PATCH net] net: gen_estimator: protect seqcount updates from
 hardirq readers
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 5:29=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> est_timer updates the estimator seqcount with preemption disabled, which
> does not exclude hardirq readers on non-PREEMPT_RT kernels.  A reader can
> observe an odd sequence and spin while the timer is interrupted.
>

There is no hardirq reader of gen_estimator_read() in the tree.

The only callers are:
 - gnet_stats_copy_rate_est() from tc dump paths (process context)
 - tcf_police_act() (BH)
 - xt_rateest_mt() (process or BH)

est_timer() itself runs from TIMER_SOFTIRQ (or ktimers/N on RT), and
softirqs do not nest on a CPU, so no reader can interrupt the writer.

> Disable interrupts around the seqcount write section.
>
> The failure mode was reproduced with an x86_64 kernel under QEMU. A
> test-only hardirq injection invokes gen_estimator_read() on the same CPU
> while est_timer() is updating the sequence counter.

Injecting a call that does not exist is not a reproducer; with that
methodology essentially every seqcount_t writer in the kernel would need
local_irq_save(). Note that such a hardirq caller would already deadlock
on e->stats_lock in est_fetch_counters() anyway.

Also, the preempt_disable_nested() here is deliberate (9f74c0ea9b26
"net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=3Dy").
local_irq_save() is not remapped on PREEMPT_RT, so this patch would add
a real IRQ-off section in a context RT intentionally keeps preemptible,
and would lose the lockdep assertion on !RT.

Finally, the Fixes: tag and Cc: stable are not warranted: nothing
regressed in 1c0d32fde5bd, and there is no user-visible bug.

pw-bot: rejected
