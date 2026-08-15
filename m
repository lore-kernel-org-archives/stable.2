Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768B2561A7
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786802996; cv=none; b=NVFSgL52oC0sL4kL3yeyaL6hh9xr2cUG9KLgj/ooRNIgItVQXJKYRRCTD8YGRZHdC5ajKg8SoxKva5YvsO833yzq33s9twyxifnLICwGVl8Ckw3Zv0KQQcHRaCkvHoADYPPQJtCHRaGlQ/30BQBbpmSDDgcvjiZeAp1T2JxDfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786802996; c=relaxed/simple;
	bh=S1LKiqQSNMlXcxi2Yv2UEG7wi3iotbbEkUf1MkDP2wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iwEFlTBpGIaDM6M/4vZWoxZVly2fzzKxugQe4oGKOEYA1o3+ot3xSmaGPaQXGBakoDgEh6IsxdjBxGyHRZJd5RWyy8FX9uodShJCVJWAeBtSKiSg27f7AiKHHJW9IXha2+4aE07KT9VquEdE/CK7GquKu8AZ1RSZ37CS1e8IiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIX0byll; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIX0byll"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1585251a91.2
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786802993; x=1787407793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rk+TK55LIKRB93LVwwGii2OByDhMrzrdTRJzsNIADDg=;
        b=MIX0byll+ZOae0HS3sebYFKi2Mub5gXColQEUuIeFFiPYx9fbclCfMh9VVaIZ+eYzl
         nHomhK5W51AXjicsG4O5FoJ6BbOvUZWKfKK2UkEwYL50XVJIULq40i0XReGfTvShqjta
         1PwcIkOQyE9ifGvuwv4AkwWi1EXTUSLqHwC3x4hIJMtxfkDjEHrXxfZRKEUS8eOAUNew
         u6d82DUHSCFJa4z6OM1+0XRI8rhnvXNcxczYSK6wy2UCfF2Coftn42aWwdKndxg9xPSS
         mSc38rBMe6IgI3a964RQpWGBXDi/rYAIYOv3W7nstwYtTp2IE4Yp5pSGDjmdtnONPDh4
         T3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786802993; x=1787407793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rk+TK55LIKRB93LVwwGii2OByDhMrzrdTRJzsNIADDg=;
        b=nrptGBBvchEWNKA/aBuCVK1zDrI1MZv8n968CcaPFNScAmStBNZH5Uhz0aqBLjRKlu
         lTBkIl4u2qoqw8/Q0PxxceNFjOfai3p/RGWkrF+aPkmpmmOKTxh8Hjuab28D3bESwL9B
         lgiKeg/FczSpfr013MMqbgICe0Y/yB0zdROobGIpGrvjY5QF5V87956v02V7rx9MwUN7
         68vQD+HiW0SCuAB69ztESaUg1no/YMdxMISlbkY0kPAu2PH/wIeTyjjL3yrI1zRK2S2A
         +VItQ2wZifi+WavBEuZ/+9nyGkoIY1pqyONYgPbGO0JbeCsWNpBKHKVjkBBZgKzwycyM
         2nww==
X-Forwarded-Encrypted: i=1; AHgh+Rqp2B+d02QhACgRLXoUAQIZvW3GG/ZWnd55QsHkUBD8Fe1NX2oRtMIUJ0t5n7lKdLbfggslCqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYio0f8QZ0lCF4N+zE5J5CzpkS+cthvdUz0WwwNYJQ8JgiMx3
	Ya1XzGEXe/MtJjgKUSyX1e7xxoHosSdCGSTqGmYFEXqNfHOUIvcPwiJK
X-Gm-Gg: AR+sD12Sp0t9RvAjy0iWoprPEPy7NR/VUvVDV3tnDogYOLLQgX50Nq0mempobr7BMVd
	M3vdzmekyAD5rsBQ9AzTNixzTxOvWngnoDH1Vxub96WltscylY4Q3dEzxno++wTTIlN3H0Eup0G
	3NWWfWRiNxewrWpyqMxEZvjmB1UnMO5+FazxlVpR8wDrG2tsSh6H69hQLqqE8bBeI4XYwdWfAZY
	5OKc2Ga3cEJjNs1sWlfYLtgpKUcJ/RPX25/WZzk+Oo9f0bY50bMFTx+V5AAPul3HyUV9BVww9SI
	eWUeiH47ZiQu3KnT7+AqFVO8WgMsppnN9F+Ns2cB42HenmDIjQYV3TlQ45ZHM8DlX+IquyuSZeP
	HIUoKiZ7NRf7bOTGRGwHP3JFhkw9q+jZKoMG91AWmNbnnu1GWBy7/g72VPpqIg9vOMsnbUHOFfs
	WsqKn62s4ZAMDgRaKJ6J4ZHScNb1d35+pDVc+FABADENozld0NV8p+WiCXEWg+jg9VXDqMPZ57v
	OnwXRIdCwwVDuetbHSsOTBK0xI=
X-Received: by 2002:a17:90b:2888:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-3933b95dbb3mr15321257a91.19.1786802993171;
        Sat, 15 Aug 2026 07:09:53 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea996575sm6327788a91.8.2026.08.15.07.09.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 07:09:52 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: loic.poulain@oss.qualcomm.com,
	rfoss@kernel.org,
	andi.shyti@kernel.org
Cc: vladimir.zapolskiy@linaro.org,
	wsa@kernel.org,
	andersson@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()
Date: Sat, 15 Aug 2026 22:09:31 +0800
Message-ID: <20260815140931.53297-1-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cci_probe() calls of_node_get() to take an extra reference on the
child device_node when assigning it to the adapter device.  The
matching of_node_put() calls exist in both the error cleanup path
and cci_remove(), but they are placed after i2c_del_adapter().

i2c_del_adapter() clears adap->dev with memset() at the end (commit
bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter removal")), which
zeroes adap->dev.of_node before of_node_put() runs, turning it into a
no-op.  The reference taken by of_node_get() is never released, leaking
the device_node on every cleanup of already-registered adapters and
every adapter removal.

The commit that added of_node_get() and the matching of_node_put()
calls placed the puts after i2c_del_adapter(), so the bug has been
present since the fix was introduced.

Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

The of_node_put() in the i2c_add_adapter() failure path (before any
i2c_del_adapter() runs) is correct and left unchanged.

Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index bdeda3979c48..61c535b8196f 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -618,8 +618,10 @@ static int cci_probe(struct platform_device *pdev)
 
 	for (--i ; i >= 0; i--) {
 		if (cci->master[i].cci) {
+			struct device_node *node = cci->master[i].adap.dev.of_node;
+
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
+			of_node_put(node);
 		}
 	}
 disable_clocks:
@@ -635,8 +637,10 @@ static void cci_remove(struct platform_device *pdev)
 
 	for (i = 0; i < cci->data->num_masters; i++) {
 		if (cci->master[i].cci) {
+			struct device_node *node = cci->master[i].adap.dev.of_node;
+
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
+			of_node_put(node);
 			cci_halt(cci, i);
 		}
 	}
-- 
2.55.0

