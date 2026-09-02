Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C0363C6C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314244; cv=none; b=K7pNDDF6QvkRQRCyzB1IhOIiOLdW40DB8YDqA2hOzdODkl+F9lFAIysP8nQRtrpc5BlYHG+6MEC9vhx4xYVgZzGsDJyuXUFPMkVrTOrFcllS7763LaKkqAD5C/Y7rfg04mlRQtSDMiFACyrAXTVslfA7RYe5pZ07BwfHIT8Ca+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314244; c=relaxed/simple;
	bh=Ik8QSbgXP5buhxF8hVJJ2LX4PPnIIT1KbX8G1W+E0SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpIyC/ofuVBrGpPoV8FlNnbQ0xs7A8BzTsHpue1m8ravuRKQcQUXxfjJMG0WkXA0jQyxaVHg9/4c2KajqFeV/sYK0tMRFVEc6AmVA1+zOrOYxFJwztRF/AjaS+5Lth/6L7RGvKA7enmA/SEiPDfl8OWj7K01L5e0bd2Cy1kWLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Lgy4n7fc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Lgy4n7fc"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so641915a12.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788314239; x=1788919039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8NexaY5OOI9G959hLH28cElmfzdE2NH8o0S1EDtR7Y=;
        b=Lgy4n7fctmLm0VRdGB0LQd3y29ORZSxGQdnw5PrQ+Xwc/RVzHoPyoscLCqWSCL/cV0
         t5o50+BopFN/QtF56t7uzdshXY38OfQprnUGRu1fomkWM7eOFnVKsm6wXlrHyymhNba3
         LiPGbyzGPIfTMQeI+kPyXPcgqFrnWWeVEyoNdMl9ilaBTkA/dEY69qt7qD876dnDLdWd
         At8gHvXLs805Voihj5n1yRCUJaVLO41HGPj+T8yYwXrej+MfTQkMeV9DDogXdVLpf0DA
         WhSu/jlarygTuwN0ZPLq83SRSX2x26TCJDA7W+DjXt2280ZFaajbwmPY0C4EjkhbjD4j
         +ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314240; x=1788919040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t8NexaY5OOI9G959hLH28cElmfzdE2NH8o0S1EDtR7Y=;
        b=ZT5vZIdSxO/ZrXc5EgeNZSNxJzu1WvCC3tzvwukwY/93sidrt8BmHQFE7d//WQVo+t
         zRsoHMOOg1zffvkcJwH/HefZyeiDyaIxMZMX+vlwmgp8TrzvvufezjK2npN1bck45Qij
         /G293oJI+3YeLOAfEqma4TN6rRAQEYAfupafA0RHmj5rLOJt8oV3WcmgDyi6Gu6vZF+v
         8oU2ql9Er1gZLw7QEGqhk0rDdBjYX421o8PWWbcDigW61mREwrig/HZOnZbr8rEgtZcK
         1Vk+RbXIHBwnZ+SIeU0Gcq1FPSIHUxcEiANFmYHYu4ZQo3ZvNyfPIAJqMU4e7M+UljY3
         H35w==
X-Forwarded-Encrypted: i=1; AKwUvByRIqCSEm1cuvwlpCn7ASht2Xzv/nurESyUBkVpKUOnK2IsuBOAiN3DnkWeFAzP4Ld9Td2Yio4=@vger.kernel.org
X-Gm-Message-State: AFuF++nhoX/qYW0XkZ/goBhbeFsBYq3OjwyLxyetwbHpQHvJZ55KKU6D
	MOBFWTmbOS3jRpNLg7JkOrpGBudc2ZkztpPatibtp2942WYwZAzrCPevVjjGZoWBCQI=
X-Gm-Gg: AYBFou1uUIwJjEtAADCkw4AoZoZaJoQmqCxoxsjUivHuvJzghPtE7Jp2/ofude24397
	PG9zkWoQnC4nvNZaPadn4RXK6K/0M08SPRY1rjzlLQv0qNhhJr4+2EZpMN54qyLpCx2V7WhXDac
	w3TIZHpvJecdnIgGMTQbJBLrWeRuFexCVUEa0a0Bv033fR4JMykX/D1Ch+j66NJOXWDdC6hSrZo
	3FrJ5nIKezgbHwNV73lViuVo/J/D+z1pVCW5FRHwmKDvJG+i0cIpceZVXV90deChHa4uR99+lRM
	90cTLtSEA0WIqUPmZxMdqYAw/Hh0KiJR1bvWpN9ZLK1ci3K1A/0EkaUt8wz5Lv2rtukqjxZLxhG
	XQtQ1Ip/hp4kiUDke59efG3w4pW6qsSIy6EAw+1R966DU4719C+2lOyi+HjRtVKawmmYNmvCLTF
	1KPZdLED7PvjZyKuyZH4CK4wdYnSfZpnnxZfVFWZ0kCZQ=
X-Received: by 2002:a17:90b:524c:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-39aedfb8ebcmr1991272a91.7.1788314239469;
        Tue, 01 Sep 2026 18:57:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0dfe6b6sm2346061a91.1.2026.09.01.18.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:57:18 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Edwin Peer <edwin.peer@broadcom.com>
Cc: horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	Joe Damato <joe@dama.to>,
	Sashiko <sashiko-bot+sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v5 4/6] bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
Date: Tue,  1 Sep 2026 18:56:47 -0700
Message-ID: <20260902015652.2421609-5-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902015652.2421609-1-joe@dama.to>
References: <20260902015652.2421609-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_rx_ring_reset() frees the ring buffers and then reallocates them,
ignoring the result.

bnxt_alloc_one_rx_ring() can fail in bnxt_alloc_one_tpa_info_data(), which
returns -ENOMEM on the first failed allocation and leaves the remaining
rxr->rx_tpa[] entries zeroed.

The error isn't propagated up, so the loop in bnxt_rx_ring_reset
continues and at the end the code re-enables TPA with partially
unallocated rx_tpa array.

This means that when the agg_id from hardware is mapped to a SW index in
rxr->rx_tpa[], an uninitialized slot can be chosen which would hand a
zero DMA address to the device.

Fix this by falling back to a global reset, which is what the existing
code already does when other functions fail, but unlike the other
failure cases this particular failure has to return because TPA can't
be re-enabled since the allocation failed.

Fixes: 8fbf58e17dce ("bnxt_en: Implement RX ring reset in response to buffer errors.")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3755a30f8d40..a8e5fdfcdf59 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14604,7 +14604,14 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 		rxr->rx_sw_agg_prod = 0;
 		rxr->rx_next_cons = 0;
 		rxr->bnapi->in_reset = false;
-		bnxt_alloc_one_rx_ring(bp, i);
+		rc = bnxt_alloc_one_rx_ring(bp, i);
+		if (rc) {
+			netdev_warn(bp->dev, "RX ring reset failed to allocate buffers, rc = %d, falling back to global reset\n",
+				    rc);
+			bnxt_reset_task(bp, true);
+			bnxt_rtnl_unlock_sp(bp);
+			return;
+		}
 		cpr = &rxr->bnapi->cp_ring;
 		cpr->sw_stats->rx.rx_resets++;
 		if (bp->flags & BNXT_FLAG_AGG_RINGS)
-- 
2.53.0-Meta

