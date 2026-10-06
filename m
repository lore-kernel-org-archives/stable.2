Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1DA48E0F0
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306796; cv=none; b=PzbS85MwlljC5/0/dKFFH2rGt1NFFO56PnW5jqKRniXwe7fuIjuAgdE8Gp1GPK5Mh4VSL8QTE0rmqn5+38lz3QP/m/1LKjOvvxrCw24FSsg98wynJdeMAAm4uOIbwPvrwryvj8yZ629gYRAt+SLa8R6BBlI4vqPiGFu8/5nLaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306796; c=relaxed/simple;
	bh=tqK3ZhdK+wYP5fx/+lrWmrU8r2TEjRV9LXqjQQpLcEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJEN2FtWqY9QYaknrQwlgb2eqs3MyY2+buzKOufup6QPQYhZpRjjx4ZJGVTmSuzivz6F0JTJpZwgkfytF69qsSbigMCZvZYoOunnZ1jwCP0xpvDUZ412tHERlHdAbNq8UKsgRETQ7D5fajPGF2dr7KrES4pZ/uPLSLgAQYz2Pyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mgJR0vU5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mgJR0vU5"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id D566520B7178; Tue,  6 Oct 2026 10:12:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D566520B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791306739;
	bh=rfnwOqzi9EtQXlIdJKd/kKItIY2A9F5Pc5YqAclrje0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgJR0vU5owtgE7bX4IjbMzisQnZ+W60BXoi9gZWOglG9qdxARoNsI11iXnqPgbvIa
	 2lPLpeHncpk/xbGWnJ0DfjLY9li2RroPCvZyTNIKcASuhqAdoUhmr6czUvCXA2obDR
	 aC+MMjEWYR+g0jlzPWE74UUnBKKse801iT0BcsvI=
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
Subject: [PATCH 6.6.y 3/3] net: mana: remove double CQ cleanup in mana_create_rxq error path
Date: Tue,  6 Oct 2026 13:12:04 -0400
Message-ID: <20261006171204.2777439-3-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261006171204.2777439-1-hamzamahfooz@linux.microsoft.com>
References: <20261006171204.2777439-1-hamzamahfooz@linux.microsoft.com>
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
index 058ad3460af9..c92c86ae959d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2451,9 +2451,6 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	mana_destroy_rxq(apc, rxq, false);
 
-	if (cq)
-		mana_deinit_cq(apc, cq);
-
 	return NULL;
 }
 
-- 
2.56.0

