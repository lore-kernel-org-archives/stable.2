Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197072;
	b=aNUWM12UonNrtVyHgFWcYoGHkWb0vsEcKH4nbsjou+Rg7UqwlbdptrpM9ZsnWzDpxt9S
	 2s7vpPk5p/vBroc35XrMNjlvX5WZW67rAB69WFa7NE5Z5t7aQLQTGDRkSK3Rx9DKFH1a3
	 PnGemYN5kjDRRg4g7/3PKxADXcOkwVJXqcyfMMis1u0URAZEP4xtDMq/xyqZuhmmVBs9l
	 hK4AuRnG3SDbTjBz+HrSqv7SqwAyEAUUgTG/FLDgmmi+XYgO2EzvAXzyhTKsITemb9vZE
	 WH7fgBA5dFsQCAk5Y1LJ+jvlE4O2F96xUOz3ngvhFFEtlYccvSZqTQcRgORQl86nJoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TQGM9otKFbe0v/ZMqO3QRr7VPtgpLnjAfvMxrL4LM9E=;
	b=W1paCt2RJ5i97msXjzTWcjGTuO9TpzVbD48cRcAzbS3MLAOd0fQSb8PhInTFJYmIdUSX
	 fP4KahJ3YSGtzW9YL+Hf4gEJZngQr5UYpOr1u68xdBXISRn5159E9oAnHNYbNma8cqCM2
	 KOtNB4Pv37bm7RYJHnAUkEENyAPuO6jqKFTvCOQ1Iryad6KjtZETy0UDv5Q8mtDMu1UZZ
	 Y0Pv5L3kUzdRyg79yD9laL+gfRFXtUqEIacgWdPUNceQGAVpWTRZOCyezaoxQg+Q01xZh
	 GmagHoMcdgQLDM9GHfqRYLKbpsmPY1PuTG3Hc/onOPDDe5CpYpLrUUKYebQ/teZmEIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tpKoM6jp;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EA606A321
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 996EA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tpKoM6jp
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so474674a12.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197071; x=1793801871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TQGM9otKFbe0v/ZMqO3QRr7VPtgpLnjAfvMxrL4LM9E=;
        b=tpKoM6jpGJRdzPveFMYHzJVSbJ48ERnNDwLSEnp9gQ+hLWhvyR8YDV1noTRZL7W6zt
         ZoJRmhMyMfBLdppluggHtQPzYwLnN5El+UkWKxSTjL1A5ui+C99UhDEvpczuZbmV8kzD
         3l1KvipLcIa7+yICyE8Pi694UyQtglAfGBwOEbD0+S5aJV6IJ+0XmQEB3sUDgBSRHLnw
         t1In+xUy5j6IjFGUAgFjoGEb9H3DhbC6mB5hmo67Zzu4iEEGesct/5g248hu04Nm3HEq
         NCPAGhX+atRpuHybq/BCkIcNTYBuDM2R9P81c8FfMeEwPzZ93Uc6LhAqEqLsSssBR6kQ
         VsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197071; x=1793801871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQGM9otKFbe0v/ZMqO3QRr7VPtgpLnjAfvMxrL4LM9E=;
        b=rn2/GUzN9W+pmB7DhvyWRuZNTyL85lV3bHUFFLk0Edf0kV+Maps5+setsOY2esjXik
         toXlRignoe8cx636ROmp54IBmyf3MnBldHUz3vNN2xUeCw8jpuSEsh4gSy4gK16yhH5G
         1oOEdTnV6pHv/QrQrvwM+8zkR+d14HbVJ5kxdT1FBJ56RVaKYHz0Q+w36ikyjkTa/j0I
         SIEoe0AmKjuWQ3xiXrK6NrU3ZlrK6r8KB6uXEqUNeCED1RlZ9u2kbxEu9s87vGxeB1gR
         UbQvSUA80HwRWIsbXR9PTM+oupZTv1yVH3GTj8uJTL4tFyy+uF/F4kAC6rr8BISQCehE
         n1Nw==
