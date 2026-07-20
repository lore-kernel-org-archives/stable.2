Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29842464A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562233; cv=none; b=FbK5wqy3cT4bKroEDh68/aSaJsPSnxUhoHbCq0KqF//hem5jH86fO2H+lgwhREGLA3a6UAZzUm+rylnb06Q0tA6IVAKn698Tbrou51ToOJg/EmHQSEpb8wmnQ91E82fBEdrMwdb6QON7sZCbMslk6Or8AhO+OlRfnakE6g5HXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562233; c=relaxed/simple;
	bh=AbA4Th6WNEOlF2eZEqUqhhpHrwlkhJ5ET7O6xgncnxA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CJP7QjKvdCiToGYifudCEO1Xcw71AC8npsq1uw9Mx2UW5/ycVbr16p3cGVqTJGd7hKoAZLgRDWJ3h3G+2ehLA7dzINqiRpC0d9ogUnU/gXZgm5Jwwm1jaXfVWVmHBLWszStiQqYgCBzIniLNWQuPoeEPGTeUee8JHO3wRfUI1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rxY110Cn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rxY110Cn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DEB1F00A3A;
	Mon, 20 Jul 2026 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562231;
	bh=foFjj+g/vHr1ZdSMIx7Pfj1HP0c9U4ujL+ReDbvgCuo=;
	h=Subject:To:Cc:From:Date;
	b=rxY110Cn1CggcabPn/ntooIgcxKwMrYDWks4EncqhBM/SnUDpWkrJMMM6kWqhbWTA
	 T6lQKjsIFItcdL3TtKIdNk4dAao5SpZVndgT7XlUmZkX67sy1HVYORLSQqATIDeO0Q
	 LkfelhDkaEIop2R1jSIxQ/OYiAMvVhpTHNLXRSVc=
Subject: FAILED: patch "[PATCH] dm: avoid leaking the caller's thread keyring via the table" failed to apply to 6.18-stable tree
To: iblech@speicherleck.de,mpatocka@redhat.com,okozina@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:30:16 +0200
Message-ID: <2026072016-oppressed-overstuff-75e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 981ccd97f7153d310dfa92a534525bbaf46752c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072016-oppressed-overstuff-75e8@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 981ccd97f7153d310dfa92a534525bbaf46752c2 Mon Sep 17 00:00:00 2001
From: Ingo Blechschmidt <iblech@speicherleck.de>
Date: Wed, 17 Jun 2026 16:33:42 +0200
Subject: [PATCH] dm: avoid leaking the caller's thread keyring via the table
 device file

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

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7287bed6eb64..d413bfaf3527 100644
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

