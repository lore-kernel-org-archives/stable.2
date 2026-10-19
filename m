Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0846F4A4
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395934; cv=none; b=szFyKQo7G+Z4el0siorzcNsD9K6Sb/gOL8k2C/Qyn6ORPmWQJXsTkofq2DZ10pUEeXvqcQAJVqk+T21CdAOUKZcQ0Lz5/htd2LIDMb5Wwmm8dKHv4Rk67nO7P/YLk1gFutWju4je7oMOtF5Xu5YW2J1AT/4kvjz7fhvQKdg0AY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395934; c=relaxed/simple;
	bh=YlRidHLZxLVQQkYv/73Bcq/10xLHfZWapZAMD6FOpb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4gbc9dhTDeVimvk4a1CSp8MQ2lkFxLLdOvfwvImFImbzSpJEm/dFK+g0T/orHXwHEisKQgxbCoD+Ka71Pr74iCBkpi8LSXLjyzH/QWc9RH1Q7HMmQZFSBeBdKJyurMq7F3+VX7Xr5puxC54tuMAW4mGJ5lhRaRvn3NSHTXMccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=iH0soMx/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="iH0soMx/"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-89d6bd67045so694195b3a.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792395933; x=1793000733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ul6H+GadvFiEjmBn8Klfdhq6vLjdD2yBpTer/wEL68=;
        b=iH0soMx/+nd1CSKDU8UbkKXG/CZ0rFXiKN+7v7S+WRPxAIMZILwsU9XtsJrAwL6Osd
         SmW8wMSWYtC6OESx5Q2MGZsbkmaInWXrotddTXt+kME8U2w1rca3fYdiro8eG1zX4Ai7
         LviQTK4XqfXQL6ZPQoNxu4HDwqdsIBAgf9pnHA9Z9iE70GcTqkGDJhn8Ykvs92d0KHIr
         Dg0Uwkp2Ka73UNP8s2a1J+tOoTmTFI9vJLAmr/90kufjEVlBh6jL75w/AWnmHLuCOQ/K
         O0qqwhc+4SNzfMbKjqBYJY160DnFVnjzN2MxL4Jg+hayFs+4MmyF8d1N0+sbJp/H5iC4
         7K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395933; x=1793000733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ul6H+GadvFiEjmBn8Klfdhq6vLjdD2yBpTer/wEL68=;
        b=lYOvslm6uSTw6lXNX44bkwVfrs/Pa7MZ5XZxZZkvTjgdrU3EpbuNguhi4jvPietJdB
         T22wjZmWLxaSQvGJKu9I1HG1oV4jUX6fHbQQGZOMUi9c68TDXFdpoEATFM+nBrUJp1Vp
         wDSZFcSU0DNZDfm5AWYuvRlHVDQrpr9AWoKNeeWQErB6nxFqcZqh7DDIbFxgMusw20yn
         6dkIlWfrxG9khO2umlrSNOYQqBw0JE88N/8rH0FnTbHcI8m+80TyoDvrF7UKu6MI2MbX
         G00AzxkLnkqu/cLdkXDy3rcXcbLIwe70+zjf1HAjDc2HIxn1J1zDG+DG8/awnficsCSd
         Vjkw==
X-Forwarded-Encrypted: i=1; AKwUvBz7i+huUM7cWvxfY2fHvJ114LpHmpm+2y1krMRDoWn19lO0XA+AMYBxD62V0FEAYO0xM85fTSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdtNZsC++BSI823X1S39s6J2QTxN6EZusw+Z840UwIeKohFeiW
	OCAizM4WAbEKRONoIvXoKRVJUB2E5gaORHBYoRmVi7RzCt7gUQD1gllOCV4H4C1Qx5ncuAw+wV0
	W2+iN
X-Gm-Gg: AYBFou3yk6Fs9bjs19lCypIrGCc2dbo+Ouz7ymVMi3rJvulxFToCGEJN0mgIxZSn9AH
	W7jabmSlIKPxJ+gldbOyYp/bAU2Aak/nx+LRGcEq77elBSMZvCoSsFNtn4nMn79XqWnWMf//3gC
	doaHzT8CnBSerE4Ka7QOGcb0wXqtxDlKZzp87GmnZhesDvJme7f0YSm+y55GVlJub4+lQqFvaM9
	wKK76N3XoECK78xgqVpNMdYJ265tCL1ta0AcobeOKyr8up95/AAnRlIR/wj1dCykbFvT6VGsXfI
	VB+m0FyzwnVA89h1iNf423pm2qrbmRtrrMXlBnH+hPT0uWZK8VcaGFFd0I4Dwf1Tkl5WmrfIFWa
	L/93LxXwfNBlDJ/iIZgEeuhiWu3nkKk/d7DharGOr8HDtFGfR1u9QU791IrbEo1JKN3hgqIf1PY
	Og8J7U+aAOQymrA2A7OSGI6qqHdl4UO6+J65w356sB1xECLSqe76UGn2JD3azPHvfz5cZEMI4wF
	UqfHQ==
X-Received: by 2002:a05:6a00:3d0a:b0:8a0:550f:bb43 with SMTP id d2e1a72fcca58-8a0550fbc34mr3271497b3a.34.1792395933010;
        Mon, 19 Oct 2026 00:45:33 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58017244sm3494351b3a.47.2026.10.19.00.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:45:32 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: njavali@marvell.com,
	mrangankar@marvell.com,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: yhlee@isslab.korea.ac.kr,
	GR-QLogic-Storage-Upstream@marvell.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] scsi: bnx2i: bound the payload lengths the chip reports
Date: Mon, 19 Oct 2026 16:45:19 +0900
Message-ID: <20261019074521.658170-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three handlers in bnx2i take a payload length out of a completion queue
entry and use it without comparing it against the buffer it is read from or
the one it is written to.  All three fields are u32 and none of them is
masked.

The first patch covers the receive queue path, where bnx2i_get_rq_buf()
copies out of a single BNX2I_RQ_WQE_SIZE entry and the Reject handler asks
it for as much as the chip claims.  The second covers the login and text
response handlers, which put a write pointer at resp_buf + length and then
pad from there.

What makes these look like oversights rather than a decision to trust the
chip is that bnx2i_process_scsi_cmd_resp() caps the same field against both
of the sizes involved, with a separate error message for each, and has done
so since the driver was added in 2009.

I have no NetXtreme II hardware, so patch 1 is backed by a KUnit harness
that drives the real copy helper with the RQ ring and conn->data swapped
for kmalloc() of the same sizes so that KASAN can see them, and patch 2
rests on the sizes in the source.  Neither patch changes what is delivered
for a payload that fits in the buffer it was given.

Yehyeong Lee (2):
  scsi: bnx2i: bound the RQ payload length reported by the chip
  scsi: bnx2i: bound the login and text response payload length

 drivers/scsi/bnx2i/bnx2i.h     |  2 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c | 29 ++++++++++++++++++++---------
 2 files changed, 21 insertions(+), 10 deletions(-)
