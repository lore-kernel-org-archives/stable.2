Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012023;
	b=tsjS7F/xIZJfBlUw4OxYDgJYS4QQ9uJeBJjSSB91WbWU9fNaqQm2YXfflbGIFpWvqpUn
	 6s4VAj3xouxQxdlUEclU3iPZ5azWHFWFjcUogkyOOqh4PgWSKrvikpwau3gUtA2BwiLmF
	 HO9JmLQ1+o5XSfxxoLapV1N45KasdGzuG+jx1cltQqi9qgY8aYj6cqpK+3dBkeSqlFaLo
	 g/SwlMZzj/HRPw2ZH7VM/aKGcGwyd16NX+je61R7Z7C2YG8D0i8XR3yavhuLCqD+vBbW3
	 JPKaxQR41kS+7wsiUoehqkW/BmihNnz24tU1mTrwPsfyYOZm84wWMkQTM/+tm5V4c6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sMCEmE835LnfszT65g9DlnVBZOxppiEGko8ZaPYVJpY=;
	b=f7KopXIGvgWZYnU1YpODnV4oBIOEpfN9ckhwrFLghft22mG9xdMeyxe8cLIwsQFkBZ6X
	 dQfrKrvfrGsCXYnlpFRl7XN5JvMidoI04X4NkXxFW26YYU/9KplrFbYeHRfyF//k3TOyV
	 c9PXJ0DBZa5LkfN24fwCFdZZULlRXh0bybc7pRcPZHHSlv9d3KxEIjd4PTnzq+MsC7abO
	 1JtMrcb5pk/ngzarekgz0oKbYgI9svJSeJ2QgrxMf5CbOvw6j7QNKLfAzDHt0fYgRgflm
	 fzuBWzKkNLqR0JjF7snJn0sDFMx/3BBuMBuOx+ejEoBRIq3N+qe2+RvhZ5f+IUZbSlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZfAAPgvT;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94386606A33F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94386606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZfAAPgvT
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b1afdf5196so387693eaf.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012021; x=1795616821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sMCEmE835LnfszT65g9DlnVBZOxppiEGko8ZaPYVJpY=;
        b=ZfAAPgvTBe84tY6D827CDlqNcrS+x3yqWDjDomZa67VUerpO0NPoN0gmUbjgFhwK5u
         niiDrzkIJ+YX2reprVSxWgD47vOUy+fQvr847hCoIDFCzjqNEiEehcHSPOasgN7aRUxp
         CtzLN1nr0rKvJOybZ+K5i+miI5wwC7QlWsyfnXaZGDE2g4J6yo+QrW6/+Zmgs3qXkTPM
         /uh1ELwppclfJl3T97WuNzehVle7eDh8oTKCNujfrOwsrPGAo3HUHgXEYMXO+1LDDjaX
         rbud4T85ipJj7LnTzj36dVrfO1ZjJ30UQ2U9Km8tSHEDtH+CP2LWYD/dBiQ40NXPXg/7
         aU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012021; x=1795616821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sMCEmE835LnfszT65g9DlnVBZOxppiEGko8ZaPYVJpY=;
        b=k0NdBHgaQDLCt4Hsf4gPRM5Y/cii3RXPxnYN/WL3POq8ORfTgfP3Tv8MheMJFPDd1o
         uHgNqKxP8CPMLRObTn/aOm80ujUtVfmbD0rxgkPUJnjxh0mJVd7ecfdlOT9V4dLZRP1Y
         ysGOdwMCuW56T7LKcCqExSv9vvzRgfISVhOGIEuPLXUXNwka/iBEQeFQHPfGGB07Ev2U
         2fc3FZmkO6egnns5v7dM0J7s2jX0bHqb5AbXu93+H/nN+A1ohr3KWntI0lmj7eR9qjXm
         aEmqFLkSH4UNenCeQzp3XKu7J2sNi8k4fPguYEx4WW/xmnsvBSjdXEVdmj/Rdm0qph6J
         g8xQ==
