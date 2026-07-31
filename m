Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9F42B756
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506980; cv=none; b=ZiIku5wtPW+T25UrXwcMjIdGggJ9tVDyplzCV1nptnwWWaOdR7wd4/mF8ipihkEV6CdF4roKeSaabRvly87WuWFfJ4V2VXDHwGknjuwuKC0k0oWD+Dnz0zB41TX7Zb8E9dO+cHQGOZogOQ9BbrIiXYQhu9nroM3oqSJeUcNxMPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506980; c=relaxed/simple;
	bh=3EOf2/jCD8AncItiAAHs6oeZqNAYPx5oM9R4lgo8xmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnAonXvE9/Q8BT6fpC8hWyKRUWjCTpVl6Wa8ys2O5HRcOf66A+X0h6bZRu2eYWi4kt9c2sPeBLa6EIUBpK7WiXkOFg/f3vzl4bh7oc/32/10nGlsNtWnLYlNDmj58659/iYxW28YLMpe8HY89ivLJBbeASETxHSdy1CLka9wgxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhkWKX5P; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhkWKX5P"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cad85b7b5aso895545ad.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785506977; x=1786111777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qfTZLKX5MXlI+65GiAcv4sDb6zyKTd9ns9ffnwjJXko=;
        b=mhkWKX5PDoWgAmcXfVNp0XUlYz1PPHyqI7gvQ1vZLKrPHmfMAJDHQnoosd+NaU4JR4
         R1G0fOpNuDGm5Kxx7EOXloQvCxIaBMUVNm18xEocs1JoP/ZgW9yTUybsD1zgb/+6jhd8
         u30EcU0j1yJ+FJokT7DsaflSDIdy5wKqxPS6YEdADFFmPvrBKNmqxpVphiQ9baOqxdqI
         7qIiRrP7I5ytwBKZYLJMk9QKpYq7DhVVqJ83xsIbK/3hIq3RAGlOZvqwcgFepYpYP7ax
         vSt+8eywrUF955DmnPLFeEvwtWd4PQie1pVjKz3GWeudAAgFrDkwARs88dZ7YGprg8vi
         Otxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506977; x=1786111777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qfTZLKX5MXlI+65GiAcv4sDb6zyKTd9ns9ffnwjJXko=;
        b=Jpb/3B7SaM+sB9n8shAERJH25KmmURGC2yTEsqQA/xmjTijRQ60YR0s/F+Y325M7Ly
         dzjlY7HLqqq4IfE4YR8FrFH/DExnQ/l0O38Rcj8HlPLznBzeE/ZSNKeYnxW5G0r3JP/C
         te9ElkKbqgpwyYGK9lIlIaS6n3hdZEQnGDx1QOylQT6R3KGNz2VUxU3fdxHfp7DYyC7u
         bCiWZqVDRb/X5AXjkIQTCXufdexMy4WzLCXCrJ59rjyjKTZjP85fUvTxhF6nwwZ1SyEp
         LM0RjGuPTI//4fh2OfRsgU7CQkxhBNbNPdN7mk+B9byUrI2WRQzvXU9HW/qpAkmt08uE
         WTXg==
X-Forwarded-Encrypted: i=1; AHgh+Rp17Uf12g/G7pUc1P280ESYnyEI7jsQtp2BkceSL2bHmlAyz0GUGXVcVfXYSh9xhNhesmjS1bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJymajBdM1le65msW2L5fjlJ04BgEc85bQwKuBRocuQJPwWFU
	+9c/900ntb0Ze8yHroIBoD3RVYZhzdboUk5p3P3s7xCqHU7xaNQRmf9X
