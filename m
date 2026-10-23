Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715941;
	b=3HkQ8wAQrSO0yXuvA5ToJtcbFWtZoDfn9gMaUdJXsPnfhoCujJZslPXuaGeybBLoF8Ee
	 lszOJdg+K552/0/SHvbx2npd+M+LXdKpGjlmQ2jCzVfExLh0hkV5SM59G9+8tAgJ0o0s0
	 K8x+ImWTGLG12H0vEvjSgwFRVruZMqv5cf7Udz9wkm1f7/QwKONQBLbT+Qh7ZpAJGcfR1
	 2Zt4erAIzTiVAlkQcq+QEGSfvawE+UXf6EvregidXiKouutRJHojPGdvL+wSVpm4i0WMn
	 x5pJCoYMvTFje5jE2NA4dU/+/J3fpWM367RuoOFTRvd6TQLWythbP9Gf5iaCyrulS2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=khbtvnCt8sXvEtX9fI1U36fFGjo7tER69Bnnl50Wz8Y=;
	b=RpOtoiOayuPWm40DXCvRvxHItLY8d+8Xg/V0ufY5oiG1xtG5kpM53I9jE3ofbw63nlQm
	 /DF2n+HtPvBZcbWjNW27Tma5Nmn9buhrfzvXVmkrFzSqPbFxKN+eg1KBp7i7UDLZ1vYx+
	 P2dZ+gWRAOpeq9jXZSksUPHca49P7v31xYcXNxDfbzRtB5+8J1DeQx2pNDPtIDOtFxQY2
	 ccgSbbRxw8O7UVKMFqXa5FGSXe1ZGvMvOsFwO0VuWswipwJ0MHR48eJx4whnmofMee9f5
	 dVb9fNWWIV34YadHOpUwovM9edr8r2H4Ap6oQQXdFNLTz6jNoimgSTAYrm4qq44KlwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qjSKpW+S;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E609606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 00:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E609606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qjSKpW+S
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so396957a12.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792715939; x=1793320739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=khbtvnCt8sXvEtX9fI1U36fFGjo7tER69Bnnl50Wz8Y=;
        b=qjSKpW+SP6NmnUtCQP3Zp/1jd6xZYFQ17wSv7tsifa1mR91SIR/kkop/qtjTK4Iqms
         PEZS1wbfNYsm5tbKG5nkh41NVCRhl9aCHQlTCUSHhwjEB10m8HGVjmAKLwGGwc2E25g9
         Rfrwgo5JafcVdbH0ZSWizK0IqqaCcG4djP7By4E3x8EtyfMJ5zn8hfJfvg1WMpf9Iql1
         QiCC8ZPyD32kiC3UBvpKPu+BpigFpC7jfcvBN6IwVxBKb7uLTsXbSB0w/jirk0Dgsg7d
         NDz1y0o7TgbiBREwiqlVf0VEe/8EYwS6Zp8JsWA2RxVJIvLY/TyHRXyg5gcw7gDtrsd4
         UYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792715939; x=1793320739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khbtvnCt8sXvEtX9fI1U36fFGjo7tER69Bnnl50Wz8Y=;
        b=xDST9LLoq7CKpdiGY+8G6slGEXkqg0ImRQ0ZYvQhS/B9H21dsG5LTCgstawstJxHxq
         RBsakbSav5JpLQ2tc6ngqLC/qrWC6OBgi78GGOMbUpR9oTDtJu15+f7bP1Z3HPqB9nGF
         2tUXURCw8e6WaU+I/EKzxSozN3YeBekFhpYbX1SBL7LZsQxISgy0ot4mT6EUpUpy8B9W
         GiQiiu8Cdu8FdwQ85e4v8+wgvtQNn+X73wr67MwrN2fXblW3GvEw/Spq7d0G4QfU40su
         JcaWOMMibEPXRzK41nqj4/cF1VfB3pi+PvZ5EpuEFO3NaBJhwfz1oaZzkdt9D8YvsVbX
         Sggg==
X-Forwarded-Encrypted: i=1; AKwUvByUNOQln3kV+39+nZ5iDEJZLjwc2ZXfrb6/4R5DGQ88x5CVDdJGyPs23rg49fihPnPSH+S0fpU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWAcUOpFdpGNJPw4NTqduwuvAUYQyHJ4SyR/4Lf/zTEtQAyOvH
	QBhBYz1EZLz2VkeXkEbFuZQysI+TF0hduMYuV90KFJAwnA4ftax7ngKC
X-Gm-Gg: AYBFou24ZyMcvzQ7v8GlNplYkGD206SveySL9pQuo7WRU+WGbFMUQFCoE0vl7jVgjF/
	DuDixzSdbtPcEFksQeW2vx83t/9E01zfXSlLwdt+WoQNIWPJP6rJtdsGp98IN2wE+6wbZ/uVVbE
	ySIfUjKiQszSLa813JnDgHrvMzqk5nhJSwPPhcvTKXiqerA68+go4YiHvEWNC4j+OWwyOO1cvW6
	AGT49iPYB13aP4l5QRT/XxodkCYpZuQqH/IrzYShSn28scLotXapr67K7Aq4X/Dn4mMLjPGyKVA
	2nf8o3EHxXTcWwhM0GbhRtuOsrFrPI+iulWrrmKif5Ulvr6GE5Bib+GuPgeW8wsZuMiVQU505z8
	IeXSVa8pZOz297eYWsVDHlHcvkq3gFS7fWag40jOWz5P6SZwhAWb042maOE3Jyj/1gkg0aEkah0
	oAi2dWrEVtCjkODoyHBY0YLb7EXZfkR0GdScsgTHVYLHqi7AbLVGNRZugPm0hgTtGFsskV1bawb
	GvGZUcO0ahGJzwvzxfst+0FejTQFIfW8oz9VJbXIvOjNFi+ETPDoafci2Sl2QwjAd8jzBNsD6QY
	8vfIGoz5IR/v784waT1IQr6c9z//3yD8MMTkTb8B
