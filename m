Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543C45562A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754771; cv=none; b=CazvPMq6GgPecfAbm+U4qN1uVU9v07FCnLrX9LoRFXzlJ9UI75g4lFDZaB+FV0SS0X4dcVPERR4kh4A/IVtlY1jEOc6BErq15UMunv1rWl2RlkKXHAPVVc69l0KYAITXBdHsoUyWDKQd0YdK3/6p9+92RjtZ1bSC/p9435EDr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754771; c=relaxed/simple;
	bh=FcfKgVtidTGfawbNAsZlmWstyb19QYDw9rtu6XxxEfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjBRpkLhSdfd78xkt4vVUsV/y5RKkbFBLQlmQZjdQwK1cNPAIpYWk8M7qK2IH32373r7xDe0pMXpQhEYzc2FLS21QBGXfEuFpJf6yNzL74oHn7X1KYiVRyFYiBwDecehoVdpcfmw6HTfRuLhmFxOE3NhbYuP4ZVQpxN3voCpCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMhZYuuo; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMhZYuuo"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so42578015ad.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790754769; x=1791359569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvZbxSF2qQnQhtXPVG06mkg9nimx73LR88KWFA5uNNc=;
        b=mMhZYuuoKAgjONELGoyNF5x5dTfFJm6BB22nnK6E3QRVIAghjONsvwLSqo8pJucGFN
         wF+MXvscjomXSBvB0VCbRTZ51oZJ32lj24HRxmzmMMSq2EXhVEZpteaso/cA149ugzxG
         gRclowD3uk9/S9rANTUejcBkEj+ChsL94k6DcGBqOjIyNquW5OcYv4Oot6MdW9Os8Lsh
         mXiLgw5D04mMdqvX9KuUWtT6wEeZFTa0yDHKjR1hD2CpoobNfMeGMbdmhvyF3pb5Cw6o
         DnsFmaG0eP+N/e+CHi2SbVWaBvNmCgk745N/32Ky7LeIEY3A/qOxAjg0FIyY7ahNufUT
         4jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790754769; x=1791359569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hvZbxSF2qQnQhtXPVG06mkg9nimx73LR88KWFA5uNNc=;
        b=0cuw+wMDLXUc3YkPz7XP9cIyPtKY1HwLZCc0Cxs7Mivb05cuPhxnCS1qalapGweImk
         vsyzExjbLPX89hW2PVWqQrhjUUyWr8Jm/OH2DSo96G/dpUB+xjquZR0pXknTLyVSfN3H
         Vpv6sppt+yobB87AR0jqEVBowJQbyrVEnz+ylAmttXatd+IRJu0K3ba69v+8Xg4rLkls
         bk7ATFhe4tEBxzRIuVF94BM6zdB+stuUf0yCPfUOyBS5f+Nrf8rnAkZ9sTb4PciRGJqT
         yBa/Oceypo5FlehdZIGcE5uDm4x6QvQjCKxgJ+FEOPwmOFXKv4It0f5hwdcKRDoRVubM
         1CNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbLPx7dspc1ZzWnW31VeLn2PT2iY1iLgh1DJx11KUptzmPkNCAWqWSUN/BxfoDtycWtcJK0a8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnYQ2lVHKB+Zj1jhjRuaYinoodCU05flcqo/IjUOWZNIhE9P2t
	31zF0K0U1CPJqNmMVe3oxoKerc/2Zyt818o/XW4GDMbu/kE11+huX3ye
X-Gm-Gg: AYBFou0C1ZPghriAOGi04q+3JylBxH7E2VTD3B6vJjt0ALH5PVXfLmggndbaXnnFmLt
	9w0XLBnt48JyWzc1CAjFuc2SknJ65N4EvXlKu/Qjq/ZGZRaTD0PmRLJbfJXYoGq4GKvZ4Uw6Wu9
	jZV2KNvaDN03ZA4I0ZDJ2Ms4HCaLItkHx+p0SjxoanFzwwqh2kc8a+jk16ePVunr05EKNP0vQRL
	AMB9fgw04nCY6aZBJLw275KqAVQ2qIQ5ga8nIGTtdESK4krj4LcdSW73p6Ee/1LTX+51S/C9ArB
	zNHYxyN4gH7s/jApU+dFzdfrXkzBN+I2V5xcAb7OJXL96GkGvmwF1b7Rlfi7tp6Hqc4PF0oqpkv
	HpWH+HamBvx+Ebb3x8OSUnW1BJr1XsF5ZlOMeM2DXcvLiZww6XgEsVUtC4E0wuD6aa0sIPr9a0g
	3JL1uaJi8oQNl7/Z3f6NYZ1lwI1XSW4Lt6EUEh9WIXU5ZQ+oOcvXsqkiHpcHEfbFSO+jMThua36
	OSgOmvspcWMYjyMfsuC6y6yr5sqJx9fG1VmUOxcI6RaUBWxGT57r+qYo8SqmmLIhCEB+Bbb1sUP
	7VzEktARPX9+4nOpkZn2
X-Received: by 2002:a17:902:e88c:b0:2d1:134:b86e with SMTP id d9443c01a7336-2e2e48adf58mr5499355ad.2.1790754769287;
        Wed, 30 Sep 2026 00:52:49 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c1408bsm3001265ad.64.2026.09.30.00.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:52:48 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4] USB: serial: garmin_gps: validate packet data length in nat_receive()
Date: Wed, 30 Sep 2026 07:52:47 +0000
Message-ID: <20260930075247.471109-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
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
