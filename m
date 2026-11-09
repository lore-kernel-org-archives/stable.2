Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190482;
	b=n+222yr1iWPo33lZRsmBTpVUFD1+U7mgxDDZcq99N2p9FbqvXiS9elP3KFqVyeMwtg3A
	 GscSvsu2+QYMdjYkqtB0F1mPu2JMup+i4seGHtkShxr1U7y1utAzwb4MOA0kR7FYtuU2E
	 9ejgn5KqMPjOuzZVNGrqGSlSxChNEx1T+DxRlXUNQu5LBkfmKKBGQAQWu375BKuSMxefz
	 cPG06D7EV7tSUtzHd8+ziN5/XPJmUBRSloxBceoY75ostG5yb1gfyyPpat9JKDudy3oFo
	 xQOVgWpZgbEJzN3DbS01Bj2JSZ43jsNEa5nwKNrWHNmv2BFrzB3EtZo3LBIjxpXNLAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J+h57vEeYMsDL7q4YjW7EJHuQlkp7BLgFsx7/CAjkpU=;
	b=gISmai+XFd5srDb2/UM28Y9nphMLAkQYhs0MtKU6+GvGo1b5nSDmoPFjCe6jbWRZmRCh
	 FQa9LeBV399bOBPc2vizr0LgHHWODatvEcn4YNGg2Tceq+MxO8OH/ebMmQJtiWDiSHyl7
	 NaU4/yPqSd5Vc3bLSqNquw2FwMUqsj20KUPndmDodP7QgnZM63QciNbH1lq0sg7O/tBHH
	 afJG4gg8lT5rCnZVchRR3JrDbBKPdpN+u7WaJPHDmGeKrZsmagH6LhrHND3xePqXlV0b2
	 YBJwUOZ2Xp7T+PLemc3WasYJZjPUGO1M4zR9FFAphwimWihiFYm/kiwXUVrtgkd/RQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=UfmvNmLX;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B825E606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B825E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=UfmvNmLX
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so900184eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 18:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1794190481; x=1794795281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J+h57vEeYMsDL7q4YjW7EJHuQlkp7BLgFsx7/CAjkpU=;
        b=UfmvNmLXs/Ja5fQ8ifnw5Tay+od7YLlFQ9zOGWBljFb31qqvAYjwnSkk+JYsPkCcHK
         1qakyi9kUxfmgXZCA8S3dtjkEB+B40tikfmzOD2VZMmtsAbFha6OMLa1koHA60IfGweT
         oQ+BWKfMcwUEuAfVaPQvUaNSWuiHVSJFbgLzCTl6iEmSzV7aqaQc3L9vCLFqoHXOewJR
         E/te70g3D1Wd1TKVVMYj34qyKAxda+Plm1SBzvQurtTDjdb2WSzupC5fQ0UUeP7G84/m
         Evjcj0dt7mfhvyjFTKwnWAOqPS4n6Dns4hWwkyVscuNMicu62jq6H11xVWxSfBN5tSSM
         p1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794190481; x=1794795281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J+h57vEeYMsDL7q4YjW7EJHuQlkp7BLgFsx7/CAjkpU=;
        b=FeR1AEwT67lSHirOKhyA2rlHDYzqWUQUB/j1ClO7j0MAjVIpmoefx3mYk7e1qd8q6l
         K3GJggKlieK8LkXFnBOu9yaiUWmwKlO5rZs3gpBI0aY88HNnvBcPubBuDoaFU99T246X
         v8BMUUxf2twsJMu5M8VvxfOq+0CAxCHvFyIzmKDyziQ1gLi7YAAKOYKUqUalL5oQTump
         Aa5TFOTjQoVO8w7ytjfcQ+s7g+eIrAvX75HRCpDHcBqFkG1t4BokMKgO2PboU+tLvUau
         kzY7ZhAHO3VcbrJXlwJpTQGD3O0Vv6YrJRmZvxKxpgHmS81xjw/dJMFUzpEyYRDuKhS1
         ggug==
