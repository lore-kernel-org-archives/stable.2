Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D43C8C71
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807602; cv=none; b=qGHHgbBeSMMpMdD8vlPHGBKWGT7ox82izutdGTzVijhT7gu/Fh+tQGE2zKsxgOTwp35//zxoObDda4fTPyynnUTgi+rX+0QlPzoS1HUUbHA05i+QaeVjX4gEFAPuFo6kCecxo8+HFpTnd3ll/bl88GC94CuLUKcHu+GA+JahEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807602; c=relaxed/simple;
	bh=arFlbPYm7CywSdooWtIElG8Uhw0lIp6ojcSzPl0opu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb1bfjMeg3YJEli1zCqtT4AxkUv+B5GrHAAN8PrQHaRxK1QplO3P3x0dutIbzY/WkVW95Z9V1n7VpB3EOoSgHbBXPAR4BWCSjU4esaJJlhGbZpGy3W/epi2+lVv9xkUZUm2agLcBsCESutMtQh/NSFYjHzQgc6N/HrxMEgCRrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhbR1a9/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhbR1a9/"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso1144220a91.2
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 01:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807599; x=1790412399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cGgh6mToruw90OrmnsN6FArYwYB4sA0gjGVfllF0rlM=;
        b=UhbR1a9/yIRZ33bwXTlA7JVPTPBwuvhW3kN65l0zYBnY3HDC7VJ8n7lSh69JaQ83hX
         Zzb7rZ9C3YQuDQ0cTuTiKYND1c/ncOUM2u2/9Jcbujh4feO3DuBAMsCNG+7RGGiGK1Ue
         53vF3LFuHS3Fm+GYujQ2OoEMimBAELXgq33wwBoPkoUWldSA0fJX4d+v8+acRrteVbSk
         g28D7TkkUboXqGqzzNljsv4PKA9136ygHwIgMHX8t8fvQNhlpTdFUFyCNlXKVaL+foAf
         kTfkm/gycF6548pJw0Lr4VSFluE8ejaWeFJo8P2U+mMGFfoNXyZD4nWomSZ70EBz6LYA
         hp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807599; x=1790412399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cGgh6mToruw90OrmnsN6FArYwYB4sA0gjGVfllF0rlM=;
        b=GCHDPj2DX3E+6OrkEH0nmRl0F7VsACUwjG882n4uHBRwpDgxmC9c95n+iyYAAb18Bf
         OcShgRe+CKIPz7pH+p6IdGDa/SxextGjhIZdhBRkTlxPZbLJApwPfI1tAl72YZUvS6Uc
         6vOKD9nUW8ObiTgUQLxAi6NUv6Y+GVsaYhyjdHjAwAbysw1NVOy+m2d7Wy7iisO7vRfq
         lBoNnvn0JU0/UqzzvweR0y90DGYs1oWgQfCP/2FUzpjYeS4ncp8DiZUO9fJ4OVp8BOLQ
         kDpw01Y+w+ws77SsZZ2lywwqxv1Kdh2FecPuanQ505zrHXy9sW/c5qDuSenw9C0ly8eO
         x4CA==
X-Forwarded-Encrypted: i=1; AKwUvBwyENmu+uDt68pS3rgPWZmfVTdsMubBmNaOdzw/7L3hBXV2c8sKosaxsm3Cx2lJIwUd9abkEBE=@vger.kernel.org
X-Gm-Message-State: AFuF++k2G+6wsf9DdldANBKrCo4nhwmPLVWUXunJYm/cvOgXQaDrlQzu
	2N235XIOO9zA8Ik8FZmchScg4w8OeCNiwrWjWYAd0EGMldxQnAtUisltRFwDgUWLW+LcaovD
X-Gm-Gg: AYBFou1wuvRCuR+yViBpNMx8gOcHkYBBhzPa18CsUc6mtWUgkCLuOJC8iz5/apNFX9m
	TDz1GICBikhnJcvjOsxG2HOX06hmRq3BlT3pYcGESjHJBV93UttwZihcpVWXWodcwSHonvuWCX3
	oyKOpOFcVAVcr8jWoIl/xZR4M74kwjsNnDJAHElWv2290uMZWoLjH697IZVGOCFK96Fz0YQawjP
	5bdqf/i+hoIwzqlOMiV284BoRkmhpFbsYWylxrKTLaMbIES3bDDCKk/pnDfDUTS6o7Fmz8ldLUo
	l1rLpd5QYjxvCWd1Z+uPRA0y0OO8CqHmwtZIs8qa5lBWv2N3BmGM/cyIgEmmX9NVzKywFSE8a37
	II8ElH7YQDdnDhyP+ITLcGLIGmsVbcJ/6k0uOzFpNP5GSEAj7BwtzEY3Cj9ZN31CLsfK3qdPxjj
	5zPrPBOxMpucRjEVRHHbcnkErS6rkFFz1CtjBj/pP9skyMm2UYigFZpW0muI1vw07B7HgUSDiiX
	7nrpiHI5UcQg3xD2d+7LTonN3qjAUQwd5Yxh3FKAU6BH/qeCdkUwqvOcPJKayAO9z3n4eOl5f/4
	S10r
