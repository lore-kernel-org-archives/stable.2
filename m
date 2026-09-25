Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E684119F7
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362157; cv=none; b=R1UPD0f1oUG3cXt+cnZRN1rUsyG8XKZOqHscvdhd8c0EZCDPSZenXaNE21LNXPmIjSapu7KXSmwNOXkRCWGYWw+yI5+Znf+zNZ2l+bEO9JwUWBCaXQjwgN5TljTfwck/7oC67DbKea2lUtBmIQrnPdQYXE6ve2XpEGXehcCmTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362157; c=relaxed/simple;
	bh=F8eGUcbXM9YJxxiTRFj1694VCKapoa42uE3eAkq3zP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyidePKokusxwHQpTFoy3z/kKoAZ6r2ihUi9zZw/Qp9z3tW4DFn5alvsh+0LmMueHkJvZrHWWlY1NTtBFBAMAQ0edUADZCcaFnQiTY722Y6YIxmsFeoifSWBBfxtHoV0muzT2Ruem0zt1dbdC+D4xoRYod5Q822DcI3Z06LBLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd6JilxB; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd6JilxB"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e97e2c7d4so710044241.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790362153; x=1790966953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kiKLmngPsfetWszmPVz9vnjkZ6oUGJcFeK7p9i5ASKU=;
        b=Jd6JilxBOET2kfXR5w38tJI4gEPIPR8nreSgtMQMGeLUOswN/XabL9//j8UvBgV50+
         1JchEB8skL8jiXnYFaU6XneVu/dGQK2PDu2EpfuLKHefcCNlHmUutYZKRH3gX3kaby7L
         Y4+gDiTFBPc3FdjpV9BMoA8KqFXE5uZsOg2TFMw2qur1p2Gc+RbaeLCDOo+cPdXg8m5e
         9Tsn/T8XOy8JthkW3hXw8EraNnWAh+hxCHe8erdijZWR+uLlXqJfulUABGtN59uHR+T7
         Q5nOU92OWRTnmfST/5dPR7xRgp7ILlSOOkuq3J48Q990xRp+UH2387yLdDtURCAcDOlF
         obkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362153; x=1790966953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kiKLmngPsfetWszmPVz9vnjkZ6oUGJcFeK7p9i5ASKU=;
        b=oRGnmEQKtiKltORMvDOXtsopqyF2LKl2aHnzfW8JYOowP0FQ+1vLE9W8O02fmjp2Q+
         T7eYpTgV7v/q2JTB98wWSRk+nYJ0SaIN+/gPV0ir/SQCULvH6DwMVrFIhkCktOqyVMow
         pEqPWdZkrd1rvk8TVs0YxPwrIohfjSnZFgdktxy4V/4FDsrDi99gth4EUHnD+pyAD5D7
         bd5WQpeJIHJs3IEWcaTPcNnX3QcnLriDiAk7PtCwiOP1CwUt/rhHo9Eh+gUAsljORRIf
         2rkczjMQ7wGG1Y68KvB8fB4xZtvIUouD+wt9GM9xQw82xrn9BSg68TN6uyzUDvQ587tt
         WD9Q==
X-Forwarded-Encrypted: i=1; AKwUvBz+kjRNyJSCtBRKjyQ346u9JiWXBJa7axFinj7I5WJCF2U9mTgfap/xE1BUT0UOIWZrhm6RF6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lbxg1sobJCREIsLgYGmId86wZ5MsV9GS0aKrUQqx9FG1bTWkC+
	4h5cLOcrJfPZZ84qPcZmjBLbjPRbgNjhRU5bV8KhkldGnqyYnb6hmFJO
X-Gm-Gg: AYBFou28tWTpHC2e66jiHQiPSP//6Xnhf4Y8i7bBAhLuPrl9LYldPTsKPxrqegbWdsK
	J+R99TgtIh+nYD3jajYc79TkJwb5NJ8pWOSP/c4RSJWJytDnzmUcnUzJXAJljPY0/UJR8RbbN/c
	xXCicZH4dpImNhtE71S9QLhWMkqe4TRdmUyK0ts5LFhBowXaKu8CcS4VpOq1k9/HlA5NhO/XFL7
	SPPg7Dre0jtNEIhXAOg9MhMXocw/tf+9dzdnyzJ8lSFuNsDUpX63DPxTIovuIktJMiFYxqw+f1S
	pD36BVoDPG2VFm9lNXmGzOC7BlwQq+OZaR8dBVmjEWsdRDSj7rw1Qo8iLJAI3T20nLNLRmSYc5/
	O8t/G5cjzHOJ/5EJKAgusqZVZoeCzTrTs0WlbFPOofOJYJegMnMIdMMWdKsBlM4xbG11V7EngLA
	R//WhLXCYsBubXYS4SM9KYcwNQtbP5yLbwCGsjULYgQYPVlEL7JOQgQnLU/HwF9Ou0LxzFK4r8M
	w==
X-Received: by 2002:a05:6102:10c8:b0:7b2:f790:c020 with SMTP id ada2fe7eead31-7b2f790cd9emr639017137.30.1790362152641;
        Fri, 25 Sep 2026 11:49:12 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861b029b1dsm3585744241.9.2026.09.25.11.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:49:12 -0700 (PDT)
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
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v2] nfc: llcp: prevent resource leak on repeated connect after DM
Date: Fri, 25 Sep 2026 15:48:57 -0300
Message-ID: <20260925184857.357926-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A nonblocking connect can return while the socket is still connecting.
If the peer rejects the connection with a DM PDU, nfc_llcp_recv_dm()
changes the socket state to LLCP_CLOSED.  A subsequent connect() on that
socket currently overwrites the previous local, SAP and service name
without releasing them.  Repeated retries therefore leak local references
and SAP allocations until no SAPs remain.

Release any resources left on the socket before obtaining resources for a
new connection.  A closed socket can also retain the device reference held
by an asynchronous connect, so drop that reference as well.  Bound sockets
do not hold the device reference, so release it only when reconnecting from
LLCP_CLOSED.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260923133339.2518641-1-qwe.aldo@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: fix author name (v1 was sent with an incorrect From: field)

  net/nfc/llcp_sock.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 5558d8a..e76361e 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -690,6 +690,23 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
 		goto error;
 	}
 
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
+	}
+
 	dev = nfc_get_device(addr->dev_idx);
 	if (dev == NULL) {
 		ret = -ENODEV;
-- 
2.43.0
