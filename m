Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC63451CE;
	Wed, 19 Aug 2026 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787101094; cv=none; b=inQ9mrqXLW5V7tVg9aDDS2UG2Qt9SbcZtcxJLODiaXafWtFLAr374JupClvReEU1LfkSTjNi/ZjdlZqLPzFBRmgPPGrKOrslVLbkq26sT15Rzof0KfroEJrKl7OjZRaH4q9G89mxjvovTmNuZTYmSjGl+D6AZ6MbWA2NknJXy+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787101094; c=relaxed/simple;
	bh=ebUXmnGFTBSijWzdACq9aFr45JaHkhkErf1JqEeyTvY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=o6PX+Pp19tEQZCoPIBwHUT91dgBr/eSxlMHHSZKqk1RC0HGubWAXA28sTeuIap1YMlikkKJLES0qEk33z22pm1M2l24Z8y68pzWLtKxrYt10FmglFgubzj7dJzfOrl4ub185kA0gGKOrraWTOwTrfVBxUGU3DenNBoP9TCD4USM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=P+F0ABSB; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="P+F0ABSB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787101082; bh=h0xhGgxmaksgU9iTe0eHoOyreEjcKYIKVhUfYpFtBEA=;
	h=From:To:Cc:Subject:Date;
	b=P+F0ABSB7A0MTjk2nIhVWvR4i0bF1kGzlJyY8xxNo+oc1pRz4P27dA5l0VPBuX7zT
	 SsoqaTR9VPbYRLLigT5yliJoW0tIaQX4BNLioxGGBkjZTTiuFJZzX7sHQDeL79PsI/
	 5tyPYoLVcfPlowKemuP8/PUp7dWlbehOgMIfvqTM=
Received: from localhost.localdomain ([240e:452:dd3e:da0d:2843:5e13:c9bb:75e])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E7B206FC; Wed, 19 Aug 2026 08:57:59 +0800
X-QQ-mid: xmsmtpt1787101079t3ipjs6iw
Message-ID: <tencent_FFECEB355DB76CFDA2C0FE89B8E509028905@qq.com>
X-QQ-XMAILINFO: MOnz+xTS1+9iDxzgviyZ/dUFaBr/EP4qZsf6GZ3PkUvFVVbdyzJxd1T+0BP5kU
	 Pqn2HJnQZ8bhYFHNxzM4LQGeZ3cD9OeeJSHQGTi09wTeDhxYa+jMt+HwIv4yc+cAvrnIErtPj1z3
	 faf9OheNNbc0JIYVjgq26/drpKTrG19jPKmm2UlCdyZkbJMUHMfs0WFzbtCx4WrNI/nuaCHuaYkv
	 Fa5QM6HAWGIhBfPvNfjNqQmvuWSjE7TmeuZay8p49avSGrjDXx9oaY9lsVsZRyAN5a3WzBxwSPK1
	 tb0B/kLiv5Lxc3qujJLLV295HVjVdKVY1mq/uzPD8kQCMWZr0697HEztZmc9+D1YRzRxOO7W2QfI
	 SGuRJEhH2DAOPIDTlaRU8dCuM7/HNBtdnH4M0AvnRC2kDgUxnoMVwizThRwCIDW6BFh2vXqfkhxc
	 U3OpMeN2SIHeKWBnIO5iA2deJ/HM0W9Us17kdhQe5wajfuLQLy6WkTI7UQokBn2RR/EdHJ/aXlxE
	 P9aos+MHwaOniRJgeD4/mG8IqxLr2aoKXADetEQTIPuPL03IwstK8RrRiFn+QrekNkcQwPCHE9bA
	 Up+sx9ibnxjMuVI5ze5vXzDBnwEGsCBU8ZjuhkqyJXJWyivkXi78As2NbVl37VMAxRTXa+Dedx4U
	 j7PNdMYHf1KnF/Dzd4zvHQXXy9nHDQ5WKXkLShDDznzUPyQPoW3Rpdr2lw9LZMM/6T3xQ5Zk8CS3
	 gQ/vT8eNKIM5a6xlQI3mV4rPWSO9Q/DTITgpViYr1HONAgTAf3x+NhaIDWgaw9yJlNX4oytNNS1I
	 ErxiyMVYRLVmy6cY0t4ydPrkGvQDkJRnrhioJnLAACH32qbqPAlprBjREx7Y7Cq20/Q7iuY6fNL0
	 up0SHRfQGzurRdBoS//GWTOPhKwMyzuJJPGLL/XfDjVV99N5ttt8qhz5kfA6zLNWPmh5J+PTMTWP
	 9tX0so6H2WrB4vRhKlUdyXjWmHrNzWadqBJeh+6XleW69SlfuMU8KqbtpvvJeQjTv2lTpSx2AyiG
	 RNS7rDa9xD41Yvne+x07E5XuQ16IYr4fAAN5cIYTnpg70O2iYrtvzzLuKDdR9bPIj7LyHLGfodI+
	 Ii5NEf+XO0H7DbzdHG+lUHYDHD9CK4FVXb3aZKtLWqhEEa6Fw=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	pav@iki.fi
Subject: [PATCH v4] Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
Date: Wed, 19 Aug 2026 08:57:58 +0800
X-OQ-MSGID: <20260819005758.10248-1-2122295973@qq.com>
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
Changes in v4:
- Fix two compile errors reported by bluez.test.bot CI:
  add missing sock_flag() name in the second condition, and use
  release_sock() instead of the misspelled release_sock_flagsock()

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
+		    sock_flag(parent, SOCK_ZAPPED)) {
+			release_sock(parent);
+			sock_put(parent);
+			return;
+		}
+
 		sk = iso_sock_alloc(sock_net(parent), NULL,
 				    BTPROTO_ISO, GFP_ATOMIC, 0);
 		if (!sk) {

