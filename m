Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119818;
	b=mt/iX4iKa7fcm2wLbQTDuz3am9D3dt8FItAwFnc5xii+oIFpoKmTjHSeR6/wCZqucfv7
	 8Fkfiwzz4Rg+pTPJQqVIO0FmNd1O+s8GYeLGXmppAUg3IbcXrj4mScg3yj32xuh6RoIMf
	 ua/WBd9u8uJDOZaFb0eXRKFE7d/wNVhBMIdZa5Bzuk9gvo+YNhW5DmIhNC8DI2Jahqyo6
	 umbbUgZcG9VxEZBm2yoIqzI85uX1jm5vpjC7ZfZ96V5hIvPgY0lkrrbDkGECQwlBeY+NH
	 +GTAlQpy5b+tHRFWKvJpQBi0CdDGIrZf9BSYYVDknfDV1F5vmsateoxrdFsp83zJlbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/4uABW8OiY3rHeYMO8zDAabmlkfTd/SaGhS/z4feweo=;
	b=tF6VWzY4X4GB206jlgWNBBlapP4Y7Qtybdg7b/kbzDyobAvC/gRYeh0cDt03qzS2tqdh
	 Kz7+aky+2F0xyglTixvH6+l3YMPNBe+VcIuU1MdmSHPuML16DMhsah834pJVeZypjzatW
	 kLoJt7J6kEUlqSEHwq3/oK/HUb7wQ9TMwqhc6c2AI6rE6qWKCblssAINTowk/131vHAz5
	 iJvM+vXH4XN+voFFKoj1krcGRL4dJD3RBprXxHvo9l7nRDlTdJ73rLX+gcyOKScN3QSpC
	 Js9kz3uJIoLpjtMI5G6vg2doKfTtpzcoldiU3am5lnfKKRkjwHCFlAIYKiWcsdJUGNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=la4w1539;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B21606A320
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11B21606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=la4w1539
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-83c1a9bd428so3549a34.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119817; x=1793724617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4uABW8OiY3rHeYMO8zDAabmlkfTd/SaGhS/z4feweo=;
        b=la4w1539TI11yfEnrvxu16oZX8aY02atnOMFhFecsCbLPlsc+qWmlalnnmLTLrhRB0
         cXIvBvW6AdVlwli/OTujmmOHe++pNxCW+WoLLWx97k4l2AjqirquI4ZzwUcfXoZ9YQtu
         8bCmVM99moCXyTyw2yydQxBqmWSc2UtzeLgDHnQiZRuzGBw7VSnVJWqhOrzvakukfkfL
         CAWtO5k2Rd3mKS36H7GyqDwB0iV6vkqIUBIa2xrUmc06KhKMrQheAPGT5HL9u/fnmgQA
         Ch6NpKShcV1J44hvq99uS6ZwrdIJ81bgxOvNUdBy98opNB8hXms2gGveQqZt8KWmzNBG
         +Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119817; x=1793724617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/4uABW8OiY3rHeYMO8zDAabmlkfTd/SaGhS/z4feweo=;
        b=ik2bd9VzLOiTk4IquLHxc72Pu4qm42OD52SYMoUySPySmfLy42FAEvSeejR5s4NXfj
         4QgSJzogxc4/OJ+8nXMNksEsKocXU/S8+RtaycRBQqwzTCXXqMLMv8ScEREQ4vx6v17q
         +A84uI/0tDstPa/b88P7fbUdZFMB+k4JFNJqO2KACrm1qSJYKoi4mraoJKg28mz/CJYY
         UJFwYVjpDoW219+zP++JqcvIzAXZ2zsx4CSZXVQQEoQHPAxhjV35nM9UNmOY6S8e46uv
         kKQ/hxxFTMr/tli0gJt4+6sbw7HKibpj+3j13mO2nyLfeUpRh9iwvYFOkmznQek+UKw7
         1Frg==
X-Forwarded-Encrypted: i=1; AKwUvBwWwYC0W+u8Br8159+kGUB6dU1CPaU65RI/ZURN7wy9DE/PYgS3curL7UMtPhwcE/pJ0HgGlaw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX7g9ZAblvkubUqi7+M985GmHOPqjNknE6CP5YPCL0FypwrdiE
	TuMbEf90e5bk7wcEC6G7f4MMqhGWNct9Ex0I/Ua07rFrfbGFmKpRR6uv
