Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998B3EB0F3
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306795; cv=none; b=gew6A9ImRihfQP3b7LHAasO7JTncFBvnffG9pAQFGq9w2NsJ5ShMPgbqRg0JIcPSYngFRuKUB989lp6N2mGQDqsccqS8ibSDRV3UjoQVyjuxFP0qdiVpEp7XNstnkV2hVXQ3/yVjdVEPUQOLvXle08ja0nh7gXphJGbjuS1NjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306795; c=relaxed/simple;
	bh=2q4To1e1efyv0AJl47HI6s/z9LEmDU6CgT72Mta2En0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifSFQnNjWRNQBwYD7PwT+UUbkyxi6MFoFqpUs+z+dMoIcYH8E9JRlhe61KN/CNgz+YIqUcUi2pEr+0UXXI+6el9hPStHnavi4azO3qcEYD8fq4t9zF2MNjgfbA0iajXj03J4glznaHf+dEIOlPChaTmcdC2LYVE1aCH3x6uzBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fI5CRCs6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fI5CRCs6"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 7554420B7175; Tue,  6 Oct 2026 10:12:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7554420B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791306738;
	bh=IRwfPPJsfYQ6UZpuh6e/Ndxc0PNn74IIb39dLAKoAKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fI5CRCs6WtL+xOoCbHOvdIkdfsFrYWNXzK1k3hGzcT2dortLX/oL5xmMKNs1UfR3z
	 DhyNRTVfh5G0YeS8Tn86IepxT5kWQmFIVvtrrQzk73T/VKXJffd9bU7sKcfh8aVVls
	 BzcBS4gFoLJaB2/+B2iwVva5RAULQYIK8anzKR24=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 6.6.y 2/3] net: mana: Skip WQ object destruction for uninitialized RXQ
Date: Tue,  6 Oct 2026 13:12:03 -0400
Message-ID: <20261006171204.2777439-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261006171204.2777439-1-hamzamahfooz@linux.microsoft.com>
References: <20261006171204.2777439-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dipayaan Roy <dipayanroy@linux.microsoft.com>

[ Upstream commit 2a1c691182823a5c149d502ac153e249ee697b4a ]

In mana_destroy_rxq(), mana_destroy_wq_obj() is called unconditionally
even when the WQ object was never created (rxobj is still
INVALID_MANA_HANDLE). When mana_create_rxq() fails before
mana_create_wq_obj() succeeds, the error path calls mana_destroy_rxq()
which sends a bogus destroy command to the hardware:

    mana 7870:00:00.0: HWC: Failed hw_channel req: 0x1d
    mana 7870:00:00.0: Failed to send mana message: -71, 0x1d
    mana 7870:00:00.0 eth7: Failed to destroy WQ object: -71

Guard mana_destroy_wq_obj() with an INVALID_MANA_HANDLE check so that
mana_destroy_rxq() is safe to call at any stage of RXQ initialization.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Link: https://patch.msgid.link/20260430035935.1859220-3-dipayanroy@linux.microsoft.com
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9091caa4ee9e..058ad3460af9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2187,7 +2187,8 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
 		xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
-	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
+	if (rxq->rxobj != INVALID_MANA_HANDLE)
+		mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
 
 	mana_deinit_cq(apc, &rxq->rx_cq);
 
-- 
2.56.0