X-Forwarded-Encrypted: i=1; AL+hErE4wud9qZYzSbwTgIQcUvPRtzYDbM1/ZZoZBtrugitdJAzsdRIXjswRNJmG7229aKQrPFCFHH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VPowMKWWkrYdN/aDXoTYN8NhPSxIsK/5dMSHao+iOF0btCWVj
	flFPDULsprbn6zbjvSjZLvoN/AHh+Uq9238MYorREyjBtXlWt2p8Bwf7
X-Gm-Gg: AYBFou2ZMifYKWH8yVvp5ZRVYEXC9ArGwnp8YnHSWU/9I49zhgSTbyX9zdFNdn+wXWp
	hU9pquOfEcy8Rx7sxlbWOvX+qevaOnHRHlcdhXktOqjjY8qzMle4As9DsOlMFLFQbOTvFDd6//F
	E00un8E7/lGJjuN1QIWuH+7/b91I9JIB8/6NQ92BliSDpfVmzBo1GAEvm4LVVv53dhQr/iCxETF
	bI4jqQkpZu5pby2wj9Cwl/c1ZlLj4hzUNJROU8r8XzEkrD6kftg23Qcwd7A+049y3KjErX7QazV
	8yP/blNxHzya1BDvp8E/MjB8E/fs9rhB3JBXkuPJdeThnfSa/ZRCWU1k9iZ7IydtqzCSFnjyUlS
	wYbXX3ctAm76zCiW9ScwiyjY+CD2utHXJXGY2779qdzwAgBwgEERRJM+CpLf3w08TvE0qOvvtnC
	ZzUvN2Xp1I+ku3YI7s8IZocd4Czs+nZ9jEyszUmVBfDHGL1apgusXRKBmAQBqVb1NmUKThOgtna
	4wKlBSgMgtVRdff6k82IlMhb6BEJ8LMzm+ogYPDEnKAk1NrLLQreAe7qkrFVlY+k6xx41kgwqRX
	7lVhAfNSd7zSsxzTOEqIqXQ4VF01uVjFNgw5r2TXbWqqI8pgdNbY5qz1HXfBeUY=
X-Received: by 2002:a05:6820:858e:20b0:6f9:59ee:cf9a with SMTP id 006d021491bc7-71b1827bdd0mr1338383eaf.7.1795012021011;
        Wed, 18 Nov 2026 06:27:01 -0800 (PST)
Received: from localhost ([216.128.135.139])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b19500c5asm2037276eaf.9.2026.11.18.06.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:27:00 -0800 (PST)
From: asatsuyu.liu@gmail.com
To: gregkh@linuxfoundation.org
Cc: asatsuyu.liu@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	puranjay@kernel.org,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: [PATCH 6.18.y 1/2] bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
Date: Wed, 18 Nov 2026 14:26:53 +0000
Message-Id: <20261118142654.3098395-2-asatsuyu.liu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118142654.3098395-1-asatsuyu.liu@gmail.com>
References: <2026111850-shiftless-popcorn-a566@gregkh>
 <20261118142654.3098395-1-asatsuyu.liu@gmail.com>
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

From: Puranjay Mohan <puranjay@kernel.org>

Change the verifier to make trusted args the default requirement for
all kfuncs by removing is_kfunc_trusted_args() assuming it be to always
return true.

This works because:
1. Context pointers (xdp_md, __sk_buff, etc.) are handled through their
   own KF_ARG_PTR_TO_CTX case label and bypass the trusted check
2. Struct_ops callback arguments are already marked as PTR_TRUSTED during
   initialization and pass is_trusted_reg()
3. KF_RCU kfuncs are handled separately via is_kfunc_rcu() checks at
   call sites (always checked with || alongside is_kfunc_trusted_args)

