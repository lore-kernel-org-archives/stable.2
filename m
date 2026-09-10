Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2146EC6A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038554; cv=none; b=ZL0rLExjhbVs76nS2wmoYjFGMOgYDUKwR/JgPYS3+e4VMPWNDFXgEuMDjZG6LP8ZzA/IiS7eAgcO7tgDgsGp1eO7LMiqsC2sBjnAMW4TCvNR6AfXeCxwbbP+uWzC5eYA7ArtMNMe45EHEAodDstrtQRT0zEBq407szslGghAhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038554; c=relaxed/simple;
	bh=5ZkI4QqHLSIzSUSgM7rwcOdaKndWmUNtuw1o37GzmUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoKvJAINb0WktaZi5Ah5O6aosgdsJA7Vwi7v5ABkeHT5YptQUMcUw8MQfhPu9auaP8EhuOW0q6u0bnD69xHChHHWf9vY2hufddQqQzkjgsCAdoF3yPcQUoRNPsIVO3yKnXrVVEJVX54shTIk7iO7Jqp8dq4fDR9/7bVRbIXjdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6qrbT20; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6qrbT20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BC61F000FF;
	Thu, 10 Sep 2026 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038552;
	bh=IU53xj0MrznI2MLF3vptI28KQFNhpqUOiss6GElMqas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6qrbT20oqvvV0uHEak3RYTed2jKGQ9EdKLIU6cHq5NuiUyuyLavX8AROmyUxC0QL
	 Ql1ud8NkwSENm1GVtba68buJp+x2SNtf08GEZuB+VftSHWe4x2+Gql8GlB9s5kTJzr
	 AVXxqMZvCDpG+mOAAN1+B2Wm+20HxdHk/u0uKtuMSb2VZlWSrVg3xEbrggXqpF5fBE
	 9ib2JSkkVfqapBPLBcjmWCsayucX8dRlDqyQ6sEGGQBlEA0MTRx0IOLEsmWfAjuuJz
	 aP6icx2M6ha5HajMG3K83Wx6m27GuLRrvwRohBGsKGCC4cycx/73SSrwkCLzntpXWB
	 gyDYSIns/bYQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vivek BalachandharTN <vivek.balachandhar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] staging: rtl8723bs: fix spacing around operators
Date: Thu, 10 Sep 2026 07:09:09 -0400
Message-ID: <20260910110910.4148201-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090820-skid-bronchial-d83e@gregkh>
References: <2026090820-skid-bronchial-d83e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>

[ Upstream commit 2038fe84b8bdf894b634f777096685e78e8f3774 ]

Fix several instances where operators lacked spaces around them.
This improves readability and brings the driver closer to kernel
coding-style guidelines. No functional change.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Link: https://patch.msgid.link/20251205021417.2705864-3-vivek.balachandhar@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

For this stable dependency, retain only the spacing change to the IE
advance in rtw_restruct_wmm_ie(). This supplies the exact context needed
by target commit 28a289beaf226 ("staging: rtl8723bs: fix OOB read in
rtw_restruct_wmm_ie()"). Drop the unrelated operator-spacing hunks.

Keep the existing bounds-first WMM match condition from stable commit
4dd2d9cf563c5 (upstream a75281626fc8f); applying the older condition
would undo its out-of-bounds-read fix. No functional change.

Stable-dep-of: 28a289beaf22 ("staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index f2b5455591fd4..b124194c291f3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2029,7 +2029,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
-		i += (in_ie[i+1]+2); /*  to the next IE element */
+		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
 	return ielength;
-- 
2.53.0

