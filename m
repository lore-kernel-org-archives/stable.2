Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010188;
	b=nPoBXJwjC/12cPJPAyUNbAA6Dr4LTgGzdwnZeEK+G8xaBL8gzsS2OU/w0wWB7jFeRWLB
	 /thcKvNi2qDpPKEq0vCDkHMn72KRhd5JFW064aSMI1mvQgr+ZQorHSZZWn3FUsv9y9Ul7
	 lhUv7Xg7/+gU7t1rEyiXOs8+hYjj9n1OGlqm8r/GKVtrsegTKLjb9u5NS3yKWNxBi/Caa
	 IVWZnpivNoXmX97SZCyZyhNj0YTOY/DP5DQ7eNUWB1F5ogh9eZ07ho2vTB6eIaiPgZ1RX
	 wBhXQ+7I8Z7rzo8z2Owwaqhy4gLoLhb7DV4sNhms9r791WB7TZI/AjTanwzsoaFlz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010188;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2Q790Rwm3zEB8bDBmjgQlFRAomWrIxaHrGw4h5UPzvU=;
	b=tlpVsRy2WYb6zSQRgtU72mnhti6/+/Ka1XigBY3nKDShxA7fdvJJl2K2VQJoqAr+X0XA
	 yF6pw7O3s2ODMSy9I0IB8Vp+Z2fuh0D0heUE5fqI8YLMukIAva66zUAKVo6949EvMeFUo
	 RNhxxjqUZuwCdYD9t5FMzT+W3F85/qtXihnDVTL47o5wjz7Zd2ZR1sXceoG9/bGhGwGJr
	 IWm01EOoq6jBdqssBUGbttg55JEkbuAEyjCTMDywl1NCjrj+hHNFv7pJw20MJN+CykuoZ
	 hfEt5Kv5Z7NqxhTSGhKXfaanw6E3z9GfpWpk6scDxxK8snkfidhd1dt5+fcgy+X8d7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaeyeong.cc;
	spf=pass smtp.mailfrom=jaeyeong.cc;
	dkim=pass header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=UwKq7h4I;
	arc=none smtp.remote-ip=109.224.244.117
Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch [109.224.244.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E1606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 280E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=UwKq7h4I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
	s=protonmail2; t=1795010183; x=1795269383;
	bh=2Q790Rwm3zEB8bDBmjgQlFRAomWrIxaHrGw4h5UPzvU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UwKq7h4IRvrIhvUneEjvk95qMM8ktTtd/TzvvAS46YyH3berPKeu+4WJ2SfLdkAo5
	 pumEw05gq4dV7Wi5aXmHhrDGYuN9578Pvr1KdobyB1qTa4l9HAsvJKful2V/t/A1Bl
	 SEk0NZaIs1ccKkYTikTOQLKm4ga+CpOaBI2zx2sXCK6EfyWRG4LQTXgHXHWr6dlY6j
	 g+basNPGXvvMSdOqkj6rrjlAGJCyECx3B2p5GfkhLtMNrafXAs/WLSqsP5dSduKBPq
	 TUwWx/OI+RRdxLbayW/XWNCIN3EQ0/4tYlCgAPHwDfJmWXyR4ZDCnU7ixapV0t8V9V
	 rrClJj8vR+SbA==
Date: Wed, 18 Nov 2026 13:56:16 +0000
To: Johannes Berg <johannes@sipsolutions.net>
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: stable@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: initialize BSS nodes after failed rehash
Message-ID: <20261118135524.301519-1-lee@jaeyeong.cc>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: 223bf5ac3187b0d40e3901196501c95036f94bf7
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

cfg80211_rehash_bss() removes the BSS from the rbtree before trying to
insert it under its new key. If insertion fails because another BSS has
the same key, the function removes the BSS from bss_list with
list_del().

The list node is then poisoned rather than initialized. As a result,
cfg80211_unlink_bss() does not recognize the BSS as already unpublished
and calls __cfg80211_unlink_bss(), which deletes the poisoned list node
and the already removed rbtree node again. This can corrupt both
containers and crash the kernel.

Clear the rbtree node immediately after erasing it, and use
list_del_init() on the failure path, so later unlink attempts recognize
that the BSS is no longer published.

Fixes: 7f12e26a194d ("wifi: cfg80211: make hash table duplicates more survi=
vable")
Cc: stable@vger.kernel.org
Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
---
 net/wireless/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1c50a16c0e9be..c285c60f5b6d8 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1785,8 +1785,9 @@ static void cfg80211_rehash_bss(struct cfg80211_regis=
tered_device *rdev,
 =09lockdep_assert_held(&rdev->bss_lock);
=20
 =09rb_erase(&bss->rbn, &rdev->bss_tree);
+=09RB_CLEAR_NODE(&bss->rbn);
 =09if (!rb_insert_bss(rdev, bss)) {
-=09=09list_del(&bss->list);
+=09=09list_del_init(&bss->list);
 =09=09if (!list_empty(&bss->hidden_list))
 =09=09=09list_del_init(&bss->hidden_list);
 =09=09if (!list_empty(&bss->pub.nontrans_list))
--=20
2.43.0



