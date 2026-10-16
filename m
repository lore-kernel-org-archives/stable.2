Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447AA4AA56C
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156101; cv=none; b=sGzeFs9Xvf5K3TjNJXQeZkgXfaj/4IkyonMkrZ9NyR5f5sK+jpARN7F+E+O7B3GD43BzNlt46FRbcKYNq213vPHQ69i74+R+saYucwUeDy0YJNrUHItXEb30kghIDuCixH793DXDpvKTXzgjhxlj57pkqT6U8B0Phar4Yw0TQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156101; c=relaxed/simple;
	bh=Z9vuHvIs5djMkOSj7qyB+HFnspgEuOMY5kkZwLyT16k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uug+UlHVGm9slBdYDE18kLZbWLGnmfges7THvc/bHc94f6Jr9uzBlAnlJzqezXLOetCTZVUyyutZCXCh3VxeygIv4ExuP9D7zvhB17McXR64R2ffwqJNpyDulVVN/rJuoscu0+Ug/dbHZKKBSj07l9JYrVKQjaVw4mfu2uast/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ+kTy8S; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ+kTy8S"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso3405602a91.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792156100; x=1792760900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m8EDc8rZac4RsFY8nAVqxYalOxuPA5SriPQpdHsNWSs=;
        b=mQ+kTy8S9dNAksavMLkACgVHGhTePoX8YJcJTFHY1LeEQD0letI3IBBSbRZXPn5yHA
         RZzUS8WltPxCOpLYFjdK5cE+NluuQefe4XPLeexGUkvztcKul3ByFKm7kBWYqiUAEji5
         xGpzrrSYez4Lswj0dAcq/6vOKeFYvyjn6LpLDdh3JVMtb5FlwHrH/TJgZdyEXV6j8H/z
         yrYL/PVbCWfhN2lCjATYSoRc6TbFzEixs/arvdylK9oHrilOyLeQwQEouqzklSn22mly
         pJ7McIaRbfECCoTz73yqDaYQ3N93t5he+hBQBp0To0J5tw8Tx0zzXAbdfgR6MvNmxhMJ
         jG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156100; x=1792760900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m8EDc8rZac4RsFY8nAVqxYalOxuPA5SriPQpdHsNWSs=;
        b=Fyj90mMWaMCEYUcPHlTShh909JO+bdSdYzQi8EynLXOs/49DEoD0GbqSzLISGc0hGR
         MQ8a3VLY+phFcjMpFatXVxdoHQ5m3Pyrg9jqmKGbOO4x5YjabYVH4ffven4ayK+nF3XD
         J0ln21MVdOgP06Fdw8lSYT575LbVIAfKFVmZyGflSabrvCV6nDZxUDw1UcasRZcozk0y
         AOKIld6qvT915eIt4uHCj2GwY5sCYW6nJIOf9b3J+rUhDDhq4lF7Ja0AQVQmG5K4ixcq
         2k0yya7VCeBVvp0TycmdwJ2Ud3twpuukgtTePR3B98M0jFwcCHWkEWAbaTxG+YsNwBVw
         JZCw==
X-Forwarded-Encrypted: i=1; AKwUvBySk2dtCrJNxHtcvBlHvuwbXRgcOgsOhBV/kamfUmNtHaoD5cznzGoEvXCj2zJuERqDlVzzvBc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJb+xumaRh2jVEdx+BwjtsA1XakdgDQzBZ8EbwwA2cJwHTO8eFk
	6zXjg5x/wM1jCSAaK85w5Z46fz/4WL4Mf9kynhvgq6xkmkGYzSfZlUMiuV7WWdZLIzVbyb+/
