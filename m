Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE330DD22
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086570; cv=none; b=XUC3NawpWyWZ3JgQmcgrbI47vYu+ggpIkbMaMCS9RBW3/EWlyJ7OgH4wkNl5NB0juoKFpfgIArX4Tzz7VOD5PkeBEtXtbTcMgIjCzhG4y/aWR9QVuunukqXQBOjyJqspt6GZGYuUdlPm01hLmcEG3eyXL7KgdIPudC7kpvZQGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086570; c=relaxed/simple;
	bh=QxkayMbqWX5LGS74vcDIcAT7rAfRVg0XdeRJ09POBBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5MwjkYRofzLx1k2/pPwQOveVUMjZUQSZChwGGEHOrbtTEkIN+UxhQiUshyBlnbqY2cpq/NPC1sFiWhRixgOe0AY44WsOSPAiR3OHAtT6ie7w4YjIKeS7b8ugwUs1SH9zKZ4iFFYc35YNAH7axIttoLR0QlueQ98Is9UJLoLMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=Mbo+uqYT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="Mbo+uqYT"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e8fa1b8d6so43204497b3.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 00:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786086568; x=1786691368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bf+D41gEUq1+J8o+TQe2hizsluGhOg1+Pa0bHuY97Ck=;
        b=Mbo+uqYTm1Ql1CaGBhKx8wSLtV513CUpTMUPGQ9/T9rHej9Vhg3kIDG+5Ztv6UDoiU
         OIRv8rEUnwvmRQfgBRxdqhZbJAX7fFYvajPVI5Hlz8iTS3iIeQdyNCstdwVfhmcG837a
         SnWYJ6JkTB2fN5BzmsrwlQw2gPHSWZ90VdkePLkkA3yzLNr+vpNkxcg0hQRv7tRV+0Cr
         M6G4H+IDZRLF9wwCjvAQrtO2xcx0GFyqvGeuoKN4NklUWrRW9Mfkn3SPU3HLlUM/OBb4
         WJif/lycKnz+w4O15LKit0E/eng/cbK4zZ2p/8meGVHunRhG49ehthumk9UZTbxfms5U
         rpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786086568; x=1786691368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bf+D41gEUq1+J8o+TQe2hizsluGhOg1+Pa0bHuY97Ck=;
        b=s8+z1HjPAc0/1E25Y+3a6/gbyu1KIp+49pMdYkcjXgZc6VsyOhtMde0sI/p6N2nyTI
         W8ZMkR1PMSHiDwRmsVNIVRAGrm5EKkllJlPVq7HH+FR99ZtNfQOLlUQCq/dplv7DLT2Y
         GtsXTvZ5YD/l6iko5sH6dyvqgZRFYKmN6y9VzJpNgJY9D1qvp9iicraS4DwLaqr5Uz+m
         UrVP+tiNAMKiF59gcAKzuYy/T82guODlMNbZhG191bxyMdf0LlsiwElT+Qt+rdUn3ENz
         N8iFpgcAcIvYxY0VFmnvNXm+rcFnep/NGjvBOssHt9nbkgE3f28vrGm+fKoLoM52wux7
         9+CA==
X-Forwarded-Encrypted: i=1; AHgh+Rpeaf6OxilyKDkqCRBHxoEx+rxaeEZP0p2f4PFvwZhlOR6Fa6vDm0PkyOyu/pv3HU97iqpXLCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykAm5dYETfgJXRErxlEweNdBXzpCHN4Qqkt9Av4GmDJRBvUu73
	oUP2qdXkNNqBQWcWGgr+cTcAbKIoiniJoIb9eZxFjvGxu2a/YdpCA5mzMuGVp8+GMJQ=
