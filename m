Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265451;
	b=jW/f2E/YQyiuVaEIBy6MQsQu6HoQ/srH8M5CvmZIIZjA1c62HazQgnWn/KTsxtuJ78Sd
	 NGittJHsQRVfhAYa5I3qEHynRPZQ81wc+G9JN4M85vvUTK8SrFMSP7XzawVcVMhk5A7Re
	 Hdc47MHDACe8j+gGoDRppoGaxnPw70ikVb+EjKivpuP9Ck/fAsXGLIa4ecsm9cTA7823I
	 ZM+F9Wv5VFMf5rM9+EW86thbM6I1KAA9dcEjhlDlcptPDF66cy/J05tyy5N3AmbeBgTgj
	 8i/dbZ/+lUAtDWhcf5sZ2T/ywi0AKJm1Lg7jg2XRgbRYywPs6JDE2EI6iWq4kMOPbJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a+JvEByhjl3Q0eRtUPeklA/fZjCl5bKRc9fdhPzK8Ac=;
	b=ZQ6nwRWk+FGAG8ygnzLnh0dy/b81LNpaXWr0xMQonNsA4I7iClOlPg8dRSYuaPDHVloQ
	 9ZEZQJPd+2f8IPhwNBk2ASh6uKKOTxsObdOzeYe8Xsh6rpRWoDhfR/v62mVoGLkURlUS5
	 RMa9WBgL/CQTh5w+ClxhLYMMh0MopccvsAVDCfQJKx4ev6oth3phh+oaO7gS/oKBhQETa
	 rM7AnX7C5PfHxa01+Pc/19Q3nOwi+m9Qmndc0vJyLXPiRoaZpngp1W7F2SSGh7crYqmUd
	 kV4Bq9paezFQgtSfD7UbLrcDI5Z+2mYybGYAw1+8RglvyHfQ1CDKSJwHc/+rZgwTMTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Imsir6fH;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075A606A330
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 12:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D075A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Imsir6fH
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso12809785e9.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795265449; x=1795870249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a+JvEByhjl3Q0eRtUPeklA/fZjCl5bKRc9fdhPzK8Ac=;
        b=Imsir6fH8V7hOExu52NV554HH3pwtbhoLh70BMUw8H1FaFiWt7W9gMtzLxzyAWqEK7
         PDd4FwlbIR16ulmMWV/RrrEnkjme74mNISBwO15zVGJctYBCbuEexnAVhvDw7EChJweE
         CNJLlHu9Ia5dmdb8RBOiBLwhc4OjapiV+Cd5c2mU4ujK3opQq7DLiS0fxDOUOEmQUNcn
         Oc/JxNmuUt/GSKQYXe7LuWKLqWlVmLBpBDpHOHXdMcuoVtBhj0Cs7C48GQHHVRpGJLnx
         57FfYipZk9L0sk23f1CityQxeUziuI/F0K8U0AB14i0DdHS5Ft9RaNWxa8xeiGMaq5aa
         bU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795265449; x=1795870249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a+JvEByhjl3Q0eRtUPeklA/fZjCl5bKRc9fdhPzK8Ac=;
        b=dHglI1AIBjMcjlQP6fzuI8+s1eugnkkb8tfhcdpNniwdzQAFzR+DFmYFa99uR61wYW
         4qFp1lEYWvKBmtE+m2ZLJ33NmA1XRrB9EWeDBD9rg1hkfrfDpmzFm5pTxoSNGKBM3Lc+
         udabrB8qdg+LxBTNNFtC9xfXMMsu3qOMrSTe1OBZznQpInH8fEMTdmxMN2GgLWWBp8js
         SnnLfPrr7VqV3yR8KfXMxoey9ZZW6m6PLQkmuqAeDLkF5FwmedjHU51gh6hT7zvS7G7n
         vgygmAOFM3YSMF4nYKHRddNwVh0LuHysKg/OpQRy83c5HDJ/ArYbqQQn+qhiNGQ0TsRE
         5ujA==
