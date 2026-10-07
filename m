Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40017A2F6
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338341; cv=none; b=rY8ZBqtZ47Jy27Ne//yBxSFib10GIM2V5xH0EVZGnjngCQosI1GiFMsPcL9FnRDJsTpvuc29P85sTxLHNgJIQnv+aB469aMIf8QzbuptQnqk6GWck3dMtX90RVns12kWPMyRnxJSCcIKc3HIRaDvn3S/I0RqJ8jrXoWAeXSwyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338341; c=relaxed/simple;
	bh=tIf7W/nmwCnVM6ETQa2lhEAO1QAfidKAfvPq+tKiN6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4z0SPKHPj5pAeiHVO0KzGAsrtAcPUWuUjL9LoOSaT7MZcW0pm3QCr+QBK5nTS0MxruilUKa0WrUvd7FUzdIL+uHSi25XcAkXcoxCY8NhPWNpTNmZIUGErKHMWd6xK60HyPS05i6mkMmNzOSnWx7RMEjx/C2Ru0KsUA7uzkqBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=TbL3ixa0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="TbL3ixa0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a4a7eb86a4so1068433a91.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 18:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791338339; x=1791943139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aape3rD0A/9PXmNWnZ4pikvp5foPOWk9ZifQ2/EdnJE=;
        b=TbL3ixa0GOzssLiUDsuHM1KjWVWWfVdn6LAZLkGPnuwofPv2+czg5p+QNterfzvTX9
         8Bxhv91I4ZLC7TPZKjjeH9dNjCWGztmu42WL3a6SBOkjpe4fRdTNMQzABe28WAmrh4g8
         +cUAvL3v5+ggYW1dO250k/o21NioXvT9QEaBWOPsgf3X1hYHvvym+VPUm+tSdhghSOA7
         VoXjQ7oh9REBKxEngS0Xbu64CYxU/sfMLu8EA9GVJnWJ3eM62m33zyw3LFQOPE8rFrZN
         ymF858rX3P/wTMHCmneo3+qw0X3I658VJuB7GlTkjI+cYklMvYNGV8a2AtiLMTtGa+VY
         LjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791338339; x=1791943139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aape3rD0A/9PXmNWnZ4pikvp5foPOWk9ZifQ2/EdnJE=;
        b=S2udMDH0/5tJnIvY+FrvjlhOrHwPSfBRhIvmhDVhQQhc+uOy8kML5Lj3xLCb5DyLqo
         8tvBohulPrjds7hVDGKjkSuhPIX7wVHmUT6Q7qKiqEUPDVghSk6eUyKNxNdgHdjXjNlK
         SzihHBxs3aosD8oW77QnUFHY3YDlXQLyC6Ab8ryp1olgmGn+aU27uvJRXLlmWGzctAhG
         TPFcrYxsxM0tXFNnR8YtdCMKLQYZZPxoCyhTaRqHHnJqgxhyTFB1/r4f8aASbV+fGoBb
         f5Yljaf3kbRVs2OrC4Fqos7Eqyn+zUNpgZRTaWW7UZjpLhI8wpZCQ9los6n5V4ckEmH9
         VO6g==
X-Forwarded-Encrypted: i=1; AKwUvBzdQrPiPzguqmAxpu7p/pbWKgDGzpqt0ZaadfATZNNfhq/h8ulJBHK4fm+c7kJqE8FnE8CcwZM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaqW7VQmVuy7dFL40ncQvhc5bLrqYSkyHqOS7gaF4IVwxkTk5e
	gEg9kRs7sU5f+cogVD8FNWglJAYtIC/sCq9YUkmfz9Dwfox4VKETBYT9lUbIo+k/LUg=
X-Gm-Gg: AYBFou0UGRXVa6Tp0YRJxZlu/6fRZNRzCUJBL9NA1ypFQ5jzr4+dEuF3Qdruu+CrfdV
	n+vhKF86qJi6cu2Z/bbcuXLlz+I21fs93jnEUv4J8qny6RcjXk1Shi1Ghc4qZeBI9IwdzcgAr+N
	xU6TqUgAh3Yu0jlttZjGeb28sggEhkx9rY4QGKHyBbHoDarsz3Ep0+WNM6Ra3oLtp9Ed5LNgclK
	GAqYy7C82HJ4Kh4rxQcpDlo6iub/8WiPFwvJf26I7TWPNjraFZskF8tGbsoRCHqLkvuSETHScw5
	y37pdusH13DmeqNA+mm94Venbgfl0m/zUR87SmfcMVP9f+8x6A64Io1Ohak67p0QL5xq7VQg3UM
	ru5BiCoztH276RbiPaxGO7vQl7JnFizvswV5taVPv3rs8VZut8ZN/a0N+LcVVYXSKkdp8ZyMoNU
	GJgTZkimFxmlnVFZzznOKyUlIfm/6ssEzD+HArUwA+/3eV9WXV3kIoj5juluwyT3crXlMEkeKEU
	UfvGw==
X-Received: by 2002:a17:90b:4a88:b0:39e:6a7e:ee1b with SMTP id 98e67ed59e1d1-3a8a1b057famr728367a91.39.1791338338188;
        Tue, 06 Oct 2026 18:58:58 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8543e8478sm8777205a91.17.2026.10.06.18.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:58:57 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: michael.christie@oracle.com,
	martin.petersen@oracle.com,
	lduncan@suse.com,
	cleech@redhat.com,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v3 0/3] scsi: libiscsi: validate task lookups driven by target-supplied ITTs
Date: Wed,  7 Oct 2026 10:58:39 +0900
Message-ID: <20261007015842.634893-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three places where an ITT taken from a target-supplied PDU reaches a task
without being checked. Each is reachable from the wire with one injected
PDU and each is independently useful, but they share one lookup helper so
they are sent together.

1/3 bounds the index from below. A transport that implements
parse_pdu_itt can produce a negative one; be2iscsi does, and forwards an
unsolicited NOP-In from the hardware with the target's ITT intact. I
have no be2iscsi hardware, so this one is argued from source.

2/3 is the ITT reflected in a Reject PDU.

3/3 is the same defect at the lookup that five management responses
share. An unsolicited NOP-In naming an unused index dereferences a NULL
task->conn; a Text Response with the same ITT crashes a little later in
iscsi_complete_task().

Measured on 7.2-rc5 with KASAN over a proxy that injects one PDU. Five
attack shapes oops or warn unpatched and none of them do with the
series. Normal I/O, an abort TMF, a rejected NOP-Out ping, a userspace
nop sent over netlink and an iscsid-driven session are unchanged.

v3: 2/3 - initialise task at its declaration per Mike Christie's review.
    No functional change: the .text of libiscsi.o is byte-identical
    before and after. Picked up Mike Christie's Reviewed-by on all three
    patches.
v2: https://lore.kernel.org/all/20260804040546.2264137-1-yhlee@isslab.korea.ac.kr/
v1: https://lore.kernel.org/all/20260803104149.2114414-1-yhlee@isslab.korea.ac.kr/

Yehyeong Lee (3):
  scsi: libiscsi: reject a negative task index from parse_pdu_itt
  scsi: libiscsi: validate the ITT reflected in a Reject PDU
  scsi: libiscsi: validate the task named by a management response

 drivers/scsi/libiscsi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.43.0

