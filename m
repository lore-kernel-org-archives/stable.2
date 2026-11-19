Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057849;
	b=wYfjOVcP6gBtUB2CkFM2pGCq1xbHxXDF5XnYyK4jsdQIaqRB3eo0f+d9+buXp4SqX2eR
	 MTNCVdWUWasq5xWWIvWSwKMSPeKXL8za2C0S43P/EbtLaroXv5+XbZYlOpW2be7UAA5S8
	 QCVHz/quQSIfy973s8H2E4PIyIWCt4Wqh/GFn0OuvEgbwlLYtadaoY7FLRka10a0HT76W
	 WhYbC1rY53IYknt3VC5RYzkNOHBouxD0oUYXTkCwkz4nlVyR1XFAqTDWaRe6S8u1ExNHi
	 WceLcStZUa0gbW9INuN4l9Hn0GBoby5ldNiTbTPT+gC7NDs/889NQDgpk7xp3XjZmcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w1YOVY/Doh6e0864P1i6+EBgq5MNuINhZbLgi234zvI=;
	b=OEqX5Wo8hbMHBjYYySTw83Cjds0TXSmxHqoO8uvhjNXg+EgyTqbMbXDCTzSXkisMdaNG
	 nWU4GKq05nCw5P+qlSjHkaay9Afqj1mAlofTcAbBE2QSarL4rVnLp/EMpSMupxazkcrWN
	 UUwBbChG4Y2ds5s/Cc/+c/4lMKf3XVC5if0in913XW1vkbNzkjS/waujHCmHv9GgWZ5x9
	 L2NR5tIoOZfyWmt68jZhpZaxU1akWeYPeFP9gL5pfN2hlq8QuJ8i8TIZb2HId0LhL5M1m
	 uPWAF8b1ZK4RQWqCVvasTD76lDChA+LkSRdaI/7wUXfCLp1r72JPrIAvZuh5IE15t5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OjMOQRNd;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D826B60A2616
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D826B60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OjMOQRNd
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3b4944a0eso1532689c88.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795057848; x=1795662648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1YOVY/Doh6e0864P1i6+EBgq5MNuINhZbLgi234zvI=;
        b=OjMOQRNdJeLJg5azmRkBB5RW5pkDklRxxPZrFuCIDm7OU+S7G0Dg/yw0sCsiyypQOq
         g5xFwpHBQw+6l4NiCO7NbmKg6AneWrbRGdHARf8ZFk4QN5SLNKVuykO2/bTSXbM9n7wS
         PRlHLWhQK7XaCIYZ/4kT7Bzamg1H+6MXS4pSobmIYryDP/dTloLkTJ5ZIc58S5nTyGmD
         kq/s/VbhA0BvrG1n42/nx7ZjP+MPi06M/Uryt3Rvb+1niar2d2c/UA0gIDyK2IF5aI53
         +Rs8tq6Iobqrakn+myFQo+BV/UgeR9tZ16VpC9s5u0UeZYPoXW2jcFOwUO2O2jRhpEX9
         Mp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795057848; x=1795662648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w1YOVY/Doh6e0864P1i6+EBgq5MNuINhZbLgi234zvI=;
        b=d02NCZ8iqeFiIlT/9jAbQgoT4qiqxGbRjdU8Fi3U43gudm6Ph71dbOMmumJe1BhlJI
         nELiHytSrlKTEIv8pQ8+wb7RZxtZNuiVAoSsWX8FqZMROpQ629mIWnKzvAIJqKbDxOmk
         ftBLL/6786WzqQI/vsVDh0YpTSPAOdPYtzDMaGT0urQ9Ydj823onccFeN35tBaz+DZYZ
         Q9G24S0B2uNEh1qUjUDRZYCFrcsS+W1cbNCn9uURpNjjd5yfPIqaEG75v5Ndw5P/DCh0
         te6rYKJD5zaOKLIEOD0x+Bpkbwmcy+sq9WEwzAMrvlX2U6bVD+ZbBxHrxMv1Wzcj96Rb
         wQmw==
