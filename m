Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908678;
	b=G7v5K16z2PuCAQcCY2JNxR1fmpEqyLNeSNn5R0URPDkgsYvGj9yr5iay69Pn9vdAAqJw
	 ZLpRjaXWaIg2UU1s4QFgyoctvzcH5JH8dUPAZKIJ5Hp+UF61U2Ui82T8afMujB8ZZ+dFo
	 b2vC/aMariI8BAOmVg3KbjPgRdYg4VXDAmc3Hk0UHBr6qX3uFhYDJ9EUs5SPtNWEdFKa4
	 hGOfEcsgcRWzx3gUxkcKaUPE979tz5XtUNRav4ewn/b/XDkK1G3cRtrSJpVJyYCePBwMF
	 9XrN6CcCjh/XguVDjC9/DOM35Q8I1XBz3Nbsyu3uGsx8umo4IFUbDYVQRPMKBbXCJjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bpVBOHCqTNlmSYDRormllaIQWrWpuayTwUPbDNGy6w0=;
	b=pFLV8hXBFS/VIxvjipRryL37C45geVJNGHMs7pXKn/QWfqqCDSwPaE4iWAuwD+tbeXG1
	 pC9YkqD2+cQ/kaXVzNXJdo0g0VAUd8DvQjVVuqU3OqI2o56x1q1xaSXxEJe6UubGS1OLZ
	 cDCGpeccvNCbsdJV68DyQJG72YN4/9bcUprLckda750AqpbTrnQsODHYIwDmfj44dlUIp
	 AVuzj3YzePIDVf4MOjVwB8nvwMr7ADQ3a8U7XnH4fUagZfE2B6m8QY7xCsdtgvRdyJgiM
	 4/YYZz18qWTae45oBRJCPQmT8qy5qU7k8gaTaJuB74HJspHYsmO+RllBunfEGHitC2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ibn59nDn;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1402606B5AA
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1402606B5AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ibn59nDn
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso27501305ad.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794908677; x=1795513477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bpVBOHCqTNlmSYDRormllaIQWrWpuayTwUPbDNGy6w0=;
        b=Ibn59nDnajmbpxSmVCbdMujxlpU2xp7zr+ALPIpdphgEd4gO4RRUzcqnftOFGrxtmQ
         DnP1qix7dGJ505+2a69wh2drHmZ+6mHExhJ6xa6j9T+ef1h3z4jFJ17RhJxFPOwmj7Tq
         ceoQHZI8h38rpyuKLlNGko9rrljwHvmJT1EBq3TGs7glnozjV5T+FJU00kKEP/RajDAU
         U7MGTihjuOdOrtLOGN8DCOOWQEZcQwBONbWvOcWmJjJQ+d6xskQ0eN6keqbQf5H0KUSH
         w9LQBYUPigMAlbp9T+3ozAWQoLyyhTlloN2bWEzXpsylC3GCGDBDlWs2ORejIGjPXMU6
         B1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794908677; x=1795513477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bpVBOHCqTNlmSYDRormllaIQWrWpuayTwUPbDNGy6w0=;
        b=lHi8Z+b27jfwlgHofgr9TpZuztBrtPMPU2oSy4BXtwEK319Drhm1xbLET0adBqWa/z
         ywpbYFMD/498x53+Q9TgWdi9QeH+QIALAN6CkfhIZykqGIOjDAvZMMTyhS2XPwRKuFEW
         sFqIhBMQPtv0Vs0x+zDNvmlOfRrSpGM9BwsSwjrLfVvRDms5T3ugEqrnv47aClRSGeU1
         SG4FR2HaBYBUasSJmXih5MIw4jfaYQLbujJaF5f3zsjeiVBJMY6Ayf0gx4geSdqQbvKn
         6lKtgv5lAVqpa3M2Gi//OYibaOgs4GC4VT0nrd8ohq3uspDHu+jku4lTYchJhD59iIot
         UcIw==
X-Forwarded-Encrypted: i=1; AL+hErFfzHvf/GFX1LMYVU3PN7gwLpNbyRet4/FIKnYShod2l6kHkLkY24FSMh2nnWjsejelGnPM9T0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BO0ZN9116bbmsdH+mj2lnIEGn+jewNvSXAn64GC0vsAKtAijF
	EpOjr2HsKIjmgZaEYVQhDQvjO9FbNjKEYQbmHMyEHyBwEFld1pJLkS0F
