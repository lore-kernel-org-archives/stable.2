Received: from mail-ed2-f26.google.com (mail-ed2-f26.google.com [74.125.228.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C7473C64
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249336; cv=none; b=ZN7PgzGYcndtxKXF3phJjCUcdZCCJu6AVoWVHn9zoCozAxew9s/NTCiv3ZXyLSpAEP7UD/mODvQ2CGbamK43uWNrkxlmbTo35VqflYE8pDplNfR6gNh2tWLfJZRCcs+aueBTEsjs9TMqLKlSs1oOmOmxy/t+6K+zZG1ued8wQd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249336; c=relaxed/simple;
	bh=9q+9njbl5fGDnCjt+CP+V3k7O4J5TEC5Hn04Vn4F3FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHXNu49ccGIGtM6tFsMHieMjMeRIZUVjym192iRO5D3zf5XnpBxuJUcUIscME2Z+/6gLfu3McVdJa1ZwR7BB2bMvua4Z3IIBDDQxBTHjM8rjGQFA1EPpUtNdpkNxVOZ0I5NOUeKn/Q/YjZ2b+ux9DcHE+FcZnHVxd9WPtrR6U8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f26.google.com with SMTP id 4fb4d7f45d1cf-6aa13e194easo3046747a12.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249329; x=1790854129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuSFDBweOP7pWzPIqUP/KjNZXgPolc/RJ9LLzLh1/A8=;
        b=QigDOEfBB1SPLyXO38LWpN9eJ/tflWb8w+59dA1v+8rzh+tYYDvsfj7zRnKPeMAMi9
         LM7oN4ZDrUZTZOnSa2Jvb0bSQnuiBBCEz5W8mQ/g3cKiS12G/+0jUcnneVBxVdJIlzlW
         /gxIXJNq/a5mfYdJy6+XI4bk08TnW9WrDYwTDOpCDnPou2/b/AKleYRogtLNWlAw9UtV
         1PCXxutkKZatu8CTLJtX0XUDpoywsVVM8D7KhUFlZOc1aIQDNXkAKFviZdyCV6y8eNpQ
         SsdZNGoJhkEYNHxoDJevdBn5XxdjziM1STPxCxeLGmHJc7iCaZ+RmugUyqx8RDjoNbkk
         07zg==
X-Forwarded-Encrypted: i=1; AKwUvBx8/kaDSsEzvuwLZamcFLGPqQSIh9/sf1nfGvwMVGAv01tuA/Mc5KupGAPOBbuHf1IhbS/P0i0=@vger.kernel.org
X-Gm-Message-State: AFuF++mQ38Ep854VkvkSgzX3Ipmboes12neCuAdFAqVuG3Z7NKjaCp9p
	WXZnGS6lWbENQnfz4j+in8hTYiGp+yaLb/EvJboh4Qsxqa6OS3Yv70Je
X-Gm-Gg: AYBFou2PZl77YmYgZGq7zJmkxWmB6Lob9JbwJ97lSAZF0cFivKJVUmybU00lIX1tmpT
	VwaFrbI5hBUZgLijWfnFeqRx7i3HZ1mfvwJ3p95QZvOHxSZYmER8DSy0kSh5+Qycio4nNHhcWlw
	uWjMyrSjHH7PiE7Cqek+/z7GKHu+wFiwm89rZe0vGBM4rBRYWOIJmTgtjzYZBEEXOLuWwi3lgVd
	FUMY8gDiPCUk5QcWuWDNIm9Tjs9QxaXCb9njSkPYh2atydDTax5ZtqY0R21ZB2OCPyIINn1xgvf
	UgQOvTws8jgEB9OwGPAKj1Ipg5Rojgh984yKgu6ufZ6AxZFmIz4ZtlpAWmgNk/NND8VGSzAE6//
	zqMzxhitLDIg2cYjgWbbIXp1TrQF38wVaf6bjlTZ2qEYjCuEsGnBLPWwXAnl1xZDNVlremxui17
	as19trbmQ8V/OZ1MGhDmgw3oxm0nebnOAFpB6e1H8WQYyhVH0vQNs09yS9x2rMa1Y6pskI/g==
X-Received: by 2002:a17:906:f597:b0:c29:448b:f5d0 with SMTP id a640c23a62f3a-c2ac25d513emr197041766b.33.1790249328602;
        Thu, 24 Sep 2026 04:28:48 -0700 (PDT)
Received: from white ([5.194.185.161])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2aae5c6022sm284374166b.14.2026.09.24.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:28:48 -0700 (PDT)
From: "Denis Efremov (Oracle)" <efremov@linux.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Denis Efremov (Oracle)" <efremov@linux.com>,
	stable@vger.kernel.org
Subject: [PATCH] floppy: return the drive state flags from the 32-bit FDGETDRVSTAT
Date: Thu, 24 Sep 2026 15:28:25 +0400
Message-ID: <20260924112825.3525931-1-efremov@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compat_getdrvstat() copies every field of the drive state to a 32-bit
caller except ->flags, which stays zero. 32-bit FDGETDRVSTAT and
FDPOLLDRVSTAT therefore never report FD_DISK_WRITABLE, FD_DISK_CHANGED
or FD_VERIFY: i386 fdutils (floppycontrol -P, fdmount), and other
32-bit users see every disk as write-protected and never see a disk
change. The compat code in block/compat_ioctl.c copied the field;
it was lost when that code moved into floppy.c

Also declare the field as compat_ulong_t: the 32-bit struct
floppy_drive_struct starts with an unsigned long, and a signed char at
offset 0 only lines up with its low byte on little-endian machines. The
size and offsets of the compat structure, and so FDGETDRVSTAT32, do not
change.

Cc: stable@vger.kernel.org
Fixes: 229b53c9bf4e ("take floppy compat ioctls to sodding floppy.c")
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---
 drivers/block/floppy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..569e8823dd3f 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3601,7 +3601,7 @@ struct compat_floppy_drive_params {
 };
 
 struct compat_floppy_drive_struct {
-	signed char	flags;
+	compat_ulong_t	flags;
 	compat_ulong_t	spinup_date;
 	compat_ulong_t	select_date;
 	compat_ulong_t	first_read_date;
@@ -3785,6 +3785,7 @@ static int compat_getdrvstat(int drive, bool poll,
 			goto Eintr;
 		process_fd_request();
 	}
+	v.flags = drive_state[drive].flags;
 	v.spinup_date = drive_state[drive].spinup_date;
 	v.select_date = drive_state[drive].select_date;
 	v.first_read_date = drive_state[drive].first_read_date;

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0

