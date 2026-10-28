Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217029;
	b=B8dkEx9dURR6cY/gvE38vo9Jf0VS8b3yquIqMHrAEG9VDcBH6GO5pik6Y7Ss5zAjfS9X
	 Z5po7TOrJm/smRbua0k+qMEMOdSqOF2LxUIpF678r1PNPhPR2IWoU0nGCX25TgyP4Bjd4
	 goUU64VHvipWSzNFTJKOt54UxTH6PcCiDX7ICLspJoTJvadLj5MQyRtOOKNxGJlqjFJ7q
	 blXnMcPMcrgauLb+BT76Of2CnhuoWjTT/mQKSyPj7oOj8jL/fOu6+kARMNDtQPoHNa1Lu
	 7T5x/q/QL+MOlPlZNe1qfKuLaQ7f31KSJwwV06YRQ9jeVKEp7KggEDF6+IQ/PFMk3YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=fom4yvaENzaHnSG42GyLTccOuWuaPzKK86KyGa1FSTI=;
	b=ILi6fXASAMSMQdkEtrMhz8tLecP8GN6GGWmfG3IDbU9QByYMfTFEEilVWl9dxyeveXKr
	 PlqFVqxRwCxGnadAopNjS5561UXrYye8ofEIloWlqUR4zpnCuWnrgEhX++EO72ZDGhcbI
	 JzqMQJgWs87zoSpBz2/jV2vE7RTfaRY5ySq1DuHUMxOi+/AJSN8rIsgrGBYmAexSp4qK9
	 V6EU7iZmceN9v35NYg2XM5DF5EF688d1JyCvqSD6j9eCSZBTQH3cw91qJyJa7Lb8ot0jj
	 m7ugJ8pJrip76gdXv78p1kiKkRvm1lQ4G+tl8o1oHEYeRnYzeKxXB4sPXLYP1FKvzQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIGq3gNS;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D260A260C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD3D260A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIGq3gNS
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a214af2076so11969805e9.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793217027; x=1793821827; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fom4yvaENzaHnSG42GyLTccOuWuaPzKK86KyGa1FSTI=;
        b=TIGq3gNSEQTGFE8dirwFKRkWnd2Scl2mBdvbI3o75uLkytzDGiMdvcHJ7K+8HBB91j
         YMCyy5YoVCr6B4L/aMd8GXJ8cWK1y/M7cuXQDJtkpMLRZiNK3HjOXQSJ/naWqYQglkiW
         3up1GCHSKhOS5YT4aikidg8Qq5XCIxwk6otkmHO9up4rFsuFa3GmujedpuO1x8cLU1O3
         YrqwJLryCf4dFeXsLlHOkzbCU33UKhzJDCRBO7wD1zi/nEUXqqTaLR7gKm1g/AegosYs
         P/xLfute2jVjbAycdQdaluXrl7sht7ZYMtoN6we0YeCDrJ1zOYhdrwaI3cQEm9M20xxh
         GRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217027; x=1793821827;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fom4yvaENzaHnSG42GyLTccOuWuaPzKK86KyGa1FSTI=;
        b=Rs+N2xnf0F8jmAJLehxCE/vxJCDmeabnjM71abvp9dJfOtW0FBckGGcK3eDDVA5T6Z
         cAalkMME3V1toEftS2w7XjnbJh6qcaEYJkO7bpKhLnPIuVLHiwgw83d28i+4SbPBPu6R
         mlbwU9JbyvO+MXFwNZU3x21vNh5wzd5PCMURe3Myo9Jou4W47A5YOdcesZ8sUDIfsGJ8
         /Aac3f/zFIJGb8Grpaekm68Yl1qUcXxiFfn6TNIqGRN+nFWDGnJUjRXfayeLPZs79t8X
         WiqvWVyhoNu68plyyYd9WuM1V92an/JC88eMgCktR6pj+j3gF7sXwh4gX9hNE9cLFwSn
         jrCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgM6V82zy1y3TkXXrnpAyaIraXwu3vycK201xBG12pHqHil48CpK+wH69LF+m/FZXqh6uatBc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQdHMursorYNLjY1X9/aX43c3T7tlTCZ5c1qKwzukBgJAfwUo+
	a3rQ+QCdEZGt6XL56kLaiBULGqOyjL44iGGj98Rk13gKyy4MRZiNAkV0
