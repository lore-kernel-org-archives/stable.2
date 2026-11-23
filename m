Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472991;
	b=Vb7fxAziA3WOsWjm2yWdfXVGeGbc0Hn3WCw5cf38Lb12SJEVYsL78QcUN5/o/v8dlhQb
	 u6cg/cQgZUYAMnJFIRSayfXHYweadQFbkCsPMH9LM2PA16ddOB3DdS0TDEHK0Z5q1iBoX
	 86nQQ7k+AO3I5OZjPlxvkzTgaK6JImKehj6PJFnbHyVvoTWSbyz5dDdbJg2o7az2WzOtL
	 96CMYfhnHQymVpYzQeQ9YDVyZG9Dio26NAMZchM/NSOSP7MONlR8nwPLK/wCT8egYX7G6
	 MrgBht/PdCOP3mSG+VGkvUcaEqdw11JYoEzt3Qwk0kYL050QNGWKthDH5OcdsKe1y5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3JpkN8yBGxXncc2qsJWmcApW+Kp2uQUu7rRgDcYYsis=;
	b=q605fGzgi0xDkv4EcAMFQX9YSW8wqN6E53x66tMQ/yr+9f78TgCJIsz5Kg8zPnuz2Tet
	 VM3rOwCdkMmUrqhDVjMd0eIAT0tqh7A56WCRGtPcpshddH+u9GR2LKiP379ETPpsnLpww
	 iX0btL1ylfE1TlwMstC8fgVfYSP7JZjTxu0A57D4IWdqV9nA0YJ20cKPrwfcJV2AsLvNy
	 EN8pZTFulTjt6Q5D5cIrVExUY/ry8XWKxUA77+p2CnjEQsPKu8mWu5mwBPx8d5Hq2YXUN
	 TyN9lAFqo/wTM4SjzU66sf6lyyqk2BX14zwara65EGtoX/0TYP1D0gvq17ymO3whpTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b="c/81sGnI";
	arc=none smtp.remote-ip=74.125.82.228
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAD6606A681
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAD6606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=c/81sGnI
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-380c28f9e35so4982361eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795472990; x=1796077790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JpkN8yBGxXncc2qsJWmcApW+Kp2uQUu7rRgDcYYsis=;
        b=c/81sGnIBHWuNQeC5+cUN1agLTlnSU28pV0WdEE8hHBDmXNhzMI6T8ZLnweP+r442g
         h4qe8oDcLmL2giGrXI0T2uVe6ryyftAEY/ksMciZPx8pGBbKjlqY8Sa20ooyZapY521+
         yMfJI39a5Jh5wgHQA03vPLwyJO36wjB2yLnLGtsVTIehLe9grYI0yYphwQJHIqvx4eRr
         1FUW4aLRX/mzUmJkNJ2I6Fj94AqnoxBSJkncFXofPT0rMTGgOlN3ashOzXl5kGUU3Chi
         lHIHEqto/21n0N2JdOtu6mGjV4y1N8uxMuiWoeC+T0hpgluWSArsnqmEdwUAzqdujalJ
         Wg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472990; x=1796077790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JpkN8yBGxXncc2qsJWmcApW+Kp2uQUu7rRgDcYYsis=;
        b=wb6DaNL5NTxdGn8/KmvM6jozssrXx/MhIlbiDJj8smxC+7JNW8RMc4C1oh5M3H+68X
         QZQJr2OYA+UCJsZdyoYCDtZWXNavaAN8pMfbr+sr12TQcNn+qqmfQaih0qSHjuZ1DTp9
         ZFXriHpiHP+cVhuod/obRBAe5R4eJmNZHMUVdz3uy9NsMKW5JuV+o4d1p8/beCFyW1mt
         dUVlckehmM+Rr1vAqES1xJDSOh4xmx6cC+hAmnOVNmiUR1pLUEcZvE5gukigAXP2bsg4
         ld/lSdsneMSvmK/s6xkTKnPjuYgb3Q31fLyN0f+2I4YINeTsRR7s5WkQSJ3AnZQvRzTk
         HWwg==
X-Forwarded-Encrypted: i=1; AL+hErEdbA/HyE9pRXBX7C1hRCtBx/JMxEqElt7z3IC2dSln8s1m7kFZ/LDGK89rcndQVKzjMJ28XkM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/dbHzQXYVThZWAP7J6+0/Yal0u1VZHRfgNhJPIRlgdhBQi0uY
	JfvY9lYytsLsTv812w48k5Q265LxSc4Fe66m6NxaV3B8uFdPpQpjH49OM4GlVWR43ILdh/AjVBG
	4QKHm/RjDiy1z7oG64M8rqMJC8QOKaHR+tULB
X-Gm-Gg: AZFdTZdor5r0Sgwkc746gQtlGfJP8sD1D02ViRKC3tdeUM0jnmJEemia67ruHpHFgfu
	YuwEhvkdRA/zAAIs77EhQFWnjlxhm4ng9yu2avBm2sEikFEo2wIRStGS9nfbL1s3z74CEwCshxb
	YFgF2oCc5qHQW7gInUHs7FJrrLaDNATKPStt4tMPO5m65i2+vdMDWZ6R4kAnuW/qWsszLA0UBB7
	lWi+Kt8ES0kuL3vskp8MEDAE3X+/pLEBoso06iij4nPqEQbKN2rbOF0Fmys02lLWXis+pHdWd10
	gzoju/psk9i2bODKh00maZvL+XRLsFQPGqnn3bWOqp3Jl9bHcu98/OX5FudIQgXmNaVkKsyYWsv
	2fPBkV1Oy9l3or5STpQjjN28DDR+pCJPQy/8=
X-Received: by 2002:a05:7301:6490:b0:386:9618:309c with SMTP id 5a478bee46e88-386961832eamr11584305eec.22.1795472989598;
        Mon, 23 Nov 2026 14:29:49 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-386a58bd934sm1071851eec.29.2026.11.23.14.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:29:49 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id F057840124;
	Mon, 23 Nov 2026 15:29:48 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id C8EC0DC0D02; Mon, 23 Nov 2026 15:29:48 -0700 (MST)
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
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net v6 1/2] tls: fix socket use-after-free during device-down
Date: Mon, 23 Nov 2026 15:29:43 -0700
Message-ID: <20261123222947.1014041-1-rjethwani@purestorage.com>
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
index fa7170cd4fd1..e4e675243779 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1345,6 +1345,14 @@ static int tls_device_down(struct net_device *netdev)
 		    !refcount_inc_not_zero(&ctx->refcount))
 			continue;
 
+		/* Stop offloaded TX and switch to the fallback.
+		 * tls_is_skb_tx_device_offloaded will return false.
+		 *
+		 * The context reference pins ctx; tls_device_lock keeps ctx->sk
+		 * allocated until the validator has been switched.
+		 */
+		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
+
 		list_move(&ctx->list, &list);
 	}
 	spin_unlock_irqrestore(&tls_device_lock, flags);
@@ -1352,11 +1360,6 @@ static int tls_device_down(struct net_device *netdev)
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

