Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0152D1916
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854302; cv=none; b=IU/POd2YwWXAmMoUCQzDIZSJbJbV9+DcCiFwr58R5c1QpwlrmPAYFms8AkaGozyNY9e3MvqtxEmpAIDMiLGm8qyiDboj7LA54vU6Vq8OTN28rQSK8D0nmG7NjLH4eWYqHxv0xoOhBNdxP12OTfoWYBertXQzL7nBrIYeB1esjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854302; c=relaxed/simple;
	bh=blmSz0ucFYiG8IMVfZLdaXb020QBlMaQczvCK7E15mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uriLH0jw+bepYY2ukUN2a5/DUYcPbdngFUq6v6AO020gUE9RCYsIk/gXkPqPeOW7rXmUnqEf9LNgqLwLwJCOMwOFxd5qLLkixQiAQcPI0DDRUYObM5+7uWrr+KZDaWX9jbNAF1XJvZE+v5G7n++44Ky/dyg37zFy3cCdnxo/ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbxG12rr; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbxG12rr"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8000e21f014so56579097b3.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782854300; x=1783459100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2poGPPDKuIRln5tPnA3S6uNyhm8S9MHlvQPEbWhmm6U=;
        b=LbxG12rr4PsUtTJ6Ojiajta+pwvBJYbTxn7OUS/ZnAF+3aw79w81fUp0c2Pmv6BofN
         vJrBYwYW393ImQXBwlfR42xMIi6RGxiwwJdR7ePdAtZrp+ewE7nFlSZ5T8LJpSpx3Z5f
         ZVuNS4IhUtS3bVUlENg+aw0AgSLfJgGxEwARhJBg8EX+JWG66/qxe2xZCdtkrw+Uh3ek
         pd1qbAWTaCOIQii9kPB/yHuVp2fxfrRw3jaoGPPBhB2Okn2zamhXL0cPlD583OGq3K4d
         CyFnSuK6BkA4kRJadHNKh2SZhwJytLcVwh8tRcJBCNMUlK3NCn/yU9kKWB1qvUWk0UyC
         kqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854300; x=1783459100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2poGPPDKuIRln5tPnA3S6uNyhm8S9MHlvQPEbWhmm6U=;
        b=kiVTqE7BlhcYC/NTBRYk8Bn6B0XSRDS3INlfQGG6k5YZ1FGRujh6y6EBVoJyIxgNPd
         JaT2e7/5mDFHtJjelGF8d/XURo0HRdFKdBeCWU/mbws4e1HpZkS/dQQPlDYdzm+iudmS
         aQc5M548Rd3c97Ggmz06yfOb3NtqVdcWyUay9J1dEYa2dAudAvmxz4RvVHr77q6/qYr3
         Vm+8WwNzgR6bRo68iLLXCu3In8mafHX+hNnMIA8gPI9pUnQb2lbkgiYfYVLKUHkVsDDf
         ur3H3PlZ3h+Mtd4rbTkIzAG8lu23IJfASuwZHt2ILEJMDCAvJRFnBWXcbbdPr74ogZRu
         o6KA==
X-Forwarded-Encrypted: i=1; AHgh+Rq1q5zao3PjQK8AO3JH1GonpK41G3C52qlVBe0RMho6uDJVYkerfjCLZ/sdmZ5e30UKZUofjsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy65nffrjZwtkvH0dHt9PCEBy5JoIh3558OOZHaSRO1aPGbT0L
	xxBk6kVTPCqupT/2gzEY12yW3BjK4LvENTpCI0Ewkju4TL8hG5RaQ9fy
X-Gm-Gg: AfdE7ck19qfBU0M98EufV4piVYFQ+AbAi6AJERSaniRSemPB9TeHZMdYxFOYuKeElkh
	nLJD7U6IOQ5dHDHofD5QKNeNxcWzrJIZlcU0iZkQTDbfbtfvPLK4ooPwv0Zs+r0Y41JjvEJ60Q8
	7AF/PJYEJzMTnNeockkAkcxY5ZIMt7dEqSmDtocPARs++SZ7Jn3gic3Ahk3JJ6zuf6gttgYtakE
	8v7sQdyQLxyv+1HKqFNxwcwiXWFqbhjD7u7rbgRqdnBHRlns9SioikJ5XyJMC3Zvfg2kxE7k2yb
	sx8htlcWmPmlBsvfngqO7kIQKJcpQ8qdTmW6ZAIGtKfUV1k1utFJAuwq8eyQ7sySWY7vvvqebQr
	ZYy8E/eLWMWCVxgtTTmWwrvvMu6Dh1IVQQOl2bliNQa01X40SP377r22cqVD8GbidJdcsPmsXSb
	tBpwt2WShCITHmXD6NMrTt6Ai9VQ==
X-Received: by 2002:a05:690c:9c09:b0:80c:85c6:898f with SMTP id 00721157ae682-81204145786mr20454527b3.62.1782854300375;
        Tue, 30 Jun 2026 14:18:20 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8128ce56f3fsm29517b3.27.2026.06.30.14.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:18:20 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net] mac802154: wait for RCU readers when removing interfaces
Date: Tue, 30 Jun 2026 23:18:08 +0200
Message-ID: <20260630211808.50440-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue wake, stop, and disable paths walk local->interfaces under RCU.
The bulk hardware teardown path removes entries with list_del() and
immediately unregisters their netdevices, so an asynchronous transmit
completion can follow a poisoned list node in ieee802154_wake_queue().

Match ieee802154_if_remove(): use list_del_rcu() and wait for existing
readers before unregistering each interface.

Fixes: 592dfbfc72f5 ("mac820154: move interface unregistration into iface")
Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=36256deb69a588e9290e
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 net/mac802154/iface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 000be60d9580..73d82a015184 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -703,7 +703,8 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-		list_del(&sdata->list);
+		list_del_rcu(&sdata->list);
+		synchronize_rcu();
 
 		unregister_netdevice(sdata->dev);
 	}
-- 
2.55.0