X-Gm-Gg: AYBFou3kBI/5PlXRDG8/GMu+0GEUxjToQYTWvTAkteSHFJZqpsgPxGNMtVbAqb3WvYf
	W5QzXsKiWSAsk13r2A0fsiXIPzGV6mR9Ayn7Q2xSu1+RsxCiDwY15cQzl8V6d+Puia9PxMosxh5
	zDe9JmTQsTxTsqwKTWVy6Gf8rObFN14bZhvwmONIvDf4udni9oYXLRPu8hv2kJO4uYLQkqj3j8C
	tJbIrhNFhJSxWl4F9f1ltFpgex2kxDET45sFvzebAScsSHVkwvN+tE7KxE/idrY5mRrD58sipyl
	4iRy45VLLWTWIqkjxveKlMfUnwYDrz4bu3VuBy2xcImfA/nhrD2+T8fr1SIX3NOtxu+1PlLXyYx
	Yivk/752Gj7SvyOsBBTSaj+XItaRvRy0D/oXrI96clhRuyQvAltpE6+V+MyIaFDSawf+LM08B8B
	ld78h/QeL71wrEyYqMJhbMKpTEq+zUiZGNBQQQWJMgLk8pYej0k7MuMszU6Fogkjdlf0Enuk4Gb
	l/15YR1UIHflgtlCp1Ql1+lDQ2YPSHPrI58JSA5iTFrgXuUM9hD4EITGCh+smhWGh+2d6rbsVoI
	at0oTzy31bORZ6n+AJvOOruYdbcNS8IZ7K5YXwgtj698NfA+vPm+7szPQUqAi5Ap4yD18HZNYPr
	kv6ZE+opkVljRfjsDAumXl/p93Bv4u3V9hQam2+b4JPzVxGQV4ffuKEqcwc8a/THYJd8pdnhOX7
	Va7ATgZ0k8P4DKU1o=
X-Received: by 2002:a05:600c:530d:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4a966774cbemr70339165e9.22.1793217026916;
        Wed, 28 Oct 2026 12:50:26 -0700 (PDT)
