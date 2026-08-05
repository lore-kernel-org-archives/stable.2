Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A73ECBED
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921289; cv=none; b=XBtk03Tdx9esWy28Q3Q6hahl/h3IzfnOwJpd34Me1ASw2g/7fYvr2HfBcNZhTk4rPy/j5HiSFMmeWDytXvfuLJnn25KchujVU7Cj/xywM1G9e7GbndPx5v1rUfypGvza+ZDn7R+uXQiyVJ+LR7tNL92enBNfxm/CFYGCXiLXwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921289; c=relaxed/simple;
	bh=KiKG1jMJuoF+WMqe82tTtfSKP5iHRZ7ngI/SZMAG3Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XvdZrtGrWW45jKSNL0YgKZvQcmSoCqY/iNHm4o4bUjdHvjtTDIQsLqlUl5/wF+lByjZXnmXyT5zB30hYQWzrezMSCkNpbhrK2dA0ue/GXAYBsUPzNN9Abs+pxY9DKRq/8IQw2NuregjZ/uULeyGy219J8Z61GJGvRAtLKMV1Gzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ANwkgMk9; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ANwkgMk9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785921251;
	bh=/dZlSYY/nM05Waxy84jVZGAoNmH0mCzYvoKTi+ijNhE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ANwkgMk9hVCcBirk8HIyT3OxAZ5KNkI6g61Xl6l9ZmmjxVCQ2Dv5DbfPR6rbwyCwt
	 ePCB/gbaWTJHcuDqY2mQ2q/esnRet4PoC8z15HAhjaqIeH50sdnwiNmSDIZkFOV+5N
	 CX/IuLQCPbAQhkSIxxvcMBg6xId7c8XPq9bjqvM8=
X-QQ-mid: esmtpsz21t1785921246t745cdf5a
X-QQ-Originating-IP: VJ7zv8Ics+0fG5MDLq9MIir9dWRhv/T6GFPqOo6kRT8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Aug 2026 17:14:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9334516254395794338
EX-QQ-RecipientCnt: 4
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 0/5] Backport fixes for handshake
Date: Wed,  5 Aug 2026 17:13:44 +0800
Message-Id: <20260805091348.609325-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NqlQHeD3iZu/tx8ch/X5BN3NWhy2rxrqVamNivCyewuMXZeTi3udiDni
	GcAvUm4iDXnnWSxrc2v2MZPvpIE+ao4mlfzoCQFjOVsmkINoqyeV/di0DqN7N08OxtyauE2
	Cidxrzyiw7AMlCqtBAC/j9SKKWFiqa72WZY70tioRJV6seWy9FPB45rTBjUlqPrNuAK8BPg
	hmNZHYnxOSQnw0mxMWfHpMynW/fuEeArufqMWVVwL5iQoflt4JMXQCKsfxgoD44DP1YULlw
	JoIQBVKyTJ8mRNRY3CHlP520nalIWl0S4EIeERM7OjDBAwOx1AwmiZY7NjAz2HMliOXX+x/
	wkvr/5lBz3+8XtM8YCsmlluphc9zsMzpd/4WAnnESSqTqB0WybFlvrue8qohNNnRUsKOPDd
	489YPxo7YfxETPD37gbClpXJJVTV0bBTW8pl+KaVvrhizcqnSjn3mZzVvtsnbgEN9jSHR/3
	O3z6/9p8OP+0lBbpNSOGjlebiGAnRBgx3YoJJBb5Z/34Qvk2c05W25jYwgvAg9+CYTvVP3h
	7U6G1oImci8Vn9iLAzvzR30BM3avg6C4ajfBNYMyfe4EDLdmz6omVuOmh2+01EdeEzIkt4p
	bEBE0/jcim+qSwPUNkwmfCIX/KuMtmIbR3KghkR1mnsHmmJY+Zl1SH1nXAhftV/EuPv0SHC
	cWN1YJjrccKccCKMZLmS6STRxX8uevw/ngR/QPxdZYMUm5mp0sKMDzDWijRYqhy9QF05P7F
	4raBTuAozIppQ0we+3H0U3LvOW87Ie8n8+5wjbP83BjSyeM4L4cxtdqDRFtGs65LUTOVw7d
	tjweo2fUAcf9n7A6XIsgFLRoPy7d+l0nf4GN3rsEecUKRkt6FO6KOuJGXLBSpSxPIgzM/Wm
	vFEgjDeK/zItCED89E9lpatqw3H81VHw5gn0S/hEiQ2M9lAdsqj2yb41+JORt8MNLFCO/H/
	L69nJfrrUP/7fIMoXj1FN8rkY953MjgZqBFGG9dRz48ZUWmyXkK8Gg4INVPXDco/jleZQYu
	sC/PTGCObH5ytK+ZoVp8+w+Fvouuedb3TWSN5hsbl6kL9V7cl6
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0


Christian Brauner (2):
  file: add FD_{ADD,PREPARE}()
  net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()

Chuck Lever (3):
  net/handshake: Take a long-lived file reference at submit
  net/handshake: hand off the pinned file reference to accept_doit
  net/handshake: Close the submit-side sock_hold race

 include/linux/cleanup.h        |   7 ++
 include/linux/file.h           | 126 +++++++++++++++++++++++++++++++++
 net/handshake/handshake-test.c |   8 +++
 net/handshake/handshake.h      |   2 +
 net/handshake/netlink.c        |  43 +++++------
 net/handshake/request.c        |  60 ++++++++++++----
 6 files changed, 206 insertions(+), 40 deletions(-)

-- 
2.30.2

