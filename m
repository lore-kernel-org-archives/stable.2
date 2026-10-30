Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355902;
	b=1GEtxCw/ZAjaSpT4Fmcuda+C1PETU4Ee5EjbmaJGkhgAKB6ebkon/33kMRzcSKnBZ/x/
	 CKviZu4CUzidWOKbNGk4/WmbA+H4iasE2DdamYq/fmOI42PKv2I1/KUU/G0hlEKb8f55I
	 IejJOEJKU9WbDT6kAGty3kr0mn1qxkGnXU8noQSK0rcbYAR5lyKbap7tmhC6V7XXy0Oia
	 L1XOiDacBpojorO6Gvxj0nfgERNylQUpQNcsJwkdV/eVzfGvrp55Bti3fIPKJVR/XUBCp
	 ZBT+YymJXJWfODigTpBT/y4EFMfvf7panCNJao9TksljWF89Lwq5S1gRDvdZ0ZCPRiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=B1hqtT8eKBTLj/QcI6rH3VmrUCTtV1HZS2iOUhxOQ1Q=;
	b=gTMn575vivrxLeaGtUz88m1zaEJyNnkITZH5PLbBoV9cnNfoak639xn5G2+kDzqQRITc
	 QIEqwlmyl8lQvzfJVnoclHIG0j/ZvOzluX3ryUYh7Ym93Gw4H4dt7flTSqQpG9Vvl+1R/
	 C5KndovPXJ0pzaLc/KVKUWl/mJqO1uuFd9Jq4wuQNKiVJuJCPoYAUy+VJLpAc+atl5VpU
	 IMesLs7z4bMX7aGwypKf28zexVwnJguLvabwg24yFWPy5scpdFZwfuc1OvOdAp6CvUuyZ
	 7OeT12a8HCUGJocJLzB+GZtT8wD+Q1R3rk7flUryoTw57iu31KtuMzMnCJRdYVCsMHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdsBaEyO;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BC1606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7BC1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdsBaEyO
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so4671505e9.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355900; x=1793960700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B1hqtT8eKBTLj/QcI6rH3VmrUCTtV1HZS2iOUhxOQ1Q=;
        b=zdsBaEyOCjb10altnH7e89JJDpKcj+5QNV20HaGnijPicGf9wengOHafV4jjC1j4cf
         31t/BTZIcdx67nAjV15lfSKsUjv7Fp7EJMShnaHOg30NO/Gz9D0LpUqLd3skcIWXAGkT
         FCXA2G8vVWd9LFQAxJbgpKpiLE7ErtfY51USIFBJKwBK/LZhezFSgtxJ6fx09gbz55n8
         ayQXmvXbf8344+nX/C0meEJmjnpl86X5YnXUwVzFs6z6ZbW9tgaxikZ3VRmtTmBNyXyb
         D0tOZfyhKKCaKrpn6P5DvnczIFnkQMcqnGn5j/ktsnuKewWHG74mcJqHp+i/HDbXF/1L
         0XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355900; x=1793960700;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1hqtT8eKBTLj/QcI6rH3VmrUCTtV1HZS2iOUhxOQ1Q=;
        b=Dbd/vZT+pqPWhcBH0ED7QUal6T4MhiewoGf0pPHKNyL/5iZnJrYtD0xKfKxXVsfypl
         RZJ0onSyzcrTSmE+3Q8xMlcX74K+yGO62Wk8v0dOzylE4/FWqvPYuyayhgcyGmFMVfkS
         66vIltCgTzwHQeq6srUgAiSb1IBBJMsANJc9kP2umm7jw40wAlVuwfLAU2WeqNu4ZLPT
         zwsDxk6BOkEw+ITIdm1MpUIbY8YeH/8flJKaU1zNBGIRGxBAARZYRpxo08/jWDQwYoU9
         BRNs9eNLLjdSFrvSx4kuDOjqb2tcGtYCisZZfhVJczj9Ud5dui0dydxDDmF527fqRmtC
         mkIA==
