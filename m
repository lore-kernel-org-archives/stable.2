Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028444;
	b=mwJ1/kREgwp2+2H8ux5EwzRteeRsgPtMyGYtOSFz2fbCS3xdq1O+DifwszViQdoS9+F2
	 wa0sq+VgP6O7SYjouDOqn/6tB7LDIGJusp7k11W0RgV2X3phbWD5nw54lLQggAIPD6PBV
	 417RpBG0sFQl2MXkd+qg4cNNQaN9CKTq2uvDj8MQpkKOHvFpeOfNVdcEG55k26p7Lfy/U
	 d8eDggzjj+QHpLQxil3/sckjqW3zkgXau9opwdg2com6U6G/SqBcpiPaRXJcvee4j5nFQ
	 KXL9d/uS3OQmFfbQLLkk1tSyrwK6g5140EMukvRZbs129TLIQZMcfp0cYlMyuGiW6lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=icXw5cUiWlz5rWfTUQ0wOJr2LvS5fa2INLJ4qgOPSMo=;
	b=ZfSI4MJrvWzZdtCpfMYKuBmzaZ4EhpxkuIhkjOR8nFFAiHDDfR6gstoLVKjYm0YNkD3v
	 qoktGEaT9n9e7vXh0eTkRYbNqO4GhU0W5vNVEvu4HEtfJy0CW+nMLXthElSAX92sfvVOV
	 9u3qZIhydEN5wCNLyDu+IpGmTmi35W9QHlugZ23hQzAztWnQUTBMg2cPhi6gvC6UNtbM9
	 QTNXn4zHqQryhs+/pM6LwbYBdDh8pNIh+7CnoIPTursINHwZpOt6oe+bW2s6V9876roL7
	 Qy6shEhHOB3hAxNfvZ3YeTJpxR6fa3iQ3kbIoO8rewxHjJU7JUU2A+rznv23o2qjcbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bfsCPrwm;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C699F606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C699F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bfsCPrwm
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9d1114320so23877475ad.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793028443; x=1793633243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=icXw5cUiWlz5rWfTUQ0wOJr2LvS5fa2INLJ4qgOPSMo=;
        b=bfsCPrwm+ad4L4mOecEHO/1R2ve1iTljR5+QR4t0AqvyTBRIQD4Mfibr3x4ot/3eeq
         wpoU5e1PgwnA8c8fizuSC5ZjSK3A7UZMBujw0ALSFHQXwzvbblh1MkzlXARBAUFmO3fF
         u1Erz+jTf1JyqpEq77jeELaRzGmrAhSsAR8cZ9FPl/jUWGTsvTfZHG7UZ4O6PRE3WwTr
         RiWy57QzMtL32Cs/vrieWxyluqEWuKkWZF133QVLLSyiOcxQ1T9p6mkBgeXD/GcU4FbY
         6xcTAdmHWBJIeIgHuZJIcnZOhLSKPYFO5dIrOmpU6AFsP6CUJwFesWyW1MWgy9QaDmRN
         FOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793028443; x=1793633243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icXw5cUiWlz5rWfTUQ0wOJr2LvS5fa2INLJ4qgOPSMo=;
        b=2W6/pt94X4jacwtiyfrZedFUKdZgPwd//FmpCTn2bu0yp1RI7lSNpcgU/qnqJcX+6/
         WrhwMPiZDux1XRB+15FO1FYrW7i1p95e3DRz+RTmCuGHvWSd/pLN3EnINNT9tsUfWm9A
         jX6TVpW1L5m//GGPxijiulwFFCLaj/HKID52ib70AaQmtfeBnZrDNAF8qoZZumJrrZA4
         iBkWlmuynbqSloKIT/Mrqn3YifbGEo3olmMZ1L6Mm9Z9X52wqhRD6cDPvWA/bUES/Uyu
         d0kHRjSeYFwiwjczh7+9ul7fgjsmgRHAgTHFDaUslztmFN4NBzHRpbJwv1do/3iP8Fz/
         IqQA==
