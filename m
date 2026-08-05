Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730F357CF4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951637; cv=none; b=IMH5CLgu4+YyK6rvvmiBAmpL6i1O6K6exP0M4G3c/Y8FNwLiq45knUZpekKAPS0KLFqKHU+ILnreri3MEMvZdQJe3CANV2USFip9/KKtp7M1JYz4guJCeNvT4yP/LGBpgn2HtTUcRj5JuKvpiBXV5u3vfSi2q1bGUiGGsWbZPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951637; c=relaxed/simple;
	bh=2b83ZB3ctcr9fRJlS6UQI0tYsiVRqsrhV/DTTl2bel4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMLFu9W24mzAzmRDlKG+r6gZhqH0ArSUJGNQDCpM6mJsOWFwKMW7AorhkwMqIn6mEk5cDrZWcgspcWgfZlCjNqnL+i4ndFsNFvd35TezdyMqp3Ivip9gGx1k4VGxUmpHtyeUpb3VwMY/Z9UbGtYb44w+uprw3RXrgQTtxH4jSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UisLephK; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UisLephK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785951609;
	bh=DOkmG78coEfm/KYxK1I1U6PpMIx5UE/Xu1CW3KjnnNA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=UisLephKBrJY4bAtbgVuFlNowKC06lVJ5M/lT8WdMLH3CiCaMf5O1PdXs/kZsR3ae
	 bWIPWbWToWjeyhUwCk3VFSsykyuszjKYCplozXNGkK7wewj318L/gewhnQcfG/Bxu1
	 ch9/kFwO5iPw7sXUC7WWOTrryX9UPbV8dqzaigVI=
X-QQ-mid: esmtpgz16t1785951604t8994faf5
X-QQ-Originating-IP: rDosL866FhdqRg8YG0s56DwKkMZGsjwaGDQzG/HDKbo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:40:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9932492737959475658
EX-QQ-RecipientCnt: 4
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v3 0/8] Backport fixes for handshake
Date: Thu,  6 Aug 2026 01:39:50 +0800
Message-Id: <20260805173958.660310-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NkyHzehpHY4/Ucivs5V5nMYNpFou2eK0tOfnGn3k76KqjQEZniriKrrM
	0bKyf51QS61zzpDRYKLzIj51wUIzyqj93i8i1LbKJbTW1crg/KL9aN0CgnWiK/t3fMmPC7P
	RCpBUvrlvHsIoE4liLZjdfcq+il8hzxREdbznWRk0Qrwmz7qUtybBcMC7vYwsJDo3MN1kCG
	jspcHeBFJUrSn8Z4Yr73ZCLTV40GkkYZwprNl64hoq0jbH7vK26Lm51RiNoLc+qg2uIpewd
	1992Ign/4W5jjqjFruVG/Yn1Au6AharsrUUWr8L4wrpgpFyWiKavnQg+AtgwAFxKcjFVY+B
	4E7dp6SKvBUSIloOALcMhKENDGOgKsX9hobGPNll3qklnOZnBJzZeMB3hII5LJRoTa5h5y6
	6lFs6/ALkCdhrFklQyxFuwJ+mbAz0m7qeB4zEEKEFqFne5F1MeSCX32xT5DAWKL3hc6KUjc
	TC485yyon5PS7zX3At79UI18k/KUCt285cyXa5uP5J99Fr4DRJQE8j9JrcW4FmpwYA3en7Y
	d+JCmn2P9cc97TznMStg2b68rhIQxqMISQ5Rk+MS5JpS++Hf0u4VvPrv9BSftFAf7QlX785
	XaU2vwUqmwhsyWIQUEktCOBq08HSPxFQtp0wq074j/WM72LSJ8x5/P5tis97Zh+UmyG1IJD
	t2kZdx5w5RFC5GVK9x3Ne4eb7A6Ij0IvcDwUm01tcREfLoygf/oyQ8C3N2W2WL/bqgEt5tx
	oFxTZrJIWYEqp7dM+HfZ6iH8JxuOzyV/C+2lk1S5vbLhx0W3TsTprn6I3xwbqCR5R4cc1ty
	pvv9rk/lPdof+gKbs5Ey0Kc/EBymz2EJnM2voEuOiwsDcgqPReJo6cw4IB+QEgjNqBKRQPe
	E75T4W6TYdghXW8ylxvIr+aNfFL7kD2W5r9pH2L4m8YiXPILJLPMs0XisAWzUOKq/jh+dJw
	27v9IXhB/phXL3FM3Lsbn50CrGzK/R0QtB/Zk5GF0eJXG/LPmsuXWeUZ/nKT+nGRh5X/Qwg
	xcNlrSKBCuaiJTZHVrOZYjM1VKR+AhrW0FPAt0mmmbuVkP8h2Hr8+xvcIV6x1YvDeRI35AB
	gPUrAtZLaKgEKeNW+xFr5Q=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Backport the ("net/handshake: Close the submit-side sock_hold race") commit
and its depends commits, also add fixes to the depend commits.

changelog v3:
Add ("net/handshake: Drain pending requests at net namespace exit") as it also
a fix now has been applyed in v7.0.12 in same serie. Build tested in my config.

changelog v2:
As Sasha point out, add ("file: ensure cleanup") and 
("net/handshake: Fix null-ptr-deref in handshake_complete()" fix the fault the
backport missed in v1 and rebase.

v1 Link:https://lore.kernel.org/stable/20260805091348.609325-1-guanwentao@uniontech.com/

Christian Brauner (3):
  file: add FD_{ADD,PREPARE}()
  file: ensure cleanup
  net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()

Chuck Lever (4):
  net/handshake: Take a long-lived file reference at submit
  net/handshake: hand off the pinned file reference to accept_doit
  net/handshake: Close the submit-side sock_hold race
  net/handshake: Drain pending requests at net namespace exit

Wang Liang (1):
  net/handshake: Fix null-ptr-deref in handshake_complete()

 include/linux/cleanup.h        |   7 ++
 include/linux/file.h           | 125 +++++++++++++++++++++++++++++++++
 net/handshake/handshake-test.c |   8 +++
 net/handshake/handshake.h      |   2 +
 net/handshake/netlink.c        |  56 +++++++--------
 net/handshake/request.c        |  65 +++++++++++++----
 6 files changed, 219 insertions(+), 44 deletions(-)

-- 
2.30.2

