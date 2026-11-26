Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657416;
	b=ZyNwthcTIXTRUt6Z6y6RdRQKiU+3mBMAA7KbJ+ZslVhgxTWs2sGa7kHyM5cbHc2+zESr
	 2FBFuSPvlVxNU/fxIVjcQi1BX5g/c274iq7BXCHFnwoE5OP/p3M1XKOWKESp/daNsx+5P
	 /YZyjkATC0HZO9rN4PsGyBouEZqHsSZT643T42Nkt7uTPIpvKYYw/2xHbppeK/B70fpUb
	 Hx67bRdZymMRbpfDzdEG6tH1T+ynOlaLkLNFIi7Gmt13E0e4SH2Qb8Llghl4sT2ka3n9j
	 OnwGqDZnRfZJPCG9CDAHSjf7cixhAs1zmZFP/QcVF245tAtXtRTTq+aowSh6J9WSFjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8IuEO7UE2YPsr6kQNPAUlV208dDrufnV7pr9TuunrwU=;
	b=pPbJ04UjgYSkOkNHN+wQEzsvz87y6DfxooednDd8sUkz/tCpw7J5PAWHAZaHna8jc0xZ
	 Jz3TgfI52NKQrYg2+O2oNe15PuHgKj7OFutXdeu7GH/dTNacBs0x7wzL28gtfBgipWWAe
	 hu+UeKJay16I2606lENn76axyPYVKDlMv9no/Cqb708Fw8EhrcLJSxMjDVADJEdfWr3pY
	 XOJ5EVo4yig6YEJOWNYRo+j/+gz0CgACKsDEEgFkcO0g99560u1gqmmfItDPiQjTejkQ8
	 w/KRGjd2Qk9K29jwACXKr13J5UJTm909ZsvYqys8Le1KIM4qO5daeyZkfV30b7YXoNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LfygWFme;
	arc=none smtp.remote-ip=74.125.82.226
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A9606A32C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618A9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LfygWFme
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-3866a784546so8821241eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795657415; x=1796262215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8IuEO7UE2YPsr6kQNPAUlV208dDrufnV7pr9TuunrwU=;
        b=LfygWFmesZKKfM8+8Ky9IjZuIRANhsNbfh2Xy8WPJVf2zC/b7ecZoMEtERRuiTeh8P
         CkDHvZDrCMJedrVyfZaJ9zc7pGMGcBNjBo1PNM0/wL0Wod7iBIXgSyNkyrX/aIq+wXYu
         mBIJD0A3OIQDehbTN8GfWQchcZAoID/aYkpel+blHSaZFQ3IVVo8XniZdVgRu8u7K/1E
         ZNqTbF2ZPnsh6toxBjIT2GWb75wD57NMAQrZ3rLmYgGUHDtgN9EmbftVd12I/eab3NVG
         gfjjT5uXFbR7sMXKvdLBV9qfmHktvM5uldH7LgGTG5hHD5V05YJD/O7xLpChNk6oXeEb
         gkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795657415; x=1796262215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8IuEO7UE2YPsr6kQNPAUlV208dDrufnV7pr9TuunrwU=;
        b=MKa1n0zV455MaoerxzZyie7pqVgHyipPjmLpWUmDVQq36pIfEupc3yYrkXEZbcRlyX
         ZY+JygWfPZ2gQ8ZDTc2bh4MKsHxFXOAHzck/AVoEUu3HHzjBJGBQgzhbq6iJDV/aMF8h
         MjnYqOP6PodjAKfWvTCrkuonokusfnT9+KWjStdlTWhGFhUkKE1PvXfKALYLtFDZjCxg
         hMvf05pXsXJCV6xjXHQ79BgW8maEEhVfs0plrGXif7wutZXWd6HIyIKsxzDSLsvk1Yr7
         l8gK4IQDnsNbRlnWzzi81/OwklYa+B8xlmTph3FgM9aokm+3tvdu7/I/6mDvjMhiTgPC
         PFjA==
