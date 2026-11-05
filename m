Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853508;
	b=MhQbkonjoKLUjybKb3Z43EbgBnE1YTrGW6wjUYWU84o6b5SvBIkhQEYzTTFnyWPskOBX
	 1pGhFqfiI0TKr9km4A7JbPGAc0k7pFyXNIyDNXFe0WWTemt852LhMM7hMp21I1UO9eNtV
	 kqCEoPjMb1EtX1auspaonDugA9BJO9TytpSvFFYy6/WumtybkQYTvC5otxRvsCEY/woWi
	 lmRiq2InhokO42a3Qn/+YDhamY6Q8WMlDvf229wESvUZtrsHnkvvWHceviFTfO81RyKkf
	 rfzGDgZY7SSbSFXYckum1ypy2limEUFBZjHWKMxcZUWtjuhxBBuAL6VG0Rclv4P/0aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=48V+VsvijFUjy1EizLIiYaKYQ847uo8vE4JKf+yBXAY=;
	b=e9kwope6aItOJm68Y5kJGo4SzXhz5uZRK+x7TYJP8lA8dQH2a5hTfn22W1HsZJ1iIuz8
	 UzghTU1NJb3uZTujigUMMzv87J7VDi+rcENffMCDhcAx1iTyajdB7F/blPYAJoWtB0Mnq
	 R7b1rU9LoK1wRMt9B70QHjR8SznlWD2/9vMmrkqKWiDpi9U/Meoenvo1TcmZbdZnuhyed
	 RF28Dv0X99ZBkY3PfyjX4OmDBvgkiUrEM5od+hwJ6AxKELb8xBDgfIRyCjQK1qAq22Q5A
	 To6DuQv6W69slcEGU3BoN9cTSS3x/kw4+7fhmOJl6aQUPu1Fux1P7gcdDThF1UnJQDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xzTtXARL;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CA3606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10CA3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xzTtXARL
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso712508a12.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 20:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793853507; x=1794458307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48V+VsvijFUjy1EizLIiYaKYQ847uo8vE4JKf+yBXAY=;
        b=xzTtXARLYN2RESb9u7JaWRcCOM9339Cll6gqB99I1UayC7NyCgiTKuUW6GDmIAHgIZ
         b6+fS+ZVhOYVrbQ3NeDTwCyKGGRvQhCILna9fWmgbYCFSwoTPEwlm6Wiqx36ieXo45yX
         N9Ng7JDJ4qTizFRVnDg8+iSMuL+HfGBifN3F5RTplq/Y8XuXNl7vNHkQamYdiDVqUvfA
         Ds4cos1dhugMquQGnqYY96Czi3UXL+FFaS67DA5bkNppMCgQmlacH+VrAk64Qqk8S3Dv
         d6OwVYGaRiouE19l+vWv2kPfHUe7ykXVpe9OelXFuLwTQqHq9/rVCZ4lqYAKhzRsTauc
         lQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793853507; x=1794458307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=48V+VsvijFUjy1EizLIiYaKYQ847uo8vE4JKf+yBXAY=;
        b=CBLndS6NfUP9VGabhVqqueBm3o6TRiPa+lGhtgLB9B08H6vKbN693toDwi27ADBi9d
         jfQk4VZ9VPfSBn9FLm989yRyKvewgs0OfgzKJqGhKrsthB4+NQd7EaA1/rSQwvDUZXfa
         Z+0moQsy+EFqc4/lA/AK4LXerAQvPtsCmnYAR/NWwx++tiaVZzfIPF/PJ3OBEw8puUqU
         26oDyqYRg94w7dSDKSGWatZ1/1SSt0FBMJbu6zRcyMCeDG2LMPebhF0vzbzqsO/bBjgd
         tUHSsc0boXYygIYzrCpr/SmSwvzxG7SXZayOhpwMhV2NRt3TpjJs04rRLKsmQoTsW5ca
         xhKg==
X-Forwarded-Encrypted: i=1; AKwUvBy5++BXvxWKZ8OoO+99mNwnMFi377hOtAwU6oPbi5u49VmKPO8KzeiPtDh8pqQhAUS494QwGB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fPPppA6LvGgOGU3SdyiEBxOEhfe9wM2H2/yDlNQX8DJ742ros
	sL+MHLxC9UZPAcSliuczvDgz8RGAK3i84tvSaGaKEFZ0E5pVHcJRNhoR
X-Gm-Gg: AYBFou2S8Y4FWThwi2B4/xhacZ+VNirlagfM+mn44rQ8eOTt2zplcVcyHhuSvLB+PR4
	AboqJkIUUaLMSY6yQKFJd364zZpptioocimKxkxlRWfxMp+dj4HhpaAXJ+iOyP+bQXT6OmKrCYu
	XDnRFeEPfUXDnD+6FKFs5x9Wij9d46tbQyYnSLxxJ8GPm5+Y2goIKzd2P9huMUw8a12jUADWu2U
	bBOKK4QPANJCNt1FaJ8sJ8R2xxvR9wAuggr/oudwRvJ60FssrfR+SuKqE0tXUx5JDVOopau+yrj
	Lu3OuQO7OxxgjZ82WLNGTdfXGyZmCps9KWiRiqm1R5vQcccKiHy039Ypxl+5mGT/1xzHWJjrW/X
	qa7bNa2BBUgGEzApceCMGfndF13CXlbEmz+n64g+gKtK/BI2qmIoMAGIBPjBfuzqQKB0GoE+JqI
	9TW+tHh9bmZXKOjVBpgi/UYGBPRFVw7WzKY3ykm7dz2VxOcyAaLEbl3zXNApMtkpTptdXctmjGg
	WiT0Bf95mG27tL5gtoXervmI/QgU5EeKBuO5gH2AyBxjJSPe2DkAx8lSxrYSGtWywDhKnphF73L
	gPpUKmevzV0ON2N8q915q+wCh7TTCak4VgaQGHDoY5dq75Q=
