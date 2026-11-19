Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091205;
	b=2Ku3IZMJOrJ/zXu9vGf1xwt2+V6rPCnQFltvIIynQPBeGjmSKsQmgFqEkGwZDJ7VNqLs
	 q8zPgn6r8/Q54ogXpD1WBAmVduVUbmbwqXKByQgKK42mHVbOlZCTx0MKPjTqv071M7iqM
	 kuhl9mfWFgtYdb2W2T07efr9/4h/TEvBQxFqJfqRi4MkD0IUaxmZ0gFPu1Ssm1nALSi+Z
	 mn7N+qt6Psi5/oA6rtWNGVCD8lMUcDNi+MC7hGK+Z+wmKb3yjp44s+UpaUsbZpGChr2rn
	 3402P3+GlygwtzwlreedXgasWTQZEJgFrZV/5lG8E7sKmrz2hwS5j6KdzkEkGtBKh/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dh9ymIZplalxsaVK1Vez24OxtVY+OAshqM6T/QkbeW8=;
	b=J5KY0WrSS7WcXLFxagGfnDxioDlHHiXxTjsmYxGsF8GufA5ckQG4m1pV5elhI+TRY97c
	 pc4UZp/eDnNn4WS3nwaGW2P3aowuEvPMiATGT34qci4wNaIQo4xejnh9QNcv1Ty4PB75H
	 ghYcvYS2Y6I4uRujuBe+Yqan92D6OKHXDUWxtW5CwMtbsRQt0q1U3fb9/EcL/gOMRFKkt
	 iyWsQTRTB41PcMOGwwphJjJv24mWCtu/aCUGo2M8K4xeahlAF2UEDwaOWLxON0osnh+R6
	 9dkxmpo5KfSyjwJbn6rvwQm+oLzupMqfrNs3D7pO5OZjvNnSBLhlvvgs/IuDyIoVVKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yv+So3fb;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA660A260B
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33DA660A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yv+So3fb
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36dbde64409so3726712eec.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795091204; x=1795696004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dh9ymIZplalxsaVK1Vez24OxtVY+OAshqM6T/QkbeW8=;
        b=yv+So3fb54X1jmyN7cQfAD+Jn5apsQnbBiFQEcREqQDfryPsrCxed8UsanUcOErg3k
         +qQemb4ssmk7na7R1+jwbAC6xREAM6YaET8hhtLjvPWSwHWDAA+rABkfNDNV0so6soqb
         Jy1kVsqqJ6uZpPwTDKnU0tR2YZNY/ksFzOL2AG++JJHfrytTfzBw0G3ToLN0U5fp8VkO
         S3Zf69R7EbScFnnaSEDORCPt0K6AOVbw1vh6s3qGxhvZhnDvKx7WDsFB4qIGgFZga8so
         BYxhe1dRkNTupKMCk+oSO2Lj30HBS0Ah3RvRYtBZpYPSwHlE8hTK+uk6CYS0l2tK4+zk
         XCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795091204; x=1795696004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dh9ymIZplalxsaVK1Vez24OxtVY+OAshqM6T/QkbeW8=;
        b=lpMxFgfwHm0xcFfz7HhlQXRW/I4DoN2DzRIYXbi5U4L7GrQp1pvDd/seFcpPdjO3rg
         ugLDdDAdcyIaNuZgB/F8FUELNpl+FgI+dDHhabQSvsLLIVkQdngIerV6+vGnuJK2RdxV
         l5y0E56dda/ZtWcMKIWE4eSsXXHRhCVCAXNMTrnyT5PKiNvIl9HG/NBcXMKJWOVJR2Cy
         O1YcTi1rihitlMccQn5N0CItHdomgLQY6L9yG5lACrLEC9MSXRDXo2fNrIAV5DcSOGEj
         5sJBUUNrSXhdwL2QrAWOplKF54q/bQUtm316Arz4NVcF9PjWC2ZummtqqmaFrWG60ylh
         QIMw==
X-Forwarded-Encrypted: i=1; AL+hErFPdfp3qpjZVWPz71Na0bKw52Iwj8tO8NAA43zz9mCA03uvPI3/0fyNoVDC20f7HvlGmbwkpx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3+SJ56VHOmLVOLzgTUL9/AJ7K1glTVNBEKAOhG8Mc0Z89CDJ+
	3qR58RQq//etL+7QOXvQbDUK+w+cSilLRuZkJjabk1SIDQ/W8YYRqud4gn5WxA==
