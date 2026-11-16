Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854123;
	b=nDvS1DS9d4GvdUY6BI5AD0k9r0pWGQ+DNEzdVDDds2mIl3J013IKSFZLs/0I5AVfEN6k
	 pKEF/UOwx2xa0HPLMkZ9xUOLURU6sPSSVx6PsCVrR9LuTD1kF+jvytWd6ljnOjaY2g+F1
	 O8QGkYIpG1f0CGMGtAFv8CPEB2DuC1N3no8wsD0fzHiOItOw5YAiTTu3RZPjbhjKFgIkG
	 sxH418L7s9EBDMEwCq1NCrrOqvDIZY7tdlXgPjQuMtHeF0/nYIwlUuAR1WMouTFMD5Tr1
	 bZRKUT5YaAE+0KxprgwzSs6kQro3iUI3xqqxJhKdNQDRItGMKsTCc4oYg2mwTNKXyQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ybBx+yBLrmsB2rueTXpUK9n0LGipir6W5oafTHFMFuo=;
	b=yuF9ZIY+m4elKDrZ7ekZQNuFSuetWokAHgHKQaw3J4oS/Hcjgc2NueDLenhh1kG/z0E7
	 bM2VEbfL+/Tbn6eeN5HEHddzlYz+IaPH4pcreYX8N9/AOsB8rdN9Ipnzt4/nfo2XQCqr3
	 RXIKG7KYhXRhU3+16yWQpHmlo/1Y8BF2P5PGFVHGX66OHsBmhUfkwc1j/6caSF9IwszYO
	 oXUS8x5SaIBpjP9ZibYaCopo0dvc2iGvFeFWhY72IfQIjUwUyIrzppHtaEWi6w6mOwA1h
	 kcF9hgUM9neFpaJbT4ZJ7onSr1WaKqWnmRFfpWK3hNVK85KXrGKxS7J44Xn+Iv+KzIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=BZHrf3Vy;
	arc=none smtp.remote-ip=209.85.222.227
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185C606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0185C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=BZHrf3Vy
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93f3c616c84so359293185a.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794854122; x=1795458922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ybBx+yBLrmsB2rueTXpUK9n0LGipir6W5oafTHFMFuo=;
        b=BZHrf3VyjRKqobnF3MURCjTiC3lNjk5+0vUW+bfm91U5SZy77q6VLoysFylbNjlukj
         bMajemJWImxEKcLg3cwOYiyA83VKJht3baXt9DCfq726TjXqXexA9IeZYIvThQGcF7Mq
         z5dFnhxjzuNZqye88MxVx73qd94P2YUX+t4XQEZkOOjIYEft5DE6vNUnm374Nlb4G7gf
         IOwglMCwcjJ24NkZQwXOIQG/LG/vLJ0aB074YyFuy2XsMRxSJEQ41oP0loRQ2d6taVDG
         zFlm55EiTCC+URH5/itjDFqq5B/Rypia6DfZ4MHWBuhLnbRA8EUeyjzJ/B6ZQWMmTyhi
         SXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854122; x=1795458922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ybBx+yBLrmsB2rueTXpUK9n0LGipir6W5oafTHFMFuo=;
        b=nJC0yYm0/MzUUSme1qTSnj9TbwCNhUyTeKQNBHyNHEMMo4C0RU3p+wFWS5FZkoEGaa
         5JNGGxjP8A568yjpL82wWHR0wYJtmwo5EsFPiSD1VKAwjFFN5DmPNwn5Se/+TCYHrBRb
         M2OUTpAg899FwisfVut1Sv7tRoyRcgPVhK0y44nyciDKz7ZQVoiGzECBVg/NpxzCVSDR
         mZ/SCFo+cCEfrBewkMYSNmXNCtnkDEaD7BCHCFA0C9Hm011gVaPH5LJH5lwgVu+EmfYC
         jxPqFisrnBhOnb4aT32y7+UrysRWyQaW/JWc8FUWcz8p7vUxRfj2tQEk7YO7Dk8/AIAT
         PCcw==
