Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C933E410F;
	Sun, 18 Oct 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341868; cv=pass; b=aqxjwpQgHW83rIo2LqbhDsjfKA42ykMVx77S5UktgSARD6F6syiZJDggROujDzkNMmrWlLByxtTEnJY/pMilD81Q/LEPcjysnCc/AeoQP1hHIwEcEnM+/VsxnqDnHY1frfEFNS6S2Aaw8uA3nM9nblrJ4neIstBjM2YQFzbs4hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341868; c=relaxed/simple;
	bh=g2FMKl/lBmFvFo3Km5VSg4ir60Zngr53bIY6J485DyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8ZMAYAm9oBcSaNzB0F7l5AtQR3VFqpSKCt648QY5LcjYwhFV7LC4dWoF1/LmS9N4KBHf6HJ+e4Vnwawg3fR3SXWIkk/7YikpsfMOfyV/Wc7WqhRwY4SjvM8xftS9RKbGsP5KAnToKkmora0bbTYakxlqq6mlMo8JNMFIB+j/rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=HBAiTeSj; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="HBAiTeSj"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8D1DF202841;
	Sun, 18 Oct 2026 18:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=HBAiTeSj4PkLv8OcqaANlAPYh6VGMNEi9BVoI3fw3/5ZF/3l2VPpltUs08sc9gCK+npEwP
	wc7lWVU9AqqRQb8C/k7Ce+fp1pg9e9oTUPJ4kBaJmYyZ07vN6DzMf/nSgroFfQqGEXkwvU
	xe4SE1NqDpTZNfevg3utZ9aCmSlyDg8V5VX+fHe2OLA2j0EO2/qh/2JyGp1SLA1l+VgTlA
	92c/XCipUd1xnaB6ai6mYy1OMyniwe2slnavyzBJi4VUCVUXMxym/OwKMPlTnUlP28SEft
	3m6Wf0bOy1P2DdOCV89D/ufRpg5Alba3QFpAsO3BwRrzxKh6UuN2id5v6eGpuQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341860; a=rsa-sha256;
	cv=none;
	b=IYEUVRunR0cxQEqfClBN46isAs2vBM5HywbcpgdRzXV+xDNiZZ8i8vzDTDTzIF6skLQdXc
	HljVrC4YgOPOX/R4+D3M2GThmk04HcxklznrYDD+2vi9Z5L5gvSG57gHDc0orfLi2c4QaP
	jWReHG+Xtb9uZnxY2hLyGTVqO6WQZKl5TTFYKxEuTV93ngEZNr//VViGmNBEWnm4zQDhEK
	fCrOtgEMBCiE5KhvaTiCS1tX2ZXS1eHqq9Um3ogyx0AuyjqrGrlEDIq+/3gqlc8axtSFqq
	61LEIqhvO6Vrud2lO7QEl7kqZNZpPtrOepBl0XTOslqSlb0B5qYwGtbLFHdZmw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=cDGYFJ3h3PiDqoeuk8rvCss1wUN3oAVV9XQDb/tHIMkJpgSVClQAL7shiGWAnfo8TbUert
	McN02IiSY8hmrySQH8Vkp7yoAjmQlHi6mNJka5y4P7+qFK531knJT1LeaiBAb9yFogBlyU
	oixIdIRnYmYvaymqnbb7+9gRDWoX2NDTG+1sGNP8aMqPUIiutWFkt0gV3f4Z7hpmwgOgB9
	y3XrRvaUEhj0qI/DLPmkgIKpv1S0rJYuhKLm3PdF42BeFEYtrk/kl22l+D2OkKFa+F15S3
	kEbO8RVMf80Dyby/5JpmycxUQ80OOsHdxSNHXnZDw+c6nIMuDTEmV6HXytRY/g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzg-0006Sp-1X;
	Sun, 18 Oct 2026 18:44:20 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3B5C75C7D9C;
	Sun, 18 Oct 2026 16:44:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	stable@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/12] can: dev: can_put_echo_skb(): free skb on invalid echo index
Date: Sun, 18 Oct 2026 18:41:48 +0200
Message-ID: <20261018164417.1540449-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018164417.1540449-1-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cunhao Lu <1579567540@qq.com>

can_put_echo_skb() consumes the skb on all paths except when the echo
index is out of bounds. This leaves ownership with the caller on -EINVAL,
unlike the other error paths, and can leak the skb if the caller expects
consistent semantics.

Free the skb before returning -EINVAL so that all return paths consume it.

Fixes: 6411959c10fe ("can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds")
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Link: https://patch.msgid.link/tencent_683AA16E643DE00211CD2FB62991264DC605@qq.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

---

FAQ:

Q: `can_skb_init_valid()` directly modifies `skb->data` without checking if
   the SKB is cloned or shared. Is this violating SKB shared buffer rules and
   causing data corruption?

A: The finding about can_skb_init_valid() modifying skb->data on a
   potentially shared buffer is not relevant for this (correct) patch.

   The FDF-flag write in can_skb_init_valid() only matters for PF_PACKET
   use: PF_CAN allocators already set CANFD_FDF. The write exists to
   normalize frames for PF_PACKET observers (tcpdump/Wireshark) so they can
   distinguish classic CAN from CAN FD at the netdev level, and to
   compensate for PF_PACKET senders that omit the bit. That normalization
   is functionally required.

   The shared-buffer concern only becomes realistic through a specific
   chain: a PF_PACKET sender injects a CANFD-sized frame, the CAN driver's
   loopback puts an echo skb back into can_rcv(), and cgw (without
   modfuncs) clones it for forwarding to another interface. Only on that
   second can_skb_init_valid() call is the skb cloned. By then the bit was
   already set on the exclusive skb during the initial xmit path, so the
   flags |= CANFD_FDF write is strictly idempotent for any parallel
   consumer of the shared buffer - no memory-safety or
   information-disclosure consequence. It's a formal violation of the skb
   sharing rules without an observable effect, so the current code can stay
   as-is.

Link: https://lore.kernel.org/all/54a3cc01-abcf-4a33-b932-39bb1f68cdd5@hartkopp.net/
[mkl: convert Oliver's mail to FAQ section]
---
 drivers/net/can/dev/skb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 3e36c0368bae..738d5968dfa6 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -55,6 +55,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
 			   __func__, idx, priv->echo_skb_max);
+		dev_kfree_skb_any(skb);
 		return -EINVAL;
 	}
 
-- 
2.53.0