X-Forwarded-Encrypted: i=1; AL+hErHpEgT7GzqGVZQ45E9A3WPSy8DeshHRJhJa9YrwZPw+eqnPvl4tbUJfd/VHJSbRd+j/EV+UI9k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+T6ZQ23J5KJRFcPuWXBOCzVSxtzROewVYmH2erPGyv042AE5ov
	bbk8T3Iq8kxy7Dpl5BERRhax5sdVG2HUmBq+OSNhd4IKBKqBHk3DGV8=
X-Gm-Gg: AZFdTZfUg9w/YEkIWF4ltVLw8FjKWnd407Y3UJcc+c0frMBA/O9/Ep/zzOdXpUW4YHP
	XFaK9lh4Fbsnj7la9fo0pfbKPIF5qRjWygjxsKH/eQMIoqA/y/m1yWEDzM6v1U2gv4vwPZYGx8h
	9hfWUeQmszSCI4oHIj34Ija2nWdwX4DKeJzIPuaxeoHmugejYRuQIHBbuVHC3mhngJPliQO5Vst
	HgVynaLq0TnsYRMDYHD/oOW9JnwM6aGMhTIz/WFEypfiL06XipC20H3WGTOGuZZUJExtTESFxkM
	61m66cONAQoZcaMqCDGbWbRR0qInOuH7zu8yO5lxyuyyuuh+e/5375xZMmnHqFsf5mjcGCwGnAV
	utOPhPzSpqBdO9R32Ni8EAicWVuGg1DN8HNejLaQlpS5Poh3zkHAyMFxxqvzQEu+0OGzRpRYqeO
	5j2+3WQJQFJO8fXXROx7qfcfa9zwoSoYnFxnttJI3PibSKTSBJ3nfbWdtkaJMtCvnp4TcDfYrBL
	CilG7LG9a51tiX92LhO0cCKqrHgtvzc3fw8UVdC42flwvfdo7bNZuIQWeLS40ecDfS+azw3ah+f
	/FlFgjSETavLRbIOZLet7/DZABPcOoGRuFU1
X-Received: by 2002:a05:600c:820d:b0:4bb:6cef:d14b with SMTP id 5b1f17b1804b1-4bb887c34f1mr145440935e9.2.1795265448967;
        Sat, 21 Nov 2026 04:50:48 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm10803003f8f.20.2026.11.21.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:50:48 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KEYS: protect construct_key type dereference with key semaphore
Date: Sat, 21 Nov 2026 12:50:39 +0000
Message-ID: <20261121125039.2532663-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

construct_key() reads key->type->request_key without holding key->sem,
then calls the resulting actor function pointer.  While the
sys_request_key() syscall path holds key_types_sem for reading (via
key_type_lookup()), which prevents concurrent type removal, in-kernel
request_key() callers pass struct key_type directly without holding
key_types_sem.  If unregister_key_type() races with such a caller,
key_garbage_collector() can retype the key to key_type_dead and the
module text backing the original request_key method can be freed before
the actor call executes.

Take key->sem for reading around both the key->type->request_key lookup
and the actor() call, consistent with the approach used by 925c84e3cc21
("KEYS: Protect the read method check against type removal"),
51bcd09b9ffc ("KEYS: Protect the update method check against type
removal") and bab48a104447 ("KEYS: Protect the pkey method checks
against type removal") which protect analogous method dereferences in
the keyctl paths.

Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Hold key->sem across the actor() call, not just the type pointer read,
  matching the established pattern from the three prior fixes (Sashiko)
- Clarify that in-kernel request_key() callers do not hold key_types_sem
  so the race is reachable outside the syscall path (Sashiko)

 security/keys/request_key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 22cd66a44da56..60a8cb5924e11 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -241,10 +241,12 @@ static int construct_key(struct key *key, const void *callout_info,
 
 	/* Make the call */
 	actor = call_sbin_request_key;
+	down_read(&key->sem);
 	if (key->type->request_key)
 		actor = key->type->request_key;
 
 	ret = actor(authkey, aux);
+	up_read(&key->sem);
 
 	/* check that the actor called complete_request_key() prior to
 	 * returning an error */
-- 
2.47.3

