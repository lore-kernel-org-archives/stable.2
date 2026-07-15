Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5D1A267
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083570; cv=none; b=KU5NLNZlpOzMeBnY3+h7nXlVDXFORWTTUby0L8AqanGv7kayRUSf19huk+8Dth99sIWoljXI03J3DQGZKcGT459b14QKK77foHUyMPJLeO8IhG7DRoFAaXkMkEer50wMB9iYZ8Xrri5vcajrR6xXNqeAnVV/qxF16S1BIxE022I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083570; c=relaxed/simple;
	bh=wGmVlRodR3bzG5R5oY5dOaTpz1P/LnRmX547kzSMuYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kru2CVtyA9hyY4WOtdQfk+Ctjzs++ad55NjxKZYm6b66veCAmOW/Hx12vVoL1EEr5iATgfagj4zJb1x9xUEk694+3TbNsW90NpP9pjmSuStgxbXUoFDURy2gSyfHN+otSap18THSYFiCgYYnAVMyapfyz6J8cPtAB/pH+vrC/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OY/jL8Qa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY/jL8Qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D58A1F000E9;
	Wed, 15 Jul 2026 02:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083569;
	bh=ue5NeZJbYsq1/wEirxHVeVRaaYUZLbTM4iH2afAVR9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OY/jL8QaQHqTp7iniEBNuqwbZSRLyHVxeZZXCtMxsw4arLelpbGL5PvgJrD/P6G86
	 CS3KLG+gz6jMy7PSimqa0wSqoy7bZ9U499h81hxiJ2+bR6kL/LOlIhtZjPEZ+pivUT
	 3jVvT6T3QBbtrtK8MMHO6OWSco75S8niTq0rAvhB9We+Aq8ByfWhtqEPTTktfFyNND
	 QoWp10gDG6Ez2v/ED3HpVwWI+s9fnHt7YDryshF4LK1KAkVMgR3zqOOkDkwGvdrlf4
	 iZwnFoW9OBNBrpkl5Eb0jIG7MPYS42wWSLV/QXDsERxKV6ET0WF5kVrbrDPEeS7R/y
	 FCV+H+0p2vL2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 01/10] staging: rtl8723bs: remove DBG_871X log argument
Date: Tue, 14 Jul 2026 22:45:57 -0400
Message-ID: <20260715024606.107096-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071347-leotard-finlike-cc76@gregkh>
References: <2026071347-leotard-finlike-cc76@gregkh>
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
Stable-dep-of: 3bf39f711ff2 ("staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop")
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

