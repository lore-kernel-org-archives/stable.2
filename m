Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080937;
	b=CC3EcCP7zZwrJP33R72DJh8QSTH/GMqTAOrAn5tKNGVSeKY14zjBSdSwphXK5kiEzaqS
	 7IiIOZ1fgsAxlrGL752Ghncgs4GjxuEV0gRA9U8OJUj4ZCUFIIFyWASn/vYWFtgwlG7Jm
	 Rxn1CZQQ8N7FmG8rpULG+Bzz44j43MbbigxNbsLJSNIVyHvSUyoLAPWNw6iIgd78hWiuh
	 rMkYObAUhEXg4uX+S4cRhmwxXIOPIZeJRko/L6SKirsAhC65lZf6Ndakei3UL+ne85GN6
	 M5AbhRJNfb0+Ov4Jo4dGXLlIAH3xfz8UL0O7jSODVZ8a+UCiCqcHOwWpwFs+EaeIVnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080937;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+vyuFtZZY82piBVNfH5j8rx0gFBhiL1nUBtOUXY/BpM=;
	b=WFSsJ8lNOfj3xw1a0CZk0kwWteJQTf9X60OqbmNxTcIMlKiOSF+rqbFq1wOqXXgQDtT4
	 jIvlKqtFEl6laG0Y+JKxT2YuH9q+ef3fx+4Om7wbkAjiC3NFkfGNMqn+A9Il6GLIT9ECC
	 itVgHGjYBjPaFDvIhmjZ54LmECwWrgihiJ38mbUiPEW8Xnvf99h2GFfu705HIFs+pySGJ
	 OITOftlrGBLS0fnizRIThgO2bfI9JZfRo0dj2rJNxBMOMLo1D8O3L6DoypKwCECjISkIM
	 +eIgFCRjLXdEe49lxZuWXmw0YO9Lz0dVcUi2fO1oxrYKjmQ/AJGuWrFZkqXF/hLpSwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=Q0cvf+Am;
	arc=none smtp.remote-ip=79.135.106.26
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001F60A2612
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1001F60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=Q0cvf+Am
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1795080929; x=1795340129;
	bh=+vyuFtZZY82piBVNfH5j8rx0gFBhiL1nUBtOUXY/BpM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Q0cvf+Am4NaPgrtTMYdOe7xKYf1Bzy6U3yeBfP7mmo5VgE/OOUe5k0xr4A8ZBeydt
	 bHGgUIvrJ8xszUz8nGwp4nif1863OWfF3NydKygNOXKkuMgHnKkTVFeGiGZfzUvUIa
	 sOhwgsfdLIRNzWXKj0FoU8pCKIdwgbUt6Dzsw54F12cTndyNRDBveSPfaI5/EPYn23
	 g0BKR7VTV4F6rJiI3f/Y7xaPAwfSsxhdcsGcHfRw50e5VSgBudNiPtmFvDm9X/lp3l
	 m2ibMvcxJOXnB6OJNg4pIFbhLexxu682lqX/SVU5Hl4JgBINo7cU893ZgBDLtEZsoe
	 QPJ4lA8Kqb3/Q==
Date: Thu, 19 Nov 2026 09:35:25 +0000
To: Christian Lamparter <chunkeey@googlemail.com>, "John W. Linville" <linville@tuxdriver.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: carl9170: take the URB reference before queueing the TX frame
Message-ID: <20261119093511.558151-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 9cf7b70c87a101fc6fb649e362f16d52d3b8ebd9
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

carl9170_tx() puts a frame on ar->tx_status[] while it holds only its
initial reference and takes the reference for the URB afterwards. A TX
status for the frame's cookie that is processed on another CPU in
between drops the only reference, and mac80211 frees the frame. The
driver then increments the dead refcount and submits the freed skb as
URB buffer and context.

A device can hit this window by reporting TX status for the small,
predictable cookies while the host transmits, which gives a KASAN
slab-use-after-free in carl9170_usb_tx() and carl9170_tx_callback().

Take the reference before the frame is queued, as the driver did
before commit caf1eae20668 ("carl9170: improve unicast PS buffering").

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: caf1eae20668 ("carl9170: improve unicast PS buffering")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
An emulated AR9170 that answers TX status for cookies 1..4 while the
host sends traffic (an unprivileged UDP socket is enough) triggers
"refcount_t: addition on 0" and KASAN use-after-free on v7.3.1 and
"kernel BUG at lib/refcount.c:34" on master 666539eecdf4. With the fix:
no report in 68 patched trigger boots (9 on xHCI, 9 on master); traffic
with a well-behaved device (also HT/A-MPDU) is unchanged.
Reproducer available on request.
Applies to master 4405c18c95d2 (tx.c unchanged since the tests).
 drivers/net/wireless/ath/carl9170/tx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)


diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/=
ath/carl9170/tx.c
index 06aaf281655b..46d8bc6647e3 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -1364,13 +1364,6 @@ static void carl9170_tx(struct ar9170 *ar)
=20
 =09=09=09atomic_inc(&ar->tx_total_pending);
=20
-=09=09=09q =3D __carl9170_get_queue(ar, i);
-=09=09=09/*
-=09=09=09 * NB: tx_status[i] vs. tx_status[q],
-=09=09=09 * TODO: Move into pick_skb or alloc_dev_space.
-=09=09=09 */
-=09=09=09skb_queue_tail(&ar->tx_status[q], skb);
-
 =09=09=09/*
 =09=09=09 * increase ref count to "2".
 =09=09=09 * Ref counting is the easiest way to solve the
@@ -1378,9 +1371,18 @@ static void carl9170_tx(struct ar9170 *ar)
 =09=09=09 *=09carl9170_tx_callback
 =09=09=09 * and wlan tx status functions:
 =09=09=09 *=09carl9170_tx_status/janitor.
+=09=09=09 * It must be taken before the frame is queued on
+=09=09=09 * tx_status[], where the status path can find it.
 =09=09=09 */
 =09=09=09carl9170_tx_get_skb(skb);
=20
+=09=09=09q =3D __carl9170_get_queue(ar, i);
+=09=09=09/*
+=09=09=09 * NB: tx_status[i] vs. tx_status[q],
+=09=09=09 * TODO: Move into pick_skb or alloc_dev_space.
+=09=09=09 */
+=09=09=09skb_queue_tail(&ar->tx_status[q], skb);
+
 =09=09=09carl9170_usb_tx(ar, skb);
 =09=09=09schedule_garbagecollector =3D true;
 =09=09}
--=20
2.53.0


