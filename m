Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091203;
	b=KNMsMDgGk+HvREXJQE3BxU1JtvAS4meskLAaS7hmSxhCDmPPoDfey9BRF8jhDeyZv0tO
	 GwcjfIdmx7kTkwlRHNYq3ASYatjiKPS2oxVHYzbI+gplL+XNVIO6Jz4sdYUP1slV+vP03
	 F9dzBEGFeoT4fER+KSWbp24ZuFVCbtpQeBMqoAlbvviE137bSCNa6XM/PcX16x5X3mUkn
	 E+VSADt+lqDVFmVncoYpcZMbeCMdCD9Q2WnbxRMj7n1wdLftuLelrGcjIvrq02KlDXneu
	 +gYM5iGFXL9c9lXHtg/WuvFka+1x7F33y29VibDYMvsqrwb+999jTCq1lB+MZ+UR7SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5V87jSK/TmzvUrPVfz6BnlwjCMwECPp1scTiD61UcXc=;
	b=zh+Szx1Z9WZfnsqbbIpxiwYd9Cgxe/XMIEDvAZiEX+SOHk6kXFE0qIRUA3aRTy9OGz+u
	 +f/CLKQkuIbUPPUYwhuiRdqecHWQqP2m7twyn8U3jpYxpInokjdEnTQrl22/Dy7W+pnpt
	 MiYj4OJMRS1G04PpGldgez/fbYHfFKD6sEkf7T8c8UxEXK1RCm6RQieqcPM83al9lLi9g
	 TKqG8HO81utvZlTNfF0gbbYpWxWsK7qupRm5/sePqmxK1NAUjsz1GR7iCGn4WW4QcHHCH
	 NL2PnnkKbYzGlSWqP5wHPx+9O5ZJZlnnHByfVRT1x3ea8WbfhlmJVVrddhVGZd2HMWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0dLc5tj;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3927C606A33A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3927C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0dLc5tj
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-381d542bc29so3981721eec.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795091202; x=1795696002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5V87jSK/TmzvUrPVfz6BnlwjCMwECPp1scTiD61UcXc=;
        b=P0dLc5tjNkbx6BboAfKc6AOJFDTodKCMpI2QzU+QBcjr4zRtcbeFLnlZALdiJILAdG
         u8rBO0d+0c+7Scz+CR0aaIT7FGbpi3NVKsDILsU/WgNQtTKd2nd/kiHF0f6fxKfHob/Y
         b+uOXfiHZtB3JuF/eBUEqLQvnVPRw7Urr8zwJAqRwEho1JaPE6+X7uthb3IUsfBG+ovi
         X+fHfAf8C4CMRpDGCdE4xxqh2s7/FqI4QomgWCo0BGf0HzBfn0hK9ZeZfZrV+Erq7OTb
         aESWTGJTOla903ahOijvjIAL7L0R+wBmcRb1l9J5p8kziQjVwLYveUnO9WrXcf/mi5xS
         w2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795091202; x=1795696002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5V87jSK/TmzvUrPVfz6BnlwjCMwECPp1scTiD61UcXc=;
        b=NKg94RA6YGhrTMG1Ie/FLGbLe023WxAcko18fLhoG4hu/kd+cq98FtX0AvhIZWdTFs
         j9Ch1VW/oJ8nXnqGVpcs1qoT2PrJdUU6XUhnE1FXvpnuTv3E/R8zV7ytl4B4IU9CC6dJ
         aITD+eQaFM7dF+8BnkzbcP/MEtLRArJA7kRz8eJVP+HWrSpDXH6gfm4qo7g4Oon4Q3sa
         7UbnZEoJLq3rsT7BAa3mWnOlESAW3BxrgpE9/2Zi8egNN/QztWlKl0BtyA7MyQpTu9jV
         /xqhi4PBGKYloSMCWtGcFtkh+lra24afhHwgH+EX7JWmy/yxOoxj37GWaNq0mFDKrcHz
         I1ZA==
X-Forwarded-Encrypted: i=1; AL+hErGI8qKDfhDhVX6lV9CmNlSEf8pmWtKDRssLeGmwN/GNT/M1SaNsYmBSUjIomKA3G9ucqDbNqWE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IdiHGL5lXWq/MomBNRN/YKSnt5dXk5U1+E9yw/fOlUK2O6egU
	wsmpltndEC/424R2DtX6FpfIyKfen57T62lk0pf+NtJlAXQ5+fj/6a1s
X-Gm-Gg: AZFdTZe6gBTM/sGQQIqpl3ttxaKaFgjvhKCNoM6uvpofsQ7QFxD2C4pMPpCtXaFTM+T
	vGksC3Dwz/UM06Go6m6o7JvOojG8tFuH9cozAu0AKF6MlKusIIvqvWi6O6Qe3vNCw8IUUSWuMV4
	nXY0U6Y6jLj1V1t3yrK5YM2i+q8e+I/1J54P0o3PcBbRYb9+6EKowkdNhbffBLhrpZu4agv/bCl
	q1+rexaEAIRyo9qkyx1n/HkjbKf0lMtzJipacrt+jilWRCJGQye7ciDFi4EBrAjJ9S2Ih+CRf+Q
	PaP3sZJguZc+/8b35aLVGyVrWDatEgdS5dW6Lr8PcbaDwjSYI4pCIK8JOKuhv1XD+uggv7EMIwe
	lrCodjk4v3NTsIEHlWWiGCyX2EW623xtH0z3Hd/rcpP1vSyHKNRc5F9YlsmWMKX4kXH5MxFNwoc
	1de0LD8XhgRSDgf2IjwZL/Uyv3rmAhux0Nk1TiJZ4cVaNiUhOYH/a0PRSSPhWUvB3N6pvsW10HS
	yUkP6B2ESkgftpKEL4IdwvtzU5rizc+yNhJsFVLfFhCvNu2DE/imSoKALMXTaYGcLsYv7IIa/j+
	v5Zgnh5sVjNICXDSji/HFdDTpklR8+ose7fhHo+5o6HEw5sBtviRBQ==
X-Received: by 2002:a05:7300:fb01:b0:384:b791:6a41 with SMTP id 5a478bee46e88-384b79175d4mr771278eec.29.1795091202087;
        Thu, 19 Nov 2026 04:26:42 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a75d8015sm16516585eec.21.2026.11.19.04.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:26:41 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	linux-i3c@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] i3c: dw: check the response TID against the command count
Date: Thu, 19 Nov 2026 20:26:36 +0800
Message-Id: <20261119122637.1368308-1-maoyixie.tju@gmail.com>
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

Found with a CodeQL-based static analysis tool that we are developing.
Both cases reproduce in a userspace harness under AddressSanitizer,
which reports neither with this patch. Not tested on hardware, only
compile-tested with W=1 on next-20261116.

Fixes: 1dd728f5d4d4 ("i3c: master: Add driver for Synopsys DesignWare IP")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
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

