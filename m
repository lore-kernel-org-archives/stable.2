Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491464;
	b=MmMb+b7tKc3lrDaEU0ivq3jeTfR7zEtLqKR6HYhla3fhnIhYvcThwF+R+dLgxhD88QFU
	 e2yH38NuaMSeNyYthhLeyD062oFs6TNtIcdfsdYIqc0HddyAEDA843qFNoGMQj5N1A/Aq
	 +P5D6k3oONwemGkShxSdhQPqpXaZhz7sybOXbP8GUUxEdT+kMh6b8yWA5g47acGAZv3PB
	 vp0WeXGAi7IWv8Zplxa0XTSle1mGjAlRwOq9O/g0dkKYPMXjaXRLfWLL+3BQXFxrKh8xe
	 yX0OSRTusShA5W3Ut65ft8b4bStbxKnvpfChsv3kt0e1UooSNz5pxJ0iOxev01l0nmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QBfpBqH9DfyEOdhBhH9UadavYWWE9bgXFu1+ss9tjLw=;
	b=1HijuoqvZPgfUBPLrj+qzEFxF9iwhWfroP66UF0fztosfqtk9+YwnHozGvcj/GbOdbBs
	 hA1gsULE7VOGZ9n7+3D2WbMj4SIvYZD0olBM9abCtLBCu+SmhnAA6+qI1dFQyeS7zDWLo
	 RBjvRkp9u8yBPeJ29B1jaHw6h2qaCDdPLXB2QbK+HH1kavwZHqVx02xDNl9c0skg072cv
	 p8gDmdkWTGkEsxSc0/pTmQ5S1GMMJcSRHod7xnCIB30rXpP+NhUDR+KZjQKV+MBrGJlp3
	 O1YheUb+fCOhLb0V4sLuR/8ACbYTRLlYo26KH9QS0YL7yN7B08+Scx2VdtYbFaQQxBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LvOJsOzE;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465B606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8465B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LvOJsOzE
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e97ddaf3c4so19835645ad.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794491464; x=1795096264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBfpBqH9DfyEOdhBhH9UadavYWWE9bgXFu1+ss9tjLw=;
        b=LvOJsOzEgbgl7nXZFUpikpO+sPH215DynZNktvAHyYkp3yom0zPzdYGSDcZkvgaOUb
         MtTwYR9abNDhvoSjpVwNtwDHT0X3B8CRNwvoLRgoBnhyT/9JHadf/NWhIzJ0bGfA8oW8
         RKpb2E2W1KcLaw+dyN74Nc7nTgA+4sELAebw4GDl6EvRaZVad7aZBdN1UQjh11O73qPX
         i7WSeVw9YyHuU2zdGt3fkV3uUQDCtIHCvcAtl+B8vrGWYU2XLYUhOoOo5s+PMDUwxzY7
         hLNf5oIFViXMTUUnavPGDuHMpr1Qa0JfInwKPzakXge+I4ZG7CqlnEA5bOVOTB6YetFZ
         9PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491464; x=1795096264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBfpBqH9DfyEOdhBhH9UadavYWWE9bgXFu1+ss9tjLw=;
        b=1grob6LEwn8aa+0rvwys07mrIMV06xNPKW6vUyqlY8YbtDGtMrbfFbaaiPlKhtKybe
         ENQuQcG1Y+Tyv1m07GgWQVV0AzDoNmSvNrDI5RsmzBYEJjrgT1iJjhMFgIIR9fMHt3tC
         N+wsy1fkvbC3xm0FA1srMDWXdMkVKbMxKZ4PZdCUSjhhs6fzcgZa6h9NQxTUFR45EVKl
         pQwJPRaTOcsMoHX82yeaH/KRfng/c+134pkUmm+hfe3TdIbzFhZf7Ci6y+11Z4hNDRwq
         7n6CqypUeM66ViPGPKFHDOw9qvlA6Cf5aSrJ3/LEcksa8TOy5niIGWYolmp7v6I7XhUd
         dEZQ==
X-Forwarded-Encrypted: i=1; AL+hErFfR1gByhzoEhPh6pzeAuCh3JcMVB6DH4gugZIa4tnbIGXjI8ZAFkiUQBe3CITq/tvrockCZqE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EEW/xB3/QnbGOFOMYWHjY9nkTlfH+Fr/ZSmdsDTd3mD/pBghS
	FEOok5sz0IkFwOjCujW8TAvomDglfEm34FXEvYCBhmz0CLAjLYOYmPHA
