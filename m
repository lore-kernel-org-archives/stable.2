Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792869444;
	b=Dt3OWwx7ZlNDgM2/C1UTFJDQctLfDYVjpTFj/WM9Qs8Y+h0MN3V4kEX6Tn31XQSGOMZB
	 M/SH5LDkKtGvqT6qGN5RBINbGWNrAuum+Ws3x2ui+yCa0NDvoAorYsUtELjomJVLPa5gu
	 qj4DzlJMdXNhHW9bw1mzcZzNfr1K+eCllBeRjcYTfdcsShKc+cCok/X0hWho4OAvUZqN2
	 LEcPXB0UW2SL+kqOZ/zN7DQmNOMfhHC7pvKUP/Tf/NrPdaJZI4sP3lGpG1e0Yr12YZL8l
	 /pXAj0XDqGWWANHc8NNCsH3yCzwtMjoDSM5KnAH6w51kW/zWGs4CyonyTGR6z2FGu/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792869444;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sVfI4KyrUShXCjGYS9SP+z/1pUujMW5B9wFyMHkKevc=;
	b=Q/Nsqfqm/wbLmhxyYKOveV7Ji/nQoExvVptDjZ1q/syR0pnmstoEskyDs7L7A4mvGc5d
	 ZWOGU+oahmZzRhq+xNl2zkRFrMjnM2T3QN993sox8gyzRQ46Dpedb7rECZO4j3s2diJk3
	 6W0wQw+6zjS/uF2GyOjbBSctMuhOIfiSU1Hkwv/3/XJEK55UWR6PJXLYLWa9mFZhR03vl
	 ZXdxpYN/uILQXz73GsC+F8CX9axqL91XMFrTDpASMx+FrZCTqPr0qpU5XieGv+Z3nz+r0
	 x7AdKdfmi8qE7GweFpGMXq5GK0zSWlYIpY/UktRQeCDo/Ky7gy7XO5mHuh1e0+QjMfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqU00Jpq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B6606A31A;
	Sat, 24 Oct 2026 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqU00Jpq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792869443;
	b=DkbpE+FV9CVLcRh3Yv7D61KH/rJ2knFxw/KsmTMsvZYQF0Ct/ny3AfQY3/5rWfShQ7dA
	 +S8eBaqFLNh0Gor8+a7xE49UEMJXrJyaTrI+j48u428rbG1Gec7WZa4dVzGB5I2MJSGQw
	 I09X2osR9/f9RQ7/v798XVG84QbZTQpNm/e5OVtq2AuuTQaywJrJWfauzHucA9s3RGUai
	 CeaKsoMvLU4yH8k0mIqiZ7pbLVGEMTFHenTI/mOxUXQjS5zitoFeNsb9C1M8NVPFBAQZh
	 x2hF+uv9hulSxpHmdtetk2GhLNrX37JI2WXN1LEHMTw4Pa7C9yS2qHnlySDnTtuRL2g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792869443;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sVfI4KyrUShXCjGYS9SP+z/1pUujMW5B9wFyMHkKevc=;
	b=QZRvXo/SL0BJ/9l30fAniF8RQRGEIZ81pGcSvz9apSP3EiDDEpI5mGNDd+FHknDyBDbG
	 bNnbFtQ4TT+AsuJ3RTvFlfR71ODSvI1PyXdjuXeYfUtCSaLZfrJk5ORV5bsu3JBAuh2ls
	 j1D93GENwE2MjZziXDjAA5N7Jyokiz269g+jROhZO5d7ll28/GKHbpUUdpHym6zz23aca
	 VRPZP/H1jfcZdLIHMXt5zAxzSNJkNUSiQ6pCVf2uDXxRsaGPkyHpMFCMzk1OFMeLGumHi
	 3oeDaRp3P0pvOD2Pyw73j0fsnIVpQNZehoWfan3v88s4leDmbYD83e1LmTIrp9JWA5Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C65301F01829;
	Sat, 24 Oct 2026 19:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792869443;
	bh=sVfI4KyrUShXCjGYS9SP+z/1pUujMW5B9wFyMHkKevc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eqU00JpqrO+WYXM54wpQW8yRMGVo626GNRHSAwmhKViJhfjeZvOODO8Lmejms72NR
	 XAEW1mx9oi6HGtzho28ZkkRZqbNhg6yfGmCR6nFFDaHi2UEr1OMYGm0df2duUgZps8
	 fjZGA6LHHbY7ke0uIhcbsIAon1bkg+dV/6c0XTPqYB2FM7aGwt65kmKXZaJhClylYM
	 a8lZZpWNSZc6FsIqXKtH8D4d6YFsWykb+in9qgm19yu9EAIdV+zXWAiVTcJyOWzkBT
	 lW50K9sJzEQX7Dmnb+5s1xkaRmd+qvA5TJ6Bsr2+EyjQxBC3xhBeblnmvU0Wz1e0Fd
	 k40DiIxAI/MIw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3146C44856;
	Sat, 24 Oct 2026 19:17:22 +0000 (UTC)
