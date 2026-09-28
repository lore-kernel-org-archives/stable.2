Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106A4E66A7
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610220; cv=none; b=Dj43ZGmBy5fZCx6/XrqG/K8wdlTutTuDUHtXU5d6IGAKwvKCCO7xgnUordV+MtKB8zsSLFHzS5eEXJSnrqeS/PcaGOnLP3SDxA4SVlZYssvz3PQXv0vK6/9sqSjOaPlDPOXerwX/Oj2Cm/IlVMNqe0SZvEpXn/oPHS0j2+rGYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610220; c=relaxed/simple;
	bh=lR1OH1Lh86PvSuqYNjDEJkms00P0n+PsbhlW8mwYc4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxSzbZbR0G8a5++5nHv5xFagHq08MxG+/SRGyMy/es1vaFkGr/2stB6yhPOS0obSdG7OmfP+tCkjM/Hamns1wWLAULD1D6hEPWXJ6n+o11gtF7D6t/4zH0fFXCwocnfhEYvat9QZDK8ONegT18/Sc0ykWXletpxkh5DGdKxrRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=perenite.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu24EUgM; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=perenite.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu24EUgM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912df756so25186875e9.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610217; x=1791215017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7u9FRFVW3KTnKbu7qJYW4kd/AKeklPQypIZL2EecgFw=;
        b=fu24EUgMw77G4gE0MwowWsOoxN8LBL/OG41YbOtAm82nEaskdqjFfCYEWrjtQeHLBJ
         j0eA1Zyk8l66/dxIXiTgGb6CPD/OiF0lIMZIPB93PZ1cgNKIRZKIDytwdkrC4MvRBrzp
         Pr0kdUyuxEF4RF+FhrsSe0g6dDNQfsmSjWlgEfu6KmbYfvjqubQz4oC+1EWGEjyxgVM3
         hkogyDGljMj1KHAo4xaW0sFqOr6us5sl8q7G1k9qpNk9ajGoG5lgC377KLF/jjGMR0mx
         MNI7MZG7mi3fkpWLuMdy+tQwA1jfiyNYgQ6ep0yh3BQ3g4C52F/F7g5JishgXzyXEVw6
         hbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610217; x=1791215017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7u9FRFVW3KTnKbu7qJYW4kd/AKeklPQypIZL2EecgFw=;
        b=UEOWJ7MRh0YaZyYpz8Zui1qMMTPntB55nWp6MjpGqsP0qsRamtjHjEQN/HFRryHAP8
         8SO/TsKjdT/GFAQ4c4VFQyh/+RuMxV8MMmBhiN9TtL10qxU35t0LC8Nwu6+bKBdg4kTI
         NkrLHwHmd84fYM+JM48bXScVyGOPtaIi7Qxu+ZsO/4npqFlKr4c1BO6PSdvQkW29HtA9
         6dqaRnTF3uTv6fFUdjqLCmjqQ0Nrl6IAN9ub9/Hi7Ic53GhqGahm/pGyiobJQL+U79xU
         8C1qLr4jVrmjsmIbdHHswWuhWgs0kZ1uc1u22mK9KTlI5+FkS7g0RUaNuCBZsQNHizyq
         De3Q==
X-Forwarded-Encrypted: i=1; AKwUvByGYTkD5+7NUXcbO/elwbzlbO90seYUwsPfD9OlJhN6vYR7+t6uzqxMvEiYk81eP85sXOOV2fM=@vger.kernel.org
X-Gm-Message-State: AFuF++mkJqtUCF8KLX/b+zagFokoPDCKXVvPH8oq7/xfxsA22TYBd+29
	Y09atG3HYY7Sz9eXSZtnySGvmHh4alo5t7mTgQydsZBpRLn8ANtNu7AD
X-Gm-Gg: AYBFou1n95xtmkj5Fjnn19LfQO602MzvFso09voJ9hYyAE3pvJHdv18+iYm41AywB6q
	gycZVqAire0FQaC4ak4x0SA3M6h3+JwwJXkVI/2UQuF6m6viw1yb7wIMVDqb/IyeX3qiGu2BxuC
	2g9TKYVZWEADUgkxsSbfseqrLDIQW08oZ5BiZrdMM/BVPJFw3dSYgXYocEXlQ846aaobLfZCghb
	/CaOcb1++KZ8VSW2tOiO8pWXRZPTN72KyC3aezNGgNYS9I7XBgtTRINrTiilY3JB/Cujj5JBjQp
	5AQWQj3JD/fs2U/bQJUJSpjeMDKBCG39FUjVlXKk3XgQVd89qt0tlK2KCp1eu6NjTKW/n3Nch1O
	X644MFao/ltnBNVzgw6d26z6vy7k02BEZJ7368bX2Vp3q9QW1iipq8WF3gflsc5H5aG4gKof/fl
	T/31fvdKgEdfupieeleO2mRg8ih1/2PhwrKnLLTULe2DdKs4Cda7ImSkJQyAoTJTFkwvlipfZaP
	5mPTllrYbjNWA==
X-Received: by 2002:a05:600c:8b6e:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49fe66f9fe3mr237154055e9.31.1790610216934;
        Mon, 28 Sep 2026 08:43:36 -0700 (PDT)
Received: from mac.net ([2001:861:8b92:2c50:ca1:5b1b:d140:af71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0062de83dsm48611855e9.4.2026.09.28.08.43.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 08:43:36 -0700 (PDT)
Sender: Benoit Masson <benoit.masson5@gmail.com>
From: Benoit Masson <benoitm@perenite.com>
X-Google-Original-From: Benoit Masson <yahoo@perenite.com>
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	stable@vger.kernel.org,
	Jeff Johnson <jjohnson@kernel.org>
Subject: [PATCH] wifi: ath12k: assign device id from the WSI index
Date: Mon, 28 Sep 2026 17:43:35 +0200
Message-ID: <20260928154335.85628-1-yahoo@perenite.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <3cd93e83-6103-457a-8879-bef8521bef9e@oss.qualcomm.com>
References: <3cd93e83-6103-457a-8879-bef8521bef9e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices of a hardware group are added to ag->ab[] in PCI probe
completion order (ab->device_id = ag->num_probed++). The wiphy radio
array is built from ag->ab[] and the wiphy device is taken from its
first entry, so the wiphy path and the radio index to band mapping
change on every boot.

Store each ab in ag->ab[] at its wsi_info.index, which is derived from
the device tree WSI ring. The group order is then deterministic.
ag->num_probed remains the group device counter. The unassign path is
unchanged, it already indexes ag->ab[] by ab->device_id.

Verified on TP-Link Archer BE800 (three single-band radios in one
group): the wiphy path and the radio index to band mapping are
identical across cold boots.

Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Benoit Masson <yahoo@perenite.com>
---
Changes in v2:
- Set ab->device_id from wsi_info.index in ath12k_core_hw_group_assign()
  instead of reordering pdev_map[] in ath12k_mac_allocate(), as suggested
  by Rameshkumar. mac.c is no longer modified.
---
 drivers/net/wireless/ath/ath12k/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 262a204..f43319f 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -2029,7 +2029,8 @@ exit:
 		goto invalid_group;
 	}
 
-	ab->device_id = ag->num_probed++;
+	ag->num_probed++;
+	ab->device_id = wsi->index;
 	ag->ab[ab->device_id] = ab;
 	ab->ag = ag;
 
-- 
2.54.0 (Apple Git-157)

