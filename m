Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2403521886
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929982; cv=none; b=J8qPSFSjNVvN5j5k2P6ksj2rrzIyJZYcatfWQBmlfY8lKR45lIY7/nX+z053sXo1f1vD0tQ+QC7HZMfkp4EWqC4xLxN+2XeHQFa1ypQZ+B3j5K8vFvHLHs2irfdVaa6HwNqsHyhAO+v3vSyVqID2S7YccS+4hVwvQifNxE3Bff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929982; c=relaxed/simple;
	bh=A+I/86KdVa8jIDGYt6ApDmQiXDBusJSa5kMa1fb0xTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZOiKE+kwb01yrVATCLKYDxQ6T2clA9tJnAQe0XJSCSVxEA3gxHw5l7rMZLFMJVd13xPDhFHwOTgrwc54/DJ2ICRg+kJKYV8mUiRx17tUQNLvlJg4xpbMeGku2WfeoAzDtsS9YljDMstSE3OQvHewn9Co8CCrzm7tJOTghRs2pFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9ivcEh2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9ivcEh2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so3103955e9.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791929979; x=1792534779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfkApeXinHFIr0p8vXlFlLyypuKINDLCCxfSgft0shY=;
        b=T9ivcEh20L2Gnf55fpi7DhP2HKShJOGeeTBrs3mIni6QHZp0ttdbtyyKpxc/m9Vce8
         06mrG4FlYTMFm7pK4KNdp14OM3toRYmxvEltNOFm6CdqSKmJH9wYrgNhzFL0ghGbiRLK
         HZdBJz1KcH9dup7ZCLkndjoFeAnmT5BuQGBYW0ipohtIy1mhKFvifFngR45FbEB0EMYh
         jhGgdXYmyQqe1X1d+jTdxoKjFDzskAakrug5B3aBOVNYioYtDaWRVI2sDYDxWE+5E0Qe
         k2+5HsHdT7D0Mq8Nf7IYBc6Gv8Cthsb1oUwt/RCpiHkaxdqHfezmgxOixLbW4Napo6z2
         FJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791929979; x=1792534779;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SfkApeXinHFIr0p8vXlFlLyypuKINDLCCxfSgft0shY=;
        b=Mr6/QbHzhslPMdHglZ81TMwflCVpHFDR3J7jy8LkygbDweR/0smDgLOAFJmwgL+WUn
         +0JvFx+XpeYAY15mg19X3p2exD0ug9hgDct0LShMMolhReUN/XG3yP9rm0LnVH5+Jqut
         op5pZms6QPY/ZNfcFRv/ntac0pL662CgSbvzclNGrTVWOjQokp7AWK7U7f3bj6QTUNB1
         SVMafuTBzVujvvJ7tkGA2A5ir4kvyDU5j2ASJ6NmJAHcc6xY9QxtoiYEofk0wNKolFlI
         RODoQE9ELHOMntB0oJ7zZ3ZNtj+ssU8s01ZA0V7UwwugC69/m8f4LgKD2qFSvryOuI+R
         oIfQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5qfd2Ired0lNju/isGb5jAvhmEQ0ilXraFa/0+/CyzaKQPaq0oIb+Xp6uEUBpB/thwDo/JwQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKj34Z59CQXN36z86NslHF+ho7gyePneIWR/tdE+HuITvipFTzH
	OacNM/XpWgaeuqKeKqpO6QihrIwJmuhC/UdZ/fHDumE4q6U48KFuFJ18
X-Gm-Gg: AYBFou09nJ1wsMv6zGcMdOc4IG/YQukCW3A0rtK7lZuoQxI/28CUZsTUXD5kAuDiGA9
	5BjyKmsO6oiO8x05CPN5Fi1C2gJFvxa8eN5MlwFzx+ehPzzObTYlY+EZbG7zZNdpwP03nx3FZvG
	G3nNYu8e2qQHEzjqyfde6/JX5GK7vjFRv45mES+K9aNvrUqZhsxmuQOvFnxb6+mUMJUXzpyWHj5
	ECMjjtubTsbmqBc9frgdnfR9Pj/K5WWG/SQ7byCqoPM0RFUm5zPfhc+zy2TndIJxCGXLlT/7eC+
	Nad6FPaUtmkvitBfRrBte0rcI2iL44Wt1YUZIkfcmIDboqWaUKt2bIV4sWpSkn5cuEgNJLXDV8X
	qRQR8JIHNrmflhBns1vArLQMpJPRQLs4yyvh3KXmr+kjupvYU+3O/JGaQFlHKZgMLtK/6gTlVLB
	HAFOxIxXW5C1MhCzTPfIsITGvhCMAtM+2onXQR2UcDZQQQZfCUhTZ+nfSvmHyAWD+twLt4WQiUl
	557O/5Cdveh3NS0Rs8IzDsDt4SWp2/otC0e29nTOYSEO0fQGhNFtk7nDXgurOFynmFHYmDlQsdj
	NwBa5CudwqeqgewKc0ItzbypbGFih/RMD909mXfRokkSpxVOWXavVfJlSATuUPUvbVeSkwcglzu
	s5+bPtYP6/XF/aG8cSoO/PntjZ7+NnAuD26//8pH9vyCOyjB5wPyqdq0OmpkyBoNmivY7vPPq3W
	m5hnCLq1Aq1edh5zQ=
X-Received: by 2002:a05:600c:8b06:b0:4a1:7ce1:2eaf with SMTP id 5b1f17b1804b1-4a18e4e0963mr279668475e9.34.1791929978906;
        Tue, 13 Oct 2026 15:19:38 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:412d:e9fb:680d:a947:4b50:d9e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18beacd2csm428992205e9.14.2026.10.13.15.19.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 15:19:38 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: linux-usb@vger.kernel.org
Cc: oneukum@suse.com,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: uas: validate status URB length before parsing the IU
Date: Wed, 14 Oct 2026 00:19:37 +0200
Message-ID: <20261013221937.41490-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

uas_stat_cmplt() dereferences iu->tag without verifying that the
status URB actually carried a full IU header.  The transfer buffer is
a freshly-zeroed sense_iu, so a status URB that completes
successfully but with a short or empty actual_length — observed in
the wild during link-level upsets (Thunderbolt-chain xhci blips) and
on a wedging bridge — reads back as iu_id=0/tag=0 and produces the
misleading

  stat urb: no pending cmd for uas-tag 0

log spam seen e.g. on an ASMT135x enclosure and a Samsung T7, right
before the affected commands time out into the error handler.

Beyond the noise, a short packet that happens to carry a
plausible-looking header could be matched to an inflight command and
drive the state machine off garbage.  Bail out on anything shorter
than a full struct iu.

Cc: stable@vger.kernel.org
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
 drivers/usb/storage/uas.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 265162981269..88fed50c262b 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -315,6 +315,13 @@ static void uas_stat_cmplt(struct urb *urb)
 		goto bail;
 	}
 
+	if (urb->actual_length < sizeof(struct iu)) {
+		dev_err(&urb->dev->dev,
+			"stat urb: short transfer (%u bytes)\n",
+			urb->actual_length);
+		goto bail;
+	}
+
 	idx = be16_to_cpup(&iu->tag) - 1;
 
 	spin_lock_irqsave(&devinfo->lock, flags);
-- 
2.47.3

