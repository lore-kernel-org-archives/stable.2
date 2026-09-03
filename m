Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BCF4A6CEF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439458; cv=none; b=Ix3f4JWtRb73Nbd8aJ+ePzYZvrKPDtKK5lPi9UKTXLEVfPp0uZZxo2XjHmTuA1pNN+85ADWFVLna+CP7z5fBDSW15KxiY4gQ56ati+Nq+bc3fuEN1c6qXXOR/t4Pidvj7MmrIfqxv2LMGnmdNn0nWx/h+GGSbYFZFYL9UajjPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439458; c=relaxed/simple;
	bh=b06yZXEaQqSIBMxK4oPujXJDGFQglvMo64Klui6GPSc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pG+GSMAPOD4w8WUSv0y05V/DAXYqOQo/ojljWzV2va9lQ+8igtDktcyI6MAs3q3H39DrNsQn4ka0ggRkm/I5jiLpJRFmrl5iUE7YQdklpl9aydYDqwjObWD3vhe8yCZYnQRLugqWDK5ZFZNT7muWbrrQ25kTmSygqlbIALRMXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dmhDrnIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dmhDrnIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7F31F000E9;
	Thu,  3 Sep 2026 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439457;
	bh=02NxK4dQWoSxrCpL0ndYHTGBswi7gdyR7YpBEoMDFjc=;
	h=Subject:To:Cc:From:Date;
	b=dmhDrnINpjfqGF2P3xjZA/mhVvvSfHmxr1xAlLTu7tOLzSEQho7iDl5WBYsbinZrw
	 BY1kQvwsApHThakSzkJ6iXJIgeewjBqLJZix9AWayBp3XpyAOxGIPKJxD0x534smft
	 A054KnoM+Ehvd6oF+WIKJR22DlW3QJUB7KyT2CaA=
Subject: FAILED: patch "[PATCH] KEYS: trusted: Fix TPM teardown ordering" failed to apply to 5.15-stable tree
To: nicoyip.dev@gmail.com,jarkko@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:44:21 +0200
Message-ID: <2026090321-fiction-outthink-69f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5e2d672280d97d83de43031d93761b12dadd7b8a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090321-fiction-outthink-69f9@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e2d672280d97d83de43031d93761b12dadd7b8a Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 11 Aug 2026 02:56:03 +0300
Subject: [PATCH] KEYS: trusted: Fix TPM teardown ordering

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
 

