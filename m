Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645092;
	b=V2ryjP70c30hXiPh4B4HMKViIxeT+B3slWWL9zX2qnU1by3/pgPZ+mtSV4naBvGPOWKa
	 03c9y2u8+zLeDCL0gLTY4R0RtpanOjXpWNi8V2q9HdqfYm4A6myX/Opyz9ihZbdpGxFcc
	 VrSsOChsT5MAdADFKzxScqveU+r0npBSGwUAsXifvzy+TjojpLPgD8UQW3gP/ykn/qqSh
	 EaW6jp39N/OR+onx0iS54mrrfY/dGmVdLbW3eNC96QZkjw8H4kHrY7gH8cnMX3+rXZYj9
	 O/Ff/mECtzsNBI6/dKiENhOjPvJyfWW+kEZ64LeMppAGE90NkRVeEhA+rJzkQ0OW/BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tpmpzrLhm7pX+D8pjkEqrRIYRLx4SQ9n+QD2Zw1yZYQ=;
	b=rx4h5Q8c1vKRo1Jh1dMqZYLlT2VEI/V5XM+xYj+r9IhdkZIuhGKcCRC9j3LAyu+0iotC
	 lo9a2Pmbdwrs+EOnUO3KxLOYT9M5k0JWitfdPpKkjhe9OaE1WWUq+WBmeVN0UnvJ0U9Ex
	 UKdVeuB1T+HYp+KhT9stfK3y2xW2dU5S7AWuVOwCR4DxXEn9I3OLbLDzdPmCWmH7GYgNB
	 YsSH3q295HVPMQ7/mVK8q4Ko3FQwz34u5thT4gIOtrQumMNlFBFGaYEyVyv4+M8WDYNi+
	 EDe0NozvXdCmKN6WnjNfD49NUbhQDDwMhrPCxydWUJYFZ/XOtXdOeOI4qEVqoSe7PsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="X6QD4/CL";
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F9606A693
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D4F9606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X6QD4/CL
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b3ae17c536so5972897c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645091; x=1796249891; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tpmpzrLhm7pX+D8pjkEqrRIYRLx4SQ9n+QD2Zw1yZYQ=;
        b=X6QD4/CL+hI4s1wJiONzEtOeYCVAXuEN7VBttyB7xsPV2WC12JlUn4wdwlTKHGEfY9
         kEJ/tkYvtwmuCHs4NkVt4Dv/eb3ryhoO1lE8wyFAkVO/Ja0PpcXjXPDscFmlhKQGtAMF
         Zr6rpbkLIdM04F0UW5OuJjYXSLeqx0q6+JULocbmR+m3nbeb7LLNyLsJfTCiFaDn+Z/5
         SeahyERlx9DxteptQRD92CSuaG3NDyjhWLHI2LQbfrCSldRXOgH1YBoCQ2vvQl3tH4dP
         iy484IyZvfF7s/rORaxoj4ABgaQAlzC4imeL4KAZP28k44ET03v6nXLfLoEWZmW8/FH8
         8H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645091; x=1796249891;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tpmpzrLhm7pX+D8pjkEqrRIYRLx4SQ9n+QD2Zw1yZYQ=;
        b=Ss+fEfinehdjgIJxYHO+XhUhbjLzCvKKR0jR12prl4d4yCnCnkOc1Vroe91yxkjKpQ
         r8PxJkF2/6tQFbd25SbBCl7N5Xp/CmzH5yRzgxUsb/CPmW3YC/u8a+zETlsvtOo7q2En
         qr8+FUFkuwNDqbFwOOhoj3euVd4ABiZTQOUDyvxJaFIXO52Rp3l7t8LCRVHE0Oz+wzZG
         hhhP5d+sbfwqItW0iBuIgSsikjylIEEd/63K4Wo50Zu1q06sb2JbFJLZcRBrwQ2NmSp9
         Q/mmRipq57gmrk63DA/V99L5V7HSjwxF9t6QrEhwf9C77XRRd0EPkN5DHxw1RgZK5Awg
         EPCg==
X-Forwarded-Encrypted: i=1; AL+hErHt9r1unLMnMYx/6kWXm45OE3xThVUfuVOvb0rQbm9rzCPOh1mx3GSdqE1mVNVH/PwxJJ5a+Sg=@vger.kernel.org
X-Gm-Message-State: APuU4Z861IG1+/6Azi6jz94odlVW87QSjbO2d876IlliS9CnL8j7onVR
	rMiklJV6wkqZHckseDYGv5kia9oT6lnWTSbCfZfWu6vBKimQHeZuNpCupwd4UCBScYi8o67KkAz
	Vsg==
X-Received: from dleb17-n1.prod.google.com ([2002:a05:701b:4251:10b0:1a7:f7dd:f258])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6988:b0:156:6676:d0e2
 with SMTP id a92af1059eb24-1b55689f5dbmr25363930c88.10.1795645090492; Wed, 25
 Nov 2026 14:18:10 -0800 (PST)
Date: Wed, 25 Nov 2026 22:17:29 +0000
In-Reply-To: <20261125221730.1421806-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125221730.1421806-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125221730.1421806-2-elkin@google.com>
Subject: [PATCH 1/2] afs: Guard NULL alist on restart in afs_select_vlserver()
From: Elkin Cruz <elkin@google.com>
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In afs_select_vlserver(), restart_from_beginning: is reached from
no_more_servers: after pick_server:, where alist and vc->alist have
already been cleared to NULL at next_server:. If an earlier VL call
received a response (vc->call_responded == true) before failing with
-ECONNRESET (setting AFS_VL_CURSOR_RETRY), vc->call_responded remains
true until another server address is selected, causing
restart_from_beginning: to dereference a NULL vc->alist.

Guard the preferred-address update and afs_put_addrlist() at
restart_from_beginning: with if (alist), matching the failed: path.

Fixes: 98f9fda2057b ("afs: Fold the afs_addr_cursor struct in")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 fs/afs/vl_rotate.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 6ad9688d8f4b..8381d6a35d3e 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -171,12 +171,15 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 
 restart_from_beginning:
 	_debug("restart");
-	if (vc->call_responded &&
-	    vc->addr_index != vc->alist->preferred &&
-	    test_bit(alist->preferred, &vc->addr_tried))
-		WRITE_ONCE(alist->preferred, vc->addr_index);
-	afs_put_addrlist(alist, afs_alist_trace_put_vlrotate_restart);
-	alist = vc->alist = NULL;
+	if (alist) {
+		if (vc->call_responded &&
+		    vc->addr_index != alist->preferred &&
+		    test_bit(alist->preferred, &vc->addr_tried))
+			WRITE_ONCE(alist->preferred, vc->addr_index);
+		afs_put_addrlist(alist, afs_alist_trace_put_vlrotate_restart);
+		vc->alist = NULL;
+		alist = NULL;
+	}
 
 	afs_put_vlserverlist(vc->cell->net, vc->server_list);
 	vc->server_list = NULL;
-- 
2.56.1.839.g22a8290db9-goog