X-Received: by 2002:a17:90b:4c08:b0:3a8:de1:db07 with SMTP id 98e67ed59e1d1-3ae8957d253mr16261437a91.5.1793853507248;
        Wed, 04 Nov 2026 20:38:27 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3280378sm1635751a91.12.2026.11.04.20.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:38:26 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] KEYS: Protect pkey method checks against type removal
Date: Thu,  5 Nov 2026 12:38:21 +0800
Message-ID: <9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auv35Ljgz1OA1zUZ@kernel.org>
References: <auv35Ljgz1OA1zUZ@kernel.org>
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

keyctl_pkey_params_get() looks up the key, and keyctl_pkey_query(),
keyctl_pkey_e_d_s() and keyctl_pkey_verify() then dereference
key->type->asym_* outside key->sem.  A reference keeps the key alive, but
does not pin the module providing its type.

unregister_key_type() calls key_gc_keytype(), which retypes every
remaining key of the type to key_type_dead under key->sem for writing.
The pkey paths read key->type again after their checks, so a concurrent
module unload can turn the checked callback into the NULL key_type_dead
member and call through a NULL function pointer, e.g.:

  KEYCTL_PKEY_SIGN task              Module unload and key GC
  ------------------------           ------------------------
  keyctl_pkey_e_d_s()
    if (!key->type->asym_eds_op)     unregister_key_type()
                                       GC: down_write(&key->sem)
                                       GC: retype to key_type_dead
                                       GC: up_write(&key->sem)
                                     free_module()
    in = memdup_user(...)
    key->type->asym_eds_op(...)      -> NULL call

In-tree, turris-signing-key provides such methods.

Hold key->sem for reading around the method check and the matching call,
so that the type cannot be retired in between.  Each keyctl handler takes
and releases the lock itself; the semaphore is not passed out through the
parameter block.  User buffers are copied outside the critical section.

This is the same type-removal problem recently fixed for the read
(925c84e3cc21) and update (aef3a8a4f988) methods.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: stable@vger.kernel.org
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
---
Changes in v3:
- Keep the switch, allocations and existing error handling in place.
- Use one unlock point per method check/call pair.
- Set -EOPNOTSUPP inside the failed checks; add blank lines before labels.
- Use my real name in the author and sign-off fields.

v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/

 security/keys/keyctl_pkey.c | 47 ++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399..40475817dd 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -100,9 +100,6 @@ static int keyctl_pkey_params_get(key_serial_t id,
 		return PTR_ERR(key_ref);
 	params->key = key_ref_to_ptr(key_ref);
 
-	if (!params->key->type->asym_query)
-		return -EOPNOTSUPP;
-
 	return 0;
 }
 
@@ -129,7 +126,16 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	if (ret < 0)
 		return ret;
 
+	down_read(&params->key->sem);
+	if (!params->key->type->asym_query) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ret = params->key->type->asym_query(params, &info);
+
+out_unlock:
+	up_read(&params->key->sem);
 	if (ret < 0)
 		return ret;
 
@@ -185,7 +191,16 @@ long keyctl_pkey_query(key_serial_t id,
 	if (ret < 0)
 		goto error;
 
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_query) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ret = params.key->type->asym_query(&params, &res);
+
+out_unlock:
+	up_read(&params.key->sem);
 	if (ret < 0)
 		goto error;
 
@@ -230,10 +245,6 @@ long keyctl_pkey_e_d_s(int op,
 	if (ret < 0)
 		goto error_params;
 
-	ret = -EOPNOTSUPP;
-	if (!params.key->type->asym_eds_op)
-		goto error_params;
-
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 		params.op = kernel_pkey_encrypt;
@@ -260,7 +271,16 @@ long keyctl_pkey_e_d_s(int op,
 	if (!out)
 		goto error_in;
 
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_eds_op) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ret = params.key->type->asym_eds_op(&params, in, out);
+
+out_unlock:
+	up_read(&params.key->sem);
 	if (ret < 0)
 		goto error_out;
 
@@ -307,10 +327,6 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	if (ret < 0)
 		goto error_params;
 
-	ret = -EOPNOTSUPP;
-	if (!params.key->type->asym_verify_signature)
-		goto error_params;
-
 	in = memdup_user(_in, params.in_len);
 	if (IS_ERR(in)) {
 		ret = PTR_ERR(in);
@@ -324,8 +340,17 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	}
 
 	params.op = kernel_pkey_verify;
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_verify_signature) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ret = params.key->type->asym_verify_signature(&params, in, in2);
 
+out_unlock:
+	up_read(&params.key->sem);
+
 	kfree(in2);
 error_in:
 	kfree(in);
-- 
2.43.0

