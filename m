Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794103665;
	b=LOpiZXvWDqSGCcLRdKWSQc1NDBvb4GjrrLlgMLcqWqVEPbTkgTzXMCkPP9H7rMGC/c5C
	 oasMFRBPZkQ9QR/LcIQEiPZ1MnC6QNuA/i4VwtWZ7wlw9GIbTcTHuOK0cyphEgJODWLVO
	 dq0I9E7T/zd1v6YIe8MpwO4ltxKa4b9OPmMWIJo83X51PAoFujhDgDUT8NpSYyntuhzoj
	 WjCI7dpNsJAwty6nt1AF+kJlBsNznE7AdrkdgY7TkCFa0MVSRBIBBQbvrXV+kLjbp1Cjn
	 g2iplBhdgscq4xTFVyGCDnfc36iCV2LNT/eFS3xdGUP8xUQqUv7rD3vRimMMDL0ZmuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794103665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nAUid8jDWzly69ovFD3scbJRnE8PsLmVF0z4XZSSRog=;
	b=gdhqBnj+J9o8JLlQRsVkZi+MBtlY5wEh6nvN+wE2nA+krasBeCsYe5EibCE8BIoz5C2q
	 Jt6IjmaQdvRvRouXiGlIJB5y+LGWDFVTfos0FqLijB3NvWPHEOOMhXW5jKnEMeG+8UtpZ
	 kL6YYEVQrfWEtrmc/fjpNwLH4Yz7pHtkyKNYx0+CQUTigdrLYJaRQkHsqD3YLFeOXp/fA
	 aSckAQidOpIbZE987DIXH4subh1NJN2YEV5CIrRLPrjj8ha4/u320cjXomqdMzanSrFN2
	 s4pfMRQrRLjDxt1vvyklxRgz+K3FlRom+J67cKjmPs2STnpzP5BceXul+4KMGZLnoLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=IhKUbDQj;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE97606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 02:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE97606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=IhKUbDQj
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37198ed3727so663490eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 18:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1794103664; x=1794708464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAUid8jDWzly69ovFD3scbJRnE8PsLmVF0z4XZSSRog=;
        b=IhKUbDQjcYwTGbkZe+oDjkxeTzfQ9brHcWJG8mz//DTeK96at5NbhgVoUSsGkrROa/
         6vaZPnWPziU01Vrla4WrTIAT8eUgFic7dlYAamPszk6Vp2k30wWxNSIt4TT2QE6YqaP/
         sZ8MHHCQclybKt2FpVZEgZvkT2NIpn2iz5gBvfj6wyOSe+ZFgpenJkNCCKcwcyYTwG8w
         k7Uy23KBK40TOng7YPsY6Co+zZxCeRjUHQx2Ig7pgPhr9kv2zN9TnFHM9rzMtmfnCxeh
         GQn+zzvj1jgR50EmhbNgftjX9wvkFdiCg5FnfH0r8Ik3AUwnfJfvEgP/Vn+Yi7JZOHwh
         IfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794103664; x=1794708464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAUid8jDWzly69ovFD3scbJRnE8PsLmVF0z4XZSSRog=;
        b=aGwqrerUhQzKqMF57bZIhtjlrIvLgYMUEMeiGmcTpqX0KXHOhUHzQsuxlQ8hFlntX/
         TG/pvnch8l8yXQskQFIW1ZLhsmGw4pZlE52+56oiCghDwFbjgdeLmZlUsuWfulUYUCdN
         F+1nf8Eq1zmkmsM4mIdd5EEfVfZL5A63KHXfj12LLwWLNYcNv4F/WBRIKDbJUPbAaC+y
         8OqMhFmSLCgKZCGqU7CzCydhveABCUCC44PvEvHoMLKktu2cm5Hq4YwPAjRbRNIX0E3/
         x7TqWuqlT3+QOBKP75syvUdm8pEasd+pFYMJmCwOcAuQaqZsggRfRLBD32bzeaVj++WM
         JC2w==
