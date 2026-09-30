Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D74E51D52B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792926; cv=none; b=S4k2SDVE7pQ0GtkJN47IXNIMps5XzB/HiYsqIFIDfRqT0Jd0lP8/Y486OVCoNNgqGI5B9/SBw9nCsmPJ8WA0JzLUq6WFHH+QUsJLx5AvMFg+yqePiPKhqS+HYQwtVZ37Ufs/36E5+nFN/uV4/ZqS6L486Zapc8iyHeBPbgcHreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792926; c=relaxed/simple;
	bh=YpVF+hPSFSXOxnPhv7pLbwpKw4zyV47UpAD2KYKFC7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDt026R0eoaNG5c9DMjIC7GVS7mnB4sA9zWvbjuq98zHsdf+64Sw0+ynpMtcZRtdciXpgOCkOjcGbcXo+axPS8PetLBKFO22ez20Xm58FlapFA/dX/lMGrMXhb9dKFdUbQppvzL2Rcum07TBEeNnQT0MOhI9DTtEANp0PWMC21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmUoWDLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmUoWDLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D61F000FF;
	Wed, 30 Sep 2026 18:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790792925;
	bh=fj6apiYsoiY2Ylgfmq0mykEbiz3NEdpSUF2NV9UfWGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmUoWDLXysbe5VfAzBWc68CiPtuIOCxYqO+4AlFQ4pVH38fWPzxThhT9NbtyJJvxg
	 mREKvqcfsVWd8jYEM7txIMxhErN/0I7iKfqq5YS3uUAWTOQeumJGAkvxO6nGbnFdEQ
	 ghHS/y2DRYgrNCOYSXYg2fZTtWWRz45hW08Vlu7Us418oMtOsYu2Hsf0tnrbCNB7IJ
	 hf4Xn4iLqjkkExbQZGPrpV19icBbae7E1VfhcxwExmURnb4+cFrPDOruoX/8LR+4cI
	 PN46F4qlb/13Mf07eZeUcKfjlYioh4n/eLE+pcBvFNKihf2ND107eaW+orWgCwZ8Bg
	 XmlZunoztmZ1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] Bluetooth: mgmt: fix race in read_unconf_index_list()
Date: Wed, 30 Sep 2026 14:28:41 -0400
Message-ID: <20260930182841.34239-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930182841.34239-1-sashal@kernel.org>
References: <2026092958-cathouse-visiting-7f57@gregkh>
 <20260930182841.34239-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

[ Upstream commit b5dbb41b212c50c095a4dbee3017a84fe94f033b ]

read_unconf_index_list() counts unconfigured controllers before allocating
its response, then checks the device flags again while filling it.

hci_dev_list_lock stabilizes list membership, but it does not serialize the
per-device flags. During asynchronous controller setup, the worker can set
HCI_UNCONFIGURED and clear HCI_SETUP between the two passes. A controller
omitted from the allocation count can then become eligible for the fill
pass, causing an out-of-bounds write to rp->index[].

Allocate space for every device on hci_dev_list. Since list membership
cannot change while hci_dev_list_lock is held, the response remains large
enough regardless of flag transitions. The reported count and response
length still include only eligible unconfigured controllers.

Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Replaced unavailable list_count_nodes() with a list_for_each_entry() loop that increments count unconditionally. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8a1fc2d252800..76d7dd7772255 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -459,12 +459,10 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	read_lock(&hci_dev_list_lock);
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
-			count++;
-	}
+	list_for_each_entry(d, &hci_dev_list, list)
+		count++;
 
-	rp_len = sizeof(*rp) + (2 * count);
+	rp_len = sizeof(*rp) + (sizeof(__le16) * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
 		read_unlock(&hci_dev_list_lock);
-- 
2.53.0

