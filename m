Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254303;
	b=SLrLrdlwqUz0/CBaHLD/HyZ8LPAQ0VzlKKqwv1Cu4FKUmidb4ckQMyuoDD1ud3gOkBpS
	 yulsZLdwJsXg30GGA9NDZWfYVSwll0dOhCQCpRLrq0H7em0BJrX7L9/wLBcIjc2bkLGTB
	 0azZfWmraZhtaLjTLAm4tK2HaND55Fhx/alN65UljlRoODQuQ5OVfQdCGXjPgyt7d8d15
	 PQv2D8/GuMuNzwHerOh8n7AO9fzaUzNYpH31rP8lAhHg+F/wTXtzMqZ+rHY/MPJw3pBjT
	 0bli17azzr1MiT3f3iNjJjcXeFU+Pyxh9pf4piLdpNqk2AuLnxizUntYuQrQXgL45iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LjlIdWOtAx4vgBSOIZMhE9Gxzn2GjEyrd7gwD+Ba4Y0=;
	b=fePRhB6/PCVjpHUFlBsJvY+aYTRH1/T5HMb12e6M2l88bib8Qi5y/ni7oKYkJnZ7d76G
	 rtcmoBsSCD3w6+vYrdth2+xHHknCD8muK6ZhpohP5mtPokR5022V8rYxm66/CgtcsjfIt
	 WDDWdnEDTc9pADPv1XGHsZAc7K7Bnk+btuofgcMS/jj9pyr0uJTp8kEP28HWppceHUa03
	 uE4k9UILTLDseLngt+x6KH82E17PAPEppQFuPKazWyX7syzrhl30gPxIjDTdyFSfJ+d8v
	 b5+317msLUG6HHGDqc9HtGadipz33ahMukrCfsqSbDjTtZwZsbB1TtZ6B3IoVNAVSvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="R/1WuOAu";
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084D606A335
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A084D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R/1WuOAu
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b8ecfa886bso583301b3a.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794254302; x=1794859102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LjlIdWOtAx4vgBSOIZMhE9Gxzn2GjEyrd7gwD+Ba4Y0=;
        b=R/1WuOAuCnN/JHW6ktRQlo8KATUbKPdmjv9knkQlezuppBKQ2QFjLENs6otezsL2xP
         eTi11KqJIzewO8F4GEX9Pf6o4wLrfbGRV4H9OSeZy3ikk84qdvC4VMdEMg/MHDhDNLVv
         yv4ssmwMsCkU4txSd9s/sNEluf8Pigwe2x3/j3/gXS/kK2AAnjAD+0PdFvTVfnpnzLh/
         fBvyKMdHhUoSFRmcYglCQljvABVmnVeCkXj1NCgIQil7Gk/POjf49qomsOEd0fN8NByQ
         wbFuKhXBaMycT4NEbjJxj+bT9JfZWmsfDPrZ9S7aOK25smaHJEJaVgMkSFajcl+3hg6B
         jaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254302; x=1794859102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LjlIdWOtAx4vgBSOIZMhE9Gxzn2GjEyrd7gwD+Ba4Y0=;
        b=rfwrXXXlGIuZJho9qakFiG6Tw2FjE+9lSGT1EeadURx9yw41Pby4QEpga8hZPdfzZa
         j6VC8b/BJtXgH7zjJ8ZqybWFK4kVY6QsIGzuo8HrCwbnPI6IS4MTroUvIwC76RxoF7HL
         ICdkDWNKMvMoS7Yzj3+RG3Kdx7o7FnJYoD6cWN0bfjDHva2CqOLBrcHistCFWibsxymy
         AHUJh6rEiV9/jJ8zlIqy1xvyZwQYv1l2OxhVi9Vq8ZAFI8xWft4j3MaFU+NcvEI5NDM9
         I7voN8WA6fEHa9SQMquVv5He+Z9h3c8zR7M4rFFFyMroHdVP8TFWgX0+TymMJ755RkKC
         QC6Q==
X-Forwarded-Encrypted: i=1; AL+hErFncl5EP9N+BLYL26HrCj/SXdAfUjWKJ81xETOxOETBW56tT2ycjj6I1Klo0dZD/jkERXGSj84=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TaD/k++Ceyz+/U5bCf9uRjypAAq0OCsnceQ7NqaIWqOgtOxYA
	fUKC4+eiqmSklsWHaLWS7NazUBa5981kmouKvHKJTsAcDcKGWMqNiQQH
