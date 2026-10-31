Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793457681;
	b=QdNlxXr6Pq65Tl+zET6CnxfFPEeZ30zv7EZIq/6UHbrnX9c+aw6YNa5JTyagFk9dxRGG
	 20tkQWtjTIBDn1EuIiTD50Lvzq6SEvAoqu4kzPH4Y3OgiC1LQ33k4wyoB7HVJ+Eim6ZSa
	 x52OLyZ8SuSEiqSIiS7VBaTzEKTfZUpnmxlc2LzzkigJQ5WY6mkzQs5bk/iRNUViT+MCC
	 K3TapJ7plv/bMM9Aor3yNk7fyE1VfuBNqsC4N4WuQHUkR+y/AI8eGj25hgjYAwrzWaCXA
	 x3us9eQFH9XggrIfaqVqdrGt42AJkjSUrm8RI3Egso4AYYFSbxQG0LPYo9aR+ods6FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793457681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oCTOQEu19vJBXJZSzplSgZ0tLJZz7jYyxcdF5qx0J8A=;
	b=lR24jKlnQGtyQmN/qqHFp/qhDIqgPLcPPwcF6gJzMK3cCcgNkjHknMgaSixHbsv9FvHI
	 pfIqqp43ovMaHlCpgvJu/RjKxfeMKMjBDiRvVGj30O+8Rd83+xx26k7L0d/EQ7BUq1FTf
	 RpIGyIYyKKnItSQdEbiVqvdQPIc4TPDWHB2bplzy9bmfXHgNl1xq0SgAQtA0xPYYmanok
	 ++Kn0HpZ2CRr+laH8klKWwLDotVi/T6psoJ/6zewNHlOe+oLiH+UikXp6wfewreZI755S
	 q9XycY6cveUm+4oyYt06FmhAGrnTzo1pLwMBGLb1Ww40/iwQtxYgrogiFlhvnwkqZMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+0Zn6Lp;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE533606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 14:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE533606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+0Zn6Lp
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so13362985e9.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793457679; x=1794062479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oCTOQEu19vJBXJZSzplSgZ0tLJZz7jYyxcdF5qx0J8A=;
        b=F+0Zn6LpVJkO0s9itSEl6vzhKyFlbNanlpwhwgkV95PMhEQYnpfvCMwa8aXCaV7/C2
         b2s6hpnG07tyt6seYAbyNM7h4of6LC+dOWMG1XfIs1uoPUlRa5/WUtxpdyk+1hcqZJ6S
         yo/cuiIQ82FH2/MzEkAoq1BGGhXsws1Tsva85OiEYDyl1sm4cs2IFxBQ6QqkLJldCAcM
         IGGP3zyq8IVStMNZ2+ETWO0g8XNRdpo4inmSaGgNahygeF+nOnfqfGTudVtt6iVv6ocU
         YAzS9Dfj5uPrio9CTuKUOI/AY74t3jIeiqw0wbRT1d+KjM0K9WOKZi7kv7J8gVojnZmn
         xo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793457679; x=1794062479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oCTOQEu19vJBXJZSzplSgZ0tLJZz7jYyxcdF5qx0J8A=;
        b=iXa4AnE+gktVj/QyrOtjX9c5Tk9n3jTq5FNJF4EpcQdXbO7S9Yi2rXNFQyARUBbsDM
         Tioni2uv7VHDvJLVCz32jn05jBgfcTHHiJ8OlBd1fBKZZc0gxIoX33y79ru6K+XDfnPc
         oFLIMQ24mvLC3q3L7Bzn0ZDMmKOLLmDZQC6NKApDFcm1tUSnk8U9T0bla+wE48Xwsmmg
         sNSlZ7uDUoNSWFuWX752nFbQUFpsmt8yyABNfqthBFXtOJM9H98Ls4O3+BV1zQjIxGWF
         7gsDQS4huMAqO5jv58XMnKQgE8Yz3eGHDVATI+jl6PqnpyQRrwFW6EuLWAl94Z8hpfQe
         SRZg==
