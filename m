Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BBB4BD108
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561594; cv=none; b=SKSFdKy1VTbnlbTM1Oa8fTuuite1ACFnBQ+yBsVcD3fXQPysF1mzjIwhF1pPf9iaEGnnXcxs5Sp/kXIBd2LPIYeyb5PHXJLZ46jEZuAO1TqE516SN0cnAIo65R+69upA3o5EeliJEWDgR3jFU1Aj4qdHmJW1nPTLoJe7xOPdGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561594; c=relaxed/simple;
	bh=UShUDqqDRtt0pGRr5Jyf+2oPSIWHCZxXHtVtwrOSd8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdIdg/76QPOSW/Xk9fdJuYX+ZkH9Bd35zGxCUeSTcqVFYw5Fr51YwmagxXdds6x0/EWQdeveXL3rGBoPvjhCukGkH5GyEpm0BCqCBPz0xkHu2u8DEgPTOQnDOD+9Zjl65u9PBEZ/UC3dcsyHv5i6998YUX/HjDVkQzNfFCqa+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6sIzgzy; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6sIzgzy"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso645533a91.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789561592; x=1790166392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pp5nSlr7xDYNq3f2m9jAshGg3pXz5ymehxcU1wOHfKU=;
        b=S6sIzgzyVcoMrvF6TNrfa/d+fkDsiStCf5JPLtKEQzwnlABra1d6Rq3STT64tSAwjt
         ihC1nN4qi2Fidve8Ut44rzcRKuAuLjs5+jH8fXoVJk3E/dqNHPOVHGacLhgmVpCJHOie
         ZheKJA1hToAGljvYkkmiEKwi35/+mgh+g/1EXjn08Mi6twXRQeVcfFTYIVuMsoSLpHop
         PTzbCzRR6YmVI00aEmSML7b/CCQu2YKreq+oQ1rfGFDkvhUDWd46mKTTu1rGO+NHJ/uh
         Jpgp9tXpxRYu4gkQLC9a3JgwRDKutx19ApkkKMSRSmE+uF+18jZ7lxeWl4IfuBZl1p4h
         +JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561592; x=1790166392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pp5nSlr7xDYNq3f2m9jAshGg3pXz5ymehxcU1wOHfKU=;
        b=zaRgHQpZ7J0CU6dIxKvo3d+kCuhtNo3gqPzvzQEbonvBC0GD8MHswTkBNvyonl3uVp
         RsxR9/0fBcKBgDpdgsKX2qAJJKCDHiOIBO+HrlYfLLkmYhvftD/V3Nn7oYg789dowGT6
         5EzRzwZuDamri1CB176XuWVG47gFTzFAotD4ONmBJPZY9w1WN9maZbrU3x4mgPZlBGyd
         gvZ6cBr4EKwzW3gb+Wn8aLIhzmmi3P+uCyUJ+y1rQuYCXvv+ZiT9eDTyDGKG6upcqh6y
         M6hcDZwKqO4mDGxWKXjMy2k+grmjtaQaiRtV61ufEN23/2YOTf6J/zYlztUHKjSzKzLV
         sD5Q==
X-Gm-Message-State: AFuF++naMKcTbbz2ybSVRSxqn8pKvPPhDZX2Uj8EA6Vw7A42Ipj1G0Pr
	tMQqSjpMOPZ46qikdBbyB2olf3cIUXWzHB5QtjOgbdDspX+Vl+FxYnChj69Vwg==
X-Gm-Gg: AYBFou2Tx4nptgWhS+TyO9mO013RMS05p4QS3mJ6BmprOK14oDAUQ71zQ4KBGWhZsRc
	Lcn+D/iEh/oj3ja/Bv1ify0M8b0n3qIUDXoeuqpOqy0mNSr7pEmrEcYuzlbpe4QZ151zerUHV1b
	+tjqwazbhex1uJjudwWuYDc2hHmaC0oT8cf31ARjG6YOAG8Y/OQOMb33tz3c2nOQVdKYNgYI4ki
	+f6YNwOVRzVB//LDuZ3ETdroBvVfPqxLeQXlj0oY8tNCm/qIXyTAqGKqYKzpXUIgegF5/y2NhTQ
	lQWNhCUzt8QCLxvkc64soaqUVdH0Zop+Ba1S6b+/bFIhRGNcM1Vs+kjakEgfdtp51nIKiPoF83N
	HFwFZI0pLtkhNEzzfQK+R7xkwjvgDIwmk+FkUEwzOnvmL0hDmybe2qMHKxc+1Itkuib/CLD9T6K
	ivECFKJawTSR2SEClZyh9PqrkKiEk9nXvciMG65PgVrTZAquUJiy3GwiBT1SjUUp6IlFymq7J7u
	RN/HYrR
X-Received: by 2002:a17:90a:ec83:b0:39d:eda6:8a0b with SMTP id 98e67ed59e1d1-39e1e50af4bmr5934657a91.21.1789561592250;
        Wed, 16 Sep 2026 05:26:32 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bb9f395sm5360684a91.8.2026.09.16.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:26:31 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: stable@vger.kernel.org
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15.y] ALSA: us122l: Prevent write upgrades for read mappings
Date: Wed, 16 Sep 2026 21:26:26 +0900
Message-ID: <20260916122626.3440345-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091618-varmint-crusader-6acb@gregkh>
References: <2026091618-varmint-crusader-6acb@gregkh>
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

