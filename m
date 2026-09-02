Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37B4A8A2D
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361184; cv=none; b=kNw3+ccC47a3jzq6SlW0uzvtXgidURhGBkge3SuCoNvcLSWu0T+HYNSshKSShNmdIX/kTrs2YhbBaB/gHSk/9VHe3LWL/IcIsjnrayGJmEGEHi6OKpvw+evbF/HXwvXUTpa8ngF2yU0xx0HRMVV/OWcUr2JaFziYPyFuFl7XCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361184; c=relaxed/simple;
	bh=3jk9MR+gg94VuaJqZwFitBFG7fXNnuN6p8vbOCicha4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYzF9UbLO51i/Eroiv/eptbJ2ynFZI6dLaSGhSkq81uZCZFqeFUf48u3AUT7QXWctUsuZrUF38N5pNEsuIKoUTX6MELz/SUYfYJHgK8T+6gTcCfAv7OEI/iD6OmUDLeo/9giO8fJEAKZ6pkC3rV9Yaxd3hRP1kxkiW9fi3mXqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJCIrPdx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJCIrPdx"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1109236a91.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788361174; x=1788965974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Yp/oXL3p1lajPvtDy021s7SwzqfNxCxh9EVSkIB80c=;
        b=IJCIrPdxknZ11SJzJi+ju2Nqy0YMekTG8G3jkW4E77GiEAtZz9e1ghPvI35RM1dlnP
         llVFTWxq/w7N3OgwYUgpIU/XuwT4aElFCe5GEVrDpwyqmW+VcChzcvgkRnKEWiiQF4bG
         hwOEWsdv1Uw9JpXy9CH5smxupcM+PqhOzJHkeigANQ1+RpaYr6VSeLPflStpapCGBs1K
         6+FdDpy4qWk5Qnmcx2YHc43d1WnZhQGGEWig7mh6gv3GCmQ6p04LsaOwzeZmkJXCwbU/
         eu8aZ7sQIxp6Fm6/fGD4B5JZj2PmmCRbxE5lecdWs0N4DalxmfW9saq2ASrsRrn9sN6p
         tW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361174; x=1788965974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Yp/oXL3p1lajPvtDy021s7SwzqfNxCxh9EVSkIB80c=;
        b=dPkNnmy0QXue/5k38Auslxuk8gvgjcKPHnhSjnCuAHqFbf7EdeE4c3S0bbzrI6g8qd
         bi0HDjmng9EM6kcf8Y1tM/Ekt19TsMDngOmC11b0qWWHxLd26vP0h/IqjhfcDeTH5HXf
         wsl2Ln2OymZyHYrDSPR7aQ8FtrHar7iozu0KbaHcxlvplbvYojopgrsQMH5oexixA8Rt
         SSKjzg1qGruCT0HHHdjgJFfDzTWMZ4UjOWzGZ5m8vodpm80DSKY8q8BcCu7rTMWr2RrO
         G66CUZzCZsuuRkiJu6WlEo13GbOvgacKa6HVsHthLDK318C3lKRNQnbcsyh0UIWY+V36
         qX5Q==
X-Forwarded-Encrypted: i=1; AKwUvBw6KnbDPSZpqt6DEjQ7GRaDw/SUAZGS4iMNTe/1QHkxVGU+lGe2oILK5RJsG+4Lcj1sVSlzPSY=@vger.kernel.org
X-Gm-Message-State: AFuF++mpMjMztILSnwyjBPVCBF9feY7ideJkB35TP+fH0ErPWfHQYbQQ
	xLAYpDgRPnvtYJZjiQfuL5wvGHYNCt2jQdpM24CsEYbMUl2ntDUaOcpD
X-Gm-Gg: AYBFou2F+rL4on7Fd2UOj39t563HI8jFAjeVjeQqcWaSwtWvPF8EWDn9A0kFdxpmYjs
	Zjwxj7kJ2BHJSLluEZvz4Mpc1rpM5smdPJBXpK2Pn790lRJF7gOFJMW7eED/+J/ciZi03fFBiKL
	OKFbwQKjqqx8qKM5YU+31EkgSv9iJdTJ05b8CQygQ3fmoYGUhU8N2llO0dj6mRUzexsqnoLY+Ht
	od9qTR60LvV+d3GfTONoYTQf/J+f0CFuKWblfpv3fOku07odhGNjrz1ZWRVhay98UaLBVm3Secg
	EPphTDUGpH9+0yRVFSYZHY0mKYNsZJGgIEnEHqIZMTIOtwO3nGqkQdQLjtANTgSQdNhtv0vVBdg
	KaWKDCSmNjnDXG/hgZ51rZg+VFbUSb2i9tVmdT+yGoAoIvWdlKWc38yv1iMIMS+ysL7lbsCh254
	KCDgNHbjWzB5kGQphL1x4G592p64/nknqF73AcuDwbQzIl3B75MRnv9AAraFZ4giI=
X-Received: by 2002:a17:90a:d44e:b0:398:ceed:6d44 with SMTP id 98e67ed59e1d1-39aee1bdb29mr8533173a91.25.1788361173832;
        Wed, 02 Sep 2026 07:59:33 -0700 (PDT)
Received: from adriano ([186.41.178.203])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07bd6777sm7534895eec.25.2026.09.02.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:59:33 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: johan@kernel.org
Cc: elder@kernel.org,
	gregkh@linuxfoundation.org,
	greybus-dev@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	stable@vger.kernel.org,
	syzbot+2fd6aefc361af86911d5@syzkaller.appspotmail.com
Subject: [PATCH v2] greybus: operation: fix out-of-bounds write in message allocation
Date: Wed,  2 Sep 2026 10:59:16 -0400
Message-ID: <20260902145916.63052-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The incoming message size from the device header (header.size) is
trusted without checking that it is at least the size of the message
header itself, but a value smaller than sizeof(struct gb_operation_msg_hdr)
underflows request_size in gb_operation_create_incoming(), wraps around
in gb_operation_message_alloc(), and results in a tiny buffer that is
then written past its end in gb_operation_message_init().

Reject undersized messages before parsing the message header.

Fixes: 87d208feb74f ("greybus: embed message buffer into message structure")
Reported-by: syzbot+2fd6aefc361af86911d5@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=2fd6aefc361af86911d5
Cc: stable@vger.kernel.org
Assisted-by: opencode:deepseek v4 pro
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
v2: point the Fixes tag at the proper commit (87d208feb74f), and add an
    Assisted-by tag.
 drivers/greybus/operation.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 7e12ffb2dd..df6daee4fb 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -1047,6 +1047,14 @@ void gb_connection_recv(struct gb_connection *connection,
 	/* Use memcpy as data may be unaligned */
 	memcpy(&header, data, sizeof(header));
 	msg_size = le16_to_cpu(header.size);
+	if (msg_size < sizeof(header)) {
+		dev_err_ratelimited(dev,
+				    "%s: malformed message 0x%04x of type 0x%02x received (%zu < %zu)\n",
+				    connection->name,
+				    le16_to_cpu(header.operation_id),
+				    header.type, msg_size, sizeof(header));
+		return;
+	}
 	if (size < msg_size) {
 		dev_err_ratelimited(dev,
 				    "%s: incomplete message 0x%04x of type 0x%02x received (%zu < %zu)\n",
-- 
2.51.0

