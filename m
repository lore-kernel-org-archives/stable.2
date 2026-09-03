Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB764D8D98
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448926; cv=none; b=Cr6ryK+0MIsy0gSb/76Qm/eARSr6nZ0U5DROwszNkuEeyqP/Oq1L5mH/zzKVjcPiU5tBJzdl6XrqhidJfyCjm8+hdF//JOEwkk3mSe0lPHkVJW1796OE5042/RAX4yGcDxyZge/TOF/xT87XyjTHnghQ093fTVZ0wGVgHMcSdjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448926; c=relaxed/simple;
	bh=wZdbPkFIiHWP+2cINcK5FdjPEwfI5HMfgvvGEnAQMXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9+cWSa6Unxwa3vWbtLvfcVU9x6U5Tsm0TGrmoF+OYOFozfJvSGSELu8rYgyk0J5utqpugloco7sdmQ7f/eML1rE81V0RkTUH6cSjk8dnaGLEur/rs5KqlEUeXBWR9uGeGPlAJb+/+D4olcPlniz4amFGD+L2rmFAaNL3cbVrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IW8MGIZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW8MGIZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712131F000E9;
	Thu,  3 Sep 2026 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448925;
	bh=6DiGJvw26k1t8BX/BCAZQSn+8MNLGNk+vnlPKTV/wrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IW8MGIZBD+uKCDQCsrJyOXCcpXv2toMpvxcNK6rnZISXB+ggSyWlf2MPHuU/mCZA1
	 b3FykYramLjGh1T5MVI5138+ePgOqa6A/Va5j9mjuIjM+5ROcJgb9I5PUv0cYrpSFk
	 HOJF7fueggk4Q8xzCV3NdOzUpBecc0bOAhU1GzPKk/8NTjfypzR3MDb7EUAvi3SXBq
	 4+fugDSaPkdTyXfp0B/oEZMnkU6QYSudbBzRmmHARtM0P+A53AmVX8JtQwj08Uok1o
	 PvACVsGgmFs+jItCh0/a0wyseQlyli7QAcz1xOrqo4k4S5JlJtxnr2+TYEppIaJaqz
	 fPXTiGs/UNlPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KEYS: trusted: Fix TPM teardown ordering
Date: Thu,  3 Sep 2026 11:22:02 -0400
Message-ID: <20260903152202.886654-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090321-fiction-outthink-69f9@gregkh>
References: <2026090321-fiction-outthink-69f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit 5e2d672280d97d83de43031d93761b12dadd7b8a ]

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
Link: https://lore.kernel.org/r/20260731140925.2973492-1-nicoyip.dev@gmail.com
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[ preserved the additional trusted_shash_release() cleanup after unregister_key_type() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 4863ee08b7b11..c482c54be918c 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -1058,10 +1058,10 @@ static int __init trusted_tpm_init(void)
 static void trusted_tpm_exit(void)
 {
 	if (chip) {
+		unregister_key_type(&key_type_trusted);
 		put_device(&chip->dev);
 		kfree(digests);
 		trusted_shash_release();
-		unregister_key_type(&key_type_trusted);
 	}
 }
 
-- 
2.53.0

