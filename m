Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EED4E50C5;
	Thu, 17 Sep 2026 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632011; cv=none; b=UkJleTjXS8W8QSO+95a0YPWLHyfkBTY3ID1uzSg7lEcAbJttG8vz/u8BGUilG749tHnZrthvydLD0X7JNmbN7QIXj9PmqM5706Lszug+TLkUN2obVsoActZXLygDg8sSkSRR3TuIYVF+GEoeMIsnwOERY2m09eb1Xbl/a4xR5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632011; c=relaxed/simple;
	bh=bK1heq2iTwxS2TSzMTf75BnqQiCXKeCGgjqyPJctAy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D2GgVdotHmyC3xllpExN9wIwxudQ5O9C1yjN5mKGaeu9x9nMwWq4Pp0h8ETVHBs83Qw/dYidpn3vYeqxFskPgfUQUvZGWRa0xVf7MWd+85ERrPzyeeqXpkMMkcWOjehnHrixB9QZYLCNPJUpMYq+mgfdVWkeh4vLAUNHMImXtZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Uo7wXIjD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Uo7wXIjD"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68H7xhzO73116695, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1789631984; bh=bK1heq2iTwxS2TSzMTf75BnqQiCXKeCGgjqyPJctAy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Uo7wXIjDWIiNEmcDADrZT0qFVmt9I5/PTLhiJvUveFjI0GE7RQ8h3BxhIefqKr3+4
	 JpuXm/KfzKMhAZi01wLhege7esklnTwrOVObvUpRAX4clsd4Cluw+3mt/sIx6tq5Rb
	 vFCPfjNAAlof5LaOSqcK+GS9wa2b6SiUi87Q91ZGzXAhplLugQizSLxtcAxLNI1Gfg
	 lXvtkhvU1gQ+YBSoer9Pplz1WCsQ0U2CS5drRvL++T8EAX2lEJneWpFf3Cp2kYYNMT
	 0DUhP2XyEUF6fQA4fjuburrSwP+lg1uReeoLAZRrZiCHwP/PkuhcxxbEWYkvdRIUOs
	 vRajXvNryuOew==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68H7xhzO73116695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Sep 2026 15:59:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 15:59:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Thu, 17 Sep 2026 15:59:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, Kalle Valo <kvalo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
Thread-Topic: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
Thread-Index: AQHdRZjHlTD58hEpHEaBWkK5Af0sf7bSYOjA
Date: Thu, 17 Sep 2026 07:59:42 +0000
Message-ID: <ea3434d849b34a4286b0a193351a610e@realtek.com>
References: <20260916040635.205094-1-alastair@d-silva.org>
In-Reply-To: <20260916040635.205094-1-alastair@d-silva.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Martin,

Alastair D'Silva <alastair@d-silva.org> wrote:
> In rtw_sdio_handle_interrupt(), the HISR status register is cleared using
> Write-1-to-Clear (W1C) semantics. However, the driver masks out the
> REG_SDIO_HISR_RX_REQUEST bit in the local 'hisr' variable before writing
> it back, causing a 0 to be written to that bit.

I feel this patch makes sense.

Did you remember why you clear the bit locally? Can you share vendor
driver you referenced?

Ping-Ke

