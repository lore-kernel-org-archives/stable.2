Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539494;
	b=N85mZikJBLYjv7Iu1M4X3NXCjBWpkmgLZHmWoYo7QEzQD8NCoivOgucD+FmP2u3YoAZd
	 45Hr9Kvh3eCrOES/F1PlaPE8Lou8+LpRrGAfV3htmN3PkgP5Pa3iXvd+9WyATmvL1jKXz
	 ZwD6uByqZKB0QWIPT1noEN79/8DWF0VZbhJpPkw1n/+QLVc1X5JvYyGlpQHsIkZf+O7XF
	 M7soungqfmKCihktenCEL+S+movl8msoCTA1m1tgDEzf0zwsfU4tv1tRPDkstTQtWosNS
	 CgkNy3PecludW1f9vI2xKitHeyLXCMa/gFiAL2jBTVhiLBoEBGnp3z0Aqw0qqDxdIJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539494;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7bzqAqpmFimjeJFcxVgTHaPyYVyV1TyY7rhQFKp6yio=;
	b=tCtPfp6gpCw9wKffKQP/+8BFxsxY2toGOJSQpUMoMef3o8TxHEfKSFf0DG2wF7xMSJdh
	 B/Clo2ZfM69UwELqrx0AC0z5ToB4FpGBQc5ZPnhywRdu7A6MQU3wzDOhAMPLdm8V6HWK7
	 FZOcW5nE878CE/6N6wIRNH0KKgIeE/h/SrJ6s/8tXZ+tNKZMmuw5uEPscsInbDSSD81Ab
	 e3PciyECUb2ym/bzMHZmDWcjwPwtOtcSb/kCRs+q0LMgCdFM5spWYy+kdnuQ+K/JRkyMN
	 y/lL3PAPgQS3xcnrFDtPi6jVnJLkIjWP1Raetuy3hYe3DD08tdsxI3LA9Ghx8fFl0Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvYVBtuT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52333606A33D;
	Tue, 24 Nov 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvYVBtuT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDB31F000C6;
	Tue, 24 Nov 2026 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795539494;
	bh=7bzqAqpmFimjeJFcxVgTHaPyYVyV1TyY7rhQFKp6yio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WvYVBtuTFXAF5q1MbcgyTZ6v/USmCbK7qJaXXQnPjFqspRJKqHZPYiEf/vD1YH0Y6
	 gYgD+2nWq9q++UnvbZ9dcF80jj3KaCsDwJiaJnlpZ6G0lNXGQIY6mcpFxxJQXNMgIh
	 ODDpbFjZGyzo2VkF4TVAQpWEbkGYkZyx0MZXtYpO0/HI8ah5Y+aRMTX0DbaNi8AKB+
	 P6g4oOSJdhHqpQOLj6O6QgwGmZyn20/bPfRroUq0IkseV5wcmjk20Pzf4DMJ1IO1OV
	 IvqdgrVdi0gGmDt0+RS77LFgHGn8FfmvTZ0RRIju5dKkHB9cU68pl6dF42XAdkPXyc
	 3JWEXGH3R1ddA==
Message-ID: <0f4420d2-c4cd-4b93-9841-20d95d98d9e3@kernel.org>
Date: Tue, 24 Nov 2026 17:58:05 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 08/10] mptcp: pm: don't let listeners pin their netns
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: edumazet@kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, horms@kernel.org,
 martineau@kernel.org, geliang@kernel.org, cpaasch@openai.com, fw@strlen.de,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, dcaratti@redhat.com,
 mason@kernel.org, stable@vger.kernel.org, ncardwell@google.com,
 kuniyu@google.com, kafai@fb.com, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@kernel.org, bpf@vger.kernel.org
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-8-278042217e8d@kernel.org>
 <179553041337.3135.9610172277728846515@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179553041337.3135.9610172277728846515@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 24/11/2026 15:26, netdev-bot+sashiko@kernel.org wrote:
> - [High] The netns leak this patch claims to fix can still be triggered
>   through the SYN-cookie path.

(...)

> Doesn't that leak the namespace the same way as before this patch?

Yep! But this is not a regression: before this patch, these children
also held a netns reference, and the listener itself always pinned the
netns.

(...)

> Could the reference be taken only for MP_JOIN children that get attached
> to an msk? Another option would be to reject non-MP_JOIN cookie ACKs on a
> pm_listener in mptcp_subflow_init_cookie_req().

The second option is already pending on the MPTCP ML, for a separate
*pre-existing* issue. It will be sent with the next batch:


https://lore.kernel.org/20261121-mptcp-cmason-fixes-v2-31-00327fd1de1f@kernel.org

So no need to change this patch, it can be applied as is.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