X-Gm-Gg: AR+sD135rPabVNG/amFmVFGXrgDmciPamjhB9kuaF/D+DsAerJ8edxn9BStcGMnb7T3
	z4UYWzzHlcMQxVBxPH1DqmfHVdhI4kqky2I/RJ6Orz2j0VecoNv0y1AOpfWs101DUud+Xl+mpsL
	wKf9kC83v4YwrozacZRaVn1+QQYZuPGNTlOo0pxap75QzcNUFircPxyyl2v4gCIZ+342OdX9JUP
	uEV00PcGGKuwv5Kb++d8oXvCVdDBYgvf8xGJAHFqECiaJqRIBtlkuKP2Fx8K6OZtyUDvhW7Kgv3
	W2Ra+BERkgcp85RkLD8fln1wMYsEuS+D+RhX/BviHmWZBpfD0AYE/8jX9qvk/G/LanCCQqYiprN
	No7vLCjLlEc39Y6xvQDmLwJuOAzv9cvzrxVD/TfhPKpzAj5eOM3FQSS6cKwWAegS9grexs/6Vkq
	m5cSkoCLRPNpxgEDqdadKGRyaO5+eMt57cRf9fEFWE01EX1AA/q/TegM54CTYO9ff9zxJU1U1rS
	iEcqqJq4rF4ILgoHCr6tiz3AH2Lzx70VE/YSyCVI0QdxG8HE+IwAFp40SilPA6Ae5U4+ppzVfJ5
	WaEtPqcxBHmhYYBMKMOn63gkCOPW69lKzg0=
X-Received: by 2002:a05:690c:2611:b0:80c:76fd:f732 with SMTP id 00721157ae682-82022539415mr125606277b3.26.1786086567779;
        Fri, 07 Aug 2026 00:09:27 -0700 (PDT)
Received: from buildmachine.tailf331da.ts.net (ec2-3-14-143-233.us-east-2.compute.amazonaws.com. [3.14.143.233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f0e64324sm5230367b3.19.2026.08.07.00.09.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 00:09:27 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Brian Gix <brian.gix@intel.com>
Cc: Baul Lee <baul.lee@xbow.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: MGMT: remove the mesh walk from the socket destructor
Date: Fri,  7 Aug 2026 16:09:14 +0900
Message-ID: <20260807070916.85771-2-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807070916.85771-1-baul.lee@xbow.com>
References: <20260807070916.85771-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_sock_destruct() calls mgmt_cleanup(), which walks hdev->mesh_pending
on every registered controller looking for entries owned by the socket
being destroyed, and completes the ones it finds.

It can never find one.  mgmt_mesh_add() takes a reference on the owning
socket for every entry it links onto the list and mgmt_mesh_remove()
drops it again, so the socket's reference count cannot reach zero while
one of its entries is there.

The walk still races the list.  mgmt_mesh_next() loads mesh_tx->sk from
every node it passes, including nodes owned by other sockets, while the
cmd_sync worker unlinks and frees nodes of the same list under a
different lock.  mgmt_cleanup() cannot take hdev->lock: it holds
read_lock(&hci_dev_list_lock) across the walk, and hdev->lock sleeps.
It is the one user of hdev->mesh_pending that cannot be brought under
that lock.

Remove mgmt_cleanup() and its caller.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 include/net/bluetooth/bluetooth.h |  1 -
 net/bluetooth/hci_sock.c          |  1 -
 net/bluetooth/mgmt.c              | 19 -------------------
 3 files changed, 21 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b624da5026f5..f49cec5f01e6 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -675,7 +675,6 @@ static inline bool iso_inited(void)
 
 int mgmt_init(void);
 void mgmt_exit(void);
-void mgmt_cleanup(struct sock *sk);
 
 void bt_sock_reclassify_lock(struct sock *sk, int proto);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f9ac..5073f4fc3289 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2164,7 +2164,6 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 
 static void hci_sock_destruct(struct sock *sk)
 {
-	mgmt_cleanup(sk);
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 	skb_queue_purge(&sk->sk_error_queue);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 167d75e34526..f13e73e3814f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10739,22 +10739,3 @@ void mgmt_exit(void)
 {
 	hci_mgmt_chan_unregister(&chan);
 }
-
-void mgmt_cleanup(struct sock *sk)
-{
-	struct mgmt_mesh_tx *mesh_tx;
-	struct hci_dev *hdev;
-
-	read_lock(&hci_dev_list_lock);
-
-	list_for_each_entry(hdev, &hci_dev_list, list) {
-		do {
-			mesh_tx = mgmt_mesh_next(hdev, sk);
-
-			if (mesh_tx)
-				mesh_send_complete(hdev, mesh_tx, true);
-		} while (mesh_tx);
-	}
-
-	read_unlock(&hci_dev_list_lock);
-}
-- 
2.50.1 (Apple Git-155)