X-Gm-Gg: AYBFou2ly9+eMZTzFV69QsHWCyY4EEAX9ITMhzk5pmXtu5vrasP4jVKArRK9lpgMBV8
	sTzJDdhcnfgpYKEAtu34zZ5hMc5jDPi9ChVwhOCaRvU95DZU7+itiE6hFrs8NJnZyDAnHNjgTvL
	rJdz6q6+AOMgizqOkkhh/CBhD0+B9fL5cRcFjVHCuGSppHaC1+jbmfHipTMah2Iw/WCXCxHEIMZ
	tMzYtaxGEAXF19YtFeL5x7yih0A1IgHrW1aDi95GEAG/L7u76Za8RKwLFxoh41ksDgEoktA/ykW
	a5ZplikZ3f8WtmCNzULDKCQxa16agQuC9DGYaT52oYODB1LbFbuxF+9CFCArTKjmf0IudDhXiLZ
	8r9UQev8bs0EHeYSGwa73Dd6Ugs6G8jEo6JxVKRFq1VsNSQSBu84sF8A+J+TpSo58Gx1PnXFXkh
	mDVXGBDKO438O3+GijaVJwy5+nvAXUR6vs40gYZ50AMreC2vM66qE6F0QyAOc98DXJb7U3irQtd
	cd1Qik6bnURKk/VumNh2EZSN6dM3KUR6/oodTZaGc2w60JOlEG69uG+Q6Sv2f3ZVYARX71HcFNc
	n/sjjykrfnz3RvfCJQysetHbcmEEJXaOZ7A=
X-Received: by 2002:a05:6830:a201:10b0:828:f53c:92fa with SMTP id 46e09a7af769-85aba4245c6mr70437a34.0.1793119816992;
        Tue, 27 Oct 2026 09:50:16 -0700 (PDT)
Received: from localhost.localdomain ([37.19.221.77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0749dcsm10927058a34.11.2026.10.27.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:50:16 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Hitalo Souza <enghitalo@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: hci_conn: hold a reused SCO connection for its caller
Date: Tue, 27 Oct 2026 17:50:07 +0100
Message-ID: <20261027165009.2401154-2-yaroslav.voytovych@gmail.com>
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

Connecting a second SCO socket to a device whose link is already
in use correctly fails with EBUSY, but also disconnects the first
socket's working link.

hci_connect_sco() must return a connection with a hold owned by
its caller. sco_connect() drops that hold when it no longer needs
it, including when sco_chan_add() fails.

For a new link, hci_conn_link() takes the required SCO hold.
Since commit 06149746e720 ("Bluetooth: hci_conn: Add support for
linking multiple hcon"), a connection whose link already exists
is returned without one: hci_connect_sco() hands the reused SCO
connection back without a caller hold, while keeping the extra
ACL hold that hci_connect_acl() took for the link.

Commit 8a5b0135d4a5 ("Bluetooth: SCO: fix race conditions in
sco_sock_connect()") added the drop on sco_chan_add() failure.
When the second socket gets EBUSY, that drop consumes the first
socket's hold. hci_conn_timeout() then finds no holder and
disconnects the link.

When the SCO connection already has a link, take a hold for the
caller and drop the extra ACL hold, which the existing link
already owns. Keep the hci_conn_link() path for connections that
do not yet have a link.

This follows the ownership correction made for CIS by
commit e06d549fcd4a ("Bluetooth: hci_conn: fix CIS hold ownership
on reuse"). The second connect() still fails with EBUSY, but no
longer disconnects the first socket's link.

Fixes: 8a5b0135d4a5 ("Bluetooth: SCO: fix race conditions in sco_sock_connect()")
Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
---
 net/bluetooth/hci_conn.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b007f623b2ecc..7a55aaf197138 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1911,11 +1911,20 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		}
 	}
 
-	link = hci_conn_link(acl, sco);
-	if (!link) {
+	if (sco->link) {
+		/* The existing link already owns the hold on the ACL, and the
+		 * caller needs its own hold on the SCO connection, which
+		 * hci_conn_link() only takes for a new link.
+		 */
 		hci_conn_drop(acl);
-		hci_conn_drop(sco);
-		return ERR_PTR(-ENOLINK);
+		hci_conn_hold(sco);
+	} else {
+		link = hci_conn_link(acl, sco);
+		if (!link) {
+			hci_conn_drop(acl);
+			hci_conn_drop(sco);
+			return ERR_PTR(-ENOLINK);
+		}
 	}
 
 	sco->setting = setting;
-- 
2.43.0

