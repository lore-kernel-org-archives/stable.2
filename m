Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9605418A5D;
	Wed, 12 Aug 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528032; cv=none; b=QCbPARzJ7dNAI5Rrj44ka2etpFMh+SAv2AaCparQUyEjzLVbYyczSDoLI8Gpdpa/nbMCFGmFuu9yEmuzdeEWziPyq/d03UU+CUCJukt6e23xogniMQbiNPM5FE9ro8ktqCRaTTYm0v+D4ByWme0AlOyranV+qMdWB6cUyEnU49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528032; c=relaxed/simple;
	bh=B0xcHHKe27nBRZEA1Wx6aRYhLvhQNqvldh6mm5506rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0dgDa8suUUof0ej2V60hI5lVZWvRi9gMdPrNpGavExp3GcUe+T4I6z8c6BP93nxXXSV7SY7wUEj+Slu18XLC6xQrNFv0UW6m2tpYeca1MfyuzwleEzouRLyS2EU2yY7GcQ5Hfsledp3iuy8q4kqyQt8dLKke+W66RjA9Ppdubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hWLU9zAU; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hWLU9zAU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786528013;
	bh=8MVPi0XBjoc5Tc+HMC+mk03uFoGDImFmSLFyLytxGtw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=hWLU9zAU1EgiWBSpRiMshaLMr1x3ReVQhtoM5Z1JUIryHLDxSNa+LryivBIu2V1tr
	 Wo83JtS7H1n4HVR/izOzNd/gCdT6nKd41ppdRxNqOObpQ05I2ywpT/SK+DKj1I/LVt
	 OQmipm3kgaazs9pYV8FcgaqyhoewL1h7rHxFKO50=
X-QQ-mid: esmtpgz12t1786527995t2e6be267
X-QQ-Originating-IP: gAH8PLOuktySRyqaoaUXnTt5xqfYt8BF3s1uagy+0uc=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Aug 2026 17:46:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10804165861698727362
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: heikki.krogerus@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: hd3ss3220: fix VBUS regulator error message
Date: Wed, 12 Aug 2026 17:46:32 +0800
Message-ID: <7A42A287B2B588D0+20260812094632.348581-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NVu/uN2EcufQu0W7q8DxzJPc/A60aSUoXUnLq7GOSBssoeeaTNOCt10z
	RZSaVuRIrmTroG13ktuYCIh43tklmXGGtEN94W+pdGIiv8k2IMca2Rcd1tLg45pAyQJ3TPh
	s5Q+Lo7h9f+l/+G7Sn9sPjC+dr601HbksCGxPm1lRjQFNlyuM2u4OVSlrOeTLCrLhQN/nSr
	w+iiEH7LOa2sJKmS+cVIC8wwUlSiJJrfCPQUkv2fPQnr9bneuLXhdaIKv/MwCljed7FD27u
	i/FOStLaN8sUSWUfA8y3nT/nFPMyYUzhYzZq6PMYuqml5yi8+XjaeljRSe9iYk/OfmSBRGK
	bMPsFjVWeQUO40Jw79YdjaaajWNkP5HYvKSWebjongaV36ZEml45rZLoDR+UhjbCOgvSfcc
	Or3nVQyCQqazYmGDDg61GdDrU+SZXheG/q08VQ9Ubm4+WsTfukBVI1WwE52bLUecUMf2OXB
	l+TIvbn79UwvJxcCBlDchEL3Qf+glK+jhuNucfXBB7sR0fApQSK00YtrhtghNi6AkqTHema
	gAdU4pNelkvn2o17n09E+ZrHSDXU2ywyv0sycBGZ2+ep31ppAgpjbrdw2OVtHLFiZVdRgwH
	M/eJeeXn1tIZk0B87/SEh3H0yZLyZV6glOVMgaeVJSlF/W0suQ7ZQpZDmgKctBtEX1+5BFM
	io10K50FILObc4fbrFnzn/T2IAREbijd5iuLPCHSWZpt5n55kYSO3aGGGJqWCq7v9HCY03C
	7O9HTdMC782SjpZCJ43G7Ep1qkRUV2n0b50WuooYLsn3VHFLXaU+BGAFueN3e+VEenPfIZV
	7BO9BH+bpD7y24TMN4Ei/eC7xwS1rxKxOkhg7HnJji/vu7bAcRNimh/XdxYHoRJwE7D0BB8
	nOg7rTneqcBK4flGcN5974P96F5xfSXjTOIrrLbPTBzctjcuR2C+GdlR9hQpad/u1RfWq8W
	dD9jsxjY+f+2Tlu96NHhgGoEO1SSDBKSm15EUKU3UikgqlXg+T6H5l47xQbON+3Rgwvp9yJ
	PoCJlDirF6EF6vJ6dWaXvdB6RXwVuh/IP1e256q1aQWvnHY5E/feQi7TM4gZDAlKW9NXLwA
	gpIDro6266UrI57M6GJrER8WJORRnui06efd/Diz7er
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

hd3ss3220_regulator_control() enables the VBUS regulator when @on is
true and disables it when @on is false.  However, its error message uses
the opposite operation name, so an enable failure is reported as a
disable failure and vice versa.

Print the operation that was actually attempted.  Reporting the opposite
regulator operation on failures can mislead debugging of VBUS problems.

Fixes: 27fbc19e52b9 ("usb: typec: hd3ss3220: Enable VBUS based on role state")
Cc: stable@vger.kernel.org
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org as requested by Heikki.
- Add Reviewed-by Heikki Krogerus.

 drivers/usb/typec/hd3ss3220.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 3e39b800e6b5..d0de5a2488f9 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -218,7 +218,7 @@ static void hd3ss3220_regulator_control(struct hd3ss3220 *hd3ss3220, bool on)

 	if (ret)
 		dev_err(hd3ss3220->dev,
-			"vbus regulator %s failed: %d\n", on ? "disable" : "enable", ret);
+			"vbus regulator %s failed: %d\n", on ? "enable" : "disable", ret);
 }

 static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
--
2.50.1