This simple change makes all kfuncs require trusted args by default
while maintaining correct behavior for all existing special cases.

Note: This change means kfuncs that previously accepted NULL pointers
without KF_TRUSTED_ARGS will now reject NULL at verification time.
Several netfilter kfuncs are affected: bpf_xdp_ct_lookup(),
bpf_skb_ct_lookup(), bpf_xdp_ct_alloc(), and bpf_skb_ct_alloc() all
accept NULL for their bpf_tuple and opts parameters internally (checked
in __bpf_nf_ct_lookup), but after this change the verifier rejects NULL
before the kfunc is even called. This is acceptable because these kfuncs
don't work with NULL parameters in their proper usage. Now they will be
rejected rather than returning an error, which shouldn't make a
difference to BPF programs that were using these kfuncs properly.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/r/20260102180038.2708325-2-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

(cherry picked from commit 1a5c01d2508a845825eece360c6145d7f436dbf8)
Signed-off-by: Yi Liu <asatsuyu.liu@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 184 +++++++++++++++++------------------
 fs/bpf_fs_kfuncs.c           |  10 +-
 kernel/bpf/verifier.c        |  14 +--
 3 files changed, 97 insertions(+), 111 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index e38941370b90..6cb6857bfa6f 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -50,7 +50,70 @@ A wrapper kfunc is often needed when we need to annotate parameters of the
 kfunc. Otherwise one may directly make the kfunc visible to the BPF program by
 registering it with the BPF subsystem. See :ref:`BPF_kfunc_nodef`.
 
-2.2 Annotating kfunc parameters
+2.2 kfunc Parameters
+--------------------
+
+All kfuncs now require trusted arguments by default. This means that all
+pointer arguments must be valid, and all pointers to BTF objects must be
+passed in their unmodified form (at a zero offset, and without having been
+obtained from walking another pointer, with exceptions described below).
+
+There are two types of pointers to kernel objects which are considered "trusted":
+
+1. Pointers which are passed as tracepoint or struct_ops callback arguments.
+2. Pointers which were returned from a KF_ACQUIRE kfunc.
+
+Pointers to non-BTF objects (e.g. scalar pointers) may also be passed to
+kfuncs, and may have a non-zero offset.
+
+The definition of "valid" pointers is subject to change at any time, and has
+absolutely no ABI stability guarantees.
+
+As mentioned above, a nested pointer obtained from walking a trusted pointer is
+no longer trusted, with one exception. If a struct type has a field that is
+guaranteed to be valid (trusted or rcu, as in KF_RCU description below) as long
+as its parent pointer is valid, the following macros can be used to express
+that to the verifier:
+
+* ``BTF_TYPE_SAFE_TRUSTED``
+* ``BTF_TYPE_SAFE_RCU``
+* ``BTF_TYPE_SAFE_RCU_OR_NULL``
+
+For example,
+
+.. code-block:: c
+
+	BTF_TYPE_SAFE_TRUSTED(struct socket) {
+		struct sock *sk;
+	};
+
+or
+
+.. code-block:: c
+
+	BTF_TYPE_SAFE_RCU(struct task_struct) {
+		const cpumask_t *cpus_ptr;
+		struct css_set __rcu *cgroups;
+		struct task_struct __rcu *real_parent;
+		struct task_struct *group_leader;
+	};
+
+In other words, you must:
+
+1. Wrap the valid pointer type in a ``BTF_TYPE_SAFE_*`` macro.
+
+2. Specify the type and name of the valid nested field. This field must match
+   the field in the original type definition exactly.
+
+A new type declared by a ``BTF_TYPE_SAFE_*`` macro also needs to be emitted so
+that it appears in BTF. For example, ``BTF_TYPE_SAFE_TRUSTED(struct socket)``
+is emitted in the ``type_is_trusted()`` function as follows:
+
+.. code-block:: c
+
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct socket));
+
+2.3 Annotating kfunc parameters
 -------------------------------
 
 Similar to BPF helpers, there is sometime need for additional context required
