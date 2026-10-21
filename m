Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594139;
	b=opI6fMtGmfQ2dJ87iOQN7C7OWRzBSq2pXmpGZ4JRaDIAIJ2kE04438jV9QuW7inzwkgJ
	 AeXWvf5tTtFGAf8F3swF0j9yb7bm7vYuZ5rwF2TjuZQUrhTZhBw3OywmCH1LoXiwUAxYp
	 43dHcbaeS15MDgBYf1zXARzk+LbCYNGjant4RHLIb5rdcTlJGdPy1SmOwO+U+He/yuXCP
	 6jiHuUKwoNjRqi49FPQhGWCKx1X+oKoeIuTCO4rs2epK9p/6isEUkWPx3kOP3g8RPKXgd
	 +i3A+/ICBLx/sK0J/pvQbuhEaB9VjIQuItQCSbtaMI6wWsop99k1sneCjMO27KdXfhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594139;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BnO9ggs+OLTRcHA98zrmKleAC6MsyzgiSsQGY475bcg=;
	b=SjUDag7VonZc/zC5sIgBxAgNsTT5v1NTlhxBJ5iloVcuA9uaxvowRH+Flb4nCmotr//V
	 zQvyz9aHl+nSXbrDWVMIDxMFaMIY1JGZiD4dTC9MczWPT6zF+qzIa/++J9M7SM81S0TXx
	 3D3PEeL7gp9yPtoW8IByM3J9/NVZrqaCInA5MRTWpQvgNJBQz0KLk8EVr2iv+RampXJSo
	 k2Axs25zgk8qPP+gPf+VkVzSfrc0NLVs3xTkL5G454TXtKRliECENR19xdNoDnCxlNKCV
	 P+bNsEyahiCQeRVe3LmEO4G2QVpvfFaCMj6kzVeoTPbthfqhb+CzT/RpSRL88rwVXEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xlzJQo1o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C9606A327
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xlzJQo1o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6144B1F000C2;
	Wed, 21 Oct 2026 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594138;
	bh=BnO9ggs+OLTRcHA98zrmKleAC6MsyzgiSsQGY475bcg=;
	h=Subject:To:Cc:From:Date;
	b=xlzJQo1oHeWb6I3qeveunmIJlNGRj1OpCjM82hOCrsD11z4MFpllYvF7aagnNHtr4
	 lgae+bCyHaRVFMFIiKwFjlTGS21t6e96sUXTabk4T6nQDmp8J0Lso+f92r92ZkZ4Lb
	 lPJH+CzZXNkitOlM0tde+TMyHPfNMF70jb4AH/g0=
Subject: FAILED: patch "[PATCH] wifi: atk9k: Revert "wifi: ath9k: reject short WMI command" failed to apply to 6.18-stable tree
To: toke@toke.dk,mehmet.fide@gmail.com,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:34:50 +0200
Message-ID: <2026102150-alias-scorecard-d1e1@gregkh>
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
git cherry-pick -x 90201351a862182bdabfc1ad1c97b1e1b6ed5931
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102150-alias-scorecard-d1e1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

