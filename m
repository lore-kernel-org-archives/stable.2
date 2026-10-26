Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011859;
	b=x6GGXkg6D9NBg0OUlVHsd7hcYMQHtSrOqlDT8Lujml+ISa5gICPxWG7pxpFuUAgSKXyL
	 uM9wKiNZtbvpDt7WPeNp0vtWPJ15KfCzxdtBQevugn9bscF45yIPVAp5jCVlMVZZ6zO4t
	 S/dAYVuaoWVnX9RUOFmNeV5X+Qkltkq4z7iRyb7qoSJb8vtPzTmLHdEVaaJo/e8kHP985
	 DWhfXOLzfn8RuCL/GeDkqZVQSr+zyeMBZvzNnutXkZVRAUi5KyE5plPbO0ywlvtKtC3TB
	 Zh6tJA+UTaO/c4GnJsVLrIkMo6cV08ylYH4BY4wcf0MhHhObn1GK0QMulzndau4loCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=io9R/T28rLxuixHyPNzGTDg5gzAwHn6Z3f+jZaKGnbg=;
	b=EqhjAtXhliKLewnJh7frw+pxIMK4lGSaeTlT38BAlK6tnJR5k2QTuXmZOLMk4qLNRm6T
	 lYc9GGq7SNN2J7sxIs6LBMIE9PN/ZFMY2Mm0ySEtEmrEt3OllqeYLeHiZrZ43/OVZYrj2
	 ZyMaeA5zzv1/JVkkxVy7DrLMX7okP9p9gh/cmvZdbylU/iLjQ6Dy5WXl/qTGrzCE3TOJP
	 j6yuo3DMviaizoWaM6Fx5TGsTv+2ry2fnZDZF9SmKBmzZZst1qWmMQT7WKQEtnz7Z4fRZ
	 sNl9pbwb4vYHOf3gY29fkdcnpLEDD/f8URkck8X6FWDrmf5G46FmfwXmxnOwoY9eCng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qdsfYTuN;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43F606A33F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A43F606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qdsfYTuN
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-14fc585291cso1224465c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011858; x=1793616658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=io9R/T28rLxuixHyPNzGTDg5gzAwHn6Z3f+jZaKGnbg=;
        b=qdsfYTuNVXaSoZFC+xuqtBgzf7JsipLUfpCI8/A3IvgWPe04Q5JdgSNszJtTypor1A
         fEjXmOnj0I5sCkZS6QeNfXGsy9dR5dWjEc9/vkL2/hauyN4tRhupYw2uBkaJDStkaCwL
         RCrMmRzEa8jj+k4JlelRucf+SBniB0xKiQKtXgzOgfRoJSYHh2TBe0fp0wkLDSRVIGYR
         HXWaQaUldWt52Rs2jk6WvXUSR7FOf6bhLB109yxyDmIQl+uL7fGRyM0WqlTw0uYNR1j7
         6m7yXMSI1rTvyf6jgIe9p4dYx6IBTbyZw9H56iEeaoCa+K00JmAGodm7L6dU9kByzvtS
         DBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011858; x=1793616658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=io9R/T28rLxuixHyPNzGTDg5gzAwHn6Z3f+jZaKGnbg=;
        b=C1QxCYPwFNhNRu6OL/8USvUileBc0KqmX7eRsAe5or1I/xAKcWE2AwxNJy5Rrl18pf
         kjauVe6do/bmJZ/6dwJy9325ubGmUXn1yfBdUvO1S0LnxNdRx60tbgzFzesYAFgGSIz/
         z9GsYYcQcmI+Mv/L+3luNwJtZOlGwEkS3p1QtaltilT0PhQFfAWnDNpx0JtEjTUoMUhl
         OYH0wvKKM1jPvifalTDyz+lmffXlf3UOLrGmXACZBpO2aINa1gsEA3KT1WEpLOdASphn
         VNirztcZkzwQ3qwoYNCMpHr9k/03+HxKBvv2IuLR3v1TXQQgNVkXlOc5XnyST4tfikwd
         GUKw==