@@ -58,7 +121,7 @@ by the verifier to make the usage of kernel functions safer and more useful.
 Hence, we can annotate a parameter by suffixing the name of the argument of the
 kfunc with a __tag, where tag may be one of the supported annotations.
 
-2.2.1 __sz Annotation
+2.3.1 __sz Annotation
 ---------------------
 
 This annotation is used to indicate a memory and size pair in the argument list.
@@ -74,7 +137,7 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.
 
-2.2.2 __k Annotation
+2.3.2 __k Annotation
 --------------------
 
 This annotation is only understood for scalar arguments, where it indicates that
@@ -98,7 +161,7 @@ Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
 size parameter, and the value of the constant matters for program safety, __k
 suffix should be used.
 
-2.2.3 __uninit Annotation
+2.3.3 __uninit Annotation
 -------------------------
 
 This annotation is used to indicate that the argument will be treated as
@@ -115,7 +178,7 @@ Here, the dynptr will be treated as an uninitialized dynptr. Without this
 annotation, the verifier will reject the program if the dynptr passed in is
 not initialized.
 
-2.2.4 __opt Annotation
+2.3.4 __opt Annotation
 -------------------------
 
 This annotation is used to indicate that the buffer associated with an __sz or __szk
@@ -135,7 +198,7 @@ Either way, the returned buffer is either NULL, or of size buffer_szk. Without t
 annotation, the verifier will reject the program if a null pointer is passed in with
 a nonzero size.
 
-2.2.5 __str Annotation
+2.3.5 __str Annotation
 ----------------------------
 This annotation is used to indicate that the argument is a constant string.
 
@@ -160,7 +223,7 @@ Or::
                 ...
         }
 
-2.2.6 __prog Annotation
+2.3.6 __prog Annotation
 ---------------------------
 This annotation is used to indicate that the argument needs to be fixed up to
 the bpf_prog_aux of the caller BPF program. Any value passed into this argument
@@ -179,7 +242,7 @@ An example is given below::
 
 .. _BPF_kfunc_nodef:
 
-2.3 Using an existing kernel function
+2.4 Using an existing kernel function
 -------------------------------------
 
 When an existing function in the kernel is fit for consumption by BPF programs,
@@ -187,7 +250,7 @@ it can be directly registered with the BPF subsystem. However, care must still
 be taken to review the context in which it will be invoked by the BPF program
 and whether it is safe to do so.
 
-2.4 Annotating kfuncs
+2.5 Annotating kfuncs
 ---------------------
 
 In addition to kfuncs' arguments, verifier may need more information about the
@@ -216,7 +279,7 @@ protected. An example is given below::
         ...
         }
 
-2.4.1 KF_ACQUIRE flag
+2.5.1 KF_ACQUIRE flag
 ---------------------
 
 The KF_ACQUIRE flag is used to indicate that the kfunc returns a pointer to a
@@ -226,7 +289,7 @@ referenced kptr (by invoking bpf_kptr_xchg). If not, the verifier fails the
 loading of the BPF program until no lingering references remain in all possible
 explored states of the program.
 
-2.4.2 KF_RET_NULL flag
+2.5.2 KF_RET_NULL flag
 ----------------------
 
 The KF_RET_NULL flag is used to indicate that the pointer returned by the kfunc
@@ -235,87 +298,21 @@ returned from the kfunc before making use of it (dereferencing or passing to
 another helper). This flag is often used in pairing with KF_ACQUIRE flag, but
 both are orthogonal to each other.
 
-2.4.3 KF_RELEASE flag
+2.5.3 KF_RELEASE flag
 ---------------------
 
 The KF_RELEASE flag is used to indicate that the kfunc releases the pointer
 passed in to it. There can be only one referenced pointer that can be passed
 in. All copies of the pointer being released are invalidated as a result of
