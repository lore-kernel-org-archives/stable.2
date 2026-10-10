Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E8373BEC
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609097; cv=none; b=pWS8Yb86anX9AS7HPp2tgna83IRlmYV0bvQKoUJKJ+18Z+awSX5vBGMVk1stINywKMsuEmNNGCRD49Poa99UpQnyYBHJb/rB5r/Ko+z9/xDq9cmJ06A8b/jdfnqFA9SJoGBfGTM+SillR+DEnDz8KTzC6KpEtiPmU7NpaX7Fx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609097; c=relaxed/simple;
	bh=MPMOwI0vvc3InXLYmyscm1qhTxNxhoj3Og1mIRJVW3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaNvhxeX1QyRcISIaf2dKnEoKq1J92HUA+zXBOjyeMZylHWCP6rL1j89scYH+1JSdzzNZ6q09k00Z9oaHdcIU1+Zdish7T+yQHK/o92x6UIPGvHlO5UlU9aj7AqzOYL8jk0qAVblF8dF/8BykTW/OgkQkN9OYDY1MS5BwuCTmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=MIrQUGQm; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="MIrQUGQm"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-141395927feso577758c88.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 22:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791609095; x=1792213895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EPzUTBNIsG1vnWSfHU0KClPEm42wHLDDcUKF5FSqaVc=;
        b=MIrQUGQmn1voPhPxsYHh+FVhHCvL6u0DNJWUTSgGPauArowvGdvRDvnc8ZLjFMccUb
         amFixag0+zpNQQraVOq0msl0A34p8yTvF0lgNk60eO8d8rrsFQO9lNDyBOuIRFtgxQ5p
         VDh07T4dNosr4ajAGtU86HjCiPdzlrGhwKZFlN0mpa5sjqos6kG05YgZmk1pqpTWwNSH
         L6HEEIOOfNVQczTkpPjOOwMcbj+4amxlULNAcBGMD560wLKECi1RAWD6gZgnLtiVFY2D
         iS+qRoNf39Uzi7yQWRqaquVN2+JOlwCiKDGGJTTYKkI0lWvYN/9Fg0rgAwSQxb3m1/Vh
         gkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791609095; x=1792213895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EPzUTBNIsG1vnWSfHU0KClPEm42wHLDDcUKF5FSqaVc=;
        b=FtQAS4KF6sJ3UXQ5v+fFH6qoTPAYMxR/Y4zC467VfJGm7zXz8ov+1+nR/qRWDDPyZT
         mP6ypWpJTdDaYDVP47GKqPYPMnnnQugOylPTG8mQoQYKT7feq3TfbO9+lr3oAjbmvRos
         s+rEmDSLLbLTFL6SDef3Ko+Xz2VkBSfmJn2IkzF1GZSFdcXnLBWwoq9hc9nXAwxQ4zHe
         +gTXp6Qz4BWR7R0TpfXG4GCanMB+IBE099neBA6yIakdwSRQHKuNlJho9ieXtJcwxbnz
         IbRXgM+AQrIsmwhOyNeLAckQkpUz9SmYz7qa5xzXlf5f0Yy08mLo5Of5tF/f2trzDOB0
         ifYw==
X-Gm-Message-State: AFq9FYJ7RW05Zwxzoie4Ya+aJQbLVNuB00CwlpzFHFsNiSUvxuRDaf0S
	wjSkZPuKDT96INsQQhTbxL+Ht3KkBQqWMZLjTsnrqNHsn6GTn9e5/KpsO5SkuUQS9hXubq13xXV
	zxV8ZXvPKYw==
X-Gm-Gg: AYBFou0/Qc7vvsCefxfY2dgQsP3GOsL1Ezi5avnU75/4oPX3L53CeTMI2Q7hU4yd8ze
	pugDxGAeUMYiWZm0OrWCW4dX2EQxvZPwkwR4PhPLzt/zlDuX0dG4mns0I5Dki5JypPD6rhjoKcw
	IMhNRgX8uryuAP9arM+ZQnDYa7FQlcIHi5y3zyy+EfWzT19zcx1b3uJbAY/za5/eOlLBWhgzfYe
	XLNeLINkeGikRkSyeXFZX/TQ6wwHo9Ft0TwIUPllMNauu93r3+mGQk3hahBw43scULM4DCGHLc2
	Y+sko6HtJWKjBvUe1zSuprKx+H/jiHQmtZhRAd0X8xlVXlj5kNXti7hLG4a0Zb6Ysbp76+mgOQW
	EnblISfeVvcG2jEFjlrQkLiL0r7J+9Ul7JoUq2o60mSiq66MGzcB077b7nFWTrlWHDftoUIpfHk
	MgrRid5I4ZMeu/h7LfiikTypvCanCEFLKi3h8Ssr/MWJz/T7bOhnrma70IJ0PlOXxWU6tKEJiDf
	JCLOlsa8DgZsh95xEcS6Bykp6xb9/bprNE7R/5BFEHyvHf8U3mSAlaN9xZPa+EYJaDdLjQ=