X-Forwarded-Encrypted: i=1; AL+hErHir1YpbsDFn5xGgVQxbQRUOjxOt6e2FXv1ZbjYsWtzqUqRjDFg+A8ouaOO0tlJYLpuGyXHMBc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ysAkPaeAFDYPebbGCrtytV7cS9dForDVEMnEeIQxDVdbR0gFd
	ImDeUABwceyf+58ifR2JB0uyJm6kbH2SPX09dErcXzl++HbOwJQPZ42ZOVKsqCyns3zxSlyYJaC
	7vzgVZTTQJqc0U7GngP6H1jE7lMEvQRCQzFFP
X-Gm-Gg: AZFdTZem+4/sFj0zWv8zKRSavoo7nXAg88kvsBpBVx6p5raze5Rx0ZuhlZA4IOU3ca2
	MqfmU62EO2ReGlN9uIFW+N1++qp0fNM3MQt1ywvJre7savu3yKUzkmLeytvyl+BkxiVL4uY5IJV
	khGmuvMWV7bbPrJOcapPqLhXyz0BywGTzoJI5UL2hgqPAL5jagJvGV//50qBnWArAnpIy3zviry
	wqlqlW/CbJsDMOOSkw9mlsWxCxwJOE8rUfmNUAVMSL6f6gAH7ghn1fBAjTlYsEf1tMTBWyn5JGC
	fdyKKufYBceUV9BF1fz86tCPNdIYjIj+FqFwh/usmSyHNAEZFM2R82Rodk/XHUT0PM/bD6SRSvE
	Jpsgk27x/K6SdvBie33HOkLcIhBDlT+rNV7w=
X-Received: by 2002:a05:7301:2e30:b0:376:19bd:2af9 with SMTP id 5a478bee46e88-3856c2c4a0dmr22218236eec.5.1795657415329;
        Wed, 25 Nov 2026 17:43:35 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-38566cd605dsm2953154eec.12.2026.11.25.17.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:43:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 834BB400B7;
	Wed, 25 Nov 2026 18:43:34 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 80281DC0C28; Wed, 25 Nov 2026 18:43:34 -0700 (MST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	stable@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Alice Mikityanska <alice.kernel@fastmail.im>
Subject: [PATCH net v7 1/3] tls: fix socket use-after-free during device-down
Date: Wed, 25 Nov 2026 18:42:42 -0700
Message-ID: <20261126014327.1638133-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126014327.1638133-1-rjethwani@purestorage.com>
References: <20261126014327.1638133-1-rjethwani@purestorage.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tls_device_down() takes a reference on each TLS context, then drops
tls_device_lock before setting ctx->sk->sk_validate_xmit_skb to
tls_validate_xmit_skb_sw(). The socket can be freed in between:
tls_device_sk_destruct() calls tls_device_queue_ctx_destruction(),
which drops the socket's context reference but does not free the
context because device-down still holds one, and __sk_destruct() then
frees the socket.

Set sk_validate_xmit_skb while walking tls_device_list under
tls_device_lock. tls_device_queue_ctx_destruction() takes the same lock
to drop its reference and remove the context from the list, so the
socket cannot be freed before the store completes.

Checking sk_refcnt instead would not work: it can already be zero while
queued SKBs still hold sk_wmem_alloc and need the software fallback.

Found by code inspection. An ASan harness running the extracted teardown
functions with userspace shims reproduces the UAF before this fix and
passes afterward. Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).

Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
Cc: stable@vger.kernel.org # needs commit f08d8c1bb97c ("net/tls: Fix race in TLS device down flow")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index fa7170cd4fd1..3ea764bdc949 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1345,6 +1345,11 @@ static int tls_device_down(struct net_device *netdev)
 		    !refcount_inc_not_zero(&ctx->refcount))
 			continue;
 
+		/* Stop offloaded TX and switch to the fallback.
+		 * tls_is_skb_tx_device_offloaded will return false.
+		 */
+		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
+
 		list_move(&ctx->list, &list);
 	}
 	spin_unlock_irqrestore(&tls_device_lock, flags);
@@ -1352,11 +1357,6 @@ static int tls_device_down(struct net_device *netdev)
 	list_for_each_entry_safe(ctx, tmp, &list, list)	{
 		bool free_ctx;
 
-		/* Stop offloaded TX and switch to the fallback.
-		 * tls_is_skb_tx_device_offloaded will return false.
-		 */
-		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
-
 		/* Stop the RX and TX resync.
 		 * tls_dev_resync must not be called after tls_dev_del.
 		 */
-- 
2.50.1

