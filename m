Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CC4779A4
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397711; cv=none; b=cXGtzNNpFG61EDFFhIhcsIwwHrwIpiYE4Y1lqaw9quSO2U1CFaIPMTnGIHFuYI5DzSqBBsDanXi1DkAHVWnl7uDCfYtXWK+TmWsKMrdASXNZJjs86CXok/OvaqPF6a2BJHGUz608+CKSi2AccKJjRabzOWuPS1+2UCmzietIQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397711; c=relaxed/simple;
	bh=eYMKmu0TspLLrpI7Dq/rAwnjuVZWjXe2BfIsHDWlOMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDSKqev/s6WtI4bJFI59RYVj9sC9xMyNM/emD/oKWv34M5Eyf5YuAu4VeNSw7BWC/2HviMu3SVr2+J736wdwk3tByr4YCq9JTc21UDRj97Do92WsRGfEOzYsuMgBlDqIlVi5E2ocOplJu5U3TjL/o6wyo4DnT0MHxIXJrhBZAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0I3EdtH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0I3EdtH"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4d03f95dfso1942312a12.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789397709; x=1790002509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K40D55+QEw0tJrishTnnZFQc54eXC6WooG3rrnRojok=;
        b=g0I3EdtHJEOecnsphh05qTqrPZnm8t9vaNGW2qPUrPdtKmCV6z1pFyMmBq0MkpvWOH
         MjIoGj2HhKrijaRRRLrrC+YPw1ZKUBJsXIhuy/ZMKscTixDS0oYiPxKUKI/Cv/1c25PO
         sp89qp/hboCTlyLCL0xuUia6cvdoFqkkA33hdFQchL3BZwAeKzB1Wmv7D91b7vMIHk2X
         ZD7L9/6vkvqGFZQXOJabJBl5tfoKGQyMzAVgFX6C7+tN229Ai6dh8SWScdhsNLt+dsiL
         hgu6EWqmL70MRTmctMZg4qpOIkq8CidZkVqUJR1KkolcHA1/TjgrT9POn7pxTwaeQ6bL
         I1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789397709; x=1790002509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K40D55+QEw0tJrishTnnZFQc54eXC6WooG3rrnRojok=;
        b=kt8XJ1cWGqmsl2QWrxVbLf7Oc/NeN7fC8ewi/jUviLkRHa+xARHoHDlYRXRMFdx627
         TtBdtvULdXec+KI1aFVlIW09UvdY4aJ6lamMxqIxOGT0nR625pIgnMRpQ6xFcTHCtARM
         pZUBtU0etaNEaUju8W3cTHl3VUZyAIThTAEesascHEQvvgHY26s9x5xaLYH9RiLH6MiZ
         Hcne6MzIH+QuV/za8d1I9AGJW8KhnpS3Go/CGNo0V+l+klwr0M6Xv7pNgTTieaTxZltm
         6Au2IErQp1zvFbt2hIBsVN0ISwYS9/e078KQgWRbmcEcGm5/giW4NGSlEVP5yvCn3uIt
         2zeg==
X-Forwarded-Encrypted: i=1; AKwUvBw7uT8f5nuovCBkXwxAY0iTBqL7dVphT+5rBrqCxC9LMCQQqo73//Lx4itfrk544+hpqy0j+uc=@vger.kernel.org
X-Gm-Message-State: AFuF++mUCvbwk1B80IdhXx5D8VxYbrSczduNg8r41PYRNFqte8FOdt96
	3CcARGeP4ju3mA/mio8D6If8E8xCeoOFERcXs/AHF2UwG4Of4MNI1ipL6x/i4LsH
X-Gm-Gg: AYBFou1xbb30LODwKXaCgcl5yuzuxH6JayYbHJ6bvYDHDksdtWIqw1GAIxqKtjRH8RC
	Df7HRQgoYK8tWFyj3xqvXOU5puqX4DaooK9GkSBUx+sXFVX+rk1JvfnPrBAuEwSksKDTdbvZAcq
	mV0Iuh85OtTWhhH0KgrYcrYmeiziTFCIQ3XxtxWgd4d1eRVqQ8gIpJA9VLBxLH9pqWKlgUQIcWP
	LFsxELYEaXoqA9MWoYXUSs+3rb051jh0ifMhiHQN8xLEuAOK2IvMG8VfUNcOYliRcEee1FrcxDI
	iVPDvX72lbEB0fc52osl9rRARvca0rR8rqDczeULwcDCDAEIMn1O411Wwf/HY09EZjhryQ14Cym
	TsD7Q3AqQcSfvUBe8ry2UO1ZsJfjs+5HU/8XJi2gAnurr67ru1/xU1FfNSH88TW7wezlIW+aHwC
	vz75j4s7/xEjQlgZEzpPX5AiA8sg9vbyl+jNHCVtIOCgC7NOxVaCQDlsl4crDdIrSrGjfXee8pA
	frnhvlR+e4Ngw23EAk3KRRn7BbC5ILcwicsD+U=
X-Received: by 2002:a05:6a20:c88b:b0:3d1:c0e2:936b with SMTP id adf61e73a8af0-3db404269e1mr7176490637.7.1789397709022;
        Mon, 14 Sep 2026 07:55:09 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c615a65bsm5338805a12.3.2026.09.14.07.55.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 07:55:08 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] wifi: iwlwifi: mvm: defer freeing PTK PN state on key failure
Date: Mon, 14 Sep 2026 22:54:31 +0800
Message-ID: <20260914145433.42830-2-enderaoelyther@gmail.com>
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

The PTK packet-number state is published to RCU readers before the key is
installed in firmware.

If firmware rejects the key, the error path clears the pointer and
immediately frees the state while an RX reader may still hold it.

Defer the free until after an RCU grace period, matching the normal key
removal path.

Fixes: d066a530af8e ("wifi: iwlwifi: mvm: fix ptk_pn memory leak")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5bd246e37943..b0c4f245c88f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4385,7 +4385,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 			key->hw_key_idx = STA_KEY_IDX_INVALID;
 			if (ptk_pn) {
 				RCU_INIT_POINTER(mvmsta->ptk_pn[keyidx], NULL);
-				kfree(ptk_pn);
+				kfree_rcu(ptk_pn, rcu_head);
 			}
 			/*
 			 * can't add key for RX, but we don't need it
-- 
2.55.0

