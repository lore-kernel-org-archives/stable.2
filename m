Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71013B4EAD
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578344; cv=none; b=Vur78lr6dStE0HSW1JMCjLBcpy0d0peCGEd8ENSQqX20fM37+76tIs2h2Oh6+JaRS5TLFo4bbpt3Zteeb8vvTWJoywbSSD91Am+NLoG0JEAZvGLeKljM2+ZPYeXEMgLZrZXcicFdN467USaGVpahVDV9Vw9stqbPn3ufuCVHz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578344; c=relaxed/simple;
	bh=YFQime2e/KMxTdkTpQbLFTR4IUPGEDfw8ma8/rXd/JA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Jr1BKhuQ2stydTGy1or5jXxS8CDnd/d3PnZnf3NDCVxxBc3OwIAAFxjK9yokEDxZel8GLrDhwS3Vxf1UpEsC3FGylgqnIOIk5VLAeaTcvCa0yYJ5jnzfyMOg8jYM2iPpV9Tb1n8+9JOukp6ZVCVY1eKUHbxQIai6zUDpunhEb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=llKyc0JP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="llKyc0JP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cace91f112so107764235ad.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784578338; x=1785183138; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d/IryXvteIZWiLHIz2ggYKGDAJY33GpRv0CKTKx2c4A=;
        b=llKyc0JPqRCSbcyzyIA+iePvK6KPhJAalzoFbC9B9wQZeN0sANqGMk/9ibWbJnjyzh
         ltT4RVf8xeI3WyxNFfDsYeyk7WzptasTapKkv9IZc6vhe8csMw0+1Rd3YdoKrzjTUvkj
         4k9CUax0me6xSCSPBr/v1V75GZHQmuBArL4xyPIJb11equMWrEgd8IEjA1L/Rk/iQzS8
         0tzIJ/bQq+Io/1kvzKQOVrQ0iiiCd1yeAEhZn8dTnD/dDftbRWayjAAA2f6eHA51lC2E
         XvoQrBt59DY271kN6mj+qXu677jKNMlPZXLvk+U905MpDZqSEPe+7g4r4ItSFGRlqVif
         UgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784578338; x=1785183138;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d/IryXvteIZWiLHIz2ggYKGDAJY33GpRv0CKTKx2c4A=;
        b=M0b//fX7qpnNFnMxJfjpueDKAXz11dK0ZK1b3SUKEFOiyFZ1yjKF0QH4/Jmsox8ML8
         9BS4TMVcCpkwFIQqAefx3fXHDbFoJa79VtpxfRz3p7rKpyq0vo76OGpJcTZFggL9B3e6
         w4i5e+fMXQz4yTMF5Cv1IzotU4Gv2Kepa2fEKoVE1djNsTTN4VzcE9UwlwF4PIWJJQBW
         evHEyGI3RB1adgWv9uTjyGMEwogi+JipKWoSi2bxpQrSVheYh8GM5PyLYq7oBNWIIyr+
         dwYF4/u/x7bJv2Dum9maSGxbXci8yOGquAmRpT1QQJ+cbG18mc4RQU0ShkOWw2apwEFg
         Xqbg==
X-Forwarded-Encrypted: i=1; AHgh+RqB772mISyQX9gN9v84nUjhunT3fGVc/cdYlQkO+Q7FQssAZFbfngV6iZnfyx9O8YAx54pqRoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI41s5gZ7SM6aTiZ6eIfZCw8zQblDHWOkrDv9Gr9SAPHiOyua6
	Fi8awiuGFS3cR2LFvULTvfdMgk4WLOUf+qAzrQ8HinNbKq0uaGUeg0wDy5WR2e8uy4M=
