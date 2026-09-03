Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D793D1713
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433889; cv=none; b=i1eHXWSmVbXxRZT2GX2gbblUVEOeyv8Feqf6sAqAs6nqK4DGJZ5fGp//sa7ef+bUDmRUFCxx5hkZEXNPTV0HLhdHW24b/zfswJCA6mLCg5V3yagFQxrBL8YNhFgnD0bxWrPuxQ/NLumuKousMiRQbRUtUC1aedkjJxbN0T8uMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433889; c=relaxed/simple;
	bh=62PF6ZVEPT2BoOqmhgVIdVWrDWtT/qFxo8C3LajrSlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku1YQwTE5jw/kxyJpG5leX41mNmloJ/UpXT5PNQslGkO15T4N/W5c9c8PKQyLrqillytAKasa/b+6Etw1Y9bu618h6QP34m0e0oqsjVf7fZA7HoPjk7DMiENwx26WuOsmcShT6ntADMvS11q+op/expVy/MkWxLqKODHpZo4lsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=r83eQ9F3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="r83eQ9F3"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so2322096a12.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788433887; x=1789038687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWrtLgfCNiD7LRwKf/k1NKKXELEJkegZ3oLlU3/e+J4=;
        b=r83eQ9F3+v7rC+rzwL4v9/JbQpicCj6xNbmgCR74qV7nP7Aw0InSHciv8jRQWShjxu
         qYt4fz0LG60zsh7pbdEQigC12heG0aRScDJ7pMdxV3BRQJkNTnGMbhjkhTwr+CMaEt5Z
         7eR0URP9koulXB17k9AAeU/h9LKUCTZP4mNeOEdcbn/VIo5Qn2QneGpafwW1mH+m+oM8
         2IVrVBfjsskEaYHbUKVVNOYY4fJvWnD82dfRUhSc0c22s+Uz/w4noF14La0PAamHVNUR
         kkbVYVRljg0Qc2Erqk8s2TgnKOOfSLEVsI6URAo4B31RmqsxdkMfW78glOqVGhJ3aCdE
         wCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788433887; x=1789038687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NWrtLgfCNiD7LRwKf/k1NKKXELEJkegZ3oLlU3/e+J4=;
        b=RZTUlxGblKWOTjFfr+JdKGe5jQUw1C+CNbQ4JE8xFn0rWiAIo+35/9pAzd7z2uT+0e
         AJS1hfk8dF46xwcCIX+YX6VgpoL5JmOAsRPolcdIbxfMSEMrHe7sbs8PWIXBz3D2M5ZP
         bM6nwQL9zy8QyxQ4KtIykvGq00WO1NWteQnIZF5K4FxTDxxG61FFFpDY06jrxE84xGOd
         jkkfht+KbOYmQGLlVfCCeihTjze/yglftpfox6YPkJvZMbODf37s92WsqVK9Cfzbi5TB
         infRb2DotS+4kBhbhqHm4I/rOG6QrjnugZr2oEMFndxQ/tby2zC9zEyt1eBXetr14kde
         9pGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwW213k6l1Fcogzn8stfWM6hux0wfmLx5PmwcBKIBKXHhOgFZ6PDbkQyvkOevP9w040l/hn0qU=@vger.kernel.org
X-Gm-Message-State: AFuF++kOZIkQ3EZ+G5ewm526uV+srRXA5REIN9HlVAqZApW+bgcDWt/c
	sukj/KYBSkq/FL1WUo0wdUE2lEi4LE6SwW6ZsjqBWriD/IkMHdUQr85j5iEjYd+JXP82
X-Gm-Gg: AYBFou3U1XtAdRN09bw2Nm+Rhx2uUpu5lvNnwnSxdbctes2Df+X8WRP9o4nKJxO75Mv
	w81vcuweAcM17ls0ZT1pxXT9h/ZJRoevVY7nPLT39wUxqhoY+dqWdjP2s70/BCI8Zy204G6mqqM
	LmJhM/4CpS/ysBmlh5zNwXKdPeiSvEyrSjp580n+leO9wbA0LBZVjkqIJa6FgXKLqLUecD3o3+D
	dIhB/SacEgrWiQCcuRXqqBvqICdm7lu/Tk7L7SSbSCxnnNj/DtTtyh7r/TX+rUEXFTQ7Iji4H9I
	mTtnid25a7Kv/hCYeP+ufqYDA4aWayDCNRdp1WbH4VQ++cEUGslXrCCTpekqufJzFu5zChKryNR
	sOAIk1QyvN39kBu+mfd0sbxyJtf771m4P6Yn6fuK312DKBjKEnbp9xX+3C9vLIrRZG8dfy8gN3Y
	CRJRLeYmrF6EIXN9vCCH17Wdhw4EO1EBt5/Q1vD1Aub7apdonK+XNTI9f0tSv8vXWzQmWGTtJrF
	EHU30RIvCOLnygvU7QtQ01d1zGnJIg=
