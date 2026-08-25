Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC693148C9
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787701603; cv=none; b=c/gAOUddQCcPBRlibarnWDr/vdgZ166X0ble/SWrzC/B4CtXr18VXvAbhz15ChHyJpQ3WPUIv+q/zhvXdPDUt7Md3Uqp151mPwskLj2+ovgA0xjjvF3X9bgaOE11WOF8RpthYcUDlIBEtI21PfCrZnkKBVFQpUs+DzcXHue4uQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787701603; c=relaxed/simple;
	bh=2WG4lWkbpVM2Cz2ndVMiP14/1xdwr1L0sM3Pbf+biZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vuq7EfFlcSPme4W4TnIhFFX5fxBGCPcdYPpQcia//nBT/ewf8KUGEwsAXhq7sKOmQGEDt5Vy8Di79kBnoAeGJvcgJ4GjtlFhvuCvzeoRwvSLU3koSz8RZmXKrBXzeUSDw1rgwhLsHxFS86shVxTjpfw/6PNc/RQu1thGzK9g4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUUj0uHh; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUUj0uHh"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc147d86bebso422883a12.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787701602; x=1788306402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AqYfwfuzUpAhOyx/YsImOZguVIuUdvA0wyyq+qn7HR8=;
        b=NUUj0uHhHgtOdFgh63PRsCAac6DCbQCTs0KeMnsrSWiMiGQb8sa88eqjh97/AioHBH
         4Bg3hgW9IWTaNiE9+J8+BYFibr2aSSV8v/2asPda8g3rL1CJbcvQB8WIt3XJ9jYDeDdq
         ihpduIWXlY75IjKnVMxtBcgc3brn5mI8hJprIpC52BZPk+fnfgUHiwGdbnYfhOf5NEAb
         VDsbK8U6ouhX5e85W1CfzD3Ern61QR0q5JcjWx0PfJChWBztdsJzoQ048xakSJhSSdpp
         CWaaohBCAaxMFgrV9aE5Wcf/60Rui8bS+hTGcuowhpX4kmFIGfqwWqG1izoj+rRYtvvB
         cwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787701602; x=1788306402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AqYfwfuzUpAhOyx/YsImOZguVIuUdvA0wyyq+qn7HR8=;
        b=NlE/abQ8K5h84ZEYMTN8HyWbYjn4BZKOxO/rT3AuTo51cqTHTSPpg1z8QHjmFcuf5d
         r3HZP58Qstusux7WYscgwN6bbqhUw4jEwugcHpl4l2TvNcEXtjuCM/aAX3G/4QJOCP0V
         ZL5Z+CgfhWD6oGHWH1OLnfHDSbrCStehFz3hWDTzEMdJmx9O5SMQya1BA98VHYrqHVSq
         b1oZf8qpCZrNWsXJmSp1OIfUjPl8BtCBjVFY8A5bPhq2+XegVmYCaaMy6MinCBdAmC1Y
         JKJzg1rFeXMlCJJuYJzXvQTq2D4wRTOgMk0hp1yU/1TF6SUoL+/RCJkRM3t+s2moC5hK
         B4BQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOwJhU6kv5W65/UdKVkshxxjQMfCWx6fySPebh2BpykUkx6/OII70Dy+ba+2P3gu0QyUBJmbA=@vger.kernel.org
X-Gm-Message-State: AFuF++mQ/C9ra6vtfiSisPXieiR46/k68ylfem3Xz9qudM7f7X01IKvG
	v8OHGxGdUfj+i/8rl3Q4Kjf1mR8sDpR8ajH7UzLbwUIVMgpqNLoa22hb
X-Gm-Gg: AR+sD11+Ddy7jda+1bvbulU/s8bj7ysCf83LV5k6GLJc96MpcIrkOfPIG5jNd/UgLDa
	rOcQBovuh+2lKG0uzTCHx9kH6R2BdHXWZaFWy7X0rUst8Gm8ZHGjoGfkZyUDeESOOj7X+oBWxIp
	LwnpWjOpEeK2UWHG7mrKt+vr0A0FAy9URxYJ9PnZNJyvuVrHWbBmjxXEAFXkcsWQf7haWzi400E
	HW9Rvtf6bf5rGkKC65ZmqKL096yyT2MjVSvXHvJbALKWwrzckktQ9blGJ8jHVhwjpELzXGkWeSD
	o1V9LSiN2GGGYFdCQgs3d1KRHvKuIHTFyWsO6nPMdxmsPMXT8SfSn7kxkDg6TNQEb5Ah1nKqTEd
	mmVDhkZcye01NpAWYXZflhcs00QWB8rF9nGd9gCDmJBMWE/5phZXic9aiii2VdDTrLbmIv2RD/2
	tIT2gfKdyKqxPG4psE9LT1M16XjAIQUofc9yWD5DHhXJnTe+GesP0Le8Dxx+c0tfN7Ph/jjdDMz
	EKHMtZCfAYZEfY2v4Qxe1GBQrNDSOoHx592+7bARrI=
X-Received: by 2002:a05:6a20:e210:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3cd8f277b90mr11815952637.14.1787701601639;
        Tue, 25 Aug 2026 16:46:41 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60bf36sm2764869eec.2.2026.08.25.16.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 16:46:41 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: corey@minyard.net
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>
Subject: [PATCH] ipmi: Fix use-after-free of cmd_rcvr in _ipmi_destroy_user()
Date: Tue, 25 Aug 2026 23:46:29 +0000
Message-ID: <20260825234630.1196170-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9e91f8a6c868 ("ipmi:msghandler: Remove srcu for the
ipmi_interfaces list") dropped the synchronize_rcu() between unlinking
the command receivers from intf->cmd_rcvrs and freeing them, updating
only the comment that explains why the barrier is needed.

The cmd_rcvrs list is still traversed under plain RCU: find_cmd_rcvr()
walks it inside rcu_read_lock(), and handle_ipmb_get_msg_cmd() borrows
rcvr->user from that lookup within the same read-side section. Without
the grace period, _ipmi_destroy_user() can kfree() a cmd_rcvr while a
reader still holds a pointer to it, causing a use-after-free.

The rework only made srcu unnecessary for the interfaces list; the
cmd_rcvrs list still relies on plain RCU. Restore the synchronize_rcu()
before freeing the receivers.

Fixes: 9e91f8a6c868 ("ipmi:msghandler: Remove srcu for the ipmi_interfaces list")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index ab4c85f3d6fe..3f4018194df8 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1391,6 +1391,7 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
 		}
 	}
 	mutex_unlock(&intf->cmd_rcvrs_mutex);
+	synchronize_rcu();
 	while (rcvrs) {
 		rcvr = rcvrs;
 		rcvrs = rcvr->next;
-- 
2.43.0