Received: from PC-Marco.local ([151.59.117.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896fesm15170845e9.10.2026.10.28.12.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:50:26 -0700 (PDT)
From: Marco Ziliani <rylos78@gmail.com>
Date: Wed, 28 Oct 2026 20:50:18 +0100
Subject: [PATCH] ata: libata-pmp: disable the SEMB port on Marvell 88SM9705
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-pmp-88sm9705-v1-1-cf951fe74573@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyML3YLcAl0Li+JcS3MDU12jNHMTwyQTY9M0QzMloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAWrVLmXAAAAA=
X-Change-ID: 20261028-pmp-88sm9705-2f741b435f16
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Kyrylo Biryuk <illofspeed@gmail.com>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marco Ziliani <rylos78@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793217025; l=3551;
 i=rylos78@gmail.com; s=20261027; h=from:subject:message-id;
 bh=jq/bX4Fw2tFf9xoqbWcRl/77+7jumFvnKruLVmfuESM=;
 b=QmP1T7AMCqTiyXZgs9/3e4KvTqqNeOjWSzyF3W/gT6zMoxHave+E4fbXSsO6v2doE0t3tfwvm
 sb4mnLBhg4SD/A6vQVZvPszY6XNAoJA+QQ988f7EhJwSRySSHCdbf0B
X-Developer-Key: i=rylos78@gmail.com; a=ed25519;
 pk=nXCfiK5yExPZCMp+lfKif3gdXkfjkUK2qk7bDW+ixMo=

The Marvell 88SM9705 is a 1-to-5 SATA port multiplier with one
additional SEMB (SATA Enclosure Management Bridge) port [1].  Ports
0-4 are device ports and port 5 is the SEMB.  The number of fan-out
ports in GSCR[2] is 6 when the SEMB is enabled and 5 when it is not,
so on boards without the SEMB there is no link 5 and this quirk does
nothing.  That includes the common 8-port PCIe cards that pair an
88SE9215 with an 88SM9705, which report 5 ports.

The SEMB port never answers SRST.  libata probes it like a device
port, and every EH round on the PMP ends in a retry loop that lasts
about a minute before EH gives up, then starts over:

  ata19.15: Port Multiplier 1.2, 0x1b4b:0x9705 r160, 6 ports, feat 0x1/0x1f
  ata19.05: hard resetting link
  ata19.05: failed to resume link (SControl 0)
  ata19.05: softreset failed (1st FIS failed)
  ata19.05: hard resetting link
  ...
  ata20.05: reset failed, giving up

Disk discovery waits for this, including disks on other controllers.

libata.force cannot work around it: the "disable" horkage only takes
effect after IDENTIFY, which the SEMB link never reaches.

Treat port 5 the same way as port 4 of the Marvell 88SM4140 and mark
the link ATA_LFLAG_DISABLED.

Tested by the user who found the problem (see the synodeb link below)
on a Synology DX1215 expansion unit (four 88SM9705 r160 behind a
Marvell 88SE9235), one disk in the DX1215 and one on a separate AHCI
controller, one boot each, Debian 6.12 libata with and without this
change:

                                      without     with
  "softreset failed" lines            60          0
  disk on the separate controller     200.6 s     18.6 s
  disk behind an 88SM9705             203.3 s     21.3 s

Each PMP still logs one "failed to resume link (SControl 0)" for port 5
at probe time.

Link: https://www.marvell.com/content/dam/marvell/en/public-collateral/storage/marvell-storage-88sm9705-functional-specifications-2015-06.pdf [1]
Link: https://github.com/rylos/synodeb/discussions/8
Cc: stable@vger.kernel.org
Signed-off-by: Marco Ziliani <rylos78@gmail.com>
---
I don't have this hardware myself: the problem was found and measured
on a DX1215 by a user of synodeb (Debian on Synology NAS units), who
preferred not to send the patch. It is carried in the synodeb kernels.

Kyrylo, your DX1222 has the same 88SE9235 + 88SM9705 chain: if it shows
the same port 5 retry loop, a Tested-by would be very welcome.
---
 drivers/ata/libata-pmp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 904f418387..72bc458568 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -482,6 +482,19 @@ static void sata_pmp_quirks(struct ata_port *ap)
 			if (link->pmp == 4)
 				link->flags |= ATA_LFLAG_DISABLED;
 		}
+	} else if (vendor == 0x1b4b && devid == 0x9705) {
+		/*
+		 * Marvell 88SM9705 quirks
+		 *
+		 * 1-to-5 PMP with an extra SEMB port.  It reports 6 ports and
+		 * port 5 is the SEMB, which never answers SRST: EH spends about
+		 * a minute per round retrying it, and disk discovery waits for
+		 * that.  Seen behind a Marvell 88SE9235 in the Synology DX1215.
+		 */
+		ata_for_each_link(link, ap, EDGE) {
+			if (link->pmp == 5)
+				link->flags |= ATA_LFLAG_DISABLED;
+		}
 	}
 }
 

---
base-commit: fb2c3f44a7e14627b9dca8e6b568e6cdc234b40b
change-id: 20261028-pmp-88sm9705-2f741b435f16

Best regards,
--  
Marco Ziliani <rylos78@gmail.com>

