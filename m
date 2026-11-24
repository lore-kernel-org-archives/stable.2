Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532426;
	b=FIM8b6Eox/5VVz8BRuEr8yOSFkNiZpx+7jfoMO3tkw4H0/nZFveEt29N60hZmZOXRG25
	 NWsTEZW3GD6pZJMOnYpOvSp9HEXT7BTs3VTbvQXA/L796zzBhOLU27Bq3yLUmRwu/8qHV
	 pNk3nJdfHKbw8c275/ML/wsy/gm1Eyc5SgCDcWeo4XDQCa6ylUDwjRcdT1/fJ0I0AZIGL
	 /L+mFoNt99nragYrsmtvjIsHV7rP/GrB5SefOYzZsYfV+PVrTFl4/HvPGSKadCC1zDZ7r
	 AQBJpJKrd/8A8Zis70YjYtYqronpITJTUePsdJTtaY6XVBvqfKc6uPd7XEf5Ccsmw2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532426;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4N7AbHRVYUMZvbDZ7R7cGsiI99gl8xDWtEKNRPeUsFI=;
	b=hBQVqJEeM+Zb3+yjRucFbe8VqiT8cc9TMLgts+ybJSkx9rK0MhyiB4T1Y015IIPJHejs
	 GZTUY5+4qHXzTzG0HG0g8P1VfXR4xff+W79XjbbNDSOUOV9ETfo1v4UjaR+H7knEb2Zkb
	 CxmVpsJxLu22u6rA1DsaufcPYNCl9kQ5r+VyxGhs6Up0usVDZE+icjyLpUy7G+SJhIXmH
	 EY+6/AEpz+bkDviCaYkJJw64lHNgJ/alI+ZU03GK/7/HQDwDsK7/B2cyVdhLnB7q5vq8v
	 0XOJuwi59EOl5tvJitfxWbw77apBy6KiqNxEPmQYRGMR5GrYX1KlQ6Bm5A1AuQmWM1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0mYjT9yj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFA606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0mYjT9yj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450761F000F0;
	Tue, 24 Nov 2026 15:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795532425;
	bh=4N7AbHRVYUMZvbDZ7R7cGsiI99gl8xDWtEKNRPeUsFI=;
	h=Subject:To:Cc:From:Date;
	b=0mYjT9yjIrXpkilbT/pK6QwKAVcbCOiCl9+zUqFyrypmJ9kBG06x0Q8TxplBIu7ps
	 Ykb51hv2ttZzXws+Md4uZLoHv90IPtVIF47vd3wya33N1zXmx0xZZNvjjP/fFJGdNv
	 oi6BwUPEXYi4LBmaqa4Ye4aIUD1xX/1Ui3Qja8bk=
Subject: FAILED: patch "[PATCH] KEYS: Protect pkey method checks against type removal" failed to apply to 6.6-stable tree
To: 0xbeac@gmail.com,jarkko@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:00:38 +0100
Message-ID: <2026112438-freezable-bash-6910@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x bab48a1044475f62d6e910c6d7267ce4bae847f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112438-freezable-bash-6910@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bab48a1044475f62d6e910c6d7267ce4bae847f9 Mon Sep 17 00:00:00 2001
From: Yuansheng Yang <0xbeac@gmail.com>
Date: Tue, 10 Nov 2026 11:02:52 +0800
Subject: [PATCH] KEYS: Protect pkey method checks against type removal

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

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399b5..e7121523b9c9 100644
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

