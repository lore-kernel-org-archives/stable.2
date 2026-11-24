Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508347;
	b=yvUznTzPK4dkxnDuIShwv1ej9R4uuHrYpZX0wAudx4VRnZgeg4bLYhE3T7U2WPmi8140
	 Pw2KUT1wGepqSCSWuuCFBjD4jsO4AKXVj2bSY2FnAuhBQ385lxQhouGpAmyo3H6yO2RV6
	 92UpF+8+LBD8bjXFkb22RwAd5dKs6q09b57t7fo//Dw/0SVLsM2paBgDSzLBMdrt+Pq6h
	 XR7CsTu5nWxyrioGikGMXxN+hcx1ZO1og/qNx8uMdCcomqfTY/48eJIsj9PBsBjxRrH3F
	 o/2YixTclEaR4QNrlu28PF3wzkja13r0WXeiD5pSTiqasV1Eru/JymdiUy+mIm/FOmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MHBGz3X9/y2fDkAOHsbOXSpgZpUshqxbqZ7Tf0vNdMA=;
	b=gM27u3uIWskkfbjH/LJQ8o4zGNtgfTig9SBcO0bT08BqbBzMDOx8Abcn0rkCCR1sVS6Q
	 XQWD9Ec8B/rwNOPiBvJGmavHRmTFCFgEWIcC90Z9w0iokiodpaoQAxJdxMTKXzjWWX3DK
	 8DjQ0j/gbFMPcTZ9lZBX4nv6iudy4TvmHMexR+FjNTJiSHxvxVGiReJoF0x3AnIQh+ebn
	 GsmkT53h4DKFaVzH0DvIK140jdjL3+OXdcJvAtV6PmHqUQMqSNCJmjptYagh79fQLBhJJ
	 8cypi0LOhJ0CGMYNzsjPWGy90CLPsjuyDU8ghUxCYEXlNk8iM1kF45thbgBw/YhPpFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CxD6KGOv;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756A606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4756A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CxD6KGOv
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso2095219a12.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795508346; x=1796113146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MHBGz3X9/y2fDkAOHsbOXSpgZpUshqxbqZ7Tf0vNdMA=;
        b=CxD6KGOvvJQyYLCLxjKLBiXKjsyqoN8nqD8+qAtFxAwQv2e8juJX0qkZCaa9deNvzq
         LUq7WXlkCDfct+cO0OfMUhb2Jot9MHFXfONWVVFBqak0NwOfLIWGzcXzKPjoEmrj+unG
         Bi9/PBtGkfZfy/8H4rBSOhBithxc944wwPIdwUnJieqehLOh4i5QMRyEuDPV7cCOhN7G
         BKFzvu6TN/7h6RDDYCN76O2IQWJJ9J7zqt1mDE7mDO367QJmZLHAzaqyo1CcYXqGB17h
         lNMBzMPnuDUHZglP5jwL9C+RsGMkudM7WWzACG+S16UZ5WgngQWjM2qHES5OPTqwsbbg
         ft+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795508346; x=1796113146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MHBGz3X9/y2fDkAOHsbOXSpgZpUshqxbqZ7Tf0vNdMA=;
        b=sMxhqLGFApcKNJ1NfjcfwAJuUlUuvZ9PZ2AcQfP3v/Nz4Nk0vku/VRPklU1hvpQOMI
         3/ftrolxaZck0krayp6FYnyqQya4/9XrKpY5Wqi4kZUt9pKAqfz2qF0j9FtmP+CJY319
         ksu/ImkE+T+jVPBfVb/5SmoyXjT2IL7DzLqL0NQx99pRsYfo5TsQesJnLEn+tjW0lIBB
         P+msuT5eBe/Fi3UMzc2s+Wyq4BRYJCkJXFfSsEG5Fnv3HsM67/As0TSZuXSiWtlZCH+/
         i1E7S5Uc05UcCQWqp67+SgscS9bzaZPpY9nRvi65q6Bm2H3PIqPT4YEyL59N5AhJJNyT
         6Mzg==
X-Forwarded-Encrypted: i=1; AL+hErG/j6jgzZMNyZ2BOE/2+dPeVhSujL3ROnkaDsDRfcegYJAZjgaB0rWd/w74MnCCMWe8qsb9XkY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9geAFSO7OUCsT4ghZcpKbfjDw63aZL3cCT6N0FQQ3HMPqZfA1e
	1b03aQ1oyogFk3ybzvqVNEZhKSHPQ9L61oeyQG7iyltXBCIKq7gIN9l9jbM43Q==
