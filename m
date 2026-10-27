Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119823;
	b=jkj8BFmMHLFyCs/Lg1c7lENHCFhK8JNbyJbilLlEodQDVoVj4tVhu96nacv7OCLAum1o
	 t2kc5XUeajImxie6UxddKkxe65yXBJIzt0rH09bEmxV2uUat7LeOtAsDKf6KvO2kAbbPi
	 YuonAU4LmiYXx4seV+Qm5ZXOVfYrMuKe0KmFiNk01u6aY+zrZ8A/hQTA0XLXjDPtie2Oj
	 L2Jfs+cbQv7kagCv8S9T6ZbXYhHQ37y+hqF1v+khmRtaOLlpYgwQ6nhhRqEZXwGuOLqRp
	 5g9TkyU6PtvNGsUXCukL18DU9OoHsx9MTXoDA01aNvFBnSnDDojcoQ8CXTzGTcV3qxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JwYZ8K/HWhh69ZRwdx8vD+GcbFUXkgT4Nh+DRyTzZvc=;
	b=ED+fYP+mrGQniw5D66pEH0OjV5yPoLULjG2omLx/X4/2CRe4leB+SrtG3/3uUnB8Cw+i
	 QjqCkTnmaZetfIhI/khXaTcNgKGxk0bj4g49/ZQALh9+vrHCAdnIW8RxsFzUk6iAuHWu9
	 63RZi/YL8Fqd/AvlCQdX3jzaxkSZehNPVo8iwWBnEaDAhgW54OmMlCD3AP/FDRSKD7bpg
	 B/KO2nIs32vC2x7wxbAte4QK86DiV9dEiw0jzR2Xh6XbcJfvWRnZJ9nxCj8h2yRHyIkAo
	 aY6FTiw0Fy9GZlKFCHYFjvzr8Rzsq63QZUQOKA7K+LOSQJZgtjMAHHd6lL8+TIqT2bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VCh+/ckQ";
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816B606A321
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6816B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VCh+/ckQ
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-820ad3183baso9227a34.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119822; x=1793724622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JwYZ8K/HWhh69ZRwdx8vD+GcbFUXkgT4Nh+DRyTzZvc=;
        b=VCh+/ckQY/TOpJsVYCO2OGK2DoHv3xhYuWxnwbY41ySZzRUjTMsWpo1M/C4l/Sv8+L
         KDazH3Y0gd3/12WlgfVgkH1Otdg7uE0voIvPIFpK5raI+YX32DBQUq3o5q+5I5ZsxzWb
         2o09QB2sHbjjBOZJy5RUhleefJtNRPHBBPAVOchIj47UocWY/dFGNIziD0Nnu82HePJ6
         VuxIcTHaooTJkndMYK2t0kYAsJxsH20ij4ibP6Lhgj5uTzDyPn4dMdPuXLqskX9IvPbw
         wa0O5t8+WoT06yPH7wWSWjUQqFVTZVQ6TpVgc6fJEBLpxt0aUlCvFN7jRY11NILJZwkI
         RKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119822; x=1793724622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JwYZ8K/HWhh69ZRwdx8vD+GcbFUXkgT4Nh+DRyTzZvc=;
        b=T5/0GF4sMzh848eJpjoDvrAVo07pJvx+su26S7pwZVBJt7UmXpDvKoYQ5KevmGCjW2
         x1/sXaw/U7tV2ftV5lLt8Swa/1c5nYs6cNLte9MKh91it+ChbEWX9ItSnjJSgi88oXii
         OIQG4fUv0W6WqndHfatYCe6noIFN4OdjKubdhaOFQ+fcTb/6d9hb5cEJbRnfSi25KQ5s
         GbfS+61Q/adQaEpnTbV1/WNnEWsAiWfS/TxjjH2iUHwHk9w3lzaWPQtWbEkMfl56JVyD
         h1QFRZNlBQurejFV6b6RogS8TQBAJJaH0Agiw7JpGEmmN8IQIGbOLiFstJynCid3avOk
         rckg==
X-Forwarded-Encrypted: i=1; AKwUvBygFAgEv2vCrBEbutT1zIr6oYe4gIeYl4l5OYyGqmCPxalwwXp6/qXp+pkOhXMWbCD83k314Gw=@vger.kernel.org
X-Gm-Message-State: AFq9FYICNnbLF2Em+006NHa3Vvfo3yuyWQBsLETGKephI5uGUHfx1RrF
	145QGsu792xEg7eiai56A9F/rP8hr+TD6BGJuRfYE9/U1aqxJig4Nu4C0zmpTGsPxWFnfg==
