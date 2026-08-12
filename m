Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913553B9DB6;
	Wed, 12 Aug 2026 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529818; cv=none; b=FZjyX/x1938ZIANVeyotbXnvy+S0VZCXGppO2u6wSJElxYxhXPQ1T6lFp/1fAgMrXQAmfRw4pHgoIKsh1NXdePAmrbYgroj7ygzOOf1S8MhgJs9L5GksQCj2ZJb05sIvzWuRzwGcTaJR7bNofjiec6EvpLgTgnZtEuKJKf5PWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529818; c=relaxed/simple;
	bh=N7d/9wuUmihrv9w+zc1GQy2IaZY858kWO5/XD+OGZuw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=W4ZiwFz7q45wOPQeTYjxwckOEg4R1mAWr9gT6dCoJA7dAC3OCVnmuf793dJIXaNTK3uO6CZeurIYDU0gKXw915CqXmcifzejpTlnIS+KBA/g49O1Rq8NAVEXJgJ9ePe2yXW6V9dL9WAwFnVL0OT9Z5ElbXyIpwoU18DlcptUO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Gnv7mf50; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Gnv7mf50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786529807; bh=/tS10aQxeyxKkgsl3wbV3VyKeGBIt+GKdcSpgGPln7g=;
	h=From:To:Cc:Subject:Date;
	b=Gnv7mf50l7ChkTTDHtlADPPno/2ioSCcHLlN+dNkQVS59Zu2CgYad4pQhZJV+82Pm
	 unZewyQh4cZNb+9MRrqdSqXnQfkKtsUYlvlDe1+cu0xDr+741NP08sNl20s5kgQA4T
	 tLAhDv/CwVBuFMwfv8LKqtUybpopDr1ddymHTeyI=
Received: from localhost.localdomain ([240e:452:ddba:7caa:44f2:d3f7:942:3f36])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 3E3B3450; Wed, 12 Aug 2026 18:15:35 +0800
X-QQ-mid: xmsmtpt1786529735tb97ak7my
Message-ID: <tencent_C2311DA54CF022D59E9418EF890569EB2B05@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XUlf7pJ/6gPnrpZ/YnGCI8CNoQdANjxQcMi9QH0PMHziVc8UxFu
	 MrIb/Gk5ReQZlj85rEn9mMKfAQci6vggX6PINGTkFyE2xsXiPYg3uQW56p+hOdqX0Gju446LlnzJ
	 G4rgabEK/LLIudYf1tvIrBuBY/ZPxIY6xX88+fA8CULKVygdM9+qTXMJ0iB4/eYSxtyTx+1dBptb
	 zzpUhESGyg4u0/rCTyPG8sDPU7bgskLU8O4+ZrZ4RVHuyK1Xca4d3dfCQT0q0xIfFooifFg/+fy3
	 57CgjNFOvdy3lwYEzJ3QTpfcDwFNIeMNkgdj7cyfilALQk7B9/hRSbq6iRHTYs7f+ajyhtG2xpTe
	 XElxsuyQQ9BRx3i/AXte6Xgprp2XnvjofYwaN520AkviddtQhHdCmGLaT7xBVmIByP4/oCAhF8pm
	 mBviGJmoCN4HAHUhVWvcIDi1juR4sMUiLo1/y0dFfLhOMBxwhw1ZfvouEfrYDhMCYF+Ymp7Rqnee
	 SCoIMAgGoTtCJ92ayvJC6bBjhMPdtwVS5VvF+ex4qlqNCFGoqGm4okcOOPMxcyXGY5XCn2Pu0qDx
	 0cjltKN24dKpcJyGEatMY82/GqQBGPY9aCeOrtoCIY2w4xqjXme7wgM7qNXK7tj0LRZxAFOAZ98+
	 t0gPoLCUu9we22kVcazBYr4gQttDTfzGgv/LAJcr0CRh8nDd2eh0ejcSvkEurVDmu9fS9CLrRgUT
	 Jb6Y3CQ3Rw15TXBLkhZpN9mugnXKifVMpUu6QO2sjxDpsNpMJeG9V4k2nCPzCErWFpRQLvjvV6ut
	 WUA/9BNGsfYsLnU7ezcfrV00E5lY+gqrPeuZu+fnTOQ4enD11C54P1mkMiPRdFbq08/I/D/wpJVj
	 AqpubRcaW1KCNLgSDHDKkaKQ5/Ko9dXx4RcDXUPznzY9Lc5cW4cR6ScakbLRBhe8NM23G0kzsLFW
	 eHAS8Qmgi5o/afAXUfqrw6Y00qG09jbUsDisWBwENQaEJbOAwhFBhkb6b8EMkEI0lWpw9GYahKDb
	 dj2GVNlzScAO60oiU+YOcsvNZH6I3nbpsFGI2XE2ootELALHuGnz+PAxZItooEFyXjLRF5fylT4v
	 vNdorxhK3s7BPeS2Mib7bBBzrkTY0PrCCn9fU/BAEmggZ832g=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Hang Nan <2122295973@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
Date: Wed, 12 Aug 2026 18:15:34 +0800
X-OQ-MSGID: <20260812101534.51637-1-2122295973@qq.com>
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
pointer is also dereferenced through parent->sk_data_ready(parent) in
iso_chan_del().

Fix it the same way the connected (non-BIS) path was fixed in commit
0d255e63fcf3 ("Bluetooth: ISO: hold sk properly in iso_conn_ready"):
after taking the socket lock, re-check that the parent is still a
listening, alive socket, and bail out otherwise.

Fixes: ccf74f2390d60 ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/bluetooth/iso.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index aa2ce78f56a2..069fc87a4e18 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2277,6 +2277,21 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		lock_sock(parent);
 
+		/* The listener socket may have been closed concurrently
+		 * between iso_get_sock() and lock_sock(): the reference
+		 * taken by iso_get_sock() may be the last one, in which
+		 * case the socket is freed as soon as we drop it at the
+		 * end of this function.  Recheck that the parent is still
+		 * a valid, listening socket before creating a child
+		 * socket from it.
+		 */
+		if (parent->sk_state != BT_LISTEN ||
+		    sock_flag(parent, SOCK_ZAPPED)) {
+			release_sock(parent);
+			sock_put(parent);
+			return;
+		}
+
 		sk = iso_sock_alloc(sock_net(parent), NULL,
 				    BTPROTO_ISO, GFP_ATOMIC, 0);
 		if (!sk) {

