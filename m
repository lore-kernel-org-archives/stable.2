Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858687;
	b=Reikml5igfDQJHd5BblBTvlcQtoAFYTYluMYee8eHfrARrPe6xvwHVCK1LVVt3ZRXu8i
	 fxANE1+2djVSR0Fl9ZSYWk+yiJIy7g6SJMl2LMZFUDkFG9d7RjdEcErQDhBEwdTn1CbyH
	 9hkCm7oWvtxF8/qnMrU5dAZAl5IGyEqCznBRzbDurd/CB/n0GVNOAgeM7Dnmx5jUzp6RB
	 eVOJxwsm1YUVTwwzNt6qOtfnShc0c9cgXn2OelnLTJNjaUwUD7YjIk58VeYkaN1G0RyQz
	 XlDLrzgJoWAqbCZpbAjuVAyac/f2U9lERaqsfOsfJWVozgaESbMwYxwxGovqmMbcrsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qq/4vwt5KZIiFWaAeaK5UibLMyaTMg//P8AG8snjRNo=;
	b=g2MFXf+b5n9CMuAwbjz9g6mtCYPZJxsbANMTKPZhhEbJ5dp1p//LTwO+4Qj3utuibdMm
	 dW5Ank949Q8orUi9DTNfZhNO+Ovd8hgvAt3ZkNlftH0mqG67Py4+UiTiLCwMDT+De/GBu
	 CZrdnDEhA8zXLgmwGRlmx+ksA/yKHyyc2Ub2TITkNVOYUfhHY9GWqkMng+Ga7YCFyLiZ8
	 bQwZ4hJJ1NkTUgB8oiibJai233B3Dze//IKy4YrXRti3cd2c/hiR+7x/pmw5CUm9RRr/m
	 xBcx5Mjg3qrsIIZkr4N73KZMcSSJWy3M8k34syYR69LWp1h3om73+WWtIJFiA8Nbs3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x0jsydmY;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFDD606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FFDD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x0jsydmY
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3acb1224533so245155a91.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 22:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793858687; x=1794463487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qq/4vwt5KZIiFWaAeaK5UibLMyaTMg//P8AG8snjRNo=;
        b=x0jsydmYz18XSDwUugYl5mIBDYC+RltVy5DCZGxBIAPvE50cdNznU5CtSNM4xoWA+M
         VCpaAUtO9vIb359etix3sIYra36L3L3VXFx0hIyfAcynEwbp229d9ac/D75d/mTCrOT1
         JCLBJex6aA1Fcj8FWLHw/OBQVVLKHmYKtSxVLh675yC+OYw9DzlDyn3Fn0yeisD1Ra8Q
         l4mmXgV0jqKqEqek2T6DSZHb5930Gba2LgOxghqgkFUl1abVBgznYHv4M0sWglCSkRsS
         ptOy3qi+ldR8dl7HT+nCaJR9vmmMXfBdonLUYFB6S1FRH307c0mxsvlaPyZ5NKtjyMCG
         TkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793858687; x=1794463487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qq/4vwt5KZIiFWaAeaK5UibLMyaTMg//P8AG8snjRNo=;
        b=ruRl6RErH37Tubqw966w/Gsm5HATZk6SG3BrGlv2Sp5nOsrUu8XQvLPgtdmNKEERXH
         pTmZ+QnC/ULBh5hKm43WYFsWsOVPJFDVF65j1qWGF3VmB7SUryuJZuyc1b1+DXhSvLT+
         jBD7kVXo5i4uEQoqLi+Wi96DczsdkJiy/1vS5sEtMEIQP7QEftvkG+aL1q9u3zqunlfo
         y2uMrj2LGRowpC4xE22G4bhemzZCR1Pb9NPMz2KpzgJXRPEgREtRQGsOuFL+Jx/6VzwX
         2Q/x0MbnjYLoashqGRdgjypYQ/Vpi5yBNo6VwlsTA93OB2gc7cf0SjAlqAivZdR+rSpn
         +Q+g==
X-Forwarded-Encrypted: i=1; AKwUvBxVW7JIk7G+4QcrudXnDQQuL9nG+ZCPnotsLmOM65GcwKqvm1HKf71mLR4v/8KJxNPjLGSldCw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ojulWsy7dXaINtnKvAXXcqa+Na6p+ftvtQeK7uvFARgbZjsKV
	+sKqmq9/edK1k5im81nc6dIQUl8qJdyW7i69SUrTfF0hOj636uriJOg6
X-Gm-Gg: AYBFou2apboqhxCoPDJ/7apS6wSDfz6vqHN6+oq374xrby9o77pxpQ5GGEsV7COm4BX
	13xONT8zT5xmZ0Sa2HeBaooEgeer86A0BG5HeRGZgXR8eW5BpM6g23WCfrcfJ27tB3nEwhssPAq
	kILtAu4i7n9dPcZoby6Z02SGmCcrmgKQasBk7HfYy39Q5WU8ttdHjB37H2fENsbktA20JW/6hFE
	9SJPcJP592AzbKQ7iW5H4h/HNYtYJY1lTa3vG7NPP98lNgR/yTGlcLs8c9tzR1cdWbcK8y1FPiN
	vTu/NFeE4oJUiAAZZf71+NzyAXdJszhbjCQAN2OwnooVw6cJB7panX0Ydb/1t3ecj5iI3WOciP6
	zZzn3EYPGgEch5RQUAoZmpcppyWY+Yv7hdoDGl1D8IUVX+XGc0X5C4ius5/53lrsHlcLijgb0bQ
	NrVIASGiZGE84Nq4IZ8jJbbi3KCiyp0t/SsebMz0kJqCDkqPvg+T5V8IG+sFWDfKQvo4+SnwBSc
	tvf+Iy54Az1xkQqEiOlCOkRucpAPvjEoXAiwoCbRGuxKnOI1Es/EZfhTYjSeDqtfNth1bvLomJA
	xshFfK5siBNydam3wLtMZ3mvN+amcpUe3FHJBfxc9A==
X-Received: by 2002:a17:90b:2f4f:b0:3a0:c162:51af with SMTP id 98e67ed59e1d1-3ae89291df0mr25913696a91.0.1793858686515;
        Wed, 04 Nov 2026 22:04:46 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c0dcsm2093100a91.1.2026.11.04.22.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:04:46 -0800 (PST)
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
Subject: [PATCH v2 2/2] i915/perf: remove sysfs entry if idr_alloc() fails in add_config
Date: Thu,  5 Nov 2026 14:04:22 +0800
Message-Id: <20261105060422.51848-3-lui2012qwq@gmail.com>
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

i915_perf_add_config_ioctl() creates the dynamic sysfs entry for the OA
config before allocating its id.  If idr_alloc() fails, the error path
drops the config reference via reg_err: without removing the sysfs
entry - unlike the normal remove path, which does sysfs_remove_group()
first.  The leftover attributes point into the freed oa_config; kernfs
only stores the attribute pointer, and show_dynamic_id() reaches the
freed object via container_of (including the show() callback itself),
so reading /sys/class/drm/cardX/metrics/<uuid>/id afterwards is a
use-after-free.

Remove the sysfs group on the idr_alloc() failure path, mirroring the
remove ioctl's ordering (under metrics_lock).

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 19b82427aa41..40385f991abb 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4716,6 +4716,7 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
 		drm_dbg(&perf->i915->drm,
 			"Failed to create sysfs entry for OA config\n");
 		err = oa_config->id;
+		sysfs_remove_group(perf->metrics_kobj, &oa_config->sysfs_metric);
 		goto sysfs_err;
 	}
 	id = oa_config->id;
-- 
2.25.1