X-Forwarded-Encrypted: i=1; AL+hErHgza6YO/t2mde1DZ5UqIyOGw4LByJ2NZlRsCS1z3nyeJzNJOjmQlIcvIS18w0Vn1EpbPa2abs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8w0w/Yy3wswLtXid7ikRxiM2vPmFiMx5dF9OlgTCCqdyNJLldL
	Fic+R8oBz5YqKZaasr7TUJj3vfDckv89xUowZyOOYTgOTmIVKUAX6ykAnQphRauszg==
X-Gm-Gg: AYBFou37Hkg3LPGR4Km6zyFuXT7DOz6oRlDkjxs8cR7vKsNUGp7LAn5TS4NZFGhv4fT
	dZCNJsgRHUtznJy4OFS1h4sudYe/kNLRaBfMa4D1ECdfxzDokBnJlQh/qO1Ii5nO+YGloG7WG4b
	hf1IcZGp491p3tyBreLkMpanwxWoSNvm9H0lHPiZGBBXBIRbgjeQd1isVl4Wcf6iBW8/2bDHFhM
	ZoHwKS7qduhVJGd0hk+kDDF6O8XBH+fJSV9odYtmFSDd4LAeDNduLRZKIKHNe6PgRtrB1C2bIM/
	VSSbLxsID5TVGH2TpfIEIhg5tzHSvsAh/v/Qyuw0lqwoID0qc+Iwz3dE+e2JpHoJeQrbUmKCtl+
	YmxHElZzfPiRQV2SjZFrgWw7K8qkIbhnAFrQZnmg/kKlOrxbMzvYmj79OxC/Ax2ilaNdBPuNCBB
	DQJkYrrN17TvxzGD3jAdqRLXqz/57Vy1P1VQmVLiWpCkHLh/PmFkcJWiow+NkLW1DRrsu/PSOpV
	bTSTYw4OmZkwPLcUfSMn7buN4goxEXInVq8icSYsEMQ69vwAw7Opv0esY5BuTA+4yRJj6ekIWYV
	Bs8rtTp8jKEu7D5ynyzFfAHOn8Xn7uEQMoGukpNomX9F3U4xhFho3Arybx8Kftri
X-Received: by 2002:a05:7301:6492:b0:36d:a466:9d0b with SMTP id 5a478bee46e88-372568fffe1mr5590031eec.19.1794190480709;
        Sun, 08 Nov 2026 18:14:40 -0800 (PST)
Received: from mparker-home-xcrbr.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d2826sm9392155eec.29.2026.11.08.18.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 18:14:40 -0800 (PST)
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
Subject: [PATCH v3] mtd: spi-nor: gigadevice: Add support for GigaDevice GD25B512
Date: Mon,  9 Nov 2026 02:14:35 +0000
Message-ID: <20261109021435.904625-1-mparker@arista.com>
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
Status register locking is enabled. Status register block protection is
enabled using 4 BP bits (BP0-BP3) to cover the full 64 MiB address range.
Read, write, and erase functionality across the full memory array have been
tested on hardware.

Cc: stable@vger.kernel.org # v6.1+
Co-developed-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Matthew Parker <mparker@arista.com>
---
v2:
 - Drop .fixup_flags per modern SFDP discovery conventions.
v3:
 - Add SPI_NOR_4BIT_BP flag to .flags.

 drivers/mtd/spi-nor/gigadevice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index 6a2e6ebda148..113db85f7bd2 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -64,6 +64,9 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		.id = SNOR_ID(0xc8, 0x40, 0x19),
 		.name = "gd25q256",
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6,
+	}, {
+		.id = SNOR_ID(0xc8, 0x47, 0x1a),
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
 	}, {
 		.id = SNOR_ID(0xc8, 0x60, 0x16),
 		.name = "gd25lq32",
-- 
2.51.0