X-Forwarded-Encrypted: i=1; AKwUvBwrzpHQOT/6vxK0WAo4pifeJxCyOFWT/1r8TRR1Sxt6ha6uqJQerj4eWM4Dn7AZ9Qy565js64A=@vger.kernel.org
X-Gm-Message-State: APuU4Z84I406/8FQ/N0Qc/tQsfRhvAqQrpXUb0eiV5P9FdNQW0UipWCq
	1QwH9zKqKVhW1y/2phv1XPcjJcaDB6Avq3h5z6IMRHcxV3h8fqgWejwmyBKYXbkR8Q==
X-Gm-Gg: AYBFou3oza/58F/nbSrnSSRpF/O88cqntgrYk2VvWVZkWf4c8vrjlmaJcmbl7CdqD8F
	wzDRvWpfPyWc3X2YOJ9qTqrUjl4zYiqL4ZT146OoVZfQQv/qfpvj1bZmD6PZNT11DXYoRUu3R5x
	cJJTeDNeIiR40TNPNqj1wQeaH7hB49NG58CSygFnKhLAhlCsvvgv8Xur26PpTdZVMptMipfJCAy
	kZIl1Ho8Y2Xev4ebxUeeAYmHOmZseEpNQDNT5Nbu8kDVli9gye72FG0s9VbevBv4zapc4wN01A9
	+Jd7YsLv50ASfd7GND+VoP44PNFgC3CftoAMhRfvG7VXADJrQDc9m4Uv7CZVs0QwsMoQDJjAq+g
	fNZVSxS6RuAdZkeZbo6o/q6JvjoQR2Dfd2II7VZXd/LUVgFkpJ0FGpEbTlqFXvhcXOOVDqDXaei
	xw0DHNL3tDvkG3scEyvTN2dPQaw283BYWl5RzkwvG76SyQMF4krTz9h4OcZ1Rd0zvhTEk9f7Zga
	XtsldVjRyPCRZraJe69fK5sfrNyDPE2RKgDJv0C48ETHcj7VVJoFdFeUo7Z/WsjJXUbwT4dfayE
	PgAkqCFTS6kY1kHQBAbLgNvGZWRbQLo9/rhU+LwFYCldpWh+KrcZMaRsD+qSj2+r
X-Received: by 2002:a05:7022:170d:b0:1ae:d447:6c84 with SMTP id a92af1059eb24-1b269b21bf7mr4108916c88.19.1794103663378;
        Sat, 07 Nov 2026 18:07:43 -0800 (PST)
Received: from mparker-home-xcrbr.sjc.aristanetworks.com ([74.123.28.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37561ccabsm2133832c88.12.2026.11.07.18.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:07:42 -0800 (PST)
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
Subject: [PATCH v2] mtd: spi-nor: issi: Add support for ISSI IS25LP512MG
Date: Sun,  8 Nov 2026 02:07:12 +0000
Message-ID: <20261108020712.897714-1-mparker@arista.com>
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

Add support for the ISSI IS25LP512MG 512Mbit (64 MiB) SPI NOR flash.

The device provides JESD216B SFDP tables which accurately describe
geometry, erase types, and read-write opcodes. Flash read, write, and
erase operations across the full 64 MiB array have been verified on
hardware.

Cc: stable@vger.kernel.org # v6.1+
Co-developed-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Matthew Parker <mparker@arista.com>
---
v2:
 - Drop .name, .size, and .parse_sfdp per modern SFDP discovery
   conventions.
 - Rely solely on JESD216B SFDP parsing with SPI_NOR_QUAD_PP.

 drivers/mtd/spi-nor/issi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 2f057d731df2..d2b812050550 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -101,6 +101,9 @@ static const struct flash_info issi_nor_parts[] = {
 	}, {
 		.id = SNOR_ID(0x9d, 0x60, 0x19),
 		.name = "is25lp256",
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x20),
+		.flags = SPI_NOR_QUAD_PP,
 	}, {
 		.id = SNOR_ID(0x9d, 0x70, 0x16),
 		.name = "is25wp032",
-- 
2.51.0

