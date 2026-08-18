Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D63C65E0;
	Tue, 18 Aug 2026 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052838; cv=none; b=PCQ/GiAejDypmIm7bTA+1CKgVTVCM2+npQ5b9d5J+YtlcRQS+1apqRXak+0yqgNupgSzSHkher45kMYstKp5EDD4Vq2nnCrnlrIJ6cBcJJp3KhITxZHssak8B6zH2TBj0eXaRaKPvkqPK0DVlMjW4vQDigmtF6XRrNUUG3VvJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052838; c=relaxed/simple;
	bh=jJEBBPJSqWnu3QQzLgejLZ60VtYcy7YjpdXDmYlpnEA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=OX0QW7AeYuE3GYCx/Fm//w5Yx6/K5qjwjVrS+V1kSGUFSz7F8hi3OYk+Jr+XEkg7B36iqUoo1kNY0vEJdsN+ziPr9o/QSNr3I69w8BYzhK9rK+ka1sI61cjgtjgAY7y4XDYVzAEABy8svUeK6pHOmrrhYYoWRHFWFIsutWZVgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YCveywr4; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YCveywr4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787052827; bh=dLN73I0h/aCUJGAm3PamUt5YJ/sap0gn4ViSvQSiBSM=;
	h=From:To:Cc:Subject:Date;
	b=YCveywr49xmT8Kek2pqk3H20XpdMOqJyAwWcggamX8iFrTBUKn2/5gqOqywObVgsu
	 U8GovQ5SFHdFWh3qU9Rn9x/bT70ygeuuFk6236zoCPfRqLh9iPI4C2XI/NZYZlvFeL
	 N2KIGIT9f2K6COz15kSKJHwhEOEqjlOfzSjlghx0=
Received: from localhost.localdomain ([240e:453:ddc8:a66b:124:844d:8bab:70af])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 86C22AF6; Tue, 18 Aug 2026 19:33:44 +0800
X-QQ-mid: xmsmtpt1787052824ts09wozd7
Message-ID: <tencent_1E12CBD7417A4019FF058EFD19B1DB930006@qq.com>
X-QQ-XMAILINFO: Mu/Y/wNdJF3z8VRldg7DPfs7UgcV8OGVjQOfu3tZBKmKrXmFCr4HVsCVcwlIDD
	 O7mnYsHH3gVEGELFvNxqZ71o22wzLYkBiWRQX1CqpHCwPrHbGUB5Hr9/roTJrFvK/sftd/odvsEC
	 bdoEDyd1vFX9oqRref4mZ/tehz6SA5DEa6stM+FHGuXavQ4vSHVJHIXPcqL5zOV5f7md3PNwv8e6
	 Xk/3nI8KnHE+h3I4h/4ueKfX+xmj4MYTJVoAxcd1CmkXi+h/qPGhPlZKn1PHzmSHl6sIxXkWsaUY
	 97NNlqJ9k5HqoiLvqDKQ4YtBPgKFNVJ3IxRYNHEva0oduGerbwc55AjfOb8imoRbQYySi/qJbCGG
	 wOFb6EdlGII0Pxc0D3q5UE4nzv9UI9DI+z9/IkFA+DbpOUSpNsUQvGFzDBRtl5ddlivqkxEI3EZX
	 5aki50DFAyrF9c1uZ0XHGPM25E/ymh1jmt+8UrxNWobyfwW2DOeJDm0nwNsg3qPqRQdzdDTz4RFg
	 lXfUEmWg3xIXJMwAq8t1N8i4SHhWlDmFnIN8J7Om3lmdZP9OdjNjT6VWxKWl1CsOCFf0kGI4Y5Zt
	 pHEDMSckGxsmH4C079z+LcjIS/9ZB7FngMkB3oN5EL3xJWNgNWCZ1Q6SYguPsbwjfjB/i2OrDSo1
	 mj2xx9nVtdPyGN4v1Fw6Ah+hl/PgwOIshzqHw3AeJr7Clpbi0JAWkkzwY7KMUgED07mwFe4MhP8/
	 g4yPhTuryLAlesd3wIYAb9LRSEW4rhKmGqdKBNtS/NF6zzE7KDV0c0rI9O/nKoaBZX5qamj7Oc7z
	 VrG1ylqxeBilKfAJQfN9x9HuM8rp4TGyQDdmDiJEco5VY8V+kAk7SDPtndIMvaPlTnTjc+pCbCh7
	 swzULveYFkFON/jw0TGh3dI3+8mtzZinfuHkKej6h7Xxu+lK8pBxB9ziawv+hVVkhRZkM1RlWrl7
	 yigvgV4sWWNXa7UYAo8GAYSmm5N6ZIYfjA2OaHV+oKtEhjCuiwzA0AqaoKaSwRlrZiUQ5EEvxrR3
	 YYgoSVZfX58ACrOO9ehljSvSiFWcyxexjwFQhUVGUmKV5jnOks
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	pav@iki.fi
Subject: [PATCH v3] Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
Date: Tue, 18 Aug 2026 19:33:43 +0800
X-OQ-MSGID: <20260818113343.50163-1-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_conn_ready() looks up the BIS listener socket with iso_get_sock(),
which takes a reference, and then, without re-checking its state,
creates a child socket from it:

    parent = iso_get_sock(hdev, ...);
    if (!parent)
        return;

    lock_sock(parent);
    sk = iso_sock_alloc(sock_net(parent), NULL, BTPROTO_ISO, ...);
    ...
    iso_chan_add(conn, sk, parent);
    ...
    release_sock(parent);
    sock_put(parent);

If the listener socket is closed concurrently, between iso_get_sock()
and lock_sock(), the reference taken by iso_get_sock() may be the last
one: the close path drops the link-list reference, and once
iso_conn_ready() drops its own reference at the end of the function the
socket is freed.  The child socket, however, is already linked to the
freed parent, and a later disconnect of the child runs iso_chan_del()
-> bt_accept_unlink(), which dereferences the dangling parent pointer
into the freed accept queue (a use-after-free).  The same dangling
pointer is also dereferenced through parent->***() in
iso_chan_del().

Fix it the same way the connected (non-BIS) path was fixed in commit
0d255e63fcf3 ("Bluetooth: ISO: hold sk properly in iso_conn_ready"):
after taking the socket lock, re-check that the parent is still a
listening, alive socket, and bail out otherwise.

Fixes: ccf74f2390d60 ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
Changes in v3:
- Move the changelog below the "---" separator so it is not part
  of the commit message
- Shorten the comment in iso_conn_ready()

Changes in v2:
- Fix GitLint B3: replace hard tabs with spaces in the commit
  message code snippet (no functional change)

 net/bluetooth/iso.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index aa2ce78f56a2..069fc87a4e18 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2277,6 +2277,14 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		lock_sock(parent);
 
+		/* The listener may have been closed concurrently. */
+		if (parent->sk_state != BT_LISTEN ||
+		    (parent, SOCK_ZAPPED)) {
+			release_sock_flagsock(parent);
+			sock_put(parent);
+			return;
+		}
+
 		sk = iso_sock_alloc(sock_net(parent), NULL,
 				    BTPROTO_ISO, GFP_ATOMIC, 0);
 		if (!sk) {

