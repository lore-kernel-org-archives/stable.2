Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6D3CF02B
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621955; cv=pass; b=N+s6yJnXOftxvrSE5aWsyi3dEN/YDvsdjFwB6fzoyIyCJgIDssKx6XVSGwDc+il14HXz9mmZu+nnjYdwZz9IN13uMUMN3Ax+eOksvtUrgs+HNMn9Yj6j4Hc3oxA1B3kByIrF+viD7WdRlqsfAtC6OT6PWEuDCLfFH81M7jkmK/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621955; c=relaxed/simple;
	bh=ZckUBzuxfDct7Xtg49y5TXXNnoeTTdLGKQnVGpqLnmQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l1NtvrHMGz98to5JbiuZvoVxMmONe3fiIq3vL9cMrGACRrVk2Mi7MxCU4PC68yhENugg/IlXHGNMoUTwonKdAnNHjz9s/Ydl6zNvuTksvo+CkCa1Y7H9uZVEhk7m2C5FSRgQibN+45nHrqpmQyK9y1sxFmr/Rv+In8F0PY+5WRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3SffaIu; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3SffaIu"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1e428so1027959e87.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621950; cv=none;
        d=google.com; s=arc-20260327;
        b=Cy3gZrwDpLl/S8ezDfrWsfS8oQbEuEebbReutKNJze+ywo07dBjBIoGp1ZYmLnwzg3
         /MK8b0t6UwwHDIdY3VPAjr5gDp7Rhbq7AIn6U1x5cYHMoB+kmeCUmPKSWYYEnRLOxRYf
         Tz4VFrrsnBZWDFUA3cm98ce+nFbEkwQKLmlp8TqND1rTpaI460+Be7a+0G6LfMHTAZUE
         bvEdgs7NvVS/KuQZ6WXHPX3+mUqP7YFphG/2uTaP4ig4gsWbqrNE7f7Ti9AdY7VSu7Qo
         G8hl4w0HKHLmSnenM+IvnHs0CeRUgoUzhi672lYtzIzzRjo5bljuYNQx6RGTZgL6ah4r
         dz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        fh=gwwQGd7d5vlmujl8Gy0S+fzcFHygS+TBiXDCMGmIyXo=;
        b=SBNbENkLVLxftXjlLF2cFm/X9372S3YQytVybLswif0ZW7X455sFc7fNWLArtmvosa
         u67rf7a/Hl6yV3Uwm5Hw8X9TSt+5Jur0IqofA47fjhDqsopyaSCvNOg2BEZOLdHz2GRO
         jAnCp7GQJQ4/QQzYpoFEcEalJbgqf3JbaUWDBmUlj00Nyq/iqU6yNpd+Q3QdUMv8sdjo
         9C1g112h0xajzflfv+50umABIkTYYKDuMg8DMBtCiq2F2wHV1p7ApyRjaXT2YB75mtOj
         JIZkwkgNdLqxslfWIXBF3x0sgiUR0ibkEDc2lBcVuxn0JL5zATQz9aFVsp23MfMbiMRH
         lSjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621950; x=1791226750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        b=h3SffaIuXFZFlrN3ssHMWUrw9m8vbhLctkQmnh/rvdVVzzlksx4S5ogP1wK1h5TGAI
         wgUF7yo0fNaktuyNZJoMC5eSIIc4tibqykGmSyVkpCCmpVbQZ173yEv6wm4D/oZjZfMa
         HUgJkW25BBx/4ngNI5m39GxRf7pVm5kHjXAqSsx33ReLW1N4uKQK+qESkc7n/62N6pxZ
         iDq8jbO7ge5JdBa1+TCocUuJzCYbOqF5oFo7g3LUp1Uu87AonWLkTyO39Hg7C0A+uSe8
         fv8S5qeTXQlSYWymNgOix5a2Fr+3Oj6wp1fnhd2CmeBa/jTbmIMltZqWrGYpyNbo70wa
         qq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621950; x=1791226750;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        b=Phb9+dVQWrdTRZlb1QN0Bd8omIlGo5kcTgxpkMT27sryejq2yYjM8aUe2ODSqHort7
         V2q9aNjJgSny5St19u6YVmpsNKUT58Y2cSXbSBrX20Oj7YchDmia0Qplw6mlS9eiskOj
         glH8xeq879y99OSrE4CJqaQM94C/tbKxdG9u7UKiEezGLlcwcci32I0gAGJ7qFAjzwzH
         54wffsUzRFf+k3ChRKHy5mxoz2IRXn/kcoaSVUwMyPM5RqbMJO1LgZQ558h8jC775diF
         41DcNRiipu8x1VYmgmFxUA20hVDoB0OuBVInRb1amUzV3WlQYG2zNZMSxhb2/QH1AlOA
         OTyw==
