Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418843F9F2D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490208; cv=none; b=aNM/4nB1pebxikWNnSEfIyfUTERU2ZUr0ZVYqat65n+HOc+IrdUv+8q6g/nGOagmCwWWNb+MUXoJTcp6qtao8TLsv3u35Dh1LFbnRqtlg2RClo4OR7Ic+E3a1aCkOeElFdep8ZdjLRCjXMmP0LruEtTdPauXDxo5uuTU+AbT7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490208; c=relaxed/simple;
	bh=EKMuXQM6RAWPZ6vd6g75W641twsmDsSceCkzG1rEJs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpVxl2mI7GPCoQXHXsSvQOJpnHbR0+VZ92Ho0OvCwOCohJFK3tsdZMXYZgl1Q5Et5FU3ye0nlym3eLKRUKWtGuxDMmMca56zE+o2/hVRFZjiuh1E7RXO2hsAofVpsuqYWEOYytmjb1oPasw6HqHYXalcqsYGwOsd+K6avkSiBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=BHoEmYP1; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="BHoEmYP1"
Received: by dvalin.narfation.org (Postfix) id EB5812045E;
	Fri, 26 Jun 2026 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzWW7wCesem3YqKEKd+colAAzY7ggw9qnF7bhE8vNL0=;
	b=BHoEmYP15K04qjI9jHegMhzBGyBHiHWOF1DE5RZ0BuTrj4ikm7sIYZYy9RcQDkGXi10Imb
	PGr7izinZX5wCZxlsWOzSPHiHo0Hgy4XJ3GuyER8xcS9T6hpgmhjJFeVcMg+EHLh2M1qnC
	3/hikRgxPYrqeTx16ITauEK+XZdjmw8=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 04/23] batman-adv: tp_meter: avoid window underflow
Date: Fri, 26 Jun 2026 18:09:33 +0200
Message-ID: <20260626160952.123713-5-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626160952.123713-1-sven@narfation.org>
References: <20260626160952.123713-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 765947b81fb54b6ebb0bc1cfe55c0fa399e002b8 upstream.

In batadv_tp_avail(), win_left is calculated with 32-bit unsigned
arithmetic: win_left = win_limit - tp_vars->last_sent;

During Fast Recovery, cwnd is inflated and last_sent advances rapidly. When
Fast Recovery ends, cwnd drops abruptly back to ss_threshold. If the newly
shrunk win_limit is less than last_sent, the unsigned subtraction will
underflow, wrapping to a massive positive value. Instead of returning that
the window is full (unavailable), it returns that the sender can continue
sending.

To handle this situation, it must be checked whether the windows end
sequence number (win_limit) has to be compared with the last sent sequence
number. If it would be before the last sent sequence number, then more acks
are needed before the transmission can be started again.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index d8ad58ccef260..10953096996ab 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -825,10 +825,15 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 static bool batadv_tp_avail(struct batadv_tp_vars *tp_vars,
 			    size_t payload_len)
 {
+	u32 last_sent = READ_ONCE(tp_vars->last_sent);
 	u32 win_left, win_limit;
 
 	win_limit = atomic_read(&tp_vars->last_acked) + tp_vars->cwnd;
-	win_left = win_limit - tp_vars->last_sent;
+
+	if (batadv_seq_before(last_sent, win_limit))
+		win_left = win_limit - last_sent;
+	else
+		win_left = 0;
 
 	return win_left >= payload_len;
 }
-- 
2.47.3

