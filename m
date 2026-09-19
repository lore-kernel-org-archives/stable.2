Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B102D97B7
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789840846; cv=none; b=XDBFP9DV5sP+Hqb4DOWSRNyWFfAERmZS9QCjkAp2V/a3kpkhfAqbieE19433Y1tf1wXQzEuZE06fFTo735b7QqbW1pPz9VD4MWDlyhbghetYt7smCcfKWd+DX+1uID7WDUZcZ2IpgKBghFZTjM0sRhSYXkTt93gA2ZvToAvePnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789840846; c=relaxed/simple;
	bh=7ETlv9nXNwoOvbtzjNafBK4cLqGS/nbn+0/DV8rHnSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tv/OjxcyvbNZQxNwJGbqjWFCDzJhOv9XxtYInGFyWzuj0942TstnAksDMSpwM0kdTgyog/4c+MOBMMUVE5zmgAciT075Fs7/UZm+mdrAjbB9ib9wjD29ppvzL396sLwKoOdB/MXY2Ugj/fPmiQDGoJpHOLttDHwNDpn4YlwEX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjAmNPHx; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjAmNPHx"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so753439a91.0
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789840844; x=1790445644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EN9dPGZ08VWGRJ+d5ue8KldWWOVO1gk1WNNgQHngEUE=;
        b=BjAmNPHxsSPpScTqJRlzw2QmL3aeD5TJxouG8FC6dJ0ULjWWwXFjHJ02CzkE5BooFK
         ihtgzlcRcrqap6n6noIJTgDFHIUX52+S1DZDqZ5M+u5fINmeec/zGNjYXJ+Sw+YaH5bF
         1ezPiZL1tdX4ZPnCnYPNzWd5wflCWcXVs1zb4fXaI4k2duxUyO+o6+O+C6VZzRv0VNnH
         gdwSP1xaa2jMiH3UiYqlWmYA3LCvmSLcbBdgy4YHqN7BCy5ccocABzaCKmbydz3HhFFU
         lKtMP4LkO0DIbcIZOhjMiDhi4huMzeIEohOU0VfIKri7PCdLFWs75OCShXOCI0UCOXwR
         GOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789840844; x=1790445644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EN9dPGZ08VWGRJ+d5ue8KldWWOVO1gk1WNNgQHngEUE=;
        b=fSB7oiZYCR6BVzq3ksAa22T+PZJKxH3WG9Mw7DBpEkrWzPN0nSlRLv+4zz/UfAMseI
         qS2BGP4OYOh1xluVOQ8yMOAIBLdFgEyMMhr0irS4BzC6poEuYjGkmSEZk1HB/p5U3VIg
         zLRfxkXL6+RzpV5h5icrBVLNSdDgfFIXKaczLstqWBvtjemByqZw4+zXCQg4jiP3Yyns
         ZSlcCnzjBF4tGr2wAuX0cXyZvQg0NYp0TCRmXszQCzEpHPfXiLXAQiqiOV4Zd/rJ+8UR
         mmqGk73c2XMEgPSsf/WvhwBsiaNj1hB3YXKDzxdwn18T9SedCnZvwuypg8nSEMTv/5cd
         /tyg==
X-Gm-Message-State: AFuF++nVUzjK4A4IwOl9gcNlHHrHQH44RO1milwPbQ4IWeVJQFA/Pg0a
	lbSEp/1TUeStFzjy/Euij8HYZUTB0UTcnOvYgWPuRQjgVVSuVOs0vNxx
X-Gm-Gg: AYBFou06RF6BXV1LTlI00qfh/BrywjT0DxbNBJ2zo+EAC1QCVUuOnsSex9+IV40cRyy
	D4pRn/VZwf6TLoCjlTky/tUEWniB+HuyqV834BOLzg9Sqoq5ukxaQturSgv1DSrWoS2Xju8osIU
	N0vZP0WSVwrG1a7hybFav2gpDtsiI0yd+DPvO+BPh4CFodEpaHWIMw0YXAJP/0WUxmTWXZKd/BU
	/V/wd48xOp+kBTWOIehc27V5CLxLxjb12CFTBNR10bd5s9wyB7kecvSVyJW2iaJINa52QvgaCro
	tQgxq1cHhSTFfG8FvjjchTdgzXszWPs9Kqr+ukWsHL6AP2X+AcnyseoFAVr+JHs7sLTThV53cEF
	QIosjgbNdtZZrsmn8z0/h5wbgEFbBgd4A4H7ial0ldyj5WgsT2yhBa7CoG91X/njMrjgSvEQkYv
	ebdKU/ivmL11+YnBy5S2o7CqeZA3sJ3PUmt26xuudVhGayByORBMFglg==
X-Received: by 2002:a17:90b:4f4c:b0:39e:6a7f:6189 with SMTP id 98e67ed59e1d1-39e6a7f6410mr3449281a91.26.1789840844085;
        Sat, 19 Sep 2026 11:00:44 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb0190bsm5453190a91.13.2026.09.19.11.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 11:00:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] dca: fix provider device memory leak on domain allocation failure
Date: Sun, 20 Sep 2026 01:59:24 +0800
Message-ID: <20260919175925.3739806-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_dca_provider() calls dca_sysfs_add_provider() before looking up
or allocating the DCA domain. A successful dca_sysfs_add_provider()
allocates an IDR entry and creates the dca%d class device.

If no domain exists and dca_allocate_domain() fails, the function
returns -ENODEV without calling dca_sysfs_remove_provider(). The class
device therefore remains registered and the IDR entry remains
allocated. The caller may subsequently free the dca_provider, leaving
the IDR entry pointing to freed memory.

Since the class device is never unregistered, its device reference is
not dropped and device_create_release() is never reached, leaking the
struct device allocation.

Call dca_sysfs_remove_provider() before returning when domain allocation
fails. This unregisters the class device and removes the corresponding
IDR entry.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 1a5aeeecd550 ("dca: registering requesters in multiple dca domains")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dca/dca-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dca/dca-core.c b/drivers/dca/dca-core.c
index 583510850fad..57e41fa87cca 100644
--- a/drivers/dca/dca-core.c
+++ b/drivers/dca/dca-core.c
@@ -368,8 +368,11 @@ int register_dca_provider(struct dca_provider *dca, struct device *dev)
 		raw_spin_unlock_irqrestore(&dca_lock, flags);
 		rc = dca_pci_rc_from_dev(dev);
 		newdomain = dca_allocate_domain(rc);
-		if (!newdomain)
+		if (!newdomain) {
+			dca_sysfs_remove_provider(dca);
 			return -ENODEV;
+		}
+
 		raw_spin_lock_irqsave(&dca_lock, flags);
 		/* Recheck, we might have raced after dropping the lock */
 		domain = dca_get_domain(dev);
-- 
2.43.0