-invoking kfunc with this flag. KF_RELEASE kfuncs automatically receive the
-protection afforded by the KF_TRUSTED_ARGS flag described below.
-
-2.4.4 KF_TRUSTED_ARGS flag
---------------------------
-
-The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
-indicates that the all pointer arguments are valid, and that all pointers to
-BTF objects have been passed in their unmodified form (that is, at a zero
-offset, and without having been obtained from walking another pointer, with one
-exception described below).
-
-There are two types of pointers to kernel objects which are considered "valid":
-
-1. Pointers which are passed as tracepoint or struct_ops callback arguments.
-2. Pointers which were returned from a KF_ACQUIRE kfunc.
-
-Pointers to non-BTF objects (e.g. scalar pointers) may also be passed to
-KF_TRUSTED_ARGS kfuncs, and may have a non-zero offset.
-
-The definition of "valid" pointers is subject to change at any time, and has
-absolutely no ABI stability guarantees.
-
-As mentioned above, a nested pointer obtained from walking a trusted pointer is
-no longer trusted, with one exception. If a struct type has a field that is
-guaranteed to be valid (trusted or rcu, as in KF_RCU description below) as long
-as its parent pointer is valid, the following macros can be used to express
-that to the verifier:
-
-* ``BTF_TYPE_SAFE_TRUSTED``
-* ``BTF_TYPE_SAFE_RCU``
-* ``BTF_TYPE_SAFE_RCU_OR_NULL``
-
-For example,
-
-.. code-block:: c
-
-	BTF_TYPE_SAFE_TRUSTED(struct socket) {
-		struct sock *sk;
-	};
-
-or
-
-.. code-block:: c
-
-	BTF_TYPE_SAFE_RCU(struct task_struct) {
-		const cpumask_t *cpus_ptr;
-		struct css_set __rcu *cgroups;
-		struct task_struct __rcu *real_parent;
-		struct task_struct *group_leader;
-	};
-
-In other words, you must:
-
-1. Wrap the valid pointer type in a ``BTF_TYPE_SAFE_*`` macro.
-
-2. Specify the type and name of the valid nested field. This field must match
-   the field in the original type definition exactly.
-
-A new type declared by a ``BTF_TYPE_SAFE_*`` macro also needs to be emitted so
-that it appears in BTF. For example, ``BTF_TYPE_SAFE_TRUSTED(struct socket)``
-is emitted in the ``type_is_trusted()`` function as follows:
-
-.. code-block:: c
-
-	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct socket));
-
+invoking kfunc with this flag.
 
-2.4.5 KF_SLEEPABLE flag
+2.5.4 KF_SLEEPABLE flag
 -----------------------
 
 The KF_SLEEPABLE flag is used for kfuncs that may sleep. Such kfuncs can only
 be called by sleepable BPF programs (BPF_F_SLEEPABLE).
 
-2.4.6 KF_DESTRUCTIVE flag
+2.5.5 KF_DESTRUCTIVE flag
 --------------------------
 
 The KF_DESTRUCTIVE flag is used to indicate functions calling which is
@@ -324,18 +321,19 @@ rebooting or panicking. Due to this additional restrictions apply to these
 calls. At the moment they only require CAP_SYS_BOOT capability, but more can be
 added later.
 
-2.4.7 KF_RCU flag
+2.5.6 KF_RCU flag
 -----------------
 
