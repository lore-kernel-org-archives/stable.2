Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0523932F0;
	Tue,  2 Jun 2026 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400843; cv=none; b=sVWBCl5TuRaQJjA+utnfz5gw4rJvRtpJJdNxJUM5w4t6GwgeV8UluvqIbs++Vd5MAe9H19qDOETgmaXr17sf2onALdrGMgR3CsFrUc/SdgTR31g7QD+V9gY/534J0ESJoxJuForr7wgertHOjbwNXBBWdKIxU/kSOgU2fD0C0BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400843; c=relaxed/simple;
	bh=omPPWB9qkNmMWGpwFF+1puyD2wBjp9pkOVrg51rWi2s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B/HpUz02ka4q65K21FsaXd1i687ct7et2zt5rgBoFehIHmdZkKSne2mDOatsDWOVttcesY1Rd7zqSQfT0wFwdj+MSHyf2nKi1vO+7TdmywUUSVKzpPeSFEv+hMb0H6JFXqF4zVHKh/PIvCnQqXFmhlqpijSImIXsw4JaI62X724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=g2NMR+/K; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="g2NMR+/K"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 652Bl1dpD2890377, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780400821; bh=v/1jgKBct0i5cLDmFqRgQ18+wM4g2LTdWlj7oto8wOc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=g2NMR+/KEs7lT/d64UYSHjYkfTYxBVtVbJRSYJmlvkr64Lrlb0QOseCJaM4SSl0sI
	 tJSkVX1ioF54r21n9dMvUfeDZ+4NEViNu1n9IxJvfU3BdCQ76gBXcuZC/Qlc8FjOvg
	 cZvujx7AYTPREgEh+sol4/ZqbR0ZXmgQmVnz7lKA2lk+uH4xD/HoIK5ZCZey/aaFfM
	 N3qX3qLD2MhDmG6RDwM9XHIICZ1fLcD6ppkSPdzZovp24HDZqzY8PXH48c29LO0wb/
	 9O2ANG7LbEimpq7BXJzPXOoGr1gqvnaFcu1qoWa2wRqAljTPcWcpjY1mgpPaZdYgpW
	 6eQJfJBcXpY5w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 652Bl1dpD2890377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jun 2026 19:47:01 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Jun 2026 19:47:01 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Jun 2026 19:47:00 +0800
Received: from RTDOMAIN (172.21.42.225) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Jun 2026 19:47:00 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>, <horms@kernel.org>,
	<pkshih@realtek.com>, <larry.chiu@realtek.com>, Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net v2] rtase: Reset TX subqueue when clearing TX ring
Date: Tue, 2 Jun 2026 19:46:59 +0800
Message-ID: <20260602114659.12335-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

rtase_tx_clear() clears the TX ring and resets the ring indexes.
However, the TX queue state and BQL accounting are not reset at
the same time.

This may leave __QUEUE_STATE_STACK_XOFF asserted after
rtase_sw_reset(), preventing new TX packets from being scheduled.

Reset the TX subqueue when clearing the TX ring so the TX queue
state and BQL accounting are restored together.

Fixes: 5a2a2f15244c ("rtase: Implement the rtase_down function")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
v1 -> v2:
- Target net tree.
- Add Fixes tag.
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index ef13109c49cf..6ccbefb5acf2 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -239,6 +239,8 @@ static void rtase_tx_clear(struct rtase_private *tp)
 		rtase_tx_clear_range(ring, ring->dirty_idx, RTASE_NUM_DESC);
 		ring->cur_idx = 0;
 		ring->dirty_idx = 0;
+
+		netdev_tx_reset_subqueue(tp->dev, i);
 	}
 }
 
-- 
2.40.1