X-Gm-Gg: AZFdTZfJaQ9hOomhAdGEM1Prt8h3YLHkWOjNH2u7GF/qu82mmHbA79fENCOzI/3cKux
	Hnv7/qPZCADTJXETZ6pefzXjxNQAHTWibEPvJ2y+b9PQ1slml2KLhJeF+Ppwyv8LIh7slQecRYW
	eZEnmNcGG1oAJkUgzj0V2eFbVRsQ7Ws6ZDXXRYTWH0QC7LCae/KjyzkDs7gHouLKYp13Boe+cLP
	q7zBmzrc1d0+xNOi1nN8KRMmtRW/vqVXnHY67MVV9u0XNDWCJJrVaQVrjoGoVb4HH1XH8mPclzO
	o0xuLQl+SGuXvcT4jw27xwYFq4ltQ/xaO4x1X58pE3G2KU3MECfyQABXwkjwbl64wss4anFuSr4
	kaYzaREqETXoSZKq3qQLu9vrs5r5esNZt71u16G9eSIUlcjneEvcpyxbbgFI7rYOJkFCyYDCuxk
	hOI/oumFagItWfGlOlz4c95S4pYj8DezCk8JZGY3YIMO2k4Co7N/bYdQekAXTU5oxwqwrPXNRmC
	9TQuwf57FEvLVv5+6N309wVhhOfaExLtwIM0z2DRutcZ6OZL4QJhHj4SpPJ4h6uwaJGqz5cTrWy
	VzO0wnz7XgWYj3yJCVW69V3OUfAQe66cOHXzsUHx9d4OUr/E
X-Received: by 2002:a17:903:3887:b0:2e9:528c:ba02 with SMTP id d9443c01a7336-2ee0dcca259mr118714855ad.60.1794908676979;
        Tue, 17 Nov 2026 01:44:36 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd76db218sm12114815ad.3.2026.11.17.01.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:44:36 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] media: i2c: tda1997x: fix out-of-bounds read with a one-block EDID
Date: Tue, 17 Nov 2026 18:44:23 +0900
Message-ID: <20261117094423.193684-1-hj351016@gmail.com>
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

tda1997x_set_edid() accepts one or two EDID blocks, but always reads
256 bytes from edid->edid: once when programming the CEA extension
registers and once when saving the EDID in the driver state. For a
one-block EDID the buffer allocated by the V4L2 core is only 128 bytes,
so VIDIOC_SUBDEV_S_EDID with blocks = 1 reads 128 bytes past the end
of it and writes that data to the chip.

Copy only the blocks that were passed in, zero the rest, and program
the chip from the saved copy.

Fixes: 9ac0038db9a7 ("media: i2c: Add TDA1997x HDMI receiver driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/media/i2c/tda1997x.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
index 30dfd8a7b42b..a523fc2b2b71 100644
--- a/drivers/media/i2c/tda1997x.c
+++ b/drivers/media/i2c/tda1997x.c
@@ -1891,17 +1891,18 @@ static int tda1997x_set_edid(struct v4l2_subdev *sd, struct v4l2_edid *edid)
 
 	tda1997x_disable_edid(sd);
 
+	/* store state */
+	memset(state->edid.edid, 0, sizeof(state->edid.edid));
+	memcpy(state->edid.edid, edid->edid, edid->blocks * 128);
+	state->edid.blocks = edid->blocks;
+
 	/* write base EDID */
 	for (i = 0; i < 128; i++)
-		io_write(sd, REG_EDID_IN_BYTE0 + i, edid->edid[i]);
+		io_write(sd, REG_EDID_IN_BYTE0 + i, state->edid.edid[i]);
 
 	/* write CEA Extension */
 	for (i = 0; i < 128; i++)
-		io_write(sd, REG_EDID_IN_BYTE128 + i, edid->edid[i+128]);
-
-	/* store state */
-	memcpy(state->edid.edid, edid->edid, 256);
-	state->edid.blocks = edid->blocks;
+		io_write(sd, REG_EDID_IN_BYTE128 + i, state->edid.edid[i + 128]);
 
 	tda1997x_enable_edid(sd);
 
-- 
2.43.0

