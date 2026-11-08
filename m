Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105810;
	b=E1GN7Mvq3w2yFKZnuIlUlLoph6t0Xus3yzGix+8ZxjLFclbfmlaPM+ylCiohRkrN0SJZ
	 Vhj9yvs1EeRQ8DHVbNd+4ay0e2fnsSE4gCGYnfkUF6uWWNQUIknNN4qo1WGYytkWTbaLk
	 XU2ER2/0suULv1ZP2/GyJOnZVIwiHxMr6oNaFOLHo1FoLqLmm/8d9zNHbBViZjHXzlvHr
	 AxpevzB1C1gKOqVi4ZSNBMllcLvRIjoWUnDLMQS/p9ntT5d+S+rltxZrpEWv9ixFNw1l7
	 b+Ju5WDCDT4/X9OfmJukoD4n3KTxxH9YAwUjoqNxMFMkF7odnr4xFfzhJedQCdncp5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NFuoGXXrkyFliEzMqju+9q+B5cpIirOFosUPmdC6VLM=;
	b=vHwzv7ZvXsPEouCvbf5yCr2Q3siFTeR1u/xZyUPMACtEiicx1hnVne76y/xG/L5I3N0+
	 B2la9CTQFYvhkzuuAhy9F4eNiy/fT2C/1+dyXId3xXfUBQdTGdaXfLObzCesBaBZ0DoEH
	 etSZPbg7s/Yi3E/Tz05YiC2lYA4z9Ii2soWJpn9I9wDo+tcZ+LkjtJPdG67tQm+RUS+89
	 Etc0N88eFObseUIBO9VXwWCQJUvn9R2xpKRW3U0n91TXqZVaaptLH0REi67gknPo6d1ep
	 BSBpxC1agBzS3FxEoTqsh3AQysp+7tUVYuhH+RhqLxq7869yzCPFU4eLIWm87e3MtAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=Jl9pwlY6;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDD606A31A
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 02:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4EDD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=Jl9pwlY6
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36dbde64409so237364eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 18:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1794105808; x=1794710608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NFuoGXXrkyFliEzMqju+9q+B5cpIirOFosUPmdC6VLM=;
        b=Jl9pwlY6Vz8xlJjs9eT7zB2WA7ep53ej4TTB6op5RXS+tQr+kUo6q8+nqH0cWxg9mV
         PUvdsc0gXlDmdLJcC7H4qJTR6t04xcbZT9aot/C9RIt1pJh1xHBqYTriHsQfOCz1YLWD
         zfJFnaeaySI8KlwMOkjt9fth0DtjnRHtVtFonr+ShnG1xghQIR2aWntFTfLMf4iRS6OU
         EYzqYzHJGff+dyDJkJTYnGqSdiYYy6iyyAoducnEJjfoWKgz64MSFCPidpF8bk9psPrG
         x+JsF4OJXq8lj1hRQifAHtXf9oV9pOthlqo2MrsAq3gUsn760llk2LhRHMqa/g1qS86b
         cirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794105808; x=1794710608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NFuoGXXrkyFliEzMqju+9q+B5cpIirOFosUPmdC6VLM=;
        b=B7v0+sJB/ugm5Mt8veVXWoIwQ2j3IIv+trV3zjLfmzs3InGLHj0qKdKMQqkpY1SB2Y
         gpLDfWaSU4wpTwyqvNMr7J6uU/UFAtw0aIYf0SWuz/eQiaqzoMGhYQdQly4fRVgEpNfE
         DW2yEAOWx+eeKRDiOy8JCQF+dnPTTfop8+2sspJLCWipSL/yT53kTjL/LQ5Wmn3NRas+
         r9H+gOuU1GA3OPKfxDW5a1ckFtsG9kPqDtG50tvvrMBrUL6WGNK8TnJLDDrA97PMYVR1
         WSZxgid/7yBHriAm5Cq1AkTPZ6trnvp24XEAD0NUlmZSpcejBx3sVWg1N3RbqlIzvfY4
         6i1Q==
