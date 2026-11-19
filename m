Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094227;
	b=5KA6ulxw9q/P9UfZPLp+tkIlzfZ4On3SbucwTc3KWg2UWuZ27g//ZWkwLXfOBBi3T6BC
	 1PrN7Xp+9UVoYsn5yIWdohtFFeDgJHJfQmF+elNWxI3GTaz8BRO4SVMRmF/W1VDc8Ny4E
	 c1OiUeH5Hr9SYm5pdzF2CX71LGp12WEquG7xydISmUsyXQPpu1mPrMyE5q9t2e6AxDpNI
	 bZLGHNWAPg7PsigOQeiRM3Wc4Ppbrm4VHeA8FDxrj9wlKntcMj029Lb6G2eEr+ck3VM/y
	 5jObmw6MG0j5AIDaFxXAOMpIT5Cxj7dfhW352l76mtkgMBVKVuC/mlG1JOO071Qynmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094227;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z/BBYeZCWdKo+dgO1M33Sr5kKilo/vdZ258+n1RCkQc=;
	b=PcDkwphrPIPlj5sgz8l+/j7ILOYbTYgCxT1OmIF1S/1m8X0WUak1PH6RjGcYwqI+lxZi
	 HCPSBN4xS2V2j/he1NQUMq949RDoewVO1jYa3QDOYO+bKt7qL+0SLxHp66PMPbT0rDsAV
	 KhE/muStD2mhrLh4HWII0D+EvTau+eT9HagSr8XDwhxyQn6CZ1VIVLrVv3wN1601fL3d6
	 LGfIYjorE5cw38zYmpHytcEAuKC+Jug66jv5B0P7eVtXUz8IIYqbfFilbyHwnBtmuGk1d
	 hSuuSDN28/wRM2GANfZ9VdiPmzTc+MqkQ4BOF77RLv0Ix720JkxqZwKznRGFurMIXMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=JVCF27qN;
	arc=none smtp.remote-ip=109.224.244.21
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4EF606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4EF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=JVCF27qN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1795094223; x=1795353423;
	bh=Z/BBYeZCWdKo+dgO1M33Sr5kKilo/vdZ258+n1RCkQc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JVCF27qNHGc9orjv57hVowIGxT133qRuEmRqvYc642rBTKMQsasOl9LHj9EoCSlAQ
	 9xd6LnDpowhH9f4mqOUObsHyGT7HHHe3dB4rFos8GFBz5KiYLCPtkOtSNkRAPrSUHi
	 OPhwxqhEuND+Bwq3Rt98mAOHPPngpyIkyViY/9sUisb77prJZ8VG7swJIGA7GKPXF3
	 hJ3yOulRfCgb1ffX3lFgEvGnj1oD02D9i/rbdygVxLGldtjDpr0xIddP6JEZxtc1WX
	 TZOp+Z1M8rGEsmd2VPLVNSL+wtins3iCBVGaVg+JRU0Nw4JN3E7XHoJxAH8fZUrdAP
	 YtqiTVnRINKvw==
Date: Thu, 19 Nov 2026 13:16:55 +0000
To: Daniel Mack <zonque@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Karsten Wiese <fzu@wemgehoertderstaat.de>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, Daniel Mack <daniel@caiaq.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, linux-sound@vger.kernel.org
Subject: [PATCH] ALSA: caiaq: stop the iso packet parsers before a partial block
Message-ID: <20261119131632.650637-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 58f06915aadd49c187784c5b7e7b4d3f65daae4f
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

The iso packet parsers in audio.c walk a packet in blocks of one sample
per stream, but only compare the start of each block with the packet
length. The block size follows from the channel counts the device
reports, so it need not divide the packet length, and the last block of
a packet runs past its end. A device reporting e.g. 62 channels can make
the driver read and write up to 232 bytes past the capture and playback
URB buffers in URB completion context.

