Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FABA318ED2
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844635; cv=none; b=ej3Y0+6vW6MtdeCp0iWntxo+Ks2QGkek6yRv7P+X749qBjtOT6XpXzzs+d8gnG4tBJeQ6dG1V1e1BDS2ePIN65T6Q9zVxWhT62ngriQB+zhWicWFEB8PEcCeb3kU00AcnNgSqAbBMb7VIGr5eR5bMzNosz3nik1B6SveKt1uehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844635; c=relaxed/simple;
	bh=G78kO2YlKw6hofYEZWpDwDqcj/rtK+Y1UaM1JNwvwnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TinEsbfIX7wFa0iv/7S4r0C2zxnqNJhKS3MmnLyryh8ukBSiagylVlCKGUO0/gqGSbC+uqZkQGVM6mdqdesmfeaG8TAcxelK4sfAg5MYZ8+sSBGk7f6jfvnf2C7ybfXdQ57F5fqF8i92RU0QSHnvjWrH5nBL06sD0ObQ4CUT25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKr+Lakg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKr+Lakg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49571fea44eso6651055e9.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784844632; x=1785449432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OjfP9ikHyH3mQBp/myz2Nssbup3gp74NNkUjx/E2Hv0=;
        b=bKr+LakgdN/lJL9f4HiouE7tkJVkyZt/I5T5ooJwpHeryavL5AiwzekuruEN6TTtIl
         3Nq2oHqKeM+0eSeDVOh3MHZPxqWUJQ0KUzv4bz3Q4SDEPO7ibmPMg4QPasf2neMVmyRP
         9mi26XQV8MNLqAbKcn8YW98ZLR/2LvbELS/ck5trbbQ4kBC5MREaQ1EpJhHsqoI/IKWT
         guekvzVJ+zFFtlf9+dUmFoApQpEPHVl8+jNZo3kFyN5ZbEQTwr0kv797mCl3SwXVbfSE
         dhmNwl+KsTiFmhauEscSUyMwPeN/N5b+W59vAzh25diuKwGycvFWN1TDD8bqdBHED8Ow
         C3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784844632; x=1785449432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OjfP9ikHyH3mQBp/myz2Nssbup3gp74NNkUjx/E2Hv0=;
        b=dB2XHAqjekvh2uI/UbKljuyiM9KR4y17e+qcXXexcVYrn8a7SKa23ZFjzk5J2h6QAM
         PRJehDwOk3bwQogflKIfl99oV7r3og3DJeif6R2UyEpROqB4xDgi02nk6OXb2XXIBPb7
         k3XEJl84BjjeExPDR7T3ftxRgJzQu7SJxkUjDdqMv0Sm7kG9VE1KniHHeQBmWAmK05BL
         E2TYU8mpbMHcg1OlOWQH3WNPqEi7g3n3dhAaaAhb8aQzSGMk+IdP/Cw2Ys4VhrVCnTh2
         QYJcJwyb4qC2a9DFx7nMLxzteTsSqms2/kGWP2cRPD2Hj3vjETUphg0cRmbuoFj95UPy
         UJWg==
X-Forwarded-Encrypted: i=1; AHgh+RpsMQBpw1EhOI8XwWquTwByDKbJ8uFqnnniD3eQVmLObimArbfa4Oxd0VTIKeTDeWD4lcYku2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJYW/3En8XthcdDEGkKa3NAuMVQrrcfJGbCcFb9kWyta+i32U
	h6CnXrNEEpDXGinddztudLFmm1sS0jHX/0eLLJ22N9LK76wbzpUcBwJE
