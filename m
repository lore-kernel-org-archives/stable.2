Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585030;
	b=rFiwciRJ0V9IfyAKgJpCZltvOO28avMGaKhZxlvCoskyIVssNbglqTqk5m0W1llpRR17
	 F24kIXEW9mogdKMFegFu2vmkUnmfpCnfeJmGXnE7uHv6Ao/2PccCP3epm4JSXF/8foX6r
	 BC6dTTUGQ+I9bL8rzISjmBOpSWKm/EFb5W3U4eE9uS/AonOnF1WLPnPgTagUNRuP750BF
	 g0Fl/K7nxxOFA+CyqZQfWXuQQcltUCycgtP7i2GbkjLz4U6qnMngri0R4sTqHYqioPXM/
	 fuHdnge5IPjTGdt49dM1ygSL/8oFPbcHlp9RgHP4Xyajwecw7LTipCpPv54mBHp5g9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:X-Mailer;
	bh=TosNnawzDPsGc04sRZxwMHLtTq8rVKPb8WELyOmoWoo=;
	b=k/IQcrux5pMgnYmOQqT8gN2rk8nPPAZh25fzBP8LU7ZoGXVkdb3+MMKyHiw18tOB8qje
	 7wV6/sYwPuKvdr9BdmBrZUuZkRKh5fu84WE8SJpvGp32nab+vZT5xIspzyh1x66QjY+mR
	 uj2ld6T5rtW6TsERK58zpqGHZaBf0wskXr/HNtFm0WS2OY1l7H4lRpSgqEaQ8njbn6Mut
	 qsBOuASVD8sxRS5hQSW2oAWdddV9xUV5zD4gM86NA8bX60uW/eQcg0hEF1jHxHyrmK3/d
	 r8b+fvUQvOl5Co3qOFYKqIq3WL7l26bF4QUBb42WJmxnrD8DtTLmO1H8av9i8EwQE3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PSv9GLFT;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94EE606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94EE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PSv9GLFT
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so4264573c88.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 18:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793585029; x=1794189829; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TosNnawzDPsGc04sRZxwMHLtTq8rVKPb8WELyOmoWoo=;
        b=PSv9GLFT1ZtVRmQvaE8bj+A3wyLLxPoH46yd2oRCfsYLUQy92TkfTZEla9NBNBdF+M
         1O7oze+DNm8E7cTg6oaK1GfS7cR7D/b8QHDX7b1wX8rhX33zYYuxAJtu84EcVQl3C1ST
         vSCFJ36v5dtGxqXF1ykGfOnZG9OYnWyZNfH1pXi1n37PIG0c9VMk2o6UD5zEJwilpvBm
         hgFcD23ZMau0EBGgCtmSEdUVsqbnr/sWyaaDYT+Jqz/fdCMPZswi7jE/JNfgwRYTvlA7
         ahy6bw3qHLCF2HCD8Og28vQkvRXCrBYFT41ptNBrfct2H+RBhOOignDfuFTbNG0q2Sza
         G0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793585029; x=1794189829;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TosNnawzDPsGc04sRZxwMHLtTq8rVKPb8WELyOmoWoo=;
        b=c8dxwKAxoZ11tFifhkZ/4Dn2ICpiMGVW89d6mlUe/vsqdAAFn9ldqbMo73u08VOC6U
         7qcFnYdaimUezdE1+7JbWsKqQLIMH3p6bYCr0R4Zkr4EPfGFAzXs34/VVwDVad8T5zTz
         RHO6tvD/eX2uvKz+foNtp/XlC44qCi6MrHN5U4Ec0RL68SeR0i6fIa6LA7bZ5/KxVAkM
         ZVo84e5k6lkxboSrojxLBLag1Fsn9iaNV/SIvqefuZHNQYlrcmEvIGZwgge+7AE01Vp0
         UTQveaMrSwnc2E0BuTewtwidRguNZql5AHJekCbRhhmRz5/4mUPS0TXs04lkGjrmgPYy
         KnKQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8AfZU7SLgfIBzoJDKLdKmYtwDncKi64C4HRNSxLAAXARPsYxjGTakRyYz2g+hI36bUqjXYwQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7x8UqS+lfkrvx5Efv110CUi0ic5NOJp/H8lRetP5i9GIshyDU
	4SW4JHirJYqlsByrHpWX9BMAKJ+53NVGOkLa7oG5cLzf/uLMWUDJqc43
