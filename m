Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CE34B697
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477004; cv=none; b=ei96k0Yerr2bmEMQQLcLx6DAhP1OQnIcNx30gCLA/rukJBA0fWvHgcYkeknSroZoPwEVCY8EgHXfnBMMTwwhM8TYhAMPRIsVggE2s6s25rnWCQ3kwC5FLE1zeUgAhg6c/jQwThV5Is9t5XTvQMrSeWRcQRoUcywkod+wcFqY4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477004; c=relaxed/simple;
	bh=u+nD+ppcmkGvSwsqARVDMuWhSCeO3Xb0BbZCEpSTc/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTDuE/ye+FMJnTd2SsBisU8YxAfTK/kaS0takTC1jg2lwOBTwWpDrzsxS4gNVKsLmlbHeQNUulwWkKF+o2UFO539567OT4LoFz79q6InJNsXnW3bI+4ff0H2gqddjT/4Xv6uNmHri/gpFZmuRcrRtEXxw05+dOUSm25adXJ0oyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQqdWI2k; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQqdWI2k"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7a269ca1so20480905ad.3
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477002; x=1785081802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GhZkSvga/r+hHGYJZyAEE9P2eaz6oeqktfsL1oAQxtg=;
        b=TQqdWI2kXJQJlGOIeONzS3eJ/CGCdqaCxRXwu4mco4kgBDOt39Jx80q5xJH0VNqaRm
         ZNv0pdYBIi+ZzABixhBzbAna1jqxY8jGDXNMIFlKlb89lfVk+1FCTvNGzB5KeYuo1+zq
         ziERSncY4AJtFQ0UX/UNkJuFjqn+qYywvzMgCMxRlcpek7sUM8b44DT1RQWz2LviZ5zD
         21WrEXHj0oAnO+dxaFVU0KYbnJFuyL8qdMa0HP55cofNpVi6SatUVhRg8cWWPIJ5R9EF
         cPCCQIeqw4vQ8U8Rfw2Epr3ofF9Y3yVugf6uXXkCGOHJaK9lvw4F+fZ98Tc3T/qxxpfN
         s+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477002; x=1785081802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GhZkSvga/r+hHGYJZyAEE9P2eaz6oeqktfsL1oAQxtg=;
        b=PO3YIdjYsvq9IxzC9CiVtYpfpGBo3tUOc1iU5GOkXJ4DLhCly0OvCOocLkXPDi11vK
         Ct6JRVCfcJPlXmT11diegoNh9I6PQQIPGOP50m2OzQaBCfQqAxCpQJBHgJ9pNGsMj8H6
         tK1/WDEd1O/A8i4Q070+AZPX/K5HgiZ0GwgDXDMNQDtrMaVBSu89P9p/smclURAjJU+7
         0nztZuEeqCTQ2GkdOn021DatEvAkv6dd+J14UH8zWcUEbqxZ+wjrJmagURHwff46kXQG
         Cm8eSV2Cq6GfJk9EXGiEHqrJnun88c79lvX7vDDceNRt+WxHHwVOB+P3YqBMRvQZvdm3
         /ssQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTfyZWR0o6QIuImfaGWA8vJeVv+G5REJC9R5f+hkBDPkikGgrMIWxQk9jQEusttgTBzDOg1Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc0yuD08xmRshvexifWG1whPdU6Amx/NNiGfnZb1W26Fpd5vp5
	+EfPXg6benIKYCl0OhEUbB0M29Qwvpck7xJn/rgXwdwSWaAzjc9Wx3Pk
X-Gm-Gg: AfdE7clswpMj+S6w4q+s87iwiFjU7RFdHU51gLGwD8/FiHGG6fDCO1tA5rLn09fwXGu
	3y38tBzz8c8CxpFsT7+2yU/Jpk1TMx5Zs8Rpdi5eAHVt961fmJjDFF5AKSljfJsqMz2ErrAUtjZ
	KZNdT4t5hZsF0VPzmPQ6mDeVO+WYEJ/onwUsynVrGy5QD8+C6DfqyjDXGhWWAvsTURbRKoHPVoX
	aglLL3WMcp3yuf17OvHWs5ZO19VIYMTql5khasYN7czsUJJl24LAD+cctnnwTN431yXx/BwQPuX
	/gTeu5MLdGLFkOFL5YzxW66nrldAkMUBU1FjXihuzoNFWUkSuPfPWE84g7TQlltPnD0zR5ua4j1
	iEAF99JbqmT6NTucdNIH6F80/x7NgnVhourqNGJiQqr8Sx8s9/At5SYJ9RZim8Hkhrhd616Zw9w
	yibxWqASeP1gaFnl5EnVc9SQRbPTC1pxjua6zmSnH1tUFZVtSn
X-Received: by 2002:a17:902:e549:b0:2ca:de3:15eb with SMTP id d9443c01a7336-2cf346316a0mr100841435ad.0.1784477002283;
        Sun, 19 Jul 2026 09:03:22 -0700 (PDT)
