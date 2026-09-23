Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790223F8243
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195522; cv=none; b=pHKmKThFk5FadFDsYdosA/CecJQE2cu7cN9l8EZjy8bhFZTZerNg2eyTmOf//en6es7pH9ru4HgmqUOLLyXYHmXpTBYQMUZJA4zUaqS0FrRlYK9+MPwlyjGs5hQy+ZOWx3wGhACdybzvdkqbPLuvRNK0FII7iI5Ie7G8qQYuYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195522; c=relaxed/simple;
	bh=lsgiFQR0W1RaDSUCFb03bBzHp12jvBbMgfMT0EHXOU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXryBWDtnVULdpiG5qCGImKqdB8sbJsgzVyuWqfjhrYDY+BSsP7AWWHl3iMnjmLH0iHASYfLzSsrSeaVsfuJYTuvoZa3pZU5VRu9A1DM/GfnQG9r5Z/SqNDOJVd0D97uiDAnqEAw36p9azhozXJJrm7vPnlFR+rKx6aU80p5PVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=oz5pMRSA; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="oz5pMRSA"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664b7582so813680eec.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1790195509; x=1790800309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rVIQWAnKN98ur25hclWfvj2q8SoQe7T1V/QGgzzXRDE=;
        b=oz5pMRSANSD2rT04xi0Ga0fDwbcW+o4DGgCerIZ1x+V2qDeEgLh7X1WcwerHDrzKAs
         lGiTMo1+LF2JnsQvPwOJQoJtvfPvY8c6Ti8NBCOIkcqEmn4FEvjDq0UeYcD2dLnVJPDY
         DjYopDDfneU50g+c5MG+4PHyophV53eksTZoNUtHxPNjjy38Rf7P5yKhhR9AS7ErBU/b
         5mLc6cVAHXcL4/Oq93FiQuL8Ywg2SrAXKxbQFd3+IVw1PUThjxyquri1ATku3bFJaxbg
         0rXpZgkSkHZg1siqA34lopbbD5ip4QlyFpLrO1LDARpBnIOCDdKMw/bRg4KjeHiz1hK8
         duCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195509; x=1790800309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rVIQWAnKN98ur25hclWfvj2q8SoQe7T1V/QGgzzXRDE=;
        b=pSUphRV5xWDzoAqfJ/N0LF+vVco2Fgjs6EWg/HUzPcYvGRpyIYxMgFpZ59tXZksu1E
         dCYtc57oSBnYTDaYHBLOChI37lJ947OmLQsZcltjrn1hiYkQbL/9qEBT2cVG2O68aiiz
         VozIskGKQHdSNgkHIUtgYRhpDPBTfzBJx3mUy8wucWQyoGYxQxaa+MTQQXBMGDryDDUC
         bg1c5dV3tQAQkSMSzbbk+NOtboVNIdXpnzv0f7wHh8r3P+gVYt2iqa6C0ktbhGClEUrg
         Q/ju1K4yyZZGr/hgsjeab91zhDj9uuvr1aMHb0NjmkiD16OecSENlAxtPjy9qgq4gZMa
         kXzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUa7GlMkYMjLdlr1Q0SMfk5KcnBvdvwNjZFEacMH7M6BMDjlrQ9K8DDyecsT0JbWj2AD13yBU=@vger.kernel.org
X-Gm-Message-State: AFuF++l+bjv+BaiDm9twO+r8eI/p3SljzlxLpSOoWJJ4kgo2CiBlpdA2
	yT7omOqv6V+NK6KQdEsYdVOKNS6ao/baVE09rLcESU7UhLTqEflPGSjOLR1tCr74W3w=
