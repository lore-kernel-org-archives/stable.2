Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794097802;
	b=asO9qAEqoR/RB1HQgHQ+nq5HsINq2KbE3BCqpeHOfPQPT8uoM/Gc9uZ3CVZ9t8gGSJlp
	 +gr09NyWMeenrKu61Q6DLWUcdHzdUhQPkIvrh56EtXR6hYaIi/P33XEzpu42PbU/ei+Od
	 IvaT+aFlxzGHnp7lAzlK92ElKrx+LWSNsFgbVg4cSu6vw7K/DpEn0fTrTB3EMBEnmMpAS
	 kR1BpcqaIr2TAEIQPe/yRnTJVJtmr4audXFksPFaNd4E5CbH3vk+CyuLFfL/KLK/L5KKK
	 CScGLKxQjt3DyZ5YADKsQylQON5/XugKyadNGan56Zx/NzH+K65S9wQkFwdpeI1hQhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794097802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gDHxHqr/ibomT/hnh0MWIWapUMs27ULmVZLfvv9myQQ=;
	b=Eb6FuXObQXPYyLe1KyQIPn4zECZfQmygF+IhcColk1BTtCI4j5dvojKGvrUR/oSpXdtL
	 Ij+cLcKMmUO+PbiF5+SdkNT/oDyAC9/UFutZApS9UlpWAbf0SmeHNBLStkeJr0zvrxKu1
	 OFoWZkBYy1U+eE+WiaWtZVBxv8wp7+Tke4CMGawo0YPdfkoaNRBzT+l/C2GS4pEWUEIvw
	 ufAf+yicYXhpAJOgYan1tJ5yznvqgtba15OIlbWBnSDczQsdHMMsvoyOWqmQcyVBOYIcI
	 oWQRVpmkonz3hK1H4Jxm+iGN4H5eJkQ7/YCiB1sw23qX9VCjCzzReY+/fBSnXxnVm+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=MLQPO1dD;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11108606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11108606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=MLQPO1dD
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso204311eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 16:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1794097800; x=1794702600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gDHxHqr/ibomT/hnh0MWIWapUMs27ULmVZLfvv9myQQ=;
        b=MLQPO1dDE+oPvarGm3CN53yJG58+L+kRV93dly67pB5Hd4I1mgJi3gamgrCgC6A3/R
         MwntnL/QJn4R3Mst6jFA8kQ7ZQRRNguPEk6OzePsKEhz9Yj0uPJOqDv/lTUPpy6SpNoU
         NY5xlYvQj9B1vWiKS0dmbHknWgIQw7hWO4/sItn53DtadPP+TNKNf07y681nfR6lJj+K
         2tLPVsnoSR3jcfVtBt3zMcTzqrGRpxLtNALx2qZEZD0jKQV/rNOsIW1flQWBqqwgPeXg
         oZuUp3f0IYF+vp9hbaL3IrnZ3tydEqi4FLmRp/usnXwdoIkdDjRGKwDElTbGr7T7SH43
         larw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794097800; x=1794702600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gDHxHqr/ibomT/hnh0MWIWapUMs27ULmVZLfvv9myQQ=;
        b=oT6QdngbDO3wFpjrLrHZ6z55UBOw8mSphCIBijOMCpD9VxeRrytfeQnxUztaMiQwUn
         pbSszbeS0QuhDJ0pKkKMExiQBF1e0s2m/73bCGAMzd9TlMyndnlz6BvVyS3wvPda/CLw
         0dO3m0CW8BjuBkdpj6n0WNkOIXTJBN6CVWjObxaDuckRr0UbssXef5VUN2KP9yxoLd15
         9HnNmtAF2YWNDJn2Qrwg78LkbRNOr26ttYRi51It7809bW/qDjubn9DuWHeEL8b3LNfv
         oCYzV3yC5krfJ/wxAXCWyvQAc+E0T+lDteCpm6Yr6v6l/8wTz5xb7bygSkiDbvMZPbUv
         /WYw==
X-Gm-Message-State: APuU4Z9Tbuh0v5YhWundPMSmmcl1s+Rw2KLIr9/Pbp0r2i2vceE4hoI5
	+yT+MEcwhfDLKoTlT54mjU6+dAnOQ3dKBHSO6a+CQq8D27pMeQpOIxRcS5Dj8wreQw==
X-Gm-Gg: AYBFou2H1xyYp3N+gCzVrQRKeuggvQLitmvraLfoywsqwlmCYvgp/hNujQQblJ7a31N
	Irgwn334KoU4diCoLijYJHb6Iux97qjHf3rVPvFH3XG3ZCsz2QF5Pc3tfS5BOyu4Mbzbm4ucDlv
	vNUvxiM+jz8ESQU3vWY58w37wArGuUlXUqFmtYrBgFtQtrINQDwylXIe6nOPFJnrpiWWYCgJzFX
	dpqtYOYRCK/KrpHALuJNtUH5bRcBO8QkFz9ILEFwOOTu+aeaaXx6qZ1XKLMKYdHCuaE5gVIC95p
	/lCbJoaXeX7n/IN5EwBZdLOIu66RpJZ4HInZAPCOsSifj5GYTbb1lLxRtBZA3BW1BBtCMtbEs9K
	smn7QRSZrQR+26846iEIF21KObyvMRAwvOkJ9HAB/FyRFUh0fiHYwyywQ4ZhpotFOHt02cD0Dvn
	BjDhGumsBi4m+6HT52MAf7B4jQhLx1eWpfxgUAne49+4ZSAlUkcqnvyWzuKht8Fbwp5XgNWTbLA
	gClI5+Hpw02p61Zu3g8SRSnV8HPK/DwU/aHEysvLVErJVxm7UX5z4ZWx475ASjpy1j4IGFv1GBi
	cerV4I8lxsZVNUwyZwd3rlM4H3aF0R1cM4zux5tT7KENgthchVvKr7f1YLL7flt9
X-Received: by 2002:a05:7301:648e:b0:36c:a390:8907 with SMTP id 5a478bee46e88-37255a4e72amr1095637eec.21.1794097799873;
        Sat, 07 Nov 2026 16:29:59 -0800 (PST)
Received: from mparker-home-xcrbr.sjc.aristanetworks.com ([74.123.28.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265618d59sm1129474eec.6.2026.11.07.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 16:29:59 -0800 (PST)
From: Matthew Parker <mparker@arista.com>
To: mparker@arista.com
Cc: stable@vger.kernel.org,
	Adam Calabrigo <adamc@arista.com>
Subject: [PATCH] mtd: spi-nor: issi: Add support for ISSI IS25LP512MG
Date: Sun,  8 Nov 2026 00:29:27 +0000
Message-ID: <20261108002927.896632-1-mparker@arista.com>
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
fast-read modes and erase geometry. Flash read, write, and erase
operations across the full 64 MiB array have been verified on hardware.

Cc: stable@vger.kernel.org # v6.1+
Co-developed-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Matthew Parker <mparker@arista.com>
---
 drivers/mtd/spi-nor/issi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 2f057d731df2..977dc5ba8028 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -101,6 +101,12 @@ static const struct flash_info issi_nor_parts[] = {
 	}, {
 		.id = SNOR_ID(0x9d, 0x60, 0x19),
 		.name = "is25lp256",
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x20),
+		.name = "is25lp512mg",
+		.size = SZ_64M,
+		.flags = SPI_NOR_QUAD_PP,
+		.parse_sfdp = true,
 	}, {
 		.id = SNOR_ID(0x9d, 0x70, 0x16),
 		.name = "is25wp032",
-- 
2.51.0

