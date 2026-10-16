Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE038DC75;
	Fri, 16 Oct 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140640; cv=none; b=AX2vC0z/reE2nouS5B+xUuTD3ELmYmQLY13Z+v7Kf8KJmzqeWERrp86jbmHnquooG++tpdVyUbCERUFh23bOZiP2blslOWAkMwauQY0dcPZIcXYS17mpZoHQt/uPqyMBpiadErXlBiO6A9PyAlf4LFo3NQdC6ty/1+xGxGyXwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140640; c=relaxed/simple;
	bh=32StZRkOfvij9KmxOXn0IGw9WpPdoBq/RtpB12Bu1qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FKcKYOB8WiPVv9u4UIzP1JKezH4dwSypyKR+lCZoChtFW/QvHK7gw0/rULkdMDOO9fbSLoy7FkV8hZVpDwt4JdzhVFTXOb/Pg49B5Qb3Tnw4ZtRr5gD2LNnXO0v0sKNwiCTxPwNo/WTZi6gULP55gLJDE0NtSgVQNU1lb4iTH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Mehmet Fide <mehmet.fide@gmail.com>
Subject: [PATCH] wifi: atk9k: Revert "wifi: ath9k: reject short WMI command responses"
Date: Fri, 16 Oct 2026 10:50:11 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <20261016085013.136825-1-toke@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 93ce8ea70451e800601bc9444aa33043de15d67b.

Mehmet reported that the offending commit breaks his AR9271 USB adapter
which uses zero-length replies to commands that don't return a value.
Revert the whole thing to restore the functionality.

Cc: stable@vger.kernel.org # the offending commit is in 6.12.113
Reported-by: Mehmet Fide <mehmet.fide@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
Linus, this regression was introduced in the 7.3 cycle, could you please
pick up the revert directly? Thanks!

 drivers/net/wireless/ath/ath9k/wmi.c | 16 ++--------------
 drivers/net/wireless/ath/ath9k/wmi.h |  1 -
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 4a08babb6d9d..44e91815a159 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -206,16 +206,9 @@ static void ath9k_wmi_rsp_callback(struct wmi *wmi, struct sk_buff *skb)
 {
 	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
 
-	if (wmi->cmd_rsp_buf && wmi->cmd_rsp_len) {
-		if (skb->len < wmi->cmd_rsp_len) {
-			wmi->cmd_rsp_status = -EMSGSIZE;
-			goto complete;
-		}
+	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0)
 		memcpy(wmi->cmd_rsp_buf, skb->data, wmi->cmd_rsp_len);
-	}
-	wmi->cmd_rsp_status = 0;
 
-complete:
 	complete(&wmi->cmd_wait);
 }
 
@@ -307,7 +300,6 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 	/* record the rsp buffer and length */
 	wmi->cmd_rsp_buf = rsp_buf;
 	wmi->cmd_rsp_len = rsp_len;
-	wmi->cmd_rsp_status = 0;
 
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
@@ -364,13 +356,9 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 		return -ETIMEDOUT;
 	}
 
-	spin_lock_irqsave(&wmi->wmi_lock, flags);
-	ret = wmi->cmd_rsp_status;
-	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
-
 	mutex_unlock(&wmi->op_mutex);
 
-	return ret;
+	return 0;
 
 out:
 	ath_dbg(common, WMI, "WMI failure for: %s\n", wmi_cmd_to_name(cmd_id));
diff --git a/drivers/net/wireless/ath/ath9k/wmi.h b/drivers/net/wireless/ath/ath9k/wmi.h
index 0bb9d31f1a1c..5c3b710b8f31 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.h
+++ b/drivers/net/wireless/ath/ath9k/wmi.h
@@ -157,7 +157,6 @@ struct wmi {
 	u16 tx_seq_id;
 	u8 *cmd_rsp_buf;
 	u32 cmd_rsp_len;
-	int cmd_rsp_status;
 	bool stopped;
 
 	struct list_head pending_tx_events;
-- 
2.56.0

