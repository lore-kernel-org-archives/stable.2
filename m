Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508216;
	b=RHtLvh79qbMt+zl6ji9wHjpH7PU7wesGKhKvpWR4AeTCVw/S6TkIdglDJhmDqgNQV3WG
	 bNMULdZKs2ZoXoMPt2MbgWvhtc8cbqCA+do8Mu7ZmqNE6b/y109+cfss5MUw/xaAxnJPk
	 04NJcEdi9L5/3eeViLM62ZlK8mc10P+6D8p4R7xv3cjH7pqE93+nU1Mk/bm1dXGkgC6xQ
	 l133XNSfzpBWyOWedHqVjSQCIeMMaI1mXUe5o0NOaaG/7DwlE/LsBStchlR/PpdBxlkB4
	 WWBZwMpXB/Qwb8xiWf/7Sm5CpgejJYCrk8CkwdL96tJJNsCzSqR03J3osyiLNzitIIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HcC9I3HM8PkvM9oYwYIQQHE7BTWNOlfs5NQCIXXB490=;
	b=oQHmle4/oNDRNzTs5qcaJJqAqUwKVURusr02WfPDYXUfQqqHoLAzLVuggmlE5t706Ad9
	 hhT+sjPJ7QdtFsepqfRdkdeJ8TitFGi2nYYkYNZQBjxd8Qi5+HmuSXzf5M2ZE7Fjjdrv2
	 +YWRrzIc0cbZ8ok8IaZGNEtegTC3YUDr/h+10Tl2rnEnrgNfbcZhh8ydNYwMqEH0OnVhh
	 QG8FSQt3uW/Qtmbohh0s8hswlWaoBx++oD4CvDk4OJyBQ6p1ikY9aVNz0GwSdIYrqg5qm
	 8LZGwTeDoefO9/oS6hqvukwqb9MnMwFaLR8HBG2dPqBhF4MLZWs6m18IH9zs6rc9rSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LuShPugs;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABF606A334
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 14:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2ABF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LuShPugs
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6798af41644so2265695d50.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508215; x=1793113015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcC9I3HM8PkvM9oYwYIQQHE7BTWNOlfs5NQCIXXB490=;
        b=LuShPugswmZJP7u4GV/OxkTrGHwqMHPXtwVV3YYPTlt5swJAgBhFxPyD5nWw002Gl2
         kQChuBgaqbAItlKCXBrxVB1ELbLRYDqDFhxGAmbzBVDlpeM1PdmkEqAD0MmVQx++Znhy
         TJ8Cl1nABpZI8eCtpqaWOUd5rjm8d+Q7zmH/dOqeAU6nN1EI2vBj9VE44FJVB15V/mi6
         WH5VYGAFLZTiwspzx/lzvd4/izHn1bRmXBMJ6jnjNezyiQxb5Pjr3+oH2FE85sMe0ttp
         cVVUKjlnbli96aNUTnF6dQtM/FP3Jyz+SQpKSSKJ9Ze2Gn0GOJqhyXPIWDMlH6rB8Ffz
         c1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508215; x=1793113015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HcC9I3HM8PkvM9oYwYIQQHE7BTWNOlfs5NQCIXXB490=;
        b=rlMBuQDKgf/Olx1/40j/UzZ0LWxPlQsjuXUmxYBzQ3MJTQV5JyzIHUq8GPG1TVsjGJ
         WiNDjo7HN9e2zyQNmx631CxGMUUq92RjmraW5tiQerdjmE5viWSoh3GsIGEOXVPIOIzR
         9Dbtk54MeGqYZLoetj1fOjDugmY1S8LwiSB7d2cEbIThsv443xh+lLbb53k4F1kK2JNr
         bPdIFiCH93aR13ft7Gnr/tF/7hoSZoc9YHfqtEOvom3Q8qbPrt5ZQMPwEKsNFB0Ez7oB
         VPXsUPciIfktDZlQcsLRNdAsR2uYnWZoBFDcdc3ThTd3wjNe2tF5wDfhReXqbYEJTsms
         UeLw==
X-Forwarded-Encrypted: i=1; AKwUvBwl4kPGyWX1XEokyFbPa5kdGGywOtCUNAtxZQtVi2JKpCfNel1BYFwk/vhH8DxeyBUk/M2+0VU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+/O2UYggUUrFqDzvcI3pnPp0JhWSVTMtlqtIFtGdFei6MkR7C
	hpEm328GemmHcTMOQrDRThOI+xfW94dCP93FqMTr7EpkNtnCqrNXCqkfJFFSkw==
