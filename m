Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D64526AA4
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180632; cv=none; b=ddKqKKZB42Cyy3GEhlc8ycb0O2GYLV1vRZJYzLNh5ErxZlfE8JTWXsRuqfvFhM0mIQ65e3I3qgIdOOqZIk2R9eFwJq8RDQV21SAszjDzxpFhFR5w9HgbXqS6GMqun9wQmJnVX5xQxELqUcZRxT2va3S3OuAgwNhSOwCjntK2I10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180632; c=relaxed/simple;
	bh=8Lm+BvsXXaReExWPNz5hI/lMvmALmH/eMlo5uY0HHb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOIQS4ThmNlLOP6ZrHzHUr3tpCR+/aEyYp4L+AzVqxvjuhmlaMP5P/5JEH91h0FDA8Hp05A5vcECQFzlFC7rq5SXv221z/CLtRYyT/9pvP9cYTx+SY3qW45U/Rf7dsRhc1FuZLWWeWpWCd65X1f4jeZOF1tuY0zRccyJT4dwc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5BJDp5u; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5BJDp5u"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3115c4451c8so24687eec.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790180630; x=1790785430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMb7v1195lnYorqAAf/ft6okD8NVdHVnkQGFUlaPne0=;
        b=n5BJDp5uzQDFYH0OksN83dVD9ljrNOFCGp/h+isXDc14VBYbGwGCwQ/OZTSAc+p5Y3
         y8EBleZkiQnaUT6EXye1KD7TmBp0pquFLiB5XybiIuq2h4A2VeANuSMNJ5ui4XzssBd0
         T6TouiygqeaPhFsmbNi5jVd5rp8WQMU0jJLWMzP/8VlE8gzSvS6fBQisOd2rttezhHQ3
         5tPmm74XE08tLkuXdyavzWh2Q/9AI5oZc5KA2Iqa2AnBBnsM782mbVkWLPY3hg8h51a7
         QFSbfg43JmWo2iEV6ySeZd3Ng4tq1+Q697O11AyPz/mCKwkEmiNzRrlR/WwrklWophJ5
         zHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180630; x=1790785430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMb7v1195lnYorqAAf/ft6okD8NVdHVnkQGFUlaPne0=;
        b=BE/809C9wBjHnLht3a8q/GYl9ZonVi64l/GPIrlgeNcgEQe3A9ikzAQc5tapEZvoLq
         yLq6jRBmFuy1WH3SlvM4rN73PofAhvX27gMIh4j1UjE8trdzpKwUHlkLB+j5tW5aI8XJ
         MI6lC2hOd5kuJAo0Av1D9+JWy0Cj3ya1w7XvDQLKgMVPZAoSGM7ESgiZIvK5po9IajHT
         QCC37fkt3ORV10kFQTo2V8h+Ajnpb/jBQE6tRRmnQVDS9TopX3hM/qE/Z2dQytCMy6G/
         Z5aK3KpGEV3L5263eAPKcfPPFqL0lzCR/PzftPNvMDuKk2RpqtIL60HsZkQ98lvg3mNj
         P2DA==
X-Forwarded-Encrypted: i=1; AKwUvBykNSJvBIWAWboPhBKB3hfjR+71B62Z+I9tpD6j2Ea/Ab7/wbIo/l/1uFP2ASyOc+yGIYmxdB8=@vger.kernel.org
X-Gm-Message-State: AFuF++nmkLEzZLV5RvGi6aUHcou9DY2Jl69PesPj2JxedcU/g3aeEroo
	noZeptlHR7qbAXB44pOQEuHICu/4OYIs6QK1UORRwGmKd4pxGfCZK6uj
X-Gm-Gg: AYBFou3E7NzT0p/j52HPfilM4iNZ8xZc2/JnJYKNBcS1s2GbnE51CMS2QXpr/NScQqw
	72pDca7StZRIjZ7TXt1lam4uxibEd9LZYW73GpE0crADOsFL5iDEpcJdleD66ObNdK1zh0qmSYN
	RJcWS1uMMNzMW9lFQlsfb8NVuKjzjqDrST3YlTfJ//RJP4huMqrDner+TPGs0oYXXqUCxKPzthW
	Yn5FjNn1ri7B0leJc4k/gylHzOaWCpziyPxIKfyY60i/ZgqiWru3xpmGhdxVZFJvp8gcJA+Z4of
	6AhfWf+mt7/3agHO9tjK6vKwVXdcdwUKfroE1IzDPptCzLIg0BYo+aglhLWHNmIAa6zekOhJoZ0
	m785s7spyQd1jEFdwzyu2qUQnnws65uR+ARgitYha5Vx5eleJHku8fsS3D6IN7MvnNxXAbcAVBK
	4l+e1r6Y2cyqTgNmKT4S7K7TBgPPS2uAD4kzGX6xLTci7F0hB9dy+YmZ7llBr1ipYVZYNz3V+0Q
	g==
X-Received: by 2002:a05:7301:702:b0:32e:f6a4:ca8e with SMTP id 5a478bee46e88-33e5c8aea48mr2964673eec.11.1790180629421;
        Wed, 23 Sep 2026 09:23:49 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96f47d52sm8022700eec.28.2026.09.23.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:23:49 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] net: stmmac: guard FCS stripping against runt frames
Date: Wed, 23 Sep 2026 13:23:39 -0300
Message-ID: <20260923162339.1375698-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac_rx_zc() and stmmac_rx() strip the 4-byte FCS from the last
buffer when ACS (Automatic Checksum Stripping) is disabled:

    buf1_len -= ETH_FCS_LEN;
    len -= ETH_FCS_LEN;

Neither path checks that the buffer actually contains at least
ETH_FCS_LEN bytes. A runt frame delivered by the hardware with a
buf1_len or buf2_len smaller than 4 underflows the unsigned
subtraction, producing a very large value. In the XDP zero-copy path
this wraps data_end backwards:

    buf->xdp->data_end = buf->xdp->data + buf1_len;

giving the XDP/BPF program an enormous data region that extends into
adjacent kernel memory.

Add the missing lower-bound checks so that undersized frames are
silently passed through without stripping.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1fb5f80..4526669 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5636,7 +5636,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		len += buf1_len;
 
 		/* ACS is disabled; strip manually. */
-		if (likely(!(status & rx_not_ls))) {
+		if (likely(!(status & rx_not_ls)) &&
+		    likely(buf1_len >= ETH_FCS_LEN)) {
 			buf1_len -= ETH_FCS_LEN;
 			len -= ETH_FCS_LEN;
 		}
@@ -5808,10 +5809,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		/* ACS is disabled; strip manually. */
 		if (likely(!(status & rx_not_ls))) {
-			if (buf2_len) {
+			if (buf2_len >= ETH_FCS_LEN) {
 				buf2_len -= ETH_FCS_LEN;
 				len -= ETH_FCS_LEN;
-			} else if (buf1_len) {
+			} else if (buf1_len >= ETH_FCS_LEN) {
 				buf1_len -= ETH_FCS_LEN;
 				len -= ETH_FCS_LEN;
 			}
-- 
2.43.0
