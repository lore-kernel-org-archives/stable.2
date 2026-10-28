Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197451;
	b=OvRBn80YMLMuIr+Kd3PAHoS6vE4jTtHFJLml5jpR9vNhgShdXn1ehSw/Sv7BgnwBc5E5
	 JKDmrJ/AuieaOyDZjuuid0+O6/8tZtgyTTYrTNbab0Mc2xY0N0+W4Fg3qMKZ7YTsHIPed
	 fkE1/OoUAXvnMBwXtud47i9VbwOcQBAGnTFTaBu16kuF5sJzRGIdRc4Bu8E6sN2/CU0h4
	 xkTTbLJz7IvL1q32KvkAWhYIXEMYLNsoPjdIZN04NF4+nX7tnklkX2PpIv2a+YyJwJdWo
	 TNMh4w7SY8HAErMpF/jDow/BXNk1rj0Exc0dE7AvrmMRDoxThnnUZ+ufWpeCLct6pgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=660T/j6szyMYX2cJqw9EXFv5X7NWkuG7benZxmM9Szs=;
	b=49Iw19Nohx4vF9Y7GUmIhorp2yu0+5D663wupT+R8tp1XLbSybmDH34TGw03eoMDS2ta
	 PtRJ9oVNVhRCGNXmZMSGaFHjVyodamvwcOAfrL1E5qmgvob+u/A2NnQ8nZ9MeLt/5igL0
	 CODcdIZlVoZWKQdn8BseMU0MXv9zmvEqOwAnbFwtkTb2EZD2Swa+55FNRrb8lveZ3UTz6
	 SatwNYSFN9WRmQHU1NE2WC9viZKJlrj5Qf5EajYdR33y6uF3dOV+LWRk5Tbn5G4M+PNmT
	 rJJ7OToACIFEro+0N6zfeveIeyLfL9I4awC/9CGpDvZ3CnAIcS6n/16xksXYqfg6wlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zK61OYZt;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0F60A261B
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE0F60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zK61OYZt
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so884388a91.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197450; x=1793802250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=660T/j6szyMYX2cJqw9EXFv5X7NWkuG7benZxmM9Szs=;
        b=zK61OYZtAVgUCp/JFTqhE9re+jZLYZst9EUpWbl9zk1eujT9d1ZBBnpgroXqL8alrm
         vCTMNJvWzRGWLgH8nl5dawueHJAUKLpWjikU19XJIrKTlivQVSU/9cqQd1arr4n7P1AZ
         r1GE4hTVEZw2UCNNl3ou1VHlgCqsKQRZt7sLBq3y//fQM6dBIPV0Py0Ebb2ApHw0qHLM
         Fw9HSxv+D1xui+An2+t5y3LLkjyd7E+thRSu7wQ0DX7TfdApyBv0+cUMb2Zn0ot/wXxA
         wToMV59t3vLN0Vw/t6CaCZ1B33Fv9QMyV2aeHMlnmDZnHRe6D8v6vQ1CemQhX4tcmpJf
         7txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197450; x=1793802250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=660T/j6szyMYX2cJqw9EXFv5X7NWkuG7benZxmM9Szs=;
        b=xEYloXXAZ4I5jRsMbbAvvyoWOdigrvD53HhnjYWUqaTaJSrhB2unmcVT7h/S9JSsuo
         iNqvbsTRjwpX/6Uhben+TqhCuNA1rEE8UtokTUrQqEe+nXYq1m5mhtqDANNY/GaT7Z+1
         +WWntvtycNIUzYzgKDvDYUF6h43gQjEjmZD1bET7NiwnO4HQ79BQ4x8ItA5qwxEgtd3P
         C0rik401HwVPMh+E3LWeNQIDNRwKvqQHbg71QetnGjPF9d/pvfaGC7J3JO3QZXNwxV0C
         fDH7WTjDNBCIJOi3ACjXbriM0L3fDhYN7O6IDPR3f/rtYsw7ZaOUYxgz5LDyu9zGxH6T
         CpVg==
X-Gm-Message-State: AFq9FYK5p7koi+I6+RFPfHxzr8yq9ebtyT+ZySO53kzEsfvF20D+M6/W
	HGcF6FkQR5S+0ud/2qett9wCJCCI/EHVQVV8K0XbZwNEmo859YHdhzpsNCp+OkUrTf4=
