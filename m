Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528C318B9C
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941315; cv=none; b=o4LJpll1bVHVFbPh8VHlQEAnk6o0fWf5XFlDQeJj4cT9VIjkZOFq1N4KPBGzTt8UzK5AdJ7BQ1Jcgmbh+t5eGACrjSrq807/V00RjRxWvlXQf7D9KrNO2J0sxnPCm+mJC+8o4uXnzIS4MnvlWwdH5cxOPOKLt3FPkNbu2OigcyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941315; c=relaxed/simple;
	bh=gmVQW4zvgK1RdCMOSrjGY3Z/g11AJJIEJYvUSmj2svQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HGgEI7LYxTGg3Hw4XO7OeORUOy9d0ztNMJXs/f6z7dikbVtyMbLP3pmeJltdEHhyx/RB7DDypE4foGeTEXVWJbgh31MieL0zn+nzo9hpFws6i++keqRvZtmSZ4o0zsFduJf/FRGbRIDliumHJevOage3tjcmSG7cdN1btRja24I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9BXdVCw; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9BXdVCw"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3a8c118e711so2029133a91.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791941313; x=1792546113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xF4abej4dYzWW64tGMfNwkdoR9vBgU7tCntIFYf9jb8=;
        b=i9BXdVCwLO48JsGMxuGlDT2FwFtBPBYvvi1r/TGzg49xFY0sd8d+I9ViggJSo1Mm5Y
         PAPD91QegvXMHAkSgorPhNXqYn94Nxb93FNFUfVJn9W33Z8hEHp7w9adfJzG8HQC5O6s
         sRexmALj2OUy1z+R1BHiC0AmMK/dwUTe9CTcjydBa6p0SYu0FIhVw6ZAbi9El5P3GyRJ
         Y9BfCCWLi17kk3imwfT1ECTevIHS4XfN4YYgHvXAbeuaWPOraHhPe1s86OIxr2++KGD1
         Xw9qtI8AkeUgViJQ5/E82NNPBr1CflUZma364cFgnKMzOv+XbMfV/8tIQ5rs/Jf4qlUR
         Xqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791941313; x=1792546113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xF4abej4dYzWW64tGMfNwkdoR9vBgU7tCntIFYf9jb8=;
        b=i8jVXX848U/Fz87MPngoI3ibpCe4pIM0eb1L2MXJce9iDUmXivt5o+fBNNnpivkKaC
         VxQUEUZThX4twZKlvGRMwXKZy1o1Pok1jQcdjKNdRZBYcbkYZgtnw3bOfanPjpsnK0nf
         a/dnBl9eNEo2ToKE8jIfwzHBQqjhwztscO4VM81Gyd2b4TUtug7JFnZicZt5fmxivi7D
         vUYmaI9ecjS61rv5umzkK3eP3S/pR5xyZ722BQhCj7lVX+mF/KGheVC63Z/4Tec60uKU
         2nZQnsvaBTLpFXCpGxZpvr7+PXI93T4JCLKOOJ4z93VF+OJAqRLlvZZ9YVeD/mGoJ1zn
         iNLg==
X-Forwarded-Encrypted: i=1; AKwUvBx5Y7q8OoALEta5Aa0BTnWIJ4p/u+NWhmX5/+QVZiLjKZrvYeAH6Dbt3tbfETj05zr3OVHbSi4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKvF8BBgf+wmVxQ+bsMi4jYsYCkYC8gnNVacsKQssJT8sHqXq/
	3eF+s2l2MWkpacWSvS5GaDy8dNOFAgQNCakloO3YbEIiihxvrQ473Uxg
X-Gm-Gg: AYBFou2NZ0siHnbdkbd3EAdT5liUXl1rbpx41nEcVJQ2WXdqXVYKHywYj3pe8Qr7xKm
	KuG8RMjsY9DlmSahQt5YVpGWkP0NeXZUH6Mj6jZ7YH4KiLv7tlPvYLwcvFIYPaPJ+/R6D8wZlle
	OGjaA07rkpKNb/asr9QxxTZUiHbBK6a7eljVkkXPWNmXjw3jFFer8fbO+yk4Hv0zvsFFCDe17ww
	p3f3ACLdYJe3NKP3MHN6edm2Lyn3rMGCsfRGPwKBLT9xAa+zI9BsM3lC1wDaTRcaQ0hDgRfpssJ
	hMOCJtD3F4DFEgAZM8vLNQIT79l8suKo4CThFoal4hSoEXUHxgvTeivtyYuhUk1rhT1ze/wC7sW
	XgeXURmj5qN4LyBVMuxhwMS547u0lY47nGyAVAbJ4eAMuPkvY2omy9bmcElr93TbJRAsk5lUwU/
	AbAcgTPozPcqUOExsl/v5bYeHbKZIX9oQJMjGwItb9uJsFMR8qcvk1sLejvTorr7kFPkGUhpLgc
	LFv6UF5sf3UMtDWS50cBQlNTtC5CA5mUXkt/thYSJBjFk5ETKLBVnyJ+XAwfH2Chzrj2GdHOwrf
	SSsZVkFQ8J0xRp+C0xxyPKU5bCJoOBM0W/k=
X-Received: by 2002:a17:90a:1601:b0:3ab:884b:65b7 with SMTP id 98e67ed59e1d1-3ab884b6b8cmr5867485a91.25.1791941313156;
        Tue, 13 Oct 2026 18:28:33 -0700 (PDT)
Received: from localhost (ec2-35-77-45-43.ap-northeast-1.compute.amazonaws.com. [35.77.45.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f1fb257sm1953670a91.0.2026.10.13.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 18:28:32 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev (open list:DEVICE DIRECT ACCESS (DAX)),
	linux-cxl@vger.kernel.org (open list:DEVICE DIRECT ACCESS (DAX))
Subject: [PATCH] dax/bus: fix dev_dax->ranges leak on device_add() failure
Date: Wed, 14 Oct 2026 09:28:23 +0800
Message-Id: <20261014012824.31468-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

In __devm_create_dev_dax(), when device_add() fails, the function calls
kill_dev_dax() and put_device() but does not free dev_dax->ranges.
At this point devm_add_action_or_reset() has not been registered yet,
so unregister_dev_dax() (which calls free_dev_dax_ranges()) will never
run.  put_device() triggers dev_dax_release() which frees pgmap and
dev_dax, but not ranges -- leaking the krealloc'd array and also
leaking the regions reserved via __request_region() in
alloc_dev_dax_range().

Add free_dev_dax_ranges() to the device_add() failure path, matching
the cleanup already done in the err_pgmap error path.

Fixes: 9567da0b408a2 ("device-dax: Introduce bus + driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 drivers/dax/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index b809e1a264af..83442430dc01 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1536,6 +1536,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	rc = device_add(dev);
 	if (rc) {
 		kill_dev_dax(dev_dax);
+		free_dev_dax_ranges(dev_dax);
 		put_device(dev);
 		return ERR_PTR(rc);
 	}
-- 
2.34.1

