Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDE3242D4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083605; cv=none; b=pe0OHiuSaitLHG3zDXQHWChLF6jMSOtagosv+inlcWesdyvdjWd9bHL7uBAliuRb5S/xFIKDmGy1WaZUJ81dEgwg0LxvdVdtQ/1PPeZG5FZR6rXNUFMGN+Icfa9RqNuAhOj9aDgIY/2zmGqQGOSFjDCwPJEUOE/ZJu15BJRgE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083605; c=relaxed/simple;
	bh=y95DrYbP/VmjOSUNzUGbzSp38YYbp8UhXE/2Bv6rCrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXn6Sx1YgVasKip+ycrBI1gkvpdx40ZELan/oR5zYfpNYkkb8+u26mwJKytazF5kfvZAstT/G7NbMGzVgX0QPnXdS+yM04sSVRzbS9UAXnMbK+eLh3YZjlwN3BxRwFCE7d6kIBJ/xcks7sOezSzjIW30dS8nNaOWIsHC71kVfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpHGXfsl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpHGXfsl"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so57371285ad.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 19:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784083604; x=1784688404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IgrBcgsc/jMn8PcArbo69Rr9sOwNc88jPEb6vu9Je+A=;
        b=QpHGXfslb83Ccc2nR3Soo0LX+Pr5KmLbmE9LZwcfK4rWzMXNGWv4QoVcLKq3ZapsBO
         shlPznte5Sh6O4F/MMfN9hg5YBEKBIjLQ385vQG7RC+bGscRLdCXUyclOdpzpiiLEUDT
         OYQLcrpiHChxM18J/g3c1nFV/QJM/OF0fvT8wVEPJkGbFRTy5j2Vi3SCFLfijeAppcpa
         hfumkkE/SsCFfEgAVgxB490AYYJgabY5pwvNoCd2gmVAOQnev3EqCU2Duqcn09ouiT7r
         zrV+LczB41Rin5FMr7FhgqYihci7SYdSXQLS81QKltOwvO8GJoNMBY2JyamHobISe5n7
         DOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784083604; x=1784688404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IgrBcgsc/jMn8PcArbo69Rr9sOwNc88jPEb6vu9Je+A=;
        b=BrKoVGXqTm+UnzPBrt8ml/YXIDLG5IBsaZAhxaRDvnYy2tFubWQlMD4h/DYmrbLdeJ
         db+iYn5PFPq5YRJSrtla+TOqncdWcoMCGiOE675ZHS7UPCcvJSltitY8260o6bhkuJdr
         g/44gMLNWWCPNOKCuMIn/Kqxh3gVjeK65Uzg8+AuRczxAXbmv4rpSHdcpTaMxkoja034
         1SEsYJgeEpeTNi3AaveePtXQUz3wJhIpE/jOMeNmpzZPp5xaBkfK9wZxBJ+O+xNXpHsG
         K2cfu7LR3pvy8MSQ8cx5/nLfpw8fXyIvphM3Wkbmutf+3dCE3jemFsN2/U3ftfSriKqZ
         sYsQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+BTqRwe5t5yNPJCw+skAriLUyZpQlFCX4AnHZKZqrNOEbsmuDiDVhDUYJ2UUq3uIvMrrDBN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIda1VOjJ2qFOMl087maqjtVT00TUxt9N08LTzwn2zSl2HdjxR
	HhLm2rRLzDvPUMOD0gl3cbxmW2e2Laea+4KFImu2FymFx8BExyiQouIA
X-Gm-Gg: AfdE7cmPjBccIpeIpiaUnRqFplI9SJJgTC/nwuI3G2FzW7VSg4Gnqgf4vkdvCFcT8OI
	PtTH2aA4CAir4ycYvd235DIWbk/ZoqieUdGNZwXCpgxlZwHXnqOvDMrB5B9CfmLVtLO0niaveNw
	kTFhqPHMcUxQFf/+I0XGrIHKvxNTdWkNMfI0t5bPur6aMp5hZ1oVBtBkPTwdETALX7l+VtKnSEp
	o2QdQNDOFXwFbYFmXG/hQ+qn2hUUEoHre0C8JYq7Amk/ePBphN0lNghsfPv0N1sHiU4DVXl7ASM
	D+z5l1CXcG+JSQN3DAI6PFCfCgynUFUfeMk3/QYlwJvT6XZj7gQ2hsiDuQ3sU8dGP/ZSuRxRXUC
	lZ20PaPpqCsO8vx94PlHXVsFXuo5FwY8AIlaSP91f3wLxLFMYRZ40xQhoOJ7w8WCurL8DBP1E5x
	JDaEoJ7EqeN4Wjs2ijwPD+fw/pi8tJJujp1lg=
X-Received: by 2002:a17:902:e787:b0:2cc:7c36:2c23 with SMTP id d9443c01a7336-2cf03d6be8amr8405355ad.43.1784083603695;
        Tue, 14 Jul 2026 19:46:43 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1edb0sm124530935ad.53.2026.07.14.19.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 19:46:42 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] audit: fix potential integer overflow in audit_log_n_string()
Date: Wed, 15 Jul 2026 10:46:35 +0800
Message-ID: <20260715024635.25376-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

audit_log_n_string() computes new_len as "slen + 3" (enclosing quotes
plus the NUL terminator) and stores it into an int, while slen is a
size_t.  For a sufficiently large slen the addition can overflow and/or
the result be truncated when assigned to the int new_len, so the
"new_len > avail" check can be bypassed and the subsequent
memcpy(ptr, string, slen) can write past the skb tail.

This is the same class of bug that was fixed for the hex sibling in
commit 65dfde57d1e2 ("audit: fix potential integer overflow in
audit_log_n_hex()"); both helpers are reached through
audit_log_n_untrustedstring() with the same length source.

Make new_len a size_t and use check_add_overflow() to catch the
overflow, mirroring the audit_log_n_hex() fix.  No functional change for
the in-tree callers, which all pass bounded lengths.

Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 kernel/audit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 562476937fa7..547ae0cebec9 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2120,7 +2120,8 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 void audit_log_n_string(struct audit_buffer *ab, const char *string,
 			size_t slen)
 {
-	int avail, new_len;
+	int avail;
+	size_t new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2130,7 +2131,13 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
 	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
-	new_len = slen + 3;	/* enclosing quotes + null terminator */
+
+	/* enclosing quotes + null terminator */
+	if (check_add_overflow(slen, (size_t)3, &new_len)) {
+		audit_log_format(ab, "\"?\"");
+		return;
+	}
+
 	if (new_len > avail) {
 		avail = audit_expand(ab, new_len);
 		if (!avail)
-- 
2.43.0