X-Forwarded-Encrypted: i=1; AKwUvBywFX7PHg7EU8miIYAA/PGePMw5LwAhqEUkoYOf582XZWmBVFEsTyfpzdjh3aiRFDGaOGolZnI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKn2WqIiz8JU2Ybw+Ow0JKAOp1isXwNJ4CrwbhQ41na01ACx9vT
	8yr0AwyigGAEIsPfetU1w3/PzIoNMMnt4QFPvWuV+7sO0YthU7vBen3c
X-Gm-Gg: AYBFou3Gbwx+A05ga+fDfFWLFckeCIoGFUAcu6ktTDY+22r/YaZKy2pi/NB+LrhjQnG
	VoKJwNfrRGo6HGFVGsN62Mh7U9ZuuCGy6Hp952JEogKDqDn05hhRKSNb4vg9cSZRbaD+NP4b/Uc
	yVST7WAQOfe0/ZPiwaezpljkSUdrJ9JDD5VIGpjtNYj3J9UHUTwj0kQtLZNbyYpUyZDehgWJ9Qc
	V0V+o8StAEYcFI0Oxgs5H7yaPFYHpzdK5gB+jSLmIVW+D9a33Ppy+kcGo5KLVd8xKO47XzD7HI9
	zRt1tDNU5M/D3N4VH1yV4UxC7NU5HEvoQpL2R3yIRuwv0Q92cV3MyrLmNDcXXXKttAn5LbgKag9
	WkFmPpXrePeIQ/AcnL7GD0ff/7muwznDZvRWvLh2MuLM3lRs4tlwtAtt6dqEEnwhAIaMEyEaWJT
	LgFtnEm3qu2OFi0iQOZlqOivoG35ed9Zrfl3e8gaZL0yYphhx274ND/jCT5klDiwjN/+9H/JrCq
	magrG5/XqNt5zaa1Rv/bZ+5Ep6hVZe+Qyvpz4OL6RYgu5SiOIQ6SjBSGE6c9hOk1QW9Xk/DSiLD
	DpqBKWVCS83rZdoBp8g=
X-Received: by 2002:a05:701b:428d:10b0:16a:f5cd:365 with SMTP id a92af1059eb24-199292eea46mr9977300c88.5.1793011858226;
        Mon, 26 Oct 2026 03:50:58 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm27897863c88.6.2026.10.26.03.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:50:57 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] f2fs: reject MAIN_AREA boundary underflow
Date: Mon, 26 Oct 2026 03:50:40 -0700
Message-Id: <20261026105042.1148554-3-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026105042.1148554-1-teel4res@gmail.com>
References: <20261026105042.1148554-1-teel4res@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sanity_check_area_boundary() computes

	main_end_blkaddr - segment0_blkaddr

as u64 when main_end_blkaddr < seg_end_blkaddr.  A crafted superblock
can make main_end_blkaddr smaller than segment0_blkaddr, so the
subtraction underflows and cpu_to_le32() truncates the result; the
function persists a wrapped segment_count (0xfffffffd in the
crafted image) and the next mount rejects the filesystem.  The
same path can also leave the error workqueue dereferencing freed
superblock state:

  BUG: KASAN: slab-use-after-free in f2fs_commit_super

Reject the underflowing geometry before the subtraction.

Fixes: fd694733d523 ("f2fs: cover large section in sanity check of super")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ea2d218..b90831e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4004,6 +4004,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		return true;
 	}
 
+	if (main_end_blkaddr < segment0_blkaddr) {
+		f2fs_info(sbi, "Wrong MAIN_AREA boundary, start(%u) end(%llu)",
+			  main_blkaddr, main_end_blkaddr);
+		return true;
+	}
+
 	if (main_end_blkaddr > seg_end_blkaddr) {
 		f2fs_info(sbi, "Wrong MAIN_AREA boundary, start(%u) end(%llu) block(%u)",
 			  main_blkaddr, seg_end_blkaddr,
-- 
2.34.1

