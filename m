Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C833936A
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720372; cv=none; b=VAlfRkGzscygldioq3BbQUNBVeGdCLquiA6S1WecxaC+TTRtCB4u6uAzXnPD0JD4O3IyBVfWfBT2qqsXmiHXhUGl6dCvaXVHyfh5E1xAGm+9l5Ynqt5lHc1KQQI6t9VhMLrcoVzqtMhYe1Az2G+OeVMM7Y67yxomUhXmGJHk24w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720372; c=relaxed/simple;
	bh=X07etQ/3rh1NMrzWQu8KGXCpHd+SxuX3v3YwUuiR9o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/QElHzv17s+PvdsWRBRTWa4VpA+fQ6mi2vMc3i+O15QaVxKCRG0ojWEV0rNqB3HJncqRX2fnOzNLXYZK/m5isZHYU7niDuwXuq333agN05d2ezyTo+b7j6zb7F+R+lU3nkAyacZb31Y6baik5eko6JOYJS3lebJ6deP3pEcMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snptwV1M; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snptwV1M"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so4386178a12.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784720370; x=1785325170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGO8UhUJTzgp6U+d6xDAFyWuyw0k6ECYlpjyIPSMdhE=;
        b=snptwV1MF8Anr7XiGg2bjo1yyz3fldDtEQmMbqtvyc98JOpMnHE/CTnIMlVeQYpEK7
         WmqBScQPkbVn5+2kiknOEGwnaQHtaiKoLNFhdLMtZ8EmVR7hvwTUHVshHkdv/CT/lTav
         9PQwq/CyeCjZSHYGIn3S6ov7K2pR9NwqAUkYAq04JddmkfcWW/EBfBF3UWbgvgI1WBMo
         5tpBruGfabbs1A2nAPvPdOiTX9Pz32Xv7ZieRvj/xiXY+hGjcn1mbZT2JWkDCrgGWwcs
         lOjrP53eJaT9psHkCzuHqf/Bc97gE4TccvMUIhaF2PYhYevv8JPXBSE4bZZPZkVbgHNN
         2d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784720370; x=1785325170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGO8UhUJTzgp6U+d6xDAFyWuyw0k6ECYlpjyIPSMdhE=;
        b=S0GoJ6+zqDe2ugV0NdIsnBi+hjYXmZvqSTEostWxLltIZ9KvBXtPJ57Up79sOX9Hei
         mVMvOn5P0CLBJ7OChumCInt6nLeYSoIXRjrxbSff8RRiv0jIQYTicOm0awJwYUVcbUwq
         K4OLtv1qVw+JaAbx/1hoy3orBFTMB5y969Q/eHqLiKlFuUc6if590jGUOcLDNgV9DL5p
         nIp5n7JpwdbRrb+RLrPRICSSpiCpnDUUYUZmT82xRxmx0rI0bR/IIIEcsGDuazvU8awq
         68VGtnDNvVI4vyx7HLq5HvyVM/jUEsn7olyN15KVuI3EAEH5VKNBORq3UL/oH/VrqkV8
         KqCw==
X-Forwarded-Encrypted: i=1; AHgh+RpVkfzEW7ydGC8KVZc2eKcrfgOtWwSTiJXvKLIt/HqdKCg8XXbORSg0uBcDovqOdMVIg5Q8pAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoyKQoi1bWQ90e1mk58OibHDxqtF+DHYd+VlcgwK/MWim2BgAe
	Wh5rOCnklplf4++EVI3RIvd0Gr5NXk3EDd4/SPs4GB3S4voz1tt4SzvL
X-Gm-Gg: AR+sD11z+C7UU9lpL/YZI46HwNUsAoYZpotvmeQeUyuCDF5P5uHDLf7i1AeQh601sGP
	mmS+5crguBGFzQZVMoX7nOFTuwin+wuSt5BlSk6Ygjsfc9pew/RyDqVQPWLppSOF0w/snWIa3GL
	memBTj+CUxcJ9kQb8Sq8izFrGt2RUDGiY0z0gvFccjq6QELv0BXlZrfwfzcA7JatfsnDZKTkVEu
	6A5CkhwNY/Nw6f6HKOZ3ap4WL/oaOtU/RS6arJ059Xl1lgD7qd1PDBov/jMYZkOTkkYEUzPe6zn
	SyqyxLqttxOELDVauPDaVphXFZ3+VnK7IB3QlRGf7AOYRusY9A/HjIz4zcaRmxSPmsiYmDaYpZf
	WN7EYLEzXdfeONZLiCFH7Lxk+/ihKW7rxYlUqT7O/tB1TOn8cWacpYwPZxDeW2AGfHQ8g4j7MAb
	yDTn6D7yXy/0W/nKh3ad6Nxg==
