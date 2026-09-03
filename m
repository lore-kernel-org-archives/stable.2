Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3154DA547
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449312; cv=none; b=TfqTc7OpS3eHPi64NY98KUlZO0LshXuj0hVFiohCohV9JONfFn9mlJdhBhtQF3SqzQmLwKE4esqHKeAZtlKjXxPki+ypjBA5LuqSJ+MM4DNaXCXPDSjY0rW40ERWsLvyrEDDpYVvwvEFaqw4St+tsbg/qoK6dcjjxgipCtIIYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449312; c=relaxed/simple;
	bh=qOhY+0HzGRtrOzjXfUJlrZWm21eJXVesubuOFefh2aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO+WYS0fklGKsfffNgXaIZvsoo9ifvlhpeQY25h7/TNuRl6J+YrXT3MmQpU0fwOfntaX47jxNa0/m3CyiJ/M9lvnh0BatVauvGdusj+XCfXXr+tnPFlpqGZ2iXzgIj/phzPxdzbIaFsFzsfC0AjOOBJlj4gxQAzWtGj7WaJwKeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU3k3rp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU3k3rp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F40C1F00A3A;
	Thu,  3 Sep 2026 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788449311;
	bh=hVr/ekSLOEZ7taW4u+mvbaeYx00MN4s26SgZ0ZVyCcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QU3k3rp5Sbuzw7Pll+CNenN4H1Zpeme1dfW5SVaRRCHjZxTgD5yHp8fok721IGD/D
	 twazRTc57NFF687lnFlq1QA+d03r0FwdFc8WZHNULSUAHxTifFpgzzvjrr+Sd7ZS9/
	 5pUGF8ujYbf6hNz48EN9+hzNbMSIXLj/s2qLLIF7vW3NyhJSEWIhhitvg60sCXD4bC
	 mC6O5uvcJArGTRVKKIzhDqpgiVzwfxXbD82DaCdfNhmeWnOdY2WXeX3iiMjqrZgkOO
	 jy2lDq+5uYINv6hBbRl7T9qlDJ287nsGnva/AydYvLCvdrXLTD3MuplggNoS9ASTEO
	 57m6cEmUBxl4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KEYS: trusted: Fix TPM teardown ordering
Date: Thu,  3 Sep 2026 11:28:29 -0400
Message-ID: <20260903152829.891669-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-dropout-recycling-8cf0@gregkh>
References: <2026090322-dropout-recycling-8cf0@gregkh>
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
index 3e9dc03d59c91..ca5efa7988e6a 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -1287,10 +1287,10 @@ static int __init init_trusted(void)
 static void __exit cleanup_trusted(void)
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

