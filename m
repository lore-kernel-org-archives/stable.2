Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA823ED6F
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569686; cv=none; b=UFZsW/CijKQrrKRCTZp3k6e9pEEZS6nFRFAu7+cvXBNdjRch6g1AggHxjqWizy5tku9XF7cUIqdXQVwMjgajQzlBkSUngInaoOw1oohLi+xOam6IiCtKYXJvnlTthXAUAqH4wVZGK6qr2ZWymKvxdLe/oAjNiTRzZDM/yuqnWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569686; c=relaxed/simple;
	bh=Fz7DRDx/ys8/9DEE57BDgxgsaZw6Dt+6ycduI4iFjS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsWVsq+psG/rwApPY5Sx+F0KA+7qHBXhD2chltSgcEmRxgN6AuhS7DGac3LEpy+utxn0/xadBTOj9z4hXBFt/rji73TzM8vY6QZ3jKlrgbt1Y73lKTMcvftefnuh8iXM3sv4EcsDCw4+7MLo9YviRPfne3s7/qyDFQDNg+CNIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7oCtNih; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7oCtNih"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf22c18ad3so24815ad.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781569684; x=1782174484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2aERsjGF0PDWk2sO+FNhRojIc+YeRBYDcFVxz8BN5c=;
        b=J7oCtNihOlP/7QK7gbmjqj5hOTb7AJ8mzQtDyWulUp0Gfny8BSZ/NoPIA+2ho3wlR0
         0vJdxSwmSKdNfgYEhZZqOauFYlxSjeQ0L5fv2cHAzJqOY8pJX3f6m1zc0tq0iUFQI/nn
         xE1KCQYLXAOluu1zsU/Tz6h+3+htZ84ftXQY4htNU9xCBy/VEdeYFeKBJsoEh2TsfH6r
         F8u0ujvWc0D4jKzEaDkbFIbYWWbkxkR0JE6tAKIO22w7I1SAhAHz78slBrqhtXAIU332
         PfIQ0ssYVabEsnbO4e4gs2q4GN5vmhFnt54CC91fMOMKrnEtVQpp7XA85Dm2QlTlP42r
         mWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569684; x=1782174484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2aERsjGF0PDWk2sO+FNhRojIc+YeRBYDcFVxz8BN5c=;
        b=DvVVF6TI8PukFE1ekAbuptkmuoNplkhSDCSSg00A8Usr7onP6ufyKO2+bw64GycCHv
         ep8EBRCPIcJOcmGoKbwprTjd02jjfWnBCWPvBwDkN05hQJJbOmTIO3nxGoOgAmDF0qPo
         fBSntZJ0elAtEMM1oTCZ5JwLaKcK6FqKir5GwStx2ZGYKbyZ8OF2sQ8rmJi7eFcx+h39
         8Lf6hqPTf/tbNlggAY6/wIXE9P+ijlGYQm/EpAeWjExnJc62K+e0+26LVQRKxmCMtd94
         k0OMuTDqLOX1jn30tGIfCfIrCTupL/vn1KCsHPRLcAs+fCmDq2bUDs1jqdfA6VeB5tiC
         L/ug==
X-Forwarded-Encrypted: i=1; AFNElJ9cQsM+LW5JeWhfAKCcK6uUthAAWhduFzM38wUcTHvWXFpaAino28Gif9dviXlbpLnTWlvcHjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFE5sTEycj0Q2CnWvtyLrTc+8fItlcVIJtMtKvv3k48n3sbL+
	TRhl76T2Ay/MRUJd0cygCHXPNkTX8FIySKaD6CE/evlyAKtZzBAEpPTOJTG+wPqHkA==
X-Gm-Gg: Acq92OFlWkTF+lO5u38aWJpmZCIOP3JekRoSraVAXudhfcJkArhidPtAm5LpM8GOsX0
	BsZJZFMkVZDk7oSz20aD0jOwej+Ok2d917lyVuNAeSFnuJY0PQXcR/8UROWbqb1KqV6PBPa9bDI
	JORXGe7BSgS25EFak9oGGccGz6c54c8va7zB8lLIcNAuy5TiXmlHjW+sz0TjIlgGuQpUTTMWv/u
	kBV1ssWwX9bUjvYFRBuuvqPcq2Ly9p/9IldMk0FU+vPl7J6Li5StIFfZCDH+uAYDzusZ4Fc9TOY
	bPMqy4Oq1DZEz8lBZL86xYVs2SQrEUAObU4JO9rUu5Zj4Q4nhk7i5EuqsjyKnVTreVxj+Nb0uUa
	NjhWeUTdBW3gv9D2UxMl8N9SWG1XrtGqYtq2IM7RjUfltLaycdgQexpa+uqgWx5UfO90JB8CigP
	kYSaro9nXem4XPQVHbx0oMmYueVP746dFLg2O5IvNQOMq1r+K9ArbQ5c96q+JbpvPpUjlFwfLS9
	WMevmrGxkj+h+/zqn8=
X-Received: by 2002:a17:902:ef02:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2c69c1d4b35mr670855ad.13.1781569683615;
        Mon, 15 Jun 2026 17:28:03 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8663164a0fsm9890419a12.8.2026.06.15.17.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:28:03 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:27:59 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Wei <dw@davidwei.uk>, Stanislav Fomichev <sdf@fomichev.me>, 
	Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] netdev-genl: report NAPI thread PID in the caller's
 pid namespace
Message-ID: <ajCYhCB7pdywVnM9@google.com>
References: <20260615171736.1709318-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260615171736.1709318-1-maoyixie.tju@gmail.com>

On Tue, Jun 16, 2026 at 01:17:36AM +0800, Maoyi Xie wrote:
>netdev_nl_napi_fill_one() reports the NAPI kthread PID in NETDEV_A_NAPI_PID
>using task_pid_nr(), which returns the PID in the initial pid namespace.
>
>NETDEV_CMD_NAPI_GET does not have GENL_ADMIN_PERM and the netdev genl family
>is netnsok, so a caller in a child pid namespace can issue it. That caller
>then sees the kthread's global PID, even though the kthread is not visible
>in its pid namespace, where the value should be 0.
>
>Translate the PID through the caller's pid namespace, the same way commit
>3799c2570982 ("io_uring/fdinfo: translate SqThread PID through caller's
>pid_ns") did for the io_uring SQPOLL thread. The doit and dumpit paths both
>run synchronously in the caller's context, so task_active_pid_ns(current) is
>the caller's pid namespace.
>
>Fixes: db4704f4e4df ("netdev-genl: Add PID for the NAPI thread")
>Cc: stable@vger.kernel.org
>Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
>---
> net/core/netdev-genl.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
>index b8f6076d8007..4c23e985cc01 100644
>--- a/net/core/netdev-genl.c
>+++ b/net/core/netdev-genl.c
>@@ -2,6 +2,7 @@
>
> #include <linux/netdevice.h>
> #include <linux/notifier.h>
>+#include <linux/pid_namespace.h>
> #include <linux/rtnetlink.h>
> #include <net/busy_poll.h>
> #include <net/net_namespace.h>
>@@ -189,7 +190,8 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
> 		goto nla_put_failure;
>
> 	if (napi->thread) {
>-		pid = task_pid_nr(napi->thread);
>+		pid = task_pid_nr_ns(napi->thread,
>+				     task_active_pid_ns(current));
> 		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
> 			goto nla_put_failure;
> 	}
>--
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
