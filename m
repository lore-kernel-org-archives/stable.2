Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66437F314;
	Thu, 13 Aug 2026 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621169; cv=none; b=SDYcQMHCa5bPeGQF7W7ThgMiItcOjYqYsSdCd1pNE2SGlTsFO3l+ZEz94HdSbCW5lmkMRBzTVw1xbwTFM5jkmlxTg2t2AIITkCbJaqxz1ZE9U/qJS7zuscFRxvk/E0Oh+EjXen7adFBT0z5vouaKSK8H8kQP7XPc0UmY3FI1Rm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621169; c=relaxed/simple;
	bh=u2pv9J8nw47sNeMqVwPr4tJKoJalsZjJD+z9MD5GOFg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ffndHRenNExt0uHnV/AI9oOlgUwsHVPREsFl11V0iZn86AEsRss7G2R4yi5ZtDNN3PuMuOaJj0fcmjriHaQsglay0AH/J5kmNp7wUGGMfwX+N2B/M63+IGtNGectS7FZHPk1AOBONUeRmYY9Q3hXiopfqB68TzlJgxAdSztF9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Q1bWgZII; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Q1bWgZII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786621154; bh=VJ7rMVR58nGUE/0GwLtpRa0is1ObRAkjQvb9anXV1uU=;
	h=From:To:Cc:Subject:Date;
	b=Q1bWgZIIFuVDbqpfXocCs7sdvJuKddERiZ2TfFEXty2fokV0V2rM9nuPEIXGcPfaG
	 8m0RA4zS8FkmrKySOysL2BQD5NKmCZZ3S6C2YsUclWSAkzjGPaOljM1PJZwLs6ohkl
	 Yz+NI8Q7qzVfjyNrryx4q603LQbWPWxWBu/JgzCY=
Received: from localhost.localdomain ([240e:452:ddba:7caa:95a3:f534:cc57:beeb])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 9CA86CCE; Thu, 13 Aug 2026 19:39:10 +0800
X-QQ-mid: xmsmtpt1786621150trgldhnoo
Message-ID: <tencent_E5954D5C14D99713A73E3121B97EEDA6170A@qq.com>
X-QQ-XMAILINFO: NcAdPGlpF/v/diuJkawnO0kZuTQeM0/JygEL6jx4N/D+CgnVl6SOugeWAzJvxK
	 hO2830I77jRoi1KwQ18gx4BriTAfY83l4mP4Fgb5ys2VL9AQpEwlzErJq/IOJGTTX182Q2qbZh1X
	 YsEWUDLeziZqLes3dZ9fkiPU6uVXgKEiPwZX26rmnBcd9PWIE7YZclqknTKi/WzkqqRQyhfMCvQK
	 2arxyTU4+fgf0mdWsFj1mTKhtlGUN9PEYOiaqWZEWYnh9A59KsyDdf27Gt3UA59EE7qDODds17Vw
	 BabY8HY9FDwX1gxLT4QwRX1HlzkA1Ucbq9xMRKR2h0TCMcFBag4Ep9dKHbThndmbay2ePwnHbkkB
	 qTZ95iZl3rTkskeqyT/u0KwANNxeUi6O4KwL5RKQNbZ6T1/vPE57hZQNGJ2bdayPOOXCadl5UC5U
	 zKFS4KInEFKyFsT2rduqL2FefpcsQ20Wl5f32gNZcChfqyqkXTDwDFyCbLHIMYlAK0p0Y+qEcb90
	 hPetkzdf5JqZnDmTzn8mcHp2AAD6I9jkoLCnE2cgPhcHiTjoakOKCRFUZMgrn9Q9pZcmcC30H1gd
	 s+JFvEFar3qivtJrmqFHxmts2JgZctIqkfhc0wRPVwWAeq7klMhFhOcvHkLMU6jrLS2EI8htf9mf
	 8pQ2bRBN+XDwmvPXwHTmAC5D1tx5plUyDqXYXA/a/lhHrThlUKlCl/G+NLAxuk15SLPX/IAjwpdy
	 UOsB16qQJMIxmH8gHP+lPu0F8Pl1RPWMwd9Qwpub7emVeTGT13YPwBbd4MiCI8rKsoCpqmkmAkF2
	 oxdfBNw55AaCZkDc4d9RQjzy/Qx1gbPicfk3KcyjYanuz0gj4NcwIc3opmr4R7fGiP5F/sCuNksr
	 bsGEPYVqxYCl38jtwrVfh68+7RfCsKmWXn+kyJET/8Q4UNwQx6J7cwW7YivLdfuhJi131NtvbIGY
	 5coIM/m3dqxAmONAdL4oz2yD2MRvy/jvHaLmwpo2WOvtafEbGzhE2qHe67Jthytdn1U8WzdzvDW4
	 0JhE8kRDfwOaGN87+B8YPbY+jyzmjnnPIqpptJVMOTCqs05RfA1/wfJsRpkXm0MwK3ylv5ElzlbI
	 8PBpJWYOcLNCZnHECvEyg+PBMDRN4E2EB94s/KZ6az8Y9wfU4=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Hang Nan <2122295973@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
Date: Thu, 13 Aug 2026 19:39:09 +0800
X-OQ-MSGID: <20260813113910.72336-1-2122295973@qq.com>
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

Changes in v2:
- Fix GitLint B3: replace hard tabs with spaces in the commit message
  code snippet (no functional change)

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

