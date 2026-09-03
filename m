Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481914C6EEF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447648; cv=none; b=jD/W3pOAQpdQCPpS4IYC4P4BFdXH89qOJPfzGV3q5Ob+WilTolip1MJ5nJwXf4lQstVn1FuCxl7Qprbx8v4wh8yu0dhVh0GbDnEAHJjgWVDCVNBwFcDBmZYWqeVy+LQ8QuZRxqZ663PxfA895T5KP+BYM6XQl2FW3Y4/CEacjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447648; c=relaxed/simple;
	bh=xcJkbqHq6/Qpm8/rkb9HFtj0Nqd+LKyMydPeSjmE9dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWpDYnj96Esh9YbmtzD8c3lUBvoMBDDY8TV923A2XP0FjL7gMqtUnjJNDP9MpAE6xhuwKeScSgTRO2Q+c8p5LYYw6JFpSJMg38K2VnxcbhXnKnoYNU1GifewLyQFbjuGF0ykI2WI6AjXIRYxyXaDDKexlPYJE+Gx4PfHQ7zhrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLgCStq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLgCStq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E35D1F00A3A;
	Thu,  3 Sep 2026 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788447647;
	bh=PMT57Dsq/Xzh80M9xx5BqvchArYSaC3g0GJvK8zSy3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QLgCStq59GLvJ30BdqfKGeLbT/6iMFPGq/b1ivrYoww1wqjKI6URDscvSpo6qkyyj
	 fGSp5VljsB526W+e5s8+LL/phWL4VP3K/Ql3yBt6NygqAPdqNBkgYrBT/bmYUkoaC4
	 fkqKWWaqPgL+Pzfs72ExrOxJsEKXwZZi+WF/+U/94xwNuCqcGQrJcVpmTzisXdbor5
	 qhRmXkg5WWwm+MYF7za14LGXSd7KKkLn0hJM7mZi82PmX3PuRwMCwm+Bo43my9Exh9
	 GN689jF7ZbnjrEVyRXY6oyCV/TmDEuRCTRDkfOpwT4CSFFARD71dF4xtbZWOOoyk+4
	 uVUBH0/0OPyHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KEYS: trusted: Fix TPM teardown ordering
Date: Thu,  3 Sep 2026 11:00:44 -0400
Message-ID: <20260903150044.855866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090320-scalded-unclaimed-9b48@gregkh>
References: <2026090320-scalded-unclaimed-9b48@gregkh>
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
index e73f2c6c817a0..b5781c5071395 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -1069,10 +1069,10 @@ static int __init trusted_tpm_init(void)
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

