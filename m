Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD63BE631
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936260; cv=pass; b=UJo5SyGRNKSoF2P5jPbxY8T0DXq750I6qFILmilaqvxbY9C79nmbG2d+x3kJFwibZE/IAqe2z/ZoMJ73PO81DMw7BGRmi2M8uqNYdD2SgdDENikVyK9oG8b+byKvgMzvmBOoq8zdwS1gRlL4iFETiJRZuf+u7uW1C4rpGZX96ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936260; c=relaxed/simple;
	bh=ZckUBzuxfDct7Xtg49y5TXXNnoeTTdLGKQnVGpqLnmQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Vh6bNCQ9veYFwHGPoVvelanPWWezb1Qo6vDthmM3cSHh3z9lCX6T7oHrveuFb2ta9BEho9nsCS05LROz50a8z9ZQdk0agXfH4b7iyzlpk4f2sdXsBu9NjtbeMcoGXccCYXnvwErKaODC7TMeQXaK++7IzdYGC/ulfgF0ixW+3Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EonNVIOl; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EonNVIOl"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5bb54bd5076so1453817e87.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 03:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790936255; cv=none;
        d=google.com; s=arc-20260327;
        b=sLIvHx1cnBy2lqVJHMHeR+lpruemmC4hA04Kd3bteOQbDUSPrd6Srr0qBWLD/75/BG
         Vu/OPVdVKfUGODlE5WUrGSnVmYKllWIIz2KB0IuCjE7Nk9DKdcl1q0xJMI2qtWZ9ANhi
         RoK1VV2jcX5mp4OvRUd6pAIrxJDMsFbVRFaOuzlBaQfz30R5WOhtQctctjq5ICcZpBuV
         b/k506jBXqj2WyIzAldZUTJtq1oFDOwd9dV3hBkTfzTB7W9+V0TfN6kt8kWz3R6i2Lej
         WcCt39jYJFZFiF40C4yr/RxsWl6koEte+2O7c4N/oDb94c0jzRmNjZgtQY5ZSHPw7oyl
         ZcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        fh=JvYEJU/As7n2J0rGUeQqJJ23SCn4fMbQxq3s0wWWxBk=;
        b=Ga3sTVVdHfnY+oyyw+F9aUyYZavrN/OsOEe8TMB1nOL50TCxs8wm83ec9AR536OVJq
         hWTgeTheNLicT0LyFE9/PltNGP2717kD+Khqme73Kk1KuaiL2/xYASaN3rClukas19ep
         R5bsQMsIQJUKIVjXJuJKz0OQLlX+X83BvMRlc2hPZuW9fOIvIuSgpUxYSzTbjSxeVDhU
         dQSMsHV3OJbIBIjBqNkekfe12JGGLkM8Vpx9rq5FwzYaFfX6r9AZecL1u2d0zkjRGM2J
         kdnun9H3ulorSd/XsB3ImEd6Tnz2AYh3Kv1mdtoHQB1duARCLIE3VxyTctFOSFmUF0km
         Yq6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790936255; x=1791541055; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        b=EonNVIOlF+cFCJCYJYKU6KJkZjZNdysmtCPlTbyQKrOXOPlzwfdw+EUCRclT1VUHoA
         WcMBiaQcH6nqw87mDTcNbmHGcIgboJshCez3jYSWcgnIwX6dxLjaVmc+VdiTQWqtt7EV
         vhFImDC5fv6IhMrmaY4F9X9fvc90nkJHu53T7Mum3Zx0A+HWVDqkPNlCQyrLl+Rey6Pb
         umqnjvXTh++rmf2BIE7H6+/MGNkq2j12ZvgiUmVquWUaN8XEWMUkoYlJnjG7HmL7VIKc
         VN6688EVh6gJXsgPuczbueH3X+MeAhgndBvLHD02uc7cXWlY881dJRQVzp9muZcxOKGA
         dc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936255; x=1791541055;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        b=rYiPE5pCEVRpmdFVUJf1HHpKcYyaqPxgqo2uo4P3SM+kXaEh76MriF0IPEc4Z6sbU7
         bvF+/F9XsICrdOYT6GPtkey/6zJgFEFjaIrU94XbFCCk5tiNdfqDBD5y6+98wHKOfD1E
         1MMNS9kP1Ed3JB7kV8l0SuQmFxII1tLhdcSscWa5/iiaITqUb6+SGzxkOQDQ9auUleBM
         /etUAFDoCnxKPXlTEMii/c1c9MvrAJrMD4D7IRrWNVG4TXgWGKQUjSVRdGqF/GFX8mq0
         UbkHhkx0f34ty1oEXqFxCetQ+KAH/IZSCnhL3HWoePymfJ7UdK49tGpHwc3g0MB7xeYK
         6Tgg==
X-Forwarded-Encrypted: i=1; AKwUvBxG5b7BiJS/9r+UArLlOTZQ8S5zPAt2ev+uKakEQQaWaaEy7YtmZ56EF5S4OqzAVCDlye/GNwc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFb1R82/mfFFnAEVfy8T0VGr7ZIuFs0g07F88K2+XSaG1cs7du
	sBrz5LtZmCaWQp7T0lGFkK36Nd3f+PO3S9wzWkbOW/7V/D5Qf3YmXvB+uFZPYr0CAVAo6q96nwu
	oBNdGCSLLFtB+z5EZXkNo12oLdBZf2HBKvcIejHA=
X-Gm-Gg: AYBFou0cv7O122lXC4cAF/oTKZDYIyoJi6c2ELVKUo7HTasIuOY3o/EaCmNRAjg+Mlp
	dz88QeFyUCgezPK3IrrtOPcDnAs7UwdpigP4i1YZj1g46Ccci7LDdZtgDQYW/5oulNr6sZM/hNJ
	eT0HAYWE1PX/9V5meuv6ueoEtFRhFgtYy0DOcoNDGSPPiUvngwGlvPQ3mjRkews3cmbxzie14FP
	A9z0QR2kBDwegjwQo7O66BjQX0Kq93BlV9hL/i1dAp6lzZDqdHraIbAXsQ0Br2LY+DnLVDcxb9q
	C/Ocygtl6b6Yh3GivJAxEv4h4pg5nfFv8OPxBXx5pQtVQ27bYxzw7deFP3O3RkENye+pe0+gyeV
	ItMPsPbm45SD5
X-Received: by 2002:a05:6512:6c4:b0:5b8:b3a5:827b with SMTP id
 2adb3069b0e04-5bba4bad0b8mr860497e87.40.1790936255129; Fri, 02 Oct 2026
 03:17:35 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 03:17:34 -0700
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 03:17:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Fri, 2 Oct 2026 03:17:34 -0700
X-Google-Sender-Auth: b1pJKT9Z1GEu05wo2aWT0OXX6Hw
X-Gm-Features: AclHuK-XNwrA2EcOc4Po4ch6BRKkhiv-zVlU7CDstfm5bS9uo236ZWXHKZYEhbU
Message-ID: <CAANnmVA26uyaCx6_Ph=BpdUyfoNH79KzparVquuv=BWqa_Mp7Q@mail.gmail.com>
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
