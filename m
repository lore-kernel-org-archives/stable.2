Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169F3264E7
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790567886; cv=none; b=r/bv/rW1ojahTJZMtbCvEVkEYzA3DsMKxgUeaJSIf0iWkN4Zg8aywV0Re3y2+A1JJIJLMjsJU3X/Tz/h69NnC0i4S0r9YHzSIGmzJl0yn6IEZefBjHEvhUa2fIZnoZjIChHaUtYXCVqIgGPXyClyq9rq6DPAwOfsrFDA5Bo6BN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790567886; c=relaxed/simple;
	bh=RCb84R1Ilbqk/brMo0ozsD4weTDX3UUsJYqs8fer/vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXo7uYq6EeuMtHLvDuIrBg9IoR8yvviqg192lAC9z7GuFKb423uWl4a8EBFaMkZF/rCzjqJFg/KkJegnNAwR4sD9Nn6e7HSaR5afzE8M5OwLbnUQ5XkZvAni52WHzx1QJAwfG4YDTIeY/0YtD8rJJ5eJivLS+kuZ3OcNXQSvUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE+5RxAk; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE+5RxAk"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8c8602so1449762241.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790567882; x=1791172682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8PRQtLnkGcQLLad/iSnwkqrL/4wKHSNHecCDuETOGrQ=;
        b=CE+5RxAkoZPF2ZDyvTb4nIJQXt18JC74S5W5fHZRCroLzNEnPs11sUoEz23V/sT3Z8
         SVhKP+SJOvXap51n1nPCYIk92nSJ52oJMKqJPcKWpK2GQwxguKxijjjHd6/azrnwnmkM
         Q2hOTulTf7+QyEUR2CGdNKcbuKfSBh6c0A+X3X/NPcY6h0zP1fWMe7h23OFZIl2gymI/
         ayxf4a8x9I09g9E1PEv4xgQAVbQryQ6Rk9/r0/SlbaMcqe/D1Wrr+nfcrZrT6ih/oGMB
         8dskjENNoAK3R9kQUmjMBNV9e+GBQYXGDdYuK7XUj63GnU+U0oou6DIakZPLGORJOKcR
         py4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790567882; x=1791172682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8PRQtLnkGcQLLad/iSnwkqrL/4wKHSNHecCDuETOGrQ=;
        b=qq9wF0R3DKnE8jY3+jBb5dPy0jELVUx8yDQAw/km9ZEczhGM0YfXt90mIJHn1GPxuA
         mLLFv2czM3m7ahMFX/fPG9OtGjTxyrjUG0VJNf5snlp8Nd8ZSAAmzZ3v8VWv+R7xM4Od
         Sb+DgtiI+JG+pEOvdvrVDM6QaRT31nIMSEqvYSPVw8PTy2VzmxoKr0wGyQUtRkTI2JPL
         qJb6TiqlPJlOHrtQiDirZ3RHz38pG/TYDfjHrwC+C+6aiwXsRkM38JCzUCet6w1TIfFA
         ZDjU6R69u7dkOegF4zdH267T6Wy90OTtplP7mZfzinUcBARQLHiBbu4usI4KfQ3z82nn
         l9xA==
X-Forwarded-Encrypted: i=1; AKwUvBy4038eK86ABvwi7HwiUIfGjmSmn8qFv/O51OyNvaMU59dWs+HT5PSaFPYF3Vshg1VT/ZYeoKk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIF4ChRBoJfEhgvDhSD34MmiJfnaX7aceFL0SCagWfOKZ+ZHZTL
	1RaApCrJBzcLZpYY9yUa/mKRjDwauHenxRfA4LqHZUBTVpmafNRDPPK7
X-Gm-Gg: AYBFou295mj38SGhOIXCzAYT0Tj+EsukfK1TEt5mRd+R5dlgTVbynH80KphPmG6vbHT
	WMkPoJ0DGP0GpRB1jgkTqK01/DLTgBNizEN46oqZLr7AveEVj796z51H4CAQHkcdRJJAcb2GOWd
	DYaqPecaeIWh23+b0nCvR8EZExfltdfxvoT+Mg38cX8YyBi7oxL2/3+1Mu3hRTVe1yxSVsbK3it
	V0C/0BTLT3WQ6TmWL/5BZc4sxyLo6wBPFdA081ns4M5HOEpz/CNZiq4q/ZzyTNE4lJmNKABeHuD
	MduvAKZN4AQZiNocplLnBMhySY1hNSvDEWNYbhXD7Ops+jjLeOl3Bz+NIny8z51i0N2V0AFSW9E
	VRQ9K7PcRP0diN0wnO5DBWRvZdSYRz2XN/R4+eVAg/Xs1urQGw0zkynxauU1c6wnwijLaKhRF7D
	OW2/9ob7CbitLRqorynJS6ul96dYBE1/EEu6UCxvAkNgFLMbyfGK5bc5iQO0DZ34Y=
