Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE04386575;
	Thu,  6 Aug 2026 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979627; cv=none; b=hC+UJuZhXJKdkFT8nDahKoO/10ywJQuatl6FO5hZEV30bBt4rGuIEKR11nh+k7OEp1dtJCwWdJ4Gb2jCBkFxWqNl9O4u6Vdac71xhNaltAvOYe3rxjFsrRJEu1CS2hEoJ+Cv2s0RcnfOWiT9WdXOEoFqsarPw4nTi7/SA0fxzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979627; c=relaxed/simple;
	bh=lFHOYy5PcGSuFEFXM5bvl3jLf0Rziveb7WBZ1JRmUZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPRBUc208wImZU+bczpZz1d1Og4zboSnzWWzIfDoXAr0WNWtb684NFywxm/IhQRoXRnuO0S9DeL8FJzyVNwWVt1H4NsXBwuCyyRFeXJyScRXaXgRY1hEKIVu1rn47NSnPV7xh6z1C7rQNxpe4r/aWi/HuBsmu/j/kuW3X4kw12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=AsWtMOmb; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="AsWtMOmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785979609;
	bh=lFHOYy5PcGSuFEFXM5bvl3jLf0Rziveb7WBZ1JRmUZY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=AsWtMOmbHIuHAqYSmNkXn0ZdB6EzrscAadbkyNwCf2yGvgIkfKetRzKZmTX6AsyvE
	 Yg3c3/bVJsNKU8F4cFsbYMQ5gmHhdPLgHag3XMWj0vEOU7hnmVS2bJwccS5JGYRgsd
	 Fxl37PnL/03kULDVC82B2DqRGDD/fhwPjT0ghvqE=
X-QQ-mid: esmtpsz20t1785979604t96977780
X-QQ-Originating-IP: k6g5g4NXYwcsC5MCZL7Z4cZm9klDP4Ie1GK+y6oxtsU=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 09:26:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9630465270380063703
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: TAD: report expired alarm status through RTC
Date: Thu,  6 Aug 2026 09:26:42 +0800
Message-ID: <87DB8AE5DFB2EC08+20260806012642.1194869-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAJZ5v0iTbz=BMfbeVVDyjmcv_u1x8Sqn3b4sn6x5qCGU=KYqFg@mail.gmail.com>
References: <CAJZ5v0iTbz=BMfbeVVDyjmcv_u1x8Sqn3b4sn6x5qCGU=KYqFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MIiZxjTKFdex2OBA/eSs7jq5P6ZZ+sJ6i9HMU/DwhYkeFGCWTGUO8ufz
	NXKQhrNn4sr5fQINXcicRQlOTUfMKtG9ZGV5Ud0lpI4ukHjsGfyQamp6mjn7+yCflOkw5eF
	OuzeuBpID6QMohSrwNe5Rr/ws3M5/UtSO13TPtLvGS6w2do17XfIAiLuxRQAeXdtnWQP8ky
	D5eyRpwhABV+NzDpUzaCi8fptnZnacf3PexmF0uUhfHQOfYizYMaJBK341OzDs11rwt3aDs
	5DDJhWR9zRdmPWXjowSLx5FgWZVafLiKreFdsuMuRl4b7jxf+DCII7SnB8wqYlyEHhqFgDb
	kjqZkcbYc+8T7mEGsB8+Rs7MM0dc76/wKNWxPrWC23BlxzoeeVbcSm8TfpnUU27cGmqvXfu
	d1BprKaFbujK8t7Dr0OCldB0x1cAU0EtNCTFIaN1JY/DfnuAL6ibQHM//E8HzEpimBQdMpD
	RZwAtJzpVtxH5PxTShAHVI1hXYt3bAu1IckUWzmv7joCC1XWn9Eccu8b0bJKwJ+LD9xKxl1
	HINOvVxZGILy+qe1+fq4VuEUJADQ4PCaFvscG2eDF5v7frdNj8CSYmjAzUuziaWV9nbu+Dc
	6S5R25W18RMrwaXnVPxKHFxVDeqHDzfF16uGPvmqI7eP9ZhUSa+IyBS3pwMiYM40OuTOBrq
	aLMmHiNc17L6ulQQ9/dO06kop/g4x8d7ApK7yFjUeO1BOhKe76lgwn9jXyU+fDb053GJM5R
	i8YVvgYxq93thk+2RvNpD3PO38i6X+dFQR6ITtaHLUTIlZtW11CIa+SLWkRsbwRW+3jyTaS
	ZggG082OaiXURT82xW2NPLjbUjrz5vPPHAIPwi905UQ/mHCOGwGghXc6Ca15QXby9WuyfpS
	CTDGsAgDZAXTJ+OoPCdQcK+fL/PufCiprMNGE/fyMtjV5FsORTkHM4jQkVSiGaVWkCWxy47
	li65IAJaBw76elsYIATcepOZDlj8NHAK36u9F59bEbHmyNYsmHDUY6iiJGVdMQ3mcv9mrhM
	U5zjaIIU0bSXhOITz23+lCcGZzFD7zi5sg6HD5pA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Thu, Aug 6, 2026 at 1:36 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Well, "pending" doesn't mean "expired".
>
> ACPI_TAD_WAKE_STATUS_EXPIRED doesn't actually mean a "pending interrupt".

You are right.

_GWS bit 0 reports the timer-expired status, including cases where the
timer expiration did not generate a pending alarm interrupt.
rtc_wkalrm::pending is not meant to report that state.

So mapping the _GWS expired bit to rtc_wkalrm::pending is incorrect. I
will drop this patch.

Thanks for the clarification.
