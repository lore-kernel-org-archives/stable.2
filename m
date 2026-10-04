Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DDD3A6418
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131107; cv=none; b=O3r5NEd2JMPAyHOOUic4qogY7kyko3mWkK+5sTcgfpCxHG+glvCcK5GUzLI85N6R1e56r7y8X9mjN4LdnHMRYy7eoWuxJx3Kl46B5YBhH//k3e/9n2iZ5U2mKDv1A72WoE+iSzCgwQqBj49V+KMQhOIOQFrwunK6fPBkXtmQPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131107; c=relaxed/simple;
	bh=amhdPcPVOEFGlnnPFkrNr+qt4Al5SBeKg0Q5MTjsFPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oou0thvk+ZuYEgI0gongN34D/W6exlL18M/XzOC+3tpmr0GbaSmsvXdSXOwYQYeW0oG3EcQuZfZ52gKfMAI9dUhrqPo5aQEDvydHWc3nb8nuE3EcxuAJ+iZ5WyAsaJtGtiUMlEfelhMpxvD09PTu+tp7kbOMJDmrn9lg7jLThlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qww9ZAsA; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qww9ZAsA"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144fa6e60bcso36904c88.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791131104; x=1791735904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1DqokxhodHH+LTo4EGPMt3+JXECLQQIzLpVVw3j5Xi8=;
        b=Qww9ZAsAjDXbB81tv8XsmBmoDH7NxWsRQUiEcxzIKbgId+PniAqpEESp4oUNohNIx2
         OejCFoNal557NabtEO+G5/SZNj774ALh7yp8dQYivhAqIRDmEpsUQ57wU05Q/7GRH6sl
         d9lAhCN149rflPjgZi5EqaBQl5WBpwvh8vOkeukfY5rPnipSh3kKeIhiHpAO+dEiJHzI
         UIpq9DjRsmkaQDeSScrrBh2qTySAPi34BbK+c02ZwyrKd+DZGOmEwbkZM5p/C91nCCUb
         GAeXw9yBsY8DzGeXtVD8t2Syz+lySRSzwTx0VxL51G8+UjQ00YGCr/FsV2xA+SBx7lo/
         74rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791131104; x=1791735904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DqokxhodHH+LTo4EGPMt3+JXECLQQIzLpVVw3j5Xi8=;
        b=JV1gi6AVqJQ7cc47/fgyfb0u0EiWxZWd7JtUUcZe19A/4G5WzCA3tJvE+Vw0oslCwL
         +PIdcih5ZCznGc0eH/fTQQbomny6V4tHVQLbfXqg/eAabBLUGOv6KBOYlFCocPors+Wh
         9NhAebJNlv3LJJpdc9X7iggkJdBYGLJkG3eOgJXqbtWI8my6Tohqm28TOMhm5Pypwe9O
         ry1jPlU7js1OQL9m2eaBm0zXq8ERtvtMbQH8iSJ4n940kRCs486FqXKqzVabK9vY8/VG
         kxSVUKrBBSLxEUCbZNvgJU8SoQYD4xycPbzoBY+7aWwkuRB4E0w4mX+bCA5akqckrCzO
         xEWA==
X-Forwarded-Encrypted: i=1; AKwUvBwccd/du3VTc8AakBN7gpj604NtUzJ/sRk3Qggf4q3NYvcJhscL0hR2pTgshvjwsGu68K/an30=@vger.kernel.org
X-Gm-Message-State: AFuF++lErtzLTkNF6CKmLfExYr05kk9iQt+25kgHBmweLGLdzy4U/sPS
	mV6jscXTKW4OwoxevI9/bbUe0kR9oyNPnFAryD2fPh/OufimI3Z9Les1
X-Gm-Gg: AYBFou1EgnBNUiYsWuS20UNJ4KW8P/N7HtDuvtCT459u07ESgm6mVhiZhgMMeO0wRhd
	aR/Ovo+iA//AuFSWBiJYaFTZnI7Ubc5PL46YLdwSwaQWYC5Z9JBXo5lZK/70r/cBi4W4jT3lSNG
	pYKX7lEKvd3dT06pVQqYCi7osOohlhqL/edVfsaPazyPeiFIP8nYuxladvCPXPKYkG4s2nQWUPj
	ZpKz7ldpgGABX7PoZD7H0uxb2Ek40Pf5yBQZMAZQDE+hz0899MUhxHf61xCHNbhaVuT+jAADUvp
	cp8p4/rAAFkxQW/2xX/wrj4YP1BDD5fUvoxZ/lHHm4AhKv/js7H61kpHedle9cBf5b8BgimqiLI
	YtQdDujDCDHu0LExYC0ZzkzI2iqB4AYR3wj2i+nXx9Hpn+oxK7kBHqtDzZq8G8m0HFJkGbBnrgr
	cuzjwi1xVLui+XtlsGiWK96sg8iZ7bnzJdHkbYAMe8AcTWSR6Z0lDsxNQ3tQFY2FkfQ/1Febw7n
	+OJNm3Nw79W0d+llQGIKMwM/6xpf/D3r0AS3M6BR8j/aPzmgUKAU+cRnEjLTIoAcn0ewQ==
