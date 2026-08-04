Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76E3921E4;
	Tue,  4 Aug 2026 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821447; cv=none; b=cs2IA1etSXXgjQAanKfgvPw/2PMbV7W4ukcDZZZlekM/HY2zvkVMUV7cW3X+hs5Og6DqV2KxUjuN1DWWrpeqVpYb9XmvTTCszsFHC9Pig4O0whl7YmIFpoEB07xgC7IsUi/oXWod5lI1I6YBUjaJKAZ3dfcB3SwIAaUDllyEYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821447; c=relaxed/simple;
	bh=P8iP43eDHt81LvqSdy5d14cpEOzQE4Tm0N/yRPrNnWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Whndp7fPD69z+OtKZMYGkw3EAS9KEaDuDNDlTUeY9VYmz/s1X/6XTLe9DmT0jahOZTj6Awaq/UEpBt5biZzB+hp1FEi+ppXS+9H25a2IDRk1tokve57s2k0lVko0Dj212VeX+yDOPWxxFgc2n6h5B472O/GmedeYsv+TcRhJ5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cDuhGcJB; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cDuhGcJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785821403;
	bh=WVerJCQIBbfiADNTn0JWm/8YAIyeBAG4QNqQ9jmnNh8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cDuhGcJBzXIzIkkCRA1O6S6KW6A86Q5rnB91rN7/Q7/nIRpp7qQZsqk03PrgGUjF1
	 Tcni29/yhdMsfdOsx4E6Xve6EAQC723RBFEyDmNQ2yPfol/ZV6iRfQg21mWYOrYPLs
	 /9uoAz0vbjN0WpfJBKG9QACqxRF/lyCu888eGU+E=
X-QQ-mid: zesmtpgz1t1785821386taa50e78a
X-QQ-Originating-IP: ysEyymIQepnshwAmNpH4FCVePOmiVYrgVFJoIm0GVdE=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Aug 2026 13:29:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16598172742338723589
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: dlemoal@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH v3] Documentation: block: zloop: clarify capacity alignment
Date: Tue,  4 Aug 2026 13:29:41 +0800
Message-ID: <4659F8F0C6C328EA+20260804052942.1186727-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <8da2a239-e074-41f8-8d8d-552b1652edfd@kernel.org>
References: <8da2a239-e074-41f8-8d8d-552b1652edfd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MiUxkXieYO8R4H+o4MTIDg/qbrK2PMkkZOqgsvGSt2/Rtb5pj212i2sh
	YsYU0oMdpJJ5CZvcuZeqxSwkeMLEdJm/ZT///wo4vSkjlGbGiYx9CtzCfvkvtGkCOcilvfg
	MonkCaZGP1miZXM8g0YVSoidquV/lQWfSDx22Zm0KwPqwLVVUT82kySZiBfzVuwSqscDJS1
	7WhmXKHt5FWFqDQIWl3l/gI1aHlP73X9qD2DbqVeT2maKl/rPamkLz763WLN0XP8Jr3oi7k
	Q38VMfpMfdzx4Y+4xHq7fVhh5txb5QVLONPTti65/TOlIUrEqVhIEVJ+pYqqZZBie+Q8PC/
	PdlHqocg+FdqvVLREGqEfh3nrbyTzJ3gEP+RuJvHumVBZg39ke8OlW3V/q2lm9VIwsoLljg
	dxMteyA8ZJCSAKmesRcAq7iXAxEgUgpShvVmRqUBgVicb3m/8hpqzT467/SFPUioaoEWpZC
	VPy65Bodtx2CbET4k5mDrt6zvsSNabefUENLpy5uQTmolA4tbxofjChxjLgkYavwcKbdr57
	uGTwjyby8LrVx4Qe+TekDYT5JC+fHQ0PDb7MT39SxfA3YvCHNi4StqddVXsFMq+yLdEHYrb
	r7MFvLHlfOSC0PSTBb1u+/i92EkQZ2SGyKqFCZOCRtZrXhKtHLBiwJaP4pMv3s5jFn7e3gd
	XGB/QEtGOoImMo1PHhB4v7qivjBJ0EC2JSSLbH1vNV/U0sCVyr5AObUMvCabxZNXe1oy8zZ
	6S4pui49JmitNR6SHF7jg6UK9hyTm/0uou6z5BWjIRtqIVVL1cPpZ8zptKTWa4bZDoBURfU
	gwNxyd/ZubCNJtrKDLt4tg4lDB7IjilV0lWFKlp1Sq0s5tFSgQjUljlha7RYQgR1/Hzi2az
	PysNOSq7hH6/KJXOyB4pXCCrqzm3hIkV6I0xMA3grPC/H02yvpcYYkDTeYqGlxHX+Kx6hWV
	BtGVbCaqa8x2OGnkmybBk5f6EHHlKJ2HaeuGeRCD4IJo+FkYEyQU5GzKdijNdy614vq8Mts
	g1/8weC3/1HL/rx9d52FJCezVgv3kjK/43kwKkg9UInn5G94eS3fefHJZKy6ectj0r7XMxp
	+Mlzea/cMUiKF+zSO6s+RrfZDYifYFGPffSccyHoiIl
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

zloop divides the requested capacity by the zone size to determine the
number of zones. Since it uses one zone size for all zones, a smaller last
zone is not supported and an unaligned capacity is rounded down.

The capacity_mb description incorrectly states that the capacity is rounded
up. Correct it to document the actual behavior.

Fixes: 9e4f11c1228c ("Documentation: Document the new zoned loop block device driver")
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Replace the code change with a documentation correction.
- State that a smaller last zone is unsupported and that an unaligned
  capacity is rounded down.

Changes in v3:
- Reword the capacity_mb description as suggested by Damien.

 Documentation/admin-guide/blockdev/zoned_loop.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
index f4f1f3121bf9..abaf36f21945 100644
--- a/Documentation/admin-guide/blockdev/zoned_loop.rst
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -71,8 +71,10 @@ follows.
 ===================   =========================================================
 id                    Device number (the X in /dev/zloopX).
                       Default: automatically assigned.
-capacity_mb           Device total capacity in MiB. This is always rounded up
-                      to the nearest higher multiple of the zone size.
+capacity_mb           Device total capacity in MiB. A smaller last zone is not
+                      supported, so a capacity value that is not a multiple of
+                      the zone size is rounded down to the closest multiple of
+                      the zone size.
                       Default: 16384 MiB (16 GiB).
 zone_size_mb          Device zone size in MiB. Default: 256 MiB.
 zone_capacity_mb      Device zone capacity (must always be equal to or lower
--
2.50.1
