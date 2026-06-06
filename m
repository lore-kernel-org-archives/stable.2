Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA13AE71C
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752369; cv=none; b=VPnN8/810kKSTj6OTZPCsWioBQuhsDSANuKs7kr5m3IdLWHPpgKzr8nQQDwVw4wkSX9IKJCaWaxAJ3EpiIJsxCXlNIgDW0iew60sIAHJwJKxqUpln1Z84zQzmqg8gLD4r/Ydkv3VAILebMAujSTc8xgI530e9NG6eJuGQboNOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752369; c=relaxed/simple;
	bh=N0iat9euPSfI1ozrhTkUFwtonZRHs7P7+pN8pw5Lenk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NpFx/SHFvUFX422Y4C3M6oj84s6OBGBbxgsue/9E+svrDAw2IUlJGpZjltyGhYXKN/pJFQVa8lUeb9zqfTIPakRP16d/yqeeLV/TviFNtkY9Fci0uiKfbItrQlLv5pVj+MdEKkY6Jywjj0vzhBaqjtCa0H5AHV6TaDuiRkibSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU7UCUoe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU7UCUoe"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so1981217b3a.1
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780752367; x=1781357167; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gt51o7gJucZDYngX+zezYd8oMcYGRKCaBEJDS7EqeeU=;
        b=TU7UCUoeWOx5ZzCIDwRai/fNwMPV5c+ll7NDb40OmJpEvgS0zXGhDHqXloSTC0mrxM
         3Yu3kDtdWVJR/Gg/FQaHDhD80OQToJw2aGxVMNsiipFdR3gHPJfD9SJqCitiHFnbOxgh
         P83678qxlxOEt/k4j6cQ439j3JIX4H8ijXLnRxNAT/uWWTUO4WYRvEGlEiVTjyMa535c
         vKs9vn8M+GSNbcCiFl8elYPx27Th5grz2R2py9VldwOlOBPMF9WAetUbAgKHe+yuYJUB
         YPVrbO99AnsRg4oS4jc8wEVMfG4L+Q0bBykVakMY35PtO2EyrfOBCcM1hKIwBMtKL57v
         EipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780752367; x=1781357167;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt51o7gJucZDYngX+zezYd8oMcYGRKCaBEJDS7EqeeU=;
        b=pzXKFYTKmOagkmn+OzwG3ryBfHFGXP3ppWjdO68dp3TXmOC84pS9Q5B4bmr4yP0jqH
         wXVQuznOkvsyBVD35fsGQSokqWKr9rUvU0pdicftXrOw5TfUM6exzU4qSExNNxCIcYz1
         MEJ5YNAN8pD6qfSj++4LxgvUPfbX01mh0IBWRxDmfCZjT+YWOfXOJl0zB6MBuRRLgz+B
         p9AxeEJI97ghDNib1xIom3ndWFPzE/tL0dOGChYyZNUzoGZMWek658jH5hFyR2/OJ4CX
         RY2lM0SB78PzRrLs8m1jhyAHJ4p/ddDkdDg9cNclzTL61inqCzxv+WHS6RXsqcx27NlP
         EmYw==
X-Forwarded-Encrypted: i=1; AFNElJ90KOOKDMYchePg/qY+6i9dG0zwad4E4Z8b/go9rsV/rleikshYaOIii7L4YrYfKzTyUmhzxg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMC9RQw0jNs0UrDcbFR8pucsCTjZA/TjzsuHsKbl1F8e4Fxh4
	nbQfnz4EgMPbskm6raahtzZjkSb/H3lIYwfcHVblgxXP6ujJ9FvJUYAlHvwJT74D
X-Gm-Gg: Acq92OHzo4HsGzl347Otene7dKdQHh5KWz7KR8IQYfVtReo7qdUHC1YYUMVg4xWTNYu
	BKFG+TJtvzEqtFsSMQ1A6YT3ksyMgkpGPWTkU1tuKuMtnyDkguPU9PfIenZ70hggg3CmM38fc46
	tW+eNtETCIFDTfj/BooFRh9SbgMJt1Do7qvXN4H3TNs4RLV8PqV+cIq9ufQDuF5OcjchxhxrJGp
	NyETJXK5iy/rPSfnxfdh53dYYPn71A6lnRGSwckWx0UNQJr99x0gO/RckIFNCRElroKZFwg+60+
	rnixSVjLyzPiH6pvgaxPtw4ex90vC/9KTpj13rvEAECTgF+YmSuxbcgI/iQGAOjgXD2ju/jKDi4
	ZaSDTGy9MKXb6yuJ8Kt1z3o50ctFNfyQtMmqT0D9rDICSkoFMxa0XlbKJgjY9Lsbtqxw5dCQy3G
	WIGzVu/g6iSAkVeXX+OjwaVnhw15r6ywUL4xo6
