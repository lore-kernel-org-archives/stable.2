Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0C388E7C
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309382; cv=none; b=V2spWz+FdaixzgMsOekBVV7IrBJ3MwVb1VCAuda/Kv/WXKVzH62xkEsZphTh0aJaBAJyLhP4BDqneZSnf+oNkaGUMroUhNEC3VECQBv2NAajkkjWdMxIi9ZlN5eEsu1sRlo7W5fnTz7BrVEKaB8UTnfhGSXLFaUerEyV/bu5mf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309382; c=relaxed/simple;
	bh=8YZE1R71BYFXhtCd6eBlXJrXCIVc8lU7KuiXbEVKYV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqWH8jCTpIGRF/Qe+7WKX0tK0b4P+NtxYv4PacwtF7kzSLeNDHUuDNdwoO2XXiQpM4dLtOW7urEmt7z4PVAXlgn++Lcuw7jr65pa/MsI9W2neOcdA8WwrUfd3nMvoOFuNwZgkJGp8Rd189HR8MvAnYpd/wp7SLuvnjL4ksDnsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nbBywJxo; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nbBywJxo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=YBT3RARv+ZuIX+iHxR+mJ2C+OTVKjAAZ0y9Pl/iC/V0=; b=nbBywJxoy1UyeWRcPQTm4pe+o7
	T2DOTs6WsKyeWLJciRYJ6G1w7s5Qiw8NKCyrXie+1KLVA13nFRluC7wevmZUWWjXaeCJwSLMDwcQo
	hOcE51bigQ8yEzb2lb4ywrahzd/dyi9hQPeqJvEOCMqkEZRW2u9AO5siJgLzAF0bNkle+8N0FVaOK
	69J+HAO6OD1me40+sDXxmGqHASlV9UXBfMXHT9OKVgKzgUnwVyohmOENyCWmaxii06AeIG1BkrWeM
	UJmFbR+n1qJLvzBXWL51BWHwRBzQFJ9Ijp0nzSwLJ3Oe631s8VVTGrluiLqQMEN2yT3yxCdhsKwDH
	+eWw3blg==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	kuniyu@amazon.com,
	kuniyu@google.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 0/9] Backport "af_unix: Drop all SCM attributes for SOCKMAP"
Date: Fri, 17 Jul 2026 19:29:13 +0200
Message-ID: <20260717172922.3398851-1-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

This series backports the "Drop all SCM attributes for SOCKMAP" for
af_unix onto 6.12.

All patches before that are dependencies for that to apply cleanly.
Therefore all patches are clean cherry-picks onto 6.12.95 without
any modifications.


Patches 1-4 are part of the series [0]
  "af_unix: Set skb drop reason in every kfree_skb() path."

Patches 6-8 are part of the series [1]
  "af_unix: Introduce SO_INQ & SCM_INQ."


I tested:
- the test-cases described in the "Set drop reason ..." patches
  and confirmed the expected result still apears.
- manual tests via netcat
- ran stress-ng with the "--sock-domain unix" option for the sock-stressor
  for 30 minutes

So I'm pretty hopeful of not having broken anything.


[0] https://lore.kernel.org/all/20250116053441.5758-1-kuniyu@amazon.com/
[1] https://lore.kernel.org/all/20250702223606.1054680-1-kuniyu@google.com/

Alexander Mikhalitsyn (1):
  af_unix/scm: fix whitespace errors

Kuniyuki Iwashima (8):
  net: dropreason: Gather SOCKET_ drop reasons.
  af_unix: Set drop reason in unix_release_sock().
  af_unix: Set drop reason in manage_oob().
  af_unix: Set drop reason in unix_stream_read_skb().
  af_unix: Don't hold unix_state_lock() in __unix_dgram_recvmsg().
  af_unix: Don't check SOCK_DEAD in unix_stream_read_skb().
  af_unix: Don't use skb_recv_datagram() in unix_stream_read_skb().
  af_unix: Drop all SCM attributes for SOCKMAP.

 include/net/dropreason-core.h | 21 +++++---
 include/net/scm.h             |  4 +-
 net/unix/af_unix.c            | 92 ++++++++++++++++++++---------------
 3 files changed, 69 insertions(+), 48 deletions(-)

-- 
2.53.0

