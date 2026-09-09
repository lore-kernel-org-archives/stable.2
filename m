Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866993AFB14
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980845; cv=none; b=oX7tZwEEy2ixIhAOp4VPIQxCUzcYRxUyYyjWk4wv4h8dnUn0r+Mswd3EPksVzZBGqN35DCjgzFDGgVjdS5B43uvQI5QD2hVuhKpZgP18XokTk1cD8h6UkCe+NooD6aqakQiF0oZuUyswHNNY6/yHQnCMrN0tKAg1MqqPb+wxHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980845; c=relaxed/simple;
	bh=XisymPQQ0hWiFojijkfMJCD3gsi/NfVsTfHC8AglBuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2e4BBubgNEtMtdJDPyUxBU1CEfUtYTfJXOKbyvz4PNPbyBKGFHljJYyfUucLVHr1Tbx5hpJ6TWwvKKdwUzJeD6UWtviQH8lh9ba70B+Y6jFEj2QEZzvmiHIAhRH2EBBZc00tqBih7J0CyZfo0aR3LwMZwXnGpxnAGtV/z6h/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jATJINUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jATJINUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6BA1F000FF;
	Wed,  9 Sep 2026 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980844;
	bh=7qprohvjyjbiw3fbiSYw/jPmA/ZQXYuf2+NrFJ9M0is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jATJINUvs1/PI+lmS50C5Y9MZmOhgr9wRADmZFTdK8OFdTPZfMJEp0Xegq9gc1JDu
	 kUr0My32J5XCSwsS3p9+cz0TZ4jaEJig4ENAIuHXuL40CLG05/TQqoEANw9hms5Mc2
	 vL9TSEd3s5M39q5DSH7ZlDbERMjFsaLFfgU43jL74ihWt6lLdjHPWLBqDcE++cqIFo
	 VMUlUiMUl9hb3FDeVpsl6+pK84QV293aIQDNO7qXxcXWseSoZ+USDUxcRrNV8sXcn/
	 o9PA9wnhhPRLWV4TbsPQPilT/UQHHZwCb2d7ZYcHzG4ph+TS0ryCmvyiCV+xTFHBhT
	 fdEubj0doyuNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] PCI/AER: Simplify add_error_device()
Date: Wed,  9 Sep 2026 15:07:17 -0400
Message-ID: <20260909190718.3536304-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190718.3536304-1-sashal@kernel.org>
References: <2026090327-unfair-disagree-3067@gregkh>
 <20260909190718.3536304-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit d72bae423004aa7b4d94c34a7fd0b48b64305a08 ]

Return -ENOSPC error early so the usual path through add_error_device() is
the straightline code.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://patch.msgid.link/20250522232339.1525671-18-helgaas@kernel.org
Stable-dep-of: a8bf2dd750de ("PCI/AER: Emit TLP Log only for unmasked errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index fbaccdac99646..d76f4049e939b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -813,12 +813,15 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
  */
 static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
-	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
-		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
-		e_info->error_dev_num++;
-		return 0;
-	}
-	return -ENOSPC;
+	int i = e_info->error_dev_num;
+
+	if (i >= AER_MAX_MULTI_ERR_DEVICES)
+		return -ENOSPC;
+
+	e_info->dev[i] = pci_dev_get(dev);
+	e_info->error_dev_num++;
+
+	return 0;
 }
 
 /**
-- 
2.53.0