X-Forwarded-Encrypted: i=1; AKwUvBzkGF32iRlSIJSTO/T4IoCL4gZsMunznHFqKwLYPJiyFBgl9Zl1J6zJSIfBiW2VMLrcfUGU61k=@vger.kernel.org
X-Gm-Message-State: AFq9FYINcC0NF8SiIfCxPKj2m8ab91pFQE6bFMlguDpyXxboQrEwFRYe
	fSjTQBvs9NLQDhtjM1rnIg7H0By8B6RsstkN/Xh85+hTthBby4a08Asm
X-Gm-Gg: AYBFou3ZY7YndMM/UiPtTRxCH+xgCqZcq7Jzqdd/Qer/7h/KgsXkU/a7FmoDiZXoCxT
	EvJzV5YHpqVsnxB4O8wLq3mAtDavlCC25Nj96c/L+xxF93bMtm7X30+tAT9HlFWyte5/K+KkWX/
	2zjWug2AJM08Yz+ttTSnbAVmCZhAO82ftplhWiRxVY6OfuVsGRUsFp1vlY6tgioK4ez7aGIy5XE
	LZX+pQx9E9GbUiETSEaHTghJWjSHDKCA/pKUX8IY+pADK5uY6KfRSkpbsGEYzLc9CERU4E9KxQP
	STgja1cTIcj71FOzXzsUU1C78GSfGwIxzOIXd9AlhiS68mIJDag+VtOSmNkcc4Tt5W9NAuQ09Ub
	OnagEMtB7lFLMzMve9C6XQsitdKXZA0IgPApiPrutu90x7sVb3Wi4N/mi/5JyRhs05vHszcDF1u
	bdhnVjZ6KOT0VrR7G+wiWl63KgwzzFLyk0VyuU91olU2vf4V4s4TuVNTOEj6/7UYNNcJiyU2mBy
	+EKAt9YyPUV9ng77zoQGIHY1RXdMhnioHgSOjmtZIQHPgjtxEDcqPvmQMRLx67mAQ28RkXaIC0G
	P0pvZ+lIpO0i1aqQUDYC4g==
X-Received: by 2002:a17:903:234e:b0:2e9:7ff5:545a with SMTP id d9443c01a7336-2ea9c67c29fmr66184465ad.32.1793028442579;
        Mon, 26 Oct 2026 08:27:22 -0700 (PDT)
Received: from KRHW1CJW23 ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af32085sm18713105ad.2.2026.10.26.08.27.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 08:27:22 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: fix use-after-free when MLO link setup is rolled back
Date: Mon, 26 Oct 2026 23:26:54 +0800
Message-ID: <20261026152654.80697-1-enderaoelyther@gmail.com>
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

Rolling back an MLO link addition can free link containers while RCU
readers still hold pointers to them. ieee80211_vif_update_links()
publishes new links before checking for duplicate addresses and calling
drv_change_vif_links(). If either fails, it restores the old pointers
and frees the new containers without waiting for readers.

During a non-MLO to MLO transition, the published link 0 replaces the
deflink, so existing link 0 users can acquire the new container. Readers
such as ieee80211_csa_finish() and
ieee80211_obss_color_collision_notify() can also queue work embedded in
the link. If they queue after ieee80211_link_stop() cancels that work,
it remains queued when the container is freed.

Wait for RCU readers after restoring the old pointers and before
stopping the new links, so their work is queued before it is cancelled.

Fixes: d3e2439b0f33 ("wifi: mac80211: fix link manipulation")
Cc: stable@vger.kernel.org # 7.2.x
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
LLM-assisted source review and patch preparation.
KASAN test-tree harness: pre-fix 22 reports, fixed 0; wait after stop 22.
Sparse, Smatch and driver-failure testing were not run.
Older affected kernels need an adapted rollback hunk.

 net/mac80211/link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index ce1c95b40cd9..34d313a2fef3 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -401,6 +401,8 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		memcpy(sdata->link, old_data, sizeof(old_data));
 		memcpy(sdata->vif.link_conf, old, sizeof(old));
 		ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
+		/* drain RCU readers before cancelling work they may queue */
+		synchronize_rcu();
 		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 			ieee80211_link_debugfs_remove(&links[link_id]->data);
 			ieee80211_link_stop(&links[link_id]->data);

base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a

-- 
2.56.0