X-Gm-Gg: AYBFou2ZR1TvgKe3Gquj2R5dPIXABC2XwEA2iWTu1P9UvgOfzPJGZSwA2rH4Vd73oze
	3gsYGw62pXSWBm2xCKLrkbhcZ4+C4pMqfkhA3QjfC+4sHEHKYh8B0kl29lRqrnIzZEKe9cmf5qb
	ATqtfTuf5NcbxgcJJp0LQ3wEKUwTrkOQhlMzCgCrrM3AvhQORlbDLuGKWr1DHHKx4CkH9Z5siyD
	9inOhk47DG1KnjqfFJ6eVRMBmxqSAtyuNSOwep/7HJqT1IZeF20gBepMz39nfMtoZoO/As2pmUY
	DiwmwAbY1KU71o0JMwftTbdg72QFidAYFfdt4p9z3I24o5KVgvdSi/Zt349xfGZ+rp1xdbq5rh+
	jia+w1E3QQgOMhlEap30GR/aIvKbB0OKpCZzgkdvTw+7MUHc/dmwcNZNmJjKTNA8LEqkaagwtZ6
	MTQaGjUVhcA4W9U16zWFBSQbhGsb9Wb7fKurBWkxoiXt3FXIT/tMOCjnwQAmDn0bMnDN78lzePc
	PSTXZVtE8caoTxKQYKuyQbKD/wyI898YRVlUJ56YGyMpSnD1McAOCEaAcbVKF24BiW2YCV7ew7C
	tbc5uRI1ZaMzUPRqJ4Pvuok77HUrek81mUQ=
X-Received: by 2002:a05:6830:658b:b0:7e9:d593:896f with SMTP id 46e09a7af769-85abd31a84cmr44201a34.1.1793119822267;
        Tue, 27 Oct 2026 09:50:22 -0700 (PDT)
Received: from localhost.localdomain ([37.19.221.77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0749dcsm10927058a34.11.2026.10.27.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:50:21 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Hitalo Souza <enghitalo@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: hci_conn: synchronize with SCO disconnect work before reuse
Date: Tue, 27 Oct 2026 17:50:09 +0100
Message-ID: <20261027165009.2401154-4-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027165009.2401154-1-yaroslav.voytovych@gmail.com>
References: <20261027165009.2401154-1-yaroslav.voytovych@gmail.com>
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

Checking abort_reason before reusing a SCO connection does not
close the race with a disconnect worker that is already running:
connect() can still report success just before that worker aborts
the connection.

hci_conn_hold() uses cancel_delayed_work(), which cancels pending
work but does not wait for work already running.
hci_conn_timeout() reads refcnt without hdev->lock and, after
seeing no holder, calls hci_abort_conn(), which sets abort_reason.

A new connect() can check abort_reason and take its hold between
those two steps. It then gets a connection that the worker is
about to abort, and the Disconnection Complete closes the new
socket with ECONNABORTED. This applies both to a connection whose
link exists and to one the remote device set up, which gets its
link from hci_conn_link() here.

After taking the hold, wait for a running hci_conn_timeout() with
cancel_delayed_work_sync() and check abort_reason again. If the
worker has aborted the connection, drop the caller's hold and
return -ECONNABORTED.

The wait is safe under hdev->lock. For a SCO connection,
hci_conn_timeout() does not take that lock: hci_proto_disconn_ind()
returns a constant, and hci_abort_conn() only queues the
Disconnect. hci_conn_del() already waits for disc_work with
hdev->lock held. For a new connection the work has never been
queued, so nothing is waited for.

Once the wait returns, the work has finished and cannot be queued
again while the caller's hold is taken, so the second check does
not race with it. If the connection had no link before, the link
hci_conn_link() just made stays with the aborting connection and
is released with its ACL hold by hci_conn_del(), as for any linked
SCO connection.

A connect() that comes before the work has started at all still
cancels it with its hold and keeps the live link, as it does
without this patch; that case is not changed here.

Reproduced by delaying hci_conn_timeout() after it has seen no
holder (a debug-only change, not part of this patch), for a link
set up by the host and for one set up by the remote device:
without this patch connect() returns 0 and the socket is then
closed with ECONNABORTED; with it, connect() fails with
-ECONNABORTED.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Cc: stable@vger.kernel.org
Signed-off-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
---
 net/bluetooth/hci_conn.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6b92fd0177857..c1c8d2b29e3c0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1935,6 +1935,17 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		}
 	}
 
+	/* Taking the hold cannot stop a hci_conn_timeout() that is already
+	 * running: it may have seen no holder and be about to abort the
+	 * connection. It does not take hdev->lock, so wait for it and check
+	 * abort_reason again.
+	 */
+	cancel_delayed_work_sync(&sco->disc_work);
+	if (sco->abort_reason) {
+		hci_conn_drop(sco);
+		return ERR_PTR(-ECONNABORTED);
+	}
+
 	sco->setting = setting;
 	sco->codec = *codec;
 
-- 
2.43.0

