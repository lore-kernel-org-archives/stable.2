Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997082;
	b=mm9kEasi5qfhVwp2eQCo16KPeZYixFk2+ObQ/e9o8wAt9c0guxxv70SLlm4D0wAewl84
	 6hE+Vo60u5zttL0OOkk0IUvEn28+5vRE4vpCEpFSEOYs72KtwrBDgIpXmt3KjN3I9M+oj
	 dSJe5G9RYpF6imo3WigLaF2dM+WYRJZogFNOVI/VWyTX3AF5z6svOrx8U8dyPsr9pAmGU
	 XwyZ2AU3PjF3dKs77by1Mc89A7Eu+kYrxhl02dwl2kr8MvO0qmlqM0OigjARxmBSjVC1z
	 pVcuTckKLzozH0mT8YlmUDs0B4d9E1y7tO2Ak2HSDSdE9rNH50q3R066DgC9VjcdvFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m9nxtzxZNBF3WBJsdKrWnkE6fbrAAwaEK/yK704NFP4=;
	b=2FXh7BCZdUBipMs4czwYPatg71VqjTUDwo7c1J6L7tCJYoX1a2A3DnUp2RnvnKVqxAyA
	 yIfOcN/pIpZ/VJCMGpCi4gYyucxWS3N4GQqQDVyxBOvP9ZNVh+RUuToCS2wdixFfmORW0
	 7Dlzn0E3wqxRmPFUpEVyFbGPn+wGT/S6rwVp2/Rh9zfmYiDARw/it1cB+umdfWt2YnPyf
	 +/vI9dik8B9gn9Qf3Zb5E3egqX/UP2Jip2RaCcGLAPJzwVdV7MTq9K3LpEOsmt+T7Y8GO
	 y3kos9K6CDEEk0D4/6xyE00JK5nwBMJKu+OIVb6SIisj5GQBvQWogJ+iY7EuumHx++g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ob97kGp5;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A9606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A11A9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ob97kGp5
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-71ae5389c00so541613eaf.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794997080; x=1795601880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m9nxtzxZNBF3WBJsdKrWnkE6fbrAAwaEK/yK704NFP4=;
        b=ob97kGp5SBgiDnJ3pS1DBEfZvQ7EMm+NKaQK7Kq65fETrLQz2J/d/L2Oe0iz8lWAjV
         JoWUp5mVskJ6KtyWFqGhevJjN8Lz+WDioQwWZt/QLQnjUv2WSjDx8Pk3Q33mdoyTTn4Q
         PEq2dLl1xR33OfscDqznt7CY3ijlNUxEavNB8x2lyN4chZ+hbIq29Jn3lSpS3Zm0Av/5
         kGajT0l/vOCbw9KsnRu+1nwq7NbXSYgvAgTc2Hm32GhDnhNYXD7qwtA94Dxc9M4pDnbN
         4szFO4DhKs9aehLR82LkT0wdw+MCDqwKdPubc0vu933kJ9nOMCpOuO+/8IWsEZf0Nflr
         lM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997080; x=1795601880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m9nxtzxZNBF3WBJsdKrWnkE6fbrAAwaEK/yK704NFP4=;
        b=Yy03UAAGIhKSCwwgVWVJXkQZt807sRoSutSmdduNIZUW8p/jBZ4GSOMPiYpGR2efNc
         yrtvrksJI93PN754Yxu2/27a0DS5Stn4YH5FcqfxPOt9MIfU0iA3WLJXxbVjlpFLyfVs
         zGXuxCPzP8eU23CHtcq3Td2WVOevPEMv0EE5WvlsOcjMDTkaR2D4BxVYcrktHIjlN7/W
         xfw0dq4+hIEYxeJxvuD5MIhVb68VEYksjD7ZJBoSac6IHQj+eHoaCfgPnvPnWabCFGKq
         aVfRj2dabIvaMz6L8rM0r908g87ONt8fUs0CJtvUj3Z08bVUd1O8A0n080d8UWPOJKSl
         hyBg==
X-Gm-Message-State: APuU4Z8P5eXtZ+lProFBJVxW/OgfcASnraBhdHtbGSNW1ilGvNg9zTaM
	kj5zs1u6WhxY2afgw2FKwV3jxQntEptGIauEGZ1NVZdUP3Piv2gcrJNmxw5LZ0rLd/A=
