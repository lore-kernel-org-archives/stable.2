Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F5184
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588800; cv=none; b=deio8pZR6WcnqYPuYpTaQNiR3tGBLBH7sadB5EMEG99J+nn/1T2Rrep9gkIDsDoxbhR09CmEJxQK2GScMFAE601ARDiVQIxscckCB7llSeTH2SgECIWlCd3Ia3OWd9iN6nfFgiv3CpseUfEVPs6McN9ob48uOHVoi2WOPXF5Hvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588800; c=relaxed/simple;
	bh=lSt0EqBpkyX+cH64uzSW61lENCGn+1Dr2Sf9vrYyv+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJ+6G7GEJcpKGjsXwBrX8mMeekRJuwnY13j1f954Mi2siTB7J70tdeBVY9H/C3HJwuRLUQXSM5K21iNISDP9k2/H4YxzGAbMZ49Md8LhQ6KYmMR7mwztyYNK3lZElrNOh9Vyt2q9Z8ErX5mFDB4OLNdFoQTpkDSMhyfI1cmmdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMurlyrS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPPNrnaU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMurlyrS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPPNrnaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786588797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wWDIoZRUfi9awnYLusDekbM5ZGXjySJAmwmUQrS1l3w=;
	b=RMurlyrSWP990RB627kFyGjsDtV6hG2HkQ4novQlf9tbUUXsRv8HshvHobJMOSPkShzDTX
	5HaHf1YY/mrR6tEBYVERX7HyI10b5Z8ssNT8ZMt3rKYsYD409uOfQJqCjwTVb6L3N9U/gm
	FfYTWl8QpXoQ4tuQQd9aO+lNZnKcTmw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-adG3ox1TNF60x8wF3Jrd1w-1; Wed, 12 Aug 2026 22:39:56 -0400
X-MC-Unique: adG3ox1TNF60x8wF3Jrd1w-1
X-Mimecast-MFC-AGG-ID: adG3ox1TNF60x8wF3Jrd1w_1786588795
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a416619e8dso838028b6e.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786588795; x=1787193595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWDIoZRUfi9awnYLusDekbM5ZGXjySJAmwmUQrS1l3w=;
        b=QPPNrnaUBGS0HLZTxDbGH30acgEtrtcLdlAc10Gt1hVjNpuGzlLF/wIIQqfoOv61NT
         4VA9Vr1VUYfLeNAJgzktN2WGnPzR+AOc5ga9W+vrS12Vo/I35s0SAAr/iNTSdyHwTonh
         7Gaev+IRKzAuE9Sjrm7r5pbct12lRG+bprezw5yQwR0WdmD86NDJW/IDRTYKiZrTxQQX
         3S0NXLwtubH0D0n+n/4a8v1cYQkHvKkAqZwtkrcpQ1GgpLdfo01pGyZfX1qNvSym6E1y
         /HE4S1PA1MmOgrr2HXwjqG56LHmzilov8W5J8IQGeGXowiEfKnudsmoCMcnKIZjrdEAZ
         A75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786588795; x=1787193595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWDIoZRUfi9awnYLusDekbM5ZGXjySJAmwmUQrS1l3w=;
        b=Ei1sHOrcoHCHIOyRl6UlbCZdNj9aKfEZUjo/05VjtgDQefnjy0tu4VYpO1IxvmeOgs
         lQBhqoEG2jwgR5VbftIeOrfduU3xwdB5He1Kpp/oPX2ulevhWsreSudsprq370IPe2fG
         PMrNvgzGfQQoNd2pWC+TPPTP5zyOdNro7Lb2GB8UkONk0MY62JRshjYpcTlntNM3TtNu
         +UNVxDONdauLH6pSTEtCKWwqsNzKO39dnyVkz59k+K+vi2nYL62wO1lgYdslUBryrvEi
         opFIQ1aFF5+pwmv/1r2HKbmg1EfeU+ewpdAYRAfuMI2rDHhtqARLuElfKwhmCWd4uMfU
         wcwg==
