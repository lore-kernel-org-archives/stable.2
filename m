Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E73CCFDE
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535869; cv=none; b=qoDrJAmu40lbpwGmKOovINJl69xNCV8UNfpooB2TgrvPjPgvRljtNY9uOpNGk/rC2DgHgxGXDyeu2YvZxWZDBSPrZxwuNBr9tscSh6Zm4q1DWEghcYsY5XOCZdSAiIpy+uqK+eqF6PkjoHoE8sNkHec0BYDAceTpiT1vAaOHfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535869; c=relaxed/simple;
	bh=OCCuX75TX/03jq2jqV7MjyMtFkPk5zMl0VhBOs0GrWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwW7Pa0zj/ttf+5yzQjo9FAQk+JhzbDVH0Wf1F2xWFvyLnIvYN7jkTR53frZQfYsb0tX/Hrg+RA0pEA9RP+8TSJCpRt9tp/wHo0ZUvSyHFtWdK3I4o4HBSalrWmAZBiXXR8vbw907OGJhDfxEIqtZqlBoKWjO16hCJriyzUn3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPh3N91H; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPh3N91H"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so7948855e9.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784535866; x=1785140666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4HV5tdGDvtX2807flRJDk1RjGtFc+woOgquZeUolgwc=;
        b=RPh3N91HwIbCYqmHgFY5PxWViGuu6xnM4rJ9wZOaklEGxFIuyNMyxaYqybjAyk+7u6
         Iq6cW026z0SJr9PkkeLWeC8H6Y/dYBlnpCkSAKi1Qk/EzpRKx7TYOgurKjK9sYXyQz3v
         Nqzig9ZE+0+hOZ/TwU6QBU40ni+k+t3HHrULbbXs+yaCSABvYn3RIBipN1opjoBINkDn
         46MEl3fZ8dqMCh8Ew170DOxJMoiJIb8tvS28UtojcvgPpyRMoWVzq1JH7ai3ZfBzrM9F
         fvwGHVsmFg48jBYmv1vpY18gz6CcEZ+c1s//ZZZlbTf7sZVw1tzGBXWoScBxOmwcpxGK
         Ge2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784535866; x=1785140666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4HV5tdGDvtX2807flRJDk1RjGtFc+woOgquZeUolgwc=;
        b=dwHYvtyqCGOCly6cah0eMh6QNSswuuag1EQe0UYXBgoBqzpmu07TYu+RgQHl/tN7lR
         FJnSNdQxW943dY4FB1W5HrlfzGf6BhS91NAktVzUFdq6gKvC0qejpncFEKW+qUotmFgR
         7NFyHUD66Wv+j1SBSsBsWeMCqcSq4oVHkg/wXs9VoXp1OHEPGFu3Wx7BvmCwePKfl4xg
         +1ZbEf/ltLwGtIv/eo8kaNv8jlOkqN4Jtz0yNS1IyePItJEhO0mq2cLldIKTI2I2CKr8
         ZUmrgFEFeb+3hzwTAVqDNdAHcNPCyv84r6pnElWMSoqGpf1KnVAjb40mJX/rvrmhKhEV
         oYBg==
X-Forwarded-Encrypted: i=1; AHgh+Rrb3RJ6QEwKXUWooT1VW4Q6s+ufZczd3UsqlnqDqaC64V3sM+q7vVJA0u3S+5M+wk1TlSbl1wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcdumKWGU2cg+/cS4teP6R1yVTJqu1kFCJe29hrQc965C8AgO
	M7x60fgA9k2HzN5xwQCY67Gg4YjSP+zXQ0Hb+Mi543nM+ffiefgrdB8Z
X-Gm-Gg: AfdE7cmldnJZuKULGevO3Yb8XbplEwbdzHZ2QFs3dOv+9c2ERdLMEmewoFpa0M0SJwl
	3snTR5TnekxpmJlpd++YAiNFtRSpH0wCaQlGKlKrDLJn0zIUHtKqAN/+55+pMpw5B0nqa6p3H8y
	nJZtC1ar0ElocFvaniGT9ct0zBzCbNoNZ8I5WvNN5aTue1bgRgUzsElAwZOpF8dnVQZjx8WhWfu
	AAFY8BFVkgSXhbFhiOa/nTwsVOULQ/tLxxy2pqXLYe8iIP6OjfBXL9m14NzgZ7gcBsQb0UXr4Wc
	11/lCP9g8NdwxjZhrE9EgXllFZiXzsLn0HdJjkPpd+lsbMTrG79HXE3Apg90ahnYXfX+BvxtBKG
	+r7bi360hep1QNyUTagjt82uts4Ybnusu60ZxcXU5zsPwPELThmswVvXh1ilsqxVbQfVXESY48r
	MBh0bXX79Od/FrAAGYEiVSNPyoSYKaZ56XboXYY6SFAtzKLNm1bV/k3B6+KViE/R0=
X-Received: by 2002:a05:600c:3113:b0:495:61aa:523c with SMTP id 5b1f17b1804b1-49561aa56admr11697155e9.17.1784535865627;
        Mon, 20 Jul 2026 01:24:25 -0700 (PDT)
Received: from fedora ([2a02:586:e223:fc00:8acb:cd0c:11d0:f2d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f6980582csm20734516f8f.13.2026.07.20.01.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:24:24 -0700 (PDT)
From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] staging: rtl8723bs: fix missing shared-key auth challenge length check
Date: Mon, 20 Jul 2026 11:24:09 +0300
Message-ID: <20260720082409.168379-1-npetrakopoulos2003@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WEP shared-key authentication handler uses the challenge-text
element's attacker-controlled length without checking it against the
fixed 128-byte chg_txt buffer.

In OnAuthClient() the length from rtw_get_ie() - up to 255 - is used
to perform memcpy() into the 128-byte pmlmeinfo->chg_txt, so a
malicious AP sending a malformed WLAN_EID_CHALLENGE element can
overflow/underfill chg_txt by up to 127 bytes. It is reachable over the
air, before association, during shared-key authentication. In the case
of an overflow, the driver can write out of bounds. In the case of an
underfill, the driver can echo stale buffer memory.

The challenge text is defined to be exactly 128 octets, which is
already provided as the WLAN_AUTH_CHALLENGE_LEN define; require the
element to be exactly that length before use.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
---
v3:
rebased onto staging-linus. OnAuth() is already fixed there, so this
revision only touches OnAuthClient(). no other code changes.

v2:
improved patch description for clarity. no code changes.

testing:
Compile-tested only; I do not have RTL8723BS hardware to test the
shared-key authentication path at runtime. The change only rejects
challenge elements whose length differs from the spec-mandated 128
bytes, so conforming peers are unaffected.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a443b3530fb9..a9382dc1294b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -879,7 +879,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (!p)
+			if (!p || len != WLAN_AUTH_CHALLENGE_LEN)
 				goto authclnt_fail;
 
 			memcpy(pmlmeinfo->chg_txt, p + 2, len);
-- 
2.55.0

