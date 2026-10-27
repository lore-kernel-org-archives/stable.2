Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119821;
	b=UUu/cdDYyQwmEWEvOG9Rat+lNH0CJv69z69tYhLFzg0EwR0ItEIWfFtC5P9zX1yJKo7W
	 w3xYlKtTIQwKbePJtWJhc1kDNiIM9Geh0J2vuRoaBYVuAMQ2TKO1BEKM+H0VxJ+1nVUzq
	 tU0J5YK5/6DPBgsspvqPcgfgviS8YdUwT+Jely+kia2k1oTOJKmqOqLr2JA32tLebhhU7
	 FS6JKKhJavgUueGQGepo116GorKTaSJm8RfhR9W8zzWthXsj4YiF79YStgtvSbuQZEUEe
	 mU4e14I9Xz7kM0t2tS/MksM+zJL9qw28/+e5tqwTzOtWrYEtm2oDmZk7vDSN9AghVIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Mz2DBXUEdTIOWIEUBBMP7Z0Vym1wsLsSE/Z0Bowg/lg=;
	b=f6lcfQWZ0t90Xd3keRsOjhkYrFHCZe1qNEWPKzngdJsb3WED00IuuBuVneBhke5LhWYw
	 kvBAZyY1bUTY3hQCttVZamb7QjMyT/J8VrfbQx0y/pcdzLn1kqTKKcnMRZ0Z4b9qhq8pE
	 WpcbgY+RDZzAsbjHYrsgCXV+0Pn8QJCzp8XR6vbFh2lRyF1eJ03a7r6Cqp+FNwKGQHph2
	 6pXGVkokEc4HLbJooqittqOACXPCuKg5Lnxqi8/SUNoKS9Dd820Hvj4kXSNbPX64Z1lhS
	 AVKLREhBHjwiGOnQYvs7NIzV+pBllp0vRMFurrr7ePyFA5gvL6F5qhvIF/mkLE4TwRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7bmwddl;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF286606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF286606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7bmwddl
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8459fdb1e17so7506a34.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119820; x=1793724620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mz2DBXUEdTIOWIEUBBMP7Z0Vym1wsLsSE/Z0Bowg/lg=;
        b=A7bmwddlPCZjKHmbGq0JSUgdYvLW8EVDnvcDTMBmYf6vWuOTPyNMLsV7cRhQ+1bEjw
         IGQF7KKqdfa/S95rvJblzaHdYTZzWPSStQwcjWIKVaReqJG0EZ4iiVpCVYA3YbEVkl3V
         3ahYDwl443hl16HkbYjhQQeKo043RyCyKLJHcrwy1EIH4ABZW4JSwnjo2gak+rUfzGfn
         hUaqJaMCCcpqwvX2SBUYR1avjDCTpVlE2k5hjbJ1hrakHWccNdj5qUXpZNgd2cGJNJdp
         hgaxuYW56ydky0xTkGoEyUV8a+tc3gkuMp4mJG38kzNtzziOOHFqYyYDbi8buhkY9PO1
         WC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119820; x=1793724620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mz2DBXUEdTIOWIEUBBMP7Z0Vym1wsLsSE/Z0Bowg/lg=;
        b=Jd9M3jVSgPXuJOzBmlW06jcpO/j0yyaVFeT5eTBgdybmd1oQ1N1mL+Tx3nH6i6jZnd
         4IE3y719KkBHYbRTc3LbMhmcqu62RXAjfOovYxkSA0SSOQy37juhaQ8Bp3f3sA0701PY
         hqKYCl8W8C/xwW7+XVyACBnWOJanwW60ZIzxzcRYWd8ITmPPZzCBB4Y7MxzxOh/4KHib
         TbS0YCNI/bjNFjWY/zP11VLNht5GiEVQAmtKAwjY2AdQJ/hrS3IU/pMhuzhny52lZtxp
         c793MQNvy2nBDs55uP05p7QtigOSmZCsEgvYTGhxWaEauB60tyYOPRu3DNIliP9mVdtn
         iVmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMcos+/Q0crtjagBKylTriB2xCM7B5IWm5MCUWhWQ3/8jKpmhp+HikOHQqn4FPHiqwF8mPom8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdv4jzslXA/Vr/3DInTOibH4C3pu2mLNU+S/j1WIt1+SFs5wgP
	apg0VxNCax1mHUGgHxyI4w7zDE0XU6+LTm+VD8HHIDZdHUluux3eZOQr