X-Gm-Gg: AR+sD13AdAut9avcHJqtDlZeThCqk8VPnB71Z7d4KfultaCQOUImY0psuEZn5eYCjMi
	DSsjmIfvM2VuzBASjW0Y8bopLzyV9NlKRuUELQLeDWuUQ7tPmug37SwwtFiOYdsgZVFKdH8/mPY
	kit/Rv4U74GQCz7jow+Yx8NUCqMto6qprzoZ8zZ2Adu5sXIlwpTfS39N96LqNK/evEq5ttc+lCJ
	SI6qOdLn5Dmin/ztxOcpJ2MrAcgoTDzv6YbbeZsnFJNz3hoYCTyBLCSCGBBfUnOvbEYLnaIfier
	y/+T2BkFa7amJ9Wtbavr5LLTT+pRjCQFi1aqTPPdBq2II9WXYsws/If1k+a2RxcdtjmuDDx7uOt
	9L1YqfRzqlBOvUmRokBCvLLWJy5GQVY6hbcY3RT75YTFmkaWLMKH1XtRhMyqyZObD7Ds9rw==
X-Received: by 2002:a05:600c:1546:b0:495:5205:86c with SMTP id 5b1f17b1804b1-49573cfa349mr51851885e9.22.1784844632101;
        Thu, 23 Jul 2026 15:10:32 -0700 (PDT)
Received: from beelink.. ([186.247.163.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957afb4e48sm22256635e9.13.2026.07.23.15.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:10:31 -0700 (PDT)
From: Your Name <qwe.aldo@gmail.com>
X-Google-Original-From: Your Name <you@example.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: SCO: fix refcount over-put in sco_conn_del()
Date: Thu, 23 Jul 2026 19:10:13 -0300
Message-ID: <20260723221014.527674-1-you@example.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

sco_conn_del() takes exactly one transient reference to the sco_conn via
sco_conn_hold_unless_zero() and drops it with the sco_conn_put() that
follows sco_sock_hold().  The additional sco_conn_put() in the !sk branch
drops a reference the function never acquired:

	conn = sco_conn_hold_unless_zero(conn);
	if (!conn)
		return;
	...
	sco_conn_lock(conn);
	sk = sco_sock_hold(conn);
	sco_conn_unlock(conn);
	sco_conn_put(conn);

	if (!sk) {
		sco_conn_put(conn);	/* drops a reference we do not own */
		return;
	}

sco_sock_timeout() has the same entry semantics -- one
sco_conn_hold_unless_zero(), no incoming reference owned -- and simply
returns from its !sk branch with no second put.

In steady state the only counted reference to a struct sco_conn is the
one held by the socket.  When close() races the controller's Disconnection
Complete, sco_chan_del() clears conn->sk and drops the socket reference
while sco_conn_del() is running.  sco_conn_del() then observes sk == NULL,
its own put drops the count to zero and frees the conn, and the second put
writes to the freed kref:

  BUG: KASAN: slab-use-after-free in sco_conn_put.part.0+0x1a/0x190
  Write of size 4 at addr ffff8881099dec74 by task kworker/u17:3/413
  Workqueue: hci1 hci_rx_work
  Call Trace:
   sco_conn_put.part.0+0x1a/0x190
   hci_disconn_complete_evt+0x1ee/0x3e0
   hci_event_packet+0x54a/0x650
   hci_rx_work+0x321/0x3d0
  Allocated by task 413:
   sco_conn_add+0x72/0x1a0
   sco_connect_cfm+0x88/0x670
   hci_conn_complete_evt+0x4c5/0x890
  Freed by task 413:
   sco_conn_del.isra.0+0x3f/0xf0
   hci_disconn_complete_evt+0x1ee/0x3e0
  refcount_t: underflow; use-after-free.

The freed object is a kmalloc-128 allocation, so this is an out-of-bounds
write into a reclaimed slab object rather than a plain crash.  Opening an
SCO socket requires no capability, and the race is reached whenever the
controller delivers a Disconnection Complete concurrently with the socket
being closed.

A related refcount imbalance introduced by the same commit was already
fixed in commit ed9588554943 ("Bluetooth: SCO: remove the redundant
sco_conn_put").

Drop the extra put so the !sk branch simply returns.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/bluetooth/sco.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index fcc597be5bbd..6502fcdfc0f0 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -265,10 +265,8 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	sco_conn_unlock(conn);
 	sco_conn_put(conn);
 
-	if (!sk) {
-		sco_conn_put(conn);
+	if (!sk)
 		return;
-	}
 
 	/* Kill socket */
 	lock_sock(sk);
-- 
2.43.0

