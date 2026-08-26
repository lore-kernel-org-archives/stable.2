Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B424313E21
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758355; cv=none; b=F1aTeefhBXmiTh07bhn0zIHGEQV21ibARY20k34ty9D7WyI6VJqS9zhqF5zcbbfkjrlteFIqvkleH68rFsfvLeBd6f2+0hOf6kdyKSQvRfArhOZkTgSeu/DcMGDaaEIbuzYKL7TgivaHvgm+yOnAULAyGGPGE899MJF6d42org4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758355; c=relaxed/simple;
	bh=34K/FoU7abAOYLlPQo+u98BXpk6bD/cNXKkoSIw24xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNahzehC4z/uv2k42pwpYuvhZUwW1WSBoT2YZlN1a7PfzF/NZc1ZAucG6DDc+zVK7kTzsQbIaZowFoox7ulgRKmCEmFC2id22tiJzpczAey3WeoHL6NP/m+4hQ0cMJ4YyzMUqsgquaculyPZWernklGQwaVTt/M/lVaPo0nBSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCH7I+Lj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nDx8dUjt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCH7I+Lj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nDx8dUjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787758351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsXHiYkvLJ5Dfkmh4RbCEqIEWI8MfAZu25u27dTcaQk=;
	b=NCH7I+Lj0PzkVST5JKsO3wV7WLmu8D7+3/f6fFhitpRmnjq38QAZhXxqBeFWZfLE1q2iDy
	kFiU6aL8imz8HC02dnUZJpBbSf0rMoNxYAaL5yBnTzAMI4OV7Qb5GI9IyEK7Hs52zEp+1o
	WCRaUgyFGYAos6byM9yIU4B8bnQ91MU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-KIedxDomO5qnCwUKWbRz8g-1; Wed, 26 Aug 2026 11:32:27 -0400
X-MC-Unique: KIedxDomO5qnCwUKWbRz8g-1
X-Mimecast-MFC-AGG-ID: KIedxDomO5qnCwUKWbRz8g_1787758346
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-855a66e5c76so27959787b3.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787758346; x=1788363146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsXHiYkvLJ5Dfkmh4RbCEqIEWI8MfAZu25u27dTcaQk=;
        b=nDx8dUjtb0XAf+WCfJ7bRqSKAghqKwtg3xRPAZ/CEBxWlJtYEdCEhTf2H8lY3rrKrk
         eUTrfRHfV4sqg7cmx4NfQxiADo4jjuVqGzqO7cUw4QgQ9LecDxi83UqKJONW0cIRlXJY
         ll0cRyTyzFeofkaTLGGN/ruosMTN/KIA4TtxDb9T9D2TSXduCgBPuYTTOyxEJUL3NsN/
         8JXrrTeQB1wBjjwRVJgEirHnTcEpmpTjhxYZXYgtkdW5cRNQEGclWXF2VGTDCFE2XCcA
         TBI+9FZ7Pg//G48T0bwvbupyg7Ds5QALEFWFnAd4mhL2ZGV8i9Umvo2b2EUc/301b6vX
         0KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787758346; x=1788363146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MsXHiYkvLJ5Dfkmh4RbCEqIEWI8MfAZu25u27dTcaQk=;
        b=AifQRNalJxttRxoEJlmf1hjhLq7EHJV0orpEiLGhSeIUvRmw3vA6O2H1XQ91n47lE2
         QCzQFGmvCBBOSi61sj8lU6ozphc/eUZnU97szPAUrPKVRNHLUiTcITKu/JgcDjRrkTnM
         vFj/DMur97ilow1qO4TWOL/hrRGkrZgwiPnlOFtxUVNXOmInKxQf7aCDK9ZAKgc+Ui2M
         Xpdf+CxS10TgbOu7kZDi/wtw3twqvZ8DXwFgkzLAexfPk6oNPxsN+ZkUjg6RVWMiiLAy
         glfGvrx9JB4IYsysdrHrYJ78NL8Pc/XsYyoLABsg4rDA2OtaXsKWPvGKn5vrJ7MiftOn
         WW4w==
