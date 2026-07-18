Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6128B7EA
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784351370; cv=none; b=cxIibzDNMps7iKYRhIXBbCXVICgKVoH5+q7CZPfKct5EpWhvAWLZ9ZQkcMlsb5NuRtfjK6jiZVxua2UTsQbr+bTUtQSUyDAzh/2lZA0LveLGf3d4uTpPu/zm/qfy7ikIER574QV6GYS8WAbZd0mZ/6qNSIg1V9KFN2sCfmi+Cgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784351370; c=relaxed/simple;
	bh=m0ccft+gceUz3MPTqfWxpwD+GP4/rdsMkv/6QSxi0lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adh4zopt4W/scFIWyu8TZGNI85YhFZxkidofLGuLtiUALsWY71EXBYwpL7EK2K4w6NwKE2d0/hUewvkVfgMU7HqB/wzju0H6ZDnPOrm7kiNk2Z4++P7Tia+g7ynkdZ8MzB7pqluJvkWGq4hY+PJ/WAN0uZ6gu4MolVmN18wvrV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKn+I1wb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKn+I1wb"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so2368871b3a.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 22:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784351369; x=1784956169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GGpAvn9E9sdeBFr4azx3JRFkGov7PU5BobgH3wDuOJg=;
        b=NKn+I1wbZuA/B9fCidmzfsUEB/JblJf4P1v5WooyeC54yXKFLKRXxnRdVBAXfodph8
         SchRMexgUtFgUXfm7FEfV9jXo2mGXKA3sZx6uB8TgKtrGSy+hGq75M0gshAHB3rBivOO
         1gXJxO61zCdY4kshgSOhSQ9F5DxFXG1XqYI1rt2oqoaMddMSKRbEQQENj8UbSDZETbi1
         XEo2z6jcXxWAE+F8OpTKyuusa7vsu2ZnBQdMclP4QWXZyaDANnIhzyVAx8bMA6z8QoLt
         Y3rggPYFJ6v+rG1PiEVtogr/EfuUAyQ8192zbnkYwER/4mpm9j1xfnWvHwYXIA480xah
         /REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784351369; x=1784956169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GGpAvn9E9sdeBFr4azx3JRFkGov7PU5BobgH3wDuOJg=;
        b=VYx57bfKJ8wp+BjlvZUJccbEcH5UoWfAdPvo2B6nB53FepUHjrRQs51g/GSt72eX+9
         y5AeBjiUIhEz922L2Dn7AJdjvJLuKc9yRRX4HR2MxDQkqnK4hroBEwEjkhBuHA4RPIfg
         dfnTYPjrFKpJM74/xTcEsRKFrSAkQ5PeN/ZI7VFxMn2wvV3YZS8sOj0sS75TBYSXWMyM
         tEexO5POu9E6zolFOEop8yU/JVP8dEs/WsP+Lc6QAi6vIH7lzsG0V6Qso4zpRT2PV2Ry
         MzLeQ20wNUYPOKeR6VvGPJGybwS2XAMTiA8+PPITf5zdbu8/We8dqvdkl+ezIQ3GYz+V
         QyYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKO35SqXFvuQMYwKjEfvxveLxAtwumYezv44xdqz6OYKfOIdj2a+VIc35YkqOmByYx6Si5RM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX006KyP2z2HmYYEB3baBnm1mbMfT2QusY8pqyPpurNxiP3eEl
	Zwm/w82lVaqEhKVfHdzTzCsjEPy1zWfdi6SI+oUKAytrHdUfGR9oqQa5RvQD+Q==
X-Gm-Gg: AfdE7cnJ5Pek5hKFpNw6jOSVHNeGdGl5J2KWLPQqrsrQeilP4/kpJgiHU3wpLmsbO/J
	uCMFfzTLSc8VbNQ+7AG4tgeKjGIMW4KPWnK1vs/JMQac9XuWzI9AhyDlNbVkSraNsQOyuQovlE5
	pFyrUW+vxQ+l1qghX/mkzS6/5qkY/inQzuOqSLS0+K6wpiTp3dkf4OfnFO4ve5sWyUNqlSbRPTw
	BSiFFNK3ddPNScfakYby1mxc+Ifd/BCn6s0QL24T6o8SEgpxsimqTbOKHHf4YgDgF3J9IdM6XOB
	zxuFSgCIpbGHs1axH8qrO5eIVjoX5nq9UX9QFv2FgzT/SMrveFLnGVV7pTpW4EewcpFfyRzMmq9
	bAIN6pguye2Nqh+GPi5y/MNklc7nOjxB7Dw/amRQg/CGGC9TfLqIYS1pGJYnnwtzOOuP8YQ9pQr
	tIaO7oNLy0edY1qQ==
X-Received: by 2002:a05:6a00:1f14:b0:847:9803:ec6f with SMTP id d2e1a72fcca58-84beb187fc2mr9986170b3a.10.1784351368541;
        Fri, 17 Jul 2026 22:09:28 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2afd07e2sm2205246b3a.61.2026.07.17.22.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 22:09:28 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v2] audit: fix potential integer overflow in audit_log_n_string()
Date: Sat, 18 Jul 2026 13:09:22 +0800
Message-ID: <20260718050922.1980425-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715024635.25376-1-zhanxusheng@xiaomi.com>
References: <20260715024635.25376-1-zhanxusheng@xiaomi.com>
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
v2:
 - drop the unnecessary (size_t) cast on the constant (Paul Moore)
 - emit "?" instead of "\"?\"" on overflow, matching
   audit_log_n_hex() (Paul Moore)

 kernel/audit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 562476937fa7..9412af9144bc 100644
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
+	if (check_add_overflow(slen, 3, &new_len)) {
+		audit_log_format(ab, "?");
+		return;
+	}
+
 	if (new_len > avail) {
 		avail = audit_expand(ab, new_len);
 		if (!avail)
-- 
2.43.0

