Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157108;
	b=DaxKh/+pBubpQPr65UW81RcebF6sHskqx/VFjay5GBrumCOhfm7rb4HU4bmFQ8jLntN/
	 UMBXvPXStJGQGjObPuWWVInT0/QjtiE1nuK3p6tEXixLPzYp+H1hpV9xneMGziWvppibY
	 DseO9yHdyflVuEjUv36x0Wn7+Fb2tQ+N+LsJ6Hdcr7YfFITLLR9rRWnM4fAD+pSsfqTj+
	 F77DZpFN9rlstuvlA//U4W/BIQ6wDp3gxP7YS4yvZjAeJZh5m37qiylJUnPu9Bu4cKfWh
	 XY3+diU16IqRFDanGO7Vwvh+2vN7X+IF1eNHSKLTNIZjElOV+NVJZFVRXvJIrBfIZEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P5/FgJx6xQuodGivSipA+H8MZrv95a/oZ5kRZw8SEv0=;
	b=PZ5c5SkLEAQYOOZTKWndF/HvJYqlQDuJ0SLKyOkPiU1rNCNK+CE9on6ajcN4WmCJt6gE
	 ufCaycWKcaXoWYuAJJAjXYudojEBemTi10l44Z6EwunBB3vXJltIQ+fOaKpR0LLG6exU8
	 FescChSLcQ89oSOfklY7R/tqObKT+0VF49Sz46uDKK5jFEeHnmjkudtVD98wJ3TNn2J/W
	 M72krEtFwPNFc4CEliYzBHxmI5Mlh/63fDiSkUMJN29kCCMiBwnJoanMizm92vlaDxpL/
	 P16TgYLs6jI1FO6Nrc5U0IRVV4lav4wiNRtZtnby2/889oVo+BwSoQmU/AKWZ+B/LpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QkdgHZGm;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2B606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 16:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63A2B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QkdgHZGm
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b244fb7fffso151124c88.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794157107; x=1794761907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5/FgJx6xQuodGivSipA+H8MZrv95a/oZ5kRZw8SEv0=;
        b=QkdgHZGmSsLi5ADkdkJ9VZfphXO5ZbhqbbOTHZmnn3V16q59Sqq/9yeP08PK8xQBVu
         lqQ/rYuLmooHGpexNb/nDvltvkMhII+oy2PSdd+2Rf35Qa099JW3NWfAZ3M8qPBGguLQ
         HtfaOuG+z/u2JGJKHCeeehp/6M13qed77999QIXuA3kcgKgFGeoKLjdbGj9IsuOH8kad
         mWHU9Bz6IK9QzgC8Pyxj2XU64RJNjGfwq/HwhG40TX57zn1I3P70h/LNH3tCIuH3OJkL
         16IWUuUVvAFrR5sW4J5FHdUdBoxLW6zTIoo2f5poG6QAM4C2xdAj2aLq90mxd4R6VtrQ
         YbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794157107; x=1794761907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5/FgJx6xQuodGivSipA+H8MZrv95a/oZ5kRZw8SEv0=;
        b=Dvr8ZLZthQr9endySNBIFNDH0C3/T6EuIaoCOzBRdhZILWNA7Nhf8YQLwM8DmmLljw
         h9V5thCvfGn22XQXLPpyKDmMCHjNxi2/zYutfck/9/ot5L+00b7ygEaEB2vFd7OVjZDe
         A00gx7hAdxgZ+EjlF40y+QCYfMfZ0l7Rj8KIqPunI5efmERyLN6atQzzKkmyrD1Udo+Z
         aioWghC4FuNnu7j71a9gcuTyisE3F56pzyA63ty4GUOgDMTyrNrg9Qo9j3DC02k7T1wV
         qa9t5F4IQ+mNpyQzxFGnEq+jmTHw3RWDEIEwiK3qYpD8BxwKmg9yjeS2LLaYtV/IYE2H
         JX2g==