X-Received: by 2002:a05:6a00:2d96:b0:835:45bf:9660 with SMTP id d2e1a72fcca58-842b0ec1242mr8396268b3a.42.1780752367167;
        Sat, 06 Jun 2026 06:26:07 -0700 (PDT)
Received: from [127.0.1.1] ([223.122.38.120])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-842829188b9sm12910688b3a.59.2026.06.06.06.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 06:26:06 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/2] nvme-apple: Prevent tag collision across queues on
 Apple A11
Date: Sat, 06 Jun 2026 21:25:24 +0800
Message-Id: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqAMAwFryJZG2jrB/Eq4qK2UQOlii0iSO9uk
 LcamDcvJLqYEozVCxfdnPiIArquwO02boTshcEo0ysZnmJRzJjthu4I4X9gHpTuULvB+qUxTes
 JpCDuys9fn+ZSPlccjSltAAAA
X-Change-ID: 20260606-prevent-tag-collision-t8015-1c8adb3234de
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>, 
 Yuriy Havrylyuk <yhavry@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=N0iat9euPSfI1ozrhTkUFwtonZRHs7P7+pN8pw5Lenk=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBqJB/qkvWEJiDJdwuAwbXwF80g9Gz+3xtXU5NzS
 q5demgubFKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaiQf6gAKCRABygi3psUI
 JD/lD/9wdAdvVm893ZEs7t9U1NqvQU+m1R8joTO0MSFw3Gz/v9nkAmdgA3DJPgfPJeRAaH2pSln
 COt//d9nV78OoIV7Xd95emThXhNuWWzlZ8+RoipvZ39pCQH18BkE+/k4sH4OmnUfAc9Xn78sXEo
 RXEWIGapLa03efOgvdLSRlWKk9+JM96Ztx1a3uBM0ZLkaan8f6JiWfRyUotgH8FTHZIuYpDwe6T
 +0nx7r7otrfEDHJpCQgO1TsiDHdHGBztPs/DUkSFctKbn3cEBS1jEHBFeKVRlHRVy6xJQIMjZTk
 MDyYGyNKRBKQwygmHU3uVAoxEBu/Di2evar+aLhdUmDMUm9wMaWlKx2ogMsWoX4acncB3xBqCu9
 o/FGp5CAbrb4cXvYj8OahtZeHOFeRbJTsCu1K8GpNRtxwWaYufaTIOkW6dqb5H8CsUrEO1d5p/X
 Xq0XLnqCM5wQJ+CKsUSJ8moOat1zsuhE9NbxGcJNMM8wBUc0GqSLJdhUqZtp/dkHhw/VDSaEwXP
 z5hn2oPSt3ej2qov2bl6Ex2DZvnZGQ+XiTvXiEpmPrerMrp0qsDNNw2QtBqPsEUIJT2PsXtTOtl
 kfRVFEgnIK4Fl6vCImpzDD/YFhJGTnvAMttZJskctGg0/828A1mEjxc15PobAOXVCDT598oQRO2
 ujV8N80CPGZFGsQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Apple NVMe controllers require tags of pending commands to not be shared
across admin and IO queues.

If a pending command tag is duplicated across queues, the firmware
crashes with: "duplicate tag error for tag N", with N being the tag.

On Apple M1 or above, this is worked around by partitioning the tag
space between the admin and IO queue.

However, on Apple A11 without linear SQ, it is not possible for either
queue to skip over some tags and must go from 0 to the configured maximum
before wrapping around.

Instead of partitioning the tag space, which is not possible without
linear SQ, prevent tag collisions by keeping track of which tags are
currently in-flight across either queues, and return BLK_STS_RESOURCE to
temporaily block command submission when a collision would have occured.

While fixing the issue, it became apparent the admin queue tag space
is limited even on Apple A11. There is no reason to do this as it hampers
performance and does not help preventing tag collisions, so also allow
the admin queue to use the full tag space.

Tested on iPhone 8, iPhone X and Macbook Pro (14-inch, M1 Pro, 2021).

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Nick Chan (1):
      nvme-apple: Only limit admin queue tag space when with Linear SQ is present

Yuriy Havrylyuk (1):
      nvme-apple: Prevent tag collision across queues even if tag space is shared

 drivers/nvme/host/apple.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)
---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260606-prevent-tag-collision-t8015-1c8adb3234de

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

