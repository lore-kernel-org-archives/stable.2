Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9A35F165
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791691391; cv=none; b=XI6ZlS29mKDkdcyCUAQGzVlZ2FQJp23iP3R5aQfX7dPdHqZaXMptLgTQsEDFC8VeqhiRGi34FTwYH+OWBW/xCOQ1h8c5gyAofeO8E/af3sV/g8Qq4wbTalYe5TqGkPRRQYZnfc7NVInbU1mnGg6i/nbgI0NKql9EX3D8XpIOkBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791691391; c=relaxed/simple;
	bh=YNo0nmhZdFFI5JJxf4mNrEwSqwmWNHiOAPm3U4bNRSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XciiebFuGf9J6G7YdVNSAXRC9SsA6/3Rpm7ZhqtkAt9f9RGz9WDLfPbwyFH7KEX8oCO/waDZ7JMQiJxX/yLo9A5jNFPq9ux/UH5g0QmJ7+wednUSxbHUJgNXSJqnFxlUErcO3z+m/E+Yv4J37drTOyyhiVLUXll5wWx92puEg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=IbDYi2go; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="IbDYi2go"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso250245a12.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 21:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791691388; x=1792296188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SmESCEDSEEVGWRUbF5vPlQHQGJwVBn1FgqLmhtDMxpo=;
        b=IbDYi2gobZ5v/icpfbvLw7sPIiS63lJKbFcuQ/4ni05ge8U5DDuaFtesdvijKrCu9O
         gZOj2JNwyIQgqeYqdv/SnYqrVBNA/vcKFH3z7//JUH2iQCK3ZW0gQkiH0Uw0bUrZqNa/
         cl+Y2y/SwePcxGSdPjbw0iQs9u/LTkwSwuEjhjRafzqIHfXgUigDuRWVrzV0QMak2nuG
         1VFL9RJXTz1CknbMw2DH5uov3uY/CgQRTiDA5jCilZqJxGix/5ThBWjl2aTc63UNxGMr
         xhc2p05Cg8Md6I7lXk1qcUto9IXlq3KVIyxnHOi39O98frpgH3ULYURSGr8C19iHJQj+
         vItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791691388; x=1792296188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SmESCEDSEEVGWRUbF5vPlQHQGJwVBn1FgqLmhtDMxpo=;
        b=G2N6mOZv47M5p4HVT0zbR/KAu0VPz6pbw4LIjXLTsKvGKuE8cHi93ENDuuKMP0VIvq
         nUX4/NRgN7QWVeU5PpKCTAgVeGkDbdQpOSdAigVmUc+VHmtZOWUsqD3ULDZZ8bNBB0bO
         JmLwdpP7uuGfgVS5tOpRtth7MH4l5xPkr8gBmdrgLOxZL4lWlTuMezcXGkAkH0+qz9HX
         i+K/zmMC1Bvs7T/Nn8UK/ncvL9jjTQW4aoKFh4BP5H1ES+eXAHth9zyg+eAomTfgwaXo
         0gkXMQKRviXQXiTPefduyCrZHGFdNZ8nDenqcxV7iGPJN8BQAGshYYixpPwQmMUF3ZG6
         9YjA==
X-Forwarded-Encrypted: i=1; AKwUvBxi7jTjk4EGXhIqwlIiLDtIEkhK6qWZLvCI+A+o8gxKNr2zq1f7vHaGNIgWY3WZf4K5tPlkMsc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMF+euM7nNSeKvAKZFb7+4EyGdonAXbtw6qU7qxzjFL6jAE+Qv
	KixWL/IAE/5n4tAUrChjlG13s5+1ZiyAVP8G1EuNMkujeDZF9WSGfVhxQ7eNGbyRGOE=
X-Gm-Gg: AYBFou0Lnlg/vEP5YSz6rMbwX67VRBhsfKMwssfFCFDHgV48P5vF0b0jvG2/9KvF/7r
	tKMCJ74lGZ+gyFwp1/N2AMHlTP4RxyfIQiRz7CKh9oR4ZxSWr6DYuALzudc9VWHVma69tc/wUQn
	eioTLP3TJd1qAFskdjmCegZwtve6Y4JwufWX8pRhLbNmgxYGA5lwAmz8Ajo4lNxnPvZdZEV4dFk
	hqQ8ZsoWqbF06dqF+vtP/yzjohFjHNifSIIIGtrpF8pUDzgzCQD7xloOLdRGstB1R9Tj/DbEOwn
	aJ+pQS96EXsbJppb+fS2J+NJche2uFaAIrVqmsXE4df5U8SYf1NKK3rd3nVucRUJbNbDWGSp3RY
	Dj0FB+7bOAivgoEy5MzaKHFcXD3BmH4K8RKyNdTUFvsJYc0xrQ9xJY11bh8U9yBgMAE3RTGYJEi
	3uWlVuT1QmDYHxfaseXN8IV2VgvQKqzmix9N4W/YIQ5DIDoPwd2y1QbVr1PE9cWs4sNV6xLEnhq
	6c258JgYUexUYuJWG59Ag==
X-Received: by 2002:a17:90b:524f:b0:3a0:d265:3647 with SMTP id 98e67ed59e1d1-3ab3a35963emr4673675a91.8.1791691388502;
        Sat, 10 Oct 2026 21:03:08 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:9657:9541:a576:7d2f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38b981b9sm10519758a91.5.2026.10.10.21.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 21:03:08 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	linux-scsi@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH v2 0/2] scsi: qla4xxx: bound and correct the ISP83xx reset template
Date: Sun, 11 Oct 2026 13:02:55 +0900
Message-ID: <20261011040257.2017421-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 bounded the ISP83xx reset template read and walk. The review of that
patch raised two further problems, fixed here as a short series.

Patch 1 is the v1 fix with the template size and the per-entry geometry
read through le16_to_cpu() where the bounds are computed. On big-endian
v1 validated a byte-swapped size while the copy and the walk advanced by
the raw value, so the bound did not hold; the two now agree on both
endiannesses. No functional change on little-endian.

Patch 2 fixes the reset-sequence array cursor in
qla4_83xx_poll_read_list() that the same review noted. The cursor is
kept in a local and only written back when it reaches the end of the
array, so every read overwrites the same slot and a later
read-modify-write entry picks up a stale value. This is a correctness
fix; the index stays inside the array.

v1: https://lore.kernel.org/r/20261010181139.1911817-1-yhlee@isslab.korea.ac.kr

Yehyeong Lee (2):
  scsi: qla4xxx: bound the ISP83xx reset template to its buffer
  scsi: qla4xxx: advance the reset-sequence array cursor in
    poll_read_list

 drivers/scsi/qla4xxx/ql4_83xx.c | 117 ++++++++++++++++++++++++++------
 1 file changed, 95 insertions(+), 22 deletions(-)

-- 
2.43.0

