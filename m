Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E696399003
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428309; cv=none; b=IGKZ3JwWAwkKIOuGprFIWrPVHgJvvXgJvN0CkOwglAAaa0LyHCmem8tyLcya7uA/dR0MaPPvASqRmKKah1EQhi/NR7BHXKy4SdUdzIlIW9zPiyHX4jh/VJhTGw1xKYTP40paP8/aWCgCMnnAO82RJFCUAJTJlsXpj70KWXYaQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428309; c=relaxed/simple;
	bh=Hj5bQFLufHq00/MFPxI3PzESKTnahG8Mxs/8XVRXevY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwc/IgeFNM52lKMnnfozHGne+RPCPQDRS0n+zqrhdkHtEz3ZD+24WF6vQmj3l+Rw1IF3SMkC7FCAEMp2upMczzp7BVTP4LS88TglNK+Ur4O3u+wCSyIpTIq02PnVCdndRnaUsxy4FUx5e/7CRRpqygWUy3Vy25QY7ORw3ZazRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1aMY/7I; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1aMY/7I"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so1825856a12.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785428307; x=1786033107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/cr8O2fJ45DKO0g9LGdnpAZnqh9rioDZWF13F3loYRI=;
        b=X1aMY/7IqFzqivCf4zSmr9zjPFrh/YO4QzKVWqETf6IgwK/icrytLbNSS5NErnaP8M
         4pPyMUqzXR0qbETnnIESp5atcKnfvN7O9m3c6ez6Bg1gTZ8ed8SMAkB7C5zRiByruLc4
         Bp//dXr6UXTtgr3CgH1Y7iaabicGNDDZHQQODMOjX55MJ7VG9XJeZq8gHY+Ai0h7lHoW
         oX9Ueuf8nvkWz4ZzL1gv8qSFjP/wGW41Y2cqYuuIn0ru84StZLZonDRQm0Q48mZAJ5+M
         WU/i2CacrvZY0BWAqaVqoU+Ilt2siapR6O4aFf0Ol8t/aDiKDJWj8Z4Ov8z/G4h7MjM7
         +OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428307; x=1786033107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/cr8O2fJ45DKO0g9LGdnpAZnqh9rioDZWF13F3loYRI=;
        b=HJel46wbGcde+OyMVUKWHWQcWLlkgvy9XoNvPTIeVwgml89AhFZJKwKIsGYCtWrvHB
         v9O0+CF2TBdJV0bS/AE+m7fcVktgRF/yeNR7bDdbXzAvSJTciBItsspYRlafjDPauobS
         hqQD2BmG2W44E1D2drprVRJUr5+XxMARCanPzRhsuSxZSq0bAhxdOZW8Q95t56nKqB8I
         8Vk5L0hJzZhcamOE0jEdEvosjgNYNoCO1AMk9jYiPDDAi9ahspY4/ISNkHFezzms5JeC
         VQ4g+axltZz5bny884T7OKN0MQAETgJGa7qd2o/2I7Gq/Et5PyWTk/ndP0NVPwLyadKA
         dVQg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5BzXla2/St7cwiJY1DV3Bb57Vk/ACVoUgQ/MTRgW4Eq2ZkA0vQQdoDTZuvOd6p6EWRR+9MTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2k+x7My+ft2OdQWlfVHSRo+08kyKOCe7u62Ndu3bgYlS7Q210
	BV41e3uS+e/PbsW9F2GCvX+CXyaOtrQaG4dXr3CBKxVvgI9RQ+EENpry
X-Gm-Gg: AR+sD12Ohs/cbq6LCZ8xc6tUV+jRlN/yijbOGGTPqkAoeCOmBWvvIPp6XdLwi2YF7/+
	R02XuqX1D3revpfNeciLT9oFHdP9WYuqZghfF2v4+fsl1G1JSb62+J4F4mc3aP14ir1p3eFj3C6
	BcmXjixP5DpEhzavN/dC+8AJz3toXfXDXjGxqMSQ6XdRiDyQoFPbb6EaEAMIZsQq4F7ot9XOZej
	c4uOF2yyB4VGMeIkRrz/2np23t0YBmmDfslgKt4OAhBbA86d4+fYuZbe7AIaFaTl/G9BdXLAee4
	aitiqjnJFyNRUZM5Dr4VMYgnzLIlH9j6TVOto6fQpF9yZBSpI+kvkRnRtOWO/zT0xfIf67+clHy
	E7eq4NpvVIUqCgk7jxAdMIn9RmAu4RQP13DOF6/KHwhYGLzV2mrlCfdlvXXadJK4ZqFlT5aqMRr
	u3ZjUVJfnpf4/uzZkCpxe3VHDVgnlh7keWOghoK5nNWdJS9lWuXVizEzpdycLkoCwCrkI+d6MJc
	wrwrJsMu4WF/OWXyLdXPbhfy1Wds1bOCrt4bKTSKKZ+m15Acz42TvQrB6O+hOsXz9YnUtA4VAeo
	RUqb3zY=
X-Received: by 2002:a05:6a21:684:b0:3c3:33df:4d9a with SMTP id adf61e73a8af0-3c9004561admr3400912637.1.1785428306587;
        Thu, 30 Jul 2026 09:18:26 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm21359741eec.6.2026.07.30.09.18.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 09:18:26 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: validate QCA rampatch size
Date: Thu, 30 Jul 2026 22:03:20 +0545
Message-ID: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btusb_setup_qca_load_rampatch() reads the rampatch version structure at
fw->data + info->ver_offset. A truncated rampatch can therefore make the
driver read beyond the firmware buffer while parsing the version fields.

The download path also expects the complete device-specific rampatch
header. Reject files too short to contain both the header and version
structure before accessing either.

Fixes: 3267c884cefa ("Bluetooth: btusb: Add support for QCA ROME chipset family")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/btusb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8f7ed469cac..9801835d7c7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3526,6 +3526,7 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 	struct qca_rampatch_version *rver;
 	const struct firmware *fw;
 	const char *fw_subdir;
+	size_t min_size;
 	u32 ver_rom, ver_patch, rver_rom;
 	u16 rver_rom_low, rver_rom_high, rver_patch;
 	char fwname[80];
@@ -3551,6 +3552,15 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 
 	bt_dev_info(hdev, "using rampatch file: %s", fwname);
 
+	min_size = max_t(size_t, info->rampatch_hdr,
+			 info->ver_offset + sizeof(*rver));
+	if (fw->size < min_size) {
+		bt_dev_err(hdev, "rampatch file is truncated (%zu < %zu)",
+			   fw->size, min_size);
+		err = -EINVAL;
+		goto done;
+	}
+
 	rver = (struct qca_rampatch_version *)(fw->data + info->ver_offset);
 	rver_rom_low = le16_to_cpu(rver->rom_version_low);
 	rver_patch = le16_to_cpu(rver->patch_version);
-- 
2.51.2