X-Gm-Gg: AR+sD12ptjUYDzsVpMIGTeMATpqpCYV0HAA/tA/LHy16oEs+37aEXRBI7HQnoH5KF+U
	ngIgJ8E18EosO5CSNNOQZFf+AYTYaeePpcmyGBs9DT9u6d3by+mJp+ZSFZ1Lso2YGIfGe3mtsBl
	OD3wBG/Rx1XsNmRgB9HD0WG4DDKFKCeP4fGCJHJA3rBbSdnkSzmjCf9Uzgfm1a1jHW8SfZsq2Af
	JRQjWqMRFa/6AqEegH12wEq9hAXSE0Xu0eUBeT0xEHWklx3ywzfeKCWIjhCHEhobi3ZLN2L030Q
	N0j+5rTSFYNkkdb5psuuJAhtSuojBMFPnxDSLDDtf/YsWPEEfeizwMWBkHiLhHCyQQa87mWWpOg
	8qR9kH4X/34buI8JRwWI4m3n9xvb3t+fIPS68rCy6c5I4aqN16JhWkSawDu+ABM/MOIJqjkPE68
	dhYTf9rYIMC/fJdyEfUeEWaBZMdPAW4kjBL6gaKIsxVkTTymtEmzn5NMy3kNZ8Fanbh5QLX7yZD
	2FHqXSqVX0gSn7QuTN2wUIEVXAi0jULpGEDYRAURmTZccacUJ3Kif8=
X-Received: by 2002:a17:902:f546:b0:2c9:b96a:2855 with SMTP id d9443c01a7336-2d051f078e3mr3246845ad.0.1785506976879;
        Fri, 31 Jul 2026 07:09:36 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddd7a33sm6268159eec.12.2026.07.31.07.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:09:36 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KEYS: trusted: Fix TPM teardown ordering
Date: Fri, 31 Jul 2026 22:09:24 +0800
Message-ID: <20260731140925.2973492-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trusted_tpm_exit() drops the TPM chip reference and frees the digest
array before unregistering the trusted key type. key_type_lookup()
holds key_types_sem for reading until the key operation finishes, while
unregister_key_type() takes it for writing. It therefore provides the
synchronization point that must precede backend teardown.

The current order permits this interleaving:

  CPU 0                              CPU 1
  trusted_tpm_exit()                 key_type_lookup("trusted")
    put_device(&chip->dev)             trusted_tpm_seal()
    kfree(digests)                       pcrlock()
    unregister_key_type()                  tpm_pcr_extend(..., digests)

CPU 1 can consequently dereference the freed digest array. The chip can
also be released before callbacks stop using it.

KASAN reported:

  BUG: KASAN: slab-use-after-free in tpm_pcr_extend+0x1f0/0x200
  Read of size 2 at addr ffff88810872d000 by task poc/89
  Call Trace:
    tpm_pcr_extend+0x1f0/0x200
    pcrlock+0x42/0x70 [trusted]
    trusted_tpm_seal+0x1b6/0x570 [trusted]
    trusted_instantiate+0x293/0x340 [trusted]
    __key_instantiate_and_link+0xb2/0x2b0
    __key_create_or_update+0x61e/0xb50
    __do_sys_add_key+0x1b8/0x310
  Allocated by task 88:
    __kmalloc_noprof+0x1a7/0x490
    do_one_initcall+0xa1/0x390
    do_init_module+0x2df/0x840
  Freed by task 90:
    kfree+0x131/0x3c0
    trusted_tpm_exit+0x59/0xa0 [trusted]
    __do_sys_delete_module+0x346/0x510

Move unregister_key_type() before releasing either resource. This stops
new lookups and waits for in-flight key operations to finish before the
backend state is destroyed.

Fixes: 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 13513819991e..8f57c6111e7e 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -987,9 +987,9 @@ static int __init trusted_tpm_init(void)
 static void trusted_tpm_exit(void)
 {
 	if (chip) {
+		unregister_key_type(&key_type_trusted);
 		put_device(&chip->dev);
 		kfree(digests);
-		unregister_key_type(&key_type_trusted);
 	}
 }
 
-- 
2.43.0

