Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F9483806
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397719; cv=none; b=YpvsjczzPXS4jDYFvK0uq1o7SoSInv6QxSAhh6ispEaifZjH0nQX8oYLtgNzAwQEQDLcTDt76WmjljdUv5ocYS+qPsiHFczx13nJW8Ddv5Jh3tpiFLs7J4FTgBeb+21YSUeMhxz4XQowOM6j1GlXJim4W7aldA8hQW9+g1c4MQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397719; c=relaxed/simple;
	bh=lIGJu87IDArxEyWhL0iXD9acKrDMnyg5SF/6N1cb1BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTY0cvnMSIlGY1uePZ/kAeBa78l5FGlFtP6Uc9zZ9bUqNx0W/VoBGnZkU/gToxDGd9Rbzkd0ifcdzYe38RPEsqqBRWcRxIhJibIz4XssxFal+VV+IDhPmZcZE3MnF3Su6kqnI0o2qRP3xeo4zCXxJL28Sr5pd2UQhpKCmZOOVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT8sk6+L; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT8sk6+L"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so2473592a12.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789397717; x=1790002517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITlXRLngn2slKcOGycWl5+67jdUQ/52QuImnyuHZebY=;
        b=WT8sk6+LDlMZjTQlawqOtZieOWochMLXnJcHUuE7n5F9cOXz4785zLZJWZkCWtIzrg
         q0wobQDD5Qvo/rqKgiFPQ1N+6b9nrmJs/8z1y4AMZQvKoG67sQg71hLoZ+tsHPIXUFwy
         xfL/9YNbOcowJhr8YHWXoe663rvz5UKhjp0eYN4XbxzgmUBQCV8FyS3D3RrNHtWyBV3U
         9z8LoXF/6fSKQyco9A3lvusT03k0+cCx9ZWahzDf2HV0n5fn2kGaUzavPCrZl1jcTtKH
         3lFk1fopy3Z20iVwhIS0rkgif29fdxHDXLUCzXnsIf0UGzQNt4gpbFydkevYwRpdZEkt
         MjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789397717; x=1790002517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITlXRLngn2slKcOGycWl5+67jdUQ/52QuImnyuHZebY=;
        b=cpLk0lGgoXZXps60/oJziirSRF2JFKB3BspATzdgxX+rYP8CAUvmr6bHv3tqRz0Dwo
         85nWikE+Um5V7X+rbI8EaZmP5OCmc49EJ9W8iBdok4UnbnL2To3ccB2KCkXvIHG3RyNN
         U0utv4EVLsBGiiTbXUSjth/ht0uR4XfNrWSkgc82hRde09MJJ7jyCuQMJfK1bcXfszsJ
         ia1xJtTIb5p7IVf/IRlqFh2WaD2xwKHLXuSoKydJL9fwk9SUI1LTjGg6SpK5frDC7s/4
         mbrVB/01saaty0N4eJzK9Cdp4vwD2cY2s0Rfz0zAMvAfxfo1mDlaHSkyfBuqz/wUxDUU
         E0hw==
X-Forwarded-Encrypted: i=1; AKwUvByRq3jhtUboptKZQzk/XnaNU5NEX5Ah17QbmAMglzUlCOa4nytNuUG4knsJ/+VhM+mNSKsmhgQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nJ8Ed85LonqA+dBuT48i2LvIN88FyEZyYoZM9v2pGp1Hr67x//
	FtMcwprHpFZS4Secm6EhcxrpTthqEUe3LJPVwOWMlVVW0Up4mLxZBIH7
X-Gm-Gg: AYBFou3qXgqk2JwT/zEzmgcqZwBXstjnEHIxzTiosKRc4tBv8rvxW6SblOEpE3LIOOl
	xmTkyDZ8FX5z9X/7/6is+6qq+tVgwOj/8sKCbpVpE2IdJhToM2L27fOWX0jtpvJRxhgqTZl51l5
	tuwvprt/UJKroFNes5r4CXeNR4QQlEAGrZiaeKfLHNZ0sMA+fSlyAn4hkbImVllOOEe/v08Efvy
	vUjKauw4TDieE0sQrp0v9mldwAzHKr2VreKpDBCOqe98+s+iqOYED+OA3jNwCwbGc+aMqM8u2BO
	kkHMRfajg0MeExIeRuuveRyb8yp31mMuoDwpPojQTg83LdEORsY5bG8d29AavFTpPWBjAcH3xms
	P8xB38Drg4wVZMj6iWMwg14P+DTOfwqcaYK/SB8conAL3lzd9jF52DPtPasRN1Wcyl/p9D4W4qm
	mS2wynGKapWJwru+b4R3ip3QkUS0xSAIRs3c3JlmRr8eW8/m2BxOW1lp92VE0OsoJIfAm6Jtq/D
	VFo8SL7/8ikVks3fWRp3z7BTZQWuHqTMFrhGBQ=
X-Received: by 2002:a05:6a20:43ac:b0:3d1:39e9:b267 with SMTP id adf61e73a8af0-3db4037cd96mr6822285637.3.1789397717314;
        Mon, 14 Sep 2026 07:55:17 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c615a65bsm5338805a12.3.2026.09.14.07.55.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 07:55:15 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] wifi: iwlwifi: mld: unpublish links before freeing on add failure
Date: Mon, 14 Sep 2026 22:54:33 +0800
Message-ID: <20260914145433.42830-4-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914145433.42830-1-enderaoelyther@gmail.com>
References: <20260914145433.42830-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During firmware restart, iwl_mld_add_link() can reuse a link that is
already published in mld_vif->link[]. If link initialization fails, the
common error path frees the link without clearing that pointer.

A later firmware-add failure does clear the pointer, but then immediately
frees the link while an RCU reader may still hold it.

Clear mld_vif->link[] in the common error path and defer freeing dynamic
links until after an RCU grace period, matching normal link removal.

iwl_mld_link_from_mac80211() reads that same slot under the wiphy mutex, so
a NULL link means the slot is already NULL; the common clear cannot discard
another link.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 96e06940b34c..55b84801923d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -541,15 +541,15 @@ int iwl_mld_add_link(struct iwl_mld *mld,
 	ret = iwl_mld_add_link_to_fw(mld, bss_conf);
 	if (ret) {
 		RCU_INIT_POINTER(mld->fw_id_to_bss_conf[link->fw_id], NULL);
-		RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);
 		goto free;
 	}
 
 	return ret;
 
 free:
+	RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);
 	if (!is_deflink)
-		kfree(link);
+		kfree_rcu(link, rcu_head);
 	return ret;
 }
 
-- 
2.55.0

