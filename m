Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119BE36F415
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083547; cv=none; b=ZRmvtdkG2YVps5tjKZNXgUpPP/LHWQWiS12KHaPQl7rOKQFQKSYhTJss/vq2aDIoMTBjLKFFM7SA6/iXHY0UXLHiKMWcb5Ub3SZL5pGmz2zmApUPc6myNBSHMRAsS4uHoJZzqAyjxIEIKr/3WM1LmsmFpjPE4wn79csMf//cZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083547; c=relaxed/simple;
	bh=oRazmrbbw/E9EbKfPye/XDabSaDGq6niu0baIpJ5qJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6AkMv1Wa/1s7D3dXv1Vc1JuvzZzca3d7CqfbJFqZLcGhivMUoAvc3f98wAxX82TIvWqgNpwcvvgawSD03+m+LdLeDmFjDRe4pAm7tFMO4HmFfK0kGlFXUHHeT4B0MyjwK0Q+NVmRpHyny+UuZVoRJ+EYZBo+IgF8TN4agOqL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD8VwKIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD8VwKIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7F81F000E9;
	Wed, 15 Jul 2026 02:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083545;
	bh=pHxOhuWSIYgU/PTQEkUJ8/NB3l3o53g7PaCD1JWmio8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JD8VwKIUsyIkMOaeFl9C3bNG3l+GXMg1bbvdd2Oeyqw4l3Lys4RdU+UDO4uCOwKgC
	 9lAEfIeohJJcRZTBkaRHEhBxORI0jqsXoHxXCAK4pTqRiGTfAm4AiMOlSpOlZPynlb
	 pyqH0aXz0U0Va0A5MhTH5yuNTv918ivGi2qrwyKwTo95Vw3cAhGXjSBCf2Akn+HZew
	 hUYR5yVfa715r4OYISVeaL9ij9KoXQnXI8HXvIoGQucqgWvqnbynMr03Ca6/oOMRQH
	 50G4nXQuuZ5jUqik19l1UqyutWZqZJnwIaTuvcbGf2vWsLDXuS8ExVyjoEGYdkhXRl
	 dqMyTn97eiyVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 01/10] staging: rtl8723bs: remove DBG_871X log argument
Date: Tue, 14 Jul 2026 22:45:34 -0400
Message-ID: <20260715024543.105642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071316-urchin-unenvied-752f@gregkh>
References: <2026071316-urchin-unenvied-752f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 42c3243ff23d119331a8ace011e0c18b222a1138 ]

This patch prepares the application of the semantic
patch aimed to remove all DBG_871X logs.

One occurrence of the DBG_871X macro has one
repeated argument, that's not even comma separated
value with the previous one nor a format string
parameter associated.

In normal conditions this worked, for the macro
is usually not expanded (the do nothing behaviour),
but if I try to apply the sempantic patch to remove
all macro occurrences, all macros call after that
abnormal declaration are left untouched (not removed).

Remove all of the DBG_871X logs as they currently
do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged, so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/3473925ae9ee5a3bcd0ab86613dbce80b6d3f33f.1617802415.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ed51de4a86e1 ("staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 6979f8dbccb849..2a60c8bb61f95f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -923,7 +923,7 @@ sint ap2sta_data_frame(
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s BSSID ="MAC_FMT", mybssid ="MAC_FMT"\n",
 				__func__, MAC_ARG(pattrib->bssid), MAC_ARG(mybssid));
-			DBG_871X("this adapter = %d, buddy adapter = %d\n", adapter->adapter_type, adapter->pbuddystruct adapter->adapter_type);
+			DBG_871X("this adapter = %d, buddy adapter = %d\n", adapter->adapter_type, adapter->pbuddystruct);
 			#endif
 
 			if (!bmcast) {
-- 
2.53.0

