Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010454;
	b=TjdiqaVDch2UiRMYpMaz/ng2F+d5habCfL5DFnrYmuKwCLZc6U+12dqXkjQuedt6Q6HC
	 V1J135bjGyEk28I0uq6jl7e3ShF8elDFekXbD8q6iupo92Ogu8LtN4Rgq1dlIVaD9/Ymg
	 pbYyEj3Kv4JohLWDn1bFlpn6ZisQPp2yTkka5FYC4w2Pg0fz3OwuExRXzR5LzH9binwaj
	 zoUqBC2Ei1SN9mHOI2X5+i+zTLuugvIhO2zd/rVqm7iG4D7i6MtBzj4TF9nkqxMcHw+Y/
	 yJA8YAMLkvERvxsDScsoZFkmPcEcyooF+HBu2jDSJFbMNaEUmQrdWHQVtEeRjrxTz+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010454;
	h=DMARC-Filter:DKIM-Signature:Date:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2Q790Rwm3zEB8bDBmjgQlFRAomWrIxaHrGw4h5UPzvU=;
	b=FOUgjXkNs/fe+nIK46k89dRP6KC2Xgfg0eJyrfVGs0jxhf+srJcE5mj7FsADoK3cuCtb
	 UW59xWGSko7EivWoa7Cj5+AycxnRUjIPlT67HmNTcmPvgI8j0ktKX1Pl7rnFvephVK66i
	 8f5kzuburlB6J/rfEkAcrbNgyFj/Hf7tTVutGsw+BilgxQ6TD2clvVJlSMPswzbnJe+je
	 Uy5GTA3Tch1mMovMtjBgQh/Zcrf0wZKGd0HRpV9HteNOsPfrrb0i/glM/p6PGMtrIqFJh
	 RYdpJYlEc6I2E6c48/NVq+yqqV+UEPxSmZMtDAovQ5JL7uhvHuMvdSUNiD3T2Xlrm6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaeyeong.cc;
	spf=pass smtp.mailfrom=jaeyeong.cc;
	dkim=pass header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=aiX0cLK0;
	arc=none smtp.remote-ip=185.70.43.23
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D3606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 957D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=aiX0cLK0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
	s=protonmail2; t=1795010451; x=1795269651;
	bh=2Q790Rwm3zEB8bDBmjgQlFRAomWrIxaHrGw4h5UPzvU=;
	h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=aiX0cLK0afv2l5UdwSjXj7pNP34WhTNgpMQV+ySN43hSztOeYXzjHIQ4ITZ/ovOiA
	 fIkUZY2h56FMF+Fzn0C3Hr255WI3igIlm3L0QlSixA1ARNcD+ROKj+g7dPw/R5CAUT
	 dvQMPIWv3PMReb0lLff/6CXqsMN5eKSN3XikE052i5uDbwmmnki4sojOUFOs2Q3LS1
	 URuI3kzCaFj1AxbqH3LiVsXr80kc0c0XOHUydxoYdp2euQPdLoNzLsakBwQM3sXMcW
	 d+StFVc/gO6L1tCUDWeMWmvyPHe/mzvkBndZ0D52jVCN7QhlZXC419QZCSS4nmKDW6
	 Zgk0P6mgt2eBQ==
Date: Wed, 18 Nov 2026 14:00:45 +0000
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: initialize BSS nodes after failed rehash
Message-ID: <20261118135524.301519-1-lee@jaeyeong.cc>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: ab521237427ee993902df0a64ae3f51ca62e97c6
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
Message-ID: <20261118140045.G-wnoC-X10UidjfTbm4u1shSXe6B7Vy8fx1U8alrVOI@z>

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



