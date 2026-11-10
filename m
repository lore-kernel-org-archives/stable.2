Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279778;
	b=WH2SMNnF7XECuntR7l34lfVR4EFk/rh+xEEvEq8h64TUloWB+khN7awnzLOqoRvDuWwM
	 veE03WSLA8uMNnuUj0OXmw8s09IHsYPk6g0pgpaHZ2amfYU9cu16uqMRTiGAlnxa53QNa
	 G24DB4zMhHVrJH0otpGRDbZIbSvPFngcTHrtCbbsXOrvPmByCykPY49X/vMLfN54YXDd6
	 XcIcH5btONO42hq4vNnt1DpgXFv7XasI+lq/EkwhDjznnMpmCy1A4JkSbK/WgIdyaahO7
	 12Chd7PrLn3j3xFdOycZcKEUgH0RXxP6VJHiahIheBQPPKB/NuJzUeJRPhd+rW6+BGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uvXhULbVWJqoR0546lkAAtO9jiY89et4ugFZQNbKABE=;
	b=oypwDL8JGrx/q1Xs1WlHojHrbCtsaozQVUBInzLQYcbuIb6KlRGuReu5zjmVUWAl3/29
	 Op1doYSlQPIvMxZ+bBTm+rtrp9inDy1pBea9Sq2354QI7LgIhHinMF09J6wDOcQp+3Kqy
	 Kg8IqegfZsrdchxoxrynzdxXeJrniT7OrRW9vzVAVC7cVnvmI6OlD0IXyfHZLzrcAo26M
	 Zwj9NVP1phOS8mYvG2QTpvViEAyuZXIDkAWvFCTeJQ73xcex33k7J8muAFVGyOxkWFpF0
	 ow4OlfeCnZiU78tkyvm09Vf6mV95Qec+7jEPEe29XZfiia9pS4FNrsmv1cvor7JSdMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sO2sQ2FO;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95C606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA95C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sO2sQ2FO
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a058315c79so768062b3a.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 19:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794279777; x=1794884577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvXhULbVWJqoR0546lkAAtO9jiY89et4ugFZQNbKABE=;
        b=sO2sQ2FOhOHHT6BqcErMaj0hc2L2Skl9csAHkP3Xjtxy4Yghsc3EcGJTYt9475hpjn
         O4BemYVaB1klWalJcNbEmDAyhRXjAfoE8lAhfG+8ZOdY8wFy2QyOJR5kCpvRISvbsUol
         OouwS2Etha/xabW1gpThvXIxhQ0cUlHF5tw1b7Dn8a9OQzLzbdl4iF7zdeRCm9MY4lfT
         bHxNnPCrxppbpcrHTHsc1BBsaSjpdpyPmQHmieNj3vcKrKJVqb/P4waP97v9lucoqmQc
         uuR6pgPdJPZhDJDiSuzJoBRZUvJ+pe6z40IWdf5lEHogC7bDAYyoFwV90uCS2Q2R+ZBF
         XMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794279777; x=1794884577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvXhULbVWJqoR0546lkAAtO9jiY89et4ugFZQNbKABE=;
        b=K+mUSug+zxKaz6UI49caa/C55ZHsTFoIwPQZ8SP1IE5DC23CeYdccUnQ9a8YQU+cN1
         UTbJLAoApz30XPLS6JxwXYtWfs4LGa5G8HxRMhvlXHP8oYaNW7/u7eP56HzfLFzWMUXn
         wrUkYPJgt1GYnxKNVqle/drlBrO8M/VYGJL9i1+kFJcwBIHhkO8HSH0Vq22ChRjvdcDj
         3cbAR3Pk17Pdq47hBO6M7oOpgXXi86qtFTTiS012g6iXL/iJKOsvUmgMfm/iOB3DiNjU
         2gDnrpobOj1kvnGiFbO5RFhgXnYs4Tq18I0gmtdiayNkCqj7KKCSG0yuRdr2Vctt3g4v
         sy1A==
