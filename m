Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.33.104.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443016;
	b=rhXT9Di3P0YO08EUx6OpyxbKVFQ2R36M4PaG0goUgIttvSIWrS05GaOAeZBGe7ucmyIO
	 MnE8w+qfyK0ymk/yUdJaATp+Fo+1gEPbLslIGR+Rg7ZYyKNiAW0xzh9SY+e14rTNTdTDC
	 vId6oAxGmLWs1+ZPeJH1tcc3jHBKF1A5s4IMx4YbGFalAnjrFkLFJD2PmjfMImBH9oGqJ
	 Evdws4VASmAofCmqR6xANrFHQvPy48hmxhxxeN67ojdKfHdgKpa2vNnOWwhQ1xcxLft5i
	 HCDDno9aSluxNPv0MdM7WcPi2opcEycvegR73D1S9rPR6OsKquHpreya6cABoQGn1Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443016;
	h=DMARC-Filter:Received:Received:Received:X-OVh-ClientIp:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:x-ovh-tracer-id:X-VR-SPAMSTATE:
	 X-VR-SPAMSCORE:X-VR-SPAMCAUSE:DKIM-Signature;
	bh=4fn63uVBYvxfQtH2ReBw1SF76TfWdRjqEc3mmjrw420=;
	b=z6BJm3n7i0buKpz1DQoXAGLCjRHcFLq/ojbpDRp6H32bhVZBdb1LBSd+4bG6Sk7lLzDc
	 VoPufMayR21ZkLK9k/chrxeiXjT/BcdAP80Rlv+wj1W70R/Mq4cv0QDsKk33hAhRjZd7j
	 g07VZ0yiM+Ne8snWoSh7+oYFPdJ3K1Z5tw8ECbnoGYanGotT/tC/K/rcZP+Pkw0jg0Xaz
	 efJBCggNbjrmstOmEy5e+qlsxZNrdRbmDNheFXhm0VFJFLohDCF7p3u5NmShKuOcNjkss
	 nCKcIjB9bknTag0fskMZcuej2JPQvYzMNq7HCt08LtYJH6VrubtUZh42ThBlxSoYQTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fortytwo.fr;
	spf=pass smtp.mailfrom=fortytwo.fr;
	dkim=pass header.d=fortytwo.fr header.i=@fortytwo.fr header.a=rsa-sha256 header.s=ovhmo5104297-selector1 header.b=U1XPlwa6;
	arc=none smtp.remote-ip=178.33.104.224