X-Received: by 2002:a05:6102:358d:b0:79e:2b00:b4da with SMTP id ada2fe7eead31-7af1c692c06mr4663990137.6.1790567882180;
        Sun, 27 Sep 2026 20:58:02 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b15808esm8107452137.5.2026.09.27.20.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 20:58:01 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+ci3c472c63e196fe9e@syzkaller.appspotmail.com,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v3] nfc: llcp: prevent resource leak on repeated connect after DM
Date: Mon, 28 Sep 2026 00:57:49 -0300
Message-ID: <20260928035749.2305913-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925184857.357926-1-qwe.aldo@gmail.com>
References: <20260925184857.357926-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A rejected asynchronous connect leaves a local reference, SAP allocation,
service name and device reference on a closed socket. Release them before
retrying connect.

The device pointer alone does not prove ownership: bind() puts its
temporary device reference while retaining the pointer. When device
teardown closes a bound socket, the retry cleanup would put that device
again. Clear the pointer when a bound or listening socket becomes closed,
and after a connected socket's device reference is put. Do the same when
DM closes a bound or listening socket. A DM rejected connect keeps its
device reference until the retry cleanup, so retain that put there.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://ci.syzbot.org/findings/64002827-5231-4183-bfca-0d91bded8543/syz_repro
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v3: Clear non-owning or already released device pointers on close, while
    preserving the device put for rejected asynchronous connects.

 net/nfc/llcp_core.c | 12 +++++++++++-
 net/nfc/llcp_sock.c | 17 +++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 199543c47eef..6382aacca69a 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -95,8 +95,14 @@
 
 		nfc_llcp_socket_purge(llcp_sock);
 
-		if (sk->sk_state == LLCP_CONNECTED)
+		if (sk->sk_state == LLCP_CONNECTED) {
 			nfc_put_device(llcp_sock->dev);
+			llcp_sock->dev = NULL;
+		} else if (sk->sk_state == LLCP_BOUND ||
+			   sk->sk_state == LLCP_LISTEN) {
+			/* bind() already dropped its temporary device reference. */
+			llcp_sock->dev = NULL;
+		}
 
 		if (sk->sk_state == LLCP_LISTEN) {
 			struct nfc_llcp_sock *lsk, *n;
@@ -1330,6 +1336,10 @@
 	if (connecting)
 		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 
+	/* Bound and listening sockets do not own a device reference. */
+	if (sk->sk_state == LLCP_BOUND || sk->sk_state == LLCP_LISTEN)
+		llcp_sock->dev = NULL;
+
 	sk->sk_err = ENXIO;
 	sk->sk_state = LLCP_CLOSED;
 	sk->sk_state_change(sk);
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 1e5ee4bcde68..9d76c12aee01 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -713,6 +713,23 @@
 	if (sk->sk_state == LLCP_CONNECTING) {
 		ret = -EINPROGRESS;
 		goto error;
+	}
+
+	if (sk->sk_state == LLCP_CLOSED) {
+		/* Release resources retained by a previous failed connection. */
+		if (llcp_sock->local) {
+			if (llcp_sock->reserved_ssap < LLCP_SAP_MAX)
+				nfc_llcp_put_ssap(llcp_sock->local, llcp_sock->ssap);
+			nfc_llcp_local_put(llcp_sock->local);
+		}
+		if (llcp_sock->dev)
+			nfc_put_device(llcp_sock->dev);
+		kfree(llcp_sock->service_name);
+		llcp_sock->local = NULL;
+		llcp_sock->dev = NULL;
+		llcp_sock->service_name = NULL;
+		llcp_sock->service_name_len = 0;
+		llcp_sock->reserved_ssap = LLCP_SAP_MAX;
 	}
 
 	dev = nfc_get_device(addr->dev_idx);
-- 
2.43.0