X-Gm-Gg: AfdE7clySRqwXA6qn6DoNVLCm6vxVUGj47+rxGdkOJqqzBA+4MrhjCEMfk1/9uSdYr5
	9M98fDXBiK1awvGN872FsRvrYniVrk5nzhlkp5uyluMK80lbtKdfpGQ3yJOfBwdekNKU++s00B9
	ZeQAtma+lVRaztI9pY4CZbzvq1sq3x/LGLU++omqTNerUP/puBxOr9izmLerNXREdYTXI0NVaM8
	pqNl0SEC3BWmm3o3Q/c7Ko4nx9o5NupL65q0vEtNwbqoc4TT9Xo06N4HA7DDV1l/L5YOkXkqipV
	yDR9WDXM/6Q3DrG0sedpbgcyBytsSRcO2BjWrXLowShIIcUta3h2J9eYEWckP8V7OxSN1o6k5TA
	L0eqxS8hDE7kEyMgaM7Jvuc5JpNRP3WJhlksLU3cZ7PQlCfBcRxP7mQy7KW48CWCfwxgLF1JRyZ
	Xpz3xHeqev3p3bPGQYfISlDDTR2FQC9vw33FOuIY8TxA==
X-Received: by 2002:a05:6a21:648f:b0:3b2:924c:566e with SMTP id adf61e73a8af0-3c3ad973471mr17553818637.36.1784578338337;
        Mon, 20 Jul 2026 13:12:18 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519aeb676sm5057046a12.19.2026.07.20.13.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 13:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 16:12:16 -0400
Message-Id: <DK3O81WR05WI.ZR3AJUCCX424@etsalapatis.com>
Subject: Re: [PATCH] bpf, sockmap: Fix cork use-after-free in
 tcp_bpf_sendmsg()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Chengfeng Ye" <nicoyip.dev@gmail.com>, "Eric Dumazet"
 <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "John Fastabend" <john.fastabend@gmail.com>,
 "Jakub Sitnicki" <jakub@cloudflare.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "open list:BPF [L7 FRAMEWORK] (sockmap)"
 <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260719161630.2901208-1-nicoyip.dev@gmail.com>

On Sun Jul 19, 2026 at 12:16 PM EDT, Chengfeng Ye wrote:
> tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which
> drops and reacquires the socket lock.  Its error path tries to decide
> whether msg_tx names the local temporary message by comparing it with
> the current value of psock->cork.
>
> This comparison is unsafe when two threads send on the same socket:
>
>   Thread A                         Thread B
>   msg_tx =3D psock->cork
>   sk_msg_alloc() fails
>   sk_stream_wait_memory()
>     releases the socket lock      acquires the socket lock
>                                   completes the cork
>                                   psock->cork =3D NULL
>                                   frees the cork
>     reacquires the socket lock
>   msg_tx !=3D psock->cork
>   sk_msg_free(msg_tx)
>
> The stale cork is therefore mistaken for the local temporary message
> and freed again.  KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in sk_msg_free+0x49/0x50
>   Read of size 4 at addr ffff88810c908800 by task poc/90
>   Call Trace:
>    sk_msg_free+0x49/0x50
>    tcp_bpf_sendmsg+0x14f5/0x1cc0
>    __sys_sendto+0x32c/0x3a0
>    __x64_sys_sendto+0xdb/0x1b0
>   Allocated by task 89:
>    __kasan_kmalloc+0x8f/0xa0
>    tcp_bpf_sendmsg+0x16b3/0x1cc0
>   Freed by task 91:
>    __kasan_slab_free+0x43/0x70
>    kfree+0x131/0x3c0
>    tcp_bpf_sendmsg+0xec3/0x1cc0
>
> msg_tx can only name the stack-local tmp or the shared cork.  Test for
> tmp directly so a changed psock->cork cannot turn a shared message into
> an apparent local one.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---

Hi Chengfeng,

The patch looks good:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

There is one caveat: Normally we ignore pre-existing issues Sashiko
finds while reviewing the patch that are unrelated to the change itself.
For this function, however, I think we should make an exception because
it has multiple glaring issues we can fix more cleanly if we do it all
at once. E.g., tmp never gets cleaned up even if there are allocations
hanging off of it.

Would you be willing to expand the patch that addresses the Sashiko
comments, even if unrelated to your fix? That would save us the time
to review the inevitable followups and provide more coherent
refactoring.

>  net/ipv4/tcp_bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8e905b50dead..a30475afb6f8 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -604,7 +604,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t size)
>  wait_for_memory:
>  		err =3D sk_stream_wait_memory(sk, &timeo);
>  		if (err) {
> -			if (msg_tx && msg_tx !=3D psock->cork)
> +			if (msg_tx =3D=3D &tmp)
>  				sk_msg_free(sk, msg_tx);
>  			goto out_err;
>  		}

