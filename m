Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77839EF20;
	Sun,  6 Sep 2026 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788689523; cv=none; b=romCFKak6ZcJwlLPXVOZY18UByw7RJmyebL8AhoBOYTkCggW7F/b1j6A/1/519wcoGkOeKfcL3RNTSwza08lJuEGMcxX2F8Sg7fRyKTKfpngKjdboue1yuGcHc2PI76jXpm9i3IsqAoibTM/3Val9XUHlTosdfwhkk5OcUvz0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788689523; c=relaxed/simple;
	bh=5ZK4uAzPbQUwFP7ga/rgJh8iVCPSP1IOvwoBU5Z0T7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUVo9HYnH2xrwr/lPkEmcKm4j6FAQhxCxKAdg9YAfl2RPLVohDPK63GNNFBaj+4lkyxib13WUhehjfuwgAWLPEy+O/otNXFvZpvAHn5kHAMGTJUGTIv8ea4v0s8rL4AnBzv3AvAcAMAqL4d/DQkWXWY+VH88Dy06wE2DIH0vZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqIaYQxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqIaYQxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC0F1F00A3A;
	Sun,  6 Sep 2026 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788689521;
	bh=tJEaiXned6r11arNPZpz/fZrQApr9XNv+fEd4IKwKCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cqIaYQxFw/IsOGE1exv1cF46tjX0TrQKEGu2xQu/gcmPYT17YRoQ1aCY3G35FaWLY
	 2oS2L2ZVV2VKH83Lx74gwcheiREoowXQFvnVxnRzFJ+wts4CT5zYLqXxnNYMYYsaD0
	 cqMtu3bPl/001kt5FRrA8hSDf4DNgmAT2bQiLqz2AGU963msbZIlwiZOWLyyrVVrG0
	 EQPTmhKnpFLq9UGhwfvb+nk4+LegqAgeI0TVBdLeJOr/QJnaxUpeJLovadXC2guf70
	 XIGyt2MkEHh7i8Akey96HZEHsj7nF/d5ddI2YoQXPhwqtvXF7ouElhfx80XJKGO5Wd
	 PMhjYLA52GBCg==
From: Simon Horman <horms@kernel.org>
To: zihanx@nebusec.ai
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net v7 1/1] llc: fix listener child socket leaks before passive open completes
Date: Sun,  6 Sep 2026 11:11:49 +0100
Message-ID: <20260906101149.215761-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0b8964c9cd294898c9657fd34c9d04cec77782eb.1788414881.git.zihanx@nebusec.ai>
References: <0b8964c9cd294898c9657fd34c9d04cec77782eb.1788414881.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/0b8964c9cd294898c9657fd34c9d04cec77782eb.1788414881.git.zihanx@nebusec.ai?part=1
---
llc: fix listener child socket leaks before passive open completes

This patch addresses a child socket leak in the LLC subsystem during passive
opens. It ensures that children are only created for SABME commands, avoiding
leaks caused by non-SABME frames that never complete the connection. It also
improves teardown and lifecycle management for incoming child sockets.

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 260460d50f54c..092625e28b3bb 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c
> @@ -88,6 +89,13 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
>  		 * skb->sk pointing to the newly created struct sock in
>  		 * llc_conn_handler. -acme
>  		 */
> +		if (sk != skb->sk &&
> +		    atomic_read(&llc_sk(skb->sk)->incoming_state) ==
> +		    LLC_INCOMING_PENDING) {
> +			sock_hold(skb->sk);
> +			atomic_set(&llc_sk(skb->sk)->incoming_state,
> +				   LLC_INCOMING_QUEUED);
> +		}
>  		skb_get(skb);
>  		skb_queue_tail(&sk->sk_receive_queue, skb);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for an attacker
to exhaust kernel memory (OOM) via unbounded SABME flooding?

Looking at llc_conn_state_process(), the new connection skb is queued directly
to the listener's sk_receive_queue without checking if the accept queue is
full (for example, by checking sk_acceptq_is_full(sk)).

Because llc_conn_handler() allocates a new child socket for each SABME packet,
could a flood of spoofed SABME frames from the local subnet cause this queue
to grow without bound?
