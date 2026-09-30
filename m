Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3C3D1CCA
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756396; cv=none; b=T6HOrbdMoQ+3VtDwBd7WjEhWh08ChAZ4N57UAxkkLIJwUrCLPv016uDINzTC1s36nuvYoPcPLP/Js2tJi1OjEiiR6ZZcw9d9kFfaIqTsxsR4nF3kvWE57Fap2dnM2xsbFsG8rSeBIR+Cf2f7sqtp7AjXtzXzHVStxAw9aPDz2S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756396; c=relaxed/simple;
	bh=pyQwwBfVun0BCNowwYL9j6bPPuuzNBChzVpGGKxs7L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5e6wlKdQ4PxG+B3k7IbF83VgOBSsrrMtqG4naxxJFnwaTt4xHX3vP2gRp6B38dpu/wK/lGSFJFvFq1jlQPAcYbxO2MwXNVHhGmCvLkVN7/6HNQYKEZC+3sSqX4EC1ou2dLxKt0uIv29aDqz4zvKai3GV26Vyuyt77/HVsugt+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7Yoia/h; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7Yoia/h"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-87c90648f99so3669436b3a.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756390; x=1791361190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bR7uVOXUr6QRqbg1xRwBDWrPVdNqeU/9itJyUh6Zs9Q=;
        b=s7Yoia/hUOvUHbESitGo8zSs8cnVeil4NVgkW8RoR80SMfOnw6r+t+Zc3OmZHEhmj9
         CvOPqNIHwfhAFSUcxOK1Ng0aLmN6/tqIrmOPz0d8q9oo+VBi7MCeqE82KxGuXinZsdia
         yx+lOHE6cH58iEzWsjb9ME37kTH8o/y+sfcohWXvH6a9C8W875VyLdJ8EswtCYx81KaW
         VZCtbd52vsc675jtK575NQK1n0p5kSEC3wdvKWlFP/NLSgipSv55IVaMPeQ/DzcPLDB6
         WuETDwETwqq7Mva5GPrnBM/DfsFJ6ftDIAkogB8sl9FjOLYxCauK0tXnkJQGpYOSRh3Z
         +6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756390; x=1791361190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bR7uVOXUr6QRqbg1xRwBDWrPVdNqeU/9itJyUh6Zs9Q=;
        b=Da+FbVlx74MzdyP1LReA34a6acN6NCvZRLm/w9lbFAqT5Zjiuy/x/UJ8Fh5naH7z8c
         Dw4qxY2RpXxTPWYWLu0veg4iwfkoUIV+Hxc7Av8pepwtKqgXJQrTsF1lpOL1i8uch5uQ
         HiLdNpeWX00Q/LHvgw6H12pKOq151IlXMGWtldBYHN9o6igc/ePabHfbe6woOCD4duLh
         yU/PeD7zc1wBjc8gBGUoOu/5Kxr7NcO9a4nfcAvQVO7U0pWq5ZMgm5gSB+6f0X7AG6m2
         X8TRunKvgHSxvooF5BatXUuLtN+GE64Rpb4DG2IGk1MRL+OxYDtE+wS14sQ9bRxTfJ5u
         HMzw==
X-Forwarded-Encrypted: i=1; AKwUvBwVWnMYN+fPL066Cw5yPIfVnu+fEunXWRNV8obbUz2ujeCNRMu3rW8zBlfZaOQumfwVUvPDgTY=@vger.kernel.org
X-Gm-Message-State: AFuF++mGkIDyPU8G2MnGm+8sF693bXt5zxyZGkkTmSjNmv9RH8a/CNL7
	BKyXGdQIIvYQwyL3Bs2noD5qqYa0BB5s0S2HV4p2mhVYqq2EhehvAMc8ALrdnIJd
X-Gm-Gg: AYBFou3JoYpZV+SC2MxXZZ7ZCfRYraGu4OPN/gwZMVK5oat3kkskB6e3uKaqRrkouK+
	MABe6uxaRaIbpvsH/ixSVyvGbTzigybtqg4wJMfg9FdgcHncTT7mIk+BNwQQ+9pJPJ+hmqd36gk
	rVTSuIs7V2r+K7lXmzb0+8Qwq64oYI97Vd9EnSNLTyB1/Mtn5uOxUccZs21glGGpozD6cg0dYJH
	AeHUuFU1qfQy4mfbK41GNmmh+Cd+T7RGKVMRglKOOsoANhoh/xkM6Rg8MWU3dobO2u24V7rHLpd
	VXBD3ZVzyynVULA+aFdM7sPN+dM6WVbFgVR4OEUyrZLyZWk59ldDQzHxXRT24GxUyRgRZYQlWx0
	8303od9inNAfapVZBId5Sokq585leU7Ay6GGfZ6m7CvJa48zLw2UhF+dVnOmfLnnFndvSYuOBTO
	1Xoo403zGUFk/JI5f6a5RBWn+r83/XlRcTIk8Wc9RoMzliF+9fuqT3zEzXNYJKlpl1zlB3pMKoD
	ROvtWADyykLkPWOSFnYM53fRkdm0DbyUpnSo3Cr8vZrLUhZhzCw+UAwnBLgnBqCHvZTA0I607B3
	zpYvewSYYw==
X-Received: by 2002:a05:6a20:2591:b0:3dd:dcc1:f830 with SMTP id adf61e73a8af0-3de9e8f8427mr742877637.61.1790756389926;
        Wed, 30 Sep 2026 01:19:49 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da126a49sm453319a12.7.2026.09.30.01.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:19:49 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 0/6] fs/qnx6: fix buffer head leaks, double free, and inode validation
Date: Wed, 30 Sep 2026 08:19:41 +0000
Message-ID: <20260930081947.511613-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses buffer head memory leaks, uninitialized pointer reads,
out-of-bounds array access, and superblock validation issues in the qnx6
filesystem driver.

All patches have been ported to the latest tip of mainline (551c722f4080)
and verified in QEMU KVM with CONFIG_KASAN=y and UBSAN enabled.

Changes in v5:
- 1/6: Restored commit description to accurately specify UBSAN
  shift-out-of-bounds reports at both shifts in qnx6_block_map() as
  requested by Matthias Goergens.
- 3/6: Used qs->sb_buf instead of sbi->sb_buf at label out: in
  qnx6_fill_super() to prevent reading uninitialized sbi when mounting
  mmi_fs images, fixing a general protection fault reported by Matthias.
- 4/6: Updated commit description to state that clearing sb_buf after
  brelse() is defensive cleanup.
- Collected Tested-by and Reviewed-by tags from Matthias Goergens.

Hui Peng (6):
  qnx6: validate di_filelevels in qnx6_iget() before accessing level
    pointers
  qnx6: release bh on error path in qnx6_block_map()
  qnx6: release bh on error path in qnx6_fill_super()
  qnx6: clear sb_buf after brelse in qnx6_mmi_fill_super()
  qnx6: abort mount on superblock magic mismatch when silent is set in
    qnx6_mmi_fill_super()
  qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()

 fs/qnx6/inode.c     | 18 +++++++++++++++---
 fs/qnx6/super_mmi.c |  7 ++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.47.3
