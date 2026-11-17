Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936743;
	b=0jaqgcOWbKLf4NSbUazSlsiI9PVau7OhHY3K2pCnmQxc0u1+wf2menpTXLRPNSLfbLhO
	 JQV1jAAWov4h9A7ZlUyZw5p+WdZRAcTT9hIWSyfrjHPlxGfZC+SAoyWM+fK7isX/Yq/X7
	 ESIw+BlvEIrSJ6sZtA8Bw2aAGzFml0rGyZgPxbzqO7VWICv3YaMiCbxGTQz5kLlk5hEAG
	 raczJlvrzW2zkZZ/S9kWS+gkDf1hN4Sh/5EWDX2xnX1U6GcXU7LdpWIXFgCwc46Dr7ZUe
	 x9woH/mR2ZjB9ScQTU3S2T+faKFqRA46rx1UdPF7k45/mZFwj0gR52i1XLJQ3V2ZIYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oC4Xm4Ftyd/KVEfH4kMfevGPXxcxUVZ8t5slQlGpuNY=;
	b=Y4k4CEGyMOnHD2Gq9wVQm15ts3JV6qSHHAMSuZQ599E3Atl+7EczffdubGWnam1hy/Ef
	 yNUyJQJhBOjQb/38Xt23njZapFMWZAQP8AEx5BjPOUbcfz/GffEXrn8G81aUpc8ava7Mk
	 KNJYEyrzUZu8Zjp9ZCp/u9/RkxJahoq2xwV4+DA1Bo7GW5XExleGGjidW6xUwLFagmnfp
	 sHASiTfOOtytc5bUAdOqPK7HBaElL31WBkvHvR/rE2/lK7yeBVfTsO57pCrgkVyTTL998
	 ArBbmlyUD/hLTt2vvZltXqrsdKbX1A+5LzjdTWgpYbhiCl64Z5cbVNVa+aR2G+KtYBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4yH0jhH;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8C606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54E8C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4yH0jhH
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so112534c88.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936742; x=1795541542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oC4Xm4Ftyd/KVEfH4kMfevGPXxcxUVZ8t5slQlGpuNY=;
        b=x4yH0jhH3nyyevBqTucgrxPsS9NXT498DNNe5pZLBy2rzBSWYRfUT7EVniWtQ7BSzF
         c6dK6mYKzpk2s74lqd6Acw/Kgz1yfLE42RUEPs5NxCEOIKWLDEyfFPlXCYEaxIYvVerF
         faBhvptbOJoUoDKrChD7RWrRNUnD5utZng6GBYFjR3cX7e9ohqIS0QF16hV8tosHM77V
         RgC/iEBtlhnJsTSijntRIUwTBwyMkwjKiy7XbXWsp9sKWYu27dDIXoQQ+BdfPpXSuwII
         m3bKcC8NcFiNT9tm4SNd740HctImZV8HstiLhIEo3SOVqJs3JoE3j/hSU0AZ6cKYf65z
         UHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936742; x=1795541542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oC4Xm4Ftyd/KVEfH4kMfevGPXxcxUVZ8t5slQlGpuNY=;
        b=sLKNUrocDSrr9bGbcu7/HyryZAf72TtPvaS35ItLriiOGNkkHqYwh884b4jeuwAh4W
         lmYBhphSyiMAGvhlcXkwIKb9weqnd8mUqEZLAX5KWna8yMr5UUeBX0931D0iE0W9XPyq
         ADo5AfgyhCP8RQkbvvh+4/riB2gKhRwGdq82XQ0SQM5iA4JphgN5jD4PjpWf9lL0EbCW
         gADfcnIWS2zR2a45UIUoN/gGnDcFNjEOEEZ4/TgRieV/0zn1H8UsOhCFzD0yd6klUu5j
         6Votdr9zqa8FGpYii2ASy1sLMVz/ohEXz5DvHQYePBYBcUdd1RKhpskoaWEpZ83PBZww
         H7bA==
X-Forwarded-Encrypted: i=1; AL+hErEEfQQwCj7rwP0fRfSySSHh+tv/n/yXDxGjSW+V/AOO3NJbZvr3zabD+gDdDZ5asRYWvtsJkTI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8K46WOwpGOBxWG6SFaLrnte7JTwUV1rkYCvWNjK3CAlfJ6g1oL
	H+xZtENJtNoUT26Kle0hlMiCZgzKylx/2CYjurORGXlqChSj7YhdOxTe
X-Gm-Gg: AYBFou0bxxB74YYLGaDfL+USxHFOy0gx2UQeKCZAHUQnSnQsjuQFAVruf9CnWsnMROk
	zQwVSNUaGFAyM2kl9nLP+to313PjLc0l3DJBGnOoMPQEiZAQWtLHywOPxVMNVvFWmcXrr0BiFNi
	cnnxE91J+8dH/zo2/mqUEgtUsoP/JRk2wf08YY6Smwwa/uR0fk1Ksm9+f45oUvjr1kZ2Gx6mmkw
	6Zze5fbUSo0BbCupWb3Mbaj3yV8K2hV+XWGHxphFt3+mFY+3rYPtdof39/YTA0t0fUIEENuroN5
	9siYe0OCb44mP3sGFy/x5q7y/TLouXlfxQBi2gM0lp6V8/gCV9YToQY2NB4Tk9G6r79Mospqo+p
	ashHW/p+E+wJa4edISiIgyW8mEX9Y+j6kMslNchzaOtvxVbyy9ZRJcFJij9/9vdFfAOJ74tcO+3
	hivyczZY5MGVsT7iPWA5bZvs72SPlhCEugiy54qSNEZT/hjDRPFk36pCmtjgt9GeHDa4O5HzP29
	sukxtM8Y1P8RQsyJtP60ZVHpF6hAwMhOoFeIdfBZSYRJCIHov+cbGCa+8fjbNotMfoqlju0zPqt
	fjxcTAQ3gfFr+rSTjEvMtzPvioeJ/JEDqM+8kDuvQsM9ng==
X-Received: by 2002:a05:7022:b0c5:b0:1b2:4cc7:7db2 with SMTP id a92af1059eb24-1b543d5e983mr212080c88.47.1794936742350;
        Tue, 17 Nov 2026 09:32:22 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm43450247c88.11.2026.11.17.09.32.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 09:32:19 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlemoal@kernel.org,
	naohiro.aota@wdc.com,
	jth@kernel.org,
	Ding Feng <dingf3ng@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] zonefs: ignore RLIMIT_FSIZE above LLONG_MAX in zonefs_write_check_limits()
Date: Wed, 18 Nov 2026 01:31:29 +0800
Message-ID: <20261117173129.61028-3-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117173129.61028-1-dingf3ng@gmail.com>
References: <20261117173129.61028-1-dingf3ng@gmail.com>
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
 fs/zonefs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 319d950..ea9582e 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -399,15 +399,16 @@ static loff_t zonefs_write_check_limits(struct file *file, loff_t pos,
 {
 	struct inode *inode = file_inode(file);
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
-	loff_t limit = rlimit(RLIMIT_FSIZE);
+	unsigned long limit = rlimit(RLIMIT_FSIZE);
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

