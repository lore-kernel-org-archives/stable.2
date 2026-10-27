Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069212;
	b=sKVQ/Pvx1+vZLONJjCJrtryTTFeLfEfynUY0uMGHhXZ0hfHAsnecnGuO+BZ93PnI2j3I
	 o+RHdzF+xhGImVAncTMxA64PJ0j2yTTkiJxlx7/VuSlHlJUDh6goWlpFKsyWJ6L7Yv5yQ
	 oWHAvRqdFaTIJPebBLq2hXQdDXDQWMp3a0y4S0SJC+q+r+A/e+3V0x4adaTvLoB+JkVN3
	 pOFKQDeR/aDYNwj8qHrk6qtWQ/wlGiSsuBgqwDKfqSvdkCrhN9ofX9MM85mIsGhuL/8hz
	 ldvJy8taUa0OdywN4JT1gGplKAvK9vewBvOON7/OdpqzUdsI7hZYsot2gwgQob4XSvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=coxZgKrnJnZEH72/LrsRIXDbgDxnkuCnDoogWLb7pp8=;
	b=n7RiK7xIiAvrMggG0D2/F+eheHkUVZCj9zvN+6lT0pZc4k4LVixyfvbrxocLZIeG/tpO
	 fzo18FV4a3/jePr5QBw2svcKfo7zZ58m4CqiM6qfmAGVl5sRWTW7AAoViviFv7Exj07xW
	 nQrEacP7FSSTEtC9MSchn546nIweCZc38XeAvtoQed6VbQE5/PJmC1xN9Feppwdg8obZh
	 Z0l602E4bNBoLQWhzeT4ZRbc6aaQQ5+7l3fmTu8YOWTvV3dFWolZ3m02x0+/QiCpcUvlv
	 k0e0Hor7pTBHyTODts6qi+MfmMz7l8zbB5JrxihaC6eaifM0+A4GM7KnXunJOc2XJUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=PoGEn+ZS;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5864606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5864606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=PoGEn+ZS
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36661f953e4so6782817eec.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 19:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793069210; x=1793674010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=coxZgKrnJnZEH72/LrsRIXDbgDxnkuCnDoogWLb7pp8=;
        b=PoGEn+ZSZSHDcDU74OOAemtouk8b4YJ9w2+w1DghVB1lN/xfW4sEfZhlHJXZJWBraK
         VA1IN5HWxRLkwkoy+HKDS5QhtB4txJqBv38G+pSv5t4WWR1TdrjGxDSG0RlJHI6vvxvi
         DJmUWCYMYTIkrgNCaZFXgNigmDIgxagI6n8ruIP5k5qoLyp6tEPqKUXnJPr64E7cY6aF
         QlEgLmadeZLMq2DceW3moY/ZWuJk/TVxUfEK5dbSvwoqLtUba/DSoEm+wFCVDM3CPJ90
         0V48qIdp/en3GSZVyKTmjzgb4PFDLIGrc5r8mPET2kkFxGOwj2qRQ6ZW96Tj3UK5mTa2
         bQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069210; x=1793674010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=coxZgKrnJnZEH72/LrsRIXDbgDxnkuCnDoogWLb7pp8=;
        b=0/N7rEPCt6Tm2hakMhIqg65W5J6J6nFpZ6qzd2NbFbBLk0XmQcLEIqkgPalLjI/qox
         fQeExXQBTTDiAKyTqR4uTf3s/6p8C2Rj7nuqTQBKuEyYqR0qncTRHnFFc3MNjvpGO3S+
         csfHs8Y2C1Td1iNVRBXUY6FLTJYDJhEoOwwU5vM+YShNbXQyrZryULQXnjUhBfaMOyKG
         3XXj4/ao/QtLMKtu778NVw00Z1VnXO/P4Zwb3Pn3NFX+lcPgpOgYwOw9x5HPDYWa4QBK
         cZrGPVNK1JB/7PQH5/bQR6N5fQjr3mEevVMHcwibuIxYxzUik8ulaoamTYp5nFZn1oZB
         /qKw==
X-Forwarded-Encrypted: i=1; AKwUvBzp2u8/gSBouCnvKoZK7SF8WrnCx4IClTdRhnupeDPJkzA05xaL15josLJEwDP+z4b05KoFBc8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+xcpCDjAc/gfJsoGYXuCCvtVUjoOQfNLTQyrwrAZZPO7vVITU
	rQjTHUs/7ZmAHOofIX5VzUL2vT7W1HnnKJozsZuGXN2+6zDPcvvMd5gJ4CNv/ti4rg==
