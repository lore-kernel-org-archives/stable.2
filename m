Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272547;
	b=lNm5P+BNxT7ITYSbZCJzMNOQOP0th67BFfATfxbmbPzEl/XBa4XgrXZZRCrFxp8nzJpx
	 G6en9105deE0rhXkOS6VHzX+jY+MBFXkG192GUIbmsaz9Vd2/PQG7i1RBQzw2OnrGvdKn
	 WnlnkkbBQe93wILb34TZB5IujWLeMI8T1mY0Mwuhe+IV0N7f1DJKp1xX9Oj13BkC9eC3P
	 7gyYIv04pEvBPSte+9fFzA8Y6QbwSLd5gGoPKTNE0QenOFudwNS9R8oKTurvB+oNwbv3d
	 xS38JPcZ9C3zSegbW90EgJmYiX9W9xuB0ni8oW6EAtnRLzCKvPEs0rEsPXZZKHdEuIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/D0YYFPcUdmGJ/rSu2HWLBAbOF+GfBK9AZBpGzeD2Kk=;
	b=ddtUJim3Fl7Zn5uai8QGR/91OkRXeTk9X2cN71N4zxJ+bPX3LsRimeShiE1y4gX9Dyrl
	 BD2tiLw8MGgl/MwFrc2GP9MfGC/O+cfZvNj434lbRd4yZS0JSwQkPahRDqVeszpEaiH5t
	 w7W5n9SL3gheIfTbBQWGrRm5qmr7CMR0mhc7HTiWqJk8GDxSN6B6VgnsWymdW68lahu9e
	 MUPQU/v39AthH2rh2k2TQnzxT6aXrhkta8LQEd9FqMLHYa8NCpb11LhJkBsxozBOX8aPr
	 LN4m8h0qgh+2YSgAV69J28rSGKYVNx8siWZ/JERuvTg87Xgwx0X+D834XptgUb95uLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TKYDd/pD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D4606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKYDd/pD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E991F0089F;
	Tue, 10 Nov 2026 01:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272546;
	bh=/D0YYFPcUdmGJ/rSu2HWLBAbOF+GfBK9AZBpGzeD2Kk=;
	h=From:To:Cc:Subject:Date;
	b=TKYDd/pDwtDV6hlL4HV9j7Ib+F58oePLDSz38GdfCPYhlJycRxL6PCVorVg7i5Jz8
	 WQN4k6XY/IUpS/I8bQaLeGjVftR+H3g8+QLQ9QN6O3j9ne2Sn/etXnZT9k+6p4Mi/Z
	 CkT8/9BQnvqkPRkQ7DwXXiU0nVz+x/QkfXohtGBxiwMkwdQxCeRNC6DKr6rWI0GZnC
	 GbzEc4tBYCI35PNB2TDYYnykZWjgJXuiNiS69MP7AQwVm7K2zEmt6a4zA55kvZ/nge
	 7ohfwFFQlLMg+shTNp6PTMV7Lb8E/RLf2S9LAMp8O68JFZ2pi93LTeH67i3yFESJ/o
	 OfCU1miHiBZ6A==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: clear ROAM flag when re-adding a pending local client" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:25 -0500
Message-ID: <20261109200225-failed-6.18-cc2186d78547@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x cc2186d7854785b30d423f5d43757b086b300e55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200225-failed-6.18-cc2186d78547@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cc2186d7854785b30d423f5d43757b086b300e55 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 7 Oct 2026 13:02:45 +0200
Subject: [PATCH] batman-adv: tt: clear ROAM flag when re-adding a pending
 local client

When a ROAMING_ADV is received for an announced local client,
batadv_tt_local_mark_removed() sets BATADV_TT_CLIENT_ROAM, queues a
DEL|ROAM change and marks the entry as BATADV_TT_CLIENT_PENDING. If the
client sends a frame again before the next TTVN commit,
batadv_tt_local_add_existing() only clears the PENDING flag and returns
early. The ADD cancels the queued DEL, but the entry keeps the ROAM flag:

* batadv_is_my_client() reports the client as not served by this node
* batadv_tt_local_client_is_roaming() reroutes unicast frames for it to
  the node which sent the ROAMING_ADV

The ROAM flag is only removed with the next frame of the client.

Since BATADV_TT_CLIENT_ROAM is set together with BATADV_TT_CLIENT_PENDING,
it has to be cleared also at the same time with BATADV_TT_CLIENT_PENDING
when the client roamed back.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 39b61426f1680..e13c2828da475 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -894,6 +894,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 					 bool *roamed_back)
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
+	bool readded = false;
 
 	tt_local->last_seen = jiffies;
 
@@ -908,8 +909,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 			 * flag can be reset like it was never enqueued
 			 */
 			common->flags &= ~BATADV_TT_CLIENT_PENDING;
-
-			return true;
+			readded = true;
 		}
 
 		if (common->flags & BATADV_TT_CLIENT_ROAM) {
@@ -926,7 +926,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 		}
 	}
 
-	return false;
+	return readded;
 }
 
 /**
-- 
2.53.0




