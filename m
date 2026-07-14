Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BF294A10
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072050; cv=none; b=CX7RRYxBYXJYBq9ivIZ/AuorXOCGvLGrCxB+c1+GRFF/wi7PUNwvotamJMe2PCsaK4vQYef6CHmIjc50ntxWHz9IjrqfNVn1HUaJ4+G1mYxBMAh5FuqUw+tghF0bH2kPB5+A+t3wtiefeFrAWstPXL4RKBOV/CU7qGQ6TcnIHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072050; c=relaxed/simple;
	bh=WkXk/jyhxD6VsRE7gkA14xDbAXbBgM3SNNHRBbdNqfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=df8OVwksbN3++GS7VNP1nLVz9Dsf0roj12n9QoCkpQYXEz5tWKMS5ZB8WsQm2c/TFrfMvPvGSF+ZXDyTToOBzv7Zd34Q2tiC1eS5m/2LHBkdEi9IMKdKH/g6xITJyMMk6bM6fcjm59p8JamJGMYeUIz8QNP05GTROXrknaE0qxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0XLkRsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0XLkRsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20331F000E9;
	Tue, 14 Jul 2026 23:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072049;
	bh=8CZH2ZFDZP7P5RRhdJEIT0T8Zw7nEQDxh6Vkkz9yJw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S0XLkRsIyntjdQ6IC/s2Cn4ZNmP9Nx4JGhX6OtqgkBqmsa/yXkpy+Ugw5GfJyZa3e
	 Hmtj95TbhpIbZM9PEoP6mRxuXcdxI0/ThhsEut+i/90u9/gjTnG6xcWVvVFV1SrEl+
	 kiAinhcA6Mv3wGa/IM+5nMBKRxN+xB8t21LIESKjmhm1l9XiMYmY/cQw6r2f+syE52
	 z7jlnAbiRP0gMgHumFnA4aRjntnbloDMgZx51pDbBVYu6RFQO88ojGnwQtdNtQrIQF
	 b5t8bVk6+zolO2ESlBRgxM4nDnHUXWOmvS8D2m/iTFzdfqG7f54fwd/sh/HGONxZyF
	 gc1ReLJdCn6yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/8] staging: rtl8723bs: split too long line
Date: Tue, 14 Jul 2026 19:34:00 -0400
Message-ID: <20260714233407.3591885-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071352-wreckage-humorless-3481@gregkh>
References: <2026071352-wreckage-humorless-3481@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 98dc120895a9a669e35155ee03b98452723aba95 ]

fix the following post-commit hook checkpatch issue.

WARNING: line length of 103 exceeds 100 columns
30: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:711:
+
receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/4e87fb741205b9f314aec739921405a7ebef908a.1618480688.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a1fc19d61f66 ("staging: rtl8723bs: fix WEP length underflow and OOB read in OnAuth()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 1144749b4f585d..183c4c2f553101 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -835,7 +835,8 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
 						DBG_871X_LEVEL(_drv_always_, "ap has changed, disconnect now\n ");
-						receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);
+						receive_disconnect(padapter,
+								   pmlmeinfo->network.MacAddress, 0);
 						return _SUCCESS;
 				}
 				/* update WMM, ERP in the beacon */
-- 
2.53.0

