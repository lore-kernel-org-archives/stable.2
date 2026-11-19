Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077261;
	b=NSDRQ8xPmVIspF5QJjOuhz6tr53veLa/oSut5k6cNT1AVcdKkwCdKbIJxaOU9DoMnfqA
	 urytobTfNneYPJm16HFUa1LXucH4mRHCa0uBucklbGTuZZrtS8t7FGAgVxMHBF1kJ29Pe
	 ydz/pU++lu8a2UUOfVgnSDu4DvrR4M8EgwZWVbXAijdmCtJlMpHHSPILB9MIY+x02TDUL
	 VAZMXJuHVH1WtjZwrDSt45zKFZXLTTL5RY6LbrUK68pYUodiVGNZ/BszOzcgTI9RKsULP
	 hB77Ayj0fCJHsunQluQBxGuPrEEghr6mH2ejV4fnNekwyrUIBhdvoVpeUiVUl69IAAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077261;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dP3y9LfuJCevZvvA+PZYGeaqMsVwR5fMNr2PjeoMC+k=;
	b=pvh4j6MmvJyjS0NIGvW5QppZb4ZClOFk4I3UiMwseCubexTeMfXi7cn6erGz7O1eQtjx
	 fq82EHKnqrGTVAa2eY7goygQJ00PNN1jYz/AnZQXJs13ncreTak07o4PsudB7ER6+QdhO
	 lluP32657mY4ExquqSB7WeLLR/LWGwyMXlZXqJW1RgHXgc0gxzMlXt51RooJWB/eV/FYg
	 1ydZ77STDNUKY/l1epeqI9keeVsaBDAICYt1imlEpDw7f33/hUf/8yMUaJQHvzQAgGTSR
	 5EeHTHh2kWrTdlcIujQc5MVr/PeNzopMVEic22r1PJ5i50gDURX63jn+PIlJGEppuXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=bg1CK1+L;
	arc=none smtp.remote-ip=185.70.43.20
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B4606A320;
	Thu, 19 Nov 2026 08:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B09B4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=bg1CK1+L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1795077257; x=1795336457;
	bh=dP3y9LfuJCevZvvA+PZYGeaqMsVwR5fMNr2PjeoMC+k=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bg1CK1+LEQFwgYvzqXraiNLRGwMhG9cx10x5aQ6SGD4DlKrJEkiT5PZEpvPJ+B+2M
	 +x1Rgd9ZY2azlaeS9BRoepZw8unnMUx8CCaUYrcwF1ACHIVjVVSzhl0o2MVI4cznbs
	 rWjdQyCgavk+wxx9zdo/z2S//mpHl222qUAt6+icMCCSVU/ROQ/R02fog+dhzRWJfB
	 IsNe3sHgL8ProI83YuazKKryBqL3+CD68aVvlpsFecGBwhmRQB4I/R6KX/SzDiQbs7
	 GD73uBPLjIxJuMr2b4dC0Mmoo5MlXpR73LGpTzXZqKuZaecUZmuoJx+FA4KsUvdCzD
	 D5NMYhZc6RRmQ==
Date: Thu, 19 Nov 2026 08:34:12 +0000
To: Michael Krufky <mkrufky@linuxtv.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Charles Kim <ckim@maxlinear.com>, Asaf Fishov <afishov@maxlinear.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] media: mxl5007t: release tuner state when attach fails
Message-ID: <20261119083359.530446-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 81f33d76bc318d7eccb58d9229a271231fede0ac
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

mxl5007t_attach() takes a shared tuner instance with
hybrid_tuner_request_state() but sets fe->tuner_priv only on success.
When a register access fails during attach, mxl5007t_release() finds no
tuner_priv and the instance stays on the global list, still pointing to
the bridge's i2c adapter. Once the USB device is gone, the next
mxl5007t_attach() walks the list and uses the freed adapter.

Set fe->tuner_priv right after hybrid_tuner_request_state(), as the
other users of the helper do.

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: 2a83e4d5e40f ("V4L/DVB (8528): add support for MaxLinear MxL5007T si=
licon tuner")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
A device that fails one tuner register access and then re-enumerates
triggers it (KASAN, v7.3.1 and master 9d66f26fefac; clean with the fix).
Reproducer available on request.

 drivers/media/tuners/mxl5007t.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/tuners/mxl5007t.c b/drivers/media/tuners/mxl5007=
t.c
index 03c46a62bf26..4a765a7b0ad8 100644
--- a/drivers/media/tuners/mxl5007t.c
+++ b/drivers/media/tuners/mxl5007t.c
@@ -844,6 +844,8 @@ struct dvb_frontend *mxl5007t_attach(struct dvb_fronten=
d *fe,
 =09instance =3D hybrid_tuner_request_state(struct mxl5007t_state, state,
 =09=09=09=09=09      hybrid_tuner_instance_list,
 =09=09=09=09=09      i2c, addr, "mxl5007t");
+=09/* let the fail path drop the reference taken above */
+=09fe->tuner_priv =3D state;
 =09switch (instance) {
 =09case 0:
 =09=09goto fail;
@@ -893,8 +895,6 @@ struct dvb_frontend *mxl5007t_attach(struct dvb_fronten=
d *fe,
 =09if (mxl_fail(ret))
 =09=09goto fail;
=20
-=09fe->tuner_priv =3D state;
-
 =09mutex_unlock(&mxl5007t_list_mutex);
=20
 =09memcpy(&fe->ops.tuner_ops, &mxl5007t_tuner_ops,
--=20
2.53.0