X-Forwarded-Encrypted: i=1; AL+hErGj5QNl+oURpd/3syzP2JdZbdg4E8WubMmWS58r1/4Ygtn5EOFNVKJpAv5senuOGLOsthef/AU=@vger.kernel.org
X-Gm-Message-State: APuU4Z84Vn6cGJo/in4hez2bkhJlBTb1KqCVg5+WukLQyQ41lNPvnvmD
	gAkT1yyYeh4NZBtVKWve0OgFb2wrF/ZrfKpmKLC8npxkTo6gfjRHeGsM
X-Gm-Gg: AYBFou0TDtBFN1ooqTTfhE94NfRfiOpspa8IP44orQHeeCDCPrICJjKTMRHnn8D8uKz
	TnEkOCbGdqv1hmVOG5xDVgAo+biID0pCjn7hABDj9/0Iexa1ElEAw8972GKZZtW2cIMA3aki+I+
	zYo9+1NJqN49RARZrXf5R62abMKaNBTTY3mDKzNLB0atIiKEYUYDZEvHC7WW5wsyRAK9JHF2sVw
	Ijgn86R1Vf5nctMEqebvfsp3bmp2IibuKlbAoqabLW97S1lkkAXQAdVKkCC+TpctVvUcRrnXutL
	FfrDZ07r+Tvaw3oeYD44I7KQwyebgL6RYUTYmQLZGMG13+FwA5VL3Cq3EBnSkeHDCSg9NwLACNs
	bBMZ1EAQdboiD/fjn5JtwWd5c1F/x4a+L+K4A1KaFuGpgpFu6XBC8+kUxsz3B4NIUIyZ98gvsQZ
	nVoXKfFaG+/vYk/GTRpw2NSGrryev0L0kswMUPpOpRbKfhFbcYT0HKNILsZ+xaOplqaHHbc/m9y
	gw52CpGAoskGwk5F919nTNyrXrMxsDu+mkx1SvCCWIdtz5B8pbua5LOG3OEWWVLNXh4ONjywYXA
	oLn/QZPin9jqy8j2lWRZFnsQk50iomGtPk1Ebr0sT6UkajteDg==
X-Received: by 2002:a05:7022:4183:b0:18d:5ef2:1644 with SMTP id a92af1059eb24-1b543be5439mr5394453c88.30.1795057847918;
        Wed, 18 Nov 2026 19:10:47 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447f4e19sm15028118c88.13.2026.11.18.19.10.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 19:10:47 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Ding Feng <dingf3ng@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] zonefs: ignore RLIMIT_FSIZE above LLONG_MAX in zonefs_write_check_limits()
Date: Thu, 19 Nov 2026 11:10:26 +0800
Message-ID: <20261119031026.7985-3-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119031026.7985-1-dingf3ng@gmail.com>
References: <20261119031026.7985-1-dingf3ng@gmail.com>
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

zonefs_write_check_limits() follows generic_write_check_limits() and
has the same problem: it stores rlimit(RLIMIT_FSIZE), an unsigned long,
in a loff_t, so a soft limit between 2^63 and RLIM_INFINITY is negative
and every write fails with -EFBIG and raises SIGXFSZ.

Keep the limit unsigned and apply it only when it is at most LLONG_MAX,
as the generic helper now does.

Fixes: ebfd68cd0c1e ("zonefs: Fix O_APPEND async write handling")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 Frama-C
Signed-off-by: Ding Feng <dingf3ng@gmail.com>
---

Notes:
    v2: hold the limit in a u64, as in patch 1.

 fs/zonefs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 319d950..c9293e3 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -399,15 +399,16 @@ static loff_t zonefs_write_check_limits(struct file *file, loff_t pos,
 {
 	struct inode *inode = file_inode(file);
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
-	loff_t limit = rlimit(RLIMIT_FSIZE);
+	u64 limit = rlimit(RLIMIT_FSIZE);
 	loff_t max_size = z->z_capacity;
 
-	if (limit != RLIM_INFINITY) {
-		if (pos >= limit) {
+	/* No file position reaches a limit above LLONG_MAX. */
+	if (limit != RLIM_INFINITY && limit <= LLONG_MAX) {
+		if (pos >= (loff_t)limit) {
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
 		}
-		count = min(count, limit - pos);
+		count = min(count, (loff_t)limit - pos);
 	}
 
 	if (!(file->f_flags & O_LARGEFILE))
-- 
2.55.0