X-Gm-Gg: AYBFou1tE6f2PTN3Jv8Osch/oX0f8Ivq4dsSMpxOH8ViafcXgDxSU+vccnPQsNWqgmE
	YYvKHGBDpLlSxjP+SAY0ICYwTSMv7S1vpasKF5i1e5NWWbbjAqVcMkAYV4MwA8+T4ICxveNA5vW
	/b+WiWUOE9RA9O8hE/qJ+nXtvQBf2mDL50eBw8vjlH7/d9odSduLO+70u/tvnGhsCDEapdVdWVj
	kerbGUAnzdqgEgc3QPWmMInFCWbtQR+OSYwbEixPinv53KHnyZS5s+I4OZTA4S/+2JRRn3njAFT
	L4ZMc8JsVfLe4zuW5q9l0WjbT4FU/XJLV0EfMXZjKHb5ac7Exad+ZXz79/fyBYVqMmVAAFBAyF2
	sBlxqNgxqt/CM2U9nGD8dhYTVylteCaCm6hk59IlE9VOq57Yxfu/HerBiD4LEzy10Ftq9vbYanP
	9gac8vdV/09+QMJIa0uC5wpKi8d7z8bPk6zzOPaSVKHp2wF81cNqZlb+IbBZ6jbQReOb2kckSGn
	rTQhv9a2un1fnbUcWyM1UhtV2LcASCoC2L444+MUSRFw4LFogUMtRxmXhMzP+t7VrS3mN8g7ooC
	fp2ZuXqpXEg2R0xA7L2BRIXHBFkLsvU=
X-Received: by 2002:a05:7301:1694:b0:368:da6c:4fb6 with SMTP id 5a478bee46e88-369e84ba936mr17506180eec.18.1793069209838;
        Mon, 26 Oct 2026 19:46:49 -0700 (PDT)
Received: from prasad-b546768-0.sjc.aristanetworks.com ([74.123.28.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d8a690sm28967702eec.12.2026.10.26.19.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 19:46:49 -0700 (PDT)
From: Prasad Koya <prasad@arista.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	prasad@arista.com
Subject: [PATCH net] macvlan: fix allmulti reference counting in passthru mode
Date: Mon, 26 Oct 2026 19:46:35 -0700
Message-ID: <20261027024635.366900-1-prasad@arista.com>
X-Mailer: git-send-email 2.51.0
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

Enabling allmulticast on a down passthru macvlan, bringing it up,
then toggling allmulticast off and on can underflow the lower device's
allmulti reference count.

macvlan_change_rx_flags() only propagates IFF_ALLMULTI changes while
the macvlan is up. However, the passthru path in macvlan_open() skips
taking an allmulti reference when IFF_ALLMULTI is already set.
Clearing allmulticast after opening the device therefore decrements
a reference that was never taken. With no other allmulti users, the
unsigned counter wraps from zero to UINT_MAX. The next increment
fails with -EOVERFLOW and reports "allmulti touches roof".

Signed-off-by: Prasad Koya <prasad@arista.com>
---
Reproducer:

  #!/bin/bash
  set -euo pipefail

  ns=allmulti-test
  host=am-veth0
  peer=am-veth1
  mv=am-mv0

  cleanup()
  {
      ip netns del "$ns" 2>/dev/null || true
  }
  trap cleanup EXIT

  ip netns add "$ns"
  ip link add "$host" type veth peer name "$peer"
  ip link set "$peer" netns "$ns"

  ip link set "$host" up
  ip -n "$ns" link set lo up
  ip -n "$ns" link set "$peer" up

  ip -n "$ns" link add link "$peer" name "$mv" type macvlan mode passthru

  ip -n "$ns" link set dev "$mv" allmulticast on
  ip -n "$ns" link set dev "$mv" up
  ip -n "$ns" link set dev "$mv" allmulticast off
  ip -n "$ns" link set dev "$mv" allmulticast on

 drivers/net/macvlan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index afad90b9222a..e20d587453d1 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -643,6 +643,14 @@ static int macvlan_open(struct net_device *dev)
 			if (err < 0)
 				goto out;
 		}
+		if (dev->flags & IFF_ALLMULTI) {
+			err = dev_set_allmulti(lowerdev, 1);
+			if (err < 0) {
+				if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
+					dev_set_promiscuity(lowerdev, -1);
+				goto out;
+			}
+		}
 		goto hash_add;
 	}
 
@@ -713,6 +721,8 @@ static int macvlan_stop(struct net_device *dev)
 	dev_mc_unsync(lowerdev, dev);
 
 	if (macvlan_passthru(vlan->port)) {
+		if (dev->flags & IFF_ALLMULTI)
+			dev_set_allmulti(lowerdev, -1);
 		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
 			dev_set_promiscuity(lowerdev, -1);
 		goto hash_del;

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.43.0

