Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508349;
	b=3r4oiqvTDCCGCp7HdkZhwLXWqbzNNVjyY++Oh/kH7UP6YNQZBMK25y4a3/M5HF8qECav
	 H6ND121uuY7NSHsqtgJhntTrs29KeNBol/BlQzvIXVSz5pmw/zCWil2NpjtuP1RQzfRB6
	 uf+AUVW4xcRltaHq/ux+l71y31Sjblt4PdHn7kMO11r1gxpI0zV8b3gUKiM/doJox5uYl
	 pgGwyq2g2P/bcSckbgLXnn5Q1KlqDBqG8YdFo8Xxig+ZYSmQZTEcWUtyaKmPB3+ZMEFHi
	 baXc2475edcIZFYORlZ1mMkect4i4vHLaiO87Qa5DERarXF0HxrmSdsUgEALOxy7kJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=R+F+F57Ny9xfispLPzjEOAMsoQ5APyywQ/gJGUHTWuA=;
	b=aRobeioTCpLUTpnTJZEHjhIM4jwX8JLx+fsOyBEZlkgVCLl+MUx2whdBBONop8q1pEyC
	 uPHCoNil8uzc/IJfIdx3Qr+uLVAX3vQcYKUD42RGwuV+mIL2Qj3POZmoKg/8od31Wmto8
	 I4MUlcB0B779Dub3nkqnSOSc31rl2hwX4LOFhjRm8jkBZy697CIAQPQZM56a7OOpMGrNT
	 3yunZFKEeYEpG4fCbGyaKKO2KI+F2sDWDqLhq53PWCa6BZ707JfrFuv0fHSnP3ESH6cRY
	 4nxPisH9ESLNgp3q5ZnNrPWJ+z1I3Ae8kQ56ksLtialF3vUpnqjRGewIvTAtHNovWJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zOGg5L/W";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A8606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B7A8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zOGg5L/W
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so2173213a91.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795508349; x=1796113149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+F+F57Ny9xfispLPzjEOAMsoQ5APyywQ/gJGUHTWuA=;
        b=zOGg5L/W9fngA8zDFJqz7EpAWDmBTNQV5NxSYsethKDrtAu81hRjT1OcquP+cSt4Si
         tIivwsvd9Yy1HzxasazjyF6ZF1F7xNM3hB89fTy4uhnojyER1EWK/VmKhlp3dPGYDGP5
         HqtgL2lOqalRiqTO1/odFYAC2b/wn/jf1KHK9F62MC9u7TOJMRf/UN9Kl1oOVW/uFsUg
         1r8feJZk4VwCjvWoIk2uo3jGf2mmnAZHgku/TeFVu2M7XMTLqMptWA7wI8l3ccnHHQqA
         wRwCZKt8kvaU3NtVutLWlEb8g1M7N6di5cDSXqC3+0zkDVN0hDzRzsSJqP1dsQTr34+H
         JP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795508349; x=1796113149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R+F+F57Ny9xfispLPzjEOAMsoQ5APyywQ/gJGUHTWuA=;
        b=nuxwJHDr8ZxdIAbLeSM+/ItJxY9JP9RqU1SdqGZYvbJaoOEZYRqhLn892/cAl7t7FD
         JJXcZbjkA7sFrdB6pXpYv4uNUxOk2AquwnIv8qcpaxJtvQMpdcjtF8xsW//Et1hzhjHk
         A2kropn9euVsqt5RVLdH88Sx0BE2PkXMeuCSlzVECak21qjkCRnlGjoLx+Z3Lua4rBUb
         uGpXyGc3xLsIdth5gthEhJ9EvWiFATd1afhZ9zPEaXWoaW+nSWHv3YGBmDC4t56tN66o
         7fYPe/T8jWXEeVULbljXlejgW6xHA3Q7zZF3V7MNHIIu2hOchgNG6gXvMR6K1O0Ryu/v
         pN9g==
X-Forwarded-Encrypted: i=1; AL+hErEHeFJFJYs3kADjpfKmjoEmK4NKi80IrJxgg9PfKOiPiaZ1DJc4agZakDtKlhIZO0bYutc8ORA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hJVeWM9wILWT3UJCdpK72P25NPVSuQr6g+tYKaRij93SSD6zi
	wmf3dRUzfQxGJkX3YhuA5BAhyz7YVbzr4NFEpozxQt73cIUnqwGEfIwJ
X-Gm-Gg: AZFdTZf3z1mnDEvka3iaXCJUOrGYuob4sN6KAImhvud3Z2A4AYyJ7SYFyw8Jz3ysKYa
	7bMBxwIaR1YtYus6y+PY3vYviNYX57IY0DZ30DTDaOqTPHUXDrn4XODsBAjRc5C1bcoa+Rf47Ix
	eFMqXRy7SLVyvNt0IsY4WZ7XEtPCv/vtlwTMhwUj/VsSLeJEleu5mL6zES1kOWKMkSRYsiKwdCx
	ka1k4gR7rkQL8UFMeDduTglJlpGIEqFm4VpgTbTwfCFUlRpxKiwMKe8XFSBl66UXZoCb166jOBP
	lK1lJK/f3FY/h5xLx+24Gr4kXXb70HxTbsx5ydmJBYo8EQf4ZuKCI6ndEdXOnYyEUAH71sLn1a6
	UYNFN4R0MwkaAS7e+tPYQE9cbZNUC3vqHfDvCWnN7aOyjubpzH0BYwMRBmzOTtv8iUWFI2QrXfS
	qL5qU6O2rHsW8lL8RUkvLwRJvZSIflIa/eRT64kqH1BhvF3U3jvgwyrgavJNw0lq4Q8zSkOUgSH
	y+TcWCLQg538iQRRkIXb1Ezp0yD6m4o6ryxtq47Cf5Ak4UnV/wQVUM1/d5Zqhgs14jEyB2G6gxU
	KFu8FW+eQF94BPVrbwUksOPi1iLzw7yGsQMRVwVAMRPaFCWPEax+EQY=
X-Received: by 2002:a17:90b:2585:b0:3ac:a11a:7c7f with SMTP id 98e67ed59e1d1-3b41c9cd182mr11893040a91.23.1795508348677;
        Tue, 24 Nov 2026 00:19:08 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0575d9sm6557412a12.25.2026.11.24.00.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:19:08 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	linux-i3c@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] i3c: dw: check the response data length against the receive buffer
Date: Tue, 24 Nov 2026 16:18:39 +0800
Message-Id: <20261124081839.3890375-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124081839.3890375-1-maoyixie.tju@gmail.com>
References: <20261124081839.3890375-1-maoyixie.tju@gmail.com>
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

Found with a CodeQL-based static analysis tool and compile-tested only
with W=1.

Fixes: 1dd728f5d4d4 ("i3c: master: Add driver for Synopsys DesignWare IP")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2: shorten the testing note as suggested by Frank Li. No code change.
v1: https://lore.kernel.org/r/20261119122637.1368308-2-maoyixie.tju@gmail.com/

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

