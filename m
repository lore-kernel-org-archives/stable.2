Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918860;
	b=h7iKT4LIiEx9olAvY1XhuY+TmJFSD+6fZtegIOad28ctW3j8xsdCMX6SU5vMeqZTecaN
	 S9dZIhZZKV+vtyDC6l8r4qYqmG0c+ERuGkZU6JDoJigXt/BBT5kmwJsJ97JF901RXGolD
	 LaKHRy6qe9RyVzQsCh0eg6bwJCJdXCtChQkSydf5ahc+BjpRjBG6qHB/KiNBaJHWLWJqd
	 BbxOyA1xCu3MWSN8iJLI34MjfEfinZ8j9EsGNY2/czVEptp13K6V0ejhp9nPOwxkWgOAc
	 Mqy8yh8+RWHAGZnTZnOtPZol1O64kcf13YYbX+iofHIUYAxXmVel+eH0K/GSzXto7cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918860;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4j9EUc4UCQbv2uPB2p9n2eNafBHD2lv4FX5nalo7h4A=;
	b=YBj9iK92vlbLwjT4eKcMZLEKg311fsOBNNqT0RxbCslUJ3EOdmaUHZOvy/MVw/jJoy26
	 crCCEH+pkZyC95LXP5J9xgEQ3YqpZYFwySbLAAPD6vWpjB3Y770QZMrUIzZ9zGvUxHWeX
	 ZiPCrgRTYUXtVPQRwkdz5sO3Dh3gPa0BtHz8PsaQJ4FAaNnsodSbcrPpBkW2p/1VX4fGY
	 /ftcFz0mvN/nXoYcKkFs42rhDVqz6mfO/XHY0RJ0Dbm7IqaMvtHh3xJAoq5VFX+DppJ3c
	 SVk5bcsx+OYD53nNH1teL14aKh0wSM1ELxJIYXXHsQ1q3UkYOL0U9m1fFSCNOOcflug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=H0wXyT7E;
	arc=none smtp.remote-ip=109.224.244.18
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B8606A33A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B96B8606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=H0wXyT7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1794918857; x=1795178057;
	bh=4j9EUc4UCQbv2uPB2p9n2eNafBHD2lv4FX5nalo7h4A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=H0wXyT7EYMtZeaRS9H4ekG1Otxm3T5mojqkEtxq7z3R48Y5lu+lUfz6dhuG0L4p/k
	 TWfb37W7S95bnJUSv9h6DdkK/Rm4B67nG4bxjXwcGA4mPHoXUWvaINBtCqMtuZJUZt
	 IcmS+7Qmh0wtyce26ey2/PWhKvXRXNaSCKo/YOVZZovYcgjqILaK/Eg7CPVtZSUl+F
	 ktZ+0Qj8aNQajCpAOcG2Co6khmsXtHJ5w0F7rjHTh3TPYEKvKgkp87l2NjNgOK5nws
	 KwRTEVZUfIPXmufp3DOOo8XbMWx0+vBCHNYEWmArLxO1lVr4+lOS+5D5jet/EHlpCX
	 TkElrbubVRlzw==
Date: Tue, 17 Nov 2026 12:34:12 +0000
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
From: Sinan Turunc <enscrpt@pm.me>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] keys: serialise key instantiation against keyctl_chown_key()
Message-ID: <20261117123353.1822-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: be4f8e1039a65530767340844033e596d4ce055f
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

keyctl_chown_key() looks up the target key by calling lookup_user_key()
with the KEY_LOOKUP_PARTIAL flag. That flag lets a caller with
CAP_SYS_ADMIN change the UID of an uninstantiated key during construction.
When the UID changes, keyctl_chown_key() replaces key->user under key->sem
and drops the old reference with key_user_put().

__key_instantiate_and_link() and key_reject_and_link() hold
key_construction_mutex during instantiation, but neither function takes
key->sem. Both functions increment key->user->nikeys, and
__key_instantiate_and_link() also calls key->type->instantiate() without
holding key->sem. When a key is in quota and its size changes,
key_payload_reserve() reads key->user seven times without key->sem. Those
reads include spin_lock_irqsave(&key->user->lock, flags) at the start and
spin_unlock_irqrestore(&key->user->lock, flags) at the end.