X-Forwarded-Encrypted: i=1; AKwUvByG8DetVQvT5E1vGdfKLOxUx95pxomusqahMhDIMoypOXbi4lLpY3SCE9f9wCPX34NRsJrn05Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJD6Goi/SQoy7sblrcAl1OZzPwVS7+VEIfIsHdg30KeRvFrvJyw
	MXo2PX8qsZyjPCuviHnzjzxDRJpn6gfknTAf3U4ZFU7oPoWCxbe82NdG
X-Gm-Gg: AYBFou0MthTbOfIPIi+Hp66v2mb1OmGw0R7wJ/noDgJCD2jV6MK6RZzFIJGGEfiYvfx
	Iw1t5xG7/E8W/WeWAn66OjwKMtepmQoUEBwHEj3eagTU74MH79jwcJdNR0ElPjG/B1x2zDF4r9c
	X/LLjQ7NOm+Rkd7onUlfW8KL6TBHfslMj/dOjDx6yEaeSZKd1Ed21dAB4Yf4L8PD2ui3gtUv+pT
	iSQVQzjA+R1nP2tf1Cmdx7DvHuu9ks1bwh6Bx59clF0PgpX43flVG+GNXXofvkP4mm0VCDbdE6J
	Hr+pKCSNo6Xptj/LgFFbwBwv/x2nZ0mxLK8f51axobJUv6S8ohn7KlGOB8nnNZy40uSyFu05DJK
	zSnc6DKwXPKdg8w0a+cPDppC5gXHRHW5aoJUKETtBWmK3qc+VEB05ei4qLnOJq0Pv+eaOpndOJF
	2vkbNdZqJr1FwRMz9s8vEFNMQO3P4A6QbgXGlkMNTdcEhqCoGeg+KS10gpb5OxYuH423Rwd37VS
	j4jxDbjWCoDzNUGJfZcdpNZTzPfYofXJESYNr6iJnaizu1qR6YqpG6HXEKYSATdCs+WVxHiub3t
	ZyqCHVyAP79OBfJgsVHczpgaZTsHgFih97XSrontlmHoMrO3SrlVrFGoCwenDw7aNrRcFA==
X-Received: by 2002:a17:90b:4b0e:b0:3ac:85be:cd56 with SMTP id 98e67ed59e1d1-3ae57f9b343mr1819072a91.12.1793197070417;
        Wed, 28 Oct 2026 07:17:50 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a5839besm3288028a91.11.2026.10.28.07.17.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:17:50 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: release rejected nontransmitted BSS reference
Date: Wed, 28 Oct 2026 22:17:31 +0800
Message-ID: <20261028141731.6185-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repeated MBSSID reports without an SSID can leak BSS entries outside the
scan cache, where the BSS entry limit cannot account for them.

__cfg80211_bss_update() returns a referenced BSS. If adding it to the
transmitting BSS list fails, unlinking drops the cache reference, but the
caller reference is lost when res is cleared.

Release the caller reference before discarding the unlinked BSS.

LLM assistance was used to find the bug and review.

Fixes: 0b7808818cb9 ("wifi: cfg80211: fix BSS refcounting bugs")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. In a QEMU
guest, 20000 rejected BSS reports retained 589--594 bytes each before the
change and 14--19 bytes each after it; the transmitting-BSS reference
ended at 20001 and 1 respectively. A reproducer is available on request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 net/wireless/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d35c826c4b1a..36f8521f8d60 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2452,6 +2452,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 		if (cfg80211_add_nontrans_list(data->source_bss, &res->pub)) {
 			if (__cfg80211_unlink_bss(rdev, res)) {
 				rdev->bss_generation++;
+				bss_ref_put(rdev, res);
 				res = NULL;
 			}
 		}

base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4
-- 
2.56.0

