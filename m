Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EAA2F99B8
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781669028; cv=pass; b=a9nNjalbM9+dWoVsEW4v7+zxJSPQ4wKj66duNoVC1dlnZsE6lZTWmpGDYCyoLSrTLNChx69u6wtKwYl+zBnsOkADp4R5jF3f2JVaJ5DcTG68TYRsynS0i6wvJRWBXXjDj5nHB6y4gIXKKKWBOKF9vH2tPVlIJpBI11EXGgFRIts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781669028; c=relaxed/simple;
	bh=nGDDKPMF7cvXoB7/DDIKRcLBkAO/e6gijUwIyJErKRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQDMRrw+1+SuDF9Jj58v1clUYBw+Q6h6fKZTwDSGbpfCBR8H2ykA6D6J5lSzC9HbhiAKIiDPmKGuaSdppuAbNmg/nNBQO50BIYn1NUkE76dBivUA53Z/O+Dn+vzBKF2vjVBD210/VQOaYCGxJ7jRU+yYMiMFw8Ig2qbD52E6GDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7hGd8/P; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7hGd8/P"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-517b1f2c668so59336921cf.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 21:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781669026; cv=none;
        d=google.com; s=arc-20240605;
        b=c8Xn4U0A6bgiTYwUa0W4fWE9aWwxjIqurMPbZ2UfOpSXdMMTCcCRs/wOTthb1q+Uzr
         2aIBhuquwpjBnSdBOQZHcoZ0OCfndWMor73P0ea6BvahmlxpxYgTP4roHrfcbeLmNK0U
         9YXBxJwC1YHurxKykz7c7PWOWClo2VcnSdDjRxtRJYRJbliI+blloTGV3BLh62fNXezu
         rlk97n7E2LNWhdMsguNp0k84ebDGU/RXxxxmKQoh4yi+bjGH07/o5qcEFBspCMl7E/XM
         lmThilKLL671kd4hGaosTIxUMuihgPYGITnLwgTTO/3AnUkiP6tgIV39uSUWZx6VIGh9
         HXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8KyfV9Pt06ZHHcC1zYd9eBjxY7fk7AzCnkPLQzY7i8=;
        fh=2LQwmir8Mr8RUqH7QBKek7zskVlcWEQ8w2sQXoKkarI=;
        b=cbC+i5+IJpatrGCvbLKEVIWHT/vS9r9PcwrmA8hsTKZ7Wvp+MQbazMmY87+kCPJz44
         UsG3QN42/KJRy0TCwRo4VkM7Hw7O0PEXO916+VpgIvFrNuEofocUbBAsi1vXpwr7dvhx
         HsEp4Km2y8dq/Ets0DuRR+zu78KAIhuSgHCHcb0fZCiG7GWboP86eOvqCTVJ2cGYvkDc
         Il2ZKsn1owQCcBFdZu3vJFxpW8W/JBTDWfrFfJ6/4aAj1025XrTo8fxhmbK8rquLaA5G
         Bga5uF3lZR6hHdWy664+gxLkHADe2vvn8g4LY2ph7x1g7BK259OFlCdWvTMuQmOvU7NC
         5JnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781669026; x=1782273826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8KyfV9Pt06ZHHcC1zYd9eBjxY7fk7AzCnkPLQzY7i8=;
        b=K7hGd8/PCloNkTaoacnaHuFi3QJf+E/64nTHm70zK8Cw/TePNpSkfC14TqaOyu5Q0H
         mT0AhyNAhWOSS7wrM6HThj8bmrEr6HVGhL5Ne+MV5ANQrctcKVIyVuDw1G7XVVxjdBzS
         dGoKE7Bn5ug8s+Y7cUMcwPdir7VmmYY7pg67rkKWbi1+Fdh3ic6RKulFinIKqJGz3UAK
         SzDo1aHnbhu6vpiUWxFnl9THNuyVSosQNgxU+21+IQN0QDXxy2VNZTvAmNQC92CO6tH7
         PqtxhqOshiE+4C6Z0897fwC3+nqRUWnzeUs8cefRPWgR6O1ntdjex8xN9pYNaMZJiV7k
         1Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781669026; x=1782273826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8KyfV9Pt06ZHHcC1zYd9eBjxY7fk7AzCnkPLQzY7i8=;
        b=Fa5BTrFLzJ3mW7o455Ilv31/I0VEJYeARAjwyb4WgYNAwPHWUvAiaTnemS/x1iSWn1
         +l0oqtL4VWtdfUOVIdi9Noz9nMQoRTaJ79rgyoWiDCg6ZqOgBa55xTIJgOWtUvfGRlyP
         +IAXm2BLoQo31WWuZBtechX/j9yrAn4lthw8CRVUiEkuoea60etr7Gw6e/j53t4SwTtC
         CtuZCR7g9YtuPgerfGK4nJC+jOZYzA0FHi8U4Ekad6t/TmAJdDzVNn6rd3hJEAN7hUV2
         64xuZWoFQ4z/hW8+pKsM3KiBnOkuEj0T/7L8YPi857OUUTzQACt0/YJ+wE9dSWAO1Lkr
         OIow==
