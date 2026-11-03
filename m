Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711503;
	b=Gocmsyu8lTNbijLyiRBbwl9B1Z0PM5KFQ9BbtNG/TphNvq2x1CrJEYqfD5pl1fsojGiA
	 zXt2Ok+xtVJGgyaKXM+HDTVBk58kVylxb2VfMcZvXwbD7fFpx8w7L6cA9HyosInBLOnXN
	 O4LfaKkNu17nRSLQEAcDOel8bpeiPanQDsOgQNsIaa/mCG0hyytk2JCs6ayic6vcsBB35
	 +BIo/fps6TF4P3RpQyi0DLX8bz8/You3cKM/vu2I7sGY6UyN+pmXN+rNiuIbInWXfgc5L
	 44MzNeERjgesfC7pYdoPNyKAhs7Cicyxa/t6KXDJmkXdGkV9m2hJh4Am1Iqoa9JQFjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
	b=zDlQOpHueTqIJH2yOIXrnJqlHcjf6qeMbeNxY3DGBENmQohyX7k1fsBLVYEqvwvAQkZT
	 ClnOI4PVmkEkhYVIrXXuoyscHXRJPDAUcolpFDA0IGzerkSLYNTm9h/zeUPgIUXUG8lmp
	 Z4UwxTmKW/uKol/jquA2cIU5GMCDgGPtXm5JN+Mmec+M0+aasbawosZuaxqHIx5tmznIs
	 WJzi80eWV1d2xpp/EqnKGNCoO8sEoiOmwnRJh9JXfnvlWyI8KdsZomCtZmX+rFXEuipW+
	 ht7XvYeY9yKBkxtZijT4YmW7HPBMIScJopzPG8JSgTR+2fRz4+DDLbgucAtX+p2YWJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5d4Z0C4;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05218606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05218606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5d4Z0C4
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a6b774d12so313953eec.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793711502; x=1794316302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
        b=Y5d4Z0C4VCcS+iRFugDfiTr9QM8oGt20qjhiOAWEwjdXCa6mxNLimTVXGi/67AdjL8
         006SGlBaxB/asTP0YUavB0G9PqD2ANnKOnaA1O6zDD7FgAoAP9W1Qz1cII5okY3Y8LJ7
         ng8G63X94vCGAa6ouj20O1i8fD0kal4DonkkSODCt5erp2LOZbOM5bGxZ7LsRqXAcw0p
         EtMDKg3YTgUWhPhVerzHVKOnD9dHBaJOD507KUcVwVZOrSASYBSIuuJra7w3o+q8Pmc5
         IIkaxWHcmqAgYk9dh/WcJc9+urlz6nWvGGbSh+U87GpOD5tFgldThNqsxefdS/queeur
         yVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711502; x=1794316302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
        b=hv+JtNCpBWlT+b19GvvCc/O8NviQSmFcaDOi7qSlQTXP/VT053kW2NwEwZs/mWAG2M
         IEhA9nXOh9ezjx4A9kEoY6WrIALeAO7s54RotwuDASfh8I7mKtz+rjdPCpeF6tXc8LJ4
         71FGoBl999PKAy6PvvAndeSv6cJkbjklR54A90LiYRd8QvIHIhv0AQ/LB1D6PTJ4SmYk
         GaUcsaSmpimtDNTk6E73hGa1++cxdxxWdCqMMB9uYLVO04f0+mAjuIamsV7vW+ipRvJI
         Nphz1KLswlLt2cNhGxjEqzGrpKgbkZpuDGVkIzYoWTRfzpI7TcRToQgIgyhcTAnRGmzc
         J38A==
X-Forwarded-Encrypted: i=1; AKwUvBzj2X+Hh0+8N1dtCIiDNrVDXXbQ5veTjPNpkOrvm+aHHCfvp1V2/bkFTWd5EweMv58+kAGlW/0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZiWuIqE07pxSLPnBqptofjuPsZePTVAzt9BmDz6coFNN1kSY6
	As0BcAhu0gdQZiMMsWWGwhTCZamzv1h54b8RhuF6sHOZAk2wqKJ8rfgc
X-Gm-Gg: AYBFou3DbaTTv2K37EdHiQnl/POg9vcNvOcrHyV7BZoxmvCDw6ay1YBU/A1FBk39c4i
	GUFZ8snSuyQbXchRZM4mquCTK9gthB98bTvbv3I2Ac+7LvtRA1zVwBUIP0y3jxxJQLBVa6hHX6R
	Uz5DoaHmF1DoeNf2bJ/3yDk97DqtZW6dewS/xtKFvlUQGg0bss636eVsSuFdFZ70IWKeVu+Mhzc
	jrWLnAjxHGJB59/ug0+dN/uDEbi3RvmpFmr07c4L1jxAxhXs9MXy4Npegn7jSZS0cKiJabRphmN
	gC0vfKRqVLQ2J77rKaWPb1c9JuHUUQzXenqwdps9i6A5YKC35ieUopMtgXhNiuEmEU2uzbsjWLL
	nIQ5+CKmaTM8ITaGJlqgZNTuiPWc3EwCIfw3sfYGbAjEkTGrQIFQZAk14DS1fT38QPkinXie6zU
	8ui/HoJqGFmsWP6vMy7C74QGA5IsKhsVe2dZH1zc3w2TkNqKBwJz4a0ujaBWRduF6NGlYrTqmz3
	V3CAAXr7cXV5Ns8LLHrjzCGgvTrpqKDRWZNn1ywYCI5esg3LUK88z2RhIHTd/T7/2EaXHD+/sXf
	6coSJiHuFGakCdtUm9QzfwhBLACJ05G+jgaBowXlJQ==
X-Received: by 2002:a05:7301:1c9f:b0:368:5521:612f with SMTP id 5a478bee46e88-36a4206296dmr27406108eec.0.1793711500553;
        Tue, 03 Nov 2026 05:11:40 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm40133125eec.4.2026.11.03.05.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:11:40 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Input: rmi4 - clamp SMBus block reads to the requested length
Date: Tue,  3 Nov 2026 21:11:26 +0800
Message-Id: <20261103131127.1585884-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103131127.1585884-1-lui2012qwq@gmail.com>
References: <20261103131127.1585884-1-lui2012qwq@gmail.com>
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

