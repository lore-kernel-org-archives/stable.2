Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A34FD266
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631209; cv=none; b=MT8Bqsevae2dy94amflt8VDRP8x8g72OYOy6hLTpJdWEYdA3CW3r6mEENgNAJ8hVSxEwf4xqm26/+mP/FojyLWiA9NUEi5Tg1fNGY5W3OXLnWOsIgTfGYqugI7tGjBkwOwFnQGEefK3Ce80OKhr5fkhhUPD17l0wiBhBiO5Flcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631209; c=relaxed/simple;
	bh=yQmN9ueNDx7oub64Hh/xzDJO6RCrU+L/hm+XnPcuf0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjMKexfUOQLS8aitnYmN7WRDogu0C9m5M1E6YIYQKqboh6MShWiY6iQXQZV4bkqQhPUvcP0N8xXjH42eEnZ4RNv46L9lKtnINcKZgOiWEhDsr7kFuigy8u5aSwkBZX3yMgEslqU2obr1iQaM82fiV5j+uJQTFmGK8x/7tENxHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=perenite.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=perenite.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887d06c669so2711395f8f.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790631203; x=1791236003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wyL1tn+mP5nVx2w+7Pq20gMgeqZvEvpVrUK6ny4B9pc=;
        b=kDY884NPixj3agEbP5Tw6Bb+eiePCKvxnLrF3rG5yd+8gjUKX6I2GYsUxrUpqM0wkh
         wpiUToz3juqPmvBgMksLNPH9y4N6MUJzMOMkt/F4l+EWmeOXQzo62qspvXXZsyyR3YFg
         o7fi68Qt3UySV0/gmZz2aJ1CZmJKZSysblYQU+gc3xjgEt5KnWZueis5TkdK0UeCAer9
         mMcmZK0EyTIXCpmWnJPf0tSmcwWtOWcbWdxNIBUElNpsFxaXne4MEmFJLTZsrkOaR+pt
         AAoxn8syv73wPcOdxt3EC3/2Ri1S9e8Oo8I9xx/Z5xrU3/LAVzb7L0PLkA84Ml3KtsXu
         Ncwg==
X-Forwarded-Encrypted: i=1; AKwUvBwzneR7bGEFMBbP23dd2gL9B0eqrY+w/FUzXkcrpcPqX3i6+dUkyncHPCQuy99hhfPOlY3b7m0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+/r51SBJ70cv+S+yMgnv43lWsoPtroXt4aH6eMcHeJU457cly
	yQ0fDkd+Eaq0LV8A/RpzN4EXptvCQjwEZvaeS94w4vl7eLSUWlr6hf7/
X-Gm-Gg: AYBFou3Jt2SADG5JL7NRsU36GSchbNsT9sSY4TJmGWxmdbip8UiFrjOWh8PWFZx7+qF
	SolnzLsXtigvyS2Muw1a341OU/N1evHq7prGvgTYoWBJL0dpcO4dZUbt5AzUPnBSgWLWB2wm6Mr
	LE/2ouXLiGVgK6KFUpEBCKbkxICPPM6N11AC+G1LUAFfdu5c/vEdPBbyrikB6N+GGGJM83CujjV
	YCF+Px9BTFtGsHweYgUmer3wgu11+jjgzFzjmsyu6aCh3RLI5JzsBrH8Ie5M0+i7sO2zh2gxqyz
	HN3+zGv+F289XYTpKF3XWmK94OMJSaWG1Rv5xJqXJWeBzKKp9km/RxbPZaliEl1vKN8889ucGNv
	ULJac2cyc+7e5I4Y/wVq7ymqY4lx+xAnmXqSogSEivohQVsLGLNtsKJs0euIdOGGwLAkpJwV2fL
	UuhdO2WrJtoJT2Lr2OWxnewiPCv1wf73CmyMofbR/7EM2WvFimuPYwCBdQVvHSKvkYcWzw6dAKD
	Ri0grO/oQ9YYw==
X-Received: by 2002:a5d:5d12:0:b0:48a:eeef:b4a7 with SMTP id ffacd0b85a97d-48aeeefb641mr1919631f8f.48.1790631203458;
        Mon, 28 Sep 2026 14:33:23 -0700 (PDT)
Received: from mac.net ([2001:861:8b92:2c50:ca1:5b1b:d140:af71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a4e9sm25993824f8f.11.2026.09.28.14.33.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 14:33:23 -0700 (PDT)
From: Benoit Masson <yahoo@perenite.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	stable@vger.kernel.org,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v3] wifi: ath12k: assign device id from the WSI index
Date: Mon, 28 Sep 2026 23:33:22 +0200
Message-ID: <20260928213322.98949-1-yahoo@perenite.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices of a hardware group are added to ag->ab[] in PCI probe
completion order (ab->device_id = ag->num_probed++), which is not
stable across boots. The wiphy radio array is built from ag->ab[] and
the wiphy device is taken from its first entry, so the wiphy sysfs
path and the mapping of radio indices to bands change on every boot.

Persisted wireless configurations reference radios by index (e.g.
OpenWrt/hostapd "radio0"), so such a configuration attaches to a
random band at each boot. This affects any multi-chip group with
single-band radios, e.g. TP-Link Archer BE800 (three QCN9274/QCN9224
radios in one group).

Store each ab in ag->ab[] at its wsi_info.index, which is derived from
the device tree WSI ring and is therefore deterministic.
ag->num_probed remains the group device counter. The unassign path is
unchanged, it already indexes ag->ab[] by ab->device_id.

Suggested-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Benoit Masson <yahoo@perenite.com>
---
Changes in v3:
- Expand the commit message with the problem statement (why this
  matters for stable).
- No code change since v2.

Changes in v2:
- Set ab->device_id from wsi_info.index in ath12k_core_hw_group_assign()
  instead of reordering pdev_map[] in ath12k_mac_allocate(), as suggested
  by Rameshkumar. mac.c is no longer modified.

 drivers/net/wireless/ath/ath12k/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 99bf5cf..6505255 100644
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
2.46.0