Received: from 16.mo550.mail-out.ovh.net (16.mo550.mail-out.ovh.net [178.33.104.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F5606A31E
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C7F5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortytwo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fortytwo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fortytwo.fr header.i=@fortytwo.fr header.a=rsa-sha256 header.s=ovhmo5104297-selector1 header.b=U1XPlwa6
Received: from director2.ghost.mail-out.ovh.net (unknown [10.110.0.157])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4j7njj08R1z5wlF
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:50:01 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-fkvks (unknown [10.108.54.44])
	by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5324EC0504;
	Mon, 19 Oct 2026 20:50:00 +0000 (UTC)
Received: from fortytwo.fr ([37.59.142.109])
	by ghost-submission-7ccd8bbbb6-fkvks with ESMTPSA
	id VEu4BniC1mqXTQgAMqfShQ
	(envelope-from <thomas.nemer@fortytwo.fr>); Mon, 19 Oct 2026 20:50:00 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-109S003aced7fa9-8cdd-47b0-9b08-e2ff1db65e06,
                    4B164670A4970DC4CA3EEE43615753EBC6495375) smtp.auth=thomas.nemer@fortytwo.fr
X-OVh-ClientIp:95.173.222.53
From: Thomas Nemer <thomas.nemer@fortytwo.fr>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Nemer <thomas.nemer@fortytwo.fr>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Skip sample-rate read-back on PreSonus AudioBox USB
Date: Mon, 19 Oct 2026 22:49:44 +0200
Message-ID: <20261019204944.28302-1-thomas.nemer@fortytwo.fr>
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
x-ovh-tracer-id: 9401264225134745115
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGjmAQVrci1F2f6mTion83iRRK4PKiNe4RxseAtO0YmJpR62k+BVtY6bj7OVCpQDxG4KbOFuqEuCDUBmwuy5yBn98wiYaRPmv7AkF7/9Otq+k/JIhoOeZofohq9Bk3fuGHzDO/S2xRf9ohivivlfQ0gFsr34TOH8V5kECRz/gqUGPDjqLM4UaJ54fEFjLguWGCKNh1YUNhkFYYl+3tsLnP5jImdwFYVRzitJFPcsYHJIlGruamiN0JeKm4l0qu99+GedDWL2af0QiuhvLZccO7fOPV5S7hXa+mMHQVJnjzlAcn+gw2S4tBzUdGbft1Dmrro8hgtdyx3uQfB/sgxCi98YtRacAD+j/YmwR7tL3O78lnflslcjyhaxND7uPEfhs965+jZCHr6faBuod6gd91CpkQwd8KpX6V3HNOrOPb0ZGFotv9z62mRLqlvZ4orpoYNFrYYxPT3Ffsip6ZwH3dBvPxdCsHxmPfz7RUKCAAMyU6X+e44IIJs9S3EBsgfBZRI7E9R2KJGM0qbwY2MBGsczkJtCfV1FHIU/xwNXbKqsmxZrLUbxnYOk7M2yDOtBFCe3xn4ZoB90n89V1rtZCu3u7UV8Mq50AG+QyrDKUI1oUcD/8D22Bi6+eJtuJ4vAD15XC4MZqqNIQGkjceVnjkO7c8tTp9fCZnu8bV85/0BXQ
DKIM-Signature: a=rsa-sha256; bh=4fn63uVBYvxfQtH2ReBw1SF76TfWdRjqEc3mmjrw420=;
 c=relaxed/relaxed; d=fortytwo.fr; h=From; s=ovhmo5104297-selector1;
 t=1792443001; v=1;
 b=U1XPlwa6UgLvGOZaHEt7oEl4v2CsZMW6PgstShf6PzjsHZw0a3XXRKnyCyO1UZ924IZmEdK3
 Z0+amFpNzYUSFVZQq+WBhs0tbSX4xn+5BL1+RTGMJTB4QuK8mefc9ScznhM4lAMqvuA0JcoHm6G
 GzmwMvJ54YIegbFmv3wyVr98DIGZUX5JdNNicwg6VqXRb00o62jw88ENICV5rmXdXTqvE4nz4ao
 pKU3lPRZBk1dnibRr6G/TOH1gfN5RlFwhKiNwEritcpp5XVUC53L2rO/by2Pbk3GZ+0EE/TgA+F
 koZC4v+OEnbimfOv0vYU9SCi95wCqSh0zrCpHgDYgFy1g==

The AudioBox USB stalls the UAC1 GET_CUR SAMPLING_FREQ request on both
streaming endpoints. After the sample rate is set, the read-back
verification in set_sample_rate_v1() fails and logs

  usb 1-3.1.2: 2:1: cannot get freq at ep 0x1
  usb 1-3.1.2: 3:1: cannot get freq at ep 0x82

on each endpoint configuration until the sample_rate_read_error counter
gives up. Set QUIRK_FLAG_GET_SAMPLE_RATE to skip the read-back on this
device.

Fixes: 1869c47e5d59 ("ALSA: usb-audio: Fix missing sample-rate control for PreSonus AudioBox USB")

Cc: stable@vger.kernel.org
Signed-off-by: Thomas Nemer <thomas.nemer@fortytwo.fr>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 4ac4aef47d..43eea72477 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2731,6 +2731,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x194f, 0x0301, /* PreSonus AudioBox USB */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x19f7, 0x0003, /* RODE NT-USB */
 		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
-- 
2.56.0