X-Forwarded-Encrypted: i=1; AKwUvBz2b+tV6/iX0Wc2j0Opf81Wpye5QMinTg1APRMYTiUANF2/ccQn72aj2lVos4ntgLQ5r9HcGvw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7OnQcXbD3ETPRyWFhioZT3fFiQLs8cWosFG8ziVleEq87L/YZ
	YQI40mLuPEhc5dYkKITR9Rqr3aVCI59LsYtdDbusiwseS0bUJknq9WgDFLeeWvSjWEOgnS1PvrO
	HZgx0yHscWqwFeaiDjqIoHRx0PJ7rV1k=
X-Gm-Gg: AYBFou0MaZ9MyD2+1hF9zzC2SWBBcrPWx69JnwemdzUHdIb6bhlh0Z2rF7zyZ9Ivott
	jVQ2NYGpK3aiheV4ba+oXmGdy2IfHsL2lb7kHy5smkk6oV9DjI3DM7jVrfGek1rl1M6FBOfH1qp
	xFT9l7FScne257QQH8WhN3sByd6BFFUFyIjNNdMLMlx54PNYdGTIzck3+NtE2Yy3UNzkDuLwWEA
	NCUURCJ0aEZXuYCm9tGVZ6hOtHBbrjSIp9hWNKFpqH6xdIRx63DIv49ymGapIP1LPVKPlRFmfbR
	HnmipvILfVR92JT7w6MrA+4m/bQa8dtFnFSvQxH5VvcoT8bz8lx7k7rCx2mMX6FQaNViRc7gdo9
	LS6KhzkYyAiKj
X-Received: by 2002:a05:6512:134c:b0:5b6:10bc:b864 with SMTP id
 2adb3069b0e04-5ba2e6289cemr39499e87.18.1790621950325; Mon, 28 Sep 2026
 11:59:10 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:09 -0700
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Mon, 28 Sep 2026 11:59:09 -0700
X-Google-Sender-Auth: ZwCvM-sC4hIxe8N8dJb-AWb4nUQ
X-Gm-Features: AclHuK-2bu843UqJ0hkn0uiGUfhhfw492ZeGe05OpMyUNCkLbPWCoP_36qHDt24
Message-ID: <CAANnmVBmovjCL0Ky4F3ay8pnmm4jp0+HyXC9QYyHo_1Bi1FucQ@mail.gmail.com>
Subject: [PATCH] ufs: verify cylinder summary size against cylinder group count
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, marco.crivellari@suse.com, ali@iusegentoo.com, 
	kees@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The cylinder summary buffer is allocated with the on-disc fs_cssize
value in ufs_read_cylinder_structures(), but it is indexed through
fs_cs(i), which expands to s_csp[i], with the independent on-disc
cylinder group count uspi->s_ncg as the only upper bound - see for
example ufs_new_inode(), ufs_free_inode() and the block allocation
paths.

Nothing requires cssize to be large enough to hold ncg entries of
struct ufs_csum, so on a crafted filesystem image where cssize is
small and ncg is large, every fs_cs() access is an out-of-bounds
access: a read when scanning for free inodes, and a 32-bit
increment or decrement past the end of the kmalloc()ed buffer when
an inode or block is allocated or freed.

Since the summary arrays are only set up for writable mounts,
triggering the out-of-bounds writes requires nothing more than
mounting a crafted image read-write and then creating or deleting
a file.

Validate at mount time that cssize covers all ncg cylinder group
summary entries, and reject the image otherwise.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
---
 fs/ufs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3569ac92b065..2052d5225d03 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1139,6 +1139,11 @@ static int ufs_fill_super(struct super_block
*sb, struct fs_context *fc)
 		uspi->s_csaddr = fs32_to_cpu(sb, usb1->fs_csaddr);

 	uspi->s_cssize = fs32_to_cpu(sb, usb1->fs_cssize);
+	if (uspi->s_cssize < (u64)uspi->s_ncg * sizeof(struct ufs_csum)) {
+		pr_err("%s(): cylinder summary size %u is too small for %u cylinder
groups\n",
+		       __func__, uspi->s_cssize, uspi->s_ncg);
+		goto failed;
+	}
 	uspi->s_cgsize = fs32_to_cpu(sb, usb1->fs_cgsize);
 	uspi->s_ntrak = fs32_to_cpu(sb, usb1->fs_ntrak);
 	uspi->s_nsect = fs32_to_cpu(sb, usb1->fs_nsect);
-- 
2.47.3
