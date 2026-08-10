Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6F258EFF
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368876; cv=none; b=g7GAEsoRzHTeOo3O40okoRq5njauyJI/1R3Z2SLAe9KWecCtEy85EhQgNkF7nYseI7f1nGz5K4GAnnJVMCGuXeoAQObdSl4BVo3g9HTZjXCQvadF/LR5b5ZWR7trSBcVucoAq+TV/mjFmvpjvt4m+k+sgbLQYCdEmmo2wOXvpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368876; c=relaxed/simple;
	bh=3mJtVOxUFYJyp28+b+p58jSvR+yV2RexVAv8BRADCoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S45WwXw+J/A0A2lYzuxzU6OcIuXQM1tfDmwPN5rprynxRNOZPGMBxYmBbOmZcQXZgv2JqDhMM2hrvEKlFiBkddA2IFVxUi8XIxT3CRBe7a1IOCJXZ0nAgOKeqAS1M2+JjnXJfZ6f+6YR3VREOWkilytFS8RVWQRUN16g93dDMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQczTc7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQczTc7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961881F000E9;
	Mon, 10 Aug 2026 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368875;
	bh=O0UdfHNzHucsd346RGhANG1DTKJQpdHtMSJnCvOcHt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQczTc7rDQZrEiaShbzX9x4in8EEwmEl1ckltT3XvZNIbMJjIMFmugmn+kw8z/sCQ
	 7ZI+zukIDPvfzymg850BXSyHq9H6emASrrShuZkZs/8r8Uzhl16GwkoeHkmU2u4dy6
	 n1gySToQGVEl2AxPFaTAx+38OZifkQzariPlv00fMX65mYgrOp+tFGAysAU5CfMlAC
	 f8DNR+Yh5JW9sP+PkuMn/d4VFs9hV5BRCmoX5GicN2zbjdqy5GOt0Fyy8umbdmpnd6
	 2+PKqWgTrsdpSiJogxy2AnW8wYTrayvbI20M6qc7KMGxcbN+S1njrHIkVOkE9cnaOx
	 mocoExD7CI1RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] skbuff: introduce skb_pull_data
Date: Mon, 10 Aug 2026 09:34:31 -0400
Message-ID: <20260810133432.1246348-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080515-broadness-backlash-dde1@gregkh>
References: <2026080515-broadness-backlash-dde1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 13244cccc2b61ec715f0ac583d3037497004d4a5 ]

Like skb_pull but returns the original data pointer before pulling the
data after performing a check against sbk->len.

This allows to change code that does "struct foo *p = (void *)skb->data;"
which is hard to audit and error prone, to:

        p = skb_pull_data(skb, sizeof(*p));
        if (!p)
                return;

Which is both safer and cleaner.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Stable-dep-of: 47778d2c2087 ("Bluetooth: HIDP: reject frames without a transaction header")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 667de403b2ebb..01eb7bc4e84b0 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2317,6 +2317,8 @@ static inline void *skb_pull_inline(struct sk_buff *skb, unsigned int len)
 	return unlikely(len > skb->len) ? NULL : __skb_pull(skb, len);
 }
 
+void *skb_pull_data(struct sk_buff *skb, size_t len);
+
 void *__pskb_pull_tail(struct sk_buff *skb, int delta);
 
 static inline void *__pskb_pull(struct sk_buff *skb, unsigned int len)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 90a63c356affb..83bf2e5bed2b2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1976,6 +1976,30 @@ void *skb_pull(struct sk_buff *skb, unsigned int len)
 }
 EXPORT_SYMBOL(skb_pull);
 
+/**
+ *	skb_pull_data - remove data from the start of a buffer returning its
+ *	original position.
+ *	@skb: buffer to use
+ *	@len: amount of data to remove
+ *
+ *	This function removes data from the start of a buffer, returning
+ *	the memory to the headroom. A pointer to the original data in the buffer
+ *	is returned after checking if there is enough data to pull. Once the
+ *	data has been pulled future pushes will overwrite the old data.
+ */
+void *skb_pull_data(struct sk_buff *skb, size_t len)
+{
+	void *data = skb->data;
+
+	if (skb->len < len)
+		return NULL;
+
+	skb_pull(skb, len);
+
+	return data;
+}
+EXPORT_SYMBOL(skb_pull_data);
+
 /**
  *	skb_trim - remove end from a buffer
  *	@skb: buffer to alter
-- 
2.53.0

