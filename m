Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47267403AE3
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490371; cv=none; b=ksYkluk1wgQ/zBxgyhXJc48Wlc7vVMvRNZy8rGYW+fB+72dXrXAKQMoPIoQcNtrKNWaEd56w53v063/Pf+2T2AmIfFCa2sj0+3d/NIPBCWLobX/fw9/29Xz2lOZKYpfxiAqW8W/O+V9bT5ja38hz3Z8S0HZb9SV/KBFB3OkQ4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490371; c=relaxed/simple;
	bh=6n8aBNMwx4OFO/mnbIfYfSm4PtfhYsQd9178zaHTGvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKgrIgsiFTyeCQJrm9ak0EDmWoqEaE/8R82pRgFORuVkZJZhICBVa7OUA0w5i2Cvp57nJpXyTOVriployfwQ7OMNYXOZtcynMzvlv6n/2ZH6iBOJFcrrBtIXdTm1Fh0UbHN9WQGa2xZJ6XC1EeNRsXqgkSw8xzoQBUUdgHGe9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=c8fhvrmV; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="c8fhvrmV"
Received: by dvalin.narfation.org (Postfix) id 8DB7020470;
	Fri, 26 Jun 2026 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vjJlBq13n8wcgUX/p8ro2v42RFsQaU92CfBNIbNXX8=;
	b=c8fhvrmVFc3fEaRWfPk8b8Zd3fZYRryNl3c0djR+KQQAW7MSHjdxbUEPBc9ZRqqmz3oG8V
	Vl4yYisEkm7rdJSgbd/blO2DAVD3E8gEzoOVV3EVWefgrfomCW0x8YUZkIGVk3akRoCVy8
	VT6NO+3NquWtcdFx/hMK19ZurMTn8aQ=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 07/26] batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
Date: Fri, 26 Jun 2026 18:12:22 +0200
Message-ID: <20260626161241.124988-8-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f54c85ed42a1b27a516cf2a4728f5a612b799e07 upstream.

The recover variable and the last_sent sequence number are initialized on
purpose as a really high value which will wrap-around after the first 2000
bytes. The fast recovery precondition must therefore not use simple integer
comparisons but use helpers which are aware of the sequence number
wrap-arounds.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 77bc69573a562..0801dcf93540a 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (tp_vars->recover >= recv_ack)
+		if (!batadv_seq_before(tp_vars->recover, recv_ack))
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

