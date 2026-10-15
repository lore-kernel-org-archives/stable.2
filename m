Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81579447805;
	Thu, 15 Oct 2026 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.56.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048895; cv=none; b=EoBYHhGb7WdbcsC07CK5NQFM9bZf+gJ2lLdWZNqfs7qSa5l6oDYQhDIlzrCvJAusZdWtRZkiVc19SVEfMiFwZWEHjL7VeV5s6+9BQdU1hBnffy4uEAsW/bLYQgYhh9eHdIo/FPTCQHqKFoEkL4g4EXecjfFnA9o8sWy2QTPeL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048895; c=relaxed/simple;
	bh=aXOYd/IpTZ/z/TqYVjtUrb+ki2He1+Dm1qXywwrwG3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfp8F10PS/cA42zhXlt0hGafz/F4kum0Jj3pOGxeD3OmBJLb/qoZZWgLBM2Ss5ZEF/5vQ0SPFIN+Z0/w47gIHCg3ANDVC+ClEEEg2OaphRCq5xM+1SxEo70rlyy+8dciN3930gxmbUrFBL7hzdArCM/8kbUWAvzzTR6PiHZWu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideco.ru; spf=pass smtp.mailfrom=ideco.ru; dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.b=CBcBmO4Q; arc=none smtp.client-ip=51.250.56.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.b="CBcBmO4Q"
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id 9B86B203855E;
	Thu, 15 Oct 2026 12:21:22 +0500 (+05)
Received: from fedora (5cfcac1b.dynamic.mv.ru [92.252.172.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id 482082032116;
	Thu, 15 Oct 2026 12:21:06 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 482082032116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1792048881; bh=sp68sfo4wdTeRg5lJcmjZaz65CMQSCLC8h6Pl0FCQq8=;
	h=From:To:Cc:Subject:Date;
	b=CBcBmO4Q7aq6UHN/4INXKbXA3tWYOIn7ijpBz7HjC49qrxRXTquCDo7itadggFug6
	 I3CSv16wORbmmVSzR1c/kl8RBGqYyn+1/A95A0T30zbF2fWdaBhNbZboSuozDChhjA
	 HOBvpH9COzZvYw+Cj0A7kdEYs/ipopD4T3N8qscNMGJYelxX7wR1m8ggFRCjXF5arM
	 6zjLJVgz3KYc+Jfh5moDyv5TXtTlBkeKAq401OPGZwqn8DPNQlIsNWvsxWSEpGpcmI
	 2MWpZSw3rulYdfhBnWc4d697d3QnhuJxIGUioyJX5i2Nu64auZh3nB//kALRhi1Mvg
	 LhmRdPlH5GJyg==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Kalle Valo <kvalo@kernel.org>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Amitkumar Karwar <amit.karwar@redpinesignals.com>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rsi: Skip TX aggregation setup for non-QoS frames
Date: Thu, 15 Oct 2026 11:20:05 +0400
Message-ID: <20261015072010.742369-1-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transmitting a non-QoS unicast frame to a station in AP mode,
rsi_core_xmit() assigns IEEE80211_NONQOS_TID (16) to tid. The station
lookup succeeds, allowing tid to index start_tx_aggr[], which has only
IEEE80211_NUM_TIDS (16) elements. This causes an out-of-bounds read and,
if the value read is zero, an out-of-bounds write.

Only access the aggregation state for tids below IEEE80211_NUM_TIDS,
excluding the non-QoS sentinel from TX aggregation setup.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 19844c0a9a19 ("rsi: data and managemet path changes for AP mode")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 drivers/net/wireless/rsi/rsi_91x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_core.c b/drivers/net/wireless/rsi/rsi_91x_core.c
index ead4d4e04328..3281fc94e107 100644
--- a/drivers/net/wireless/rsi/rsi_91x_core.c
+++ b/drivers/net/wireless/rsi/rsi_91x_core.c
@@ -458,7 +458,7 @@ void rsi_core_xmit(struct rsi_common *common, struct sk_buff *skb)
 			tx_params->sta_id = 0;
 		}
 
-		if (rsta) {
+		if (rsta && tid < IEEE80211_NUM_TIDS) {
 			/* Start aggregation if not done for this tid */
 			if (!rsta->start_tx_aggr[tid]) {
 				rsta->start_tx_aggr[tid] = true;
-- 
2.56.0


