Received: from mail-dy2-f40.google.com (mail-dy2-f40.google.com [74.125.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F932C8B
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131165; cv=none; b=PICYCejG+Hwmn2Vpim99tmuLw7kYIltXtw0zLSg4EDQmrBGh0wfuGmuv0s5f5nGYfpfbmRF3UAcFyaMri2JDsXnPr6nXxtKBmUXzCO8ewVhgF4XMn0G5LDukla/tN4UvPDJp0pmv0zlW2/d+NgCbBP1tX0u1MlVlYRl+7AiY4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131165; c=relaxed/simple;
	bh=amK8ElqSX7xxn1c3t7Pk4XyCHGO72+Mj5UglIjSJuJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUTA0BhmdW3DOb5e2mQjNkRvFALyGnA5Sgx6h+pJ4c3rQ2W99tCbqIbS+d1uOPezgpqxsR6znr9KzwLw25eVYuXxXPsKuRcjmNpIW9RPsGL/yPjmdLDsuLBGkGSgPZBCtj+/JQ783l2LZUpoQcNHbdbCYBsBRE61hRrj5BQKFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8FG3ZPe; arc=none smtp.client-ip=74.125.229.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8FG3ZPe"
Received: by mail-dy2-f40.google.com with SMTP id 5a478bee46e88-351314bfe12so267eec.2
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791131163; x=1791735963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jZ1eJoTadH6bv11VGShYOIfVRmew2zzu4O74pMeyNJs=;
        b=O8FG3ZPef9jFyyxb6yzCGWm3oJKDaAmbrSZo7WpLSOz0hVZRI4JFAE/3AGzw9lzy3D
         bREy/c48I0iOEQAu+RUHKEvT0ibRBziQW822LI6R2rJ4/0Jx7ebPDO7VM7fwD8+KC57j
         p4x9V8zQN52SGuKyVGnBaaya9yKx2M8ib4c+8LFypciDRsJaf5UG5kva8+g3pkt3n8xO
         Iwa5KsjHcg6gk/iJZD0GC4qXF+nGB83i7Ye8qLOkJ3mbYDEnV2iSuZu2brfPYOS8YpwQ
         l+tGpBr2owT+mHWlhS6PssJVMk88YevVp+/JQYOjtRflGdqCcd9vOj7qn4UX4hY9qOqW
         +FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791131163; x=1791735963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZ1eJoTadH6bv11VGShYOIfVRmew2zzu4O74pMeyNJs=;
        b=SBVOOTuGkN6as7fmkpWFrs8yRnv8OvxBA/gZk02NwiI9b0P7Ot3Ex6+HyMMwCIAUJZ
         /IlF5uiQlEEb7Ou4qz1oRiuvj8FUufNRYyx8f4iooUFlo/oyR7mS5AOloJDrH7R+C4z/
         hqs6cWk+wAyGwzlXWCNm5h2xdgyyf7m63GTDzbVH7xRIOgW3dFDbFr1vv21HbOSuHYOl
         AERxMsZ2QmPRl7mSz2+IKq3T4K+8pPxtBs6bvKbeQhfvv0NC2cMGsywsxwG6ZChPz2RA
         yCgzsqcP8NN7Jc2Wrtn3Dq/1PnoN615pv+dqP2zZgad0CqWhMCtJ+TSPmM+4TnZEvBgz
         CNIg==
X-Forwarded-Encrypted: i=1; AKwUvBxZfm6nS3A6OyGwFpI+mDy7tideo+PLTDZ3wkBZB8HTuNyYZYToljMF3b2mFvk2yDv9qckcFL4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqb+5OTO/v5IRsWVHA0ZVSQrE+ib3LdkgxQxLib+Y0SvRHIQNg
	hU7V6Dx6NEXwP5yXiifGiTBqHOBfv0UZFvSqkGMQCxwGCA2SlrvuYNYW
X-Gm-Gg: AYBFou2iI7Y9LI90mwoTokeEkpOFwc19DWLeufwXGD9CB1gaBCrreyFQf/Q65k9TabU
	CLekbdzdgDlpTtb21wrFJM7auv6LhZGZmw8Hf1ow9kz6RgWu9WMWKXtYQ0MNfIN9PJehNE1Oqr2
	1A8GsN0QTAxLZGkFD/TVU+Ylwrq6RC4c9J2cj/xqVF1/ASoV7mzLQ//Bb2qbNZZZlLeerGq+YrN
	x46oebr7sf/ghil2UggFgLOkM+sOHj5/eAsIcPc+05OVDMdtkMiCgCoMiRwHitXflUId8eOTTWG
	oDzPQDixcOeftBDY7eoIAQVVqEI0oYw0ugahW+OGtDydNAE7FOKtZJOn3iuT9vVGooxUuXn3rM9
	QnS3Z1rwtRUGvueCyllPcd4NYcXHfrsB211Ci4hOEgX954D3XMN191f22snhWVnF06rZTR/Fu49
	jUDZ7c2rXF7R6swkb7iYe7Pd5lwY6Jnc4HQU/OmqCbsaAnLDNCn2VWufL5VgMBvU1929VZ5TFfc
	SR1O6PVmuApoXjTzJ2NiYVVhEmi42TvQrU9uXWv51lFZADnAf7VLgPxEW3EfIkOKsNseA==
X-Received: by 2002:a05:7300:24c9:b0:343:fdea:9a0 with SMTP id 5a478bee46e88-34f15028c8fmr17583068eec.2.1791131162529;
        Sun, 04 Oct 2026 09:26:02 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272ceb02sm11517960eec.25.2026.10.04.09.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:26:02 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Reject concurrent BIS listener setup
Date: Mon,  5 Oct 2026 00:25:48 +0800
Message-ID: <20261004162548.3968712-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_sock_listen() drops the socket lock before calling iso_listen_bis()
to preserve the hdev->lock ordering. Two concurrent listen() calls on
the same broadcast socket can therefore both observe BT_BOUND. Caller
A can attach connA and release the locks, then caller B can acquire
them and attach connB before A publishes BT_LISTEN.

__iso_chan_add() checks whether connB already has a socket, but not
whether the socket already has a connection. The second attachment
overwrites iso_pi(sk)->conn, leaking the connA reference and leaving
connA->sk intact. Socket teardown follows connB, so later events on
connA can cause a stale socket access.

Recheck BT_BOUND and require iso_pi(sk)->conn to be NULL after taking
both the HCI device and socket locks in iso_listen_bis(). The connection
check also covers the interval between attachment and publication of
BT_LISTEN. Reject a competing setup with -EBADFD through the existing
unlock path before allocating another connection.

A recorded KASAN report from an instrumented kernel shows:

  BUG: KASAN: slab-use-after-free in iso_sock_hold+0x119/0x1f0
  Call Trace:
   iso_sock_hold+0x119/0x1f0
   iso_conn_del+0xe4/0x270
   hci_disconn_complete_evt+0x351/0x8c0
   hci_event_packet+0x71b/0xb20
   hci_rx_work+0x293/0x730

  Allocated by task 93:
   sk_prot_alloc+0x113/0x220
   sk_alloc+0x2b/0x6d0
   bt_sock_alloc+0x29/0x370
   iso_sock_alloc.constprop.0+0x19/0x300
   iso_sock_create+0x94/0x100

  Freed by task 93:
   kfree+0x121/0x3c0
   __sk_destruct+0x42b/0x540
   iso_sock_release+0x29d/0x340
   __sock_release+0xa1/0x260
   sock_close+0x10/0x20

Fixes: 168e28305b87 ("Bluetooth: iso: Fix circular lock in iso_listen_bis")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6 Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/iso.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7657c2a0abbf..2e70c0df9ef3 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1340,6 +1340,11 @@ static int iso_listen_bis(struct sock *sk)
 	hci_dev_lock(hdev);
 	lock_sock(sk);
 
+	if (sk->sk_state != BT_BOUND || iso_pi(sk)->conn) {
+		err = -EBADFD;
+		goto unlock;
+	}
+
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
 		iso_pi(sk)->qos = default_qos;
-- 
2.43.0

