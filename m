Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A93432E6C
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702031; cv=none; b=R/CDV/M1tEXSk/RSFykFUwCpIAcZEQ86xbLWDTdpV2ODhYtAN22TxRChih5Znb9rAmI8hHFFLWlu3Bz93JKY3ZZDPt5yECh4yH6IDdF9Y3zC0WXe/tRQZP7SGoCAL1kJG5w/lQHRLNFpe5rzgNaIMtZywETRiBLFIayuyw1jrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702031; c=relaxed/simple;
	bh=LoIhzbp1d0ZeCyz04+M4Kj98e1og5GRRnFH0MNcdZ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXapZO/DjrZkd9N/c4hnY+qt4KY8IEkLtRuWtIl5cX/rpUAQqISh7MXXOq/Nlx0jgMxnYGCOTFST98Ps6O53VobQ5aTUM7SxbnKdVLt7sTCXFQ8R0kHdcpxhqOCvbyQk1p4M8qyHNqW8Ur/rSEKiKMqOuKFlF2E9XOAcaOKbUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=jPl2XbXe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="jPl2XbXe"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4816084e128so68105f8f.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 03:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786702015; x=1787306815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tf6RM9xJ3M1kyDotpVdoqOYX5D/YfyoZJR50szLtwT0=;
        b=jPl2XbXe7gHE9iJy2RUnAfE8Z89JF2aKVNFPvWeghueiDRYlmEBOah2C2zV0gd0v6G
         /JVz3SatvxJmtpQeb5t6qnpqbkaxgxzJAvKuzZxzxq785hTC2c0E1rLckcz+0inwzMBo
         ccsXVdpHDFz4mxgvLQsV5Wv3FDStwK6Q8thQP+aNrn20iZN19y/+eonMyPKQQ2JvMXgh
         aofN1zrALCjAyeSutnMTqEndE532yAKe3cvedu3kn+2wVZP2F7hDX7ToLSi0rFxkP3cn
         pM5oWscB5zQ85XVcBMiMYy6Rwnvbq6FnVV0zbMAOXyKwLR0Ii6y4LI9ov+lNaRbKVhm2
         MLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702015; x=1787306815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tf6RM9xJ3M1kyDotpVdoqOYX5D/YfyoZJR50szLtwT0=;
        b=JBuwflumieerTPeOLIZkzkKinmbqOqPDV/h3qLjTwG/Xb0oqeZ2XwT1MazStTGtdy2
         Z6UOEbi45iVjxoMmhsFyQ9RcuNixh1DJhlHGBV5PbPR15QA5NYdvCwJLNOO3QWqlBKcc
         fk5ZobGBcFChGKD/2vtUKOjSaFp3hYpJfqgPZOrwFgqeD4SzJ91ssJEo1MLaQArKxz0B
         1CsmP7iigyUc3UdO95xusumfV7jTNB1zsMrXmgtNsOzap6oUyMFVq27FZufAUbF8bo1H
         iFWpiHK2x3RTAXzLKzeeN+/H7arOBhN+4l7+uHJyVWRgw/qmvbJ0TvsJwc4qQM+ecy5T
         6lAA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+LMZHUGcq++LIMJGk4l0uJPdXMvvXyUFSBYlf+oalFAqhWbH3u3DIWXMwqzKburnOSm/fkrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Jn5TmxJE051caVAuhIH3sGWDgpocp4VGVd56FqehtVihMz2D
	fQ6KLdzjR3o1ztId5+ClVi1SHDxA9X/lXOAh1ryA4IWspdR7+C5bKTooA8XU896erKU=
X-Gm-Gg: AR+sD13uUFawJCOKDwXqrWh3FQ0sO9WpQkLRotPQMk5tCOLk5f0QKilWB7QbUnyFGV+
	TYDvtbqE+lkV2LBcfn67QsIjyDiLgt9XwoJlFABCef0RCw/Fr4O7Qb0bzho6Af+pKEPzGs4F99b
	eenposKfLjf8a1lnYNd2OhUZimGK/1DUpFcvLVV7zzzNogXKKjPXxnzltOF9iJRa8Kz2NRvhmgl
	qJA45HZzJZB74bnEksnwNWECh2oI6NMdNwywUOr7tUvZl8F3y8ovhWDAT6GImtooNe6hleKr0nT
	NTR/BM68Lz4wMyPxNfhiQfmidzagGdPqNDl0/Vny5ABHPTIpOHPduPfudpaxCMTtcsP90KmNyRc
	NhGHUsvg4hQKfO9Endv8mUVGvy1EKUQEZ+rN5CTy9Jwa5oc6jnWd2UL+vHaJgL+gd6ahWD7qrQC
	ictdmBOgT25zsQgxoH+h0Gt8YsuhFO3Ug0P/o/FHwa0L+L+uulwQnM1WOiYEyb7dZtYRr0CnbSi
	S2hRXxvQPWIOPglZ6HvU3vtvJTSoZge0lXx
X-Received: by 2002:a05:600c:3b1f:b0:490:ec79:3046 with SMTP id 5b1f17b1804b1-499878d463cmr31750705e9.0.1786702014957;
        Fri, 14 Aug 2026 03:06:54 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net ([2001:9e8:144c:bd00:56c3:670b:dfc6:d046])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm6948207f8f.24.2026.08.14.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:06:54 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: dmitrii.omelchenko@cloud.ionos.com,
	Ashish Kalra <ashish.kalra@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [stable-6.12 1/4] crypto: ccp - Add new SEV/SNP platform shutdown API
Date: Fri, 14 Aug 2026 12:02:54 +0200
Message-ID: <20260814100652.225499-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814100652.225499-1-jinpu.wang@ionos.com>
References: <20260814100652.225499-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashish Kalra <ashish.kalra@amd.com>

commit f7b86e0e75bc234751cb7a82d888083a57ef28b2 upstream.

Add new API interface to do SEV/SNP platform shutdown when KVM module
is unloaded.

Reviewed-by: Dionna Glaze <dionnaglaze@google.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/crypto/ccp/sev-dev.c | 9 +++++++++
 include/linux/psp-sev.h      | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index d668f9318c28..7c05cae7e577 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2444,6 +2444,15 @@ static void sev_firmware_shutdown(struct sev_device *sev)
 	mutex_unlock(&sev_cmd_mutex);
 }
 
+void sev_platform_shutdown(void)
+{
+	if (!psp_master || !psp_master->sev_data)
+		return;
+
+	sev_firmware_shutdown(psp_master->sev_data);
+}
+EXPORT_SYMBOL_GPL(sev_platform_shutdown);
+
 void sev_dev_destroy(struct psp_device *psp)
 {
 	struct sev_device *sev = psp->sev_data;
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 613a8209bed2..6a4435cfa977 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -947,6 +947,7 @@ int sev_do_cmd(int cmd, void *data, int *psp_ret);
 void *psp_copy_user_blob(u64 uaddr, u32 len);
 void *snp_alloc_firmware_page(gfp_t mask);
 void snp_free_firmware_page(void *addr);
+void sev_platform_shutdown(void);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
@@ -981,6 +982,8 @@ static inline void *snp_alloc_firmware_page(gfp_t mask)
 
 static inline void snp_free_firmware_page(void *addr) { }
 
+static inline void sev_platform_shutdown(void) { }
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */
-- 
2.43.0

