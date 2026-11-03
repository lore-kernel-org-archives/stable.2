Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714524;
	b=yys6crtB/PuMXklUGXVCZEph2ZDhKjoFpbHBQF7D0o7oSka2wn+k9herS57eDsxsNsTl
	 V0krhe9Qaeq5OBCIaBwN95tWqeguC0ly83BinrGMcEnTg5W2S4Xoh709Sj3JypHcxoank
	 ZX92DydmVK9xohYXvEMq94gjN32EVlnqRH6FcXTjzXjJzTebFkPfUJI2Li6OcFI+Xytbo
	 P1Ma/F+VeO+4FcREyrnh+vxQ4H/cU8UfU04fYyJK68s9BTHJO/DsZ9gi++kl0aaVp1xyQ
	 468fYPWKN9TN/sQYRQVzL86A2SR9CBObs/GvtqTvoccrJ3NN9yshqmBc2a20lx6gJPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
	b=o75raBkx+rrITLHPYYyO8gESH1mNbbC59Avz8wWMwnd2Zox2fP3OFJX4UQue6Xd1C+ds
	 y3vKg1m96CZSoZfE2rjRbwcB73mlcFRjSBs2HBXu70fusIRSJicQ6X1kZYjW0j1tPqHA1
	 V+AePrUpoGMW+VOA4QN/U0W9zL4/Tuvk4GFIS1HQTFvJ194OXse9IK4fWfywK6BF8TTcM
	 8eLQ1SrWtxAtca1qL7woFNmtxMLO3ZZ5NsjrLtumzYuRaEU5m080mMg1Pi5X2OGxRwKVp
	 7BGrAgaT+JvTblBeWhdT15Pr+X0Q2fEDLOWUZlA0wUEXNmVCNYUhOeVoRtAOc82n/Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EAihM5PS;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC28606D825
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CC28606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EAihM5PS
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a6b774d12so323340eec.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714523; x=1794319323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
        b=EAihM5PSl+n+KoiV3sOtuy9ZGYiMqMrNlO+oXWxSs42M+ri2MqFh+WAt/Ldf5xsoYC
         11/XBB/e1vLFGIr2aecvU0FQFvQCq3zPITYhqRS7vNYNBbrxxr82Q5gumqMO/cf4DFGl
         o3Tll68iPcgqLHUUTQ/eGpEGWzTlq3a9DUCShVTs0vDMku7FIq5QfzsfAZMsEFFRRMcd
         z6BQuTerzg9pl8n2NeziFlD5zVY7CKg8mbBG/LTuCib54N2Fmgz8PfSzNR8agOEqPtnW
         CNsauLZGKEHttecdIG+QGW+O6oCSPDkPLhzTk2ezBqgqfG8YzzyAR2rZttIT4KQ7wNDs
         q1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714523; x=1794319323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
        b=iy7pX+GoBNNywf1nG6SFLWsIDF/3u9Cswue+E+wtZXEbE6m5kqvemUyirsi7fj3nLY
         L/MxH52HGkHmPwJqhgFFCsWipPhMfZ20tR7f8dnKWRA2tojTFLC2zc4jQ2MpxWWtBKsT
         ZwUfcVaXTbk1t54uvigRWmgEATYR/3nrORnpbqpMkmS+/wUzwmUmuukxCCnKn/qqXw2B
         jKFILAE+c3C5TI1SgIAReFhSSj62S3dtxoi3Su9uvCpyhfuTVunh6BWESYZ8XQBYd6P8
         GEK7QNvf8IEH5AySvQEDjo+Brm3lMhBvCIt78kH12dBiUCZ3nXpRTmsV9Ydk/ut4ddVC
         Cfcw==
X-Forwarded-Encrypted: i=1; AKwUvBxs1G79v53lFRQnZXGfTEsjWIPj4NmFp3jyOEceleEh1CSr/C0YiajK6gO0X+wPal+/8TtcxS4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Kka9DcUuXdmH8qIFgR1TPVoF+tkq6fvhp/+cuY3VnxpZpcFcf
	Lzpz8HfYViO0ud99qE+/HfxjW5c74aLb4rtc06neDL1AOI6a4qMr8DA+