X-Gm-Gg: AYBFou0nHBFWGJOVB+qsK070LAg1cekHu4l0osxpUvc0S9H+k56Iv5WbR9qQbW8eIBF
	36BFrnigQKqffFgusKSct5zznA+uB58zf12GC7k+YLSqHoGBn2GyDpZYICrvvxDLjK2JvZhxOSC
	DIS0wkYDtH1J3GOpNWarIrnLLKGqK1hJgk3wvHU0NylwCCDRMg/nt9QgFYSalvmOgQ8bwvRcnjO
	XiYZf3gQXfjZxBF0FaUJGL/x5EMVUZw163Tmi0D5X2P7C7x97pnuxC6MHg95ZOa2GTZ42dZxyKO
	00Ly6Zq4ApRXOVRL2RuVyaiE3onjvLApLlUVbcPGaFr6DIA08VDf/zFoaSRlwQvYQmyOAH9LQfz
	yoIHhIxYgSyCPDThodC+dae9tSRUzv68fu9U8Xfk2n/m0Oeq9P5237Vn/+GnceVYL0i48OAv9TK
	ZDgnKH6t+JQmd8wHpiBXZVYkXOzeGvoBtiyB0I0UJ8210zToOmAgKTE75Qfi/JPAdf23Vo/NP1c
	QS80RG4tjGY78oWrH/a
X-Received: by 2002:a17:90b:258f:b0:3a6:dc51:cce9 with SMTP id 98e67ed59e1d1-3ab3a96634dmr18516390a91.57.1792156099489;
        Fri, 16 Oct 2026 06:08:19 -0700 (PDT)
Received: from AERO17.taila7786d.ts.net ([156.231.115.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ee274sm4190467a91.4.2026.10.16.06.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:08:18 -0700 (PDT)
From: Pufan Jin <cyan2254650260@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] spi: zynq-qspi: fix address buffer corruption and support 4-byte address
Date: Fri, 16 Oct 2026 21:08:12 +0800
Message-ID: <20261016130812.282624-1-cyan2254650260@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In zynq_qspi_exec_mem_op(), when transmitting address bytes, the driver
iterates over op->addr.nbytes and populates xqspi->txbuf[i]. However,
xqspi->txbuf is never re-assigned before populating the address, meaning
it still points to (u8 *)&op->cmd.opcode from the command phase.

This causes two severe issues:
1. Memory corruption: Writing into xqspi->txbuf writes past the opcode
   buffer on the stack (which was passed as const struct spi_mem_op *).
   If opcode is zero, xqspi->txbuf is uninitialized.
2. In zynq_qspi_supports_op(), operations with op->addr.nbytes > 3 are
   rejected. When paired with SPI NOR flashes larger than 16MB (such as
   Winbond W25Q256), spi_nor_spimem_check_read_pp_op() tests 4-byte address
   support, which fails and causes spi_nor_select_read() to drop all read
   capabilities, failing probe with -EINVAL (-22).

The Zynq-7000 QSPI controller hardware in manual I/O mode natively supports
transmitting 1 to 4 address bytes via its TXD FIFO registers
(ZYNQ_QSPI_TXD_00_00_OFFSET).

Fix this by introducing a local opaddr[4] buffer in zynq_qspi_exec_mem_op()
and explicitly setting xqspi->txbuf = opaddr before populating address
bytes. Also allow up to 4 address bytes in zynq_qspi_supports_op().

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Cc: stable@vger.kernel.org
Signed-off-by: Pufan Jin <cyan2254650260@gmail.com>
---
 drivers/spi/spi-zynq-qspi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index d762aaf45..bfcbcfe85 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -229,11 +229,10 @@ static bool zynq_qspi_supports_op(struct spi_mem *mem,
 		return false;
 
 	/*
-	 * The number of address bytes should be equal to or less than 3 bytes.
+	 * The number of address bytes should be equal to or less than 4 bytes.
 	 */
-	if (op->addr.nbytes > 3)
+	if (op->addr.nbytes > 4)
 		return false;
-
 	return true;
 }
 
@@ -526,6 +525,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->controller);
+	u8 opaddr[4] __aligned(4);
 	int err = 0, i;
 	u8 *tmpbuf;
 
@@ -547,12 +547,13 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 	}
 
 	if (op->addr.nbytes) {
-		for (i = 0; i < op->addr.nbytes; i++) {
-			xqspi->txbuf[i] = op->addr.val >>
+		for (i = 0; i < op->addr.nbytes; i++)
+			opaddr[i] = op->addr.val >>
 					(8 * (op->addr.nbytes - i - 1));
-		}
 
 		reinit_completion(&xqspi->data_completion);
+		xqspi->txbuf = opaddr;
+
 		xqspi->rxbuf = NULL;
 		xqspi->tx_bytes = op->addr.nbytes;
 		xqspi->rx_bytes = op->addr.nbytes;
-- 
2.56.0

