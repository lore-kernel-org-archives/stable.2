Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A392717B425
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561492; cv=none; b=QacKgZ2O3Y4bPnzu6WZxScF8qkbXiYd/jfGaDwuq9XfEQMLNA05RcUwE7YWeglA/kh7ZIbOtwR/hJurW8w4Axwk9cwFmhlsQtHmHCH9ZJn4LqdW/4yeXjTD7+L2kVl/Ox00YZmc5EDypJau1UTWdEK8fu2LVbDzu/2DYULOvl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561492; c=relaxed/simple;
	bh=mv7zdY9WWZxBVn1TBNZp9qz7x8UsaNnhCPEP5ctDH48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf8cdrSIyRrSmrP1JSo2sMdAns6utBL1UrxOFB6XB7FVVPyFkoP3vtPetXtpK3WJbCMrU6d1LBH+leNHyFVIm35wkkvPgMQj62tp5qU6vRwIV0hfqrbwKdO73X4AMxIyI4VBLFHF58ocidGwfoQSotanlusFOrZkjz5kq8kjfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEBLtr3s; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEBLtr3s"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86212a185dcso812846b3a.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789561490; x=1790166290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrUZnRAaNnQtdCQz/Of4Jhp25IoStcNrwmd0bgy4cTI=;
        b=LEBLtr3soWvtuRI02Zvm3fOfhw5TEgNqMZKvqr7pLH4viCYJvYtDWj7tzDtsIonqcE
         Ah5XlifFYTKdU87/Ov8Nx9Y6aDrpTjGJWH/XmtOUiQBgycVP+c4tzWg/Vziywk3e/x3n
         elK0dniO7MSoOhE9C1CApWGPGdD6Oph89jA5yhNGCPdvT7HDoOYrOZME1tconGryf1uw
         1tBimis+TkoGClkcG6czjNrQpx0wXSH66yZmB2ase0QIcCtQIPH0n+1ATpOrg6F7aDv6
         auffrrKhk02Ogjt6VGZBW+JkklN8E6o7B5hrRtnTmr6t5IaQL5CE2Yr2MhkolL0oy3Ph
         GJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561490; x=1790166290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrUZnRAaNnQtdCQz/Of4Jhp25IoStcNrwmd0bgy4cTI=;
        b=aw55bPhm+OTsr5HltLYGzzml2hJ+zQT3KTlXaMlG4+k9omeu/g+Sz8NxDrGPgOOt8z
         4RyGtwepGWlfnAWpHmN4mifuPWm3rjiGtZLw/3FWtnvgcrk/bEr4lyzjQtvDfsBc7PpD
         c+JW08Hz+2qbltOUNudN1Dt/0ycd5iljsbu4fMVaCVtgQ7q5AyrDgSKaJjTx/s6mzpnF
         UHyRBSwy6yaCbUWVhI1Rbk3T+LZXh2Vo7Mj5k5wkK5sMc5nxQpFIXKvaOrXXsIvOZNzS
         wiUzsmIl9HK9VjJnCqX2mWLdsF0amYyONpOBma0NoVyUPhawBCutrEtHIeEQpUxWxUBm
         TtTA==
X-Gm-Message-State: AFuF++kDhHsHDwFQsfLKW7UZpK/Tard+bdn9DlFkxqVKLMSFVO5/c57r
	uBo2kLs5GmnjEwJJhtf1G6QzAaJXRU9LzQh297LgDYzwu1rYY0Nmib1R9LK3rg==
X-Gm-Gg: AYBFou3yA0WDVtioWtp/MJx8qJ3bbzwYJJLeFyUwqT7VUL9vfEizydUcNFKnKGCOCTn
	F5usb4BhvJYw4wQGCus0YU6BUR1QW0nWiAM8EgiMKbTbrSDsTbdmyHhmCb8H+4Z9uCry8lOAiW8
	fNlmcC9yzQWAUcW7LuORi45nIvB9sghYwvxUpLpyM4JYs6fLxctAZHMA4zTafq8VAa5/UXAMV/m
	DvGCzfR7JCi2Dtl8XSSpZxc0UPQnz5nTxUASr9eqnaiF1esXFwCcePyTgyN7UEJXglOEwjz4/Rk
	PXw3MuZh9PBXX7FhgG3hnTbAq7ul1nuJHJJJAunOq/qBQZBT4gfDeqMZeeNXuTmOAI08sI/3cZc
	4QnuaQoPos1xkG0ZhpPbkMgvePBPRB54GErFAwkwAHTolHi3RCvD57vKnUyKfD9d7t3DhJquWUn
	o8ArntcHsIb9T24NuqMEyJj7Wh3ATbJjJA7IzXLfPA8TlUMi+nXrIIHiQz7vMBOkNnUQ5coCcZ6
	5A0EMr/Ug==
X-Received: by 2002:a05:6a00:9296:b0:871:41fa:d1d6 with SMTP id d2e1a72fcca58-8723cf31f63mr4341374b3a.14.1789561489839;
        Wed, 16 Sep 2026 05:24:49 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-871fc14239bsm1166004b3a.0.2026.09.16.05.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:24:49 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: stable@vger.kernel.org
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12.y] ALSA: us122l: Prevent write upgrades for read mappings
Date: Wed, 16 Sep 2026 21:24:37 +0900
Message-ID: <20260916122437.3439484-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091616-crumpled-gizzard-8ee6@gregkh>
References: <2026091616-crumpled-gizzard-8ee6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hwdep mmap callback rejects read-buffer mappings that are initially
writable, but leaves VM_MAYWRITE set on mappings created with PROT_READ.
A process that can open the hwdep node O_RDWR can later use mprotect() to
make the mapping writable.

The read allocation begins with struct usb_stream. Its read_size member is
used by the fault handler to decide which pages belong to the read buffer.
The read VMA intentionally remains expandable because pcm_usb_stream uses
mremap() after reading that size. Changing read_size first can therefore
map and access pages beyond the allocation. The same member is also
consumed by usb_stream_free(), where changing it can make
free_pages_exact() release pages outside the allocation.

Clear VM_MAYWRITE for read-buffer mappings after rejecting an initially
writable VMA. This keeps the separate output-buffer mapping writable while
preventing later permission upgrades.

Fixes: 030a07e44129 ("ALSA: Add USB US122L driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
Link: https://patch.msgid.link/20260908110053.2950767-1-hnkz.64@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
(cherry picked from commit 71c610aeb1770302ac9c9e0b9a4ecd37f1311928)
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
 sound/usb/usx2y/us122l.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index ca5fac03ec79..2a107803af88 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -201,9 +201,12 @@ static int usb_stream_hwdep_mmap(struct snd_hwdep *hw,
 	mutex_lock(&us122l->mutex);
 	s = us122l->sk.s;
 	read = offset < s->read_size;
-	if (read && area->vm_flags & VM_WRITE) {
-		err = -EPERM;
-		goto out;
+	if (read) {
+		if (area->vm_flags & VM_WRITE) {
+			err = -EPERM;
+			goto out;
+		}
+		vm_flags_clear(area, VM_MAYWRITE);
 	}
 	/* if userspace tries to mmap beyond end of our buffer, fail */
 	if (size > PAGE_ALIGN(read ? s->read_size : s->write_size)) {
-- 
2.53.0

