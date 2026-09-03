Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5CE4AF68B;
	Thu,  3 Sep 2026 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442100; cv=none; b=uTPaufRsUpr/Ek4ovK1Z2g6QQjZY2W8NhMQ+iArgG3oFVyHtN4E/C1P/VGHppGzdHUU8VjiHQBul4Dy1jCaDCywSs3drR0W4z3q6OZJh6Bd+xTeYr1LxkuUX9J7ekU3tqkQQ+J1i2PtOC1AcywMDMboLpP1pPXxnnaRFUMMKS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442100; c=relaxed/simple;
	bh=622354WABGNaY2oxin56jyAGnIVPXlrs8EJdcZ/XPb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzPuOQQNEcyi5Zb1A30ZruXkZiY673cu7TSLZU2yqIBvsgvg2D56/PHVdIetMGI87AN8VvNSxFS99JUvWmYZ1m7wp0VZIIl98e5AWlV3lKdZjbMVcOa3g1ILDpQuJ8zllbOe6ad1B4UqFOufqGWCKcjRiMZZBTP36joIQVHwVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WH8d83Wf; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WH8d83Wf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788442041;
	bh=622354WABGNaY2oxin56jyAGnIVPXlrs8EJdcZ/XPb8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WH8d83WfzZMAcXKQvcTcWWsQ1XV2XALSk+k0BWVsdSKmf0QPeoU2zHc/eVRrIoLlB
	 ANudpD+8jcZXdLavaAC4lfsWHLFpK0DhShR9SjPF1exeydQZByqkMwKJqcoHYK+b1b
	 6XUBJBZCwGiB7pfG8IgqskXxe27KtwRTITKJBcdE=
X-QQ-mid: zesmtpsz9t1788442037t43b2ded6
X-QQ-Originating-IP: WhcYITip3DCLK5RQh/B4KeKpFk5IXY7lBXQuayl7DhI=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 21:27:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17184470730467376045
EX-QQ-RecipientCnt: 9
From: raoxu <raoxu@uniontech.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: brgl@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
Date: Thu,  3 Sep 2026 21:27:14 +0800
Message-ID: <A4C1EAB3A67613DC+20260903132714.2538118-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <5be7vkmpzmizgmvqxyefubgi3epnlo2uf7mabcgsapvia4ckpm@ixwfppk5z5e5>
References: <5be7vkmpzmizgmvqxyefubgi3epnlo2uf7mabcgsapvia4ckpm@ixwfppk5z5e5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NDtUtlvFer7v25TZOtRhfmrdiQuAal4mQn9WxzY+55LZOZ/mjMyaLQw4
	eRZAiOQI3Hz5V+VCg8qt1yLKyv5ijfqqvyo4qdFbYfeBtRIrmKu5WNjPlakmOD9a675Ad49
	blJjE2s6Nc3UOllDAmFeqUkc7xVVn9SJbXhyhrT88NQeEFhbEnmgGVjf1OSWX0xBKRb9hll
	lfXSN/k/LOvhdv57q2BXYsa4ZXOxyvPXMywH4OeG1F5B0sGCP/05kDtdGGsDfl28jIt5b3Y
	lisSUhl5xRsPZ6T2oa/iiA1DMOYrrRiGtPYB7shcepm0glApkv8deW2BR7L6sFr3GyBfsz0
	LKCsr4usf42ZV33zx7tH9oDRxxeLK0hf82NpNByas10P4Ay5DsNvQ4KAHivBrjN6UgO6S1F
	BjZVi83b1RWl/xUbLXgHrjpsO89uKDTUyvDcCcWlq2UBQLGaAm1Q4reGVvARIP76Q1w9+BC
	Fo/L/gO5tF1r+VQbJy1kFma7yKTI/qtTN5EJ+dTHtpSWR/7x9mcVtZfBvVsCUGmQNmmuwfW
	WY/XfPmvUkKTMDb0Okz1XyXAodKe7SbTEQ/goa1N+BdZBoVGghrnaEcSL7LWsB6EArDmm6V
	oF39OB7s8iTOVy+uwiTcDhYHH33p4VpunUUuLtf6WooZfDRHF3fOOg4UkfXMAxzpV5zxtsw
	9IiiWwd7cRYBdRIvJU8LbLkynrbw/snTELhbMfsZLObhVCL47lNreO+vfrSdpHNrTgwFhZ7
	q3O+YmyU0iTTbGcKfR05f6mhnRIYQVlaALQkyG5J5XBzgC0hnYdzGF+hqNUxuwAYiUZqxYE
	lenoVEqHCJYHnKhlQN5ly8apPwy5YYh/eYvRgMQJBfuKWINiCwdTEuQ5+Rw5M/Gw7oLB5KY
	eetDLsVbEB1/roQf/YXRG2blHSvvXo73iTM/pKn6DuXXuZskd0RHKKvmS+eCijrSBCypsE/
	s/HVGfktmkojkXJs2coLmqwEpn5KgOELOWyizCZzPMxnWWOeqteD7gFod9zXWX9AIDl/cfY
	Z+0MGak5eBwC3Sv+CTqvfWwJLtQjiPSL5Z0lXswC4AjZ8Yaez+
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

Hi Luiz, Marcel,

A gentle ping on this fix.

It has already received:

Reviewed-by: Dmitry Baryshkov
Acked-by: Bartosz Golaszewski

and the Bluetooth CI passed. The original teardown ordering is still
present in the current Bluetooth tree.

Please let me know if any further changes or testing are needed.

Thanks,
Xu
