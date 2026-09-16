Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D84AA3E4
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561539; cv=none; b=Yj5xRj1I8pQtq3i6GdA/F/czUUzS6tOBOtoRSzs3XA+3wQuzHnaLtX7EfGvg0dQik6P6uJaIWiiz+AXRuQFdk4IlJgbL0EKgazlBMqnGA8gMN3hn7JqFOFn0yRrgTmMCoyPAtTK51Nuqrgwz7UL3GfK4JgCC2S/+jSdWY8XJMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561539; c=relaxed/simple;
	bh=FGr9Shz9BSAlNsuspvli5xP7a3WM/S48TPy5slnK+v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDylf9q77BJY48HFwS2ckJojCipg+LUOSm6nfnFStMX/8Rq8uv6X/BoZq0jhts1Tieq077XisBpdyLafABx6dNBBCwJQlPmF31VA4JlSBstBiHv6lnfBm/T/4YxtiAq9J5BABYDgknRhVmOO06tjiXS3qQrXfPGlXKbsweiWdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msnGPTF0; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msnGPTF0"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8623e5d435cso202892b3a.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789561538; x=1790166338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AV+lCCoktRWzmvoejBkgm7hcNqqryAlcCUkIXdAGlSY=;
        b=msnGPTF0xFNDmdwGm/prli5rNtvRKfziCtQFbjKvJB+cMg+U3r9h+EVWgpFRLYd2n5
         SRFVAHLjdY4v8gOIKHsmmYERrIgK55SXhOlUM6G4/H9/JH6l851EAQaNi0kw4QC7/qS+
         YoxkucpNkNQ46FXZHGesJ7sXh6I5sU6uovuGXJSsBEWGKaPmkm7u2jK4qOlxLduCshjV
         pE983hIEZHR50gQln1iikG/dpGGx7U/k7fr1Tn6FYTiobzSVsmOsfE3Jq3rmsB7TBs+O
         nMPwXIMiSzF2qGlnDoET6T8K2SvEUFSd+P1M+axHEw9kkLfz8DfOu3TmmpD8lfpsRddo
         VCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561538; x=1790166338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AV+lCCoktRWzmvoejBkgm7hcNqqryAlcCUkIXdAGlSY=;
        b=fFr41FfkBhdSc/HU2kB8Y5SMgSB8os5k/+9doRRZmgHXL7uL7ayUXYGx0ipx7DRcJw
         0Ismt6cgEYhu3dPgvxbgfJqvc4r+r+/fy2B/1nLGxsCqjXmUfnkE3jzKWkAdU8RXwBIp
         j0uEWyLem2ivCvz9ReCapuwuG2voqpT/0cGEjb4F3gm2/vmfSsyTvgd/fVM3Qwgj8VLz
         HrKbWJOQoc9R0wuaqE4a7ifbxheFcA7YsIliyZv8hTessPV7cqi5xCZZ4A/EJec1EFnK
         UyYlJlL5MbEC2Ozd6a7sD15uEKJM6H9sT+p08M/1n5Af0MiCnLxiew4IK2I6/vNJ7QOF
         TskA==
X-Gm-Message-State: AFuF++lSmsplz/HUd7BDHXGJZFBqYReASySKqGmMTZx5QrcsoX1pZx1c
	aRFiFyAm/BjKBpyFqK73d4RS1lKK8wNdW3Mc2xiLMDqT/Zr8H3uD7y76+aMz3Q==
X-Gm-Gg: AYBFou2MAq2i4/9PHrEFbEY/3h146PpYLv8CSfdIvv26S+g1Jh6pG7umomBWrFmJB0G
	7oebnvylQkfiQMaMIWg3TkTY3By65Up/rua3dzrjWGm7HGMrrDq+xPWRfse87JwCXeUVI0lA0N0
	sv8YIcYji5On82dXm4XFFRcbHIndVvQngi6h+OCDa8gIdwF429Zp0Sq4SVf3s4gYa5VfNYKUUbr
	3wZDjelRdbHpGzUw7L72oJ7LrMZ5fD5cy7JN91X1paHuI6l1+nxxS+F0J5NeaSDLpiXh+aibS73
	g1FWlsj17Tcs4IZ0GiV46iMQ/I98i9ops0alSSF/9c8O/K9iWv7zC/QxyAJW+jTER4KUuODVuJO
	IT5T+K6+t065GGUriR3lQO76+gkqcBowmCOcEf5SCXTI7ebmFqi5RapwnjCvD/k9iFISIkJQ1rN
	gpi0x2SYoghyVzXggb8xz5atNTyShx8aT+XZoiGxFyO1/cTudXzPxTWiaEp8l50Ys5fkLvyHWfl
	60FENv9
X-Received: by 2002:a05:6a00:3918:b0:857:72f8:dca7 with SMTP id d2e1a72fcca58-87234e1e055mr3139295b3a.13.1789561537349;
        Wed, 16 Sep 2026 05:25:37 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8720172f6ebsm1141202b3a.34.2026.09.16.05.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:25:36 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: stable@vger.kernel.org
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6.y] ALSA: us122l: Prevent write upgrades for read mappings
Date: Wed, 16 Sep 2026 21:25:30 +0900
Message-ID: <20260916122530.3439898-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091617-bridged-thrill-e9d2@gregkh>
References: <2026091617-bridged-thrill-e9d2@gregkh>
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
index 612047ca5fe7..36167300b8d0 100644
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
+		vm_flags_clear(area, VM_MAYWRITE);
 	}
 	snd_printdd(KERN_DEBUG "%lu %u\n", size,
 		    read ? s->read_size : s->write_size);
-- 
2.53.0