X-Forwarded-Encrypted: i=1; AKwUvBwM7m65jEzehntbMnFMbvemWjWEVQdMRt05mTG8ofGd8mHY3qyI4AEqyAjuOBmNO51cDE8Rqtw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhjFCe0fCOgvhAi2zh7A6om2XqPzRtxwpkAb++pzNFEvbHZApr
	5lKOloe1MpcSm+KeD9PyEPUUqUL9wLinBTiJ9xHbEoo+ohLPzWKkN5xR
X-Gm-Gg: AYBFou0Txvo/nQUOmzo4msAIgCUyo/IVoI2KY7/zGjbgLZ0h4h6dCM82v/Ri75EBxCT
	s7p4ds+jewet0/UFyu3nvnJwoW8d0Pw7ghh8LRM9+PJWUDLh9RyWQe3hQalDUHqNxVeOQ6mq+mV
	44B5yJPhMsyPpWwvad8WLnNnB5D8AldQ0D3+tfOW/TeeB731xm6sNG0n1Kycg20ONWv8Ppk/oDP
	XaEyMFWvanww2oquWGZIMptN981yC2pnKv1W5tXCE0q+44cC40snAVUksKRFp/t+irCGyJfwcBp
	pZyS6GOUooomwbAary6et6O/qyMT3nm4uWAVQ2Tzf372MusL1mRi0Lb7UD5B3BErWLc0NGbQn/n
	Wwr/8rSr4cLIhBw6Taan+4rMJvHgAPidCT/cvGcbiCTIjU4QuyrgQsamrWLtmfVUtDSCWqUbOy/
	pGPUn1pw/x5QA8S+YxkvfL7srHknhgTX3GAseyI88mwdJiUymyqDqlQYEIAMsf1mWG2J931sOLI
	8dVn+T/RlWBexFfgDiDf1rKQ0+gGJgGCtbtAzOm17PN1SM8FonUA61pPJvR680+xveOj0MyYuuA
	rPj1IUmTS9glBFKDReqeOC/faFsFz+VEHAnDw6D8gIwl6NQTP6fIyw==
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id 5b1f17b1804b1-4ac17a3628emr38043095e9.14.1793355900196;
        Fri, 30 Oct 2026 03:25:00 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm66892605e9.12.2026.10.30.03.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:24:59 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Dwi Siswanto <me@dw1.io>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
Date: Fri, 30 Oct 2026 11:24:08 +0100
Message-ID: <20261030102411.12985-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030102411.12985-1-gnoack3000@gmail.com>
References: <20261030102411.12985-1-gnoack3000@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In landlock_get_fs_access_mask(), only add the
LANDLOCK_ACCESS_FS_REFER right if any filesystem access rights are
handled at all.  This prevents us from accidentally treating
non-filesystem layers as if they handled LANDLOCK_ACCESS_FS_REFER.

landlock_get_fs_access_mask() is used when initializing the layer
masks for doing access right checks, so this bug meant that we
unintentionally denied "refer" (e.g., link, rename) operations in
layered cases, where the same operation would have been accepted if
only either one of the two layers had been enforced.  If the rulesets
individually allow an operation, the composition of these rulesets
should also allow it.

The bug only manifests as soon as one other layer handles filesystem
access rights.  Otherwise, Landlock filesystem path walk is guarded by
an early exit for the case that no filesystem-enforcing layer exists.

Reported-by: Dwi Siswanto <me@dw1.io>
Link: https://github.com/landlock-lsm/linux/issues/67
Link: https://github.com/landlock-lsm/go-landlock/issues/66
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/domain.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 428c1d9890db..693e569f5387 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -258,9 +258,16 @@ static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
-	/* Handles all initially denied by default access rights. */
-	return domain->handled_masks[layer_level].fs |
-	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	access_mask_t handled = domain->handled_masks[layer_level].fs;
+
+	/*
+	 * Handles all initially denied by default access rights, but only for
+	 * layers handling filesystem accesses.
+	 */
+	if (handled)
+		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+
+	return handled;
 }
 
 static inline access_mask_t
-- 
2.56.0