X-Forwarded-Encrypted: i=1; AKwUvBxKOAsLZyehePHGf12shOQ6ri5sa6P8jfD4DkCqTZ7gauJBvYbRuEzXYnJ0f3V2LgBaJDb+chc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJZNzGMzcP0DC/8iy3CQh2HJp5rPjYaEbEawhyQdSVTXcRRmzf
	kELA6qpLUYkZ8ASwAdWe8VM2lq5U20yy3yBjfxRr1csy4uu4tnQy5EL1
X-Gm-Gg: AYBFou1y6yIXB0E4nuFh+KRkWiZ/v0YqszqahyetUxpQfU5a6RJNDYNw5BcCJL4xY1L
	S+pS5/3ZeX/WYEM2qS/J2WxLna7OAT6DAl67nUZ51w8WHGzdn0tmu2N2J1UFYxvVAmC1JGj7ynO
	GKxca1Y4giQRIghFqLfIDl9nRx1qP/UA5maWcOz8F3j+iV9GzNnnlBwG9ThNPKcGFFATQ/ZEONs
	Ji7HZ4VN8HHIhtEX0dZmrJKGtiV2n25b+PfgMzEWXfnFtYvu0eRF1j7UQpgH4FuGgOVH7IxYeou
	B+T23Xb00YDUUQCjtsvDlY68oGIlhdn0elEQRmvioOAc+S9bV9LJ3L5cM5RfaUzVWM1reLswwel
	3gD3V7LOam4SSkxPrFkPiknug4c3q/z4xPKsb+8OBCFY/9R+OrJLMYvRwcxNTw20vUpS1iph1Te
	nR6/48eMlMtDXw8q5jT4Y1GdSXvT+hESg7w6ZSHb5mF2VkIyGJB3AiUFuPl6aTQYtj7WoNz9Pis
	efwDez3JYxvayUzcHS+KkcxOxzCkIB5qAv2wQbTtAG8GNU7Fg/+eByjmERhxAeJikWo+ryrBw9r
	Rr4R1cFEu/8yVgUofw5StD1EUIgYM13azMxJ7v1BlCEo
X-Received: by 2002:a05:600c:4e12:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4ac1765cf2cmr129879855e9.19.1793457678846;
        Sat, 31 Oct 2026 07:41:18 -0700 (PDT)
Received: from localhost.netbird.cloud ([94.242.199.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aab10sm132090535e9.9.2026.10.31.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 07:41:18 -0700 (PDT)
From: Andrei Galiant <zakat1984@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Galiant <zakat1984@gmail.com>
Subject: [PATCH] ACPI: resource: Do IRQ override on MECHREV GM7RG7M
Date: Sat, 31 Oct 2026 17:41:15 +0300
Message-ID: <20261031144115.4189-1-zakat1984@gmail.com>
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

The MECHREV Jiaolong17 Series GM7RG7M (TongFang GM7RG7M, Ryzen 7
6800H) describes the PS/2 keyboard interrupt in its DSDT as
edge-triggered, active-low and shared:

    IRQ (Edge, ActiveLow, Shared) {1}

The keyboard controller actually asserts IRQ 1 active-high.  On AMD
Zen systems acpi_dev_irq_override() skips the ACPI IRQ override for
GSI 1, so the IO-APIC redirection entry is programmed with the DSDT's
active-low polarity and the interrupt is never delivered: the embedded
controller still scans the matrix and places scancodes in port 0x60,
but atkbd_receive_byte() is never called and the internal keyboard is
dead under Linux, while it works in the firmware setup, in GRUB and in
Windows.

Add the board to irq1_edge_low_force_override[] so that the standard
edge/high override is applied, matching the already-listed sibling
GM7XG0M (Jiaolong17KS).

Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Cc: stable@vger.kernel.org
Tested-by: Andrei Galiant <zakat1984@gmail.com>
Signed-off-by: Andrei Galiant <zakat1984@gmail.com>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 56df459..0a944ba 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -553,6 +553,12 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
 		},
 	},
+	{
+		/* MECHREVO Jiaolong17 Series GM7RG7M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM7RG7M"),
+		},
+	},
 	{
 		/* XMG APEX 17 (M23) */
 		.matches = {
-- 
2.56.0