X-Forwarded-Encrypted: i=1; AL+hErE/FTmAxtfxT898niOQL7FB/4hgL14Hp4+3Ve+ufuSaiOIy048c7gQsQiLvA3NbGkIOYSTlk/U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/URSth7egq93goVa8v7CJsL22fU1y1RWf1uW9voKNV4QYNG52C
	MJwPd5iqfPEH9YygqpzMwPDcnlSNIuL9WdzLzQcjs98J+rSj/C7OjoYM
X-Gm-Gg: AYBFou1GRTeVb+2cBKzvAECzk3kpqxRyXwDLpAgunEXgab/4vtrsLvJAvEQvcfkut8E
	+GAdy3CUvLS2THyJCps8YSZ6OJR+O8wX7ffBWlqdiFc+91f+GMpKkUNRAQ6nQKg3Lx1l+alRW+m
	F8mCWO6WTXzEVrtBuivmGU0Ja9uMvFpjyLfSTL2OwPuHvOdv2w2qCoNQpdQt5vGkpPjAWvnlNZ0
	KQSsgAmq5t1xLZEfNxkmBuRBKChLLFc/1ZzjDXvXbcL+/FgogPq0Xgcxu6vV1AghoAH0wK+z0to
	3RhMOXM2P3t8NrR5Uyf7L4JOaTutq/Fzjok+vpekrHyDDDeiJnOsicHgnnmzie53Og5KgrBl7nJ
	tDWAyntA4qU2C53J7lfa3FdpGVYLrBv4sFzBt55K0xYsuU5IlXsY2Jt4S5KkrSKnCS7Tut/uF3H
	5vbNCKN1g1LdbTBq0ttfRgkDTe6CNaeMTM3WqCjNGroYdc823td46JSuZWbiMwO4a/WfDe/lVf0
	k0CFSNeGmCioKaeW4JSAEsnj8lPQN5H4P/Ctd4HPklH4CRpS+UUq8w8FwPk+cZ35EluDGhWoCME
	YWo37z6OBpMR7UUa5AlQ5ZdohiRLwlmmZHwk
X-Received: by 2002:aa7:930a:0:b0:8a0:76ea:36e0 with SMTP id d2e1a72fcca58-8ba865bf481mr1434779b3a.40.1794279776980;
        Mon, 09 Nov 2026 19:02:56 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa2a6d79sm318940b3a.10.2026.11.09.19.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:02:56 -0800 (PST)
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
Subject: [PATCH v7] KEYS: Protect pkey method checks against type removal
Date: Tue, 10 Nov 2026 11:02:52 +0800
Message-ID: <20261110030252.9979-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avJ4KM-Erci0FkgZ@kernel.org>
References: <avJ4KM-Erci0FkgZ@kernel.org>
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

keyctl_pkey_query(), keyctl_pkey_e_d_s() and keyctl_pkey_verify() check
that key->type has the ->asym_*() method they need and call it later,
without holding key->sem.  A reference keeps the key alive, but does not
pin the module that provides its type.

When that module is unloaded, unregister_key_type() waits for the key GC
to process every remaining key of the type.  For each such key, the GC
takes key->sem for writing, switches key->type to key_type_dead, whose
->asym_*() methods are NULL, and destroys the payload.  If that happens
between the check and the call, the keyctl calls a NULL method; if it
happens while the method runs, the method returns into freed module text.
In-tree, turris-signing-key provides ->asym_query() and ->asym_eds_op()
and can be built as a module.

Take key->sem for reading around each method call, and check the method
again under it, right before the call.  While the lock is held the GC
cannot switch the key to key_type_dead, so unregister_key_type() and the
module unload cannot complete until the method returns.  If the type is
already gone, the check finds key_type_dead and the keyctl fails with
-EOPNOTSUPP, as it does for any key type without the method.

memdup_user() and copy_to_user() stay outside key->sem, as in
keyctl_read_key(), so no page fault is taken with key->sem held.  The
in-tree ->asym_*() methods do not take key->sem themselves.  Nothing else
in the kernel calls these methods, so these four call sites are the full
coverage:

 - keyctl_pkey_query(): ->asym_query() for KEYCTL_PKEY_QUERY
 - keyctl_pkey_params_get_2(): ->asym_query(), and the op-specific check
   for KEYCTL_PKEY_ENCRYPT, _DECRYPT, _SIGN and _VERIFY
 - keyctl_pkey_e_d_s(): ->asym_eds_op() for _ENCRYPT, _DECRYPT and _SIGN
 - keyctl_pkey_verify(): ->asym_verify_signature() for _VERIFY