X-Gm-Gg: AYBFou2Rg2C9XejGPoEGdI/dyZJugUgeOi8d3q66D2oZulbZM/Psej5LATyy/+CeuTI
	Y/YIsht0cDW2EzS5BF9ZpgiVVz6Fkk9h/8zSsva3NnuEZ3O59wKwMGrEn/QhwwQWTE4q4w+QNH5
	YfxdXv9CwJE50ucY8Fp9m9GxNK23KVRr9SyoAOMUR6xqNtyS7UxULygG5IIjxK5lulose7yavno
	OT18FNOSYxZj842Bjoc6RoQxZIpqNA1GfCQroTf6DVofikAKhaJD/H/Aq2HAJqPpIHGfP0gkTey
	rPQ6lC3Br4jZwuUEnowKh8CNI7Rip3FoN0IVcEJ5HKnI3Mn9UggEIgLnzH/Dfyvvvl5Mx69bJ9X
	zQM4r4x5V+1XZD20ojjexEX5TW6KO3y6Nezd13DuX9UbZam2B+sD0Ybn8h7jIlsNX+Nv/0CSaYg
	1xVL+jDA6UX895O+urckOHRXPaur0MzBYQDHuy0qQKJ9Y4dDKF98oojtY2UbWCqG00iM+ppnezY
	iWu6UjAVtOx/dzLt0gUjkBimxld+mCYtg8HIVDFiV5hezlG2kkdPyGBthqVYp2CPGo+6GNzOdLn
	HTQyfK0d7765gRL/gdldOoo+
X-Received: by 2002:a05:7022:1117:b0:195:49ee:94c7 with SMTP id a92af1059eb24-1ac5a0b579emr12094810c88.8.1793585028691;
        Sun, 01 Nov 2026 18:03:48 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm28456015c88.23.2026.11.01.18.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:03:48 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH RESEND v4 0/2] ext4: fix shrinker scan budget accounting,
 plus a related cleanup
Date: Sun, 01 Nov 2026 21:03:43 -0500
Message-Id: <20261101-fix-ext4-es-scan-nr-scanned-v4-0-1290a288f5ea@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, 
 Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>, 
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Zhang Yi <yi.zhang@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This reverts the v3 simplification of the ext4_es_scan() shrinker
scan-budget fix, keeping the unrelated locked_ei cleanup from v3.

Patch 1 keys SHRINK_STOP off nr_scanned (extents actually examined)
again instead of nr_shrunk (extents actually freed). Jan Kara pointed
out that a batch finding every extent still referenced and freeing
none of it is still real, useful aging progress, not "nothing left to
reclaim"; Sashiko AI review independently flagged the same issue.
This restores Jan Kara's v1 Reviewed-by: the diff in ext4_es_scan()
and __es_shrink() is unchanged from what he reviewed there (only the
explanatory comment reads differently).

Patch 2 is unchanged from v3: it removes __es_shrink()'s locked_ei
parameter, which Zhang Yi noted is dead since its sole caller always
passes NULL. It keeps Jan Kara's Reviewed-by from v3, which still
applies unchanged.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V3 -> V4:
- Revert the v3 simplification in patch 1: key SHRINK_STOP off
  nr_scanned (extents actually examined) again, not nr_shrunk
  (extents actually freed). Jan Kara rejected v3 on exactly this
  point; Sashiko AI review independently flagged the same issue.
  Restore Jan Kara's v1 Reviewed-by on patch 1, since the diff is
  unchanged from what he reviewed there. Patch 2 is untouched by
  this revert and keeps Jan Kara's Reviewed-by from v3.
- Re-measure patch 1's test data against the reverted fix
  (239 -> 1 calls with nr_scanned == 0, vs v3's 238 -> 1 with
  nr_shrunk == 0).

V2 -> V3:
- Drop the sc->nr_scanned computation entirely; just return
  SHRINK_STOP when __es_shrink() frees nothing (Zhang Yi, Sashiko AI
  review).
- Add patch 2/2: remove the now-dead locked_ei parameter (Zhang Yi).
- Add a Fixes: tag for the commit that split count_objects()/
  scan_objects() apart, and Cc: stable, matching the equivalent jbd2
  fix.
- Re-measure test data against the simplified fix (429 -> 238 calls).

V1 -> V2:
- Correct the comment and commit message: nr_scanned == 0 is not
  only reachable when sbi->s_es_list is genuinely empty, also when
  every inode walked was skipped or had nothing currently
  shrinkable. No code or test data changes.

v3: https://lore.kernel.org/r/20260930-fix-ext4-es-scan-nr-scanned-v3-0-9aef0be87d21@gmail.com
v2: https://lore.kernel.org/r/20260929-fix-ext4-es-scan-nr-scanned-v2-1-f4e8f6f6b8b1@gmail.com
v1: https://lore.kernel.org/r/20260928-fix-ext4-es-scan-nr-scanned-v1-1-91d88228b0c8@gmail.com

---
Qiliang Yuan (2):
      ext4: fix shrinker scan budget accounting in ext4_es_scan()
      ext4: remove unused locked_ei parameter from __es_shrink()

 fs/ext4/extents_status.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)
---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260928-fix-ext4-es-scan-nr-scanned-5af70744f6cd

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