X-Forwarded-Encrypted: i=1; AFNElJ+tS3X/6h6A6EJ4ZGTcour/Xj1E/5g6aQW5r36JOMEuqFsPmGTUfEIUi9YMr3ywQhnxvTn6p3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyhtxaNWUkmrE26tV/h02rd+rGI4Jl9nYwuKeaO/oCB+P103l
	2qMY0inHgXfVlstzhdgEmP46xE59fJ3uWKXqvB4DSKVtJqt/bdE1Flu/EX0Bbu93rrYaCBxm4az
	d+NtJOYAi4ApOyLojS87EMOrYkrrNnGf/FNUiSuaa
X-Gm-Gg: Acq92OHFLvSMyesl9Lgd+iWtJ56/odlQ/9gA0RSvQdxrVDfOlC0GgzfjJ075EgoiH73
	k0gb9J8Qy4TZdO6Q++X244sVlB9MQN13vWG3CxLBJD6etucI4/QuDTAMekB0GpIX1vFg81ipQ3l
	zOBH51cBGPq3cFOzE8bMvwDhKLlHdt/AGkWFrvKFVrwzmVOwITbuKZf+T4c9eo+pcb+Qdhmlivx
	p3AB9AsdTj2kJPvbUl1SvsFru+HWJe8BAc+E9Ido3tPLebx/SKhJVCiVrsvnj2yXSUUh5oGdiva
	cFxw9l9d3FTqDYNCKBWBQp+HEs+0DJAeycM30DSgGIRzqI3pcJeZC8KtCVhI2toIuP8J2nznOpt
	CnSrxnLzg
X-Received: by 2002:a05:622a:a6ca:b0:517:6c6f:8ee6 with SMTP id
 d75a77b69052e-519a8c6908fmr36262241cf.6.1781669025646; Tue, 16 Jun 2026
 21:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617013208.3781453-1-joshwash@google.com>
In-Reply-To: <20260617013208.3781453-1-joshwash@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jun 2026 21:03:33 -0700
X-Gm-Features: AVVi8CesugWGvhT1ob5SAVvgc8BH84Ip7FIlMibVTmgvAH_bFYwrk6DEdOErY80
Message-ID: <CANn89iLoYFW+TLt02c_sUtXcPL3-ONiQjFxqaA4BSsRCoAd_zA@mail.gmail.com>
Subject: Re: [PATCH net] gve: fix header buffer corruption with header-split
 and HW-GRO
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, 
	Ankit Garg <nktgrg@google.com>, stable@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 6:32=E2=80=AFPM Joshua Washington <joshwash@google.=
com> wrote:
>
> From: Ankit Garg <nktgrg@google.com>
>
> The DQO RX datapath programs a per-buffer-queue-descriptor
> header_buf_addr at post time and reads the split header back at
> completion time. Both the post and the read currently index the
> header buffer by queue position rather than by the buffer's identity:
>
>   - post (gve_rx_post_buffers_dqo): header_buf_addr is computed from
>     bufq->tail
>   - read (gve_rx_dqo): the header is read from desc_idx (the completion
>     queue head index)
>
...

> Cc: stable@vger.kernel.org
> Fixes: 5e37d8254e7f ("gve: Add header split data path")
> Signed-off-by: Ankit Garg <nktgrg@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
