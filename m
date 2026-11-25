Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635939;
	b=5g9/Xfg5EInx7S1ltZsZCzUzd4BD7l04CAtdQn+h5KcRvf+rfh663kC4E1n/7TF8ipZy
	 aGVvMUDKIS15HehWZaRXE41601q/46Gf2A5kZ3Lw8V1xNXIcKI40n0DZImyoIcDGu+t9M
	 tLYcTDjo1Afj5jx/n2uKrsbsSWNZQCyG1qrTvWFP90+EVy6ImNKzF0OaiL09Ev1SbwqjZ
	 epg9ZZs+JU01iWTzqhoqGrckIm3AgfK26GUUobb9cxM8PQCezO1F3QqhjlYpOJOFME6kA
	 KmnmRu47kCPRf1dxevMXU3KVP6J4lekhyVTNRmQVljipXsdpJHX5H8qfR0gZ3B0+LGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hFd6xvy0hW/uykhyNQpUH9l2XFVSW+p2LbIu+VEJclY=;
	b=D2T7JumT2BcxMQ+dxWjEjUtX1VkcRecvA41GOPgZ/kus90zfJ3Vut4qYc54fADzJnVXJ
	 7LzbubqXh2F9nZ4xQ+4zxYH8fdmIiKxKPftelOeVYja1v/8KrozHNgm9QmIdaOt5wx4Q0
	 8ARz35N0qD425Qv5ODQD7zgwNDqSjHQUYlmbxjK5cum5S5v03elGsrmqOaRH32+r0oBtc
	 I4jbUizImqJix2SS/FPvqxwE0TO34y4iVMcy5k8JRnp4ku4+nMKpey24ZSG5q54ZDfnTZ
	 2feUNmxLMNq5LXWkw/x2Q4+CRpessFTrTWKFk8d4XNuFRIZ1WWp7Pl1qtYzlyN+OwMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=cy44b9Al;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6CF606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC6CF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=cy44b9Al
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3869f03af6aso5394835eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795635938; x=1796240738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hFd6xvy0hW/uykhyNQpUH9l2XFVSW+p2LbIu+VEJclY=;
        b=cy44b9AlmneDmpHr/wymeRnnlTOofyaqYzeT7NgyNbvpSwOALzn661/w4m7F4lnjTe
         8qO+lLe0IeNgK5ix32aVb1mmXkZGzllW0lrdNnwxqzYL3yB2DCEHteUDBwWPJxSAAcuZ
         ml+yYK1ZOq7jsX6fsZLhkeoZC1DNHWuYGJlCu948rL/I27WU+PeBfn0bZxg0JANtSF5Z
         H9RYvMMoQwnFukucOFr4A77vT0p/H21sv/J4OOypIiRl9iPOgzqCj5UmI3SFVWOMDCeJ
         lkVSWhlw/hXemh7SyQ1cWEhAaiKxubKoje/ZIjjHtXiH2EyXAERRWODqYGAwrkYLJvHT
         V4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635938; x=1796240738;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFd6xvy0hW/uykhyNQpUH9l2XFVSW+p2LbIu+VEJclY=;
        b=ZxGDtyy0S2OJ1dJmImr529GU7erVmMh+IiMSL6HNLOd06hTJFTUeCZ0ezU+IyQsYtL
         bC9OqICHDwTyt+6oh0fqhm8OKxH/Iqp6CFEiEqF7IOnB9rqmiYcco944efMav+WrnS0E
         i2FKyHW8GQpzpMTvB764hngMFRbkf6kYfgYTBSXXQnABtYwUV7Y42pqMiYvCdGV5SXu1
         iZsLIHbSm31KRVtCSwbCrPgOsz2/z3DVk8m8jh2ezOmIDxGvDcf/rX4k0CU+dc9y95d9
         +Bo0JR0YO7T+7ZulY7RubbA87kSYj1Y+K8JZwq9L7ai3+AVEkl2eUGKI+TgXA85y085K
         7jLA==