If keyctl_chown_key() swaps key->user between those two calls,
key_payload_reserve() unlocks the new owner's spinlock and leaves the old
spinlock held. By source inspection, key_user_put() can also kfree() the
old struct key_user while instantiation still dereferences it. That struct
key_user use-after-free was found by reading the code and did not trigger
during our KASAN runs.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  WARNING: bad unlock balance detected!
  7.4.0-rc2-g23c62304dde2 #3 Not tainted
  -------------------------------------
  request-key/163 is trying to release lock (&candidate->lock) at:
  [<ffffffff82698fff>] key_payload_reserve+0x29f/0x370
  but there are no more locks to release!

  other info that might help us debug this:
  locks held by request-key/163: 2, on CPU#3:
   #0: ffffffff871c10a0 (key_construction_mutex){+.+.}-{4:4}, at: __key_ins=
tantiate_and_link+0x38/0x370
   #1: ffff88800de4a8b8 (&candidate->lock){..-.}-{3:3}, at: key_payload_res=
erve+0x160/0x370

  Call Trace:
   lock_release+0x286/0x2e0
   _raw_spin_unlock_irqrestore+0x1a/0x50
   key_payload_reserve+0x29f/0x370
   generic_key_instantiate+0x42/0x230
   __key_instantiate_and_link+0xd7/0x370
   key_instantiate_and_link+0x40d/0x4b0
   keyctl_instantiate_key_common+0x2d2/0x450
   keyctl_instantiate_key+0x167/0x180
   __do_sys_keyctl+0x391/0x550

Take key->sem for write with down_write_nested(&key->sem, 2) inside
key_construction_mutex in __key_instantiate_and_link() and
key_reject_and_link(). Subclass 2 is an unused lockdep subclass that is
only ever taken inside key_construction_mutex. Subclasses 0 and 1 are
already taken outside keyring_serialise_link_lock by __key_link_lock() and
__key_move_lock().

An AI tool assisted with finding the race, writing the four-line fix and
the reproducer, and running the tests. I reviewed the kernel source and the
test logs and wrote this commit message myself.

Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner=
")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
v2
Drop the inline comment changes from v1 and rewrite the commit message in
my own words.
Use subclass 2 in down_write_nested(&key->sem, 2) so instantiation cannot
form a lockdep cycle with __key_move_lock().
Update the Fixes tag from the initial git import commit to commit
5801649d8b83.
Tested with the reproducer and the lockdep stress workload on 7.4-rc2
(23c62304dde2) and on for-next-keys (1dbbde3bc4).

 security/keys/key.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index 3f1f0fc..df31d10 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -441,6 +441,7 @@ static int __key_instantiate_and_link(struct key *key,
 =09ret =3D -EBUSY;
=20
 =09mutex_lock(&key_construction_mutex);
+=09down_write_nested(&key->sem, 2);
=20
 =09/* can't instantiate twice */
 =09if (key->state =3D=3D KEY_IS_UNINSTANTIATED) {
@@ -473,6 +474,7 @@ static int __key_instantiate_and_link(struct key *key,
 =09=09}
 =09}
=20
+=09up_write(&key->sem);
 =09mutex_unlock(&key_construction_mutex);
=20
 =09/* wake up anyone waiting for a key to be constructed */
@@ -609,6 +611,7 @@ int key_reject_and_link(struct key *key,
 =09}
=20
 =09mutex_lock(&key_construction_mutex);
+=09down_write_nested(&key->sem, 2);
=20
 =09/* can't instantiate twice */
 =09if (key->state =3D=3D KEY_IS_UNINSTANTIATED) {
@@ -632,6 +635,7 @@ int key_reject_and_link(struct key *key,
 =09=09=09key_invalidate(authkey);
 =09}
=20
+=09up_write(&key->sem);
 =09mutex_unlock(&key_construction_mutex);
=20
 =09if (keyring && link_ret =3D=3D 0)
--=20
2.56.0