X-Gm-Gg: AYBFou3l4EW8+ZhyJ/SK0y+G2leVXFJ4Yr4WZMixhVHnurO1tJx5ZyZ/biXnAwwupFe
	dIzVuuqb20V8+swhJNB12o4UGlIsTYdhKeTUmi6CGhgQmmlK7ZnkiOFT9xE31GpZjSjisSu5VIq
	ESmTExMi6kA0MH7tKdef0zq8nUMlnbG/kYi4z2GE1EJFCGWqgRvcZcZuw6Nuv6PYA5LCMsRw4gh
	oPUNDk6H/8VTXFwSelNsqJKth135OAIxyLm4lCWmGOgt06E9gGtAtcZtEELQrNWrmIFJOXRvcvT
	vdaWXgABMtJHiIHLBWGeNzTellx8Trfg8XWiR9UVRZ5xkwqk0gD1HyNnBTsmJ9OeISrXMW/ii9t
	MoMZw7SHAOvKeGb0ikddeP+G5YJj+a9NNpRS0bsRH5y1z9qmvB2KdGQu+uP5Z2FuEZtPB8RsydF
	LKtt5TlhLe+WIzJXBNlcaoRKHt9OgGnJnTY2mHlwApUKljmk712//aGlWcHPE3KlhEmynw07kAB
	8CCy4Vqkn6Mtka/GasjyLPRi9DLWUviI+LauT6C7ujG2GpSE3TIhU8xianBSn73eTN13+BXSiVy
	kJ76bA/Owfz/1xGvlFK1q3IYHqToYp9JruWRLknHBQ==
X-Received: by 2002:a05:7300:d090:b0:36a:e7a:e89 with SMTP id 5a478bee46e88-36a4239cc86mr29709377eec.2.1793714522144;
        Tue, 03 Nov 2026 06:02:02 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm56343226eec.25.2026.11.03.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:02:01 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Input: rmi4 - clamp SMBus block reads to the requested length
Date: Tue,  3 Nov 2026 22:00:05 +0800
Message-Id: <20261103140006.1587143-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103140006.1587143-1-lui2012qwq@gmail.com>
References: <20261103140006.1587143-1-lui2012qwq@gmail.com>
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

smb_block_read() drops its len argument and calls
i2c_smbus_read_block_data(), which copies the device-reported byte
count into the caller's buffer.  The core clamps the count to
I2C_SMBUS_BLOCK_MAX (32), but nothing bounds it to the caller's buffer.

rmi_read_pdt_entry() passes a 6-byte stack buffer during PDT scanning
at probe time: a device reporting a count of 32 overruns it by 26
bytes, with contents controlled by the device.  rmi_read() with len=1
and all register reads with len < 32 have the same problem.

Bounce the read through a full-size I2C_SMBUS_BLOCK_MAX buffer and
clamp the copy to the requested length.

Found by static analysis (audit of i2c_smbus_read_block_data()
callers).

Fixes: 82264d0cf7ae ("Input: synaptics-rmi4 - add SMBus support")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 8b61c23822..e4d77d1f80 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -177,8 +177,23 @@ static int smb_block_read(struct rmi_transport_dev *xport,
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
 	struct i2c_client *client = rmi_smb->client;
+	u8 tmp[I2C_SMBUS_BLOCK_MAX];
+	int retval;
+
+	/*
+	 * i2c_smbus_read_block_data() copies the device-reported count
+	 * (up to I2C_SMBUS_BLOCK_MAX bytes) without knowing the caller's
+	 * buffer size; bounce through a full-size buffer to bound the copy.
+	 */
+	retval = i2c_smbus_read_block_data(client, commandcode, tmp);
+	if (retval < 0)
+		return retval;
 
-	return i2c_smbus_read_block_data(client, commandcode, buf);
+	if ((size_t)retval > len)
+		retval = len;
+	memcpy(buf, tmp, retval);
+
+	return retval;
 }
 
 static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,
-- 
2.25.1