X-Gm-Message-State: AOJu0YztZJBwXJ5E57i+biBcso1IG+PInS9lGyixX14SEOc4d7CZjQdN
	otWAh//pJZQ9QOaMVooiQe+B4NH/CCIGnWYsAjtUyMoA6Sa2rv7USYl7AsCEGHPROiJKLisyM3W
	UB4ObZQOMZCJQQx0XYeRTM87ZGKpqctJkGRwBAHft0vPX142EqgMNP06jzg==
X-Gm-Gg: AR+sD11F5G8+j3M/oScdBs+SWngPTEk9Z9Qrwx4d5UlNvMg10gflThV3aeCjpif6Czl
	BXWoyKrAXXoLYGXeFWH+LLnOy9k+jZ7YSjTR0OeBDREmfGw2uFhsve2mPELb5IOMCHzZQgggMlz
	X2dwsbzCVYXQLSHq0XAxf8U4UuvHiqj2AhyEqi7CeuLXm9vLz0Q22cTj9C/n0V8eNTJir64GWEP
	EMrLTsPaxIpTPoME2EA2wNaTdhOst+Rw5Z2t9AwqlvBDTgQ0nOzbvaUq97ZiweF3TIoajNnOMyt
	4S8OQcHALb40zSwLddlWzWc7Yq2vB2riqisb6+27RkfKQCw511kyQ1TzKw8ss8J/AGF7XiU/4Kp
	/ezwKkpA4jNtVJopyQyqZM9JbTtQ8lA7FM1ExgUgDti9qzRlZxs0aAgSHXIhhr4ra0Q==
X-Received: by 2002:a05:6808:1a03:b0:496:976:acad with SMTP id 5614622812f47-4b2286875e3mr1003763b6e.1.1786588795090;
        Wed, 12 Aug 2026 19:39:55 -0700 (PDT)
X-Received: by 2002:a05:6808:1a03:b0:496:976:acad with SMTP id 5614622812f47-4b2286875e3mr1003740b6e.1.1786588794489;
        Wed, 12 Aug 2026 19:39:54 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b22cd187e2sm506473b6e.6.2026.08.12.19.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:39:53 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	stfrench@microsoft.com
Cc: stable@vger.kernel.org
Subject: [PATCH] smb: client: fix UAF and buffer leak in cifs_check_trans2() for malformed secondary T2
Date: Wed, 12 Aug 2026 21:39:51 -0500
Message-ID: <20260813023951.1846143-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a valid primary TRANSACT2 response has been received (mid->resp_buf
set, mid->multiRsp true) and a subsequent secondary response causes
cifs_check_trans2() to return false -- either because the SMB header is
invalid (malformed != 0) or because check2ndT2() rejects the PDU --
handle_mid() overwrites mid->resp_buf with the new buffer (leaking the
primary buffer) and, because mid->multiRsp is set, skips the
server->smallbuf/bigbuf NULL-out.  When the user thread frees
mid->resp_buf, server->smallbuf or server->bigbuf is left dangling; the
demux thread reuses it for the next packet, resulting in a use-after-free.

Combine both early-exit conditions and, when mid->multiRsp is already
set, abort the pending transaction inline: set multiEnd, call
dequeue_mid() with malformed=true, and return true so handle_mid() exits
without touching mid->resp_buf or the server buffer pointers.

Fixes: 316cf94a910f ("CIFS: Move trans2 processing to ops struct")
Cc: stable@vger.kernel.org # cifs_check_trans2() is in smb1ops.c on kernels < 7.0
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb1transport.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index 966f2cf83a51..f11a4a243784 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -430,10 +430,18 @@ bool
 cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 		  char *buf, int malformed)
 {
-	if (malformed)
-		return false;
-	if (check2ndT2(buf) <= 0)
+	if (malformed || check2ndT2(buf) <= 0) {
+		/* mid->multiRsp blocks the server buf detach in handle_mid();
+		 * returning false here would leak resp_buf and leave a dangling
+		 * server->smallbuf/bigbuf after the user thread frees resp_buf.
+		 */
+		if (mid->multiRsp) {
+			mid->multiEnd = true;
+			dequeue_mid(server, mid, true);
+			return true;
+		}
 		return false;
+	}
 	mid->multiRsp = true;
 	if (mid->resp_buf) {
 		/* merge response - fix up 1st*/
-- 
2.55.0

