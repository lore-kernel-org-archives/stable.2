Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E8339A4BA;
	Wed,  9 Sep 2026 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975080; cv=none; b=GI33hVN79rgeBisNnWbxmOC32DjFEiR/WECDkksgdutnQpqarGYvPaO4NMBSbHOD06kqS8I7kXn2l6Pd3nMMpLn0R+pRUK7mLp1imd7WtbYPeM3FiHcy6irSWTDA/EJUx6vNhiR3iHwxXb0thGk2EKmG/vnuTfuHVv3YBxVlxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975080; c=relaxed/simple;
	bh=FV/YC+T9nm5Na7ZqvbQxGFR0eRdllXK9yYLCGn2UK74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzmZUd/mI4q3Vmo8TxXUXeIuPDf2F78308eBg+fEv5Qb9CW+hEmewzjL40hc1/8UIK2HEoFlF0zfRSN8RWuBJNTCVCXogTFb2sMzzGOFzVcARGRxYTuKNqebBvNBm/xs54Zko8p+CaLRBczZ19uHfzej7XYF/Fnb1/qQYoW0Y8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=UtGIMaxL; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="UtGIMaxL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788975069; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BImPjDWJFaTy23MZvaalvSN0CAVWkTjsWrxp7/F1C5E=;
	b=UtGIMaxLwlO4RMw7AKer+QwZGYrqktiJSekXXg/ATmGFiL+VbySWW876yoi3gok9j7UpTsO9zY7PyfNqF1DpR9fHIoZHynQj/k9j7vasHEyh2PbDtbO61WC80ICqbUzzSjta10XehaxbvFbUsRKi4aTX2jWiPMGO+fIgkc3Hbq4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07520904|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0356341-0.000535005-0.963831;FP=16775997236466740915|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.j9p79qq_1788975067;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.j9p79qq_1788975067 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 01:31:08 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH net v2 0/2] can: j1939: tighten TP receive-path checks
Date: Thu, 10 Sep 2026 01:31:02 +0800
Message-ID: <20260909173105.158202-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_xtp_rx_rts_session_new() allocates the receive buffer based on
the message size from RTS dat[1..2], but then overwrites pkt.total
with dat[3] even when they disagree.  A sender can set dat[3] smaller
so the session completes after fewer packets than the buffer was sized
for, delivering a short message to userspace.  With dat[3]=0 the
session just hangs until timeout.

eb96c5890792 ("can: j1939: transport: j1939_session_fresh_new():
initialize receive buffer") addressed a related symptom by zeroing the
receive buffer, but the root cause -- blindly trusting dat[3] -- is
still there.

Patch 1 aborts the session when dat[3] does not match.
Patch 2 adds a pkt.rx check in the EOMA handler for unicast receive
sessions (BAM completes via the final flag in j1939_xtp_rx_dat_one,
not through EOMA).

Note: The handling of sessions already in WAITING_ABORT in
j1939_session_cancel() is fragile in general -- the cts_one and
dat_one cancel paths carry the same hazard unguarded.  The pre-existing
AB-BA deadlock between active_session_list_lock and the rxtimer callback
is likewise not addressed; this series does not change the locking.
Both belong in separate patches.

v2:
  - keep the EOMA size-mismatch warning for transmitter sessions (was
    inadvertently suppressed in v1 by the !session->transmission guard)
  - guard out_session_cancel against J1939_SESSION_WAITING_ABORT state
  - add 'net' to subject prefix
  - use netdev_warn_once for the new warnings to limit log spam from
    malicious frames
  - fix format specifiers: %u for unsigned, %d for int
  - drop redundant dat[3] == 0 check (a zero count already fails the
    != pkt.total test, since pkt.total >= 2 for TP)
  - patch 1: explain why neither direction of mismatch works today

  The first two items address the sashiko-bot review of patch 2:
  https://lore.kernel.org/all/20260908145715.D70BD1F00A3D@smtp.kernel.org/

v1: https://lore.kernel.org/all/20260907145640.1106170-1-liuc63@xiaopeng.com/

Liu Chao (2):
  can: j1939: reject TP RTS with wrong packet count
  can: j1939: check received packet count before completing session

 net/can/j1939/transport.c | 41 +++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

-- 
2.50.1