X-Gm-Gg: AYBFou2Wy6l7SucuYNYanylAtqxlA5akqJBg1eRbCSJn2BaPHfVQlRjiK0s2Ov1fxU9
	buxgsk+6XqMbKX8U5AEY8SmqXM1TXA/QkUuSw5wdHstYf82NCtgdIcPdHablP85+JR+/yllE3C1
	qB2NKASjus/j4QYz5cJ9Mes8J5V04mzdJC44Fn+xLTQju78jccieM5KM5oRTP+4HqUlI5eaaDfB
	Z6GLuYYaHMImR/mJnckv3hZynJvM27Y4qARQdXNwKSZLWlJ19gMRzZiA9my+5tnCdeB2n6HOWXP
	oIzREIJoidcG1O5BWnNQs4y9zPa4slsbIofX1NxjfXCHfxAxwTO2GV/+id9ueJrmZrhZTQlxoiK
	F0osbKtEmqyjtdu4WaEo1vCm2ZJt1sxTRvEYWzrCM4sw8PzXVSXc2vHzyvL9fPRqeJb6pN+aMlq
	t5G+MmryQcdA1J+qfubq37ZJQp/eFc1AvQBUDUvCvIVrVEN8WuY7ZRFi+FIIEvCGEbwwbQppg7n
	c/MzBmuCj5OEQxjNUQ+LGBYrSho4A+eqPhL/liGF+EFj2ReaLI2ZHEricLW4+0Tv4hwe4tROGPQ
	4EsJf7U0HXi+g9PahiyPgBATIQHqJW2/f/yAgp9Mndsr3t0=
X-Received: by 2002:a17:903:3bac:b0:2e9:8510:6acf with SMTP id d9443c01a7336-2edd7748dc3mr60985655ad.25.1794491463730;
        Thu, 12 Nov 2026 05:51:03 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6e0f9ffsm35078015ad.75.2026.11.12.05.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:51:03 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [PATCH] bpf: Fix cgroup link update after a failed effective array rebuild
Date: Thu, 12 Nov 2026 21:49:41 +0800
Message-ID: <20261112134942.288831-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
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

replace_effective_prog() uses the position of a cgroup program list
entry as a physical index into the effective program array.  When an
OOM detach falls back to purge_effective_progs(), the detached entry is
replaced by a dummy but the other entries keep their position, so the
list position no longer matches the array index.  A later link update
then writes the new program into the wrong slot, leaving the old
program pointer in the array.  The array does not hold a reference, so
the old program can be freed while it is still published.

Translate the position to the corresponding non-dummy entry before
writing, and use the same helper for deletion and replacement.  This
covers both regular programs and cgroup struct_ops entries.

Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effective_progs")
Cc: stable@vger.kernel.org
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 kernel/bpf/cgroup.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 57a785241d42fb..db3f173e83c693 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -403,6 +403,28 @@ static int bpf_cgroup_array_length(struct bpf_prog_array *array,
 	return cnt;
 }
 
+/* Return the entry at logical position @index in an effective program
+ * array.  Dummy entries left behind by a failed rebuild are skipped because
+ * they do not correspond to an entry in the program list.
+ */
+static struct bpf_prog_array_item *
+bpf_cgroup_array_item_at(struct bpf_prog_array *array, int index,
+			 enum cgroup_bpf_attach_type atype)
+{
+	void *dummy = bpf_cgroup_array_dummy(atype);
+	struct bpf_prog_array_item *item;
+
+	for (item = array->items; item->prog; item++) {
+		if (item->prog == dummy)
+			continue;
+		if (!index)
+			return item;
+		index--;
+	}
+
+	return NULL;
+}
+
 static int bpf_cgroup_array_copy_to_user(struct bpf_prog_array *array,
 					 __u32 __user *prog_ids, int cnt,
 					 enum cgroup_bpf_attach_type atype)
@@ -432,16 +454,12 @@ static int bpf_cgroup_array_delete_safe_at(struct bpf_prog_array *array,
 {
 	struct bpf_prog_array_item *item;
 
-	for (item = array->items; item->prog; item++) {
-		if (item->prog == bpf_cgroup_array_dummy(atype))
-			continue;
-		if (!index) {
-			WRITE_ONCE(item->prog, bpf_cgroup_array_dummy(atype));
-			return 0;
-		}
-		index--;
-	}
-	return -ENOENT;
+	item = bpf_cgroup_array_item_at(array, index, atype);
+	if (!item)
+		return -ENOENT;
+
+	WRITE_ONCE(item->prog, bpf_cgroup_array_dummy(atype));
+	return 0;
 }
 
 /**
@@ -1175,7 +1193,9 @@ static void replace_effective_prog(struct cgroup *cgrp,
 		progs = rcu_dereference_protected(
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
-		item = &progs->items[pos];
+		item = bpf_cgroup_array_item_at(progs, pos, atype);
+		if (WARN_ON_ONCE(!item))
+			continue;
 		prog_list_replace_item(pl, item);
 	}
 }
-- 
2.43.0

