Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37023B4EB6
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186004; cv=none; b=An4HwSIVUviobKFniXswuf1hJ0bvCOtYFmlZ1ftg6vMHnY2UYRuir3S/+tcHim7oXT77ly6FLIWv/sS9c/oklilKAgUmEtdURwgPOI79xwETf0obWDTumjol4vfiX1fAjTWJKliPYAxjglC7Xtegsa/erkta18sCqoJDmnITfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186004; c=relaxed/simple;
	bh=uPTYRvRfqEQxZJoPW+vnSW2cxZBWdQxKgaVIT0AAihM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRShqCP54EIqdB+LPLH2NgMHcOYjZwN1SK0McopRKA7eAPEJSwFKzWp6lzBjHHxIiSFBCECOaRw54mzcxq+yd/qE6b3kaG+3uAtArErX22DsW87R60HkszNHyra94ZAkx2KAXFwVkmgS2XYbWtHDgaBp6QnG/7QYW8NHBX4g8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP4b80Z/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP4b80Z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149B41F00A3F;
	Mon, 27 Jul 2026 21:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186002;
	bh=ZLyO9E1ti0awzFa4W27GtzwUcra34KM832xRdFxPdq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aP4b80Z/wJZW7EUiCYEkJnJSf2k6G5+oJZieC0sO9mCN30n4HSC9R/cv0zJ+FmMCb
	 59hvhMZtnMoIU4C/qD4uArSDCk0HjLn2xCbZn9OnB2CJ0Anfwf2W960eQbAXpO9Vkp
	 fCmOM0Aswnfv/KsW1ql0ii6TpDDbhxL8BmSevJ99UVsJuLm8HKWxQRnc4YlGjY8TVX
	 yxuB0eUUFdso1oXDZHjlbR8/ybbgtk4eK07qCO6eZViQS8CIIAAmgtkeg3qgkRVpIF
	 l9r5mvbaUrNOko1fMNnyaEu3USzxJW8j9fhujYnOwDpH/K1kHgD5JaZAqJPLc+9+zp
	 P9yP8LZGefiFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ingo Blechschmidt <iblech@speicherleck.de>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Ondrej Kozina <okozina@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] dm: avoid leaking the caller's thread keyring via the table device file
Date: Mon, 27 Jul 2026 16:59:58 -0400
Message-ID: <20260727205958.1929027-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727205958.1929027-1-sashal@kernel.org>
References: <2026072016-oppressed-overstuff-75e8@gregkh>
 <20260727205958.1929027-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ingo Blechschmidt <iblech@speicherleck.de>

[ Upstream commit 981ccd97f7153d310dfa92a534525bbaf46752c2 ]

The refactoring in commit a28d893eb327 ("md: port block device access to file")
accidentally causes the caller's thread keyring to be kept alive long
beyond the caller's lifetime.

As a result, "cryptsetup luksSuspend" silently fails to wipe the
LUKS volume key from memory.

In detail: "cryptsetup luksOpen" uses its supposedly ephemeral thread
keyring to pass the volume key to the kernel. dm-crypt's
crypt_set_keyring_key() copies the key material into its own
crypt_config structure and then drops its own reference to the key in
the keyring with key_put().

With this fix, restoring pre-v6.9 behavior, the copy in the thread
keyring is then promptly garbage collected, such that exactly one copy
of the volume key remains. This single copy is correctly wiped from
memory on "cryptsetup luksSuspend".

Without this fix, the thread keyring and the volume key in it remains.
This second copy is only freed on "luksClose". "luksSuspend" neither
knows about this copy nor has any way to remove it, so the key remains
recoverable from RAM after a suspend that is documented to have wiped it.

This fix should not introduce new security problems, as the code is
anyway gated by CAP_SYS_ADMIN. The device-mapper core, not the calling
task, is the legitimate owner of this long-lived file.

Fixes: a28d893eb327 ("md: port block device access to file")
Closes: https://gitlab.com/cryptsetup/cryptsetup/-/work_items/993
Link: https://www.speicherleck.de/iblech/cryptsetup-luksSuspend-issue-reproduction/
Signed-off-by: Ingo Blechschmidt <iblech@speicherleck.de>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Tested-by: Ondrej Kozina <okozina@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fb6bcd598c5b85..28d825cc69c537 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -735,7 +735,16 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&td->count, 1);
 
-	bdev_file = bdev_file_open_by_dev(dev, mode, _dm_claim_ptr, NULL);
+	/*
+	 * Open the backing device with kernel rather than caller
+	 * credentials. Otherwise the caller's credentials would be
+	 * pinned in bdev_file->f_cred until the table device is closed.
+	 * That would keep the caller's thread keyring alive long beyond the
+	 * lifetime of the caller, breaking userspace expectation (e.g.
+	 * cryptsetup(8) leaking the LUKS volume key).
+	 */
+	scoped_with_kernel_creds()
+		bdev_file = bdev_file_open_by_dev(dev, mode, _dm_claim_ptr, NULL);
 	if (IS_ERR(bdev_file)) {
 		r = PTR_ERR(bdev_file);
 		goto out_free_td;
-- 
2.53.0