X-Received: by 2002:a05:701b:424d:20b0:146:ffa9:2117 with SMTP id a92af1059eb24-14f5aa4188fmr17146860c88.1.1791131103773;
        Sun, 04 Oct 2026 09:25:03 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc872e43sm14904474c88.7.2026.10.04.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:25:03 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Serialize concurrent connect calls
Date: Mon,  5 Oct 2026 00:24:58 +0800
Message-ID: <20261004162458.3968546-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_sock_connect() checks the socket state before taking the socket lock
and drops the lock again before setting up a connection. Two callers can
both pass the admission check while the socket is open or bound.

Caller A can copy its destination for route selection, then caller B can
replace the socket destination before A binds or connects the CIS. A
then uses B's destination with the route selected for its own request.
B can also proceed after A attaches a connection and sets BT_CONNECT.
For deferred BIS setup, B can bind a second BIS and overwrite
iso_pi(sk)->conn, leaving the first connection's reference and conn->sk
back-pointer stranded. Concurrent CIS connects can likewise replace the
socket's connection. Later teardown only detaches the current connection,
so a callback on the old connection can race with socket release and
access a freed socket.

KASAN reported:

  BUG: KASAN: slab-use-after-free in iso_sock_hold+0xf7/0x1b0
  Call Trace:
   iso_sock_hold+0xf7/0x1b0
   iso_conn_del+0x7b/0x1d0
   iso_connect_cfm+0x186/0x16a0
   hci_conn_failed+0x154/0x280
   hci_abort_conn_sync+0x3dc/0x7d0
   hci_cmd_sync_work+0x173/0x300

  Allocated by task 121:
   sk_alloc+0x2b/0x6d0
   bt_sock_alloc+0x29/0x370
   iso_sock_alloc.constprop.0+0x19/0x300
   iso_sock_create+0x94/0x100

  Freed by task 121:
   kfree+0x121/0x3c0
   __sk_destruct+0x42b/0x540
   iso_sock_release+0x29d/0x340
   __sock_release+0xa1/0x260

Check admission under the socket lock and mark the connect operation in
progress before publishing its destination. Keep that flag set across
route lookup and connection setup, rejecting another connect with
-EBADFD before it can change the destination or attach a connection.
Clear the flag after either helper returns, including on failure, so a
failed setup can be retried.

A separate flag is needed because the socket lock must be released before
acquiring the HCI device lock, while BT_CONNECT requires an attached
connection. Keep the existing state transitions and the deferred CIS
completion through iso_sock_recvmsg().

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6 Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/iso.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7657c2a0abbf..8113367c796e 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -61,6 +61,7 @@ enum {
 	BT_SK_BIG_SYNC,
 	BT_SK_PA_SYNC,
 	BT_SK_KILLED,
+	BT_SK_CONNECTING,
 };
 
 struct iso_pinfo {
@@ -1269,17 +1270,26 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
-		return -EBADFD;
+	lock_sock(sk);
 
-	if (sk->sk_type != SOCK_SEQPACKET)
-		return -EINVAL;
+	if ((sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) ||
+	    test_bit(BT_SK_CONNECTING, &iso_pi(sk)->flags)) {
+		err = -EBADFD;
+		goto done;
+	}
+
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
+	}
 
 	/* Check if the address type is of LE type */
-	if (!bdaddr_type_is_le(sa->iso_bdaddr_type))
-		return -EINVAL;
+	if (!bdaddr_type_is_le(sa->iso_bdaddr_type)) {
+		err = -EINVAL;
+		goto done;
+	}
 
-	lock_sock(sk);
+	set_bit(BT_SK_CONNECTING, &iso_pi(sk)->flags);
 
 	bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
 	iso_pi(sk)->dst_type = sa->iso_bdaddr_type;
@@ -1291,16 +1301,18 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	else
 		err = iso_connect_bis(sk);
 
-	if (err)
-		return err;
-
 	lock_sock(sk);
 
+	clear_bit(BT_SK_CONNECTING, &iso_pi(sk)->flags);
+	if (err)
+		goto done;
+
 	if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		err = bt_sock_wait_state(sk, BT_CONNECTED,
 					 sock_sndtimeo(sk, flags & O_NONBLOCK));
 	}
 
+done:
 	release_sock(sk);
 	return err;
 }
-- 
2.43.0

