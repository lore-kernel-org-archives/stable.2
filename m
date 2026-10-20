Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527499;
	b=46bmZErmRJUGSajPh2PJLCtvUTB7pVETs420+/QZerapKfM2j7CWYiqbLJH5ze116IvZ
	 8Jo8Z5vx6a57M9lthc3+mgdVLaThkfl80SFE6KxGeWYAaLlParJoJOLDsQcFhVPirSYsm
	 7fjDbNM0TGOg8BY9SX94KoLn0aoEifmvkwPYHHh6zb6OXBCbN/bKQn5GIWbA5XflyDMs+
	 cST4RTNcspyxD56orVcPTJVqKjFvXZgPea8xR0kaqNjtLnKDySX4a6Br/SJoGoEZblpjk
	 nFXt5nOh4HMQA+K0E08x+xwfey9UKCNjDiYG01dj7rn/Xe3CiWBdquBmoXbrNh3ouSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527499;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=S5Imp0ytI0QuZZ5aOAyocJYw5ldMPdPddBET+K/JAQU=;
	b=S3bwN76i09ff+5bfMuL4QFuG5sNq9fzYaWmImUDhdcJll3IanOM2RFW4UP5fZ4splxLi
	 uXjji1zlqZS5AexwmTZ2ROvabQAocT0rHwvQZY+oJ+yV1cVBGbxBscXtxvw76oRibfGK/
	 i0/86Jz3Lw/uuuqvma05NnVkQ6zU3fPg5Eth9AxpPSQHTb8KASZtTZkWv16yCsHV95CLH
	 VphbwQT5sB2xmZpg8qUawyQU2kPJertOxssPR+qEV6HDboq3+Y9T7u2otUQIF5VK7mbYX
	 ANoJaPlMFw1QlHbbRKO6usGMyoD+Tnv6VCP7HchgUb9UjGc+HZUHsXQnrURWLQpwm/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="zZvdUdr/";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1F606A323
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AC1F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zZvdUdr/
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2C6D71A1290;
	Tue, 20 Oct 2026 20:18:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA1DC60393;
	Tue, 20 Oct 2026 20:18:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31CE510328934;
	Tue, 20 Oct 2026 22:18:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792527485; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=S5Imp0ytI0QuZZ5aOAyocJYw5ldMPdPddBET+K/JAQU=;
	b=zZvdUdr/2W/zGI23P0M7CoHHIign8VaNvM+k+Rw6HvgkeKKGEo6SyWmlfwX0BWD7J0yxQf
	mbW5vAW5aCgrgBGxIlBqK+xTrfVoLgMHrEyRqsVWpm7VkMEBj+i/6Mf79dtd05Nosmthuu
	gid16ic4eat/8IjgbW+wCjlVlIho2CekDNXHNGafJNrgpa/qRt0QH30OWu3XAIjU1FBApn
	l6662kjzRUUNR8DiGOWfme2PIoo68LtJFvOMqb8mRXciO+Nlft0L/+D9qGpo284XYzLPXb
	yRujHM9Su908wfawJS7yXTKtHKcrBodRY4T2Bc9tX6dGa4ax4FdbQ9NhrHtRyA==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 22:17:58 +0200
Subject: [PATCH 5.10.y] security/keys: fix missed RCU read section on
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
Message-Id: <20261020-cve-2026-64015-5-10-v1-1-e46094923660@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CMAxE0atUs8aVbUiKuApiAcEFsygogQpU9
 e6ksHwjzZ9QLLsV7JoJ2UYvfh8qZNUgXY/DxcjP1VDWKKxMaTRaQHHDEiiQMMVOujX3qmZb1Oc
 jW+/vX3WP0Aq3Hxz+e3mdbpaeSxLz/AVFGZ1LfwAAAA==
X-Change-ID: 20261020-cve-2026-64015-5-10-671730f22ee8
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792527481; l=1810;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=OmruEB3wy9mmcrZWbKMxIIXQpCKqADTXVvafR22DtJA=;
 b=MpDCczD+cGV5WmWsxmfrk9B6wnv6ZpE0ECHMNQs/yeqrgGcfJ9+3ofJQhe6J24ha2SPJ53RLb
 rDczUN7HYCbDnaGnpctlV1hqLGJo5jvI34M2nYHADvuNkrGoHaeWTXx
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
index 8b938e61ecd8..241b96addcf3 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1105,6 +1105,7 @@ key_ref_t find_key_to_update(key_ref_t keyring_ref,
 {
 	struct key *keyring, *key;
 	const void *object;
+	guard(rcu)();
 
 	keyring = key_ref_to_ptr(keyring_ref);
 

---
base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
change-id: 20261020-cve-2026-64015-5-10-671730f22ee8

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