-The KF_RCU flag is a weaker version of KF_TRUSTED_ARGS. The kfuncs marked with
-KF_RCU expect either PTR_TRUSTED or MEM_RCU arguments. The verifier guarantees
-that the objects are valid and there is no use-after-free. The pointers are not
-NULL, but the object's refcount could have reached zero. The kfuncs need to
-consider doing refcnt != 0 check, especially when returning a KF_ACQUIRE
-pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU should very likely
-also be KF_RET_NULL.
+The KF_RCU flag allows kfuncs to opt out of the default trusted args
+requirement and accept RCU pointers with weaker guarantees. The kfuncs marked
+with KF_RCU expect either PTR_TRUSTED or MEM_RCU arguments. The verifier
+guarantees that the objects are valid and there is no use-after-free. The
+pointers are not NULL, but the object's refcount could have reached zero. The
+kfuncs need to consider doing refcnt != 0 check, especially when returning a
+KF_ACQUIRE pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU should
+very likely also be KF_RET_NULL.
 
-2.4.8 KF_RCU_PROTECTED flag
+2.5.7 KF_RCU_PROTECTED flag
 ---------------------------
 
 The KF_RCU_PROTECTED flag is used to indicate that the kfunc must be invoked in
@@ -354,7 +352,7 @@ RCU protection but do not take RCU protected arguments.
 
 .. _KF_deprecated_flag:
 
-2.4.9 KF_DEPRECATED flag
+2.5.8 KF_DEPRECATED flag
 ------------------------
 
 The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
@@ -374,7 +372,7 @@ encouraged to make their use-cases known as early as possible, and participate
 in upstream discussions regarding whether to keep, change, deprecate, or remove
 those kfuncs if and when such discussions occur.
 
-2.5 Registering the kfuncs
+2.6 Registering the kfuncs
 --------------------------
 
 Once the kfunc is prepared for use, the final step to making it visible is
@@ -397,7 +395,7 @@ type. An example is shown below::
         }
         late_initcall(init_subsystem);
 
-2.6  Specifying no-cast aliases with ___init
+2.7  Specifying no-cast aliases with ___init
 --------------------------------------------
 
 The verifier will always enforce that the BTF type of a pointer passed to a
diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index b60e0698ce13..97cb06877754 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -68,10 +68,7 @@ __bpf_kfunc void bpf_put_file(struct file *file)
  *
  * Resolve the pathname for the supplied *path* and store it in *buf*. This BPF
  * kfunc is the safer variant of the legacy bpf_d_path() helper and should be
- * used in place of bpf_d_path() whenever possible. It enforces KF_TRUSTED_ARGS
- * semantics, meaning that the supplied *path* must itself hold a valid
- * reference, or else the BPF program will be outright rejected by the BPF
- * verifier.
+ * used in place of bpf_d_path() whenever possible.
  *
  * This BPF kfunc may only be called from BPF LSM programs.
  *
@@ -383,9 +380,8 @@ static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	return -EACCES;
 }
 
-/* bpf_[set|remove]_dentry_xattr.* hooks have KF_TRUSTED_ARGS and
- * KF_SLEEPABLE, so they are only available to sleepable hooks with
- * dentry arguments.
+/* bpf_[set|remove]_dentry_xattr.* hooks have KF_SLEEPABLE, so they are only
+ * available to sleepable hooks with dentry arguments.
  *
  * Setting and removing xattr requires exclusive lock on dentry->d_inode.
  * Some hooks already locked d_inode, while some hooks have not locked
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b89a5d717e42..3ef78a702685 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12281,11 +12281,6 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RELEASE;
 }
 
-static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
-{
-	return (meta->kfunc_flags & KF_TRUSTED_ARGS) || is_kfunc_release(meta);
-}
-
 static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_SLEEPABLE;
@@ -13493,9 +13488,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
-		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
-		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
-			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
+		if ((register_is_null(reg) || type_may_be_null(reg->type)) &&
+		    !is_kfunc_arg_nullable(meta->btf, &args[i]) &&
+		    !is_kfunc_arg_optional(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
 			return -EACCES;
 		}
@@ -13560,9 +13555,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
-			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
-				break;
-
 			if (!is_trusted_reg(reg)) {
 				if (!is_kfunc_rcu(meta)) {
 					verbose(env, "R%d must be referenced or trusted\n", regno);
-- 
2.34.1

