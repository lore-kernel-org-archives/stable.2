Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856744B2032
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824378; cv=none; b=NyEmmNeaHkHkBS/6SzziErESAiVQzVyjfgLq4ZY83Nv9EdaZS201WaX4iyA2OB64jCnOdGABD+xckdrr73vc+imv3CfJczY+YwSuJy2ZRvd2DzyXVzzvxSFGgi8HA0l5WZfel3DPSBWXjHvZ43WygyolAlZXTJnFzKY87WATTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824378; c=relaxed/simple;
	bh=EhH6IwlihPOZBtZ7fy6A6cdyCPV4x/BGcANAY0SO5AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8JMH8+pJX8b+kZqLjhrDW5qOj5EPPunOkcW4PM6tMH6lgdz2GrLuz2IfW1SnavjqX+B7GABO61O/zxxeKmHvBytX5meQg/zqUuEk6wfxMhxt93XLYIEQj8RkVXqfdPFCQD3ttmVPgEl7i2wDgKStsTq5mbXB7ug5gbNKcbJGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ddOrvwVj; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ddOrvwVj"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso289289eec.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791824372; x=1792429172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JSUpEqLrV0X2B9mHs8V/zQL6TPWRwBaZtNzo85tRy5c=;
        b=ddOrvwVjCkbY4sOeazhMYQtUoNKna6EPcbbavrnGxmyIq7d6ekYV5NjXRk38avRB7Z
         g2ywh05nXLFuDbOx3/If6pizkWwnFylwbTqgl2G0aTjujinZctlnrVxmNjfQNAYRsNmu
         6pXt4MDMUz0nQfBEcrRBPo+rJw0i18R+g8J/AWELTyxs1BDwLabaVBQk4yZZHoHFJv1c
         937U8NLPZ8xHfb5iDFVTjN3WlMl10ywpMu9UqGfTL4jH3dc/c6tNaQBjfT49rhMpyyxy
         FVd1jjAly95e2F58UEcCMnLiu6aZsJreN122A2E+y9Xwz2LCFUaFu3cr8Khvu0JpXwE4
         clKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824372; x=1792429172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JSUpEqLrV0X2B9mHs8V/zQL6TPWRwBaZtNzo85tRy5c=;
        b=UgtrgSldAzBMRP7h/yBzsuBDs+JwbDabWIi1O81x2bgsXDo2n14GvoEOf+lsNBmT9w
         Nbzs+wLRAO1D5Zq+5Sdw7Z+W0JLj9rreDYuD9ziKWVeluUtE/acf+OWUmxMyjheV0KVz
         L/Wo908bJVtDN6edtuULlb5l7fk6LQ6IgepE78t0oQcdLYd9dBi4OVL6WeRtVSyymP1/
         c5fiM/xx7uVUVpDElIan2cFVQtVFSq0J0jJk7cozvaXsdtPAeaK/LREbZYGsWQyAMfpB
         t5L8A0h3mjAPyLJt7k0mLZYAKH6OEQdsXZL1eCnz/aIl8ucllWYBB2ENzxf7z7bTerfC
         fOBg==
X-Gm-Message-State: AFq9FYICVxftqKPYxDMS9tv6XM6NF881ZLhNfA6MAcdaVFdyInn1VRCh
	Z/OkcN5LGxndmKTYIGhp3AAwwgWqerL0OqifMOHETpOSne37j4E132QPQDhXzWGFJXa5P7HL0d5
	by6l8IIOivA==
X-Gm-Gg: AYBFou0o2KueLk8gSMv+y3dYNIdo6yAHTBbwTrizPuQyMJJKmP9lrRWxtJ6xoS1G3tj
	yST9Eef6inorj0amxvGwWC6STw7/K19mt3FLrJ223j39aJHqHxFv++zA8xDqXITl8hxMKm3PK95
	TYdyxsFv1EHDlrGKvtve7CDgKaH6YQzYwqAx/qg+9hZP6ovjVvbMOC7UuTCuDyr2xesenVqeKtz
	H5bsPn0wTneXfcryJ6QEMZWVvBVuIA3v3hItRgdhgEWqLBlOFVwtzdiUw5KY4m0Ms/gLKM3LNXz
	MB/UIVTB4ZCzAQ6+4GR/5CSHcP0R01QwqWmgkx13UM1qQ/70HZhiJp8tVPGu8ey14M0OeR+1HNK
	wEw6gT12H18BxxWxdB/QrZ2PYr3j4Y1qn8Z5yetaeY15yNNg3SEcCCn/jP58LRvaUoKakLTNvCj
	v+rioYfbXe5SNPTS/FkU06EPLQ73vkN41Ta3T/sUy3cuCtofv8VnnhjDE3HZZO1hBLQopFftwJ7
	WOpy9qNK0N51gZSDgx1nreDykLSpqoPIslmCniKtQmZ3VtW1+BTgIc6UJILU/saveyDL/rfHZNY
X-Received: by 2002:a05:7301:77cc:b0:357:e9:dcea with SMTP id 5a478bee46e88-35700e9df2fmr11300677eec.15.1791824371897;
        Mon, 12 Oct 2026 09:59:31 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:1464:826f:d188:9e33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm34296900eec.28.2026.10.12.09.59.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 09:59:31 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] wifi: ath12k: copy M3 firmware when reusing the buffer
Date: Mon, 12 Oct 2026 12:59:25 -0400
Message-ID: <20261012165925.32575-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012165925.32575-1-artem@trailofbits.com>
References: <20261012165925.32575-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes my 6.6.y backport of upstream commit 05090ae82f44 ("wifi:
ath12k: check M3 buffer size as well whey trying to reuse it"). There is
no corresponding upstream commit, because upstream never had this bug.

When the existing M3 buffer is large enough for the new m3.bin, my
backport releases the firmware and returns early. The new image is never
copied, and m3_mem->size keeps the old length. Upstream instead jumps to
skip_m3_alloc, which copies the current image into the existing buffer
and records its length. As a result, after recovery or resume, 6.6.y
gives the firmware the previous M3 image whenever the new one is the
same size or smaller. A larger image is reallocated and loaded.

Replace the early return with the upstream goto skip_m3_alloc. The
previous patch, a backport of upstream commit 00575bb44b2c ("wifi:
ath12k: fix reusing m3 memory"), keeps the allocation size in
total_size. So copying a smaller image no longer changes the size passed
to dma_free_coherent().

Fixes: 9a38ba5561d9 ("wifi: ath12k: check M3 buffer size as well whey trying to reuse it")
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 86cc61dba094..8dc1c8e0c7b1 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2543,10 +2543,8 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 
 	/* In recovery/resume cases, M3 buffer is not freed, try to reuse that */
 	if (m3_mem->vaddr) {
-		if (m3_mem->total_size >= fw->size) {
-			release_firmware(fw);
-			return 0;
-		}
+		if (m3_mem->total_size >= fw->size)
+			goto skip_m3_alloc;
 
 		/* Old buffer is too small, free and reallocate */
 		ath12k_qmi_m3_free(ab);
@@ -2564,6 +2562,7 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 
 	m3_mem->total_size = fw->size;
 
+skip_m3_alloc:
 	memcpy(m3_mem->vaddr, fw->data, fw->size);
 	m3_mem->size = fw->size;
 	release_firmware(fw);
