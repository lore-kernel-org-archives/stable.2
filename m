Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858682;
	b=iWykmzDVNZILkP+6hqOXPE2i1v6M+VKwua50dVwE63lAlBa3/ILn6rx+Kte+u6+Xv+Ks
	 CszzMLWaJWRATfZbmEq0O4OsNb8i1BCTeDBRXy7HX5qX00NIZsK0r12fXc4JY50Z9Zwqe
	 t3jxua1k3rDJMvF7qvL5K3zeFJAM5wrWOtWCSucQtOGIvOtR2Pywt8zdD/LjqmZr3vkMx
	 j9xudm9MjWph4ZrjuIC29I3rhuWNfCVA9S57bYZV8+XMMdnN2UJ1CAzEPR5Y1wwsD7lFL
	 XOwb+Mv7908ZEGsBvFI9mvqocsSnOxW+mP46LV8r1ssoaxVrVY5QfHTUbEFEN/GaDvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YPu8h0jDpjB4vijwFawJAErayo8SO8CuvsZ0ZVqanQU=;
	b=VzvcE9C9YIolgLS69jSWZ+C+n9zWoLwuFqQsXtdso8HjLnrEO7dCAlX+0E6Zx74ek0ME
	 Z40fL1h+V7gfwysNThHWHumy03+OwBJVY2zqSRH8wg4RiLMiqs985yDnWIV76l9MADMP4
	 eOMAwidcGaze6+fhtovYnecrdhh9KUwhZoB6yjLOSTbM7gTyUvO0MPBy0GKmkwhk0Asow
	 ip9J8UZKArp5WanxNkL0+UNzoD0eW/GF1uxi5wuks9FlsAJ/8IfJyhXgmitEmutityc3T
	 sliN0Wr8/VtX03ww1SDzNUI/0Ws1Od+BRE9PPMEexMcRwz/mpfyFpdd0GQRa1JBDqaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L9foHbIz;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457F606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A457F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L9foHbIz
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acb1224533so245149a91.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 22:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793858681; x=1794463481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YPu8h0jDpjB4vijwFawJAErayo8SO8CuvsZ0ZVqanQU=;
        b=L9foHbIzzFITZMHdneZN2RIlEiH9B4iUkZdQWFIjSW+8AZyIZYb+1M+gOJuej7daN4
         cMwLt5VkIkvHEpL80W0121MwVk/F9EVgEa6IMubRgptzS/ybSoEG59azSZioaMlR5mSJ
         vxchDSBfcz4jpGT9B7mRNJln/GT24Tl5RHnVmnqwAhLsGu/57BgTb6zyEHeZObSxZulj
         UBFzRxQ4ob08QC2VCRe76hn6afFmACfGcqjoUG2LjqXA6qokONwY9ZA8az2SWmE7Y5g7
         V6UyhBssyUPyD/OnnXF4t0AtLVSHiGtW+lLmBSlnKhwGO/Xetngng11ortACtm05irUC
         aN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793858681; x=1794463481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YPu8h0jDpjB4vijwFawJAErayo8SO8CuvsZ0ZVqanQU=;
        b=mOOQKcXgjmsM5X6M+y8ZMFbDJDXk7/CEsOGY+R+OBPMEnbNQ53DwZjrUqSBNYJoUmE
         An5meI5Ou5kzjVZCmXsckCXH2AZVy5T4LlmxZp1IT6RwdNb3KQA0Bb1rxk86q6L/6RO9
         bgHn34kMauT2qiPMzulymt+DpP/2FnMs//n+kIFP2JSJb+wxZhWxIaX9jKnJ1SQ46fgz
         aXO55o553f7+Vw0UAiE9pDSAkpEEKsXR7PwD/q5CtG2oXHfb+di+DkWvqLDNNcWAgPYc
         4cnwxsZZJOWNDWYCLfcVYZRhsrA0LA4Ou34t8Canh0IDNoYCUAYd5Vx75badBFE3PuZs
         WkTw==
X-Forwarded-Encrypted: i=1; AKwUvBx+pLrcqNztTlAU5VvpweCw1Tuba5Bmaqi8prC5VM0GuVx8JrKXORjyTggBAH1r5xy81HrXgkI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CiAqmTi0HR65bnFfV7FG3WhbEmo1Lc0wASO0p4cDdBJd3fVys
	a0iIuAUiiplKA+sZePBynxjymA3l4dNHFKEHP40nhUcUsc7U0g+gyRqw
