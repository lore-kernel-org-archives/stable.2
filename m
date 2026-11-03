Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714527;
	b=GwSKOL6+48K0SVZY1VDsFruAGJ8klJAyb8WQI/6B5kG7Bia2Ws2uChyyW8/oOCEW4+Ia
	 KQaIa2G+Qxgsl2xsSeyAYYzeqeAc0JJN+CnyYVJKEww2XYuU6Y3K8MTgMPGvKuEtDk1ND
	 Ke3k3qd+MxI7krSzMMlavI0s+upLQmVEGweexC6MzZMPakf5brJUBMboMzbMMa6GVX/og
	 Nh5AaEWSuQOkVW8LP/vFA02/jNVj/k4+PKlCVVaxpqdwQzIYWVSiwJr5qzb8w9j8bgHZv
	 xcnozMAx4S2c2A8Faj1WDNvEtE96xlwsYLhZ+vSynty5J1/SNt5gu5hg+NWQ/O8mLHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3lqUuofFF+sym+aHyb1Hp/3ru9p7QB07qliBrnkjVYA=;
	b=HebI4eGKz/MhCxXnG5LS5oSVmZa0M2aFSbrXjo6XuQwHZeswb/lhuFntTFz7cht9os6P
	 neJCvINePX1qrrowBaWL3j/IlTyIOjdbhsRk09l9mRgJlOPdRw+ilBOswH/6b343hsYUC
	 fF831rBoWuatO4JlMASwuySERlbDXidpuWdJEexBn9iTBfphfdAAFstVUCQF9Por7pRSS
	 YlFEectqU7L5Ej01Ir+PuUh6rRSiO4BX45K+gWIhU0I4sRlb0tXY1523+PgDQEwk+9kRF
	 g7XOHIUmSNCt/R6M3f6TUi2zwBWsL+0t8X+9yCxrenFw/wWEgyCD0aBS6NKkAoq+B2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmmEzL2S;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DB606EEA5
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F32DB606EEA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmmEzL2S
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33c10faf6easo537002eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714526; x=1794319326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lqUuofFF+sym+aHyb1Hp/3ru9p7QB07qliBrnkjVYA=;
        b=BmmEzL2SrMRSIITUPNL02a2fjqbMbKWDfbVDBqRMq5nSmXxRJN+YCeWyFbQGel5AEH
         FME01N7UEjxRGaXMpYdN6ylls1GdHaVU1TD9CjIOxzab8891tFyYbK9ZrCKPULAfbm9k
         pGXO/q2g9oKi4P38obZ9EkjU17DsD0nT1Z1gI/95OvFfMsQyPXDHDuyGYF183/H2mUW5
         l/5BE4t6REAcdx5ApRk2yle9atvK2hqP4c5iusWEaZ+nHxBUjR3kRMLOpy6cgca7Z9ev
         sPSKyzKuwkA1PlU+E+vVHtZixAxYfaorzaqNpDBPu+WpIbBiGuhCOvSN0AWQpnSBqnjf
         XRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714526; x=1794319326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lqUuofFF+sym+aHyb1Hp/3ru9p7QB07qliBrnkjVYA=;
        b=W9Il00gGesUOih8TqxotZvSP1MkT80BVODofxbbkchaT0w/YrRKXBsz/+jxLsYft6o
         JA0/YdeySGgRUZ+vuh2tKZRcT2uaSxm2UAzxKwfgzGE6qUYwsxtRlonjz6+clY8X6EmD
         BK0CgCdx7h6CilRbFS3Yr4WWNFYuH3VvGZi0RO/oExtcmrtDw8S9KNdGXA1mYKwsrcwY
         7vJlb54+TsR8oeWhh91VYrTepapq9NKQVdxTFcKj5Pd+Shntvjh1vk40h6M9/kG+RVqG
         fEZP4HjgEUYZn3JvvTnPEvB+g79t+qzjHTFdNxZ1PMY+R4t864qDsHkeeCLl4fQSl+Fu
         rtAw==
X-Forwarded-Encrypted: i=1; AKwUvBw/Mnp2BSThcQ+9FlMC9Jlvd6dNMZ/LZcTMUnku7jV2pkEzJEXISOLunoJwZ0cgtJ6n0CoT1gg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LA5g9Y7fUwGS0smJYZzg4aTxkVZjdxlaeVMFqJowQflPgEUeE
	ccwmuDZ9QtcTbpuOjok8piHv1XtfxoiB/XrWlIKCokWSPpZCZBfAWLHx