X-Gm-Gg: AZFdTZfbTh9Aj2p1hXRSR1SCDo1CEMCBRwAvvY2Jxgf/0FXVkOFj+N+nw71KYWcdiUx
	IJ3xQ+j1/Fks2GacCdWoZc4JQw3alkjyk5Xzugg1yAB+MU+GhvNGOxAk34sL/HthLncFHPk88gR
	WpqSObtTNycmNxAFKKosikn4hA4PpVC8/T2a3RnrFnq6Knidk7/gzqWKggU1+Yp/hhhP7CeItBZ
	rOQ6pnzdEdOOUmM7Ic0nxj/CQCX38Q9ot/XssQ9KZiZV0X/zy5VdXb5beCxBQZWmmVOGPuBtu8k
	aBS6Z3UzM60CYnL7HuQoZMHEMJyEZ+ISHZQF9n2/UzRSpThXzEwI3saGk8zADmHN7uk0TA9OvIr
	Tp342Vv88U1XNo406wYvIq+nqncuxzTRTij5z71no4N92CVTgq8jTfTvpCcBpuPgvVGnGxMw4qT
	gSfNwEjt7NIof32Zji9utE/qcysW/6xtCbZYsQYh6LqOGMlmebKcahuq8YFPT1FVxS+1779nyhZ
	cOI40mf2+djKPdlM9oGVmwl1h95yyiRnQFaEbQPfqBCciIOxlnG6Hy1moWtIXhM/k3wIlhqM0/2
	DVS5xPoIXqBfkP5sALXO6t/snWeJdOUE2h+xmVVbSXEOt+W0gAk/YVI=
X-Received: by 2002:a05:693c:88c5:10b0:383:bef:b6f6 with SMTP id 5a478bee46e88-3830befbb72mr4107693eec.21.1795091204290;
        Thu, 19 Nov 2026 04:26:44 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a75d8015sm16516585eec.21.2026.11.19.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:26:43 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	linux-i3c@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] i3c: dw: check the response data length against the receive buffer
Date: Thu, 19 Nov 2026 20:26:37 +0800
Message-Id: <20261119122637.1368308-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119122637.1368308-1-maoyixie.tju@gmail.com>
References: <20261119122637.1368308-1-maoyixie.tju@gmail.com>
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

dw_i3c_master_end_xfer_locked() reads as many bytes from the RX FIFO as
the data length of the response says. It does not compare this length
with the read length of the command. With a longer length, it writes
past cmd->rx_buf. Data for a command without rx_buf, such as a write or
DAA, is written through a NULL pointer.

Skip such a response and fail the transfer with -EIO, as for a bad TID.
A response with an error status still sets cmd->rx_len, unless the
length is above the size of rx_buf. DAA reads the number of unassigned
addresses from cmd->rx_len.

Found with a CodeQL-based static analysis tool that we are developing.
These cases reproduce in a userspace harness under AddressSanitizer and
UBSan, which report none of them with this patch. Not tested on
hardware, only compile-tested with W=1 on next-20261116.

Fixes: 1dd728f5d4d4 ("i3c: master: Add driver for Synopsys DesignWare IP")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/i3c/master/dw-i3c-master.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 1e0fdebf58d654c..895cbded5b8129c 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -478,7 +478,7 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
 
 	for (i = 0; i < nresp; i++) {
 		struct dw_i3c_cmd *cmd;
-		u32 resp, tid;
+		u32 resp, tid, len;
 
 		resp = readl(master->regs + RESPONSE_QUEUE_PORT);
 
@@ -492,8 +492,18 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
 		}
 
 		cmd = &xfer->cmds[tid];
-		cmd->rx_len = RESPONSE_PORT_DATA_LEN(resp);
+		len = RESPONSE_PORT_DATA_LEN(resp);
 		cmd->error = RESPONSE_PORT_ERR_STATUS(resp);
+		if (len && !cmd->error && (!cmd->rx_buf || len > cmd->rx_len)) {
+			dev_err_ratelimited(&master->base.dev,
+					    "response len=%u, rx_len=%u\n",
+					    len, cmd->rx_len);
+			ret = -EIO;
+			continue;
+		}
+
+		if (!cmd->rx_buf || len <= cmd->rx_len)
+			cmd->rx_len = len;
 		if (cmd->rx_len && !cmd->error)
 			dw_i3c_master_read_rx_fifo(master, cmd->rx_buf,
 						   cmd->rx_len);
-- 
2.34.1

