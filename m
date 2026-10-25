Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892286;
	b=S/aB3jnZWdkvSMDymIgFF+E3km+wAyMcSq+Zp2VeXNKsSGk0jaDeaBCahXYnkiqZThNn
	 EragC399gI+4mSeljH+KxW2oFIYA/lJeWktQQOQnU0sBW7TR03CgtWKCQPTuD3jz0s5V0
	 m8Z6c81ULwvJXbwsPJtFwLII/SqMz7JePBFdlCvDV1TfaZvSKI+6WzY+VgTZFXtduqbdg
	 J0XQRBzhsa6CjPPjupQ2Z2A+8a9GJTAc5ihXLFAqtjUUjTlGn35EoPow1XR3AwKKflmr4
	 t+IQRtva8AezkCf+pdGTCoYWOPjgycVGk0GO8X5dB/jBILFFh4Awp6zd+dAr5yXzaDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u8h1InsNpeC2AlWGNl5I9ntcUmNs0bzik5YkhmDqhCQ=;
	b=YbGi+fGxyJbMAj3WMJWmAzA8/JAMTszHuoROHvJ2Zyrrnkdk8zcbw/kbV9ofJ5xvMrr2
	 lSROQ0ZjbAotcQ5MHkQsT8SqG5t1tA5d3b/QwagOQ8E/ErzN5/BWXNPv1w2HAjQVXbfrt
	 W8XZDPgXF2oshbWyU5NkWEnhNKdUIgv5DH3bGWXbYChiyYrFrYbyzKo8xEMy8o8h+fkD2
	 Vphw6sljuL6+t9D53lFPLseYltSW7yiBt6ZlFEysjSNbXRgDxaAqc1YDaIa67mSI2d5YT
	 hI+ZYoS7bSIAVpyKWNLvb1UTWuDXHOwdn+Kq5nYTbV6gut9HoYFqKnGQpclHZwsUwQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sEGEkAsT;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF33606A31E
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF33606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sEGEkAsT
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36681e85e87so1426796eec.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792892284; x=1793497084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u8h1InsNpeC2AlWGNl5I9ntcUmNs0bzik5YkhmDqhCQ=;
        b=sEGEkAsTpgfmX82g11PV76q1y7ztdsbuImZnA2R0xNogWSBJjygohuxHaAvHrR5h4t
         MIjSvtpCEnNm7+2UUXIBZ+gmfNImcsjx1SEKy6y3PK18adPKmvvRmeJ9zllhdHjO+1/q
         njtdixJEtnfxjw1SdO+rSCevSSHExE0Q/TCKvrXXbBgsjYcAJGmDjrmU/totlJei9AV2
         NJydQzHgb16+Sman8eEjuNjMtMkqer46DIgBoMmbiRPBrVWiJ8flj7Q+EKdjAOAqOB73
         c9YDNartU+E6io5F3XtQR6ODJmWLZ0Nhe//6KM5ot91kyRbukwdAxh0u4okw7spJD2H1
         blfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792892284; x=1793497084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u8h1InsNpeC2AlWGNl5I9ntcUmNs0bzik5YkhmDqhCQ=;
        b=Ia0hDnNNH5Rbl55w2KssaLuu/9icwOJZCuCxqJDTUdgduse/dUCetXBC0jQPggjRgj
         HnQlJaBY2wRl0u6XhgIKvJVyu5x+ZVpdkIBFcGJQ0KTgmH/HIZ1CiAiDYBZ1HcARGZyC
         vFv2O7w8jeX2vdYsVec7Ij5RpPd1ZcGp4a8v5PdOvfoRyj1ad4kW8Hsz7s1okItc2Bgn
         4VhcRUCmOV5dEX46L3Q+hM1yeIKwSaCkeX7NeqGdn6Ek1MgaSALRPqfG4AbthRpmFs3G
         T6kcHnS5J+hRtguSHjeKuyKGk2h05VJKKKgZDjRd370NJLfUeawPsHeYrzhIY4fmz+u8
         e4eA==
X-Forwarded-Encrypted: i=1; AKwUvBycKtQ5kdRODjNFwQkHRh0uIikKWOTWPoNy+vUpJdGNar/irCUIGEk6f93CaIUSAOwvTf2YpRc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKF8Jh9/JydPYDT6aCIHMc/aIv10FJkEt+mWfZjY77NGTFgwK/Z
	RvATGPo0TVJr3hirSyCoq80OWu+6yW0aTCJaCy3WAxO/CC+3Jizt+Bd4tqm9NIWEY5I=
