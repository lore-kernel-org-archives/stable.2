Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D33A3E72
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770132; cv=none; b=IuubDjYkTvCAx+VlVzOr0/wpR+DANqnT1gYq8arSEb3COlLw/X1Av5eaTzi8vBXGpdQ5F6A9Qg+ELj8RkwiqKpJZDQdej2drhQ68mYXdKeY9j9HoG8ZHO93HagfwCyMLDFPBMfU1p3YPfd2EoJ3Cz/qTARP0sH8nkaboLQEPsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770132; c=relaxed/simple;
	bh=JMyHDX7+Cb3dhNLf82u2UybGGP4n+GPN92/Q79+iw1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpDp76TO/OXqFHV5u5DSn5fopYC0rJQZYpRVFwTn8fSmelgth+svXyr70spCzGw00dH3i/rmQybW0LvPhWXDeNfg8/9pbGZk+8fY6tpt1sz9wKZU/Yo4TBX5xKOp9LyEKUSN2ZkkCKZo7yTQnnBM3Qr21dyxibMU/LlKRiGVx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uzxw55E0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uzxw55E0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F741F00AC4;
	Wed, 26 Aug 2026 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787770119;
	bh=OWdRUiU2P540RjclW+7b9oB00lthEKs8N/bsFraQOrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uzxw55E0q319epyZH5TPzrxT2Bx1Pv7AsSpHa+IftvAEqS0lr9E/7ejxuCJ6qSFOp
	 3e6bEQ6WZuBFQDOnp4Vix3mLldMiqZybHU5RLSwTxuIT2eZVfr7KyvdJAM6ZeOzrSc
	 bf13oy2q1a5APm+v3RSEI39kTYpHkbqNGlOL8FgmPD22v84L7330RrZp3zRlM+uU01
	 8lrbQ1RYLQJD6OKfZtT2MBm5J9fOHifyEGOaWCAK8HFwoIdsIjYxCkCKIdx3k1XSop
	 wGF5A6FfgtOOHZZlL5HKAxtPobYzI0fiW+FPXzRtKFzdpfaRZFCFDG4k7zVkkjOf+A
	 MXTRmns/eRDyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] Bluetooth: hci_event: validate LE Set CIG Parameters response
Date: Wed, 26 Aug 2026 14:48:33 -0400
Message-ID: <20260826184834.3559828-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826184834.3559828-1-sashal@kernel.org>
References: <2026082559-suspect-staff-6aaa@gregkh>
 <20260826184834.3559828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

[ Upstream commit 0acd4eeb4b225b9bebbf9ef96cc10cdd79b94899 ]

The Command Complete dispatch validates only the fixed part of the LE Set
CIG Parameters response. After that part is pulled from the skb,
hci_cc_le_set_cig_params() trusts num_handles and reads each entry in the
trailing handle array.

Matching num_handles against the command's num_cis does not guarantee
that the response contains the advertised handles. A truncated response
from a malfunctioning controller can therefore make the handler read
beyond the skb data.

Validate that the remaining skb data contains all advertised handles.
Include this in the existing response validation so malformed responses
also follow the established CIG failure handling.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 41cfd0201d3c2..971997dbdf413 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3791,8 +3791,10 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
-	if (!rp->status && (!cp || rp->num_handles != cp->num_cis ||
-			    rp->cig_id != cp->cig_id)) {
+	if (!rp->status &&
+	    (!cp || rp->num_handles != cp->num_cis ||
+	     rp->cig_id != cp->cig_id ||
+	     skb->len < array_size(rp->num_handles, sizeof(*rp->handle)))) {
 		bt_dev_err(hdev, "unexpected Set CIG Parameters response data");
 		status = HCI_ERROR_UNSPECIFIED;
 	}
-- 
2.53.0

