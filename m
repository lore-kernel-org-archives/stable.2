Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A129E10B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959760; cv=none; b=OT/tIFdApnQTVyRIZYOwVXz+DwSwzLvd4HhLwbLvq5Md/Ytjuhj9J3EjmC/O4X9xM1xVwCEX3kdUXJ7Os1PMscC4BUxc9PcoTuSer6xUF2vlb9rvkTB/CU7RblmI2eSgVxqbF8gswbnd5Q48m51RCMp3oEjYOOLTp4Y+vm4/K58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959760; c=relaxed/simple;
	bh=FcfKgVtidTGfawbNAsZlmWstyb19QYDw9rtu6XxxEfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6qSMDWPJ3gv/3aJ0yFD3cUyuK4ZZZe5oLs1gSmsLY4JvzAL5+n3uhhNaoOXGqzVeFjnm4jnnX3qRG/6f1e1keUZupPa12T8YY0IBud7dQXGHMzF/41sFR7cPr1rlHWcPg10ZGH8BBPBAGZC+xllPlV92N7RbirWQomB4NjJg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7Ow9xqL; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Ow9xqL"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so2873522a12.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 20:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959758; x=1790564558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvZbxSF2qQnQhtXPVG06mkg9nimx73LR88KWFA5uNNc=;
        b=D7Ow9xqLtdgGKU/XQ1zv/syW18wc5rFFy7bZlsmqHa9n8TMD4VkN5tCC8baisnHBhM
         b5rFmjlr4GAxhL9FIcCWXDGnCFFIKpCpMxJ9gZHHDrO2+R++kRxHZTOcIOpydJ2a4ji+
         rcWque+saPx+fVrs4+D4e37Rvg7mRJcz2+nAksuzITVAQl4EG6hAiJabyDg2snzkzmhz
         Elf2UyjKJ48TL0d7BviZ87/yJ4tcD3rD3HttNthQRulynV5NDN1nlHvW8ToICxzM8h3Y
         4/ALEO3xDr6Z+XJEor5F+gfgtOM0No6O6XrYfh+Jiei3I0dqphUUaRWbCA6/if/0U6Lj
         zXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959758; x=1790564558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hvZbxSF2qQnQhtXPVG06mkg9nimx73LR88KWFA5uNNc=;
        b=Fg099lsGKxPRJ4Nm9egNKLTbqymSu1BnfgJkUhV6APodaUFaRrdewBiLYFRDoVxLyT
         iAZrkUfHAwYLTSma3NClt95L/XF+uK9RZaH3CxOvW7c0gEbH7vvvGACm4PpFUsEGrarf
         a0Vwr0ix875VtYa0Ku19gw3u+KcAax+bI2VJ7Rsf9STNQ3egJH7GedzGvMrXn25EIPIZ
         K2v22S9YnFiXPKKNrj7MqzJh+iwYdXVQxgDXTD0EZ3+WdY3FkGQ9yBGyxZiAklsPn4yR
         wUxUKI/nuot+ea1M4FiAyjCnnNVReIwceQtZlXuvzTy4Tg11Jq3Dnh9cXzJoiehOQfNK
         IdzA==
X-Forwarded-Encrypted: i=1; AKwUvBymiMwDTU479sxnxHKl+7jABUP2NY3HQMxsh0RpfEM+mh5wSDU32akImcXdL0u09Qu87qYkD3A=@vger.kernel.org
X-Gm-Message-State: AFuF++n0UUjBPYAwfeFqZ0gK7Ty4E8aazyvnPvfcDAjwPeX0I2q7t6vq
	4MAob4M9L2c6eE2PGlgNkx76eSd55+ZQYX31BI/3FYrHUFhaPJ/YbFQt
X-Gm-Gg: AYBFou10vhl5mAcmVtSLpimkwJ+WhMoMFRT90qqmMuXlftJUa9I4o/m4AbcF1KxWF4O
	1wkY0yfJCqUsXQM1CfM9n5u4cEz6TRAgXvfpX35r/1/h07CY4/YcZtZ6QwD4suG1cNtKPhnB1sd
	ystrLS3Bp6N9mKDBHEl7ecsbiYFQoVlK1l3FhfEJwegWvHmehO6x59j1vyCmlCnfI1uOkNWcmbA
	MXuxQWz+jmPysmpoReOkySScrAzcWeyYDk7mD3vq/t4HXT7dQ5Sxjmj+4PqnDNNg0JXvjjRGPEU
	EgrF1oHtpHmVi2SvxHxYZFw2ed8kPw2KuNUvttZnFDl4lW5e1LJlXD/lXoygy8dxnbap/ZOnE11
	14edlvRilErMtx2Qq6+/N18cxoUWugWJHAv/1ykDKmPceS3nkUTgv7HNn3rHFnt7UC4p6jsV7aI
	LiDchhcwjqF+SdxXp0ECCSWNgEgYYLSSvDxUIr9aoxCADm3FtDp6Kri7zajXpGBa7EXAgqDevtB
	soUB9tEaJvTaIuNyCicCByPZVOoZUG30/4a7JL53x0fg+Qkui3HTO9moKe9EZsftpYVD5Eu1W9G
	dlz/K3qf+g==
X-Received: by 2002:a17:90b:2882:b0:39e:4c81:6c95 with SMTP id 98e67ed59e1d1-39e54f3d98fmr14405553a91.27.1789959758256;
        Sun, 20 Sep 2026 20:02:38 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca50118sm11806311a91.4.2026.09.20.20.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 20:02:37 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4] USB: serial: garmin_gps: validate packet data length in nat_receive()