X-Gm-Gg: AYBFou2lKfhlUlQf/sV/2EOpxKk/qhOEJ9E0Uh9MvlToYIn3R6HKh16O2iQ2BYlWmVT
	5y0a/TTEtwIPLRg549Wcfi8+biF7i4+kqD4/SaKMosyhlfYWA/G+0HoyzmJ5zME6HayeWJj2US2
	UNmaiPhY09dyidCfhCwy/cNjuSdPCUBD9FZGshIocC5ctdsXEgwXWNzyn/jdpbW3gVowkx5+rB9
	ZbjcEqKCe8pIzelLUDtPMvlZY+xeyxs1H3H16zVjz9c0k1Eb0PQqIr19wuB4u1/q8TC/nSU0kNF
	CxGeF9N4rfjPqanzz0CQG9HKDDfwhNILxjCAHy/M6dNWlVmSR2+artSVWg2evjIeOGZjDJu62cu
	remABNlpyYQyip0+A8xLUBun2U5gwJ4gWKGx8UZh+VlFQN9jsZwHB3N7R6KQgF+uVuEpFrSc5yD
	Bc4hEpTMsbPcg42+I52Dmq4pj+P9nUEJ3KjcWznBuuCXBse86QtnyvynvHU8AZMLP9OU7ujs4Mc
	9u+eYJYNQtD3yF+TVrOmjMz7dnJxysxaha8Eg/VT9AaDGos51dnh429kAOA9YSqmP6NZw/rGPO9
	m3ItCFKQdUk8thjIUaa0fysZvTIStF+OK1el/jvqNA==
X-Received: by 2002:a05:693c:6304:b0:368:1f8c:5f23 with SMTP id 5a478bee46e88-36a4205b0bfmr29800396eec.0.1793714525925;
        Tue, 03 Nov 2026 06:02:05 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm56343226eec.25.2026.11.03.06.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:02:05 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] Input: cyapa - clamp SMBus block reads to the caller's buffer size
Date: Tue,  3 Nov 2026 22:00:06 +0800
Message-Id: <20261103140006.1587143-3-lui2012qwq@gmail.com>
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

cyapa_smbus_read_block() passes the caller's buffer straight to
i2c_smbus_read_block_data() without passing the buffer size; the i2c
core then copies the device-provided count, and any count <= 32 passes
the adapters' range checks.  Both the group-read branch and the indexed
loop (on its final partial chunk) can therefore write past the caller's
buffer.

The affected callers use 27-byte stack objects:
cyapa_gen3_irq_handler() (struct cyapa_reg_data, on every touch
interrupt) and cyapa_gen3_get_query_data() (at probe).  A device
reporting a count of 32 overruns them by 5 bytes, with contents
controlled by the device, in interrupt context.

Also make short reads an error: the "ret > 0 ? len : ret" convention
otherwise masks them, and the callers' full-read checks would pass with
stack garbage in the unread part of the buffer.

Bounce through a full-size I2C_SMBUS_BLOCK_MAX buffer and clamp the
copy to the requested length in both branches.

Found by static analysis.

Fixes: 9f1cd857518f ("Input: cyapa - re-design driver to support multi-trackpad in one driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/input/mouse/cyapa_gen3.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index fc3fb95452..730ac925a6 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -254,20 +254,38 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 		return -EINVAL;
 
 	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
+		u8 tmp[I2C_SMBUS_BLOCK_MAX];
+
 		/* read specific block registers command. */
 		smbus_cmd = SMBUS_ENCODE_RW(cmd, SMBUS_READ);
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, values);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, tmp);
+		if (ret >= 0 && ret < len) {
+			ret = -EIO;
+			goto out;
+		}
+		if (ret > 0)
+			/* never trust the device-provided count */
+			memcpy(values, tmp, min_t(size_t, ret, len));
 		goto out;
 	}
 
 	ret = 0;
 	for (index = 0; index * I2C_SMBUS_BLOCK_MAX < len; index++) {
+		u8 tmp[I2C_SMBUS_BLOCK_MAX];
+		size_t chunk = min_t(size_t, len - index * I2C_SMBUS_BLOCK_MAX,
+				     I2C_SMBUS_BLOCK_MAX);
+
 		smbus_cmd = SMBUS_ENCODE_IDX(cmd, index);
 		smbus_cmd = SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
 		buf = values + I2C_SMBUS_BLOCK_MAX * index;
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, tmp);
 		if (ret < 0)
 			goto out;
+		if (ret < chunk) {
+			ret = -EIO;
+			goto out;
+		}
+		memcpy(buf, tmp, chunk);
 	}
 
 out:
-- 
2.25.1

