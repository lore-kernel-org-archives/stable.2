Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824575;
	b=vZEvyZ6ZrrQpZGVW3BZowYUdr26iMoAa2g6/jUF/GJnTb9Zt+Tpa2yZSfFCbhGhvCJL/
	 Abw0VI/mGVBhPstdBR4C8kJe+zVmXdC+qLdH3hWbIkAw3+6q3c39jjS1Hvbjmzv+G3+vv
	 y4uIdEZE3wmoyqoksF7yBN/rzmTOWmzp2Azc8vH1gQ1AJUcnMgupQqaIYm7ywI2N7b79x
	 vAin8fUISAxICHiaqQL/qz4ElJ1xX+k2iWCI0C54nXV/JqN9ySGPPWiQtM1RlG1GdKXgw
	 LDls0r3I5vK8vfJTw4e1mO9DhK6nfel7dyFhVrSVySsu7qqahjbisFC8f04SULgxXBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=VwPEOH6TnC9eq0kvN9U5QGgPY1fvhRUkSYpizPQPnRc=;
	b=W0k0IQ6qSrdx2DN8jJHVp5rMarrCXb4Av2DtYoJPEK3nqGN+EDYzK6qQGrgPBDokksQj
	 RBUmnfjG/7Jy1TXeiMGj1yOh92xTWdBUCfLFW0Z6iWvAUhGeZO1GimJ1VorbUGRFQFWCr
	 eSJMeeScymIAKUP61ROn/3pBalNv/fKBI3y2X6wNSlyOz3F4yP7ib8Lailm5/KZWGhpP/
	 eh7m80WrSckECILMbcjvYOHFn8e4wZEq91cUbVSChP2a8DWvi18mJ7WgHX2CG8WYmNy0r
	 9M3rJUVN2xuztGNgAMCiH32YHjC5NQsgbiJ1U3OWnVlduSrLZ/uUWxANwpwKjRiMd1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=awiKX9MW;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1F6075267
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E1F6075267
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=awiKX9MW
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53cd0c8614eso7475091cf.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 12:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793824574; x=1794429374; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VwPEOH6TnC9eq0kvN9U5QGgPY1fvhRUkSYpizPQPnRc=;
        b=awiKX9MW+jQ/pdyMQdy5h1Kdt8Ffbv5vW1j2PVua0fdRVCyzRn/omf16XlmjmEm1ZP
         73LSi8BQEugNpgM5sLZtYBz7MnLwufSsK557NzaoyuzhS/B4FmyVGl3VtGXEoIyky50L
         9AE+frPji8xMLgNEJ276X4Hyo5FDkpUv2Hn+HkRPxxuULdYHsrAspFJCRM+zZPs771HG
         J0T0+AyqUejnXm+zJVP8iDGjzjB6fi145gQtY7lAEHXVqWqHEOgd9xWJDbx8gFrJRjDu
         t7dnNwY6Dmbj5fYjA/wOYbq5jUg/7x1SvaU7U2FOIb4i5lYriTnKXVzGZBS37Nmetr+W
         7sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793824574; x=1794429374;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VwPEOH6TnC9eq0kvN9U5QGgPY1fvhRUkSYpizPQPnRc=;
        b=o4Sjiiqs77cGRZCdQD2lxQUpccY0g/PlaMEizZ9flkV0CtnboHLtVDgSFG7pNZF71h
         3HhjjqNAS9Ncknj5Y3xNkkufBpJfXGBtPNtuN2xqgKFR40dTGjuf2vbLAeCv8Ebc31rX
         41D/q4CAkLJiiso9eI6kkW+v0PyZJmWzEJoVt4aBA3cPXvZEqqPIAqiN4MWvz50SpkbP
         tTLpmvEcy/TMwI+UbMmmmLI2sabtbRpmnpHILUNhCGxKJ8fPq4Tk/wPdMVUMDO+VFain
         pLYg/R4yRI8570Mt5JcB2gW0GPBw3uXSDKnU2tALgWS+JJaWRV28WO1yfH0uTkRJ660F
         0F4w==
X-Forwarded-Encrypted: i=1; AKwUvByuEKgHQhBIPpMwUSb05yTjEx3b8KNcWTeEsc76VpLEs0Mkm7CAI+4rCO8XwRtyjMIA11rLqY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ostme9yzN5Vsrg90i61HSSU3kXw8booFO/0SdoTjWb5FWr7OI
	64kg4KdAADsCqN/QDbnCHZQejy38yGpOpnG/yKtRmuaAL0ccaU6Uwz8TyQi+pOCccQ==