X-Received: by 2002:a05:7022:7f0b:b0:14f:4b01:40a1 with SMTP id a92af1059eb24-16a4f627a7cmr5226042c88.0.1791609094685;
        Fri, 09 Oct 2026 22:11:34 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:fc0d:3183:3e45:a830])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becf08sm11181963c88.5.2026.10.09.22.11.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 22:11:34 -0700 (PDT)
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
Subject: [PATCH 6.12.y] wifi: ath12k: fix reusing m3 memory
Date: Sat, 10 Oct 2026 01:11:29 -0400
Message-ID: <20261010051129.14918-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

[ Upstream commit 00575bb44b2c2aa53d0a768de2b80c9c1af0174d ]

During firmware recovery or suspend/resume, m3 memory could be reused if
the size of the new m3 binary is equal to or less than that of the
existing memory. There will be issues for the latter case, since
m3_mem->size will be updated with a smaller value and this value is
eventually used in the free path, where the original total size should be
used instead.

To fix it, add a new member in m3_mem_region structure to track the original
memory size and use it in free path.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

[ Backport to 6.12.y: drop the copyright-line hunks, which do not apply
  to 6.12.y. The code changes are the same as upstream. ]

Fixes: 05090ae82f44 ("wifi: ath12k: check M3 buffer size as well whey trying to reuse it")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20251029-ath12k-fix-m3-reuse-v1-1-69225bacfc5d@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and ath12k maintainers,

Please queue this for 6.12.y.

6.12.y has the bug this fixes. When a smaller M3 image is loaded into a
reused buffer, m3_mem->size shrinks to the new image length, and that
length is later passed to dma_free_coherent() instead of the size that
was allocated. The patch also fixes the allocation-failure message, which
reads fw->size even though fw is NULL when the M3 image comes from
firmware-N.bin.

The fix is already in 6.18.y and 7.2.y.

Testing: applies to v6.12.112 and on top of the current 6.12 stable
queue. An x86_64 allmodconfig build with CONFIG_WERROR=y is clean, and
ath12k also builds cleanly with W=1. I tested the M3 load and free
functions in userspace with firmware and DMA stubs under ASan/UBSan. I
did not test on ath12k hardware.

An LLM helped prepare, build, and test this backport. I reviewed the
results.

Thanks,
Artem Dinaburg

 drivers/net/wireless/ath/ath12k/qmi.c | 9 ++++++---
 drivers/net/wireless/ath/ath12k/qmi.h | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index b93ce9f87f61..5b02d1d76a36 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2724,9 +2724,10 @@ static void ath12k_qmi_m3_free(struct ath12k_base *ab)
 	if (!m3_mem->vaddr)
 		return;
 
-	dma_free_coherent(ab->dev, m3_mem->size,
+	dma_free_coherent(ab->dev, m3_mem->total_size,
 			  m3_mem->vaddr, m3_mem->paddr);
 	m3_mem->vaddr = NULL;
+	m3_mem->total_size = 0;
 	m3_mem->size = 0;
 }
 
@@ -2762,7 +2763,7 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 
 	/* In recovery/resume cases, M3 buffer is not freed, try to reuse that */
 	if (m3_mem->vaddr) {
-		if (m3_mem->size >= m3_len)
+		if (m3_mem->total_size >= m3_len)
 			goto skip_m3_alloc;
 
 		/* Old buffer is too small, free and reallocate */
@@ -2774,11 +2775,13 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 					   GFP_KERNEL);
 	if (!m3_mem->vaddr) {
 		ath12k_err(ab, "failed to allocate memory for M3 with size %zu\n",
-			   fw->size);
+			   m3_len);
 		ret = -ENOMEM;
 		goto out;
 	}
 
+	m3_mem->total_size = m3_len;
+
 skip_m3_alloc:
 	memcpy(m3_mem->vaddr, m3_data, m3_len);
 	m3_mem->size = m3_len;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 0dfcbd8cb59b..e9eb186441cc 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -118,6 +118,9 @@ struct target_info {
 };
 
 struct m3_mem_region {
+	/* total memory allocated */
+	u32 total_size;
+	/* actual memory being used */
 	u32 size;
 	dma_addr_t paddr;
 	void *vaddr;
