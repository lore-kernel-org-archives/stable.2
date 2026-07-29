Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0747340A57
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346609; cv=none; b=Cr+87VX/bJb4teIh0b6xv9fCOxFET7g/uFLIXBEsr4teggkieDfCBhV1nr9ooQZE4vMzeMBMNGO2ZXrHQ4XF/bFiXp9Q/u7A7TeUa9UfgV93P1oSTa+ELNRWRwkHDWzCCnrE+54pnxToVu9lozR8M1T+6mUOuz4koT4gZViDn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346609; c=relaxed/simple;
	bh=bLigRDlF77Q8rMCVJRJEG9Iw4ESVLt7RgamZeM/qbdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=claWHqGTdVHTBI/J9Ft1VoKB+WO+ctenpLdld91yCEUfmdCsh4hKw6B1Nq7BrO95ZrL7pYTgZ83CpDfnhMhe95rlGOS42oIWugidjvp+IYBXhIyvpM1mdEwttGd2hkzF9hvVPgot/4HDZ5yp7EaN9Q8lZdMgAJrBrWtMvgwvNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3NzY01O; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3NzY01O"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ced3386430so12796915ad.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785346607; x=1785951407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gg6ArNtx1AiAv6yPr+prFaZ5QUtx/jRFL3cP/oq9oL4=;
        b=n3NzY01OnnfSW9mbHuQ9pZZkdkPs1ymiGLtBi7kc40Z7F8Id1dP2IgBfvPi8huyxmg
         5AQk1bY1q4UjE781Oe1FnSRpRjHBQgwkDwXNk7s05+nRZRVNHIY5eUSZFHuslopz8mAB
         ZBnH84oxy0GUM+oG0EUYGGF7G0zYyGyqViA/DCjskzAD9QVh1/wkQtfZmawnxOy68xBl
         wEn6xydJiJN2Z5MVBMmRTNVl5chK2q5jnD1YVXwNxCXcfJfrbIVT8LL9Mf6Kq40zcSvI
         4g0NNKj9IquWZwaXD9Fxy4Sc4MZpWeCowj/Kw8UXQclI+jbP+xlmp768D/yoiZkrTddk
         eiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785346607; x=1785951407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gg6ArNtx1AiAv6yPr+prFaZ5QUtx/jRFL3cP/oq9oL4=;
        b=V85tAFl9Y5rc+PyPwmtushTTVpxdF3JCwA+UGLUWwm8FRF34mP4B79YWFfSq2+WeDn
         mwdlPpEo2tpvQQMpW9GQe5UJwsv/VfogBKI3tG0NEOqMouwNeNkvw4TMZylnoukr/+Xe
         1/hHX/B3FWXqxTqyn+HgRgRTcY80Ep5ZzI6qbnRkFrxL4jWfogL3JyPbwaspQXrFGI8g
         UwtrLh5ELK/79C9wLqu7ES00nh7Q2R37gsbAtpXdArRFT1icU1Y2PIMW9N9UKCLNSnPd
         LKY0alO9uYBPaSjmIAc6d80gbkeYoAz0xSygc67vrGsPcmYVquFQIf/CXHMfKnJy5xUH
         zDbg==
X-Forwarded-Encrypted: i=1; AHgh+RqpJQiQsdR8KW677bo5TaKnM597tfmhbO2TuZsO6NmM7YM6NPEAgBeLQIh8mPomZc72Gm5KB8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2nmXEuvjcdzDxBxBnCfBW7qbDApQueVr6J1qAVp+mTaGFExDD
	8XZ7e2X9npfNjSuOo1q+5cpfsbpBEM//boXggSfiXtz86TyMDqPz/kGw
X-Gm-Gg: AR+sD10F6Hvi6FILTXXjnVDI7uHzDQKoPa2gp9ZzpVpuX4MdMQTfRMK3d16F1OuwDx9
	3F+EO2dsMawmjAE/gRbBmB29F7n5p0ghdl8ZbANxcW7UuvEPKtp1mV2a0AZIyrPJaDt8H1Nz3Pz
	CvgEY9n9S1cfeDdsr0gWEGStBVrhcHi2zQGwI60Acp/ZfwvdaxjlHsLhq9d2gFukKwtprX6GZud
	yOYp3UccY9+B0BofVk9S7FkbojdDzIjfkGDifBsG4RI3P2Ir48326cqzFJOAF9v0lv/zpWo2M3c
	ktFkSawTAgCPcg+rHKsixA07laxij3n66utR6KKOuzDIFWotUdAAzVwloc31vBUfkAoOwSf9T4l
	oV3oNLkihJnf6Y6KXsyIKGU/gp77FZPRNheQOmz55qKsMH2AljAgXqol9igPPQlcdfks9EEI4l7
	MpcaMzOd/jCIdvzmrftYSLgWl2IsgvMpeF7Yu7lbH96pQw2ae8zmlVYDbh8cpgpxIZMas9Km/+Q
	QGs1JYP/V7FIDq+OwXQvIPNJBE=
X-Received: by 2002:a17:903:11ce:b0:2ca:b8fd:1a8f with SMTP id d9443c01a7336-2d016050393mr86243135ad.39.1785346606916;
        Wed, 29 Jul 2026 10:36:46 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([120.234.91.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bf39cdsm14806045ad.55.2026.07.29.10.36.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 10:36:46 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rex Lu <rex.lu@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Chad Monroe <chad@monroe.io>,
	Howard Hsu <howard-yh.hsu@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	MeiChia Chiu <meichia.chiu@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: mt76: mt7915: unlink TWT flow on MCU add failure
Date: Thu, 30 Jul 2026 01:36:31 +0800
Message-ID: <20260729173632.14387-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729173632.14387-1-enderaoelyther@gmail.com>
References: <20260729173632.14387-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7915_mac_add_twt_setup() links a new flow into dev->twt_list before
asking the MCU to add the agreement, but exits without unlinking the flow
if the request fails. The flow-ID and table masks are only committed
after MCU success, so the still-linked flow is invisible to the
mask-gated teardown paths.

If the station retries the setup, the same slot is cleared and its
embedded list node reinitialized while it is still linked, corrupting
dev->twt_list and potentially preventing a scheduling walk from
terminating. If the station disassociates instead, teardown skips the
flow and station storage can be freed while the node remains linked. A
later scheduling or debugfs twt_stats walk can then dereference the
freed flow, resulting in a use-after-free.

Unlink the flow with list_del_init() on the MCU ADD failure path. This
restores the list to its pre-request state and leaves the node safe for a
retry. Mask and agreement accounting remain untouched because none of
it was committed before the failure.

Fixes: 3782b69d03e7 ("mt76: mt7915: introduce mt7915_mac_add_twt_setup routine")
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: Kimi:K3
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 334c19ab2b22..1ad54a5bb374 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2345,8 +2345,10 @@ void mt7915_mac_add_twt_setup(struct ieee80211_hw *hw,
 	}
 	flow->tsf = le64_to_cpu(twt_agrt->twt);
 
-	if (mt7915_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD))
+	if (mt7915_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD)) {
+		list_del_init(&flow->list);
 		goto unlock;
+	}
 
 	setup_cmd = TWT_SETUP_CMD_ACCEPT;
 	dev->twt.table_mask |= BIT(table_id);
-- 
2.50.1 (Apple Git-155)

