Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1133C13EE
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244046; cv=none; b=lmj2ZHoXC4BjLE854Qcodw2SYdNZd/hcc5WmwAiJj6dSYXHdOKltuB7wc+uYeSSW0bbUuVIRA2LoVj9rvd/da/FSnlgbXWP4QjiSBU1Mw3cTuXqe53dHISLc0O4S+K2mclkxoBd5NqGq7diBbbmQSoEn40LpT6pSoFHRZqR8FCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244046; c=relaxed/simple;
	bh=nwaYkLbsXfKCJjGkeRjXJQ6s3GI3fNcy0etbBPov7F4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+y2xTqz4SnD/K7SuyBEzpB6nz7JtLDIPx4FDdjTbQVtks6fo1kmx6X+6eCk+qzVJxDctExB/3WJ+idj9fHlePl7wY2uZaolhWtt9dTI2iBKN4OZFvVmAnUnC7RDThaatrmPebV+FmdveFDIrmvJcQY0O4Ss9tP66h+JDU9sDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnV06heG; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnV06heG"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b20so285511766b.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 03:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790244029; x=1790848829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U6oEIghWvcJ4GRb1a00MSWjde3NQ7RviSDO9ePyO6Z0=;
        b=nnV06heG/ot2k7wc4CyHxJ9gviveiXqs9gQ/UUcL4UdxKHteC2ZMTmLuCeyW+M1Vkw
         5S+uVnCykbcKSUB+z26n6+gyh6w/cbnAYcAS+Qu1Tj0IHIlMZfzBbsGP/KZbim97QLBR
         ts7kxzl1hOJF8fqOP3q8mTpJ76qhIUUPWir754aSU5q22a/ozyAtFWhbiU0SDnhc44I3
         NMVqcJjQH59KKVGiKKf0IhAm4eu1HSk774hnvWKhE0S2mSAUxprBiypADVZ661BpD6xb
         UKyqH8tXRmpFh29iailXQbcUExrCpNxe83iXyN7gitmHtIRXUfw98gnx+dBYo3XkiCVP
         FoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244029; x=1790848829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U6oEIghWvcJ4GRb1a00MSWjde3NQ7RviSDO9ePyO6Z0=;
        b=D5Ox4DM71P74ix4Ga+vU3oZedEaOg6weo7Qkvu+ZNKzPTsK9st9UscA2lqhV1GzSQL
         cO10W9TktGUvctDd0s+RGt8wO43EaVWyBQk8FdbDz79Cka43tA424G2HpvCgGnHi22Yz
         84wbTP1o5JkGq6YWDgpc9IWKjM8EmpXMbN3uzJjF7jnmw4viZjmY17qNkdK09+rssne6
         jxk86IwTO+MkcumeWeEUZ+UrqlQAG68MYP6j8gB9BcDhiUbJ+QGaeok1ZqMwpu1U1fz/
         TTEUz/PW+Di51HFfIrwDO+3V4R20tF7bZvxOOeQ91PnjmM5vdyF4nO5xjr8BiE+eU8Ff
         Heqw==
X-Forwarded-Encrypted: i=1; AKwUvBzcTduWgvS4SoUhwYbJjo6BWy96AqelsFjzQe9K4UG6C9OG9/NDz5pCtkTKU3XsQzxBKkCQDr0=@vger.kernel.org
X-Gm-Message-State: AFuF++l4Mc8+agYu0ThNIAjlLQCp1WzHAgsdROuT54PKosSdpqy6qDhP
	1B+QOlBqnIM6/MP4G0O/xmzfIvJgC1psYf4xWlxPAoP631I1P2x7CZ5E
X-Gm-Gg: AYBFou3bDRm0RsTucaUBKAv9yw0lAcI+LV9wCCF95kHeY26FovltcCigTUoD05OPfEJ
	B9ile+8OHnZ4doCdx+Z+9A47iSBBr84oDw9bULlgKvBh3EMPhIMy9bPRe6BXpPrVeWkdS17Euov
	Ij2f44H79GpBx+CtAdvkSw6/U1NkIY4qJvMnIrv/Xtz2cchz7bQAjO17ppdk0TRByIY8G3PXQUE
	jblXeqjYzI6UsTyq+47SolY5lnutGxV5h+cUZp+G2YpSffydNhcrBQbMmfg3lFczd1DWg7QPGbq
	KGAJAXREOg5sews2Jv/pG2sz9umRFf+x60bkM1PTqb5G6RF25oXLRVRa3L2VP9xfGWeSgPNpHWA
	uyDfumtrMGNQNwvR5EvYlJRNZ9WfH7oSp5+YXtv7Rqg0kJq5ItvfGsacI/XhpGtygQwekmZDCDb
	YURMwWOIoWAZkLPb2YpSQhHCwN5wTag+9zY+XR0xEzb1gRDutudxAMph6qr53O5+ANejZ9Ni0/6
	GH0kTk/GU9z2R5M
X-Received: by 2002:a17:907:9407:b0:c29:f0ec:1c15 with SMTP id a640c23a62f3a-c2ac20ab89cmr165652766b.6.1790244029398;
        Thu, 24 Sep 2026 03:00:29 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6682d3sm260123766b.40.2026.09.24.03.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:00:28 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
	syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v4] net: e1000: fix warning in iounmap on probe failure
Date: Thu, 24 Sep 2026 12:59:55 +0300
Message-ID: <20260924095955.3471-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When e1000_probe() fails, the shared error handling ladder attempts to
iounmap() the hw->ce4100_gbe_mdio_base_virt pointer. If the hardware is
not a CE4100, this pointer remains uninitialized (NULL). On architectures
like x86, passing a NULL pointer to iounmap() triggers a WARN_ON_ONCE,
which is fatal under panic_on_warn.

Fix this by conditionally unmapping the CE4100 MDIO base only if the
mac_type is e1000_ce4100, matching the exact logic used in e1000_remove().
The hw->hw_addr iounmap() remains unconditional since it is guaranteed to
be valid for all error paths reaching the err_sw_init label.

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b
Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY registers")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v4:
  - Actually include the code changes (v3 was sent un-staged by mistake)
v3:
  - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100
  - Removed redundant check for hw->hw_addr since it cannot be NULL here
  - Added missing Cc: stable tag and Closes tag
v2:
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags
  - Added Reviewed-by tag from Aleksandr Loktionov

 drivers/net/ethernet/intel/e1000/e1000_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..d7e279b739b8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,7 +1227,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
-- 
2.47.3