X-Forwarded-Encrypted: i=1; AL+hErF5DiYMa3BVboVt9ehW9HMZWKEW7qCmIs7dwwSppydj2PVjMShhhurNNQES1Gi2YBGK9Qd7hTU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CFc9oU70tPccxGUsg7hXExkaVVnS6dKpNwIaM9p37zj2i/f2k
	5eWZFQ2cQk5KcClajIeVA1ZGm3gw2aZXVJSNdH9wF95jQLj9Rw2Et7wgc0M3HGauNw==
X-Gm-Gg: AYBFou0oZbjT8e2ir+nwLM2pa1q0ekeDZVJS1wXht4uqFROxbL8TOw7iTVzhsRIZB8Z
	2HHE+ccuSPFTAKI3T5MWmQf5mdvV1dvl3Bf47aEoXSfhWVqTP1JvIf4WrHFpVeiQ3LJoy1OA1Gt
	H27s71Czl2DBzu8LXb7DH5+8r0eNWEH9Hqf3zRP5yX4GZNubGN2xeDn8d5LxrNO8YjfZPHy5uZw
	R6B2uZKUvQcVvjetT7or8HoaiOE3jvGnT0l8+KrBTsXMMzW+sE+aeijVHIRxHu4nKsJUVRMlcNE
	lSmcBwZoopt7q4EYPFM+h5/LAjNMEyhXHx8pdLPxwwTpDjDz1HjKS7NpLWRzn8sNCmdL19uaqPX
	Y4cO+80ILmXXui5qLqCDKFwYwHUsH/ZQn/iW0Icx1zIG1kvOaur3Mbz3/7uH8ihXcrBSedsJPID
	mApu53o/VV9EU/9YjzlUU24vYFBX8qX+bZhj57hmXMHeeMB1Oe3kg6VUq+zjxiKo/CQx1bBxJ81
	AVde1GeQU53V8bGYf3DwdnPrBbK5jA1MbAP3pREgbn2bNiqNAuJvnQv3+UxN33tmQ/OHYONvauC
	Cb+U1/vaSPFsdIEBg55lHpw7JAMivZHpLN1MmHYQlEfptS6cF2QEtsI9LetlGFiGfvFihYdOvD1
	ObD3bk4wiYw==
X-Received: by 2002:a05:693c:62dc:b0:36f:5746:3369 with SMTP id 5a478bee46e88-3725807c859mr1143986eec.24.1794105807738;
        Sat, 07 Nov 2026 18:43:27 -0800 (PST)
Received: from mparker-home-xcrbr.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372665db8bbsm1681203eec.22.2026.11.07.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:43:27 -0800 (PST)
From: Matthew Parker <mparker@arista.com>
To: pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Parker <mparker@arista.com>,
	Adam Calabrigo <adamc@arista.com>
Subject: [PATCH v2] mtd: spi-nor: gigadevice: Add support for GigaDevice GD25B512
Date: Sun,  8 Nov 2026 02:43:17 +0000
Message-ID: <20261108024317.898917-1-mparker@arista.com>
X-Mailer: git-send-email 2.51.0
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

Add support for the GigaDevice GD25B512 512Mbit (64 MiB) SPI NOR flash.

The chip exposes valid JESD216B SFDP tables including 4-byte address
instruction tables, from which geometry and opcodes are discovered.
Status register locking is enabled. Read, write, and erase functionality
across the full memory array have been tested on hardware.

Cc: stable@vger.kernel.org # v6.1+
Co-developed-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Matthew Parker <mparker@arista.com>
---
v2:
 - Drop .fixup_flags per modern SFDP discovery conventions.

 drivers/mtd/spi-nor/gigadevice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index 6a2e6ebda148..fe05c0f0370d 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -64,6 +64,9 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		.id = SNOR_ID(0xc8, 0x40, 0x19),
 		.name = "gd25q256",
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6,
+	}, {
+		.id = SNOR_ID(0xc8, 0x47, 0x1a),
+		.flags = SPI_NOR_HAS_LOCK,
 	}, {
 		.id = SNOR_ID(0xc8, 0x60, 0x16),
 		.name = "gd25lq32",
-- 
2.51.0