From: Moe Mahhouk via B4 Relay <devnull+moe.flashbots.net@kernel.org>
Date: Sat, 24 Oct 2026 19:17:12 +0000
Subject: [PATCH v3 1/2] virt: tdx-guest: Fix timeout detection in
 wait_for_quote_completion()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261024-tdx-guest-quote-poll-v3-1-6a83bb767314@flashbots.net>
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
In-Reply-To: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
To: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Dan Williams <djbw@kernel.org>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jun Miao <jun.miao@intel.com>, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Moe Mahhouk <moe@flashbots.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792869441; l=1997;
 i=moe@flashbots.net; s=20261021; h=from:subject:message-id;
 bh=1dO6LibjB5hJoJz8TEcXao2BEcsRzIPKbgLEX9gGRKg=;
 b=kFo+JKzdDObF9V4MdTRk+Dqjc6ScwZIPR96NM7xblgsfwWLCsglgd8p3ufy+O8PyZ6JAbr0Yq
 b8dpUR3B84iDcV1deEnp3tkRkkOcNwkFtihXvXAnfjWJFFdfVONwT/A
X-Developer-Key: i=moe@flashbots.net; a=ed25519;
 pk=hJTKfjLno/YESrpxMIKDJk34GM+/8Tol+24XK2b4xf0=
X-Endpoint-Received: by B4 Relay for moe@flashbots.net/20261021 with
 auth_id=1259
X-Original-From: Moe Mahhouk <moe@flashbots.net>
Reply-To: moe@flashbots.net
Content-Transfer-Encoding: 7bit

From: Moe Mahhouk <moe@flashbots.net>

wait_for_quote_completion() counts the seconds it has waited in i and
reports a timeout when i == timeout. That gets both outcomes of the
last second wrong:

- If the request is still in flight after the last sleep, the loop
  condition increments i once more before it fails, so the loop ends
  with i == timeout + 1 and the function returns 0. The caller then
  returns -EIO instead of -ETIMEDOUT, without the "GetQuote request
  timedout" message. Before commit 0f409eaea53e ("virt: tdx-guest:
  Return error for GetQuote failures") a timed-out request even
  returned success with an empty Quote.

- If the VMM completes the request during the last sleep, the loop ends
  on the status check with i == timeout, and the function returns
  -ETIMEDOUT for a completed request, discarding the Quote.

Decide on the Quote buffer instead: the request timed out if it is
still in flight when the wait ends.

Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
Cc: stable@vger.kernel.org
Reported-by: Kiryl Shutsemau <kas@kernel.org>
Closes: https://lore.kernel.org/all/atoHWgQF-0vlTRK4@thinkstation/
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Moe Mahhouk <moe@flashbots.net>
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 11d741da3b35..a5a53174f9d9 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -282,7 +282,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
 			return -EINTR;
 	}
 
-	return (i == timeout) ? -ETIMEDOUT : 0;
+	return (buf->status == GET_QUOTE_IN_FLIGHT) ? -ETIMEDOUT : 0;
 }
 
 static int tdx_report_new_locked(struct tsm_report *report)

-- 
2.34.1