X-Received: by 2002:a05:6a00:4288:b0:842:6a3b:60d8 with SMTP id d2e1a72fcca58-84c29436f1cmr23351332b3a.30.1784720370334;
        Wed, 22 Jul 2026 04:39:30 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([2409:8a55:94d3:a1f1:120:207c:3304:503d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175f3180sm1177136b3a.56.2026.07.22.04.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:39:29 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: netdev@vger.kernel.org,
	Taehee Yoo <ap420073@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH REPOST net] amt: fix use-after-free in AMT delayed works
Date: Wed, 22 Jul 2026 19:39:19 +0800
Message-ID: <20260722113919.7723-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an AMT device is removed, pending delayed works can still access
the freed amt_dev structure, which may result in kernel crashes or
memory corruption.

amt_dev_stop() cancels req_wq and discovery_wq with
cancel_delayed_work_sync(), but these works can be scheduled again
from event_wq after the cancellation. This allows delayed works to
access the freed amt_dev structure after the netdev has been released.

The following is a simple race scenario:

CPU0                         CPU1

amt_dev_stop()
cancel_delayed_work_sync()
                             amt_event_work()
                             mod_delayed_work(req_wq)
free netdev
                             req_wq accesses freed amt_dev

Use disable_delayed_work_sync() in amt_dev_stop() to prevent req_wq and
discovery_wq from being queued again and wait for running work items
to complete.

The delayed works are disabled after initialization in
amt_newlink() and enabled only when the device is successfully opened.
This keeps the delayed work lifecycle synchronized with the lifetime
of the AMT device.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Cc: stable@vger.kernel.org
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Repost:
  - Explicitly target the net tree.
  - Add Reviewed-by from Simon Horman.

Previous submission:
  https://lore.kernel.org/netdev/20260714072705.129262-1-shlomojune6@gmail.com/

 drivers/net/amt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 951dd10e192b..7eb871b9b7e1 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2995,9 +2995,15 @@ static int amt_dev_open(struct net_device *dev)
 	amt->event_idx = 0;
 	amt->nr_events = 0;
 
+	enable_delayed_work(&amt->discovery_wq);
+	enable_delayed_work(&amt->req_wq);
+
 	err = amt_socket_create(amt);
-	if (err)
+	if (err) {
+		disable_delayed_work(&amt->req_wq);
+		disable_delayed_work(&amt->discovery_wq);
 		return err;
+	}
 
 	amt->req_cnt = 0;
 	amt->remote_ip = 0;
@@ -3023,8 +3029,8 @@ static int amt_dev_stop(struct net_device *dev)
 	struct sock *sk;
 	int i;
 
-	cancel_delayed_work_sync(&amt->req_wq);
-	cancel_delayed_work_sync(&amt->discovery_wq);
+	disable_delayed_work_sync(&amt->req_wq);
+	disable_delayed_work_sync(&amt->discovery_wq);
 	cancel_delayed_work_sync(&amt->secret_wq);
 
 	/* shutdown */
@@ -3278,6 +3284,8 @@ static int amt_newlink(struct net_device *dev,
 	INIT_DELAYED_WORK(&amt->req_wq, amt_req_work);
 	INIT_DELAYED_WORK(&amt->secret_wq, amt_secret_work);
 	INIT_WORK(&amt->event_wq, amt_event_work);
+	disable_delayed_work(&amt->req_wq);
+	disable_delayed_work(&amt->discovery_wq);
 	INIT_LIST_HEAD(&amt->tunnel_list);
 	return 0;
 err:

base-commit: ba712ecfd942b68b21a4b0a5daaf72f6616cc66d
-- 
2.43.0
