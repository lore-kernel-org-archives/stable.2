Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468818;
	b=jRRmF6Sw73YQivr8PxNk1ODqv6v30QXBedO6HoUHIR24QZbt/oNfakBYB7S9ucaQhzpt
	 LS+X8heyjiBHL5DWNoEa/LUSuHf91n5SvGIO/zC3X8o82l3XzhPIer+XuivRI6/r4/Cfp
	 dqtuSq75mcp85p//9xFZU6NIL3FBHF/RxqI8/Rb8CTa5k7GOfE0+pr2wQBDsUwa22K/7u
	 ohrLD4FhflRCptkY9YqJWPYEQyAZsYzDvqsLv5UpIYZjaVkA5IDGzEv/2ic8TB4W9tX7l
	 u5/GGAglYDvkasCrdAmgUMUBaWlBzGgJxGvXQnzEwxXOAePLZf0vfrVMKt/ZWcTSOOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468818;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aS3f8fmnMsiBklo3ZGwbxztH+5WpTBX/rTdQq2vKU8o=;
	b=kav4HK2kE4ZvnsGXiWEMyTpuQ70z6gxya+p26arF81L6YfTOdBCvmbM3+8QIEft4/9AV
	 2LQ/9Q8B10mu2G17tE1P5HsJC5oMkmIfvFnxVIS5DGqqH0sm8XB7rTkLllbT4RUI2YVfJ
	 RqvoXoo+xJhuuLvKb8aYaOXNApJMCYVWX3ywlnIGITL7Y709IGT1wPYog/Bm54HjqgC+1
	 rM2gCqukr7LnQU+GvwaEN7W3WR1x/A6qHD1vg5XIYLI/wKPV8BngAEfoBFXvowDRCZGZE
	 fgMG7cny2bmIEHxmJOW3ZyTW8TYJDZTc7Bp+iNE/aEQMOjP+vnS0rhNiAgUyEp7oLuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZG62TXU0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 80AA9606A31E;
	Mon, 23 Nov 2026 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZG62TXU0
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C89EA1F000EC;
	Mon, 23 Nov 2026 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795468818;
	bh=aS3f8fmnMsiBklo3ZGwbxztH+5WpTBX/rTdQq2vKU8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZG62TXU0aLHx7cl8lQwuF92wTnZJF7mLMKmOgGamFulkP7BhKnjaIEkrdUaYjcKtw
	 KsmW+vCrduRM2ihi2Ji+7G1Y4RJX1a0YvS77AlENFW+6U3yHeOjaDkf+TZlYmFXz2o
	 kpSpN3xHGKiu4kJ4OwAvJy0PdbBZsJoeGDXpXGN76k/aPgWDmkFjhqzTXUa7AXwLEi
	 lWlG2vCavPRyiEq2P9uuIy7Rw6RgrTlmvv1iIk9baZyl06/4gSJ0JAlg8LKp42+S7b
	 1sW41CCjdM9dP0L62wXPmPty6fstsOtB4pVa3iPSZ6UcOs0oBhj14klKWflpYn0frT
	 tffUs2oJPA5kw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Guicai Ma <maguicai@kylinos.cn>,
	James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] KEYS: Fix userspace buffer overflow in keyctl_pkey_e_d_s()
Date: Mon, 23 Nov 2026 23:19:58 +0200
Message-ID: <20261123211959.4102708-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123211959.4102708-1-jarkko@kernel.org>
References: <20261123211959.4102708-1-jarkko@kernel.org>
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

From: Guicai Ma <maguicai@kylinos.cn>

Commit cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
changed keyctl_pkey_params_get_2() to set params->out_len to the maximum
output size of the operation instead of uparams.out_len, so that the
kernel buffer allocated in keyctl_pkey_e_d_s() is large enough.

Because uparams.out_len is no longer kept, keyctl_pkey_e_d_s() copies
ret bytes to _out without checking whether the result fits in the
caller's buffer. If a smaller out_len was passed, copy_to_user() writes
past the end of _out instead of failing with -EOVERFLOW.

uparams.out_len cannot simply be required to be at least the maximum
output size in keyctl_pkey_params_get_2(), since KEYCTL_PKEY_DECRYPT
with enc=pkcs1 can return a plaintext shorter than max_dec_size into a
matching smaller buffer.

Pass uparams.out_len back to keyctl_pkey_e_d_s() and return -EOVERFLOW
before copy_to_user() if ret exceeds it.

Cc: stable@vger.kernel.org # v7.2+
Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
---
 security/keys/keyctl_pkey.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index e7121523b9c9..b5f82804b5ad 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -113,7 +113,8 @@ static int keyctl_pkey_params_get(key_serial_t id,
 static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_params,
 				    const char __user *_info,
 				    int op,
-				    struct kernel_pkey_params *params)
+				    struct kernel_pkey_params *params,
+				    u32 *user_out_len)
 {
 	struct keyctl_pkey_params uparams;
 	struct kernel_pkey_query info;
@@ -183,6 +184,8 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	}
 
 	params->in_len  = uparams.in_len;
+	if (user_out_len)
+		*user_out_len = uparams.out_len;
 
 	switch (op) {
 	case KEYCTL_PKEY_VERIFY:
@@ -264,10 +267,12 @@ long keyctl_pkey_e_d_s(int op,
 		       void __user *_out)
 {
 	struct kernel_pkey_params params;
+	u32 user_out_len;
 	void *in, *out;
 	long ret;
 
-	ret = keyctl_pkey_params_get_2(_params, _info, op, &params);
+	ret = keyctl_pkey_params_get_2(_params, _info, op, &params,
+				       &user_out_len);
 	if (ret < 0)
 		goto error_params;
 
@@ -310,6 +315,10 @@ long keyctl_pkey_e_d_s(int op,
 	if (ret < 0)
 		goto error_out;
 
+	if (ret > user_out_len) {
+		ret = -EOVERFLOW;
+		goto error_out;
+	}
 	if (copy_to_user(_out, out, ret) != 0)
 		ret = -EFAULT;
 
@@ -349,7 +358,7 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	long ret;
 
 	ret = keyctl_pkey_params_get_2(_params, _info, KEYCTL_PKEY_VERIFY,
-				       &params);
+				       &params, NULL);
 	if (ret < 0)
 		goto out_free_params;
 
-- 
2.47.3

