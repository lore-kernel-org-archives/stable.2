Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0343478846
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407067; cv=none; b=DCWwfqdmWqLIq3wG636/2+pJqtHTl9lkkmdafJCeLze6+AZ4jDqX1Zobq07Yj8TVLr2Ri5l3EpCWvpuDG/FDTIz5SAlGsRbqiQRkpH+lXqVocY+HNIArXMuFKWaLvK6OZnXKniSlaIizLk1R0fB8UXi22N97UfgiTAAy1uYaS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407067; c=relaxed/simple;
	bh=qHFSpRikwa/nn6MFHRYhx4cMrvlGxbQe1RFuOZb4iI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3Rn/NLJWgD6OrnYL8nBptTReB9GsRAvoubjJTbmVC3dA2en7dj2luRhdtppaRBd9sTiSsxDQFgCxhVWcfA1il0y8TwajVRxv2uh7MaPTxSVc+IZwwzYC1rH0ycD/QiC9be5LoC3j8+Q2piSUH66OuVzHWE8eV7BPbQUh3Abz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwuP2ooL; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwuP2ooL"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff16dd47so17954361fa.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789407062; x=1790011862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uejRUvyuFcc6D/L4RGNRyiFIR0zJDJV2e12Q9seeuxg=;
        b=hwuP2ooLLZmSOUk9fVY+YoFXzpVfQGMeNXomBnAeswGCFze2WNQCjuJGodl9JvwejN
         S+RQC4C1e3gBYet9wRCgGHnN6LeKNXWYCUJlFDmWs/q5rV2P/aFovQ9LgYZ5Z3aJ/ZqJ
         N96nu813pfACKKYDOplW+TBFry5q/FT9daS7HixJKMqlb9IpRDG/Zg6kkVNztyCDRL3K
         Yi6Z0ENn3tHMzfgn/YZHnZSkbSD9fKpfzCcH4E2tQXztf1gQDmQFf5C4h6ggrxrIIPqU
         PD0ExHT2jRFCxvD5eGVHhW/rCWa1XU5H/ats1Pj7RPtcwL63ydiUqLDX3SvIHZaUtmQg
         mRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789407062; x=1790011862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uejRUvyuFcc6D/L4RGNRyiFIR0zJDJV2e12Q9seeuxg=;
        b=NF7E9kO4/Aol4YPQykVzP4wSHhlM9L7sCD6abyl1FtFRYG5gDujur7xxBzgIytkhr6
         hFeH8EmQ1x6as8y594HiLhTfJHZyFltluBmHKAz/9KLCmr2Rx7ivwEY00VIyrVVwEGiS
         7C1srhTwvQGi5dtmwuyUyOYZG6kr0lYzxf6QjgBPkEnMQDHRsROx3N5sfXwXlUIdfovt
         1UyW3aq1vldUiiq7c9x/Vzkoyx6fFM9KHgj9HWxMMBfAYhpxVYGa5WzNmb5B3kZ8dVt/
         XOqEmsDjYhjC5hagIv/iDgFz6s1Cnnw3hkVxe/fpEAQWPWj4Tkq1jeJwsbnFZEjxOU5/
         S3RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzanew0THdkluvKdAbYW2sIbEY55eLkTGB0oUcN3IUDi9EEL/Og+kMzPf0tTSt5tuNdBwA4Prk=@vger.kernel.org
X-Gm-Message-State: AFuF++l+Zih/e8VycxMZDrevdQNyiko6zTHtNxbr71nrqbP5ks06ORiU
	CJWUw+KiDgcewBmmj6afm1PhbS1PGwI7SrusExNMPch9shDa/9HNfugF
