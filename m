Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226283EEAEF
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293191; cv=none; b=WraYjC2iKK4hdBt3wKZIgW/qnyRGYxNZM+bSEDS8LXz2sr3BzaWnzNMa20E6hcQKiw00uFBQ3fyfpwKDyh8tvzgAYNYJ1H6JPuIeN9KrXA4L9ZGIrXVunNmyWpBQtW/bKTY36ybEsDXrJyoR/WThIYfj5iG0U9mEHd0HL3Y0jSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293191; c=relaxed/simple;
	bh=KKH6Mx6vrHvXwwIKA+xXTDYN+U8JXDCYoafHU+C7tGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MBC+AhJOerWPyGBKGNJWS4nhRVJnTRaY/XKzx+UDZTqMfKqIP0pyCqQRjP0EkFYLuPLwufJHYDX1wZJYw1vexdp2wY1Glp16inq4JEcwi7gJuqYZklC/CwdfvZD9vqtruxYLHm87Ms3y5CC7CYdxaNPfqsJO2YIVgRgQ7sQGNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iDFGpCqQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iDFGpCqQ"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 4476520B7168; Tue,  6 Oct 2026 06:25:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4476520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791293134;
	bh=QDS/Tanu5f2ossPGoWuz4mtgHqx9d9/NFs0mbAEF2c8=;
	h=From:To:Cc:Subject:Date:From;
	b=iDFGpCqQm6CdApNtzLSZ4xgjNJffPB8kRwz5UX3iU5Wrwm/vjMf9N7GWSe2wwlXWR
	 v5UQw+ouXqBQJKkqEkOxsErWFYcyd8YftBMnYdgB2vhi+SVhU1L2AP+gaU/xfcJavj
	 J8mAmO7shAUarkQkwFyV6emlu5juTtMi9FOr+MoU=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 6.18.y 1/2] net: mana: remove double CQ cleanup in mana_create_rxq error path
Date: Tue,  6 Oct 2026 09:25:22 -0400
Message-ID: <20261006132523.2742871-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dipayaan Roy <dipayanroy@linux.microsoft.com>

[ Upstream commit 3985c9a56da49af8b2e45cb1fa55c03c89b1d471 ]

In mana_create_rxq(), the error cleanup path calls mana_destroy_rxq()
followed by mana_deinit_cq(). This is incorrect for two reasons:

1. mana_destroy_rxq() already calls mana_deinit_cq() internally,
   so the CQ's GDMA queue is destroyed twice.

2. mana_destroy_rxq() frees the rxq via kfree(rxq) before returning.
   The subsequent mana_deinit_cq(apc, cq) then operates on freed memory
   since cq points to &rxq->rx_cq, which is embedded in the
   already-freed rxq structure — a use-after-free.

Remove the redundant mana_deinit_cq() call from the error path since
mana_destroy_rxq() already handles CQ cleanup. mana_deinit_cq() is
itself safe for an uninitialized CQ as it checks for a NULL gdma_cq
before proceeding.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Reviewed-by: Aditya Garg <gargaditya@linux.microsoft.com>
Link: https://patch.msgid.link/20260430035935.1859220-4-dipayanroy@linux.microsoft.com
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 304815a61cf4..089bbe38feb9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3025,9 +3025,6 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	mana_destroy_rxq(apc, rxq, false);
 
-	if (cq)
-		mana_deinit_cq(apc, cq);
-
 	return NULL;
 }
 
-- 
2.56.0