X-Gm-Gg: AYBFou3DJZQ2dtwNFwFdgxurhg7HCRc/61NhLsOcRh+XDE1CDSQYEe047lIkAN3dHxs
	Q4D/8Nwnza1O40FL1/OkYJFoJlUlzmPqjNiKow1KG8atUQ6lopassxntCXHAn+RqMHjAs/6H8BU
	2YFEcc0DjAkw7hfKRWcjVPa0dvqPslMdAsDLtvXB6zZQu3BBIJAxjsd8HLVN1fY0KSFZUJB6fSo
	uC1ocLP9suPJjlSTgSVAwLKG8xtrXw+tnQZ7yLbTiH7YSexPGA0Nj2huC2ihrkj6VXMuLxVwrem
	lg+01B4AN72vPgaNkJML8y2qNT+TAUxRAq+v6sdwSvQQXfUztt4hP6IfTQ2c81vBwh+Lhtd2LgQ
	8nsjG4+BD9IP4V/WRlXvdzIp9ApEcYXYN7kl42I7ND/zh1eNPo4ZOhq3TyOFCNo2qORffRzrttm
	TkETSfzONp9113vBd6ErzSXCKOmIofg1L7jABK41IoE9MHVBvzQlZqxl8N5/xi32ZLUK7Wy1bjy
	kS1UPv1tZkSoiQ6q1Q69xyZUjlQQvpvI4EgoW3UxqEFm0kVrf+hgl4yHFxw42B259tl4wKyrakS
	gkIBG0UUA5P+IBPfFOEFFwwsdu4Rb7VY6wqdIQxKx6n637JSg453lt1KlsTAyEM=
X-Received: by 2002:a05:6820:1391:b0:71a:f498:3048 with SMTP id 006d021491bc7-71b1853a5eamr1698465eaf.25.1794997080164;
        Wed, 18 Nov 2026 02:18:00 -0800 (PST)
Received: from localhost ([216.128.135.139])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b7449282c8sm1781869fac.11.2026.11.18.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:17:57 -0800 (PST)
From: asatsuyu.liu@gmail.com
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	puranjay@kernel.org,
	vadim.fedorenko@linux.dev,
	Yi Liu <asatsuyu.liu@gmail.com>
Subject: [RFC PATCH 6.18.y 1/1] bpf: Reject NULL arguments to four kfuncs
Date: Wed, 18 Nov 2026 10:17:48 +0000
Message-Id: <20261118101748.2335815-2-asatsuyu.liu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118101748.2335815-1-asatsuyu.liu@gmail.com>
References: <20261118101748.2335815-1-asatsuyu.liu@gmail.com>
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

From: Yi Liu <asatsuyu.liu@gmail.com>

6.18.y only applies the kfunc NULL-argument check to functions carrying
KF_TRUSTED_ARGS or KF_RCU.  Four kfuncs dereference pointer arguments
unconditionally but do not carry either flag:

  bpf_copy_from_user_str()
  bpf_copy_from_user_task_str()
  bpf_crypto_ctx_create()
  bpf_rbtree_remove()

A BPF program can therefore pass a NULL or PTR_MAYBE_NULL argument and
trigger a kernel NULL dereference.  Mark the four kfuncs KF_TRUSTED_ARGS
so the existing verifier check rejects such calls.

Skip __ign parameters in that check.  bpf_copy_from_user_str() and
bpf_copy_from_user_task_str() intentionally accept
unsafe_ptr__ign == NULL together with BPF_F_PAD_ZEROS, which is used to
clear the destination buffer.  Without the skip, the new flag would
reject this valid use.

The patch is intended as a minimal 6.18.y stable fix; mainline has
already made KF_TRUSTED_ARGS the default in v7.0.

Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
Fixes: f0f8a5b58f78 ("bpf: Add bpf_copy_from_user_task_str() kfunc")
Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
Fixes: bd1279ae8a69 ("bpf: Add bpf_rbtree_{add,remove,first} kfuncs")
Signed-off-by: Yi Liu <asatsuyu.liu@gmail.com>
---
 kernel/bpf/crypto.c   | 2 +-
 kernel/bpf/helpers.c  | 6 +++---
 kernel/bpf/verifier.c | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 3837d4dcf48d..d1566f76a2c1 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -353,7 +353,7 @@ __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
-BTF_ID_FLAGS(func, bpf_crypto_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_crypto_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_crypto_ctx_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_crypto_ctx_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_KFUNCS_END(crypt_init_kfunc_btf_ids)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 72757f7290ec..d9e0c95bce02 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4278,7 +4278,7 @@ BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_rbtree_add_impl)
 BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
@@ -4365,8 +4365,8 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b89a5d717e42..aac687b81b84 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13494,6 +13494,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
+		    !is_kfunc_arg_ignore(meta->btf, &args[i]) &&
 		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
 			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
-- 
2.34.1

