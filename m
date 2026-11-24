Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540456;
	b=vo2TWZcKdXXJaBHdlHm3Atfn6sFCH7V7ICYcEJmaaEGiIkrfdzK2nPTSoeURLzjOb6rW
	 bPD7u+4lgoBA85qRK27yL0ZSYKgcoJkw1BjBr4mO62t3ClM0g0zpwJKEfFq+7nnBykr27
	 JolNJeAWcnjBmoE/wilQSZpeLdaVU3Jp01FfF1UhB+Yp8K7jfJKuPWoXT8tNQ92EYt6Oz
	 tmV+b3/UtigehclszGNWC8McUXj8MFNZIZtos+C4zkE4i7C4jmPBwVI1R3/qOdcbNbV6r
	 VezSRDFY4Y/tH4yfx6vNEroCZ6QDO/Xlbqun02kLL52ZkZyBtkIf/ppl8D0nuCjYuMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540456;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kFTNabQtDL8NHvywAjkEy5v1oK3QmEloNZ6WNxs+EVY=;
	b=iQ+n+I7OSK49S7GiB5MRDwo8tedm8RvGnpFZBMpnUVXAh59Gec4gooveTTUHxFQXOhSE
	 ThTpOu5PGPxeOirHXk7FS0Q1WnxGmc7ke6Q37ax49OJbFSRl6BKPca2WMpM/BEdYVqLBa
	 KNwHyN/1H91jKicEb+PE4ayMTS7Gk/lsH+mJsui5UYo3am0tnDihxoELUTDmtWzQkJj96
	 3S+5oMFHhJy7SpHu4NiE5XBwxG/FaH7Rt2Hfvk+mctm9GZhDmQYCBZsr+ygHzMPZsM/e+
	 I2SJuVbQGuTZspoNZgd3/v8oi3m0xkORKjaiLdptldbwN0vjUdOwAZTUR/eSOJM6Y4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=it173FnN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB772606A32C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=it173FnN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1443E1F000D3;
	Tue, 24 Nov 2026 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540456;
	bh=kFTNabQtDL8NHvywAjkEy5v1oK3QmEloNZ6WNxs+EVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=it173FnN5o8V6DLuUH9ryfAqotUxcyMKP3qjjYR4DFeBIwuJQTF/imvXaCfsrF8jI
	 DgC0F9ER7wO+v/1IiAWcuC7oluiNKWRY3Hz8Un5p09dKDquXlprgI0iL5xlBuICZFZ
	 IqFbwilA6iq+xbW+eYOXcJiIRHJrGWqKP48Tm834LMwxLsZuHtKyN+l9Kvn+h30Ud0
	 u58KrJZs9z71NxxtUP/Ub00y9f9cCSi9yDgfc3lH7xW9nFoWoSCbe52q80bAkbeVOx
	 wj8AfE8+sI0kGnTFrVAejltDT7h9dcbLoaq8S/TV+3Tk0LyLv9bYwx4cxOr5WpUy5F
	 cS/fjizulvWjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuansheng Yang <0xbeac@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] KEYS: Protect pkey method checks against type removal
Date: Tue, 24 Nov 2026 12:14:13 -0500
Message-ID: <20261124171336.1722903-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124171336.1722903-1-sashal@kernel.org>
References: <2026112439-grope-bankroll-ba51@gregkh>
 <20261124171336.1722903-1-sashal@kernel.org>
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

From: Yuansheng Yang <0xbeac@gmail.com>

[ Upstream commit bab48a1044475f62d6e910c6d7267ce4bae847f9 ]

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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20261110030252.9979-1-0xbeac@gmail.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/keyctl_pkey.c | 100 +++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 24 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399b59..e7121523b9c9a 100644
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
2.53.0