Date: Mon, 21 Sep 2026 03:02:36 +0000
Message-ID: <20260921030236.1040858-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <2026092059-hacking-coveting-c629@gregkh>
References: <20260919112819.3885778-1-benquike@gmail.com> <2026092059-hacking-coveting-c629@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nat_receive() (called from garmin_write() when userspace writes to
/dev/ttyUSBn in MODE_NATIVE mode), while garmin_data_p->insize is less
than GARMIN_PKTHDR_LENGTH (12), the loop copies up to 12 bytes into
garmin_data_p->inbuffer. Once garmin_data_p->insize reaches
GARMIN_PKTHDR_LENGTH, nat_receive() computes the total packet size as:

  len = GARMIN_PKTHDR_LENGTH + getDataLength(garmin_data_p->inbuffer);

Because getDataLength() returns a signed int from __le32_to_cpup(), a
12-byte header with a negative 32-bit length field (such as 0xfffffff5,
i.e., -11) causes len to underflow to a small positive value (12 + (-11)
= 1) without any bounds check at that point. Then garmin_data_p->insize
>= len (12 >= 1) evaluates to true and nat_receive() calls
garmin_write_bulk(port, inbuffer, 1, 0), which allocates a 1-byte slab
buffer via kmemdup() and immediately reads 4 bytes from it in
getLayerId(buffer) (and again in garmin_write_bulk_callback() when the
URB completes):

  BUG: KASAN: slab-out-of-bounds in garmin_write_bulk.constprop.0+0x3eb/0x500
  Read of size 4 at addr ffff888002cc0ba0 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   garmin_write_bulk.constprop.0+0x3eb/0x500
   garmin_write+0x60f/0x1450
   serial_write+0x123/0x200
   n_tty_write+0x8ea/0xeb0
   file_tty_write.isra.0+0x44f/0x7a0
   vfs_write+0x671/0xd20

Validate the unsigned 32-bit data length (dlen >= GPS_IN_BUFSIZ -
GARMIN_PKTHDR_LENGTH, matching the existing len >= GPS_IN_BUFSIZ bound)
in nat_receive() as soon as the 12-byte header is present, resetting
insize and returning -EINVPKT on invalid lengths so garmin_write_bulk()
is only ever called with a full valid packet header (12 <= len <
GPS_IN_BUFSIZ).

Tested in QEMU against Linux 7.3.0-rc3 by emulating a Garmin USB GPS
device (091e:0003) via dummy_hcd + raw-gadget, switching /dev/ttyUSB0
to MODE_NATIVE via PRIV_PKTID_SET_MODE, and writing a 12-byte native
packet with data length 0xfffffff5: on the unfixed kernel this triggers
KASAN slab-out-of-bounds reads in garmin_write_bulk() and
garmin_write_bulk_callback(), whereas on the fixed kernel nat_receive()
rejects the packet with -EINVPKT and 0 KASAN faults.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Kept the fix strictly inside nat_receive() and dropped the other hunks
  from v3 (garmin_write_bulk_callback(), gsp_send(), and changing the
  return type of getDataLength() / getPacketId()) per Greg
  Kroah-Hartman:
  1. Assigning u32 dlen = getDataLength(garmin_data_p->inbuffer) locally
     in nat_receive() and rejecting dlen >= GPS_IN_BUFSIZ -
     GARMIN_PKTHDR_LENGTH (matching the existing len >= GPS_IN_BUFSIZ
     check at the top of the loop) prevents both negative/underflowed
     lengths (< 12 bytes) and oversized lengths without needing to touch
     getDataLength() across the file.
  2. The out-of-bounds read in garmin_write_bulk() and
     garmin_write_bulk_callback() was only reachable because
     nat_receive() allowed len to underflow below GARMIN_PKTHDR_LENGTH
     (12 bytes). All other callers of garmin_write_bulk() always pass at
     least GARMIN_PKTHDR_LENGTH bytes, making a separate length check in
     garmin_write_bulk_callback() redundant.
  3. In MODE_GARMIN_SERIAL, gsp_receive() already bounds insize to
     MAX_SERIAL_PKT_SIZ + 2 before calling gsp_send(), so the extra
     bounds check in gsp_send() was an unrelated defensive check.
- Added Cc: stable@vger.kernel.org and QEMU reproduction details.

 drivers/usb/serial/garmin_gps.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index 8020149f5658..a3f599043a4d 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -769,8 +769,14 @@ static int nat_receive(struct garmin_data *garmin_data_p,
 
 		/* do we have a complete packet ? */
 		if (garmin_data_p->insize >= GARMIN_PKTHDR_LENGTH) {
-			len = GARMIN_PKTHDR_LENGTH+
-			   getDataLength(garmin_data_p->inbuffer);
+			u32 dlen = getDataLength(garmin_data_p->inbuffer);
+
+			if (dlen >= GPS_IN_BUFSIZ - GARMIN_PKTHDR_LENGTH) {
+				garmin_data_p->insize = 0;
+				result = -EINVPKT;
+				break;
+			}
+			len = GARMIN_PKTHDR_LENGTH + dlen;
 			if (garmin_data_p->insize >= len) {
 				garmin_write_bulk(garmin_data_p->port,
 						   garmin_data_p->inbuffer,
-- 
2.49.0