X-Gm-Gg: AYBFou3Ila/lSEx1xf1sv0DK36FhhKVV/2hl4ycswKsslnSsseP05hCLsOj6Cc2bBY0
	f0/5TUKrbvXfgwOHree+UVH+9FUaQjkKZIIY0kYoIdM1OBDMzTaYbR/PU2x5Lb83f8bbSG6zDzN
	RK0SP3ZqoqxoXUdw5WF8hDlkE9TmsxD+fXTAm5DlLxpMHTpN64Q9lQAP3kZDOpJPbnx/vxp3Z6I
	eXGmIaguFEANclF+7yFOpxt8/hESQrQ7OmiRH2zrXVl8+iT1eyeyg4jgPZTZuyGnwN/dFl6VbBJ
	giH/rptrG+JEupurkUPf0AVeYbRpW29cLKpEI4tF0ROBvKTXlWW6ecKxaeDxgsIJWrjXywb+QBq
	ul71zbRNz9KplgIuN4phFd5HnrzxO9KpwQlFD7JZXOMfBauIbUNbpP6xQzHRUVW5iLBivgv952u
	T4Vly/UIX6j3TFDXGO5WdgKx+IzQdS5gCssI3Wvb4SfeWbkApRG/wVOTzTKiSfW/hTXGsxaohBZ
	oQBtGTWM90tHIzpxw==
X-Received: by 2002:a05:651c:31c8:b0:3a3:74b9:8a7a with SMTP id 38308e7fff4ca-3a5c896409emr5494961fa.19.1789407062008;
        Mon, 14 Sep 2026 10:31:02 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.121])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3361f94sm25781391fa.32.2026.09.14.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 10:31:01 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mikhail.v.gavrilov@gmail.com,
	Maxim Skokov <skokovmaksimevg@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: free the skb when the DLC has no owner
Date: Mon, 14 Sep 2026 20:30:42 +0300
Message-ID: <20260914173044.5249-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_recv_data() hands the skb to d->data_ready() and returns 0
without freeing it, so the callback owns the skb from that point on.
The tty implementation frees it when the DLC has been detached from its
device:

  static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc,
                                    struct sk_buff *skb)
  {
          struct rfcomm_dev *dev = dlc->owner;

          if (!dev) {
                  kfree_skb(skb);
                  return;
          }

The socket implementation returns without freeing it, and the skb is
leaked.

A connected DLC can have no owner: rfcomm_sock_destruct() clears
d->owner, while the DLC itself stays on the session until it is closed.
Data frames that arrive in that window still find d->state ==
BT_CONNECTED in rfcomm_recv_data() and are handed to the callback, one
leaked skb each.

The leak does not stop on its own either.  The remote runs out of
credits only once RFCOMM_RX_THROTTLED is set, and for a socket the only
place that sets it is rfcomm_sk_data_ready() itself, below the return.
rfcomm_process_dlcs() keeps granting credits, so the remote keeps
sending and the leak keeps growing.

Free the skb, as the tty side does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/linux-bluetooth/CABXGCsPe5wykd8Aj-hm+SJ7SGQyb8yoGNnx3XDpPmBathj+EGg@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
Assisted-by: Claude:claude-opus-5
---

Notes:
    Noticed in the v3 thread of "Bluetooth: RFCOMM: connect the session
    socket without rfcomm_mutex", where the same leak is described.
    
    Found by inspection.  I did not manage to produce an orphaned connected
    DLC on hardware: it needs the socket to be destroyed while the remote is
    still sending on the DLC.  A kprobe on rfcomm_sk_data_ready() over an
    HFP session (RTL8851BE, btusb) counted 31 frames delivered to a live
    socket and one rfcomm_sock_destruct(), so the window does open in normal
    use; no frame happened to arrive inside it.
    
    Built and loaded on 7.3.0-rc1 with KASAN, UBSAN, PROVE_LOCKING and
    DEBUG_OBJECTS; HFP and A2DP sessions behave as before, and none of the
    sanitizers reported anything on the RFCOMM paths.

 net/bluetooth/rfcomm/sock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 958081adb9..82aa38715c 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -48,8 +48,11 @@ static void rfcomm_sock_kill(struct sock *sk);
 static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
 {
 	struct sock *sk = d->owner;
-	if (!sk)
+
+	if (!sk) {
+		kfree_skb(skb);
 		return;
+	}
 
 	atomic_add(skb->len, &sk->sk_rmem_alloc);
 	skb_queue_tail(&sk->sk_receive_queue, skb);
-- 
2.47.3