This problem was recently fixed for keyctl_read_key() by 925c84e3cc21
("keys: Protect the read method check against type removal") and for
key_update() by aef3a8a4f988 ("KEYS: Protect the update method check
against type removal").

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: stable@vger.kernel.org
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
---
Changes in v7:
- Restore the early ->asym_query() check in keyctl_pkey_params_get().
  Removing it was not part of the bug fix (Jarkko).  The function is now
  identical to 7.4-rc1 again, so the diff does not touch it at all.
  Sashiko flagged that unlocked read on v5; it is pre-existing code and
  is left alone here, as asked.  The locked rechecks at the call sites
  are what the fix relies on.
- Make the commit message more compact (Jarkko).

Changes in v6:
- Address the Sashiko review of v5: keyctl_pkey_e_d_s() and
  keyctl_pkey_verify() still read a ->asym_*() method pointer without
  key->sem in their early checks.  Move those op-specific checks into
  keyctl_pkey_params_get_2(), in the same key->sem critical section that
  calls ->asym_query(), and after the buffer size validation, so a key
  type without the method still fails with -EOPNOTSUPP before
  memdup_user() and the error precedence is unchanged.
- Drop the LLM paragraph from the commit message (Jarkko).

Tested on x86_64 under QEMU/KVM, with KASAN, lockdep and
DEBUG_ATOMIC_SLEEP, on 7.4-rc1 with and without this patch.  The
test-only key type module is not for merging.

  race_sign, race_verify: the module is unloaded while the keyctl waits
  in memdup_user() after the type check.  Without the patch: NULL call
  from keyctl_pkey_e_d_s() / keyctl_pkey_verify().  With the patch: both
  return -EOPNOTSUPP and delete_module() has returned first.

  inop: the module's ->asym_eds_op() sleeps in module text while the
  module is unloaded.  Without the patch: return into freed module text.
  With the patch: delete_module() returns only after the method has
  returned (about 3.1 s).

  func_asym, func_fake: KEYCTL_PKEY_QUERY, _ENCRYPT, _DECRYPT, _SIGN and
  _VERIFY on a real RSA-2048 asymmetric key and on the test type; the
  CASE lines are identical with and without the patch.

  errno: a type with ->asym_query() but no ->asym_verify_signature()
  returns -EOPNOTSUPP before reading the input; a request with an
  oversized length still returns -EINVAL first, as before.  The CASE
  lines are identical with and without the patch.

In the forced races lockdep can report "bad unlock balance" for
key->sem.  Its lock class is the type's lock_class, which lockdep drops
when the module is freed, so any key->sem user on a key whose type was
unregistered can hit this, e.g. keyctl_read_key().  KASAN reports
nothing.  Not tested on Turris hardware.

v6: https://lore.kernel.org/all/20261109055204.31673-1-0xbeac@gmail.com/
v5: https://lore.kernel.org/all/20261108131417.77287-1-0xbeac@gmail.com/
v4: https://lore.kernel.org/all/20261105193632.34363-1-0xbeac@gmail.com/
v3: https://lore.kernel.org/all/9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com/
v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/
v1: https://lore.kernel.org/all/20261103032940.51826-1-0xbeac@gmail.com/

 security/keys/keyctl_pkey.c | 100 +++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 24 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399..e7121523b9 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -129,45 +129,77 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	if (ret < 0)
 		return ret;
 
+	down_read(&params->key->sem);
+
+	if (!params->key->type->asym_query) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params->key->type->asym_query(params, &info);
 	if (ret < 0)
-		return ret;
+		goto out_up_key_sem;
 
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 		if (uparams.in_len  > info.max_dec_size ||
-		    uparams.out_len > info.max_enc_size)
-			return -EINVAL;
+		    uparams.out_len > info.max_enc_size) {
+			ret = -EINVAL;
+			goto out_up_key_sem;
+		}
 
 		params->out_len = info.max_enc_size;
 		break;
 	case KEYCTL_PKEY_DECRYPT:
 		if (uparams.in_len  > info.max_enc_size ||
-		    uparams.out_len > info.max_dec_size)
-			return -EINVAL;
+		    uparams.out_len > info.max_dec_size) {
+			ret = -EINVAL;
+			goto out_up_key_sem;
+		}
 
 		params->out_len = info.max_dec_size;
 		break;
 	case KEYCTL_PKEY_SIGN:
 		if (uparams.in_len  > info.max_data_size ||
-		    uparams.out_len > info.max_sig_size)
-			return -EINVAL;
+		    uparams.out_len > info.max_sig_size) {
+			ret = -EINVAL;
+			goto out_up_key_sem;
+		}
 
 		params->out_len = info.max_sig_size;
 		break;
 	case KEYCTL_PKEY_VERIFY:
 		if (uparams.in_len  > info.max_data_size ||
-		    uparams.in2_len > info.max_sig_size)
-			return -EINVAL;
+		    uparams.in2_len > info.max_sig_size) {
+			ret = -EINVAL;
+			goto out_up_key_sem;
+		}
 
 		params->out_len = info.max_sig_size;
 		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
 	}
 
 	params->in_len  = uparams.in_len;
