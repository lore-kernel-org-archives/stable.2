Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17788572675
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201151; cv=none; b=etDhWzYHu2lryuR7mjL+8JskCmYxlH8VFl0PE2h8FwZZVbAzlb7fz0Ayx9iDbhiprMt6z91FBr5YhVo7+Wg5tPE3V7hoGG/gWcy939g+/UC59pHBnXprR721fxdBrG+BfWuDEAxTZu4tDWuGRIF5nc+fJN6mP6lt1CrKlAfVB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201151; c=relaxed/simple;
	bh=K2axbYRQNW+6vDySUPFdJODepbCos+4GY8IGWK9+sB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uCpfadldOP1SxBkna/C/6PSsjJwzkwuU3vFoXRS+bE21HMzhAmuzDc/EgwJnDeOmfktoiJESTRMLy7Ef8PZ0dV+LVw8k+T4LMzUJytkLGOBtMlITzYGv+kfDMU5UpsLZxj4xX1tCZI24bXUnNAGOih2SVKESpJEEh62IjApAFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=PWohvULh; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="PWohvULh"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664d340aso914992eec.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1790201148; x=1790805948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q/nnxvPu+Ie5/oYJqt1aHS/OFcFQN5Rkx07F17u0JBU=;
        b=PWohvULhtq2cuD9UNRoKn05JKrY7f5Q5fbpkJ047o9ms5IdsRkxyk4+fEPLuXYsxCF
         KMaZYptWRuPKMBz85zizxXHOSYsE6xVh71JartJd3a3CrYbPaWPN328nH7lzCBBkC07T
         OoeRAs3x+48ysJ8s5rNy46vvUWIlVfoc5NbwSyU/5VEweUocLkpXTIgzR9ZQIWPXdFu5
         n57ThrGOvJVgfaRi74aDNblWeRG0pCo98EsCh6SRZ2CcNZh7NxERflkthmIfF8/fAExQ
         nK7lSnv2NhMdTQcVzKvAoPzuHkRSw6rTBsK6lfAVEhfGCbDMGXSSYYLUK5EtnzPwV4y0
         s5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201148; x=1790805948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q/nnxvPu+Ie5/oYJqt1aHS/OFcFQN5Rkx07F17u0JBU=;
        b=AeqtUGBChRoCaVK0KSVzfLYlwuCub9QMhzOzkxz1u08uBuGdwcbrpHvjLbtcv18Nzo
         wnXLT1y/4vDa73FLPuwK+gWzRCqKEjZCNPAtoL8A6en9TZxItA6vmyy8bCJDSI9q5vLL
         gVXekyKrhppLc4eTYpoWfl0w6/P2RFNvUnJATwREEYKAYpLaKI9PzaHyv0c5rnpM8suO
         SAHMI4Hev82P0fG8ZTfu4JakuL+NTaFRelDfZv7CqbO8iCUedSH4jMK9Q9HNQu6SpWXz
         YQBfgJy6thLS8U/RZhDphHveDzIcRWBVaaMZC0d0mMwVUEQ49Z3XjR/rcP5OvkSbA9Rb
         zF4A==
X-Forwarded-Encrypted: i=1; AKwUvBz0N57RJioE+lFUsj7Yvji4uh+nWWKOINUeohqQqrCTLy+16IH3gPaIRdY8i0QGnvSL0QsfQ6g=@vger.kernel.org
X-Gm-Message-State: AFuF++mMkMUKksxLesFZjUJShhHRaXLJISRv/pXGrNazflqHMon7+YKr
	77wIoje01TggPvk7xiaRSoBIl55uYOOUJwJj5XB19zpOWnVVkVN0B9F+f9BTsRK6XXY=
