Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543080;
	b=yCE01hOKNPESVbPf7BvfsGuIUWj++7qS6pSj3jvdcky04OV1xMhUDqnXTj7IFBhrqJq+
	 CtP1xn0uZVsIsfRq0J802NT/Vu7h973H62YGn7zdtLYK+PBl1Z6xINX+7FnOQAe4jse6Z
	 tDl+nWHmrb60PWpTEZ0CmXc5aXwW1wQqpHZutSOqQqWeMRZ1L9n0rP8K47uGpr/gmepGl
	 hhx2fgYfuIn6LFiFa114R3Wik1vN+LnrkC6QuOhLPhUH5ZnZkW9HqrEohrpqwUeuopot9
	 oJhBzJ53hjAh7HVYkXZAP5rnSFbBmd3ImK0Ajd864JFEopKbesKtGNQ3mhGsscp/8QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=9bIq9aII7kLqjsNDBEaSAqEh5ibZTVSbY4P+ooHbewY=;
	b=XsDSpohcl0X+P0nVxId79n2D1gEP8CKVqh9Xyxhm/LQN6pqqGTaR0mMCuLeV9qJtFgbv
	 CK9Qa8W9v3Jw4XtP4n2tkLiv9qqJl1XwPvjN23K1YaezLVMb+jeDF+KUi8zRp0pjWSVdK
	 nToYa70OdPUAgv/TuweK8b5p/4yECTbsQKyd5ljb9X+PxjAV6YPF7fZPMXW7By0QkatlB
	 oNRutYJZI54v3J0vI0XM/30FrKvY5hjH4KULFUAqBdfsIWEZ/wPU1HUNxq0PQjCOTkNml
	 KiWJJ46cpCmP7Gde1mTvPkGImatM+0Xvw3bnKCcgx+sQIYbD+Q86jDNzXE81CdYnzMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="eKFoo/LH";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C12606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65C12606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eKFoo/LH
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e987b4a710so6346385ad.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792543080; x=1793147880; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bIq9aII7kLqjsNDBEaSAqEh5ibZTVSbY4P+ooHbewY=;
        b=eKFoo/LHGp7jtYrmLpVcXqMKP30nxaprx+ioCYxVhmS1BFT8B462AsmbkkASn0Y6Rk
         OSw6u9fIMf5DQ8L7TKRj6G4HuhTXuQkH8pRGalecuP5SnzszDOC9a7i/S7qEfvRWWxPw
         LtYxJLf5XceHQhO5HkfzQPbIDB5TM/zJtpJYqzul7MexF9oNehPOLaBu/SdJb0XpaGwa
         nRgKUb7rTwvcZesDSUKTpulwZj66VQslWm8ZjX3+GAbOajyEf9EdAHYtoGESaocrn3fQ
         D+xKIN5c6kydEivM/ibYLj5OZbPIQuX3lFTZ/FftlJf+GqDQfG3waDH6CRktFJb//hrQ
         v8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792543080; x=1793147880;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bIq9aII7kLqjsNDBEaSAqEh5ibZTVSbY4P+ooHbewY=;
        b=lpTCjiHIsWL6k1wWhMs0zH21Sj1NvPyFpm5m8647zESu6fhTGTbjagmmLhEUqrjHqG
         HHSUBohebBLS75AsKYZ9RaxznpVPCEN5a+/Qu2cU8q6bkGuGgB+JEN6LhTnc3P9P9E9z
         DGhAn5IBtJ+XhCCj+QNttUnbleEmgEKDY0UPtov/4ZFSlmeS+vHysYTe1NqpvooLIby6
         3y2ep8ixxL+gjTyZA5muOPvPr4jp2VynP2auznkwN6Dd26/9+2s8HKGptOSn0BEIhKRT
         m+DaMiq3gZ8RuGi0h3S3QwRZqolzvvjLKRcgjCgY3QTz4lkSyhGnSxMuJPeWJ6NVD61u
         DxsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMuzmG2kO7+8c2pqqEerlgekyG1FZwSfqCClGgjAMerSOFDnYPFPt3WX0z6AKiJIxMjxfAR8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLg1xVhkEyGRRJ1FZucGpxa8RiwbEv3L4YsRtj1rgaBMetUCumg
	riV2BoG0wp+tbQT/HzH6zFyOMhmkIejPLw2VrBAKEvkxrtxrnu0ne17P