X-Forwarded-Encrypted: i=1; AHgh+Rq7MKHwqCpfaTz3EQ0XfscfixbqmCwOUY2QfP810kd4hu1L4P5mq8KG+PLy0lG6pDJsoP/umz0=@vger.kernel.org
X-Gm-Message-State: AFuF++kqjU2FOPosI9ic+F0Wgu3V9ZHtVlISLcOSWD7M2oghh7PzYHUK
	1wtwZpUqKGG0TNHOgYBx4kykOm3IulV67+Lv7LmivxUoUBeDQSH8vY77RztyeVKcT4LyBgQni/7
	8kAifqZWnWX6v0k4TujiIWEXsRvQuUJ2TVRS/TzWLtH8xuFQrL/hgtb1tow==
X-Gm-Gg: AR+sD12n44L5Au0zxzH68UBiLhzQ6lEed1QKzvGlwMRgXT5MVGtHQ7y6wjtoW/XWSKb
	PMYzgTZ9GFpxIypmpmHM5l7BP83F9zvaNTPKLS7dXeINpvdEABEOYq0qmBk9aAMAWY8CqQ//CEa
	Xer9EVcp0ygN6Qk3DWsQlUcrEdLIZNMNINVt7TrwU12hU8vcu+LVXwJXBytCjswWNSOXBtxM4uL
	cAkqeBR8IL4+qJcA36OTxHbFuMLE3gj4ef7IkyxktRoRBFYiDgTP8QReABfLZTlB873FGlwNRX9
	0Hpu68l9KEZSYQftNnDjqdIKxP0t4BK5fSIpuqAGakzAR26OAyNZnV4QezHNu3gdXWnWGgDWxJz
	H2vCI/bDK7N5zcOObua2fAcQh7uRRF+1tuGfO2xUyR6vEL0UexOrfiT9NWZvILNdP6w==
X-Received: by 2002:a53:e10a:0:b0:66c:9046:5aa1 with SMTP id 956f58d0204a3-66d256df641mr2248539d50.22.1787758346075;
        Wed, 26 Aug 2026 08:32:26 -0700 (PDT)
X-Received: by 2002:a53:e10a:0:b0:66c:9046:5aa1 with SMTP id 956f58d0204a3-66d256df641mr2248520d50.22.1787758345573;
        Wed, 26 Aug 2026 08:32:25 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24592f24sm1598209d50.6.2026.08.26.08.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:32:25 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 10/11] smb: client: fix incomplete bounds check on reparse buffer in cifs_query_reparse_point()
Date: Wed, 26 Aug 2026 10:31:46 -0500
Message-ID: <20260826153147.4112943-11-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826153147.4112943-1-sorenson@redhat.com>
References: <20260826153147.4112943-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The start >= end check before casting to struct reparse_data_buffer *
ensures the pointer is in range but not that end - start >= sizeof(*buf).
A server-supplied DataOffset leaving fewer than 8 bytes passes the check
but allows OOB reads of ReparseTag and ReparseDataLength.

Fold the minimum-size check into the existing condition using `end`.

Fixes: c13b779d26b3 ("cifs: Fix validation of SMB1 query reparse point response")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f5aad5f61dce..acb533383a3e 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3064,7 +3064,7 @@ int cifs_query_reparse_point(const unsigned int xid,
 
 	end = 2 + get_bcc(&io_rsp->hdr) + (__u8 *)&io_rsp->ByteCount;
 	start = (__u8 *)&io_rsp->hdr.Protocol + data_offset;
-	if (start >= end) {
+	if (start >= end || (size_t)(end - start) < sizeof(*buf)) {
 		rc = smb_EIO2(smb_eio_trace_qreparse_data_area,
 			      (unsigned long)start - (unsigned long)io_rsp,
 			      (unsigned long)end - (unsigned long)io_rsp);
-- 
2.55.0

