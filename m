Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527420;
	b=cvSDAsoicERbCe5KbU1AKH1lk3WCwtde739toBGibEMg8sidXdned3R+PI4BX7H4dBv9
	 afnAJBA0KsFdAFaqRX2TK9F9iq/y3QkasyhO4g3NlgTPQxCip2Thq+c6Ek3eM2BW9o5ZX
	 OVy5qvkBopBcAHxW66Ppqbn4zn41E8yy0IfBwkNI+9huYZRJa2RvwZJBfdFtKYVtkYFU5
	 Afnl3rOJMt9N5bBnQl7ZJUl2FrSUJYx83fngbQfDDXyrNxAdM5k7pCJJ4VnIuHUQYHf2Y
	 Di92SBcNIvsblomfPGOAOfpqoky45aR3O72UtnA69GrByYR3kWTTj+VA/hRS61lbtEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527420;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=5ZyhxfnR/OMl6eSq4R/nmtSjioEkST4Al6ReoxZQXhk=;
	b=idTFvI2BRzEFeAZY37/JDkk4o7K3ZICjRFi65mMsA4XBmP/hjr6wnDTgfRfMXPZ+B/a8
	 8nATpjaovYdhv+9z4+ObItdj6b9TpUnRZr2FUU5Th4D3V8rFTuL73k/ERKLRfM3OiZXkp
	 +QE6cUcTirpTEdNv9AEYsRkc7JYVGxpYHJyVokUvbCQeaRBY/bu0bXstmxCBUrPfxbTaL
	 FYOufvZQhAnOARAYKLogi8v8cftkjYOiLrkNuVDuWyuEIfXq3pB7YCM8qAJ+HjdHjIV9Z
	 e62puhlkLW6Hb7W/ld1/c0lkdc1UGyd+nnAttZJR0R0fF+jKTJAAYvwaQtGUN4EGrAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gL8fUvzo;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160AE606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160AE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gL8fUvzo
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 788AD4E41290
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:16:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3EFE060393;
	Tue, 20 Oct 2026 20:16:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8734B10328E09;
	Tue, 20 Oct 2026 22:16:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792527410; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=5ZyhxfnR/OMl6eSq4R/nmtSjioEkST4Al6ReoxZQXhk=;
	b=gL8fUvzo9CAHLHRjFYmZdA4maLeKrrUC21Fg4nnNN6ieJMDIjBb6MEr+uSbLAvA+pIFvsx
	M+CQYX2ArSTMrEG29qNr7ugIvRdUmfZsAAt/FNx3nCxI7OKkSwbF+5kAPDiXrGS89ZkZqu
	xJMhvf2eODsnK66lqd93ckzGwYJzyGATqOVH2fcp8n6MqZS38IZ9TFmo59qfHuPSFpyDRB
	PPMAyPhuDQRrhSmabX1Uwwt3BmAyNHJx2YA9x5fIumJBP+J8jTrI2vU+pMDhWKfhCb9+/6
	YQqmJFxtuCzFSwFv7yRbi7QPR1HmLU7EigwXJH5Uqvf1b3C2CGgvQVk8OS/PyA==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 22:16:42 +0200
Subject: [PATCH 5.15.y] security/keys: fix missed RCU read section on
 lookup
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
Message-Id: <20261020-cve-2026-64015-v1-1-6b1010633008@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3ZJu2Gb6KsYD9ousBzQtEo0h
 He36PGbZP4VRbNpwalZkXWxYve5wh8axPE6D0qWqsGOg3fsKC5KOyh0zgsdhZN0nDiEiHp6ZO3
 t/QueIa2X9oPLfy+v26TxudewbV+Pih2IegAAAA==
X-Change-ID: 20261020-cve-2026-64015-952d542d266c
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Nicholas Carlini <npc@anthropic.com>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792527403; l=1805;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=QyKGSJa7dRA0USCYa/SNISet/TXgRI0+WtWKXABz2MA=;
 b=7+HvKkAzPfr1NoU/r+9eXSpoeavREdrYs62uJbnj/9gEwD5Xs2fDyP5ylXusvFEbzNKPt4YtD
 CzbP0I1yD3wBI4BYF1SDdx4l3askthj+DvU+x2JdRCH0/gPP89YM3ja
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 43a1e3744548e6fd85873e6fb43e293eb4010694 upstream.

Nicholas Carlini reports that the keyring code calls assoc_array_find()
in find_key_to_update() without holding the RCU read lock, while the
assoc_array_gc() code really is designed around removing the node from
the tree and then freeing it after an RCU grace-period.

The regular key handling doesn't see this because holding the keyring
semaphore hides any lifetime issues, but the persistent key handling
uses a different model.

Instead of extending the keyring locking, just do the simple RCU locking
that the assoc_array was designed for.

[ Moved the guard at the top of the function to solve a compilation
issue ]

Reported-by: Nicholas Carlini <npc@anthropic.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris James Morris <jmorris@namei.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 security/keys/keyring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index fc26d339a962..5b366911aac5 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1105,6 +1105,7 @@ key_ref_t find_key_to_update(key_ref_t keyring_ref,
 {
 	struct key *keyring, *key;
 	const void *object;
+	guard(rcu)();
 
 	keyring = key_ref_to_ptr(keyring_ref);
 

---
base-commit: 792fbe1537d8daeca9bd1917e84078b5432aadc2
change-id: 20261020-cve-2026-64015-952d542d266c

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