X-Gm-Gg: AYBFou2nwWWNeWUcr8xzvyh55dq2hPbFo7Kjk6RlOi5tVc8L6vxBcYzRuCNhYwIJKTL
	1GV8OdDvUcRNITwLfq/wtL/4A+nufYvjP7m07xs4m0roSNrwcr7bWBq3NLKDYoHM7Z/fM1oQu6F
	T8JY2L9CJkksrik0pf5lFx056M/BjHZikrTR8iM7lI4QDzadBOUd2DkbJDBCKQZ2jw/nyx1jO5W
	ybQCJZ7fe5fODWY0tC2k1sdmh+gNWXqE10F/cf0Peg1zPEJh4v3ZANB7hFK6ZT1L+yXh4B05HGE
	jOgVsMHe4eANGT/izlNtPab0qbe/ZcQHV57GJPEZkqPZWndkBZJiz3UzftQvlPJMBnm6J/YLMtJ
	EiiXIZ6kxAVzaxuKk6zdR3QSC+k2xe7q/1ZZNDhGyFXR51qGk1nUwSrLqHUUHws8cnLJSriDPxD
	ya1IAORhbRYVeFUrTFpvzGnVwScwPfcd5+M1W9nT/ZFas8wBKGYIA3BSCVUAd7LL6N3KazSq8/S
	tpe1BPcBwn8p8Q31AJpWC3PnKOQ0bs2CfaJ1aKpaFYpow==
X-Received: by 2002:a05:701b:4512:20b0:143:297d:21f5 with SMTP id a92af1059eb24-14503fc5fedmr228574c88.34.1790195508236;
        Wed, 23 Sep 2026 13:31:48 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144f983c5a1sm13276486c88.7.2026.09.23.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:31:47 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	ojeda@kernel.org
Cc: atomlin@atomlin.com,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org,
	ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	pgovind2@uci.edu
Subject: [PATCH v2] rust: module_param: Fix potentially incorrect access of `SetOnce<T>`
Date: Wed, 23 Sep 2026 20:31:45 +0000
Message-Id: <20260923203145.18714-1-pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1789426258.git.pgovind2@uci.edu>
References: <cover.1789426258.git.pgovind2@uci.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `set_param` function casts `kernel_param.arg` to `*const SetOnce<T>`
But the Rust module macro in rust/macros/module.rs initializes `arg` with
`#param_name.as_void_ptr()`, and `#param_name` is a `ModuleParamAccess<T>`,
not a `SetOnce<T>`.

ModuleParamAccess<T> has default Rust layout but `set_param` accesses its
first field SetOnce<T> assuming it to be at offset 0. This is not
guaranteed by Rust and could cause type confusion leading to data
corruption.

Fix this by casting `kernel_param.arg` to `ModuleParamAccess<T>` and
then accessing the `value: SetOnce<T>` field.

Fixes: 0b08fc292842 ("rust: introduce module_param module")
Cc: stable@vger.kernel.org
Reported-by: Dylan Zueck <dzueck@uci.edu>
Assisted-by: LLM
Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
---
Changes in v2:
 - Split unsafe block into two separate unsafe operations
 - Add safety comments explaining the unsafe operations

 rust/kernel/module_param.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index f9a14765a926..1a2fcbf4a5b3 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -74,8 +74,13 @@ pub trait ModuleParam: Sized + Copy {
     crate::error::from_result(|| {
         let new_value = T::try_from_param_arg(arg)?;
 
-        // SAFETY: By function safety requirements, this access is safe.
-        let container = unsafe { &*((*param).__bindgen_anon_1.arg.cast::<SetOnce<T>>()) };
+        // SAFETY: By function safety requirements, `param` is valid for read.
+        let arg = unsafe { (*param).__bindgen_anon_1.arg };
+        let param_access_ptr = arg.cast::<ModuleParamAccess<T>>();
+        // SAFETY: The `arg` field is initialized with a pointer to a `static ModuleAccessParam` by
+        // the rust module macro. Thus, the pointer is valid for use as a reference.
+        let param_access = unsafe { &*(param_access_ptr) };
+        let container = &param_access.value;
 
         container
             .populate(new_value)
-- 
2.34.1