X-Gm-Gg: AYBFou34iYqcbEAWyPZIQ/pLh+y6K0UhAK8c9A9MIdz8CF4JatamwczNV5G+b0SP62I
	PeCweQws5X4Zqmev29BAmadT4BxnBLHWOcOMSn+2e+6pHRF3pAAelR9i4K2/VoLj1aCN7F+IALY
	1HOG+TeWngWn1LDcvtYiSqHu5y3qeXuVnGrHAJyhPG+V1fkciBR5YZjq0prI83CSJn8zzpKhQh6
	B6225JEQrLNDXxA2KlxKhdF6quSoFX/moSgXZCdPVE0nQ+3XPkQKDouHI8NXkZZdE79S/cX2TIS
	FKGePlzQimDVW7ybcgerqp0S4lxvt9rqSpQXFeuk+7XddzWKGLT9E1+CgUFEMiSk/lZCsbS64p8
	fHdcNd9zFGY4kDA6rdYtNVPWvBKrioMWArrNWg67nGHNNOOP8TK1iT5Z2rrSy2ROMeTj2NQrXkN
	vdnhNCCZfT6KD3Bkf7tKe2aEYRUraZM/kZg0ErkLQGFY4R73brxJDTRHFYOQiH+nmy/YLdcR6oS
	klGXUsz1+HelwW21PHFM6jSKvsaXsDMKaPb4RFiTJwrWMRXrgsDaE94L8j6XbCCEEAHXxxfdkQE
	6ngxL0bzCGpd6VNzIkoYTR8hzQ4nhXcfs2KaoJ4NDy67D6D9mtpeEROQaSg581N7vg==
X-Received: by 2002:a05:693c:820d:b0:366:bcf9:1807 with SMTP id 5a478bee46e88-369e84dd76amr5254349eec.36.1792892283556;
        Sat, 24 Oct 2026 18:38:03 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:dba3:be57:a674:a67f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8dbaa42sm13724329eec.21.2026.10.24.18.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 18:38:03 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v5 0/3] RDMA/srpt: fix the descriptor table checks and the context counters
Date: Sun, 25 Oct 2026 10:37:45 +0900
Message-ID: <20261025013748.3755639-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
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

The first two patches bound initiator supplied descriptor data, and the
third widens the counters that hold what the first one admits.

A 510 entry table fits in the default 8276 byte IU when the additional CDB
is empty, so the bound accepts it and the counters then have to hold it.
With only the bound, a conforming command carrying 256 or more descriptors
still wraps n_rw_ctx and leaks every context it allocated. With only the
wider counters, a command that sets ADDITIONAL CDB LENGTH to its maximum
still walks a descriptor table that runs past the receive buffer.

The first fix dates from the driver's merge and the other two from the
conversion to the generic RDMA READ/WRITE API, which is why they are split.

Changes since v4, all in 1/3 and all from Bart's review.

The span check now uses struct_size(idb, desc_list, nbufs) rather than an
open-coded sizeof and multiplication, and the size_t casts are gone. nbufs
is at most 510 by the time the span is computed, because the existing count
check runs first, so struct_size() cannot saturate.

nbufs == 0 is refused explicitly. Bart and Sashiko both pointed out that a
table_desc.len below one descriptor still got through while the v4 commit
message claimed otherwise, so the check is there now and the message
describes what the code does.

2/3 is new, and it has not been reviewed yet. While working out why
nbufs == 0 reaches ib_post_send() I read the rest of srpt_alloc_rw_ctxs()
and found that a descriptor length of zero is not checked either. It
reaches target_alloc_sgl(), which has no length check of its own, and ends
in sg_init_marker() indexing a zero entry table at nents - 1, which is
unsigned, so the write lands far outside any allocation. DIRECT requests
are affected as well as INDIRECT tables, so the check sits in the shared
loop, and the patch carries its own Fixes tag.

3/3 is unchanged and carries Bart's Reviewed-by.

Link: https://lore.kernel.org/linux-rdma/20261024162852.3528224-1-yhlee@isslab.korea.ac.kr

Yehyeong Lee (3):
  RDMA/srpt: bound the indirect descriptor table to the IU
  RDMA/srpt: reject zero-length buffer descriptors
  RDMA/srpt: widen the indirect RDMA context counters

 drivers/infiniband/ulp/srpt/ib_srpt.c | 21 ++++++++++++++++++++-
 drivers/infiniband/ulp/srpt/ib_srpt.h |  4 ++--
 2 files changed, 22 insertions(+), 3 deletions(-)


base-commit: 6fba331225f5040e93d0947d1027e9712238291f
-- 
2.43.0

