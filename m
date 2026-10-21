Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594142;
	b=A3UVfyxMAN4wW0yRAhRWyJ7BYlMTHGaWCLsAGKuuRfaREpEWnGIZ3El0VrtWe8dPqRyj
	 qLbrKV2YQ4p3/dxICQCZuRyXI+PWOIiZzD7rtIGXRy3oTOxOHrI0znE4enxTUaLCtiqlT
	 HMF/aZwU2efE8n8PKrbhU1UHILAbDybfdFwLzRSwlWTnDsm72VcR17PONUzQvK06ulw4X
	 kADl1l9FDtpYpWIgrOj69reJ7NTPB7ODGGMeN8Z82AOR5s2H2Wxd4aoFUzVmfKEFSajvD
	 as0CC8SydGIJAWRJcF8VNdJy/P/LrZG5jmvq8O3LWSwz2RCiqVbdMQQIl637mhXpmIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594142;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7vi0MaheqwvRysyNVAQ//LB96SLI++esTzB0f6zDWRs=;
	b=KpZxACNSLRfm1759K9szFIQKkxdS38ofgn/yg9KkElRRoqXg6fgiupi+wJzIDe/Z1r4P
	 yZLj3ThbLAAwuDcjXlCnhahwIVOEgJ7YGtpQM3IIGGfoiCIkUDY8LqZN58IY+JatioP/0
	 mzc2W3rjsiFuq8e59eDWc3TcYAVGm5Pztrnm7yA5Gh2Jrz0qLIdzfCJfdkLUB7G/p2w3Q
	 G0AHgooUlPNs/rBCvBtwukDDtQ/lv9iW1ZPFZnLO6Xj+P38iEyUQSXAp1aO8Kf1D7SPB3
	 JAX+lra+g5nAlObZnQkDNeQOi+WYo9sYIBhisfwq0jXOjIbwUx4JjM8bYXylV6qAzMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ckb+0ulI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2627606A321
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ckb+0ulI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A781F000C2;
	Wed, 21 Oct 2026 14:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594141;
	bh=7vi0MaheqwvRysyNVAQ//LB96SLI++esTzB0f6zDWRs=;
	h=Subject:To:Cc:From:Date;
	b=Ckb+0ulIt3VUHl3/hUH1wqueLNiSR9aw9O/WeW55f03oMjrTUdXf2ELFbP0TmWMlD
	 mfguQAOTixmu7h2a28lYq6KKm3x5HCQdY7Htya3DTwpjorYCmRGoVs/K3+IYdYawuR
	 35nqYeLwPsDzcUL2ZMdB9HzGs0v32IGDteM8Ma+0=
Subject: FAILED: patch "[PATCH] wifi: atk9k: Revert "wifi: ath9k: reject short WMI command" failed to apply to 6.12-stable tree
To: toke@toke.dk,mehmet.fide@gmail.com,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:34:51 +0200
Message-ID: <2026102151-glandular-pelt-13ce@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 90201351a862182bdabfc1ad1c97b1e1b6ed5931
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102151-glandular-pelt-13ce@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90201351a862182bdabfc1ad1c97b1e1b6ed5931 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Fri, 16 Oct 2026 10:50:11 +0200
Subject: [PATCH] wifi: atk9k: Revert "wifi: ath9k: reject short WMI command
 responses"
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
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

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