X-Gm-Gg: AYBFou0wD5fRNPoXL6CuUApSzXcA/hSGCyiAm8B78Crs+JZa645Gy5pjjCjC1VgY7XU
	HiGLCD1/82CknePJnyIgx0w1lyuUMetG5cdjEnQMgNHjIUqR6+oo35vI0ab2/0mAOYAiXJc3lWw
	cFLMObOLjSGyMDJBtqPda0CLNw9LcOX1Aov5W7g3B6eGt6LZvp1O228o0nkQsCJepj3WuyzhvDy
	J6cFK9bnQTsbaaDH1aCdulNWmSEkrTeELpzKAOEpulPQ7ToHLHzUUClKkkEQTedFzcuvdiXocwT
	Jvj4yXfbeE8mt/IMLQh4kfo3w3RXRtsowrOBCjNnVoALROboT0bf9kHGOwW+4aOUcIS9YGw6Gt5
	pyFpQ4vQ3nNPE6LvDShUZ5cGI1eQ9d/Rql6wKD2MDu259vyWCpM7u9oL45rhXhvFS4Wo4HhSHLD
	I16ZHU3y9+/sERHIvsDZpZJkg2GhGUVStiapTCEsLqOaZOOjuCzaNvC3L0LK98MgLec+QuRZDxy
	BX8y6jmU88pe4fsSGRQumfSCEo5dxbKZ6DWnxLHRTRiLm+OwVDcu9W3duQVh4I2oh71bQAaD9WN
	0BsHxAePumW8gIJbG5jNPfYewc1PpGAlp8u9USbBJ5MMCKt5IlbdQnhL4DpizGmlQZAvc5zcS1A
	HVlE9EuoyCxJBLQiAxgDs3bbiRpHmQg==
X-Received: by 2002:ac8:5d46:0:b0:535:9798:3f0c with SMTP id d75a77b69052e-542b6a6d944mr300331831cf.34.1793824573629;
        Wed, 04 Nov 2026 12:36:13 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4dcddsm33431391cf.20.2026.11.04.12.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:36:12 -0800 (PST)
Date: Wed, 04 Nov 2026 15:36:12 -0500
Message-ID: <b446cedf8a7977337389f8cdc1e5acce@paul-moore.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261103_1853/pstg-lib:20261103_1851/pstg-pwork:20261103_1853
From: Paul Moore <paul@paul-moore.com>
To: Bradley Morgan <brads@mainlining.org>, =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>, Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] audit: fix UAF in kauditd_send_queue()
References: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>

On Oct 31, 2026 Bradley Morgan <brads@mainlining.org> wrote:
> 
> kauditd_send_queue() grabs an extra reference to the skb header before
> netlink_unicast() since it may need to retry a failed send. If unicast
> delivery reuses that same header, the receive path stores the
> destination socket in skb->sk without taking a socket reference.
> Consequently, after the receiver consumes the skb and closes the
> socket, the extra reference taken on the skb header makes kauditd
> release a header whose skb->sk points to freed socket storage.
> 
> KASAN reports a UAF as:
> 
>   BUG: KASAN: slab-use-after-free in sock_rfree+0x44/0x140
>   Write of size 4 at addr ffff888004f94140 by task kauditd/31
> 
> Clone the header before netlink_unicast(), then use the clone for
> delivery and keep the original skb only for retries. If cloning fails,
> handle it as -EAGAIN so the send can be retried.
> 
> Fixes: f3d357b09295 ("Audit: save audit_backlog_limit audit messages in case auditd comes back")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  kernel/audit.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9412af9144bc..5e739fa606be 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -790,6 +790,7 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
>  {
>  	int rc = 0;
>  	struct sk_buff *skb = NULL;
> +	struct sk_buff *skb_to_send;
>  	struct sk_buff *skb_tail;
>  	unsigned int failed = 0;
>  
> @@ -810,9 +811,11 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
>  		}
>  
>  retry:
> -		/* grab an extra skb reference in case of error */
> -		skb_get(skb);
> -		rc = netlink_unicast(sk, skb, portid, 0);
> +		/* Keep the original header unowned for retries. */
> +		skb_to_send = skb_clone(skb, GFP_KERNEL);

As Bradley pointed out, this appears a little confusing as the existing
approach of skb_get()+netlink_unicast() should end up doing something
very similar to what you are proposing due to netlink_unicast() calling
into netlink_trim() which in this case should always end up doing a
skb_clone().  I'm sure I'm missing something, can you help me understand
why this proposed patch is different and solves the problem?

Also, do you have a reproducer for this?

> +		/* Preserve the connection on a temporary allocation failure. */
> +		rc = skb_to_send ?
> +			netlink_unicast(sk, skb_to_send, portid, 0) : -EAGAIN;
>  		if (rc < 0) {
>  			/* send failed - try a few times unless fatal error */
>  			if (++failed >= retry_limit ||
> @@ -827,7 +830,7 @@ retry:
>  			} else
>  				goto retry;
>  		} else {
> -			/* skb sent - drop the extra reference and continue */
> +			/* skb sent - consume the original and continue */
>  			consume_skb(skb);
>  			failed = 0;
>  		}
> -- 
> 2.47.3

--
paul-moore.com
