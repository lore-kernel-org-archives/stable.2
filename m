Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84A41F35C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561570; cv=none; b=W3Z0RFWbv5ropRf4Erb9MM9IkSrysApeOEE9SObA5EHS9I/tkOaYKHL5dkkDdWw2UwuTur3rapnUzRkE5N0wDIkNf401aA27jMRxWhM/w1/E6EhnpF6e+AW5W1tPpWdmKJt/k2ZrZm/Qko0Fw/6AMsvsXjVVwh5MiAcEeG4AXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561570; c=relaxed/simple;
	bh=UShUDqqDRtt0pGRr5Jyf+2oPSIWHCZxXHtVtwrOSd8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAH+nBOPdmJgf5pXN3f3KD8XiVdCF0kcK3YJCgrfvTKrhodcFtVfEywzL3jsyPMy9CprFYqSW1XYjdeGoafjh6CWOPtc8y8+wSzvK+F1OA4hdm9WgCGu4JYR8OLDHlBTaRBx7ZNEfStJ3N4nBxsSzIDnwJc46H+Ubfxcn/fsJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFfhUeN6; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFfhUeN6"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed9866so7973815ad.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789561568; x=1790166368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pp5nSlr7xDYNq3f2m9jAshGg3pXz5ymehxcU1wOHfKU=;
        b=OFfhUeN6+6O89MqujCSrwXCO8/W+VthGmaotuOoUcrNk9cBzppdMPz+t7Ng3iyWrK7
         10Sx6NQqVxGnhIZmLmkOoKX1s219RRJ8fl9VtQDtKrLWf8CFqnqNPMzLvSdgqjnH9rsv
         vYwzFt4AZTeHD5WRd4iACv61tMukkd2NJQxAls+TJVlCatLSVLYd1H1lA2nSv7+clKrF
         CiXFRjsG+8sip6qgFIEZjE7I+WwMyfIbiqtG/NdtMtD/S6F2QmV5ikqwX+nZ4zC9kb9L
         c3MivB364MmjifCrsuBEFz2IM6VJJDoL3v8hz/sWTHo6E7QYFA7tD1kltrcDu2koIY9A
         mJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561568; x=1790166368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pp5nSlr7xDYNq3f2m9jAshGg3pXz5ymehxcU1wOHfKU=;
        b=is2UHDyjvFrlUL+ekXS3xiKlXYakxAlpBeHbiTZaZfks+PnvyvdxG/66fqvL+jSo3B
         OYSOwRr+IUVSDGBFufL1iQ5mJtTMy3OF9EjNoRIrKAD2G777rHABW2Uce4U0+Zl6TiD5
         UnCEGplguC2b/vYqIxq5Cxx5IA8ts3gi7njnqG2yNm9imHL3x2iIXYXiffWUUOm6ZwLT
         cEKiRjU2ggZGoT7eQUX9xcxYJ4Lv2pU7IhGEXWbBjvEoDHh1+/hfnoB/0HR1TiCH0Rf7
         qjW4PC5FzB+91BzQeM6YMYs0LOitm3ZRnmowPeW6phds+bbCm1wBqsg1Yimh9njbaa/P
         FzPg==
X-Gm-Message-State: AFuF++nbGZ8CS0O36pXQ3OfKcGUucQ/+lfM89Bd3wILpJkJtXCFsFFi3
	AJut9nVqX+bC/x+a/eVH+CDO97P4A9tc8jXdiM3Fj6Hwox+mUn+yWnEhsUe8wQ==
X-Gm-Gg: AYBFou3RlHvS0cY2Gfw4wgBXMwwTQb3KqZ16nZgQsvRlwqnYarvySAY7urwn5GI5mdK
	SrRJU/VPDI2n0HFxwQgvQF59kSZttFkDQljLlmfihhVlKyQ9JSvx69/YFx/prj718Lex7b/gIeC
	OsHN3IZKDRbZHMImlMy9m3EB4qOLGmCG2g64pCNl+QIFKUhb/Q8e95nn66kP+uSoTUJbFh+K37O
	bZQ/7zZDzC5eI7ZmINq509a2GaLLWUyjR1qI7rX2naUM7aHWLA7tPdtMRG+PNn7M2/o2yfDx1WJ
	DuPoIOdAhPXuTNzYbMQXYrqCHxsyxGumBZtKylfaFVzE+8rWfxPhnkAxjqH3v87QRMpHcedeJ5N
	0dwji6qmjJmnJ9vnfA9ZCQJ3dYn5SW7kd7xwUNLOCICZR/sG+AwwUFHlF7AZd2p03eDgN7wqxvf
	WoimK8abtbz616ulWpcN9mguughnQ8SjJm0dJz8pGYXVlHocM+p3yRjDo9YRJfIx3KYIDJIJHnf
	L6Iwxdd
X-Received: by 2002:a17:90b:224b:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39e1e4246f7mr5481806a91.13.1789561568132;
        Wed, 16 Sep 2026 05:26:08 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1c540f6csm1209466a91.3.2026.09.16.05.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:26:07 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: stable@vger.kernel.org
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1.y] ALSA: us122l: Prevent write upgrades for read mappings
Date: Wed, 16 Sep 2026 21:26:02 +0900
Message-ID: <20260916122602.3440176-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091618-snout-ozone-8b38@gregkh>
References: <2026091618-snout-ozone-8b38@gregkh>
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
index 23d7d542a3de..21c5a7fcea76 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -209,9 +209,12 @@ static int usb_stream_hwdep_mmap(struct snd_hwdep *hw,
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
+		area->vm_flags &= ~VM_MAYWRITE;
 	}
 	snd_printdd(KERN_DEBUG "%lu %u\n", size,
 		    read ? s->read_size : s->write_size);
-- 
2.53.0