X-Gm-Gg: AYBFou3m4VhesueOfT9vEh8+bfFIU/nXJzL3XIZHQC/d1ivF2BhQHiv50kCFKna503e
	QwpfCaVDoRLCi9u4mqKDUXAh2ZKohKybv1tNjM+b89wc3Qt/gjWnNbq4tDT3CMAHTgK0coNRBrd
	wgePA8mfWuDLXtTzxuk6rDekzkTFSO8r3ezY5fWv54aDvwBMRL9DpQRBHLoZlhy5gSQz39QkR95
	3fxggS8wCAiBPRi4QCnlKYbFk61xcs1kVBugXUP7CWNMRIH4ruowvJ9kY6h9KXeeDNhM/8U9KYM
	CxYEezLpm+E8wM+CbLeJar49+dDp5kvJUolA6tWyEJCOegg71GVWY4AKyiS0C2WNiI7R+uJUbNY
	nUnbXcipAyEvLF/L+HnQK6w9qDq+C9sVwg5QZ1hyBkU8SLpM4OrYpJfzYnbKdGDTNmk/bN/mUwK
	HIF1ZF5+7WtMHGfFdJ4ZY0yF7X5cMKE+7svMlOumXtFkDMOzUy9/mAgaI12bKbCTo3hLw3Sv+4Y
	5HJCi6vIOhZOOuLglaPK0pGxhCzy/6iUD8ka3cs0Hm/fYU8BHUZqGtEEdzhd7ER/IVz3FkDrQDk
	vRx0XbZMCgIZ9/k7yafCNLCz33TJuATm0t2bmakEeOjzu1U1kvHRLdRv1D3K7fHnlI1nfD4spaS
	8yAfj3XwZy1M/vm4+V8ncb2zBTilKgc9yLhQzTUM9GjqIyPJ6rM4AaMw=
X-Received: by 2002:a05:6a21:110:b0:3e2:4e6e:6ca3 with SMTP id adf61e73a8af0-3f18fb8127amr165601637.34.1794254301572;
        Mon, 09 Nov 2026 11:58:21 -0800 (PST)
Received: from localhost.localdomain (mx-ll-183.88.2-201.dynamic.3bb.co.th. [183.88.2.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa2a7fbesm61629b3a.11.2026.11.09.11.58.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 11:58:21 -0800 (PST)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: linkinjeon@kernel.org,
	stfrench@microsoft.com
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: refuse reauthentication of an expired session as another user
Date: Tue, 10 Nov 2026 02:58:13 +0700
Message-ID: <20261109195813.24238-1-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a Kerberos session expires, its owner can reauthenticate it. For an
NTLM reauthentication, ntlm_authenticate() only compares the new user with
sess->user when the session is still valid. An expired session is in
SMB2_SESSION_IN_PROGRESS during the reauthentication, so it takes the
other branch and simply sets sess->user to the new user:

- the session's open files, tree connects and other state, created under
  the original user's identity, now belong to whichever user just
  authenticated, and a later Kerberos reauthentication is compared
  against that user rather than the original one;
- the original struct ksmbd_user is overwritten without being freed.

krb5_authenticate() already refuses a different user in this case, and
the valid-session branch of ntlm_authenticate() does too. Do the same for
an expired session: compare with the existing user and refuse a different
one with -EKEYREJECTED, freeing the newly looked-up user either way.

An AI assistant was used to find and fix this and as an independent
reviewer.

Fixes: a47634cd729b ("ksmbd: expire SMB sessions when Kerberos tickets expire")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/smb2pdu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b084cca8813cc..234439c1526f9 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2365,6 +2365,17 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 			return -EKEYREJECTED;
 		}
 		ksmbd_free_user(user);
+	} else if (sess->user) {
+		/*
+		 * Reauthentication of an expired session: as for a valid
+		 * session, and as krb5_authenticate() does, it must be by the
+		 * same user. Replacing sess->user would also leak the old one.
+		 */
+		if (!ksmbd_compare_user(sess->user, user)) {
+			ksmbd_free_user(user);
+			return -EKEYREJECTED;
+		}
+		ksmbd_free_user(user);
 	} else {
 		sess->user = user;
 	}
-- 
2.43.0

