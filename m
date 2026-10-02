Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A89A346FB3
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936257; cv=pass; b=H6SNyPwf19fYd3f1/8Syjewo7XE1jJzU0djArPElZVTa02r2vMRUpq2VCTke1UFoO8BtHKMPe3V5124ewQk+egukX/OsMF6arjednM12Fp8Gdvi0ioz2G4yAgPgzzpBKOstNL60iIVOTFy6py7t4Y7VKenBlrsG0MjuMqc1SA3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936257; c=relaxed/simple;
	bh=zbxh97DfahtmVFw2yx/P+OI0PpzLVE463PD6gyDR+VQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Wu3lKdWY7hUmxD3tvGBzhe3VxR9afw+5yGsSTHju1EYmu03Y1dqrkzccjiC6jTImBB2A89OXGLksVASQtUM5FbMTEPDdeBnxCgxR3ilIXxiwbXDkmpJrNGlSCEmmweO+ArXrUlNtg9bLeaRibGLw+DA+bgyqsVEkjKo7ZOFKjZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcOzz30+; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcOzz30+"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8e6ec4dd4so5879618e87.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 03:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790936254; cv=none;
        d=google.com; s=arc-20260327;
        b=lEcYFEoRQZamj88llDTe0HiGR8F1ZSKvaOOqBQD9ctc/0p/VKbB5ZrnsirvacxdFRY
         hJl7vAZ8nJIZmQvidcd2cV5oDqQrb9AIUZjri19ezQrd/SJ6X2uVqAvmuDGWSXuo9AOn
         RlmgVjqtdmH7nPnKrjX55QPgbfjCBi3K6A78nVt2UD41EWM//XgMyr0hj/BOhDJ6/2HA
         FN24c7UeuQRcqkgpEaCCQ8wIxnAmilYXLS6gpW5gEnf0xGPXPiWT5x5xJkBbYTspkrnr
         fHyRu7yTzqrDj2dl+FWY2lUgpO87aAugex3Xis+8INqW7mEm/rWyT8EIQ9Tr9rnGxVZP
         4jRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        fh=2N5HigfpShdnkHd9kKB1ZBWbPWlVibD4fXS3MI/vQzA=;
        b=GBOteI0R5owxw1uJQAdrefN8UYg33xuonWM2MfjEL5bC/UHJsUi4jEUNJR3AH/P8mz
         X+ZBPD3+gvwCgaMX/H5kwKAZXhzD/UiZN0o0Sir3ZvpxEToS/yb7cVVbwY2AeZNV1ANd
         yKKfYPyIyHXBL1wnJlCDVlAzXLhHGc8KAlrSxh0VOAlmBfCF0vl+WBFhgMesr8lt4zLt
         Pg77hFyor19ImGSKe8yDxJERbYQydKgz8Mly2ogkMRVVFN7d6Zg5FedR25GifjrAoXxH
         RP7K85b+4SKG/myrrBxDLKSU+3rm4+XXGxz8Eug78EdJq3D9DfXybYavg/a+873miCWR
         T28g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790936254; x=1791541054; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        b=FcOzz30+98AQjHVtR7UVXsOk65DwSxleNmU2lZyXW+69OCS8ZlgQPAarHp4ChW3oYq
         Yvr1pR2Mlh+QoKspvzNhNAlIjA+li3LBnxwitlOVvR2XR77Xh1aZYE831FLVJP+nuitn
         hjlpfgpGnWNCKi+t9JVxwDxkGD4sYOh9Ew5FSfEbKs0bgh8BHvrkRKcHMwAOSeOQ9P2O
         LShQ4VVUTfchQWAWWiEofa9S+bIzL7dMMInT01KRxprawGeQe7fpqH61zCulxVMQAUiZ
         xLQH5SL6Q02oqDthD2pqvjXUyj2cB/aLqFcKuEABXvKL5M4NtnD5eBDkzDbsYhm02Zz9
         +hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936254; x=1791541054;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        b=tKEZbDFXa3ZZG0fj43dlrs5d/CnBqACxPmQtISMHqRlh+0GtoUijojd+AuFiOGTxDQ
         Gd1gHjQ3KJciwLv+W6C4kFEjrdT9ECex3zj86VP59tH4l7fpAnaQ3+hbMvkWJIDiU/p7
         ona3NM+rD3LfHDjxMWWMvd4a7MkHqZKlG1GNGqPeR4l/mcL5T3dGqMFranPv60CrVOBe
         +6UaSWkXBaNVGUI4eIYOl1NFg6QoWgxvp4E9zOQZoUCTzGKel+OOAK8p0+tk8D1q7qRm
         s5jTmEG32M+BCaiyaSVnxMyrDmOMSdsjqZiA9T5nX5Egj+iyT238QavAhRnhF9kh9At9
         KJiw==
