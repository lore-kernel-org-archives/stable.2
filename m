Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077953;
	b=RB98yR5iPyFT0sW371lhGjI0/MMMYidLBV5NwA5WhfIbCNMdHQTT6RMFdTp19YcVh2v4
	 x/dGjQ5j6sT6WvKYqO/H7a9KiiSORtzeESuWqzan176+7WccV5xOgGoVmOgAT4JhyHfP4
	 A43XWMgO/kV2SHwq/xM3aZJHtIJvJHNKNTKnX5iO858LzKbSAIC3528xaLeYwxusJQdpP
	 sk6ejklE2fo2R597CTazOR8VcxCQg8igKm9cXZijLrtuVnoNVkQIookiyFf5PnXfBUYln
	 otN4OMTYpjVR/7YmX9ws/xjNmV8UlU+ikZXv+x0iM7Qon4OwDoG0Z7pL3DbUWrrjGFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077953;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2AA/oYUrXjkSRDdR51JkLOpz5cVRl0RWCOUJKDjohk4=;
	b=ZOYd/KYE9MVj4ntasOGBmq2RTGX2jiK5lgXWMZQz4DwmZdUg3NoTkDNrUPCm3Zgscfi4
	 1ho5+yQ2hOWmSyIMS3Ey5pQxsBn4Sy1fXOwMphLNPDApofhydzywDPKITfAnY6vtpf4qv
	 iYRan++bqLJW8NH1yBwMEZmNKaFhUKAoJVp58oxXVS211xPdtdcz5Sl0BztDe/FdoudFQ
	 zyLge83l4Z+eY5FncmVIK/ZEnn11rHWx3FMJ7V/qMSGEeApLGySllof4MaKv/5amue87m
	 fXYGoTTBiqf4EdYBdNA7m82OE0Ce3ltmx6OFpWiW/sEWfTkuasf52fZlY18WEQ9wUog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=OafF10ne;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB94606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBB94606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=OafF10ne
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1795077949; x=1795337149;
	bh=2AA/oYUrXjkSRDdR51JkLOpz5cVRl0RWCOUJKDjohk4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OafF10nemQlnXrKZ7DeIU52XYi70F08/9whlmHVqB3UTTSzFYslCCcDl9Rm99kTuN
	 Ka7fg3Lt7U6SppVExhtvrB5COMLzDb85ibN0UciZZvyWX6rgCj/QBTO0eLmYGb3N2K
	 1D/BUV7Qv3Nah2xMdaRDfxCil8MsWsJwac6ZxLmgnW6EWuvzzn1YIOj9vgAlDevbg+
	 1VmxgKA3hbrLT98OQ3AG8Te0YCsJhCkY7KR/mzmkh40Zn7f8MbjqxwrQT12TRiOq6R
	 Mnt9FLADqnyURsIhUbT/uxIKUz5Q37e+kecxYRsquPndRb+OZDR2dp1gBY92tx/hdR
	 wjHuz8Qwwnuhg==
Date: Thu, 19 Nov 2026 08:45:44 +0000
To: Oliver Neukum <oliver@neukum.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: image: microtek: don't receive REQUEST SENSE data into sense_buffer
Message-ID: <20261119084526.535901-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 9d427cabd65eb9414ae8ed8c3daf0f7a0e9d031f
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

mts_command_done() receives the data phase of a REQUEST SENSE into
srb->sense_buffer (SCSI_SENSE_BUFFERSIZE, 96 bytes), but with the
length of the command's own data buffer. A REQUEST SENSE sent through
SG_IO, allowed on a read-only /dev/sgN without any capability, can have
a much larger buffer (252 bytes with sg_requests), and a device that
returns that much writes past the end of the sense buffer.

The special case is not needed: for the error handler's own REQUEST
SENSE, scsi_eh_prep_cmnd() already points the data buffer at
sense_buffer with at most SCSI_SENSE_BUFFERSIZE. Handle REQUEST SENSE
like every other data-in command.

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
An emulated ScanMaker X6 answering a 252-byte SG_IO REQUEST SENSE with
252 bytes triggers it (KASAN in dummy_timer, the HCD's copy into the
URB buffer; slub_debug redzone report with xHCI), on v7.3.1 and master
9d66f26fefac. No reports with the fix. User-space REQUEST SENSE now gets
the sense data in its own buffer; the error handler's REQUEST SENSE
returns the same data as before. Not tested on real hardware.
Reproducer available on request.

 drivers/usb/image/microtek.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/image/microtek.c b/drivers/usb/image/microtek.c
index 1f0b3c44d388..0b8d7f71c3c9 100644
--- a/drivers/usb/image/microtek.c
+++ b/drivers/usb/image/microtek.c
@@ -445,22 +445,15 @@ static void mts_command_done( struct urb *transfer )
 =09=09return;
 =09}
=20
-=09if (context->srb->cmnd[0] =3D=3D REQUEST_SENSE) {
+=09if (context->data) {
 =09=09mts_int_submit_urb(transfer,
 =09=09=09=09   context->data_pipe,
-=09=09=09=09   context->srb->sense_buffer,
+=09=09=09=09   context->data,
 =09=09=09=09   context->data_length,
-=09=09=09=09   mts_data_done);
-=09} else { if ( context->data ) {
-=09=09=09mts_int_submit_urb(transfer,
-=09=09=09=09=09   context->data_pipe,
-=09=09=09=09=09   context->data,
-=09=09=09=09=09   context->data_length,
-=09=09=09=09=09   scsi_sg_count(context->srb) > 1 ?
-=09=09=09=09=09           mts_do_sg : mts_data_done);
-=09=09} else {
-=09=09=09mts_get_status(transfer);
-=09=09}
+=09=09=09=09   scsi_sg_count(context->srb) > 1 ?
+=09=09=09=09   mts_do_sg : mts_data_done);
+=09} else {
+=09=09mts_get_status(transfer);
 =09}
 }
=20
--=20
2.53.0


