Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFD23B61B
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786888515; cv=none; b=WjNCqiEU7hfiHWsFfy6js2MM9EUtSgN6ofsnudlBXGgFKshdQoZWyL1PvQQWVJ47+g6esQ+PFuUTVNuVz6kpieXCmAl8fiNph62Gf0ExUNjPMDQpWqA83SjFUVll4UBo0uyVSs4n+RJXHms9xjUEBgoOwknypGNudmCajj1XLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786888515; c=relaxed/simple;
	bh=6gXzcdUOI2C/JorOCTroU4TApGBlIDqM/twHJT8nr/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N42qm1AfOnOFHcdntUYVxyHhSvfDwMd8k2UlgqyUwj7KGQzHVmH5HPzyDpcEFcVZYWj2XcmWQzraHImE0kCBEDHKUmQ07l1rSZK+hAkZ9PXd0FTSmEhhTMxgxHRERFQCmdUA6itoLdQHGHtJBlVjXDIkZGY1lEYdjhQ4m9a9lzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i48S9VjG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i48S9VjG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so23535785e9.1
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786888512; x=1787493312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uClaKJD4Ir9tR/GTyjo/ABX39e0TSK4z5x2QoXKCFyM=;
        b=i48S9VjGJ2nN+FeVkUwvOu8DGkPszlyjOHgoJTzLBXcIrQNvnWHJ2Bq2fOKPpAFT+S
         fKimLN+IkWWm8uBdrOTTl7f/mt5zzjP1b7I2vl4bKYqPpIMWJ+4S/9CB9Zib3ty06ILc
         gntvFwNqxPa7tfCnBZmqzmhbRigpTzj4ymdKmqPnnJEYuJqU+jDgJTdOwBnxrtHso7qc
         W5eN6ITAbQ81L3BnKK43RkKgrJzAQ+nfEDnQ5RVnOdjZLmFq2xk6A/PUaYCAxJdvt2bm
         R4M4QRx2fbI9hFbUk7pfOBvpdvVrN17qhqWX/x317C1Jl82va3jIuybEReNC0KG28hKD
         av/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786888512; x=1787493312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uClaKJD4Ir9tR/GTyjo/ABX39e0TSK4z5x2QoXKCFyM=;
        b=d+sIX+SmqWSyWtGefjhop/PozPMlI3h0OXfogOP3zYwWAreFE9TRS7FBrFPWmdUK+N
         LjOT0ilgAn/vkp+dCkvXxn3AEU4P/hMDyHQykuNnuNKLj4D5mL1A4LUP6jsRQgixLZUL
         rDmBImsNB6mpSyDLm8rMAJx+gGBqL3r9VP2hsvb6mM/XdePYL71RgG5T43D4XXni66Wt
         8+93F41uHTd9UH27pa6fBiV84I8cAZu14h6Vp/TEsryyqrKHBrgCkw3w0irTXapVRsx1
         9vXqTvkU0H/ma4qlbWqSWaR4/I6L9EF01BK1shZtI6/HI/iKi8nUyLOcYvGtLYcir4hk
         TmjA==
X-Forwarded-Encrypted: i=1; AHgh+RoEQqpY+Hq3VZjVzCQi4gYDHCNcMz+wpiEYefh59t+b/y0inaqGLZgwZf4Hx8q4aTf+k/Ni+6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3JEPPuIQ2ZdXrPdbrOwVG5/MgyiUhRTlXNOPJm8RjpG5L1hs
	fnf+tqevYtnW06KqRvGvNbKr22gkZ0KgXSzNdEgz6SZB2L+pDBmk/CY=
X-Gm-Gg: AR+sD13twnCd/2JgFGJkYANXCPt38X/E5I7LvMO6uEfqBJBKJ1R7ejqC9RxrzPi2dZd
	JeiccmKjvNitmUUM9Kv/WDi9quTEP1/sgAUVW63YxA7GAFFAGjTXb6IRYrYviOWYnoAqBlifKIs
	pDw6bnM2HMa6+vZlpiff1ad0Fuh75gj3PsZzsJM2t1oAoS0n8esZZc00XMi1yzEhFaZvXSDUj6L
	v53IeCfHJB5k8BKfnonja8vm4JzEwqTaODRXW2DeUp0iHAYO6NUaWB5T4FtZ4LSeZ525yxt45Xi
	VfUOyKYycuI0Bok5Y65pPWuyXpvAuw7OjCyMIPqDSHoQi+ULoFPJUmYtJ4NM3IAwAC85hn9IKbo
	xt/YVSOKyAMTbmZT2sm+dGQxgsQtpyQGE9S91CcJUxNWZDs8H9oMgh3MH2RaKUOMyAp/FbXW9jd
	ob6bjIIpt8TFgQidKdwW3AHhHxOcQTuQ==
X-Received: by 2002:a05:600c:3485:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49987938e19mr302694185e9.1.1786888511685;
        Sun, 16 Aug 2026 06:55:11 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c0a75sm24312488f8f.25.2026.08.16.06.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 06:55:10 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] ice: fix metadata_dst refcount handling on representor teardown
Date: Sun, 16 Aug 2026 13:55:10 +0000
Message-ID: <20260816135510.1015041-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

ice_eswitch_release_repr() uses metadata_dst_free() to release the
representor's metadata_dst.  metadata_dst_free() directly frees the
underlying memory without checking the dst_entry refcount.

When ice_eswitch_port_start_xmit() processes a packet, it takes a
reference via dst_hold() and attaches the metadata_dst to the skb.
If the representor is torn down while packets are still queued on
the lower device (e.g. in a qdisc), the metadata_dst is freed while
references are still held.

Use dst_release() instead, which correctly decrements the refcount
and only frees the object when all references are dropped.  The dst
subsystem already handles metadata_dst cleanup in dst_destroy() when
DST_METADATA is set.

Other drivers sharing this pattern (nfp, airoha, bnxt) already use
dst_release() for their metadata_dst lifecycle.

Fixes: f5396b8a663f7 ("ice: switchdev slow path")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c30e27bbfe6e2..96174fca3984a 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -95,7 +95,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
 		return;
 
 	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-	metadata_dst_free(repr->dst);
+	dst_release(&repr->dst->dst);
 	repr->dst = NULL;
 	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 				       ICE_FWD_TO_VSI);
-- 
2.47.3