X-Received: by 2002:a17:90b:6cc:b0:398:9bd5:490d with SMTP id 98e67ed59e1d1-39aee0eafb9mr18058900a91.20.1788433886906;
        Thu, 03 Sep 2026 04:11:26 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c3a526sm4810773a91.10.2026.09.03.04.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:11:26 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH v2 1/1] Bluetooth: Fix parent socket UAF in accept queues
Date: Thu,  3 Sep 2026 11:11:18 +0000
Message-ID: <34824eaea68a895a3fe9ed5337248eca1d81f74f.1788259244.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788259244.git.zihanx@nebusec.ai>
References: <cover.1788259244.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bluetooth children queued on a listening socket store the listener in
bt_sk(sk)->parent, but the accept queue did not hold a reference on
that parent socket.  The child side can later fetch that pointer and
unlink itself from the accept queue while still needing to notify the
listener, for example from L2CAP, ISO or RFCOMM teardown/state-change
callbacks.

If the listener is closed concurrently, removing the child from the
accept queue can drop the last listener reference before those
callbacks call parent->sk_data_ready(parent), leaving a stale parent
pointer and a use-after-free.

Take a reference on the parent when a child is queued and drop it when
the child is unlinked.  Since unlinking now drops the accept-queue
parent reference, take a temporary parent reference in the callbacks
that continue to notify the parent after bt_accept_unlink().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - rebase onto current bluetooth-next
  - refresh trailers to the current submission template
  - retarget author identity to Zihan Xi <zihanx@nebusec.ai>
  - v1 Link: https://lore.kernel.org/all/65767989c644f8adf52f35334f4034c66f47881f.1784383243.git.xizh2024@lzu.edu.cn/

 net/bluetooth/af_bluetooth.c | 2 ++
 net/bluetooth/iso.c          | 2 ++
 net/bluetooth/l2cap_sock.c   | 2 ++
 net/bluetooth/rfcomm/sock.c  | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 411d66f24393..61a232378e6c 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -218,6 +218,7 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	BT_DBG("parent %p, sk %p", parent, sk);
 
 	sock_hold(sk);
+	sock_hold(parent);
 
 	if (bh)
 		bh_lock_sock_nested(sk);
@@ -266,6 +267,7 @@ void bt_accept_unlink(struct sock *sk)
 	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
 	bt_sk(sk)->parent = NULL;
 	sock_put(sk);
+	sock_put(parent);
 }
 EXPORT_SYMBOL(bt_accept_unlink);
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 75bfd5938b2e..e709292aa112 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -286,8 +286,10 @@ static void iso_chan_del(struct sock *sk, int err)
 
 	parent = bt_sk(sk)->parent;
 	if (parent) {
+		sock_hold(parent);
 		bt_accept_unlink(sk);
 		parent->sk_data_ready(parent);
+		sock_put(parent);
 	} else {
 		sk->sk_state_change(sk);
 	}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b553b6356af8..3720ab2e39ed 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1748,8 +1748,10 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan *chan, int err)
 		sk->sk_err = err;
 
 		if (parent) {
+			sock_hold(parent);
 			bt_accept_unlink(sk);
 			parent->sk_data_ready(parent);
+			sock_put(parent);
 		} else {
 			sk->sk_state_change(sk);
 		}
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 958081adb9b5..a16daa68ecb8 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -78,11 +78,13 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 
 	parent = bt_sk(sk)->parent;
 	if (parent) {
+		sock_hold(parent);
 		if (d->state == BT_CLOSED) {
 			sock_set_flag(sk, SOCK_ZAPPED);
 			bt_accept_unlink(sk);
 		}
 		parent->sk_data_ready(parent);
+		sock_put(parent);
 	} else {
 		if (d->state == BT_CONNECTED)
 			rfcomm_session_getaddr(d->session,
-- 
2.43.0

