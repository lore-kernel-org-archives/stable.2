Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810293;
	b=c3yNyakAdPobUN8vBdXKBttWEj4H6ZWQEzYhBoP1N365SObuxcmeT0INi5h0QVc2U2xg
	 MpK7Or1aKpC/QeBDwfo8egEBRWhyHxM226GZ3CJnY/HCTpKEWOnlvnLbIjlwdM4kpTVCC
	 OGfsCEiy+Bpf4ETtUYTBtEXux0Zdh+0y3LKVd+rCdNQeKRtYSCge06Kv4uUQVTGRFBnxS
	 uP1Eb9mKz7OEoxszt7DeRIRRc/crDz5UM6HgBoj8CMMSsDhJvESQ23QGTkSkHKWwk/bAr
	 GApGOrNBqDwrJNSnLO+jcMU94EF86Ohiw9W+ai85uZjyzAzYigGuHlgvUO5urleqn/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Wb5sLgyTJ9ciByxdIv0xU7QJ6xtgseRf/O5NmmuNpEI=;
	b=0PfuJcCbG2FXsyxpz3jyTLTZFluR1PQA1IRjuuzUfATlPhk009MvJkitafjTux0pOEyL
	 Ddu9Lykxw0tkemSgiAu5Pd8qXag7jeewlptin5sXl3botedNdSvuFNmqMGtkGg+/MUi9W
	 yhEqUiupOPKOHzxSHwlFd9WVypcT04PRfwbKLPur8DWNe2GeLMwbWdCZgimQoucfP7btI
	 3RsVSwsrFK505NKuEjy3Ww5oXUVQRvCTT2BXbrzcOZiBcoNpHmMhBSGN+biWkFkLEsf+Y
	 cwGiMDLVu5oQyzTXSJS95Vet9zyJcRcG39PnO4JUppmmR00SDsfXqHs1n7+JCSba1WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABzQGIpr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C6606A31C;
	Fri, 27 Nov 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABzQGIpr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE381F00899;
	Fri, 27 Nov 2026 20:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810293;
	bh=Wb5sLgyTJ9ciByxdIv0xU7QJ6xtgseRf/O5NmmuNpEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ABzQGIprL1UtFlBfzIhPYycookg6YVp9jM53YfxK6OdpGVYSO0CcYRMK9aW5ETyW/
	 u9p6r+pcwrj43udHBImlUVoVUZlyeuBPZvmKl9PTUGqoMPYUa+z5FKAjpEwDZUAXhQ
	 PzFgJDiR1tI08BIJlX/4BMb9PuYDuct5TMjHx24oE1AmO6dwMYmCprh+38Nw9Alejc
	 9jDvv9n1va57awVo4reFUQgHAdTge0qQWcbSDrL+VOk2tU+1TCfpLtsLgGl/q14s7n
	 RRjmT1p/+i/SEtmTI9eIW7YVm1qqz8OngRRed4kdb5tBEJUiUoi9iUPzpZ32XL9BAE
	 SYrVJ+UCief+w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	David Heidelberg <david@ixit.cz>,
	Andi Shyti <andi@etezian.org>,
	Rob Herring <robh@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-input@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/10] Input: stmfts - fix i2c_smbus_read_i2c_block_data() check in status sysfs
Date: Fri, 27 Nov 2026 20:09:59 +0000
Message-ID: <20261127201050.3532488-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127201050.3532488-1-lee@kernel.org>
References: <20261127201050.3532488-1-lee@kernel.org>
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

i2c_smbus_read_i2c_block_data() returns the positive byte count on
success or a negative error code on failure.  stmfts_sysfs_read_status()
checks if (err) and returns err directly, so a normal 4-byte read
returns 4 without formatting buf (exposing unpopulated sysfs buffer
bytes), while a 0-byte read formats uninitialised stack memory.

Return negative errors immediately and require sizeof(status) bytes to
be read, matching stmfts_read_system_info().

Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
Closes: https://sashiko.dev/#/bug/linux-bd87edf0-6f79-4318-8780-d69205787e7d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/touchscreen/stmfts.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 2054c2254947..aada03f96940 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -699,9 +699,12 @@ static ssize_t stmfts_sysfs_read_status(struct device *dev,
 
 	err = i2c_smbus_read_i2c_block_data(sdata->client, STMFTS_READ_STATUS,
 					    sizeof(status), status);
-	if (err)
+	if (err < 0)
 		return err;
 
+	if (err != sizeof(status))
+		return -EIO;
+
 	return sysfs_emit(buf, "%#02x\n", status[0]);
 }
 
-- 
2.56.1.839.g22a8290db9-goog

