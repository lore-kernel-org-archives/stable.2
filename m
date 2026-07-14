Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74C370AE5
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014088; cv=none; b=neS63+V2n/EL4YqQoGZ2rnrApTxHwc0/99Uk+HTMiwQaY8RGHndJ0e03PDH6aAjQ87DBi8cPKAxdoBgoojRXeg4S/3NSK7gNtZO+THm1qvTttlz4ygEz9Ra2I1yebzMFif9b7yVhVV89dzK+TMwSkleRTfp+ULO1nHk+dkkUjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014088; c=relaxed/simple;
	bh=VV6RH/yKbbXGqbCZVlFLWMvC2IkSZjVrbZxP+GH89A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5zBfRkY49T2ut2gIpSQmu3Y3wgvvmUMyXfojVnH3Ks0nT8J5FfVlstBGdoWiM7LpGzThoNQXUMi8Pv8mtZqoJaQEiPwephojU+4zO315hyBUm7UNALz7xhzoEg4ggVo1HfjCwQrdywPdbWcRscV6g17PW3cybm7u7kSl1U2bss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrQKtzVE; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrQKtzVE"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9486571b64so2287964a12.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 00:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784014086; x=1784618886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UL4JsWWFy5+1VcD51BCzcQnL+AOhOLYxnY1WLoSce4c=;
        b=MrQKtzVEK6cC864IUWe3vPOz+tNabRozEn2LOjqLNDT7Mv/1qS6ZzvJN0jatk/6BYD
         0aXrWJV2LEUGzI9NhlgvcOd5p4zhDf4cgjbeeI0FWswQnA2/2zKSrCCtP9b3ndmXNqM3
         t4WIyKTou7pBYd+W3WEh+5r9L/B5SwdaHZSODinrUXFSe30b5p5D+nuNkCpZ8YtFaK7K
         yu0y6V3EjupH6oWVGXEOHWbW65pOw8C2Qcne+Vt1YF05S/glcnzK1dXXqVUKI92LL772
         UHPwNy5lO92nmraNgsz7wgHEZjCpICyJmlCJcmsCgLSrcm3gW5rphIFAySpSY1cFQ2BO
         BLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784014086; x=1784618886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UL4JsWWFy5+1VcD51BCzcQnL+AOhOLYxnY1WLoSce4c=;
        b=RGjSVIOs+aV88HPKTtNLCIsv2ZfgVb5c3nIhmUJYlQK4kykC+AeIBO+KrSMOsQd7+D
         0k8XbY9mhCsLwOixF3AS0nsFjjQJR8WtOzU7a+mcZtPSlrK4/PYFZhwAthL8AZ4StXnc
         F5uz9cOCZR+8nZbD3KcSlYiRvALOxCwM4Py0Qy/kx3Ul+cAJ9/yBKGLk6h7oT1KdUGvi
         NzrazD4LaCE6IZb7dUFwJ8b13uQ/D+i8m381ZBuIOjjqQQRDGXyWfcg6dm3Qv4OQGMZG
         0uidarfE3rx1rmAr38w4Dx1a4mAXQFqLmoQXAn5cTHexUhFBnjP6oPx7wdwbKLlGXTgp
         pm2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrgFDIXw5S1pm9iMU2yLkMDZ+bgS1/UI1XwfCAY5DFCWZrs8wbnZHjGlMQqeHchNcdxCkvsr6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4VQSgRhYEsVnbLUm+y732QEPj9mPLs33L4TFKm3F9xC96dkF/
	NIZZTAbNlOfYwncsGFEDTNsU0dz8YjfMuWn00eTMnWUqARtOxOkN7cwwWn7B4We0WSIHXzMt
X-Gm-Gg: AfdE7ckirV2o62PUvP9TqiRqcRFB7jIDsRBwAAV9Up8K08erIJxTC9yHjN6kJZw+Th8
	3Ih7cgsVWMiCJjPl7ucG69w+Glf74//Ix02OsX5i7LbeopTmlqVlFN4Jl8CdCxcgLUn+fldvnfi
	NHtgQVFEEzPxL76qArRWp5FX/xyqpV0cjkKjNIUIcSRvgeUU83A2EP8CUZ6WNlybxaQi9DoOksL
	rxEBX8A4EjfoRnsOD7Hc8Etj8ORDzv2i1EdzXikbZrlopHUL5pcSUvs9d+89Va+rAfnaBiM7c1u
	xMbmV6IzbA2jATRQRbuUV5fRDM+gXis+p81wXBd5b6cJlrWf9agFtsqisp7zf0JIarqQeXntBuk
	N96K2VuDDuzjYdWGr03hF7PeAZ1mjd1E6VpK9jVnqFV8+A+aMQYQ4pW/FN1GikAaqDNGBlaV+Dq
	DVHRQf6hhggMgLeUoJTj7YnM4gpRElTX3uCA==
X-Received: by 2002:a05:6a00:1943:b0:841:58b0:82bb with SMTP id d2e1a72fcca58-84a5576ce8cmr1383065b3a.9.1784014086315;
        Tue, 14 Jul 2026 00:28:06 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([2409:8a55:94d0:4771:cc5f:41a5:d797:4728])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f80de8esm975471b3a.56.2026.07.14.00.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:28:05 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] amt: fix use-after-free in AMT delayed works
Date: Tue, 14 Jul 2026 15:27:05 +0800
Message-ID: <20260714072705.129262-1-shlomojune6@gmail.com>
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
---
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
-- 
2.43.0

