Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795695918;
	b=rJdPrwlxyDMLkQlHPB7rMKsuCbNaG3sHG6qe7l8cVxgwuNE+sjI/rne3cSLOAe7LdA6b
	 3dpoT6Ngh1bNF7zYYcJUm1zq+Mr0DU7dT2+zBIgZWPyQGpy/+ye72vzt81cDaHLv5XWft
	 6lQrnFd46D7jZCsS2seCRIM8JPnmAbZdBjgYx/L+AF0L/o2rnhhEEYkfD0Iyco4F7SiFH
	 Js77e2+8wWBOHK5YBoIgNU4L+1etK/P/ETov3hsGHiXMsiL1wZQW6M58IWAaTYIigRgoa
	 ACLWvwmX9tsGDPDIGRo6ak7X7PQiSnoROhwMJhQW4FIok5h5OQJouccuZvIiy/GqXZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695918;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Q96M7sSh5CzS3RUxF7E5kOzuouA27Dy0CEGL5b9oYiU=;
	b=jEfJssQwv6LTwT4cDlo96qjc/Ouh4tORv+3Znx/tUo1bIlaQvEJfN3wvajSwQwBBRyjx
	 6oFHgBm5kuyCrdsYH65uLPSDR0y46kIBOzqXpwLm9WfNLVtb2JrUrEdH0M3VW1S4VbUX+
	 g2asybNj3tNISgG0W/1d/+EypGAbUtlUOkRokbmhfMJvaR/cByDor32OS+mje0MavbVpy
	 FNzhY9s+vho7Wo6zrM6cBq0YxZAuW4OjlyjpjXDZt8W1jsnSeFxRVkQDYZnSZPcX+uIKC
	 HrlmT2gxdh8qxXlpLkccp+3YmfUUiUiqMcqmulFy0u1ERQPUQfqIWaYO41sha3D7u9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWC2WBT8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0B606A31E;
	Thu, 26 Nov 2026 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWC2WBT8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795695917;
	b=SIDbcStLOIDU6adFx0fnYz5w2LlUJYZ0qB+SA/3EWP1IZGCTYuIUsHX2HZAGyvwJ6hDP
	 2VE0Tz1O1yl+IdG5ofP6kPhU3ZhbXuk9bdVg/Bib3rf6eFEWjIG/Bwkw9enUQQ2yW3MF7
	 tIXe5sv39tUlxpJ+2UWK90VsTe8uKemqN69xnCrjPA3gwCeK+LsuAmupZt3SD9NAXn12R
	 TTbSuODd3+bEj0DTSv0ATGvkwz7TWQKcLlv/l9DwWwy4ieD4uXfGbIjaAsI1okIfuTDp4
	 N7bV0ND5z8LjVuy8a/ZlJpLWvLN2pf1xmg9Ug6rxXShxdqjk8TTJPMGYw7bVAen03MA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695917;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Q96M7sSh5CzS3RUxF7E5kOzuouA27Dy0CEGL5b9oYiU=;
	b=fZu85eEsI61W1gD1qf2X0+DKbVF2byMaysAeofWhEyJ4abFy7woJiCs4MS315tXTtMux
	 KXcTF9moawNU1c0V6ZjrF6tKkc0OYvGmG22yfPwEDwO9ubP9hf+sgxAxcXgVhJr/5LPFY
	 j8mgXFk1y50JG6TPm5h+vLtDZlCjkPeDwJoAe2GVek0FtwEgRevDQ/R3A1j2CzeES5wtW
	 OjW6UB+Ae+VwF5uLOBn7ES2hEFtBHl1CgpuRNLGk0dCZf3KJEq1vO6Mb9OBbak4tLwJhM
	 KNUVHlnRMmCYX6JLtCU0tRIwvfb3dwS2XPEEvmvQblGnNP+rsDQuRZsPXoFuJCnCAJA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 228F01F000EC;
	Thu, 26 Nov 2026 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695917;
	bh=Q96M7sSh5CzS3RUxF7E5kOzuouA27Dy0CEGL5b9oYiU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=BWC2WBT829QGWyesX9LJQ5VYl/BpNWCTjtocmzwaxg/gr2JHkxw0jY7NkhPEf4Q4q
	 SMGPFXDihDRPVZc5iYMwp0NVknwMWhFnPSi1A41lz49le/t6GtnjRB84RU3b4VIyzq
	 de8D/8txJep2Qjg/+DIk4mCk1+MUuOfuhnK0JQvKi2rDsD8fGpu2bm5PF9BwoNzbbz
	 3nAwUcHBoVFxlzaF2L9jYPImVQ7XBtEvGBSm6Fg+/3XEPZMJojYxUDy9PiIA/A7HxL
	 ptvnwYHUFMWhq2M5P90Kxqecmxjg7AMbqRsYqHlcOnOKS1dp7Y5u41tk5ULTMNuuHY
	 RP+WM4kubcRHQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A291E4D495;
	Thu, 26 Nov 2026 12:24:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 12:22:52 +0000
