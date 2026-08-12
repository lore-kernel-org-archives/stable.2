Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7053655CD
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529806; cv=none; b=AI90+BuMUzBRjfSX9srrOOv185pwOZqq7It+wCZQO+TXARyUElG7IurXiTEm7KodDG0UCnRCuYb3ArO2V65E1lq4TYhO3ncJKXeecRNFTR7s32kbVvyXo4Q28F/0d1dKdthrotXq4t9dJgHx9ips45rc60yZlPeadonB9wfg8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529806; c=relaxed/simple;
	bh=N7d/9wuUmihrv9w+zc1GQy2IaZY858kWO5/XD+OGZuw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=fxJe2nVZfj2U4XbTuUkDDeFzrtSQcy9tqxn2hXsEVSqU1pArSkHiI+C5Gsly2SBDATT298bg4CnqVIPqkdPDE/0w0rSgpSsoEKf2S+XGmHTe6D9F/Mg4UWcW/qdZoCOspCesCRwgW5PFe2v2hjQIb0TMVT6eGZbUL4qK3LfQJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tp0OvTVQ; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tp0OvTVQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786529795; bh=/tS10aQxeyxKkgsl3wbV3VyKeGBIt+GKdcSpgGPln7g=;
	h=From:To:Cc:Subject:Date;
	b=tp0OvTVQWHuzDcJDWsgVw5XPSHPerLivvSEwT0lww/Mv5vHUM7rn/r7f66O4CzvUq
	 MMaTur4Zh/H79WrHVB0QpoQHT6nAR0kfQ4z0SnMD9jqE1dW3PLI6mSCHemXQqvqf1f
	 gPLFNci4WY2GIFJWmyEzCqnGx4RpknGaa6Mc6S/M=
Received: from localhost.localdomain ([240e:452:ddba:7caa:44f2:d3f7:942:3f36])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 3D8364E3; Wed, 12 Aug 2026 18:15:24 +0800
X-QQ-mid: xmsmtpt1786529724tji9urc7l
Message-ID: <tencent_D2D387CAA22E84EDB589ED9E7A901ABE7609@qq.com>
X-QQ-XMAILINFO: MoX/Tpn4vKqQzi+KgrFuGuvtUlj6/XthmMIaC0/DVEbEF50n2uVRjyNaEVizxX
	 hgmk65S74gwvOuxrYE/PzNMS9M0235WSQxMFGRV+MAL00vB+da9cSD1ybps2Zka98ady13x3X5ho
	 UCL7gvH5f+28rAmB+WxgbBkeopFT1RJQCFUuDdElb+eu7gY8QyvMHFoof+Rbk6OvfKkRzcaThkmP
	 nFaE3DoAkOXEbvQx8Hm73tmbWiAtT8HGjVYYS9lwH5WtvkdknC/P4UcbHvJ8VLbphUhfGw0EDcds
	 kktEFcDC9fs5FGQ98XiEcyzQ98DPHsEwjSJq7GU06wVJDggYp3ew8vtTlWlhvcWN/oDrVmTt2IkA
	 hO5XJpZ9JJQtqH+Kfphm2LDiok4jhgItGJpUipg9EsiATcClNgZSp37V3OySsb1HTqakeM/BlXnC
	 1goeeNBQCe5q7sSFLRFEvo9zwpcntEXw6MZEs0/O05n96NNifA5P5eUEJqIsIptn0WmKC5QXHVGS
	 B7ZruBmzMpA8fgbYSi8mXl292CHkataCitG+LSGVOX8jlAPZgKpXMEQsks6MrmZKSmC32DtrPWQo
	 J/bqffoktZsQqqqmMFO5uppQ+BIMeo+8xPGU1jLa/rchWYPRvFy6GR1LGfv1ncAvURIa3bWsx+Pp
	 4i3PxTKIi1WStOY5fOZ4GsEwWGhehxegq6unfs76ZID+E66UJvdutpxy7ky1RG+DQkJxTrL8IOZd
	 AUrtqKwxrxlBv4Vhqe1bERDe5VCFlJPPQBKS4UIBYSNw5YSfwNIjyYgrW0rGhY53EglxPTIf9ZOO
	 1CMDjrSwMy6MPM6dJFTh93F3lXUxh2hyLMSYtOKZ6kXlr2Av0Suu6bbLBADawads8oimjFFRBw+L
	 73pzgm2naN0r0JEYMhur+R3SaohWI7b9vIeASSSj+Ev66OCQbkFSc5KDolWIx4d+iKL6ntFXJlGq
	 oWv6PRTWamjw50EwRWlNSvk8h1ylBrzjmQDf1RET8TLqj8oG/1dBbV2+3Nc2vR3vz37R5U5Bq+yp
	 4ELnwSeeJpX+hX0MhuuKIY2YhLLCzS69MUPfNZ/MN2DUiE4nxOZj4TYrQZXPs=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hang Nan <2122295973@qq.com>
To: 2122295973@qq.com
Cc: stable@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
Date: Wed, 12 Aug 2026 18:15:23 +0800
X-OQ-MSGID: <20260812101523.51423-1-2122295973@qq.com>
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

