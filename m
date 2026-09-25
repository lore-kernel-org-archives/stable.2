Received: from mail-vs2-f33.google.com (mail-vs2-f33.google.com [74.125.227.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3647884C
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377279; cv=none; b=KpyaK/ObgPpxw65vjzxWxVvcVwilI+Q9hM3nMj8OicomENAlttAjs0/HH5vu1TCMMU2+WUe7sicgpH0B0Ox9V8RBri0fVqXZixRRzR8EpVf3l7t5SQY4EobqoxlAf2HafQuq/+WrFUlXqiqnlFtcjxajh/CpvpfJ5I1RPcrG2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377279; c=relaxed/simple;
	bh=RIy0KwrUMk7zzmVivVsxjnA+TSbk0UjyCIxON/nNzEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u67mJeBN/DFHYq9N4bSBWETZID9gbSVorAx1RyiKQVdUaAA8igEl3UxDtqX9SAshRskgUryiSHa/++iBG8q17Bqwx6YLHtp1yk6ONubECf93/7imWYDZs3ola4K1QRXsAPUek9foiLuKq6xA9BdhDMf6U3cD8ZA5gR78ZhlPqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDdiCCmm; arc=none smtp.client-ip=74.125.227.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDdiCCmm"
Received: by mail-vs2-f33.google.com with SMTP id 71dfb90a1353d-5caec6d2983so1202759e0c.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790377276; x=1790982076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sFJAWMbuQDMPuL+kmFa3AtrXjztcOUowTHzkHn+U0Q=;
        b=RDdiCCmmP9368Ksm25aNT4BBNOW63kRQvbZP8B6Y9hX1wnQ/zQN1KbB0WIhHGOd0KS
         aAQk60zzXjKRqzFxTwyFsSwO1ykma6Lv/kXea++bKDLf31NVO56zSyBe5qYiUcvQlfDV
         U2dbuwy5YxcTxrMLWgLF5YaxPq41iZaeL09f1jaGsa70LUcexvGR61LGNTDuyo2UuNTm
         DxrQN0WLO0LOlsJ/hEOF+RFkNgamIasek1DSKZmp5mOENgGJR4/YGK54msmPNtHmqIlU
         OttAEKwnv15xSfKcpsQICBECimA7CTpT2OzDjoi4z8RWHWWA1TYn522z4QuokiJzhpdb
         dW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377276; x=1790982076;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/sFJAWMbuQDMPuL+kmFa3AtrXjztcOUowTHzkHn+U0Q=;
        b=BLQBb4QbNIf/SUnGj6sTO0M8/4hZwlTD+oHBTLwemOsgnFMUCBCQ6/y4gl8Du44yZM
         mE0SGhdY+6Bh4ySNTuYIirDZjQAqP1ken34w7Bm4e5+U+T3iFQtE3mMNhP8xJWTsJqh6
         K67pr9rqcWdO0AG8lqgACTW95e9y6Ww/XruttNcOZJvIYPnc0Zg4w0AROlZCAj+jWLnN
         bddVHcZ6fLBZW9Fy4ng+5mEbmeYd3ZZ0u2VBkzyDeg62l1yehrILE+Iy+/tS+dzTHfR8
         M11dsTuxwmpiNFsH38Z9NQlotlfRKl0H0jzWmEtRnMWTGMt6wujLXPy1p42x+FG2gbHi
         KrMg==
X-Forwarded-Encrypted: i=1; AKwUvByrngIoo8AvI4oIdcMRr4eRTV6ErL/ZatKzz/jdcBGl2MRLkDO+/adUmOcHF0CJDj//9Oy52v8=@vger.kernel.org
X-Gm-Message-State: AFuF++m3DviYva8bteT8GGpLsLMcjvsVCaZdn5aJrBIGnERXVHI6/C56
	n/PGBwolBurwRPGzlFSU4EVhvYWT+vHc5eNZ/pgwvEgfN/KG8c6vi956
X-Gm-Gg: AYBFou1D+f9gZKgsYUVQPH5htc5YbI6NpLQPI0w8DBHqzvgwu/A0Zoonra1pIUi16rx
	uivMK7wlS2yhjHMYTeMdadrC/q6J2QaywJ76QrSbVPtxiK9vOKrhlyOx2/304BNnL6TP+9e8PrP
	NM+jywq6kpSmCJf0YHYNFFF2Iln3x7EYypnJLylKZ6ppTYItMawDRiMw4tbbkaYD1DwQMxRn2B3
	o8nR5aO/Ixxy1C+sTW36a34fWMwjAMhPgU3ughmMJ4Nqc+nc4kaxD7uYZHGdbTnu3eAjd+zCC3p
	z29i4bcXhL8yfrX1vLzVVN4CN8fw+kCIrOjR+mjLCu8gp/8Loc2N+H7BNGTFaiWEPO4b2nOMTJk
	FR2AczasJXxFxm8vT1JgVjmiZU/9HDcEW4p6Idxq6i8Fvgc883jhCSVsla6TBGxGCRgzA21k0WN
	BAo/88m/5tWI7aa7UCak+yBLeKBxFZUg5Q2diig5SINlPuhydMbc6rU83mUqkO4NR2qj9RF1Yyv
	jn+J5wDV467mcy8xamlyoWd7nJS14lLNekGTR68JSUMM3UOs/RHo4Qa
X-Received: by 2002:a05:6122:310f:b0:5bf:8c77:e89a with SMTP id 71dfb90a1353d-5cb09217797mr4032734e0c.2.1790377276151;
        Fri, 25 Sep 2026 16:01:16 -0700 (PDT)
Received: from daniel-l440.tail54b8a9.ts.net (host179.190-30-68.telecom.net.ar. [190.30.68.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde02784b7sm562190e0c.0.2026.09.25.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:01:15 -0700 (PDT)
From: Daniel Salmun <salmundani@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>,
	Daniel Salmun <salmundani@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: synaptics - limit the T440p InterTouch quirk to LEN0036
Date: Fri, 25 Sep 2026 20:00:31 -0300
Message-ID: <20260925230039.236786-1-salmundani@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 26eb3d92c7a4 ("Input: synaptics - disable InterTouch on ThinkPad
T440p (board id 2722)") disables InterTouch for every touchpad with
board id 2722. The ThinkPad L440 (LEN2004) uses the same board id:

  psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xd001a3/0x940300/0x127c00/0x0, board id: 2722, fw id: 1484859

so it is switched to PS/2 as well, although it does not have the boot
problem that commit works around. On the L440 the SMBus adapter is
registered after psmouse probes, so the first attempt returns -EAGAIN
and the adapter notifier completes the switch about two seconds later.
It did so on all 7 boots in my logs:

  psmouse serio1: synaptics: SMbus companion is not ready yet
  psmouse serio1: synaptics: Trying to set up SMBus access
  rmi4_smbus 0-002c: registering SMbus-connected sensor

Match PNP ID LEN0036 as well, as the earlier versions of that patch
did, so that only the T440p is affected.

Disabling InterTouch on the L440 was proposed before and not merged
[1]. In PS/2 mode this touchpad reports two tracked contacts and no
contact size, orientation or palm tool type, which it does over SMBus.

[1] https://lore.kernel.org/linux-input/20230414092353.v2.1.Ieb687047a5b75c7b7ee5dd258207ef5ca9a3b728@changeid/

Fixes: 26eb3d92c7a4 ("Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daniel Salmun <salmundani@gmail.com>
---
Raphaël, your earlier versions matched LEN0036 as well. Was dropping
it in the V2 RESEND intentional, e.g. because some T440p units report
a different PNP ID?

26eb3d92c7a4 is queued for 6.18.54 and 7.2.8, so without this the L440
drops to PS/2 on those stable kernels too.

Build-tested on top of for-linus. The L440 logs above are from 6.18.48,
which does not have 26eb3d92c7a4.

 drivers/input/mouse/synaptics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a8ce89d41..6bc14c07a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1840,7 +1840,9 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
 		}
 
 		/* Disable intertouch on known-broken board revisions */
-		if (info->board_id == 2722) {
+		if (psmouse_matches_pnp_id(psmouse,
+				(const char * const []){"LEN0036", NULL}) &&
+		    info->board_id == 2722) {
 			psmouse_info(psmouse,
 				     "Disabling intertouch for board id %u\n",
 				     info->board_id);

base-commit: 309731e95917125bbd13626a7a5600490a5bf44f
-- 
2.55.0

