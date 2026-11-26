Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795666758;
	b=QuRWsm1RhNUBMFmJJFrXwqUUgiBW61fktMvd/z4Sis9BcBOak4JVOeFp2XMLcufoOE49
	 lX/ckPkG86EdSbfDX0biX5iOMYE95xKW4eihlfpHthCVQNDAWCnwIWAErfkHWtBLTYb5p
	 9MaAq42+xJN357mhzZVZDWN9QxJuMVGwWQeR5yBfjfb+47djOmK9ISVUJ6BQ/VaGRmRZ7
	 gaw2Bcmzz4uWDRsTtdTUYf6atxq9Wqsi9eDm/mMYYzPhrDLGJy2Wq223K7LuOpPepVqcj
	 w12n1u/aZ29/D4qVkZPYGT7M0txNajU78bjI9jVYf3iFmPvQ1WBOO37+c00e9e81Wag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wu5lDuRgkYhHSywuSlGY6BNnn9XlDv9stYOOgzfHduo=;
	b=FzzNwNyjIFd190z1UBJzx4PAMqMrZQIqnHKNkTu1VP706VKnLNZJAWC8EaRCo71yLyW4
	 S/k/uWf6lZOkrhCVyQ2E+XtUK4BO0xMossyGoEESGZ0GX+WrjwbeDeiDNrPtRilY+ctBO
	 zlkd0vnXTCXJPkk9q9hIHcQshf8a8assQzE5CBRnwsWbIzGOPEaTP9rRmNCVg/6nGx8ia
	 oQ6wLDph/skNdFW/8p52Gekn4tDyH1J/aV450hJeQEWw0KBwsn5wYwn1Mt7sCip/2sArr
	 z/hKolz5k4zNYHnHyi2LA3+kGhz8He2RnfYz87a+r/P1UmhAHz6dO2NFuOzJVW2z6Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZQcCpc/b";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA95606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EA95606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZQcCpc/b
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so4466481a91.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795666757; x=1796271557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wu5lDuRgkYhHSywuSlGY6BNnn9XlDv9stYOOgzfHduo=;
        b=ZQcCpc/b4moUBO3hNXHKIR5pTa6j4s2brFgmZQXaau8TAb/hc9ZkExV38h2Dv9L+zo
         uBtYJoek0v6a8fiziQ5ywr6BceiHQ1xtBvJOut7FBzVm/jVkybI58Fmy+MQu8DN5OPlg
         2GuOJhPrfW+fzldGmOkEsbqrr3Yw+FUDi0Obec1P1/ctlZlGFS3RsRuSDmyRsqNkWv0r
         GqbHKaQtsL9NWI8NApKbne3TKfTw3j9klqRZynfwPmAqveQ01y6dBDkfR/wG2CiF1JPS
         tUbLAO0p4FqmN8jmXPrMPYeJc+nA5VuMpPFYvf+yeL9WrrRyH2bamALxBZ3I4+8wCVmh
         i6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795666757; x=1796271557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wu5lDuRgkYhHSywuSlGY6BNnn9XlDv9stYOOgzfHduo=;
        b=LfWY7gW6HEk3ujd+Q/IQCWIxjTl9sJUS9O+LCEj0/s4FDyVRafIBefJn1Lhg1V7Lzu
         rCuUejMHgOg/jUm17qrMSDpG1svzFRW3FLZgQMbCEzLWO1SiGTznRnNcsm4EYA1ktHLl
         z6whjeRZPKRGhIAh5gU7c+5tbcHD4FZqLAjFtUHoiy35AAzbTU05uiV9VncGk6wBlFTm
         qptmmYTRKTsi2ljejyIXMSb0gQe7WcCNJ9Q2ePEIlJ3wHr83Uyx4dtCg0E0fx0ErC4vy
         3twqqLtONEdjem0e2YUOjZpUb5qiZXwjxwEsDi/jWLqjhHMX1+LtEqqvF2d/79OkT1O4
         ME3w==
X-Forwarded-Encrypted: i=1; AL+hErGelfCIo6DoBBB4e23wz72NPgmvI8CprhKbQxJiQSHA+hgAKNCnnNCVQ1INtjWdxqlOJcl6vSo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JkTR85KAgJjbwKcOqAXMxtNmyf+rid//V+V44PoU/Nxrb+wc2
	bTvzdFCYGGkCDf/nlVU9WYDNjrfVF+m0NKrBU0pUXt6Ap0mW10DZGDCy