X-Gm-Message-State: APuU4Z/RFzujKxJYZW1TxspI/Rd7NJ4UWpi3ETvV0NAx6DrgAt8VnQlJ
	38ylCLtz9MiManpbPAM++uw+dKawcfQTkeDvI15FE6qtlYF0NqGVT5wMYZZsdfajgmg7EPmn382
	P9QX3bOc=
X-Gm-Gg: AZFdTZd885ejiZlESl2guMGhbZOjNqa8ZksyfB3rFxwW5AID8gzSTbbv+vK0XL54hT8
	p9geo1wHjb/jcGhrFOGj8swxbwzR3DVONXpfMzwOiFuKeH6gbzGktFgubmv7qwgQDDHKdXVSQ86
	Cn0r0691P59l7iCVXoYtXcNzhPwI5IbPP3jcJcZTw5GPX/PDKqd7GHmu+j71LY7vgCcl+FG2o8d
	PoZqiVvEvI2guHLwC6dAJi+0XsrUNMOhwPJZDeu4YkYUy73uHGbWEfLE4SGEsnvRZ+4NDWASfzJ
	+45DhIYJPw5Q43h/+78xCYC3YgHkNBqDzdVWLcIGS9BqSeM3VyGy06RhmXjt/jPMQnFZfpHxFiZ
	baawtcrKubqw26Fqw3IyxII1xKU8ZViTs+YTh0sgi4rsGfRek/WT22ohjTabatLmCw20yKDE8Oj
	SqmJtd3o3OEoWZRL99zKBype/VM2LYe/HsQZosw4rjqbN3XTeat1CL7AfPF9739bzVaRMD9SaCh
	4sBDRRUC7lmz24xnq6M8Vq53jOi2fkJLe/8wYmNQSsaepf+I4uJLIjdj7qqq5WTWVwBwydxsKbb
	VpZckbY8kkhguTRvxjoe89pOb/IJvV8QuD7qi7QM0TDltKGSSybVs3aKeFwEFWMOlftTto6ItVT
	0ySin0mqGVYJ2pP6IYNHasESbTw==
X-Received: by 2002:a05:693c:25cc:b0:369:f17d:efb with SMTP id 5a478bee46e88-384b3e77699mr28669992eec.10.1795635937926;
        Wed, 25 Nov 2026 11:45:37 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386d605c894sm3737730eec.2.2026.11.25.11.45.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:45:37 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	bird@lzu.edu.cn,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	n05ec@lzu.edu.cn,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tomapufckgml@gmail.com,
	yifanwucs@gmail.com,
	ylong030@ucr.edu,
	yuantan098@gmail.com
Subject: [PATCH 6.18.y 0/2] 8021q: reclaim cleared egress QoS mappings
Date: Wed, 25 Nov 2026 14:45:32 -0500
Message-ID: <20261125194534.52951-1-artem@trailofbits.com>
In-Reply-To: <2026050408-ideology-liftoff-aa01@gregkh>
References: <2026050408-ideology-liftoff-aa01@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Please apply these two patches to 6.18.y. Together they fix
CVE-2026-46153.

Patch 2 (upstream 7dddc74af369) deletes cleared egress QoS mappings
instead of keeping them as tombstones that accumulate until the device
is torn down. It depends on patch 1 (upstream fc69decc811b), which makes
the mapping lists RCU-protected so that a node can be unlinked safely.

The May 4 notice in this thread reported that 7dddc74af369 failed to
apply to 6.18.y; its prerequisite fc69decc811b had not been queued. Both
patches differ from upstream only in one context line, because 6.18.y
predates the kmalloc_obj() conversion.

Both commits are in 7.0.7 and in mainline since 7.1. 6.12.y and older
stable series lack them as well; this request covers only 6.18.y.

Compiled net/8021q/vlan_dev.o, net/8021q/vlan_netlink.o and
net/8021q/vlanproc.o with CONFIG_WERROR=y on 6.18.65 from a cumulative
x86_64 tree, with and without the current queue-6.18 patches. No kernel
boot or runtime test was performed.

An LLM was used to prepare these backports and to check applicability
and stable-queue history; I reviewed the result.

Thanks,
Artem Dinaburg
