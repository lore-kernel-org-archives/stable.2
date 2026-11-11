Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415939;
	b=1aOOEwqYy41sgHjlMxf9DXwKcMctqSnWSfC5n3qt9OKMaf9Lco+80YmUm1DE0pklqi2+
	 JyrfJWHtBOkBEW4H3S9BAqdabQT6MOEX5KhHaiOfIxMG0gAcb/uh90YAUu2hO14CVpBep
	 uNdYLgHaTR6XxkUeWtFgZZcIlLUDa5saYJWEBjCGv6Qeu3M7DyDda5+60VDx1uTs+Bttg
	 QMEdONdLpKONt8HOIj9rgDJNaQ8El/6u6vRWY/ZOhnSxm/YbaZo8s/YXK4DJlin7B1V6r
	 yOQVgppFmlyCbZn4HXMk6sj49RFr5N/X56X28JU8nsPw0/d12mCcbtyXRLxIayncBSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415939;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pzQxquiSKV0jXWRCKchMj1IkoJbMomHSziw9UzB/wvA=;
	b=UVn/2t2vtZesMc1jlpOXjbrJNDfVackUqcxiI1W7NGIF6zOCcpp68Jz6xZXullxMMwX2
	 qKK7BAVVw7ek6Qojvjxwdj+S/kwTJ3kMmo+7GYFG5Kx+hHl6nMwDJxPlC7OLnYctu4Fqp
	 wWRVBLHhwa+qJ2UD8PlCyMjyJ0P0MWOa1KAJuQJ7SSCEu+RkcSCI56gJVM0RrNjHe9V2+
	 vuI7xaCBPuayy7UzjO94uGflNw03oZhXFjYN6S/XzmsHDOVdh7maOzweagBxoNwyJroOG
	 IN6cc2DsSGJL8CGySpBw7plzIcm5O+WilWG74FnIjtDWsjslg601xY/FuRThrbsrrqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AyAG0Jkl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82D606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AyAG0Jkl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22961F00A05;
	Wed, 11 Nov 2026 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415939;
	bh=pzQxquiSKV0jXWRCKchMj1IkoJbMomHSziw9UzB/wvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AyAG0JklE+nyzivKViA5Ycdu1kv4YxpErol9IjJsNTHdN/SNadVyixH7c7NW8qblz
	 nxL6546b0YCAjfYOKUtDYaFTW5v04iZaZYjNkB7VOKGIKyhEpbBi5lZXljtKUk0j7E
	 f/gu6Q5n6J3tflOEHg6rSuPPI+5LMvs6Bkb4JBoxmcRS5F5o/jTbAmpjAffEFuQ+Lb
	 b0T1XDDs2R20iAeQbepWC4msL/Q++LUjAs5MM5Uekzqqq/JzeBSqfyIyMm5QWVl8Tx
	 o4EZ4TS7mC9bge102cE6LJMLkXIzxZTWN3gjWq1Gi0rvgyzZKs99tA7/dFxgd4O9ha
	 JSkZv+WgeUUIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Donnellan <ajd@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Russell Currey <ruscur@russell.cc>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] powerpc/pseries: Make caller pass buffer to plpks_read_var()
Date: Wed, 11 Nov 2026 11:52:16 -0500
Message-ID: <20261111165210.3351833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054327-failed-6.1-d52a1659cb17@kernel.org>
References: <20261107054327-failed-6.1-d52a1659cb17@kernel.org>
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

From: Andrew Donnellan <ajd@linux.ibm.com>

[ Upstream commit 0cf2cc1fe4e2e7a37da077cdd3fba5cfd9a6a36c ]

Currently, plpks_read_var() allocates a buffer to pass to the
H_PKS_READ_OBJECT hcall, then allocates another buffer into which the data
is copied, and returns that buffer to the caller.

This is a bit over the top - while we probably still want to allocate a
separate buffer to pass to the hypervisor in the hcall, we can let the
caller allocate the final buffer and specify the size.

Don't allocate var->data in plpks_read_var(), instead expect the caller to
allocate it. If the caller needs to discover the size, it can set
var->data to NULL and var->datalen will be populated. Update header file
to document this.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20230210080401.345462-20-ajd@linux.ibm.com
Stable-dep-of: d52a1659cb17 ("pseries/plpks: fix error handling in plpks_read_var()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/plpks.h       | 12 ++++++++++++
 arch/powerpc/platforms/pseries/plpks.c | 11 ++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index 9e2219b0202db..4652ad319858e 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -82,16 +82,28 @@ int plpks_remove_var(char *component, u8 varos,
 
 /**
  * Returns the data for the specified os variable.
+ *
+ * Caller must allocate a buffer in var->data with length in var->datalen.
+ * If no buffer is provided, var->datalen will be populated with the object's
+ * size.
  */
 int plpks_read_os_var(struct plpks_var *var);
 
 /**
  * Returns the data for the specified firmware variable.
+ *
+ * Caller must allocate a buffer in var->data with length in var->datalen.
+ * If no buffer is provided, var->datalen will be populated with the object's
+ * size.
  */
 int plpks_read_fw_var(struct plpks_var *var);
 
 /**
  * Returns the data for the specified bootloader variable.
+ *
+ * Caller must allocate a buffer in var->data with length in var->datalen.
+ * If no buffer is provided, var->datalen will be populated with the object's
+ * size.
  */
 int plpks_read_bootloader_var(struct plpks_var *var);
 
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 00137d6a303cd..b66a980478fec 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -528,17 +528,14 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 		goto out_free_output;
 	}
 
-	if (var->datalen == 0 || var->datalen > retbuf[0])
+	if (!var->data || var->datalen > retbuf[0])
 		var->datalen = retbuf[0];
 
-	var->data = kzalloc(var->datalen, GFP_KERNEL);
-	if (!var->data) {
-		rc = -ENOMEM;
-		goto out_free_output;
-	}
 	var->policy = retbuf[1];
 
-	memcpy(var->data, output, var->datalen);
+	if (var->data)
+		memcpy(var->data, output, var->datalen);
+
 	rc = 0;
 
 out_free_output:
-- 
2.53.0