X-Gm-Gg: AZFdTZd3erkxApjCSaOz6IPtaZXtbtb0lKyB+koYZcCkfQXw3DvBPloYOR5yrcubfga
	gmMdQiA4U/q1jg9sPuAmjcvXnQd104fTH4k/tYz9r/1Na+f2ath2EYz95JMyyiHVnUIuhVKJVX5
	fMdmYbrS1J4uh2oH0Qejis9uXzbbIgk/9FaK78F0Eo/KdM7ee8cizDTccWH7XvlHl4CoDaRoJ0F
	leccUydj9kTdtJ7nKb0cl1xSG64Jed4Co6myg6QbUr2K8CT9IqK5RIRKjbMnVXxQJiHMIqIHYnC
	rTh1ngfWl2cy57kcFAFmpzdx47g//GOmw8IBMzGPtBu8234eLrLZLXwYLJritbO70V+KPYlaiM9
	+FMD7sTfi0ALJ6/+CPk4XH7hL+390fsRSV6tm+Y7zHDXMyMfpWC2Vf3NKKqtDCmIz4R7VpfFMiG
	ENdqBCC7i2qg2RyQ9rq6RrR90BR8R6ZI+Je1yKBUsATCgjAGPjy4T8uKf0hEjFlS26sBvGnR1fk
	FOQWY9KHeTnMRjny8t7YmjrGgS/TnBvmDvL3SCEoGnYdUNo9jV5E1cz62gom70iTI6HzK5TK/Wo
	Nh9zf3R0QpnE4KNyx9aQnUm2Q9OyuWE+PzYlggI+/Di11I2LJK7PLA==
X-Received: by 2002:a05:6a21:2006:b0:3f8:d81c:819a with SMTP id adf61e73a8af0-4014d562665mr6832435637.23.1795508346479;
        Tue, 24 Nov 2026 00:19:06 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0575d9sm6557412a12.25.2026.11.24.00.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:19:05 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	linux-i3c@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] i3c: dw: check the response TID against the command count
Date: Tue, 24 Nov 2026 16:18:38 +0800
Message-Id: <20261124081839.3890375-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

dw_i3c_master_end_xfer_locked() uses the 4-bit TID of each response as
an index into xfer->cmds[] without a check. For a TID at or above
xfer->ncmds, the stores to cmd->rx_len and cmd->error write past the
array. If that response has data and no error, the driver copies the
FIFO data to a cmd->rx_buf pointer that it reads from past the array.
The error scan runs to nresp, the number of responses that the
controller reports. It reads past the array when nresp is above ncmds.

Skip a response with such a TID, fail the transfer with -EIO and let the
existing error path reset the queues. Scan the ncmds commands for
errors.

Found with a CodeQL-based static analysis tool and compile-tested only
with W=1.

Fixes: 1dd728f5d4d4 ("i3c: master: Add driver for Synopsys DesignWare IP")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2: shorten the testing note as suggested by Frank Li. No code change.
v1: https://lore.kernel.org/r/20261119122637.1368308-1-maoyixie.tju@gmail.com/

I used an LLM to help write the harness and this patch.

 drivers/i3c/master/dw-i3c-master.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 34aa8f8e1a0a26d..1e0fdebf58d654c 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -478,11 +478,20 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
 
 	for (i = 0; i < nresp; i++) {
 		struct dw_i3c_cmd *cmd;
-		u32 resp;
+		u32 resp, tid;
 
 		resp = readl(master->regs + RESPONSE_QUEUE_PORT);
 
-		cmd = &xfer->cmds[RESPONSE_PORT_TID(resp)];
+		tid = RESPONSE_PORT_TID(resp);
+		if (tid >= xfer->ncmds) {
+			dev_err_ratelimited(&master->base.dev,
+					    "response tid=%u, ncmds=%u\n",
+					    tid, xfer->ncmds);
+			ret = -EIO;
+			continue;
+		}
+
+		cmd = &xfer->cmds[tid];
 		cmd->rx_len = RESPONSE_PORT_DATA_LEN(resp);
 		cmd->error = RESPONSE_PORT_ERR_STATUS(resp);
 		if (cmd->rx_len && !cmd->error)
@@ -490,7 +499,7 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
 						   cmd->rx_len);
 	}
 
-	for (i = 0; i < nresp; i++) {
+	for (i = 0; i < xfer->ncmds; i++) {
 		switch (xfer->cmds[i].error) {
 		case RESPONSE_NO_ERROR:
 			break;

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

