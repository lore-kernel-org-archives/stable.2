Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666758;
	b=JwzzXG4xXOVYiQAe3r57fCKmWIyGwi9jAORIi5AtrpFbNHnaZsNr7ohBl6PNB8UxYqT6
	 rkC6rOQ8QHaTXFhueCFFjr00Qfp5WzPfvjKiwdj+NJ7tDihiWF4gnoNyJVuDhGcXcR1Yd
	 kKSlT3Xq1GqzGmsS/mpKN//EXFKv9kdwhkfihUn26V32aE8fUR4g/sWMfensfNLB4JAz6
	 XbQJRd+WVGFvig1Hxf+r95hObErpMrVVCruex1LW/0sR1v/rbPJGOxyzih41tiIqD/JFy
	 Yu6PwOoNGpi+FPCEZn1xg/nLCsuHxEnTOXeZr/oJuotkdCOC5HDUiazh2t7TB5FiCtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666758;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=YDT8UeFw9iQHxfzqDnKut+Nntr+niJNA5KvxwcaOwi0=;
	b=ljpGzzKRC7p3ueFWAL4XFUzkLxIg/wk/eIDALSUXgRKrgv4J6m3MCyNJBUasZeDxZn0o
	 zmb3MO0gwKAqw6rixGtBOs1T3K1emrxWOYHTjXgSOB8zYBHkLmRgIFgzcdMJeSuNAjqBP
	 9emUE4KAd+w4djR9vP2yGS1HfnLw2Q3U3qO/3FH9tQtoBaCOGFuqDqtURW98xlAs9Xefn
	 kF/P+7rW8lmacCs5kfTS93iYhb3FDmSarJohA3n8NWWLevEBI6FoqV0bOPaKViX0RQ7iX
	 zziWzlWlkheI8Z2OMOuxaCULVVgjYsLKnP3F0FS6Ek/tpdL5H7Bxer64TRMj2qhq5Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=hXbhxu8y;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AFE606A332;
	Tue,  3 Nov 2026 00:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26AFE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=hXbhxu8y
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 533e14b16;
	Tue, 3 Nov 2026 08:45:53 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	Thierry Reding <treding@nvidia.com>,
	Scott Branden <scott.branden@broadcom.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] mailbox: bcm: Unregister controllers before destroying DMA pools
Date: Tue,  3 Nov 2026 08:45:50 +0800
Message-ID: <20261103-cmc-mailbox-bcm-0-a4f6f65a1e@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa19edea36c03a1kunm5eb36721118233
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGE5LVkNMHk9JQx0eGktMTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=hXbhxu8yKGO08y55zW0KHpXH5RFeCRLO1fzFnb/XmMF1aFP0uMVJdwZOwXcjfLLEdE7k14QRwll7svMqROK9qTQLgsblhRmRmvwEysfQSjOFFcdzLc+KP03BHbCe579VEMgakpKCUOqjFuuUTxmQ8Hp2WKuRwoeiKVlZGMu8hVE=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=YDT8UeFw9iQHxfzqDnKut+Nntr+niJNA5KvxwcaOwi0=;
	h=date:mime-version:subject:message-id:from;

Explicitly unregister the Broadcom FlexRM and PDC mailbox controllers
before destroying their DMA pools, so channel shutdown can still
release its ring allocations.

Prepared with AI assistance and reviewed by the submitter. The affected
objects were build-tested with W=1; configuration details are included
with each patch. No hardware or fault-injection tests were performed.

Guangshuo Li (2):
  mailbox: bcm-flexrm: Fix potential use-after-free during removal
  mailbox: bcm-pdc: Fix potential use-after-free during removal

 drivers/mailbox/bcm-flexrm-mailbox.c | 4 +++-
 drivers/mailbox/bcm-pdc-mailbox.c    | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