X-Forwarded-Encrypted: i=1; AL+hErGhp1xK21IrqR4dtk9qkDuUr3U2cqHTPwrvMa2wOI74zLkGdXCE/e5Y71D00kKRyKM/0m6VBE8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8k2YJax9eo4Nke3gPjSy0EjiJGMUfkRSO3KQ0MI2Jx/9S7NkzF
	B3PcM1CnDUc4Z7+zNdp3yQAnr0wQN1l+nCk801+Y4d5GzUDmXL7KSN3EufqvBj+zc9fpGoQoR22
	MMtro2daN3uss+gh06oOJQ8yZWwhFsIbqS9IR
X-Gm-Gg: AYBFou08lZwiNRlJBpTNwOVmTtYzc6APQvGMiXM5YKbSop8S0QFvgO1mfg4wPstE2VG
	mbzJz2nRSBQnmP/ojjyfp52ewcDe4B9kQPMBS158ahT2hXnpzS9tuVpXWi87PxqAPEsIqzYL5j3
	NSUTiBgvbNBNZIfTu1C+XoE022LS3Zk6Ak9BmC4gsdyhPUn37TJWgkLAY/1+qze542ttR/j6TJM
	46gu2VQ5mkd5IgYa5L9ztumT7dQ3mAZd0P4jTZwdn/u5amL4PoJVvi0idOhaZGkfKupHJRssnqY
	zXVQ790NNR5Urs53R8ndnQAZx+7kLRUalS471GgziqejwMhqBdvf/Z+YaRvyTRbosyIS7AQ8vqh
	rc0/15fh6rsZcJlySQL+usOL1nNOo9F860bU=
X-Received: by 2002:a05:620a:4042:b0:93f:571b:c72f with SMTP id af79cd13be357-9494bb97ce7mr1908980885a.20.1794854122063;
        Mon, 16 Nov 2026 10:35:22 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9494c805f2dsm118548585a.19.2026.11.16.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:35:22 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 6C70D401CE;
	Mon, 16 Nov 2026 11:35:21 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 656EFDC0D05; Mon, 16 Nov 2026 11:35:21 -0700 (MST)
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
	Simon Horman <horms@kernel.org>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 1/2] tls: fix socket use-after-free during device-down
Date: Mon, 16 Nov 2026 11:35:17 -0700
Message-ID: <20261116183519.3314837-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

tls_device_down() pins each TLS context, then drops tls_device_lock before
switching ctx->sk's TX validator. The socket destructor can run between
these steps: the context survives, but __sk_destruct() frees the socket.

Switch the validator while selecting contexts from tls_device_list under
tls_device_lock. The destructor uses the same lock for its context put
and list removal, so ctx->sk remains allocated through the switch.

Checking sk_refcnt would miss sockets whose queued SKBs still hold
sk_wmem_alloc and require fallback after sk_refcnt reaches zero.

Requires commit f08d8c1bb97c ("net/tls: Fix race in TLS device down flow"),
which moved the destructor's context put under tls_device_lock. Include
this prerequisite in older backports.

Found by code inspection. An ASan harness running the extracted teardown
functions with userspace shims reproduces the UAF before this fix and
passes afterward. Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).

Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
Cc: stable@vger.kernel.org
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 4cdfbb57ecff..866193a506d2 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1345,16 +1345,19 @@ static int tls_device_down(struct net_device *netdev)
 		    !refcount_inc_not_zero(&ctx->refcount))
 			continue;
 
-		list_move(&ctx->list, &list);
-	}
-	spin_unlock_irqrestore(&tls_device_lock, flags);
-
-	list_for_each_entry_safe(ctx, tmp, &list, list)	{
 		/* Stop offloaded TX and switch to the fallback.
 		 * tls_is_skb_tx_device_offloaded will return false.
+		 *
+		 * The context reference pins ctx; tls_device_lock keeps ctx->sk
+		 * allocated until the validator has been switched.
 		 */
 		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
 
+		list_move(&ctx->list, &list);
+	}
+	spin_unlock_irqrestore(&tls_device_lock, flags);
+
+	list_for_each_entry_safe(ctx, tmp, &list, list)	{
 		/* Stop the RX and TX resync.
 		 * tls_dev_resync must not be called after tls_dev_del.
 		 */
-- 
2.50.1