X-Received: by 2002:a17:90b:4ac7:b0:39e:6c6a:4b6a with SMTP id 98e67ed59e1d1-39e6c6a5812mr2736249a91.52.1789807598562;
        Sat, 19 Sep 2026 01:46:38 -0700 (PDT)
Received: from lenovo-thinkbook (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6fb75539sm3121039a91.3.2026.09.19.01.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:46:37 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"John W . Linville" <linville@tuxdriver.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH 1/1] wifi: mac80211: minstrel_ht: validate fixed rate index
Date: Sat, 19 Sep 2026 16:46:20 +0800
Message-ID: <288e6f6d30dc82ff40da502755e6666982f6b735.1789798000.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789798000.git.xuyuqiabc@gmail.com>
References: <cover.1789798000.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fixed_rate_idx debugfs file is a plain u32 attribute, so any value
can be written to it.  minstrel_ht_update_stats() then copies the value
into mi->max_tp_rate[] and mi->max_prob_rate, and
minstrel_ht_set_rate() uses MI_RATE_GROUP()/MI_RATE_IDX() to index
minstrel_mcs_groups[] (42 entries) and mi->groups[].rates[] (10 entries)
with it.

Writing e.g. 65535 selects group 4095 and rate index 15, far outside
both arrays.  The out-of-bounds entries are dereferenced and updated as
struct minstrel_rate_stats (retry counts, etc.), so the invalid index
corrupts adjacent kernel memory.  With CONFIG_UBSAN_BOUNDS the access is
reported as an array-index-out-of-bounds in minstrel_ht_set_rate().

Only a valid group/rate pair, or U32_MAX to disable fixed rate
processing, can be used safely, so reject any other value when the
debugfs file is written.

The file is only reachable through a root-only debugfs mount, so this is
not a privilege boundary.  The out-of-bounds access is still a bug that
must not be reachable through a writable debugfs attribute.

Fixes: 24f7580e852b ("minstrel_ht: fixed rate mode through debugfs")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
 net/mac80211/rc80211_minstrel_ht.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index b73ef3adfcc5..c26221287515 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/skbuff.h>
 #include <linux/debugfs.h>
+#include <linux/limits.h>
 #include <linux/random.h>
 #include <linux/moduleparam.h>
 #include <linux/ieee80211.h>
@@ -1947,14 +1948,39 @@ minstrel_ht_alloc(struct ieee80211_hw *hw)
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
+static int minstrel_ht_fixed_rate_idx_get(void *data, u64 *val)
+{
+	*val = *(u32 *)data;
+	return 0;
+}
+
+static int minstrel_ht_fixed_rate_idx_set(void *data, u64 val)
+{
+	u32 idx = val;
+
+	/* U32_MAX is the default and keeps fixed rate processing disabled */
+	if (val != U32_MAX &&
+	    (val > U16_MAX ||
+	     MI_RATE_GROUP(idx) >= ARRAY_SIZE(minstrel_mcs_groups) ||
+	     MI_RATE_IDX(idx) >= MCS_GROUP_RATES))
+		return -EINVAL;
+
+	*(u32 *)data = idx;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(minstrel_ht_fixed_rate_idx_fops,
+			 minstrel_ht_fixed_rate_idx_get,
+			 minstrel_ht_fixed_rate_idx_set, "%llu\n");
+
 static void minstrel_ht_add_debugfs(struct ieee80211_hw *hw, void *priv,
 				    struct dentry *debugfsdir)
 {
 	struct minstrel_priv *mp = priv;
 
 	mp->fixed_rate_idx = (u32) -1;
-	debugfs_create_u32("fixed_rate_idx", S_IRUGO | S_IWUGO, debugfsdir,
-			   &mp->fixed_rate_idx);
+	debugfs_create_file("fixed_rate_idx", S_IRUGO | S_IWUGO, debugfsdir,
+			    &mp->fixed_rate_idx, &minstrel_ht_fixed_rate_idx_fops);
 }
 #endif
 
-- 
2.55.0

