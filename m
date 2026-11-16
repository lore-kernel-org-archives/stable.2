Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832031;
	b=Ahi0cQXJEYX/BmvRtqZIBlIeOM9iOPMKBVOqDD/YsjiMarmUr/6FwE8mpzqDlO3t6QWO
	 xNGLVaxq5x8HjjPUtbpzvHbyOLiBCFHC4IPJkzoBA4hG0mTcZyeEfffC7u+62H8UiMlSp
	 wmh6D0t//PQH5ylZCsz0zvbWV6nYgQWnKPKVQDrdxA/VvOSzePOv5U+RC9SzS+zt/AMz8
	 hfckZ1vH7gAuTVOs1SN7N3NhsD6WUq8y27jRzKBaB4IyUEhQM76UbXld7WqLcjiQRxm6s
	 u6a1F0mnfJv4k4yQ6yEAf9RTUCiLGKbVcfWg3GoGqnWPAJoxnZvh3j/nisgK/8pAvag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lYiKs2zOREczoUXWCfabA4P+kj5kMFUufjVpxMQWxLc=;
	b=To1cnoLz9sZs4LNMpSWvVr98F6KxD/NPBr2bygI5GlxJFijKkzPWh+AGNJt3sUdlVpdM
	 oYEKznFFgK/t0vw4CDkmR+1xpZ/tLeoV7eUpHggKAquSwNYewbs2myQlInNW6oG/cx3eE
	 dlTQt+EkDYy077r1XWVn/GKdiERP7k5m897wF3dBmmxvKh00lxr3Tvds+b3FyDVbeFAJK
	 myfwIhbMiE+t9blz4DX400akQw5IkOG23EX0Lr3XdELaGLCb0EvW/yS01YFo2Ml72zL8R
	 qOHOXnGJ9t7nb1xDwv4GsDCfeFQdewnfzOJsgyT6zah00UXUBWEqisdJemUmwbMnBbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fBNkVy93;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5C606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 12:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A5C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fBNkVy93
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb606491faso9929805e9.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 04:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794832029; x=1795436829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lYiKs2zOREczoUXWCfabA4P+kj5kMFUufjVpxMQWxLc=;
        b=fBNkVy93+Ivhz+cLJItX7AINqI3LPXcFYjJEc6SPK0wfFZ8GArFwA8UG0umyTif4TV
         1uvWX+rG2VNZ8GI1dUuf7sBxQxy82ZUD/nDIn0T23BeRrAWvhjgbL2UA92RyEzsuDueK
         5RPCfNWASJSVPjUTUGQGMFbJe+mOFBNTnkvp6J4Hg5GOha5igl1QmPeq4fNkfLPpoqms
         kVvw0EBh9/EFRBHCbGq6rhoQ7v2N9LrrKEJu0Mbztr0btTwQ5RJDQhMh+alfveeqF+bm
         aFWQ4+raenJPfSHzTZ7jS5TpdxApbkIlnpDa2v+YqpK+9HpEtKPfi8J4xHKCnjeLZ81E
         OLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794832029; x=1795436829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lYiKs2zOREczoUXWCfabA4P+kj5kMFUufjVpxMQWxLc=;
        b=ygMmeDpRUxVgGQMdb1GeHKKPzXRixZYVRQUOY/V25+HSMRVIvcnbW0418o84D+B8dy
         Vhhf2dGD5cDtY+mKLT9Hhcdxxcfftz8DmB73GwL5HIcyvE4myLX+KmqqzoIqJmYprB4E
         igvdtT/BaozHXiOn/YqyWYlmP6fGJhvSaHOIUgakSgzR1U0PoEx5GVLdXxPALoSyAWn7
         fxud0EjWhHvd9TIcxYo5hGHmnFVWbRnoxBLmuv7URnITCQxEeA7QP1eDYlWlYRMkx97P
         /VSLq7bDSH54HR2WuhRtpHnoVPeZ02zCgQF/FmvUIZsVqc0eAqxvlaLEWy4lz9Mq/7VC
         DBqA==
X-Forwarded-Encrypted: i=1; AL+hErEqLp3q4FunuBcQM1hmiiZBJLA/RP6+wLh6iQMV7Sfot4I2JgFC9f/W2lhFTcXqSK7I4CH3FI0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/O9JaFgyGesrElly9mgotsHYdyQuTq5HL/cFsYRWaZfXlxNoYO
	8/52y/1tVjmwgJNkWR4atbhY9VKxZwNyXivi48PYPDzWb73zckDjzTqN