X-Gm-Gg: AYBFou3J+0/EpfQ+xxFXY+T21ZbpYsUNwxA+XiDcqS7LmK57FT3Z3gV2fYaZWnN7+So
	nXw1UfjZ42+ftx9kuIEWrS2QbUcfDsu4/3qol/iTX9QBreGciYeiZ++08b5ErgudKwQPAsDb73o
	C6riczrbpp7BRL4GWcdNwoU2XIctciClfwqV9MBI1aeKlamPM/lLjQ1zClK2Y1q3GaDSOkJXB2G
	ZO1pYlDBsUk0vgblTOg7enEbVcrY5uS2bM4tQbKw2jcNHY6a3BUUDG7KHcKG/qQKamw5cMqEOIO
	khOXvGim2xqpf5Wm20PyLSH5IZMx1qbR/smn5yJKS5YK2MkRO86WeVwWHesXm9fBOAq3W0SxMi7
	UxjKR77P9lFjtpnV/X1reMaTOTQ5FJTomQJD3ZCD2VRl5QB2JkAJSjhgZbSiwtuRtI4hRIZo/kJ
	bYipvAQdkwXRzxTWFgySBXA+Xd24Qwo0LS29V/f2fhxlBbu8GnzdGEbLrpUQU8FwqUcKbOxN4cy
	LafHOTiaQ==
X-Received: by 2002:a05:690e:b47:b0:67a:a:a5b6 with SMTP id 956f58d0204a3-67a000ac7d4mr614715d50.33.1792508214680;
        Tue, 20 Oct 2026 07:56:54 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8701:205:573e:17eb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1c98a1esm5239944d50.1.2026.10.20.07.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:56:54 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf-next v2 5/6] bpf: Bind iterator elements to their iterator
Date: Tue, 20 Oct 2026 10:50:58 -0400
Message-ID: <20261020145059.2146170-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020145059.2146170-1-utilityemal77@gmail.com>
References: <20261020145059.2146170-1-utilityemal77@gmail.com>
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

An element returned by an iterator's next() kfunc is kept alive by the
iterator alone. bpf_iter_task_vma_next() returns a snapshot that lives
in the iterator's own allocation and holds the vma's vm_file reference
only until the next step or destroy; bpf_iter_kmem_cache_next() and
bpf_iter_dmabuf_next() hand out objects whose reference the iterator
drops the same way. The verifier marks every such element PTR_TRUSTED
with nothing tying it to the iterator, so a pointer saved across
bpf_iter_<type>_destroy() stays fully trusted after the memory or the
reference behind it is gone:

	bpf_iter_task_vma_new(&it, task, 0);
	vma = bpf_iter_task_vma_next(&it);
	file = vma->vm_file;			/* __safe_trusted_or_null */
	bpf_iter_task_vma_destroy(&it);		/* frees snapshot, fput() */
	start = vma->vm_start;			/* vma, file still trusted */

Set the element's parent_id to the iterator's reference id, as is
already done for the PTR_TO_MEM elements of bpf_iter_num_next(), so
that destroying the iterator invalidates the element together with
every trusted field acquired from it. Elements of an RCU-protected
iterator keep MEM_RCU and stay bounded by the critical section instead:
they point at RCU-managed objects rather than iterator state.

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/bpf/bpf_iterators.rst |  6 +++++-
 kernel/bpf/verifier.c               | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 189e3ec1c6c8..08c9c15b59ac 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -79,7 +79,11 @@ Constructor/next/destructor implementation contract is as follows:
     will eventually return NULL when elements are exhausted. Once NULL is
     returned, subsequent next calls *should keep returning NULL*. Next method
     is marked with KF_ITER_NEXT (and should also have KF_RET_NULL as
-    NULL-returning kfunc, of course).
+    NULL-returning kfunc, of course). An element is only guaranteed to be
+    valid until the iterator is destroyed, so the verifier invalidates it,
+    and every trusted pointer derived from it, at `bpf_iter_<type>_destroy()`.
+    Elements of an RCU-protected iterator (see KF_RCU_PROTECTED) are instead
+    valid until the end of the RCU critical section.
 
   - destructor, `bpf_iter_<type>_destroy()`, is always called once. Even if
     constructor failed or next returned nothing.  Destructor frees up any
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c85c83a6ee63..9ce5517dc1a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15504,6 +15504,19 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = type;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+
+			/*
+			 * A trusted element is pinned by the iterator that
+			 * produced it and dies with it, like the memory
+			 * returned by bpf_iter_num_next() above. An RCU
+			 * element is bounded by the critical section instead.
+			 */
+			if (bpf_is_iter_next_kfunc(&meta) && (type & PTR_TRUSTED)) {
+				err = validate_ref_obj(env, &meta.ref_obj);
+				if (err)
+					return err;
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
+			}
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
-- 
2.55.0

