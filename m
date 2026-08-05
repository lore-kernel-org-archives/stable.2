Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE93CDBD3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950324; cv=none; b=ZkYiZ+JbJvPcQGGFhqrToj+nPM5kj44gMcKpIr1H2wsRDkQ0k3E5fubanyQpZfEDsA0A7Nc2EQzlpMq1phv0cXXVQYlUEkKdmfuUxJ8m8xxKUG6dlm32lZQR36eWXQMYxAAh8rVenWSqdJE5FivGt8glaHcHDIP0PkHlLD8om0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950324; c=relaxed/simple;
	bh=oFelcMx9i/nHMRO/WDKyBs5frFHSz/uE7G7n3KBjnh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L8ES+5FGRDrFFlpu6GpE5aDqyCyu8thwi3qv0NsglNPeD7rX/22lkJvLw4WBbC8YDzfgQtGy6axPZR3EHi9fm9ZllJ8jH8fw4lrLiage06B/0bVjG1gtO1rAMwwnwv32Dx+UPgwIrDS0wToH6spp7sUzyNZCRU6JkfS2gOOtGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gKU9uLb5; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gKU9uLb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785950274;
	bh=zG2ecyZ1ujDVHUfyDcj29FBEykw4UVzIV9tO10ZPT7c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gKU9uLb5x3H0gwUJxS0z3PiHyWVRufn8MdKPzHobj50ltvCumGumEFOqqoYsWJQ+p
	 SAd6EPPM/NoTkPultY8/RIwYejpqcbVso0tdfe60G/H2yfV89NZAd1ZsrEGKdIij9F
	 uXu0tkkL8G2FhvSqdpGB5kSWex95iVcTDKR/RbbE=
X-QQ-mid: esmtpgz12t1785950268t85b08979
X-QQ-Originating-IP: OSQmusZfixIwhXuVymh0g05ptTtJcsRpoBLctNwhGG0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:17:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13812665985417922455
EX-QQ-RecipientCnt: 4
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v2 0/7] Backport fixes for handshake
Date: Thu,  6 Aug 2026 01:17:35 +0800
Message-Id: <20260805171742.654530-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MGrSfDJOGEDK+qUdeU3B6G1HWW9kRlUDb7dlZXBFD/8XyJyORJxsFDLS
	49vTs2X+PowxF97+6S3Gt84W9AC6Qdr+GuvHKFXtat2Gb/qck8jf6SDQqg8asnfMvSdz0T6
	N27izqpja5gAY15+4VPz10CLk3Miejkhij/HXsJ8oCAsZWqxDIUu4vZWwgYzvFQiJXSmOng
	Rn4S7sgJNV2m7doZgbsFUZtFPF7Bl53HzHEncTRzUj2YjosYDTPiWtBW5IxTPjGio4J010T
	kRtEvRAUpnlVmhp5zrr9qqNQPlKlhGdp2BSRn/OgUq+QyH109dqUD43/x4Pxn8ly4w4FU2p
	3kQQL/mjNtteEUR2QvakavxCYE/4IbWfCWdARgI9SBtb4znx4ubDCvqVdwVuoIq5SI/dCnk
	0gvIDu70TrZ0M2qrYNs0R7nnzbV/mTR6/OU8onWMB/de4eFkARqpVe9CaDqYDQcbxm4HLDX
	Az73RoZSGw0nYRBMxqRKiqAvYqEMPTdLoaUew91WLdyzwpbX2jxEtW989BInBxPqR6oJHZb
	s6myKDK1pHD7Sz2OhzrxzSn/+AD3MkJenmpQ83ee8htZRcIlIM4cdjezZ0LrO291eFD6C9s
	jygzwX+qrO2tqYDwXBCLrRhDnkgGRNS3A+XW6xZDuJl/2u5fZRvKpFg8F5RvDfSXinE+Pkw
	UaKPFQc3scJXebTEAns024YsQoxKiTxZXTwZakuieQIjjo/aA90SRYKWTSQnsnPncpgbDaB
	tc8B3CboCamfXsk+hkzuSYYO+8vbxnG7++IIedICRFjp695UFfA711BFn3UKq/qrA9MyP3A
	U/jEP0IOB64zeY5kHyKBQ6tDNZm626exWgRK0A7SuYENDYzTaXbwtXoJPThCjOQE+a3sZqO
	cZeZkUpbffDfxgSOGeuRrQBMECtNNX6WsSj2e79eA4rhfo9yuRHlee2S+uNLxU2XyOEcbLg
	8l3zuyvV+kcowBbkHfxMdvFA5BZbwFVfgIhAQRQ5mwKxlnx1DVKSf3yKQc/5rXVMY/ITvku
	O//Dcv/ogU4Y+1LFuSiCVmg3xEbkoepPKWCx9JEFVeuMBzkpJNzuVIrbowuhdQpZNGXLfPC
	fN3iTxf757Z
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Backport the ("net/handshake: Close the submit-side sock_hold race") commit
and its depends commits, also add fixes to the depend commits.

changelog v2:
As Sasha point out, add ("file: ensure cleanup") and 
("net/handshake: Fix null-ptr-deref in handshake_complete()" fix the fault the
backport missed in v1 and rebase.

v1 Link:https://lore.kernel.org/stable/20260805091348.609325-1-guanwentao@uniontech.com/

Christian Brauner (3):
  file: add FD_{ADD,PREPARE}()
  file: ensure cleanup
  net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()

Chuck Lever (3):
  net/handshake: Take a long-lived file reference at submit
  net/handshake: hand off the pinned file reference to accept_doit
  net/handshake: Close the submit-side sock_hold race

Wang Liang (1):
  net/handshake: Fix null-ptr-deref in handshake_complete()

 include/linux/cleanup.h        |   7 ++
 include/linux/file.h           | 125 +++++++++++++++++++++++++++++++++
 net/handshake/handshake-test.c |   8 +++
 net/handshake/handshake.h      |   2 +
 net/handshake/netlink.c        |  46 +++++-------
 net/handshake/request.c        |  60 ++++++++++++----
 6 files changed, 207 insertions(+), 41 deletions(-)

-- 
2.30.2