X-Forwarded-Encrypted: i=1; AKwUvBx/bJBe7LgG8jIMB6mol9S8xCe0cgnaOVdH3Xaz85SNdD3qO3jBcSDxnTpoJ47lsodEcTaqrk8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8X7rwpXKUNQYaeoUOe3xRNloEVvaGzpX5j+HEWhZnD3hoIdik
	WgVi91oSifzzmOGyOH5I7RJCF+xYceKX9vT4rGQ45nCtZEwBiTSi9UqwcafYVxPKMRN3f3cEFlB
	1g/cIIfWX1fF4I3bKywkCCfgVcGDM0NU=
X-Gm-Gg: AYBFou3MGT7Xzw47ddjrK10vuJ2AZRFB+gfN0HWLTA6lI7r4K4/vCNH1YkhvUPmvLVU
	jmqZVBkochiVhmhVq/z34OcTEN8bg+0gCGZn8oMLaBYfTQoxE9/3PY6aTN1M5iznFaFLWM5IBvD
	7L5XTR112t55ZMlDxCEbkB5AMHSWvsDjES/S+nrtNESmK9WVnWLE7k73ms82T3BBiJeXDn26OQ1
	lCRc211EJBovwAB0/jVY58PoBotFCcjYV1YU9RHMcpNhavaDVrKp30Lq9oCdtGZLluc1DSB74M/
	JFOAlBO2oFCYt6Iwo54Ao8oecFHSEndVG5MaZDm6x6XiQQFyhv+C2CPwsz9OtRBiwrwwtruK4+3
	b5eCHURnutwaR
X-Received: by 2002:a05:6512:3b8a:b0:5b8:e94f:8d79 with SMTP id
 2adb3069b0e04-5bb9bc25b94mr598164e87.64.1790936253817; Fri, 02 Oct 2026
 03:17:33 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 05:17:32 -0500
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 05:17:32 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Fri, 2 Oct 2026 05:17:32 -0500
X-Google-Sender-Auth: rgVdU-Na-thylIHC_Y0SkBWvGuQ
X-Gm-Features: AclHuK-11oArOlh6vzmbSmxKA7acyV-S_yNov9Vtcz6DICtpbHOmyRBdRUJQ2o8
Message-ID: <CAANnmVDM9VBqwwDKC8kRn8zAP92e_STs=EVNRZtZKgqWaJaLNQ@mail.gmail.com>
Subject: [PATCH] fs/adfs: check name length of big directory entries
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, rmk+kernel@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The F+ (big directory) entry format stores the object name length on
disc as a 32-bit value, bigdirobnamelen.  adfs_fplus_getnext() stores
this value in struct object_info::name_len and then copies that many
bytes from the directory buffers into the fixed-size obj->name array
with adfs_dir_copyfrom(), which only validates the source range, not
the destination.

Nothing validates bigdirobnamelen, so a corrupt or maliciously
crafted filesystem image can specify a name length greater than
sizeof(obj->name), causing up to 4MB of attacker-controlled data to
be written past the end of the array.  Both callers of ->getnext()
instantiate struct object_info on their stacks - adfs_fplus_iterate()
via readdir() and adfs_lookup() via path resolution - so this is a
stack buffer overflow which is trivially triggered by listing or
stat'ing files on a crafted image.

adfs_object_fixup() also appends a four character ",xxx" filetype
suffix to the names of non-directory objects when the ftsuffix mount
option is enabled, so name lengths greater than ADFS_FPLUS_NAME_LEN
could still overflow the buffer by up to four bytes even when the
initial copy itself fits.

Reject entries whose name length exceeds the maximum defined for the
F+ format, which also leaves room for the filetype suffix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
---
 fs/adfs/dir_fplus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..ec663bc12a92 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -192,6 +192,11 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct
object_info *obj)
 	obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
+	if (obj->name_len > ADFS_FPLUS_NAME_LEN) {
+		adfs_error(dir->sb, "object name length %u exceeds maximum",
+			   obj->name_len);
+		return -ENAMETOOLONG;
+	}

 	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);
-- 
2.47.3