X-Forwarded-Encrypted: i=1; AL+hErEUNLLx6o9HAxARXdvMTwbvD3v8Wxt4+/G7tkoKRhFng7bAnTvGm3QEp25r0VDC0do6nM3Dqa0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Rge66kYPstsB8j5geDa4j/PjVF5oFtXkqh5XK4sFNxTyw9ptj
	6E6ahD2fpMtVdSl2jmA/kW502ZnOxcMDp9VRX+BrnhF+mJt6Fbjf8N6w
X-Gm-Gg: AYBFou3gyA+eiBfzRAsOzEe9J2ZjN7IoF5zizKknudgqa1DdjpGOpEdW2gGN5j3krgt
	EmJH3Aq3c20JgEMXf4gFlZy+/cOTIv5LHH2WBqaZNVqoWqlBNy/aUn5XSx0C8jLFQkGxtzEYuAS
	HmXkZg4JPDxAh4Mw8LmRAu3IM4eqSE76VkIIDV6n67X4LB7Ffl8tBEYoF2mCAoiY3l6HX/F3j79
	o7QsWQHX6oN9SlZs21FD3LPc9WRoxM5RSj6SiL/C9CHoLBwZMJgMJ1FKWyM17GgX32LyCKunRzw
	7ruLZM163UVuuhS6CnIr3yamTk3WH7TptI+p3lzcxkeAKMlXMPaEJAGsusVykhbNtUa+6w4IxvS
	JW+Ho4Mm8nLv9o0NC3kCZ5uxkVnxVZQKsd685yfsY41MC6NFQuu+5VVOblm6BYa9QaA1icCZiJ1
	BT28B6Aft3mlCTQOXLIGLiQ7mxRObwxdf5Mcvkx37Nd3Zsh5x81GVALIjcukFgDHFKdOjvsfnp1
	kdI8pImpdqWWYds6wWOc2jcmSYI9UxiztEwsQ2pbyc08BmQTYfZxJ2efFFJvyPCC/f1LTaPfQh8
	pEM28c02GqR9soaDgKc5LrFNsbyLaNtOo3h31T77omhFo+yV
X-Received: by 2002:a05:7022:1081:b0:185:4ad4:3d15 with SMTP id a92af1059eb24-1b39fe2dd5fmr2487572c88.1.1794157107231;
        Sun, 08 Nov 2026 08:58:27 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372631df629sm6539935eec.1.2026.11.08.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:58:26 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v3] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Mon,  9 Nov 2026 01:58:12 +0900
Message-ID: <20261108165812.676876-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

tpm_common_read() calls flush_work(&priv->timeout_work) under
priv->buffer_mutex, but tpm_timeout_work() also takes buffer_mutex, so a
running timeout work deadlocks the flush. Flush after unlocking; the timer
is deleted under the lock, so no new work can be queued.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v3: Trim the commit message to the essentials per Jarkko's review.
    No functional change (same as v2).
 drivers/char/tpm/tpm-dev-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 6569212..ee91f45 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 {
 	struct file_priv *priv = file->private_data;
 	ssize_t ret_size = 0;
+	bool flush = false;
 	int rc;
 
 	if (!size)
@@ -164,9 +165,18 @@ out:
 	if (!priv->response_length) {
 		*off = 0;
 		timer_delete_sync(&priv->user_read_timer);
-		flush_work(&priv->timeout_work);
+		flush = true;
 	}
 	mutex_unlock(&priv->buffer_mutex);
+
+	/*
+	 * tpm_timeout_work() takes buffer_mutex, so flush it after dropping
+	 * the mutex to avoid a deadlock; the timer is deleted above, so no new
+	 * timeout work can be queued once the mutex is released.
+	 */
+	if (flush)
+		flush_work(&priv->timeout_work);
+
 	return ret_size;
 }
 
-- 
2.43.0