X-Gm-Gg: AYBFou26EFZ9Awz7UWxEfgTRJtv2fBkNu0FRvbK+da51BFagQVskw3li3TKRsL8uOSs
	Tg4eVsxlDEavyIXqIcH2x1R4fnPgaz+iOEmIjdQOwkpX+DJavD9V0pfihPMlmR4b8HuHBVs6bWa
	LZYnKLegs/s9Ye1F8P1j6ceFnWYiWR7Vvogc+tgRnJDkXVIdIQ6koP1ydIYXpVYv+eND2MYtD/R
	vG0v/7TSTjW/hasmGR+Vd0MXzsTViWSxZ7O1wBJE6QLDS6hTBZ2YP7uyzMR07iYo17vFLvzkLop
	pR0sULDebIDkEqoA1UycNO4dAU9QWsgMeKMwmEAT49zuiQ4pbTmFCuUfg168aY8gpJr4t/uAvss
	GAXVAcw+q/+av0IIw77x4NBfSr5Pgst925QuVZonQNhhvN2USAnKyflVrzIzhi71Y0NuOtXBBS6
	GVKXn57Yat+W3YwN6NQtAks0EMPeuxB0TWiduvVnWZn1OBgrHhmUrtxVtt6M4rIdUXXMYkPq/Qp
	Gm76kQLGdxFO8GPtXPwloRHYMVand+pl/HijKuFlBYh+g==
X-Received: by 2002:a05:7301:7bc9:b0:33c:e91:271b with SMTP id 5a478bee46e88-34001220f83mr451635eec.36.1790201147964;
        Wed, 23 Sep 2026 15:05:47 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e96946d0csm9038456eec.21.2026.09.23.15.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:05:47 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org,
	ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	pgovind2@uci.edu
Subject: [PATCH 1/1] rust: configfs: Fix incorrect subsystem root check in `get_group_data`
Date: Wed, 23 Sep 2026 22:05:45 +0000
Message-Id: <809b66930e6b7a47535c87366b193695f420d2df.1789770689.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1789770689.git.pgovind2@uci.edu>
References: <cover.1789770689.git.pgovind2@uci.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `get_group_data` to determine whether `this` is 
subsystem root, the following check is performed:
`(*this).cg_subsys.is_null()
`get_group_data` then tries to read the `data` field of either
`Group` or `Subsystem` structs depending on the result of the check.

But the check always evaluates to false in `get_group_data`, since
`link_group` in C always populates group->cg_subsys with a valid, 
non-null pointer.
Thus, if `this` points to a group representing the subsytem root,
the incorrect branch in `get_group_data` may be taken, 
leading to attempting to access `Subsystem.data` as `Group.data`.
This is type confusion that can lead to data corruption.

Fix this by comparing the group's address with its subsystem's su_group
and updating the safety contract of `get_group_data`.

Fixes: 446cafc295bf ("rust: configfs: introduce rust support for configfs")
Cc: stable@vger.kernel.org
Reported-by: Dylan Zueck <dzueck@uci.edu>
Assisted-by: LLM
Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
---
 rust/kernel/configfs.rs | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index cd082b83e9e7..c5fdafde0107 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -295,7 +295,8 @@ unsafe fn container_of(group: *const bindings::config_group) -> *const Self {
 
 /// # Safety
 ///
-/// `this` must be a valid pointer.
+/// `this` must be a valid pointer to a group linked into a registered configfs
+/// subsystem. Its `cg_subsys` must be non-null and valid.
 ///
 /// If `this` does not represent the root group of a configfs subsystem,
 /// `this` must be a pointer to a `bindings::config_group` embedded in a
@@ -304,9 +305,15 @@ unsafe fn container_of(group: *const bindings::config_group) -> *const Self {
 /// Otherwise, `this` must be a pointer to a `bindings::config_group` that
 /// is embedded in a `bindings::configfs_subsystem` that is embedded in a
 /// `Subsystem<Parent>`.
+///
+/// The containing `Group<Parent>` or `Subsystem<Parent>` and its initialized
+/// `data` must remain valid for shared access for `'a`.
 unsafe fn get_group_data<'a, Parent>(this: *mut bindings::config_group) -> &'a Parent {
-    // SAFETY: `this` is a valid pointer.
-    let is_root = unsafe { (*this).cg_subsys.is_null() };
+    // SAFETY: `this` and its `cg_subsys` are valid by the function's safety requirements.
+    let is_root = unsafe {
+        let subsys = (*this).cg_subsys;
+        core::ptr::eq(this, &raw const (*subsys).su_group)
+    };
 
     if !is_root {
         // SAFETY: By C API contact,`this` was returned from a call to
-- 
2.34.1

