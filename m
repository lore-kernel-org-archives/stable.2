Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5243833B6F8;
	Sun, 11 Oct 2026 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737341; cv=none; b=Bk6ADzsdGJpzWxYpVOUTKxTgIg6jrtqqaJ82nGI9cCqFV9/mBUBK+L9mAV4jI+sdb0x3j7MktrcOUXlR2PaCu1SDtPO4FOuR2bDlZ1R+VS+Pb07fB5pYlGHphnMVmb4fTDi9aDdqusjh1NoXBOVlZsXapd90GGUjNRJSUkTTIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737341; c=relaxed/simple;
	bh=FKfgpR8zMF2/vU7G+VjwWWvlWk6W6Tago6pqkc6YiKo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eNOcXjGNHu2DcWv4REoJ3vH0VM2FmCHOLMV9iH4xR/WffBqYzSvCiB86FgJvgj+Gjbh76ng2CyaQRo5IuUtJbLq1vc9Ac8tMvFddBdQDzTEcE6y0ld5iRsO9t1UGq0/88qr1UdQlQml2rVbascC0ya6pgn7WxDygE6YthpMk+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qyVaMzq/; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qyVaMzq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791737329; x=1791996529;
	bh=LarrssuBABWPTwg1p8etRRP2viISHVBLfh4RBo5CEoM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qyVaMzq/u8r5g4Gz6ZL8ftUFpsJcA5Gmcdv8a6rsWuzkaWsaDa07q+ksblU8yL7jJ
	 wwBAQZmgqRngwtu+FTB+41IYqyXKhUdUYrlh17oR1BZbpepc0TgWMdoSJb11ACyGfZ
	 LtgQLCMj3bKVpJDFgQyyDr49jARfeW2gfv6rI2NqmkzPU1X4DkOrc3K4uYltYv4J9p
	 8FHNPqO32/GYkSaazqK28LwdDa9c/71bWb2P74Up4/wtc2Tj3xjBWscTWe19PCU1Su
	 KwT/epRzKSjSG84zYA2c/Y0qEelEoBqFNOyBg/Q+K1srXeHIzx/Ew4GOz1zO0au1yM
	 fUEOeb9MZ18xQ==
Date: Sun, 11 Oct 2026 16:48:46 +0000
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2] i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL
Message-ID: <179173732257.29426.7905170638383807320@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 5c6754ccefadb41aa845cd9bb2131df664c89160
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Viken,

This change takes away the built-in keyboard and touchpad of the Lenovo
Yoga Slim 7x (x1e80100). It reached stable as 139efdb3ee6e in 7.2.9,
and with it the laptop has no keyboard, also at the disk passphrase
prompt.

With the change the first transfer on the keyboard's bus fails.

  geni_i2c b80000.i2c: Bus arbitration lost, clock line undriveable
  i2c_hid_of 1-003a: failed to fetch HID descriptor: -11
  i2c_hid_of 1-002c: failed to fetch HID descriptor: -110

The touchscreen on a80000.i2c keeps working. Both buses are set to
400 kHz in the device tree.

To narrow it down I took a 7.2.8 kernel that works on this laptop and
replaced only i2c-qcom-geni.ko, built from the same tree. It is a
distribution build of 7.2.8 whose patches touch neither this driver nor
qcom-geni-se.

  7.2.8 driver                                keyboard works
  7.2.9 driver (its five qcom-geni commits)   keyboard and touchpad dead
  7.2.9 driver with 139efdb3ee6e reverted     keyboard works

One thing I can see from the outside. The driver does not set the rate
of the SE clock. Without the change clk_summary shows the clocks of the
I2C controllers at 19.2 MHz, so the 19.2 MHz table is used and
SE_GENI_CLK_SEL is 0. With the change the same clocks read 32 MHz.

                                      without     with
  gcc_qupv3_wrap0_s0_clk (b80000)    19200000    32000000
  gcc_qupv3_wrap1_s0_clk (a80000)    19200000    32000000

So as far as I can tell these buses now run from the 32 MHz source with
the 32 MHz table. I have not found why that fails on b80000 and not on
a80000.

I have not tested mainline, which carries the change as cb97bf3d4f91.
The same backport is in 6.18.y (5815329988ac) and 6.12.y
(f5d0302416aa), which I have not tested either. I can test patches on
this laptop.

#regzbot introduced: cb97bf3d4f91

Thanks,
Birk

