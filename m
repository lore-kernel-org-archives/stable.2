Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080560;
	b=toYYvULUoeigec3+5wuHNlHpC1/UiyGYYPT0nEg2zjWFpTf69lMHLV+PmWfl3O6fjtbq
	 kwkX719y8FAoK/pjXDV3saQIDLkrFJZNYbwL8W88KwvCby/W0mxsUQJEu+bewfWh+RgvP
	 UfLQNcBQuSBfLcwddfoghTQzMIDBFBx52qBOjTEARx+MKH2BUE6zImYdRc+WXFHkZSdw9
	 2hA34oG06g2lBByXDNDdyF3i9rRXujuqQBpZp+kOHQFwFXaQltohg+2zcjxWk+naZzmwZ
	 ojoGcGwfrvRX25YwpWbO9pH48KZbTSNoOqndggK+wAnQ5akFgAcDdpm7LxITgBpR5Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080560;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kbCdt3KgEjN/2CiYy/Fd6/ugSIyTJAlsDpb++fhQDhI=;
	b=YTgCRuz8s5wK62a6py+ydnS8cLkVyC7In/jJJ1KTgdHGh220P2XsxWr6l1nCMgnXgI3W
	 Jcwu5+FUqfNDdQ2zaARSTpJ2J9+3ctJN/JEU3oUG3NTSru4IG5llAA+8fAoxTyP6wvAU+
	 ryUG9KCiOZ+VC5g7rqjG2hf+AGppCTtBB4VHpLlrvcL6AUxZ5+IZ+0oyVtHvf2C51hyDo
	 tYkUaVamkO/6CzbOavnXl2tEPL/BoOpoSTEnweDEDmSg9re8Z32ndyoL9BWavy417S2+F
	 kAySxR+wWwGi3EY0zM4VYKe6tm0+hw5XTI5AnhtBFmcOipDHT5+vWSw7PEfl1zgGC0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=kKrWubLb;
	arc=none smtp.remote-ip=79.135.106.26
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3E606A326;
	Thu, 19 Nov 2026 09:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BD3E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=kKrWubLb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1795080556; x=1795339756;
	bh=kbCdt3KgEjN/2CiYy/Fd6/ugSIyTJAlsDpb++fhQDhI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kKrWubLbWCKe8/tI9uaVAF2lP0WWBT6yfKPdjHvD2upv1c5htTNCXwbEFItvrssPA
	 XDoFcU769dnOEJodFjqWD/5LAX5U7FR3EF6INBInaSp96gcFJ7a2MOdEKJ10D2Ueik
	 aVVgbPt0Cn19q+2E7+goAz7NdWq49SHspq92088pY/nhkvPJxmvAcS381lvotxWF8O
	 KmrVQumTPUI6ty+oMZElzW3ZGUX36rNBm/8XQ6WxmUnT0rBbZKjFV409N8LdhRhKjn
	 HLCO2mKN8kJAovUmLkUCKvNFwLTW38tGcclL+ESMF5DqrFW1C1d7HoYRdYnEoRTcZA
	 fp8itE/Pr7/LA==
Date: Thu, 19 Nov 2026 09:29:11 +0000
To: Jeff Johnson <jjohnson@kernel.org>, Erik Stromdahl <erik.stromdahl@gmail.com>, Kalle Valo <kvalo@qca.qualcomm.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: [PATCH] wifi: ath10k: usb: validate HTC header in ath10k_usb_rx_complete()
Message-ID: <20261119092848.554901-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 186a44acddd7b71ce5f8f57788e12ac831867b18
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

ath10k_usb_rx_complete() uses the endpoint id from the first byte of
each received frame as an index into ar->htc.endpoint[] without
checking it, then reads ep->service_id and calls
ep->ep_ops.ep_rx_complete() through that entry. The header length is
not checked against the received length either.

A USB device can make the driver read out of bounds and call through a
function pointer read from outside the array. This is reachable even
after a failed probe, as the driver stays bound and
ath10k_usb_pm_resume() posts the RX URBs on every resume.

Drop frames shorter than the HTC header, with an endpoint id >=3D
ATH10K_HTC_EP_COUNT, or with a payload longer than the received data,
as ath10k_htc_rx_completion_handler() does for the other buses.

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: 4db66499df91 ("ath10k: add initial USB support")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
An emulated 13b1:0042 device sending HTC frames with endpoint ids
9..255 after one runtime suspend/resume triggers it (UBSAN
array-index-out-of-bounds at usb.c:304, KASAN or a bad indirect call,
depending on the id) on v7.3.1 and master 9d66f26fefac. No reports with
the fix. The two length checks were reviewed but not exercised at
runtime (no endpoint is connected in that state). Not tested on real
hardware. Reproducer available on request.
Applies to master 4405c18c95d2 (usb.c unchanged since the tests).

 drivers/net/wireless/ath/ath10k/usb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/a=
th/ath10k/usb.c
index 987d57a01ddf..0c900351ba8c 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -299,8 +299,18 @@ static void ath10k_usb_rx_complete(struct ath10k *ar, =
struct sk_buff *skb)
 =09u8 *trailer;
 =09int ret;
=20
+=09if (skb->len < sizeof(*htc_hdr)) {
+=09=09ath10k_warn(ar, "short frame received: %u\n", skb->len);
+=09=09goto out_free_skb;
+=09}
+
 =09htc_hdr =3D (struct ath10k_htc_hdr *)skb->data;
 =09eid =3D eid_from_htc_hdr(htc_hdr);
+=09if (eid >=3D ATH10K_HTC_EP_COUNT) {
+=09=09ath10k_warn(ar, "invalid eid %d\n", eid);
+=09=09goto out_free_skb;
+=09}
+
 =09ep =3D &ar->htc.endpoint[eid];
=20
 =09if (ep->service_id =3D=3D 0) {
@@ -314,6 +324,12 @@ static void ath10k_usb_rx_complete(struct ath10k *ar, =
struct sk_buff *skb)
 =09=09goto out_free_skb;
 =09}
=20
+=09if (payload_len > skb->len - sizeof(*htc_hdr)) {
+=09=09ath10k_warn(ar, "truncated frame received: payload %u len %u\n",
+=09=09=09    payload_len, skb->len);
+=09=09goto out_free_skb;
+=09}
+
 =09if (payload_len < htc_hdr->trailer_len) {
 =09=09ath10k_warn(ar, "malformed frame received, firmware crashed?\n");
 =09=09goto out_free_skb;
--=20
2.53.0