-	return 0;
+
+	switch (op) {
+	case KEYCTL_PKEY_VERIFY:
+		if (!params->key->type->asym_verify_signature)
+			ret = -EOPNOTSUPP;
+		break;
+	case KEYCTL_PKEY_ENCRYPT:
+	case KEYCTL_PKEY_DECRYPT:
+	case KEYCTL_PKEY_SIGN:
+		if (!params->key->type->asym_eds_op)
+			ret = -EOPNOTSUPP;
+		break;
+	}
+
+out_up_key_sem:
+	up_read(&params->key->sem);
+	return ret;
 }
 
 /*
@@ -185,7 +217,16 @@ long keyctl_pkey_query(key_serial_t id,
 	if (ret < 0)
 		goto error;
 
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_query) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params.key->type->asym_query(&params, &res);
+
+out_up_key_sem:
+	up_read(&params.key->sem);
 	if (ret < 0)
 		goto error;
 
@@ -230,10 +271,6 @@ long keyctl_pkey_e_d_s(int op,
 	if (ret < 0)
 		goto error_params;
 
-	ret = -EOPNOTSUPP;
-	if (!params.key->type->asym_eds_op)
-		goto error_params;
-
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 		params.op = kernel_pkey_encrypt;
@@ -260,7 +297,16 @@ long keyctl_pkey_e_d_s(int op,
 	if (!out)
 		goto error_in;
 
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_eds_op) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params.key->type->asym_eds_op(&params, in, out);
+
+out_up_key_sem:
+	up_read(&params.key->sem);
 	if (ret < 0)
 		goto error_out;
 
@@ -305,31 +351,37 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	ret = keyctl_pkey_params_get_2(_params, _info, KEYCTL_PKEY_VERIFY,
 				       &params);
 	if (ret < 0)
-		goto error_params;
-
-	ret = -EOPNOTSUPP;
-	if (!params.key->type->asym_verify_signature)
-		goto error_params;
+		goto out_free_params;
 
 	in = memdup_user(_in, params.in_len);
 	if (IS_ERR(in)) {
 		ret = PTR_ERR(in);
-		goto error_params;
+		goto out_free_params;
 	}
 
 	in2 = memdup_user(_in2, params.in2_len);
 	if (IS_ERR(in2)) {
 		ret = PTR_ERR(in2);
-		goto error_in;
+		goto out_free_in;
 	}
 
 	params.op = kernel_pkey_verify;
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_verify_signature) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params.key->type->asym_verify_signature(&params, in, in2);
 
+out_up_key_sem:
+	up_read(&params.key->sem);
 	kfree(in2);
-error_in:
+
+out_free_in:
 	kfree(in);
-error_params:
+
+out_free_params:
 	keyctl_pkey_params_free(&params);
 	return ret;
 }
-- 
2.43.0