X-Gm-Gg: AYBFou039Z8oQoWjX1M4EsoxRIWSDezOGTHalyhgSVRjYlsDLDZuBAciO9M+luixRT4
	rX6M2j6Z3T7r76kff9URyh9UzxHU+5QajDBMCXnjUTVqQUmq6ETtmzY+wrph7I+oibWCGXnNYk5
	0Zr8dLByo49v1pBYgRUwV+AE6EEo5hwo7IGqnsR/t20BYWPittKlWE/Ztx+u5oBD7rTV4geX9KU
	Jp1vtQdvndURp2eTSKA1cu60+CVpW5D5M7NJORXrZOprimYRQ9zLpP1pSgLI8qHBxQQxppDTs82
	pJhiv6J/69ersiT7tQjGJQ3ArcWudB6y0x9DVyqN8WooeD0pZzgaCAqbneGVJgtKKM/D0WH/urP
	S1eNGHOQcUG344oqua/WhqbESshyGIw3bYuw5J6ikWgHXqLwflW/92mNSrjeVwegPW7r+JO92U3
	OTEIdsNhNl93fwdqY09PKBkb4wZT8QDqbIXAWbUh+FjMY3r099DSEUTJC8XW3r0ZdTEnoDp/5l6
	XIiqvVhN1EkHXGIfS8CR/hiPijo23DBiu5Fk8Qf27tZaIEHXNTUGrjbh/W+R4mrFVPTFpIjYh40
	1seiVgTYK+98fq9hmO+Nh8/J6+AUCWUW9bU=
X-Received: by 2002:a05:6830:a147:20b0:827:c0cc:1a08 with SMTP id 46e09a7af769-85ab5eae098mr119261a34.1.1793119819661;
        Tue, 27 Oct 2026 09:50:19 -0700 (PDT)
Received: from localhost.localdomain ([37.19.221.77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0749dcsm10927058a34.11.2026.10.27.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:50:19 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Hitalo Souza <enghitalo@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: hci_conn: don't reuse an aborting SCO connection
Date: Tue, 27 Oct 2026 17:50:08 +0100
Message-ID: <20261027165009.2401154-3-yaroslav.voytovych@gmail.com>
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

A new SCO socket can report a successful connect() to a link that
is already being disconnected. No new link is established, and the
socket is closed with ECONNABORTED when the old link's
Disconnection Complete arrives. PipeWire hits this when it closes
and reconnects a SCO socket during an HFP codec change.

hci_connect_sco() looks up an existing connection by type and
address. It sends Setup Synchronous Connection only when that
connection is BT_OPEN or BT_CLOSED.

An aborting connection is neither: hci_abort_conn() sets
abort_reason and queues the Disconnect, but leaves the state
BT_CONNECTED until the Disconnection Complete. A new connect in
that interval therefore reuses the old connection without sending
a setup command.

Before commit e6720779ae61 ("Bluetooth: SCO: Use kref to track
lifetime of sco_conn"), the closed socket stayed attached in
BT_DISCONN until that event, so sco_chan_add() rejected the new
socket with EBUSY. Since that commit, the closed socket is
detached at once, and the new socket takes its place: sco_connect()
reports it connected, and the Disconnection Complete then closes
it with ECONNABORTED.

Reject a connection whose abort_reason is set with -ECONNABORTED,
and drop the ACL hold that hci_connect_acl() took. The caller
learns at once, with the error the socket would otherwise get
later, and can connect again once the old link is gone.

hci_connect_sco() runs under hdev->lock, but hci_conn_timeout()
sets abort_reason through hci_abort_conn() without it. Use
READ_ONCE() for the new check and WRITE_ONCE() for that write.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Cc: stable@vger.kernel.org
Signed-off-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
---
 net/bluetooth/hci_conn.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7a55aaf197138..6b92fd0177857 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1909,6 +1909,14 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			hci_conn_drop(acl);
 			return sco;
 		}
+	} else if (READ_ONCE(sco->abort_reason)) {
+		/* The connection is being disconnected and stays BT_CONNECTED
+		 * until the Disconnection Complete event, so no setup would
+		 * be sent for it and it would be closed under the new socket
+		 * as soon as the event arrives.
+		 */
+		hci_conn_drop(acl);
+		return ERR_PTR(-ECONNABORTED);
 	}
 
 	if (sco->link) {
@@ -3272,7 +3280,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
 
-	conn->abort_reason = reason;
+	WRITE_ONCE(conn->abort_reason, reason);
 
 	/* Cancel the connect attempt. A return of 0 means the create command
 	 * was still queued and got dequeued, so there is nothing to disconnect.
-- 
2.43.0

