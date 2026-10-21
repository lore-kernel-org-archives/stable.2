Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594136;
	b=XuAD0uMBHBn7v531VTWSTIbHZhizLH+7Xbu6H9B+dxW6nmbs9Qintu+X6zxiaiibwm4I
	 KxIEmHhW+y4B4rLDUFnxh/L4igzOLCjbMckiNPVT0cHJK1J9z7Z6RJs6HzGa6pT7Co15c
	 HbObQPRSPbH0Py4VBjrQRwp1Tci1lb7QMQVIDvaeeNBxjl7I71inwZGNjs4VvG9msQ5jV
	 dQisNUILHPLINDQ67RhmJlQoYwTUoYvYwT4t8XLHWNad3VBzIT9obPNMiy9SabOBWcs+w
	 T3bU1NxkI7JJkFOPBbv8BsdC6X7/qxhaV/mwCh/s3T3FhZ6BBGiTb4EdlEQv4yxnzgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594136;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=l3V6JrpMgWGnXOgR5+/PnO+i7koXWDpRhefi1TEjzBk=;
	b=YBj900g2xckPKxiMWYJahMKSde2doNxLPkI/1CP19SI3asAl25mNAsHRSDiWjCUKBl8d
	 Yj0hOOjfQYHf81IvIK7YaG3YaoF4w25K7Jw+yJYOanJDql5F9YfVGsAV6Dky+X6WylJQn
	 fKbNzkHf+KiiqKMPBEE8jBiTis+W/4Ndo090ONKZ7xZ5C23CuWAXcJJ+h0J1YaKLsRlmU
	 Ne7WNnwMn5AT926RwFYFqnSZB95Mo5DNyJGnDPEPcT9pxzJ49+v616yZ9rL8SaxmQrHLN
	 fXHLBWHr2+9sOsLJy6BPCAkEIqMdLVm4P6zfKoUCxFTNSHqbKX0Dr9qZa9GoLsS95OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MMxg9FE7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B8606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MMxg9FE7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BB51F000C1;
	Wed, 21 Oct 2026 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594136;
	bh=l3V6JrpMgWGnXOgR5+/PnO+i7koXWDpRhefi1TEjzBk=;
	h=Subject:To:Cc:From:Date;
	b=MMxg9FE7xQQ0L15WJ2QtzEMJKbTyk+sM6UY+goeOxIUT3ozXTdY3iNFCJGyKHi9Pl
	 u8PU0/o36GiVLcMHy3HusfHPlm0hPKVftta+L+8/9HIvxZ4WCaeeClcKsTbKl6E9+1
	 MNFAefnaTJo2BXiFCeiHveR157ia72wNSFqu9OSM=
Subject: FAILED: patch "[PATCH] wifi: atk9k: Revert "wifi: ath9k: reject short WMI command" failed to apply to 7.2-stable tree
To: toke@toke.dk,mehmet.fide@gmail.com,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:34:49 +0200
Message-ID: <2026102149-tranquil-moonwalk-bfc4@gregkh>
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


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 90201351a862182bdabfc1ad1c97b1e1b6ed5931
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102149-tranquil-moonwalk-bfc4@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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