Make each parser round the packet length down to a multiple of its own
block size, which depends only on n_streams and not on
spec.data_alignment (the device can change that at any time), and zero
the unused tail of a playback packet.

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: 523f1dce3743 ("[ALSA] Add Native Instrument usb audio device support=
")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
An emulated caiaq device on QEMU xHCI reporting 62 channels and sending
512-byte iso packets triggers KASAN slab-out-of-bounds in
read_completed() on v7.3.1 and master 9d66f26fefac, as do 3- and
12-stream variants in modes 0, 2 and 3, also with the device switching
data_alignment mid-stream. With the fix: no report in 85 boots (20 on
master); a well-behaved 4-stream device streams as before in modes 0, 2
and 3. Not tested on real hardware. Reproducer available on request.

 sound/usb/caiaq/audio.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index bb6280aa3533..c7d47f0833da 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -332,13 +332,14 @@ static void read_in_urb_mode0(struct snd_usb_caiaqdev=
 *cdev,
 =09=09=09      const struct usb_iso_packet_descriptor *iso)
 {
 =09unsigned char *usb_buf =3D urb->transfer_buffer + iso->offset;
+=09unsigned int len =3D rounddown(iso->actual_length, cdev->n_streams);
 =09struct snd_pcm_substream *sub;
 =09int stream, i;
=20
 =09if (all_substreams_zero(cdev->sub_capture))
 =09=09return;
=20
-=09for (i =3D 0; i < iso->actual_length;) {
+=09for (i =3D 0; i < len;) {
 =09=09for (stream =3D 0; stream < cdev->n_streams; stream++, i++) {
 =09=09=09sub =3D cdev->sub_capture[stream];
 =09=09=09if (sub) {
@@ -360,11 +361,13 @@ static void read_in_urb_mode2(struct snd_usb_caiaqdev=
 *cdev,
 =09=09=09      const struct usb_iso_packet_descriptor *iso)
 {
 =09unsigned char *usb_buf =3D urb->transfer_buffer + iso->offset;
+=09unsigned int len =3D rounddown(iso->actual_length,
+=09=09=09=09     cdev->n_streams * BYTES_PER_SAMPLE_USB);
 =09unsigned char check_byte;
 =09struct snd_pcm_substream *sub;
 =09int stream, i;
=20
-=09for (i =3D 0; i < iso->actual_length;) {
+=09for (i =3D 0; i < len;) {
 =09=09if (i % (cdev->n_streams * BYTES_PER_SAMPLE_USB) =3D=3D 0) {
 =09=09=09for (stream =3D 0;
 =09=09=09     stream < cdev->n_streams;
@@ -407,6 +410,8 @@ static void read_in_urb_mode3(struct snd_usb_caiaqdev *=
cdev,
 =09=09=09      const struct usb_iso_packet_descriptor *iso)
 {
 =09unsigned char *usb_buf =3D urb->transfer_buffer + iso->offset;
+=09unsigned int len =3D rounddown(iso->actual_length, cdev->n_streams *
+=09=09=09=09     BYTES_PER_SAMPLE_USB * CHANNELS_PER_STREAM);
 =09struct device *dev =3D caiaqdev_to_dev(cdev);
 =09int stream, i;
=20
@@ -414,7 +419,7 @@ static void read_in_urb_mode3(struct snd_usb_caiaqdev *=
cdev,
 =09if (iso->actual_length % (BYTES_PER_SAMPLE_USB * CHANNELS_PER_STREAM))
 =09=09return;
=20
-=09for (i =3D 0; i < iso->actual_length;) {
+=09for (i =3D 0; i < len;) {
 =09=09for (stream =3D 0; stream < cdev->n_streams; stream++) {
 =09=09=09struct snd_pcm_substream *sub =3D cdev->sub_capture[stream];
 =09=09=09char *audio_buf =3D NULL;
@@ -495,10 +500,11 @@ static void fill_out_urb_mode_0(struct snd_usb_caiaqd=
ev *cdev,
 =09=09=09=09const struct usb_iso_packet_descriptor *iso)
 {
 =09unsigned char *usb_buf =3D urb->transfer_buffer + iso->offset;
+=09unsigned int len =3D rounddown(iso->length, cdev->n_streams);
 =09struct snd_pcm_substream *sub;
 =09int stream, i;
=20
-=09for (i =3D 0; i < iso->length;) {
+=09for (i =3D 0; i < len;) {
 =09=09for (stream =3D 0; stream < cdev->n_streams; stream++, i++) {
 =09=09=09sub =3D cdev->sub_playback[stream];
 =09=09=09if (sub) {
@@ -516,12 +522,14 @@ static void fill_out_urb_mode_0(struct snd_usb_caiaqd=
ev *cdev,
 =09=09}
=20
 =09=09/* fill in the check bytes */
-=09=09if (cdev->spec.data_alignment =3D=3D 2 &&
+=09=09if (cdev->spec.data_alignment =3D=3D 2 && i < len &&
 =09=09    i % (cdev->n_streams * BYTES_PER_SAMPLE_USB) =3D=3D
 =09=09        (cdev->n_streams * CHANNELS_PER_STREAM))
 =09=09=09for (stream =3D 0; stream < cdev->n_streams; stream++, i++)
 =09=09=09=09usb_buf[i] =3D MAKE_CHECKBYTE(cdev, stream, i);
 =09}
+
+=09memset(usb_buf + len, 0, iso->length - len);
 }
=20
 static void fill_out_urb_mode_3(struct snd_usb_caiaqdev *cdev,
@@ -529,9 +537,11 @@ static void fill_out_urb_mode_3(struct snd_usb_caiaqde=
v *cdev,
 =09=09=09=09const struct usb_iso_packet_descriptor *iso)
 {
 =09unsigned char *usb_buf =3D urb->transfer_buffer + iso->offset;
+=09unsigned int len =3D rounddown(iso->length, cdev->n_streams *
+=09=09=09=09     BYTES_PER_SAMPLE_USB * CHANNELS_PER_STREAM);
 =09int stream, i;
=20
-=09for (i =3D 0; i < iso->length;) {
+=09for (i =3D 0; i < len;) {
 =09=09for (stream =3D 0; stream < cdev->n_streams; stream++) {
 =09=09=09struct snd_pcm_substream *sub =3D cdev->sub_playback[stream];
 =09=09=09char *audio_buf =3D NULL;
@@ -565,6 +575,8 @@ static void fill_out_urb_mode_3(struct snd_usb_caiaqdev=
 *cdev,
 =09=09=09}
 =09=09}
 =09}
+
+=09memset(usb_buf + len, 0, iso->length - len);
 }
=20
 static inline void fill_out_urb(struct snd_usb_caiaqdev *cdev,
--=20
2.53.0