X-Gm-Gg: AYBFou36yKyy3/epaxLdMGfNMZGlEoaUcd0lEEbQlQWZN/cIaDUW/f4qYrLF9Nb/8ZD
	ysiEXoTIvdpzQEIDlI3aCdVzYbp+oKs4+bI/kpf5ktREGGZoc5rhOGSOUGM6+wlbvgEgukKZ87K
	ehqXah7Qlbhcsrs4biPLFdVwD5r9VgvCvtkerT//nqNpPWevYRgKFM27SR2z1j2oBNpw1oriU2D
	vuYW+ZBaFJ8tJK2kRuGmnW7CJ6xg1xMWEcbuNPEn/IlxZN5DPktD/dIFbmCxFGWjRBmg0yZk3KB
	tA0GVTfASjmwMka3/wucEiyvhXCgTc1Nsvihaal6ezGqe+8KS9lo2SwtJt9yxGGYODyyiCfJohD
	E8GPIZFrw98S7Qxtz2mTNUzl/FOoCzqdk0xTkpX0XX0qKd26ra+O/6bCbyzRFaxATDvkQAFHNjy
	5rn8q6bw5QujSWtGz9NOyPsipECpxVpUCsuayrO1NP5szDFASJwairTtLTtpnlfDZcgw/MgZR5+
	u67S0xMJI4l9Dhg6XDVyqu9BG+L6uySbUPQL2nEJL7q0QNBcCr3+nYPxs8xRhzbq9XYG7Jgxu/d
	flADeTD0VtNUw0aA9HPKnb2tui/T0eKAUtm9btA74cbHKPKEuY3p5tRCVFgQiMpwkhZB
X-Received: by 2002:a17:90b:4a4b:b0:3aa:6b5d:a02e with SMTP id 98e67ed59e1d1-3ae58318a19mr1972701a91.54.1793197449365;
        Wed, 28 Oct 2026 07:24:09 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a48c2d3sm3324593a91.5.2026.10.28.07.24.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:24:09 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: stable@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y] wifi: mac80211: shut down RX BA session timer on teardown
Date: Wed, 28 Oct 2026 22:23:49 +0800
Message-ID: <20261028142349.19894-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
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

commit e588e83e5c7a0f6d7a77dbbb58927c8c8cfd598e upstream.

Tearing down an RX BA session while a BlockAckReq frame is being
processed can rearm the session timer after teardown deletes it. A later
expiry then accesses the freed tid_rx state.

___ieee80211_stop_rx_ba_session() uses del_timer_sync() before RCU
readers have finished with tid_rx. del_timer_sync() does not prevent a
concurrent ieee80211_rx_h_ctrl() reader from calling mod_timer()
afterward.

Mark tid_rx removed under reorder_lock before deleting the timers, and
serialize the BAR removed check and mod_timer() call with the same lock.

This differs from the upstream commit, which uses timer_shutdown_sync()
instead. Linux 5.10 does not provide that helper.

LLM assistance was used to find the bug and review.

Fixes: a87f736d942c ("mac80211: use RCU for RX aggregation")
Cc: stable@vger.kernel.org # 5.10.x
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed on v5.10.272,
with no diagnostics beyond the baseline. A forced QEMU/KASAN interleaving
changed 9 use-after-free reports to 0 and produced no lockdep or
atomic-sleep splats. Natural race frequency was not measured. A reproducer
is available on request.
Sparse C=2 and targeted Smatch introduced no new diagnostics.

The affected files are identical in v5.10.270 and v5.10.272.
Equivalent fixes are present in 6.6.160, 6.12.113, 6.18.56 and 7.2.10;
adapted 5.15.y and 6.1.y backports were queued when reviewed.

 net/mac80211/agg-rx.c | 5 ++---
 net/mac80211/rx.c     | 5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 6ef8ded4ec76..b23ff9793fac 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -103,12 +103,11 @@ void ___ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 	if (!tid_rx)
 		return;
 
-	del_timer_sync(&tid_rx->session_timer);
-
-	/* make sure ieee80211_sta_reorder_release() doesn't re-arm the timer */
+	/* Prevent BAR and reorder release from rearming the timers. */
 	spin_lock_bh(&tid_rx->reorder_lock);
 	tid_rx->removed = true;
 	spin_unlock_bh(&tid_rx->reorder_lock);
+	del_timer_sync(&tid_rx->session_timer);
 	del_timer_sync(&tid_rx->reorder_timer);
 
 	call_rcu(&tid_rx->rcu_head, ieee80211_free_tid_rx);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 8ec630a4d069..c7504dff7b4b 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3101,12 +3101,13 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_data *rx, struct sk_buff_head *frames)
 		event.u.ba.ssn = start_seq_num;
 		event.u.ba.sta = &rx->sta->sta;
 
+		spin_lock(&tid_agg_rx->reorder_lock);
+
 		/* reset session timer */
-		if (tid_agg_rx->timeout)
+		if (tid_agg_rx->timeout && !tid_agg_rx->removed)
 			mod_timer(&tid_agg_rx->session_timer,
 				  TU_TO_EXP_TIME(tid_agg_rx->timeout));
 
-		spin_lock(&tid_agg_rx->reorder_lock);
 		/* release stored frames up to start of BAR */
 		ieee80211_release_reorder_frames(rx->sdata, tid_agg_rx,
 						 start_seq_num, frames);

base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
-- 
2.56.0