X-Received: by 2002:a17:907:7b8f:b0:c41:e0c0:e6b7 with SMTP id a640c23a62f3a-c46a8f502d3mr128704266b.12.1792715939268;
        Thu, 22 Oct 2026 17:38:59 -0700 (PDT)
Received: from localhost.localdomain ([45.93.75.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5d17e95sm45499066b.83.2026.10.22.17.38.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Oct 2026 17:38:58 -0700 (PDT)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: restore Kerberos logins with released ksmbd-tools
Date: Fri, 23 Oct 2026 02:38:55 +0200
Message-ID: <20261023003855.98316-1-mike.michalo@gmail.com>
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

Commit a47634cd729b ("ksmbd: expire SMB sessions when Kerberos tickets
expire") added a __u64 session_expiry field to struct
ksmbd_spnego_authen_response, growing it from 156 to 168 bytes.
ipc_validate_msg() requires the response to have exactly that size, so
the 156-byte response of every released ksmbd-tools, up to 3.5.7, is
dropped and Kerberos session setup fails with STATUS_LOGON_FAILURE.
The other way round, kernels without that commit, including the stable
trees, drop the 168-byte response of current ksmbd-tools master, and
ksmbd-tools has no way to tell which layout a kernel expects.

Pass the expiry in the reserved area of the embedded struct
ksmbd_login_response instead. ksmbd-tools releases with that area
(3.4.4 and later) allocate the response zeroed and never write to it,
so they send an expiry of 0, which ksmbd already treats as no expiry.
The response is 156 bytes again, so it works with those releases, and
every kernel also accepts a response that sets the expiry. Use two
__u32 halves, as the reserved area is only 4-byte aligned.

Fixes: a47634cd729b ("ksmbd: expire SMB sessions when Kerberos tickets expire")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/CAO+rqLhpPvY0NLrAnZjFXz0gOXnA6zsXxK8xCgtA42XUkSsAeg@mail.gmail.com/
Assisted-by: LLM
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
The matching ksmbd-tools change (struct layout and mountd/worker.c)
will follow as a pull request.

Tested with a local MIT KDC and smbclient --use-kerberos=required:

                    3.5.7      master     master + tools change
  7.2               login OK   fails      login OK
  7.3               fails      login OK   fails
  7.3 + this patch  login OK   fails      login OK

With this patch and the tools change, smbtorture smb2.session over
Kerberos (including expire1n/1s/1e, expire2s/2e and expire_disconnect)
and the 190 smbtorture tests run by the ksmbd CI over NTLM give the same
results as 7.3 with ksmbd-tools master, with no kernel warnings. NTLM
logins also work with 3.5.7. A test-only mountd that overrides the
expiry (including values above 2^32), the response size and the length
fields found no wrong session expiry and no kernel warnings in 313
logins.

Current ksmbd-tools master needs the tools change to work with this
patch. If you'd rather the kernel also kept accepting the 168-byte
layout, I can add that in a v2. Only tested with smbclient and
smbtorture on x86_64.

 fs/smb/server/auth.c          | 3 ++-
 fs/smb/server/ksmbd_netlink.h | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 1b24eb3f3998..8e5a1b10db6a 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -464,7 +464,8 @@ int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
 	memcpy(out_blob, resp->payload + resp->session_key_len,
 	       resp->spnego_blob_len);
 	*out_len = resp->spnego_blob_len;
-	sess->kerberos_expiry = resp->session_expiry;
+	sess->kerberos_expiry = (u64)resp->login_response.session_expiry_hi << 32 |
+				resp->login_response.session_expiry_lo;
 	retval = 0;
 out:
 	kvfree_sensitive(resp, sizeof(*resp) + resp->session_key_len +
diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index 2673522c76bc..fc6af757e45e 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -148,7 +148,9 @@ struct ksmbd_login_response {
 	__u16	status;
 	__u16	hash_sz;			/* hash size */
 	__s8	hash[KSMBD_REQ_MAX_HASH_SZ];	/* password hash */
-	__u32	reserved[16];			/* Reserved room */
+	__u32	session_expiry_lo;	/* Kerberos ticket expiry, SPNEGO only */
+	__u32	session_expiry_hi;
+	__u32	reserved[14];			/* Reserved room */
 };
 
 /*
@@ -286,7 +288,6 @@ struct ksmbd_spnego_authen_response {
 				  * stored in SecurityBuffer of SMB2 SESSION
 				  * SETUP response
 				  */
-	__u64	session_expiry;	/* Kerberos ticket expiry time */
 	__u8	payload[]; /* session key + AP_REP */
 };
 
-- 
2.56.0