Subject: [PATCH 6.1.y] wifi: mt76: mt7915: clear wcid mask under mutex
 after RCU pointer clear
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-so1-mt-61-v1-1-0ffc1ce5c949@certik.com>
X-B4-Tracking: v=1; b=H4sIAJskCGsC/z2Myw7CIBAAf6XZs1u7mODjV4wHoIvFKBgWjabpv
 wuaeJzJZGYQzoEFDt0MmZ9BQooVaNWBm0w8M4axMqhBaSKlURLhraAmtOS9Hbb7jaYd1P6e2Yf
 X93UE3VP/htNPy8Ne2JX2aaE1wmiziW5qSjiOJaUrNr/+/2FZPlBoQo2eAAAA
X-Change-ID: 20261126-so1-mt-61-b1ffb0793618
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 linux-wireless@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795695771; l=2803;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=BkE0m2cISHMa7wUZVEILWzsYSDPiQWwct5nsfphc2Ps=;
 b=I1eHDPM93R5LGwF5WQQThC2waim3ncf0rHWdkp3ftjfd4fZp0Gh+BmO/2bW/rtb7VWoBHWKdX
 3wUUNMbuaboBpGG3QGBBMaeWYwUP30sRdo5dcLvzGsZPn3sCwX28chF
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Felix Fietkau <nbd@nbd.name>

commit 6486e11a6e2f679597af2d5bb48c3b07a2b2a7ba upstream.

mt7915_remove_interface() cleared the wcid mask bit with no lock held and
before clearing the RCU wcid pointer. The mask is a non-atomic RMW shared
with the allocators, which all run under dev->mt76.mutex; on DBDC the two
wiphys share one mt76_dev, so this raced add_interface/sta_add on the
other band and could leak or double-hand-out a wcid. Clearing the bit
before the RCU pointer also let a concurrent allocation reuse the index
and publish its wcid, which the subsequent NULL assignment then wiped.
Move the clear into the existing mutex section, after the RCU pointer is
cleared.

Fixes: f3049b88b2b3 ("wifi: mt76: mt7915: allocate vif wcid in the same range as stations")
Link: https://patch.msgid.link/20260722082610.2699628-8-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ adapted to 6.1.y: context only, older mt7915_mcu_add_sta() and sta_poll_lock ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.12.y and newer already have this fix. The moved line is the same as
upstream; only the surrounding context differs on this branch.

Tested on v6.1.193:
- x86_64 allmodconfig W=1 build of
  drivers/net/wireless/mediatek/mt76/mt7915/main.o, base vs patched,
  no new warnings
- booted the patched kernel with CONFIG_MT7915E=y under QEMU/KVM. I
  don't have mt7915 hardware, so the remove path wasn't run.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index dde451d818ba..6ed4c9879b6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -297,7 +297,6 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 
 	mt7915_mcu_add_bss_info(phy, vif, false);
 	mt7915_mcu_add_sta(dev, vif, NULL, false);
-	mt76_wcid_mask_clear(dev->mt76.wcid_mask, mvif->sta.wcid.idx);
 
 	mutex_lock(&dev->mt76.mutex);
 	mt76_testmode_reset(phy->mt76, true);
@@ -313,6 +312,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	mutex_lock(&dev->mt76.mutex);
 	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
+	mt76_wcid_mask_clear(dev->mt76.wcid_mask, mvif->sta.wcid.idx);
 	mutex_unlock(&dev->mt76.mutex);
 
 	spin_lock_bh(&dev->sta_poll_lock);

---
base-commit: 1ca1436ccc68275d0b43b6a730b3940fcc46b7c2
change-id: 20261126-so1-mt-61-b1ffb0793618

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


