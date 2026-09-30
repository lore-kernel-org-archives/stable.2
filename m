Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34294FDA77
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782289; cv=none; b=TRWvLAklvBpqMshwrORk+H5UsZEceLslO+wfl51HvL/KEIxIYHCdIcKhk9FQx4yOQEvmRdlBlq/ubcQqexa6Q2pYp3/o54FfBIumkbCUQjTtzaLHyyWfNmqYuRHoKvmna0bj8PSEEJQSRrlMo5jXqJ2GDnCMqayQkzKL5+4XDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782289; c=relaxed/simple;
	bh=Mnb22KD09GmOz29J1D/Pjmgctjw+1VeUXnhXgWi84tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsW7jttOnlcFlDIhCgNUFHFVWCNrStFnUPj0Q+rOPY5x/+cQZCE+t+CL4gXXPpRBvBZZIwpb32iAhXpQ1yCuUHJNAG9SVSJbcJv22J1/wx2yt0VV9HCqDMs2ixTinsuRWSgaDaUrlXJC1Vv7HTk8R2foLn9YHCS4IPLhku3TRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY+Fiz5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY+Fiz5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABF11F00898;
	Wed, 30 Sep 2026 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782280;
	bh=WMwaoZJJOXOur+1MxglNGSjVX/CLNjq6xylUFB1e7dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SY+Fiz5Ny5JW5WZO3F6PpFk3AzPscmLyoZ2r0lAeZoiBLYW7lQ3s2ZgLBHjI3dpiD
	 7EQp8XUCcTpTzjBREqvcAEJgyfYaJF2+3cdjRMlZrW+2TxVPGF0udzy0zl/hCY080K
	 gJ937CWH1npeFEnvs7K+pXPrB9qGt7a+IjgsvdpRnvqWRaqetF3cQ38Sd7W2cmWh6H
	 hFXmFUGBkHj/o1MxMDzvJ6T+GqwffVydQSDzwjcDGx4h+i3brlDEM2TU++FSDhhae+
	 wCfrGMIB2ImrBlYOtTBen9W44OpPbLlb66pnXt9PZOgSPRC16h+wg1hggzAcn96PvH
	 yGx1NpBuDd92g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] Bluetooth: ISO: release unused CIS holds after channel attach
Date: Wed, 30 Sep 2026 11:31:16 -0400
Message-ID: <20260930153116.2781860-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930153116.2781860-1-sashal@kernel.org>
References: <2026092936-wildlife-vengeful-86d9@gregkh>
 <20260930153116.2781860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

[ Upstream commit 0fcd4dad555c96e0bd3a1b8c569f989be85c7341 ]

hci_bind_cis() and hci_connect_cis() return one hci_conn hold for the
ISO layer.  A new channel association consumes that hold, which is
eventually released by iso_conn_free().

There are two cases where iso_chan_add() does not create an association:
it returns success when the socket is already attached to the same
iso_conn, and it returns -EBUSY when another socket is attached.  The
hold returned for the current call is unused in both cases.  This occurs
when deferred setup calls iso_connect_cis() again for its existing
socket, or when another socket attempts to reuse the CIS.

Detect the idempotent case while the connection is locked and release
the unused hold after iso_chan_add().  Also release it on -EBUSY.  Do not
drop it for other errors: a newly allocated iso_conn releases the
transferred hold when its last temporary reference is put.

Fixes: 69997d50ec57 ("Bluetooth: ISO: handle bound CIS cleanup via hci_conn")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 1674e8bc95a93..51864345f7ab3 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -450,6 +450,7 @@ static int iso_connect_cis(struct sock *sk)
 	struct hci_dev  *hdev;
 	bdaddr_t src, dst;
 	u8 src_type;
+	bool already_attached;
 	int err;
 
 	lock_sock(sk);
@@ -511,8 +512,14 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
+	iso_conn_lock(conn);
+	already_attached = iso_pi(sk)->conn == conn && conn->sk == sk;
+	iso_conn_unlock(conn);
+
 	err = iso_chan_add(conn, sk, NULL);
 	iso_conn_put(conn);
+	if (already_attached || err == -EBUSY)
+		hci_conn_drop(hcon);
 	if (err)
 		goto unlock;
 
-- 
2.53.0

