Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874693;
	b=xnCgYN8TzIzrqbFDfO221mFldBNOABLR8TMiCSTfCt4U/fcxBFcfq1fEOAHi9fUt3KGI
	 XsTmBXEIxN6tUfgjSkJoH1xtNGK0AKRjWR1X1Xk3C7ibwcVL2KQkQ3WwcTfkeAycYC1w4
	 9Tq901wOtOzzMY5JFo7lwmHeQhQZ+9hDy4WTwz34TuN4zmrramsRCEaA34YpOapGjyskL
	 ZBGatdPHFHUu/J1vPhl807BzMrcRgDg/fjkOcM1fwpUPcDptb1QsokGP51RGzbiJvBAGz
	 qmhRLCI80b/HlJw5SeJNJY55mn1Ttm3RFe4w+GWTv1QSCPDCJS8S1v8ws53q7hODphA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874693;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=8P7GUwNhhS50WVRBkqOY6jBdJ8Ob0THbUP0oHJyfj2M=;
	b=tE7NcdHV6TYEjKJl1GWms23hYOQoR04I10MPre9DH/JB2iwX+sMP4d4EfMyDuTVq3mC4
	 Ivuug84NJBHCoCwOtMGSGuhpho/k/wq6QP3PXzfTBWToJBhRz0Itbqo3Wj8LgEBgxCwjs
	 3ujMh0s2yaZR34kEhps5WeUCPvT7SrtWMKURiDgEh5BjrwbXgLr3Aft5H2+aJAYsRskBB
	 Mf6LDn8J9InNiRYNTzU7DzkrzKP6GE+9z6aN/wdwhsctWe8hj7CGq7MCZOjeVesa/KR0n
	 gy0dEz1dcDShEQ7xFA9V7p1PstRSfRQh/SZLWoZPkVC+lz36gToYZ9cDxHxK7dEgO+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=lScDyLhx;
	arc=none smtp.remote-ip=220.197.31.7
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A4606A31C;
	Sat, 28 Nov 2026 14:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 004A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=lScDyLhx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8P
	7GUwNhhS50WVRBkqOY6jBdJ8Ob0THbUP0oHJyfj2M=; b=lScDyLhxuiHb7z6ucq
	gyRm5z7329jAjOYWeu1iocxl/d5/bvdQwT/rQOLlld/Tt8UcwBJbRtVzumFu4vYa
	maVQzYWoQQ3O66/dVLW1k1DF+UTWD3aSN1CcGK7mGjbsEJP49eKZw98JB81OTxFe
	aguITAlTjiz2yMgfY52/DV7sg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDntwdE3wprqZfxDw--.48395S2;
	Sat, 28 Nov 2026 22:03:50 +0800 (CST)
From: Bilal Hashim <AeeSec@126.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bilal Hashim <AeeSec@126.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] rxrpc: rxgk: round up appdata and authx lengths in rxgk_construct_response()
Date: Sat, 28 Nov 2026 22:03:23 +0800
Message-ID: <20261128140323.1122-1-AeeSec@126.com>
X-Mailer: git-send-email 2.47.0.windows.2
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
X-CM-TRANSID:_____wDntwdE3wprqZfxDw--.48395S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr47XF1xXrWrtF1xuFyUJrb_yoW5Jw48pF
	s8ua4Ykrs8Xr13urZ5Gw4Yyw1avw4UWF17Ka4qq3WfZr1vqF1DtayIyF9avFWfAFZ7Xr1F
	ya1Dtay3tF1qva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziX_-dUUUUU=
X-CM-SenderInfo: 5dhh2vbf6rjloofrz/xtbBrAZmAWsK30ZFAQAA3x

In rxgk_construct_response(), `auth_len` is computed using `appdata->len`
instead of `xdr_round_up(appdata->len)`, while
rxgk_construct_authenticator() pads `appdata` to
`xdr_round_up(appdata->len)` bytes and returns
`sizeof(a) + xdr_round_up(appdata->len) + sizeof(b)`.

Userspace can supply an unaligned `RXRPC_RESP_RXGK_APPDATA` control
message via sendmsg() -> rxgk_sendmsg_respond_to_challenge(), which
copies `cmsg->cmsg_len - sizeof(struct cmsghdr)` into `appdata.len`
without checking 4-byte alignment. When `appdata->len` is not a multiple
of 4, the allocated scatterlist length (`sg_len`) is up to 3 bytes too
short, causing the profile encryption routine (krb5_aead_encrypt() or
rfc8009_encrypt()) to hit `WARN_ON(cksum_offset + krb5->cksum_len >
sg_len)` and return -EFAULT, preventing the RESPONSE packet from being
sent (and panicking systems with panic_on_warn).

As defensive hardening, also wrap `authx_len` in `xdr_round_up()` when
computing the total `len` to match the subsequent `rxgk_pad_out()` call,
even though all currently supported enctypes already produce a 4-byte
aligned `authx_len`.

Found by manual code inspection (not reproduced at runtime; verified via
call-chain analysis from sendmsg() -> rxgk_sendmsg_respond_to_challenge()
-> rxgk_construct_response() -> crypto_krb5_encrypt()).

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Cc: stable@vger.kernel.org
Signed-off-by: Bilal Hashim <AeeSec@126.com>
---
Changes in v2:
- Add Fixes: tag and Cc: stable@vger.kernel.org.
- Clarify the exact WARN_ON() site (krb5_aead_encrypt() /
  rfc8009_encrypt()), describe the `xdr_round_up(authx_len)` hunk as
  defensive hardening, and note how the issue was discovered.
---
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -936,11 +936,12 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
 	if (IS_ERR(gk))
 		return PTR_ERR(gk);
 
-	auth_len = 20 + (4 + appdata->len) + 12 + (1 + 4) * 4;
+	auth_len = 20 + (4 + xdr_round_up(appdata->len)) + 12 + (1 + 4) * 4;
 	authx_len = crypto_krb5_how_much_buffer(gk->krb5, KRB5_ENCRYPT_MODE,
 						auth_len, &auth_offset);
 	len = sizeof(struct rxrpc_wire_header) +
-		8 + (4 + xdr_round_up(gk->key->ticket.len)) + (4 + authx_len);
+		8 + (4 + xdr_round_up(gk->key->ticket.len)) +
+		(4 + xdr_round_up(authx_len));
 
 	response = alloc_skb_with_frags(0, len, 0, &ret, GFP_NOFS);
 	if (!response)