X-Gm-Gg: AYBFou3T6IHrR6Ladmn+wwVHbkdMvMbUPOtl2auCVRXY6X7c9NGcDz86+j5UhiyQAfO
	Ao0v2tMuE2Q6wnrm6XK1rhMtOEERbkCom78NGLOk/ok5DNThVXA764BxryyyF0xVOg35WTDzwGB
	tOLbX2KfOwLkIshehRcTZNUbRwPF6Sol0fn05FXzyUm1KVCPnCY6C+u/ldtcOIybFwHi79LMpLB
	pL0TwbkqYLTEMgWhOB6TGoS+cXbY5F2wiwm4+lSMN7uDn907lD8a9taphVOlSfdBRONZn+RouM/
	ftqsVVv2Ucng2l3eWkTpmuxWDJc5D8mkm1qUEzzPDNGUbirBLANE4wyJu+vtgMWuVDwvHbG/63x
	aRmKS7hHrZV23df12roNjda3Ul/VCsNnMVqsdJuW/BTyQinVbuq8O1cHOTkHqwwNKzcW+/hM36U
	rrw9hOywk31N17+b5oD90clePvQgwQm8pdch8yMZVL1Z3BBzkLIMWz/heopwNus/zi7dEAEDksH
	HIumLdvPJlD82bRHJ36CU+RalZhZFFoxujPp4Dez3U2s/+rwMXRcrcmRssIxEcxnEYlvJauvZZn
	mOJi2wwGBWAWfTfpPAgMww/MaL2lfAXjBGd+huEJLUnVAMWTIr7sid6+T7H0jg==
X-Received: by 2002:a17:90b:1b04:b0:3ac:9ed8:f30e with SMTP id 98e67ed59e1d1-3ad86f4e243mr274578a91.35.1792543079615;
        Tue, 20 Oct 2026 17:37:59 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813de463sm1499556a91.13.2026.10.20.17.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:37:58 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:37:58 +0000
Message-Id: <DMA3HLS1N8FF.9YVQJB6RM2A0@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Song Liu" <song@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Carry MEM_RCU for trusted fields
 with MEM_RCU parents
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261020145059.2146170-2-utilityemal77@gmail.com>
References: <20261020145059.2146170-1-utilityemal77@gmail.com> <20261020145059.2146170-2-utilityemal77@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 07:50 AM Justin Suess <utilityemal77@gmail.com> wrote:
> An RCU-protected parent also guarantees less about the field's value
> than a trusted one. __safe_trusted promises a non-NULL field for as
> long as the parent object is valid, but RCU only keeps the parent's
> memory valid: struct file is allocated SLAB_TYPESAFE_BY_RCU, so a file
> read under RCU can be freed and reused within the same CS.

It guarantees less about the field's lifetime too. A MEM_RCU parent
only means that its memory is not freed yet, so the field is safe
only if the object it points to is RCU freed itself.
inode is. mm_struct is not, __mmdrop() does kmem_cache_free() without
a grace period. With this patch the first MEM_RCU vma hands out
vma->vm_mm as rcu_ptr_mm_struct.

That's what the __safe_rcu_or_null list is for. Let's put f_inode
there and not apply the trusted lists to a parent that is not trusted.
exe_file->f_inode is the same rcu_ptr_or_null_inode, so the tests in
patch 2 don't change, and the ternaries go away.

Something like this (compile tested only):

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01434e1..219d027 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6476,6 +6476,11 @@ BTF_TYPE_SAFE_RCU_OR_NULL(struct request_sock) {
 	struct sock *sk;
 };

+/* struct file is SLAB_TYPESAFE_BY_RCU. A reused file has f_inode == NULL. */
+BTF_TYPE_SAFE_RCU_OR_NULL(struct file) {
+	struct inode *f_inode;
+};
+
 /* full trusted: these fields are trusted even outside of RCU CS and never NULL */
 BTF_TYPE_SAFE_TRUSTED(struct bpf_iter_meta) {
 	struct seq_file *seq;
@@ -6552,6 +6557,7 @@ static bool type_is_rcu_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct sk_buff));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct request_sock));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct file));

 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_rcu_or_null");
 }
@@ -6757,10 +6763,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 *
 		 * A regular RCU-protected pointer with __rcu tag can also be deemed
 		 * trusted if we are in an RCU CS. Such pointer can be NULL.
+		 *
+		 * If the parent is not trusted, the field can't regain trusted status.
 		 */
-		if (type_is_trusted(env, reg, field_name, btf_id)) {
+		bool trusted = is_trusted_reg(env, reg);
+
+		if (trusted && type_is_trusted(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED;
-		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
+		} else if (trusted && type_is_trusted_or_null(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
 		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
 			if (type_is_rcu(env, reg, field_name, btf_id)) {

[...]

> Cc: stable@vger.kernel.org

That shouldn't go to stable.

pw-bot: cr