X-Gm-Gg: AYBFou32RTOfK6keGcq5eoEL5wYUxp0LyIA2Ikh57hGJ9cfY/bw1SR/rVBeySVCvtLs
	uZYF4CYyksm6Y6Dgjow9r7CB0ep7jzTiW1IE7vV7HB4tRrLQ90blHn06ThU3T0xvLZssG0oTn0n
	PrrvidkLCQSKrtv1DBXoMe2aUjdaIhRfjmk6b3o1RXaW3gf2FqWthymihyqTmoPec8sM35eh7AP
	kIojVeZSQ1QPG1hDSp3Qz9lfNNDds0dGnE1NtprTdGkwh+RZTfy/pg/arAVdHp3lgtgpEl05RUL
	D6zEysUPSb8MH7YS7ulCXaA9WDWfFEl4uNwn9AV95Z9jGBScGLSagrqYfCfLL6ySBdD+yY6WFZf
	zC21sAQoBks7D/FYQ4ev2mJhz9GgCxovX+AnnPsqGRNfoyC5GlNGSMx4WyuphDfcyAKmP3I8Epn
	5CHx6LumQHVvQhe+rND9JyC1QMQQinTZnXQFah57kRqb3kxyxw1x51d2SmgisuAbWTAsONkqQ3f
	CAvkNi2I9R6LQSE2olB2tOgH1nFHabE/FvvL793V3JJDgmOUy+1C1Kt9IgZ39RrDRlYyc2e/s5x
	JWmfh+8jxhx27vZehH5103e6oYaRrRXTVvs=
X-Received: by 2002:a05:600c:3f18:b0:4bb:6ac0:6dc0 with SMTP id 5b1f17b1804b1-4bb6ac06e5dmr82826765e9.29.1794832028780;
        Mon, 16 Nov 2026 04:27:08 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56689bc2sm171999685e9.2.2026.11.16.04.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:27:08 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: [PATCH] i2c: imx: acknowledge the count byte of an atomic block read
Date: Mon, 16 Nov 2026 13:27:06 +0100
Message-ID: <20261116122707.1349139-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

i2c_smbus_xfer_emulated() sends the read message of an SMBus block read
with a length of 1 and I2C_M_RECV_LEN. i2c_imx_prepare_read() clears
I2CR_TXAK only for a message longer than one byte, so the atomic read
does not acknowledge the count byte. The target stops sending, the rest
of the block is read as 0xff and the transfer reports success.

The test for I2C_M_RECV_LEN was dropped when the read was split into
i2c_imx_prepare_read() and its callers. Commit a5d0b9e32745 ("i2c: imx:
fix emulated smbus block read") added it back to the interrupt driven
read only. The DMA read never gets an I2C_M_RECV_LEN message.

Fixes: b460b15b3cc2 ("i2c: imx: separate atomic, dma and non-dma use case")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Reported by the Sashiko review of "i2c: imx: test the block read flag of
    the message that is read":
    https://sashiko.dev/#/bug/linux-09e3015b-fc03-4410-809b-82964cdfac9c
    
    Tested on a Colibri VF50 on the Iris carrier, kernel at this base, with
    the M41T0 RTC at 0x68. The core takes the atomic path only after
    SYSTEM_RUNNING, so a test-only hook called xfer_atomic() with interrupts
    disabled, with the two messages that i2c_smbus_xfer_emulated() builds
    for a block read. Register 0x04 (0x13) as count byte: without the patch
    0x13 and then 0xff (50 of 50, return 2); with it the next registers,
    the same bytes as the interrupt driven read (50 of 50). With a count
    byte of 1 (register 0x05): 01 ff before, 01 01 after (50 of 50 each).

 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ccf08cd63151..1a3fc245d6ba 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1283,7 +1283,7 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
 	 * Reset the I2CR_TXAK flag initially for SMBus block read since the
 	 * length is unknown
 	 */
-	if (msgs->len - 1)
+	if ((msgs->len - 1) || (msgs->flags & I2C_M_RECV_LEN))
 		temp &= ~I2CR_TXAK;
 	if (use_dma)
 		temp |= I2CR_DMAEN;

base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
-- 
2.56.0