X-Gm-Gg: AZFdTZdjAK4DwRrxwwmfYzI96ZBBBoPPU8G8tuTE6qRLf47HEvkUJqei8Es2FqEmeQo
	wZLUvUy3fOGfwNnVm2bCVL2MU/40lLs6cDF5SOdH7vuBvaFuni/r7TvhncyYytiDsi48YrIl71e
	PSyO4Y6cx6ODf194ToELZ7cXSnGZ246MCY2nP+a8sGE+MavhrMAlOWLqEtzhe45pgFhZOQEiLyd
	S+JGLEZrgXWYGsMm/XxrINm/CBCE8ufIr7Aks2VJeGp+litjNfb3luiXi48EAcETjROqnnr96Eh
	bEgkYipLPIF6byOjUwthWG/MQlgvDPz6S2Pwc5xEWIJMU9X4n0fj+QjJaxHxRhKSSuW51k5VScs
	9vIL9g8Zq1+FbGUgFmcWZ6nN6tX57s5jCh5zx4F3SZ6FrjD4YzjohmRilDxeCW4sQSVmmVfIJ0N
	25dnA00M4+riFXpUHQdfzWe/c+YUmSBel7Q72EBXTeJsvY6KQ/lVRQKuKRAJSRpS+1q2EZEYimr
	soCG7tZXx8WFqZ1OAhVVWoKePspv5QvHrRw+YnBeIZFhdWv9ar9X8uMjkPPnB4K9AQOCqBSlFIt
	Cd1XrzWBNUeKPHxule+mdYKtB9QxFBgLCNM72tttLrSSv8bNwBjgjcN/3YDmga97EPlnlqqwlHg
	Rp/JhZ2DnVHtBTrlyVT7a
X-Received: by 2002:a17:90b:5543:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3b41caeca54mr18611047a91.36.1795666757269;
        Wed, 25 Nov 2026 20:19:17 -0800 (PST)
Received: from LDYT9Q2G2M.pvgl.sap.corp ([2a09:bac5:cad0:1caa::2db:4c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm30527530a91.9.2026.11.25.20.19.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 20:19:16 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	stable@vger.kernel.org,
	Zhiqi Zhang <zhiqizhangg@gmail.com>
Subject: [PATCH] iio: chemical: pms7003: Reject frames with invalid length
Date: Thu, 26 Nov 2026 12:19:11 +0800
Message-ID: <20261126041911.55827-1-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The PMS7003 driver accepts any frame data length up to the size of its
frame buffer. This lets a device send a frame with a length shorter than
the two checksum bytes. When that frame is completed,
pms7003_frame_is_okay() subtracts PMS7003_CHECKSUM_LENGTH and reads the
checksum from before frame->data.

Lengths that are at least two bytes but shorter than the fixed PMS7003
data payload can also pass checksum validation and leave the later PM
reads using bytes that were never received for the current frame.

Accept only the fixed 28-byte PMS7003 data payload and make the checksum
helper reject any other length before deriving the checksum offset.

Tooling disclosure: I found this bug. OpenAI Codex helped prepare the
fix, and I reviewed the changes.

Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
 drivers/iio/chemical/pms7003.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index c50edb24a..4f62b5092 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -206,7 +206,12 @@ static u16 pms7003_calc_checksum(struct pms7003_frame *frame)
 static bool pms7003_frame_is_okay(struct pms7003_frame *frame)
 {
 	int offset = frame->length - PMS7003_CHECKSUM_LENGTH;
-	u16 checksum = get_unaligned_be16(frame->data + offset);
+	u16 checksum;
+
+	if (frame->length != PMS7003_MAX_DATA_LENGTH)
+		return false;
+
+	checksum = get_unaligned_be16(frame->data + offset);
 
 	return checksum == pms7003_calc_checksum(frame);
 }
@@ -231,7 +236,7 @@ static size_t pms7003_receive_buf(struct serdev_device *serdev, const u8 *buf,
 			return 2;
 
 		num = get_unaligned_be16(buf + 2);
-		if (num <= PMS7003_MAX_DATA_LENGTH) {
+		if (num == PMS7003_MAX_DATA_LENGTH) {
 			frame->expected_length = num;
 			frame->length = 0;
 		}
-- 
2.54.0 (Apple Git-157)

