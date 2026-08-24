Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C34126BE1
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787537902; cv=none; b=nyrc0Y9eco/RchG1Z9DnfuOFy34h0ONeJ4LBl4LbtRLfIrmmLCwJw1z5Hea97/G6snIRCrcdCNeVckT0YcV1Ka4gSVI18u+76c47DJw6dSL80WWk7YfujhHJTk1rAkJmjwvLgOwW1XmihtBVgE+V8UMMo7X738nUTSr0mb3RfQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787537902; c=relaxed/simple;
	bh=Ru+VD86lhBhSk454Oyocv5T8P5aSVW/N0nVsamwbVv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2/L4EjESuZJ++uQrcrAhbGFcoe9WfvpSpNcqqNeYNUiMzDAGSTW+05+8AlTFJLN3uwEflDyydoKzuDQpdcdQez4tZdQKi/v/XanWOFO2r1a94S/VIImgh8KqkmNPDAyC6fIIWu+ssI0oGDXsxvcEjJY7lHvBDFB0q98JCEi2mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVM1P8g4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVM1P8g4"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbedaf975a3so247393a12.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 19:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787537900; x=1788142700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhypSWxOeI1zP+Bw3w2pXH1x9nj4tvFTNGUygwEptQc=;
        b=JVM1P8g4vz9ZLbxy5Is3hFDL/dizkgw2jPmgqd6qWdWKp/2dVIWJaz34SvE8yVX6i4
         AYcpMBdkAMpeD8Xj+hdBk0U7B2iNk+gBTKH34aaL2R+NC9moaiZFFeMIqbhDED82oKbd
         pz09WqI+NLPbeCmxCOxnYKr6TZjd4t958ptx/loos2h4jzZMzR7JDeee6+eGXKuGETLB
         ik79fwQ/k2RenclrxauozqW7ug0sOxq5P2f/EtO2xYO8K7EzsWzqDa7slmqsW8KZ6qHq
         J2hvGEnfzw7caSd5xX2g/8uYJ8PtWrjMxeLYY4lFDiVtxpohsFUHLThOuHasGDLtCHtc
         JfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787537900; x=1788142700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhypSWxOeI1zP+Bw3w2pXH1x9nj4tvFTNGUygwEptQc=;
        b=Nh7rt1dJFa7gGnCyX2EhTapUVBv5qtnWbS/khHyWpQ2/O4muY/GIhpBzZ0wYZm5nUp
         zqAmt5qifcT/mZOTNf19AodCGUkt8n8bRZ9Ee5hisYcCvnt9ThBdGLLQrRbAZaHUrn87
         cPPBgL71fSvHVMajjw11RfNufdLhpsdL9z22J6Vf1JfePRUl3Lp9rd7K7bP0ovA5S6mM
         iYsAw8feLK+7C5lR9tWCrKfSJSFTA66Gn+HU9fm2oXXaEtr4B00rh3kangEYezW2fzcX
         PDGayMabYhHLbizFkL1wwtzMTaRa4CW3uiJHcSIoeqElm9ChsSG7caSUb4T4J1a2Fx9O
         WczQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmO/APpwYosh/eY6JHzC761BWlHmCwHcKwVjWEP2bKqpC2HFVsiiU+Npo1OytZZreMgXupq8s=@vger.kernel.org
X-Gm-Message-State: AFuF++l/ZQ5GIy98PvED8pz7i64Ogq98wJYZMcrCg157jCb0TIdMyciO
	ytNf7cN7Zlz9tYfeDizOPN3XdXaxchj7OIhfKuA/J20LSSgMn+mWXVL4
X-Gm-Gg: AR+sD12P3NS9jynwQ8lykIwQm8HSvoS553a8LxVxGFaHM40Ses7d9DlcFQetu79XK0W
	umeEIUinFti1xCRs6Os8RxQlPyRAl5AfG43vPNlsXCQSuTXwBei5xjeBq75+nybmSBINs8c7Ira
	N9wglut/LnY/x9azqS3fNsb0bvrS4xw0ChePMrRtSSPhMLS/T8z/zRbw5kzEzFHA7lCdG+K0gF8
	s/xOYYwrUuZxsCeyD8TnbTro4u/UN/Oecn0pq8GSnZTyUwrd4lITTT5GhDK3dlLOYJdRWCRyzkj
	4v9xG6zRVpbT0W66jJz/5udu9xnI2iAEZPDh9Hq2eE+I4upEmKL5HkTTz4IIe6FlZYcTtZBV9/l
	3QqrJTVgPld2u8EIGE0Oc3VeTaNN9yuVT8K3rhTtei8h2Q6SyM8bHGOk/cfzIbdCwnNHdFIyDf9
	SXK+GUjVHnBLXw/6CJFUJ3aU02CvfMcoBzy6NIUE+CtKVbKTmk8M5IVaXK/7txv5DPfQUPlr+v/
	FUYv2aJC6PqiMmJxNiRMU/+Mq5xf7ghaCFcVbkLXVNEx4EnAq4=
X-Received: by 2002:a05:6a00:7112:b0:848:3dbd:5cb0 with SMTP id d2e1a72fcca58-851f9f1636emr13066590b3a.2.1787537900470;
        Sun, 23 Aug 2026 19:18:20 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b185sm1406434b3a.39.2026.08.23.19.18.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:18:20 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: jv@jvosburgh.net,
	jiri@resnulli.us
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	netdev@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] bonding: reject frames with insufficient headroom in bond_header_create
Date: Mon, 24 Aug 2026 10:18:01 +0800
Message-ID: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

AF_PACKET SOCK_DGRAM sends reserve skb headroom from a snapshot of
bond_dev->hard_header_len.  A concurrent bond type change can switch the
active slave to one with a larger hard_header_len between that snapshot
and bond_header_create(), so the slave's create() pushes or writes past
skb->head.

The hard_header_len snapshot series that fixed the SOCK_RAW send paths
deferred this SOCK_DGRAM race: dev->header_ops is the stable
bond_header_ops, so snapshotting header_ops in the caller does not help.

Reject the frame if skb headroom is smaller than the active slave's
hard_header_len, before delegating under the existing rcu_read_lock.

Fixes: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")
Cc: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
---
 drivers/net/bonding/bond_main.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 522eab060f9e..9ec663610dfd 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1524,10 +1524,24 @@ static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
 	slave = rcu_dereference(bond->curr_active_slave);
 	if (slave) {
 		slave_ops = READ_ONCE(slave->dev->header_ops);
-		if (slave_ops && slave_ops->create)
+		if (slave_ops && slave_ops->create) {
+			unsigned int hlen = READ_ONCE(slave->dev->hard_header_len);
+
+			/* Headroom was reserved from a snapshot of
+			 * bond_dev->hard_header_len that may predate this
+			 * slave (concurrent bond type change); reject if
+			 * insufficient for the slave's create(), which
+			 * pushes its own hlen.
+			 */
+			if (skb_headroom(skb) < hlen) {
+				ret = -EINVAL;
+				goto unlock;
+			}
 			ret = slave_ops->create(skb, slave->dev,
 						type, daddr, saddr, len);
+		}
 	}
+unlock:
 	rcu_read_unlock();
 	return ret;
 }
-- 
2.50.1 (Apple Git-155)

