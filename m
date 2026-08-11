Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791944A3E8
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459846; cv=none; b=HW8Z2nPyN7L2gNRmbH8kBkI7pMbLKT9zvSmuj5/UU1Nmt4wwJupI6faRKcxHdFOBi4Z9nf6Qqcr5GpQET+O1vWsajO2i5oW/EZXf+MhdxR95vbnpgJgM08e5jPJrbzsA6FNxZsNdmOf4JdS3tlZ2w1k2APVl4XdaVp6Zfj08Ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459846; c=relaxed/simple;
	bh=vy+nPDagugMSWoUExpKD9Ehhgvh0TW20gsx0J+TtB/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqOli4XDkl2P7lPIl+dHZKg5qYevuo8IPHTKoRb3z1O791Wukwm0guRZzt2VVlOrIVDM+nLqvX3lvdvaYqNdJxGmP4gqFMiZBx3h5wm1HOBPaYHmX8Jfr8FpypDMKJRYPnpk+nDf71pnmVTkE8vOvYWyZKWymAXRQcIpea8JP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzTeG//l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzTeG//l"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f7027ca11so2086963f8f.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786459842; x=1787064642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YQuA0ZccQt2j4WPVeXgq72Tc7MReF5AZhxZINUavJhs=;
        b=QzTeG//lzHo4Q8oMgSnuk7EImtit6PZ7hrmbt6MX6dPt66vp955Z2rhdmMxKuHCYwY
         P6M561VwHNjs4EkRsM+X/B1YnXJ276WYL6g3o6zZwaRoo+VcaSb0+XCdeht7HIeyXby2
         I/L0KpiVFBOvJyVrZXL1c6OXEyaYilIhXxBPwnM95PJUeq2dpHfoud0PDAiru/yC7X7f
         i1DG7kwJ/KRAe9Ydt3s7HsmGLHY5ce11jGVzIN5tAb34J7FpQB4Q1exmVbwa7Z3wLNK/
         JEKa4phPNjsVEbgxKzVKTKLRSHx2Z+P1OAxE/+/lTdO/MBZGK8eM4J7ySQ8hZJ4r5MHt
         badw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459842; x=1787064642;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQuA0ZccQt2j4WPVeXgq72Tc7MReF5AZhxZINUavJhs=;
        b=R99s5pWxB0FP4BS45x0wjMVeqgZ/trF9cSj+Vjqltag7M4u5pR06zclpN1iaCcBk4a
         sc8s/3ME4vuGsrxEeGNwcaByLGqCQXMQDh2l6Ng1Nj+KTm6B95SD2kXWt0zs04w13BR0
         VpLCjybwx89/1SoxnooqQIUm/WkdliQ3+JEZbD20xeqVK/5s+V/TlgtECnMrfAbPSrQN
         EfTcjn60Pz4/Sge/5DFuYRkJJaUVL6BnzvLSSLn1SyA1be8AYDS7hQCppS/vDu+O5y90
         +9huVG8uZe2eqIOZ4nPuCGjezmeHGo/ydxCsQ41NfwbK4IF0Nq41DNxkE2JQ2OGH8PQO
         EqGg==
X-Gm-Message-State: AOJu0YxoGGiiRc6HXtfzItBOlWWENZ2XwvEA+7S3ej5ojgDKyMQOIrPF
	cl8K2LBIXXhRACJJ0l9FUiAhFu5dc5WSk/7b3/X0tKt8+KxHR8N0Tf2evf2UXQ==
X-Gm-Gg: AR+sD10btQezbyqxgv6ilaMxoMCB61cEAd18kulSRc4POosLrSl++iuqX1ggqURiwze
	itMjmZkVj46naNpqZPy0Mi94gFzb+fl/2pKRWQuQNl0LOVDeVn1kSgXmECCW6xPi1lLoacn/Y6w
	a5ZyzmkBdbEkw+n5EbkZxPYPl7igMisF3GxvRz2TRYfSOFqjZHBnG2ZeXJzL7/75nxd9jY+OTvJ
	TToIxhmDgWo0jBtq2K/PJL7/1w0tMN8ZMQ2ZgUjUMlaeLtGYQ8JhByzsT45fxGQ7XOs1/+qxRk/
	9DFre0nC4CywJSXFcHSH1/bbRx9jAY1txMNFFOAkBr+nOJ7fnSS/jb5LxWUQliz2qcPdlcgRAFz
	0Ul0jAQKp6UeCKFJd6eU1TPw24lf3imCraky3FSoMBGCafMV8RB+XEs+ca8cOC7jKP6cMJh+g2W
	tD6c3JxHXE/xIw2SpDq2l/plz77eNozZCAukk25URQ5k5s8J72Oy++fETxLWSIXFDG8qeqHVZRv
	rtJyJgmOc6jzYgtHwqklerNMTLJKnot3NmHXTMtnsfjWRhLrtuSrRVMrnuT4Ntk
X-Received: by 2002:a5d:64ee:0:b0:47f:f4b9:88b7 with SMTP id ffacd0b85a97d-4814ad7b612mr7221198f8f.1.1786459841608;
        Tue, 11 Aug 2026 07:50:41 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72cea1sm5646271f8f.37.2026.08.11.07.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:50:40 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: megia.oscar@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v5 5/6] Memory leak error in qxl unbind
Date: Tue, 11 Aug 2026 16:49:21 +0200
Message-ID: <20260811144957.69900-6-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811144957.69900-1-megia.oscar@gmail.com>
References: <20260811144957.69900-1-megia.oscar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bug: ttm_pool_mgr_fini() does not destroy the list_lru.

Fix: Add list_lru_destroy() after ttm_pool_type_fini().

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 46e13707493a..b9251dc22cef 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1575,16 +1575,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
  */
 void ttm_pool_mgr_fini(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
-		ttm_pool_type_fini(&global_write_combined[i]);
-		ttm_pool_type_fini(&global_uncached[i]);
-
-		ttm_pool_type_fini(&global_dma32_write_combined[i]);
-		ttm_pool_type_fini(&global_dma32_uncached[i]);
-	}
-
 	shrinker_free(mm_shrinker);
+	ttm_pool_type_fini_and_list_lru_destroy(NR_PAGE_ORDERS);
 	WARN_ON(!list_empty(&shrinker_list));
 }
-- 
2.55.0