Received: from localhost.localdomain ([14.218.106.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448db72sm42571615ad.1.2026.07.19.09.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:03:20 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	SeungJu Cheon <suunj1331@gmail.com>,
	Chengfeng <dg573847474@gmail.com>,
	Tim Bird <tim.bird@sony.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	"J. Suter" <jsuter@hardwave.de>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: Fix session UAF in set_termios
Date: Mon, 20 Jul 2026 00:03:11 +0800
Message-ID: <20260719160311.2898053-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_tty_set_termios() tests dlc->session without rfcomm_mutex and
later passes the pointer to rfcomm_send_rpn(). The latter dereferences
both session->initiator and session->sock. Meanwhile, krfcommd can
unlink the DLC and free the session while holding rfcomm_mutex.

The race can proceed as follows:

  TTY ioctl task                 krfcommd
  --------------                 --------
  load dlc->session
  enter rfcomm_send_rpn()
                                 lock rfcomm_mutex
                                 clear dlc->session
                                 free session
                                 unlock rfcomm_mutex
  read session->initiator

KASAN reported:

  BUG: KASAN: slab-use-after-free in rfcomm_send_rpn+0x297/0x2a0
  Read of size 4 at addr ffff88810012a850 by task poc/92

  Call Trace:
   rfcomm_send_rpn+0x297/0x2a0
   rfcomm_tty_set_termios+0x50d/0x850
   tty_set_termios+0x596/0x950
   set_termios+0x46a/0x6e0
   tty_mode_ioctl+0x152/0xbd0
   tty_ioctl+0x915/0x1240
   __x64_sys_ioctl+0x134/0x1c0

  Allocated by task 92:
   rfcomm_session_add+0x9e/0x2e0
   rfcomm_dlc_open+0x8b1/0xe00
   rfcomm_dev_activate+0x85/0x1a0
   rfcomm_tty_open+0x90/0x280

  Freed by task 68:
   kfree+0x131/0x3c0
   rfcomm_session_del+0x119/0x180
   rfcomm_run+0x737/0x4710

Add rfcomm_dlc_send_rpn(), which holds rfcomm_mutex while it verifies
that the DLC is still attached and sends the RPN frame. Have the TTY
path use the helper and drop its unlocked session check. This keeps the
session valid through both the frame construction and socket send.

Fixes: 3a5e903c09ae ("[Bluetooth]: Implement RFCOMM remote port negotiation")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 include/net/bluetooth/rfcomm.h |  3 +++
 net/bluetooth/rfcomm/core.c    | 17 +++++++++++++++++
 net/bluetooth/rfcomm/tty.c     |  7 +++----
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index feb6b3ae5e69..102c278e3584 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -226,6 +226,9 @@ int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
 			u8 bit_rate, u8 data_bits, u8 stop_bits,
 			u8 parity, u8 flow_ctrl_settings,
 			u8 xon_char, u8 xoff_char, u16 param_mask);
+int rfcomm_dlc_send_rpn(struct rfcomm_dlc *d, u8 bit_rate, u8 data_bits,
+			u8 stop_bits, u8 parity, u8 flow_ctrl_settings,
+			u8 xon_char, u8 xoff_char, u16 param_mask);
 
 /* ---- RFCOMM DLCs (channels) ---- */
 struct rfcomm_dlc *rfcomm_dlc_alloc(gfp_t prio);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ebeae17b71d1..75f7512dec54 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1028,6 +1028,23 @@ int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
 	return rfcomm_send_frame(s, buf, ptr - buf);
 }
 
+int rfcomm_dlc_send_rpn(struct rfcomm_dlc *d, u8 bit_rate, u8 data_bits,
+			u8 stop_bits, u8 parity, u8 flow_ctrl_settings,
+			u8 xon_char, u8 xoff_char, u16 param_mask)
+{
+	int err = -ENOTCONN;
+
+	rfcomm_lock();
+	if (d->session)
+		err = rfcomm_send_rpn(d->session, 1, d->dlci, bit_rate,
+				      data_bits, stop_bits, parity,
+				      flow_ctrl_settings, xon_char, xoff_char,
+				      param_mask);
+	rfcomm_unlock();
+
+	return err;
+}
+
 static int rfcomm_send_rls(struct rfcomm_session *s, int cr, u8 dlci, u8 status)
 {
 	struct rfcomm_hdr *hdr;
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 4b9a699ec59b..b2c1060394e6 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -858,7 +858,7 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty,
 
 	BT_DBG("tty %p termios %p", tty, old);
 
-	if (!dev || !dev->dlc || !dev->dlc->session)
+	if (!dev || !dev->dlc)
 		return;
 
 	/* Handle turning off CRTSCTS */
@@ -979,9 +979,8 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty,
 	}
 
 	if (changes)
-		rfcomm_send_rpn(dev->dlc->session, 1, dev->dlc->dlci, baud,
-				data_bits, stop_bits, parity,
-				RFCOMM_RPN_FLOW_NONE, x_on, x_off, changes);
+		rfcomm_dlc_send_rpn(dev->dlc, baud, data_bits, stop_bits, parity,
+				    RFCOMM_RPN_FLOW_NONE, x_on, x_off, changes);
 }
 
 static void rfcomm_tty_throttle(struct tty_struct *tty)
-- 
2.43.0

