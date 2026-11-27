Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795749047;
	b=0mwezWBUQozHtp/4AgxX2SB0XtkpSZkAELGFSe8YwxwoKLTvCSbvyBEujpJOIdXQwxhF
	 xR4xPAn3Dg28h7k5si4SNHjD8ZmTyARmXJICcu8iuXZqDvktrNOHK4SCgHFppc0SJNC5G
	 1Ety9f0aV30QL0GZwr5eAMdaJT3NY0Y2xmfbfQWvTJHD6qZR65p3QoUfiN+HwiYXg7uB/
	 mmc1Xt3OQrYxlQEIQ6d1LT3E4EcnGtdI3XzoS7Sapd/sgmGONNNATNLlf7PpY2DEbcbiA
	 vSmSbK+lYz4UP1iyyvPCZ53o8dbcx1xvIHEl+wUPurEnaKcs4UkmLBErCEJ7CxErZtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749047;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Nj4rrQQmWYWvulinJkPHwmpfaomfoJDtKEI30uCQvJ8=;
	b=PlMApDFpWYCG0onXqiHnDVdJxSzwnG8SCl5RxU7Dp63ii/Fj5Dtc8HqAuL8/tSPvR1ko
	 /ZwCRpMNaW450yOfNUck39axtyJlPmNgtwjsA1rWmYSWbFxjiIK6JqBauL6QkcVipqLjW
	 nN7SwVdVL80Rr4pN3c6RVoU4sdcJwdVe0JpohkYlxjH5WITbJXHG/+dh95G8jOWrWW50p
	 ewhwSDOy6gAwAC4LwY/VRsvk8f8oovyG+rAiVfHSBjYxaw4O2OPegQ/bYk10peGMz1CUb
	 Rjvl2V54ExHEv4d9pvHkYy5BsYTe0oIcN3PSLXB3HJj7sUpxejUmIJUxhysQXmpmPFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaeyeong.cc;
	spf=pass smtp.mailfrom=jaeyeong.cc;
	dkim=pass header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=CnJUBEf9;
	arc=none smtp.remote-ip=79.135.106.105
Received: from mail-106105.protonmail.ch (mail-106105.protonmail.ch [79.135.106.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08081606A337
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08081606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=CnJUBEf9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
	s=protonmail2; t=1795749043; x=1796008243;
	bh=Nj4rrQQmWYWvulinJkPHwmpfaomfoJDtKEI30uCQvJ8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CnJUBEf9iZ7yA9CfHNbo5C6anGTQUryhfWwyRO5LWMmjH2vTY+e6ddn2qPrdxLl+4
	 +E9b0yOWZG5HmvS9/lhKLaDI13lQ20FZste+K2xuLi+owfKZEfTulMWi5/N9ndviNH
	 Oi5miH1LFfKUJCV44lv022pM4WwiIgH+I1p+S5jF3s5350Igmeac9ajeDlISHwgSb7
	 H0HZZYkOAGDIhjTeBvXR3wRxYuoHUC35pX5bTb1hYaMxLIWYlaSwgvMfQSPA+4mCqW
	 XQrEln4HgtWfWAlF2PmWqEUg1Kqxl9nY6hBm4QNmyV7Sjtabmc2T1mLRzSzxRFwJYA
	 t5WD1xzUzR+Kg==
Date: Fri, 27 Nov 2026 03:10:38 +0000
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: initialize BSS nodes after failed rehash
Message-ID: <179574903211.74080.18229639752208026871@jaeyeong.cc>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: 0768a75ecc112d3e958ee5e2057917408e283ea1
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
index 737cf77c5d765..dff53b9b8095c 100644
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

base-commit: 18d0bedbb5f0538396cb7f763ed9cd1dd69c5b23
--=20
2.43.0