X-Gm-Gg: AYBFou1UMweZTg4IDqzQxRJbpFcmtPzEN5IL4Xcy19HL0+BxDLRvzbMaXMsITFWHp3N
	/VO9vjX72RRxGzr72zBY/zmCGK2IIaSsZ7YDI9IRDCMQFITUGfaopNKPN+uVSqDzxzLjp8lwhWA
	JHQimYZpNAeXfwGuARI1L1zfj/42CrDZ6nPG2fX3DLLH3U5LJa219971FZ6rimFsQk0yoz7on11
	zwdqSk+SL28wL3UPoOBnz0OQqk0bi4YaFrYhwYhT22ZViSllwqbJCRFFnJKnA6qi2TOGup39u0F
	WHX8DV2q2ZmSPkWq9xy9i9YwIu+7EY7wjlDHro9DR4AMqYlccAVNcJGgTRbckBtE3v7tnhgjZzL
	PivQpsue51IvTqjnwvbhMmFRnjJXCGLsFx6aX5VmZrln0oKyHi1NN/NKTkXNXC0PtY2PNkv3zJb
	c1DQfa0FhezDlLL6B6P8AsyfK1u262bH9YCQ7btZEU/Cac8koJY0Jhnf/oDxsGnSLx/fxpA/DO3
	/Vwt5LdTmGIycYOwtslU7E7ZJEhYlDO8uXRo6fGteSPtvwjBc2y66Yj+mEZP1gkzL7zhxXKW3W1
	QgUUFbTF6SmxFSucWpC0YWnkxn3wWJem0d3chWMwwg==
X-Received: by 2002:a17:90b:1652:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3ae895a0406mr26169727a91.1.1793858680988;
        Wed, 04 Nov 2026 22:04:40 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c0dcsm2093100a91.1.2026.11.04.22.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:04:40 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	ville.syrjala@linux.intel.com,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	stable@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v2 1/2] i915/gt: don't store ERR_PTR into ppgtt->base.pd on allocation failure
Date: Thu,  5 Nov 2026 14:04:21 +0800
Message-Id: <20261105060422.51848-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261105060422.51848-1-lui2012qwq@gmail.com>
References: <20261105060422.51848-1-lui2012qwq@gmail.com>
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

gen6_ppgtt_create() stores the result of gen6_alloc_top_pd() directly
into ppgtt->base.pd, and on failure the ERR_PTR stays in the field.
i915_vm_put() runs vm->cleanup = gen6_ppgtt_cleanup(), where
gen6_ppgtt_free_pd() dereferences pd via gen6_for_all_pdes() - with an
ERR_PTR that is an invalid dereference and a crash (in the async
release worker).

Assign to a local first and store into the field only after it is
validated, so the field never holds an error pointer; on the failure
path it stays NULL, and gen6_ppgtt_free_pd() now bails out on a NULL
pd.

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
index 438cd4724ac4..f747ee1f96d7 100644
--- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
@@ -259,6 +259,9 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt *ppgtt)
 	struct i915_page_table *pt;
 	u32 pde;
 
+	if (!pd)
+		return;
+
 	gen6_for_all_pdes(pt, pd, pde)
 		if (pt)
 			free_pt(&ppgtt->base.vm, pt);
@@ -427,6 +430,7 @@ void gen6_ppgtt_unpin(struct i915_ppgtt *base)
 
 struct i915_ppgtt *gen6_ppgtt_create(struct intel_gt *gt)
 {
+	struct i915_page_directory *pd;
 	struct i915_ggtt * const ggtt = gt->ggtt;
 	struct gen6_ppgtt *ppgtt;
 	int err;
@@ -455,11 +459,12 @@ struct i915_ppgtt *gen6_ppgtt_create(struct intel_gt *gt)
 	if (err)
 		goto err_put;
 
-	ppgtt->base.pd = gen6_alloc_top_pd(ppgtt);
-	if (IS_ERR(ppgtt->base.pd)) {
-		err = PTR_ERR(ppgtt->base.pd);
+	pd = gen6_alloc_top_pd(ppgtt);
+	if (IS_ERR(pd)) {
+		err = PTR_ERR(pd);
 		goto err_put;
 	}
+	ppgtt->base.pd = pd;
 
 	return &ppgtt->base;
 
-- 
2.25.1

