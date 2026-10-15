Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C245208D7;
	Thu, 15 Oct 2026 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067622; cv=none; b=pr8cywJIwYAO6LWFD8dIrZbQvZoEt1rMxRXgsetYFojiW8DiC6y1VnsoFLYsmDoEgl5rb5fhKkGyV12ve0H0r4EgJi8zaPgcJBP1b4VlPKtrkONRSff6uKoSHXmb6Noh0nghVeCvto5Coz5EcWEn/tagIvKCsalK0H97v3EYrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067622; c=relaxed/simple;
	bh=L256Ja9HmeE8cqpLuhOwiDbO5UCv9dziLigvvEqCJm4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SP15OYF06hI4hWTAzSy9vrcBQc5BCsRngQ4s4981T/UyqzgiThWqMmF8v/3PgUAdr9+8XItK2jBl+zs39KcWGpErWrHH99TwwMWUveYL2uZoxfNZ266UJrUr+FxWvFeaan0W8mUe8Fa5CNVRuwFqsGu3JxmsqFNbLW4D0wuyLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=E8PRu350; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="E8PRu350"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792067613; x=1792326813;
	bh=jqN7tBTtl6TwoLhDwQvr898F3IgLD04BSqjitGTs+7Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=E8PRu350FXqlwzfhRHNS+5hnrjY10ZySyoKGMAymaEHIviSKUQLiiWkTzC9IOMUM9
	 U2iDDqKkOfVkeX9pAaMfvT2bjRjg5bOFcAHfVzexo8YfrRXgGO+lLIMhawb48pgqi4
	 TBkeZMelW434234+QS+0kPn3hhonHa7aF5dUN5dzlWurtqQtsySxtGlnBBW6pW58DH
	 Y8nsMzrUL/uW9wMdMP6R1lBkxflfUl8k6jZEqKQPNbFabnhHPFtJ2t+3tEez1rqQEd
	 SpeMlmhoehembTturoM5rIe7a+FJp8CHkk8UbACACIFmz6kkqk/Rr9/zkKkGJHpIe7
	 6BXgTScKnCWGQ==
Date: Thu, 15 Oct 2026 12:33:27 +0000
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, regressions@lists.linux.dev, Andi Shyti <andi.shyti@kernel.org>, Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: Re: [PATCH v2] i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL
Message-ID: <179206760496.80083.2220015870357865408@pm.me>
In-Reply-To: <52bc42c2-f60b-4249-976d-83d360933ede@oss.qualcomm.com>
References: <179173732257.29426.7905170638383807320@pm.me> <52bc42c2-f60b-4249-976d-83d360933ede@oss.qualcomm.com>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: d7e0835a3d7e2823ff8252c8e8192dad58c439f2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Viken,

Thanks for the suggestion. With drive-strength =3D <6> in
qup_i2c0_data_clk and cb97bf3d4f91 present, the keyboard and touchpad
are still dead after a cold boot (one boot). This is v7.3-rc7 with only
the Yoga's device tree rebuilt with that one change. The I2C serial
engines run at 32 MHz, and the first transfer on b80000 fails as before.

  geni_i2c b80000.i2c: Bus proto err, noisy/unexpected start/stop
  i2c_hid_of 1-003a: failed to fetch HID descriptor: -5
  geni_i2c b80000.i2c: Timeout cancel_m_cmd
  i2c_hid_of 1-002c: failed to fetch HID descriptor: -110

The touchscreen on a80000, also at 32 MHz, works.

Andi took Abel's "i2c: qcom-geni: Restore the source-clock selection
policy" for 7.3. With it the serial engines stay at 19.2 MHz and the
keyboard works on this laptop, also at the passphrase prompt. I can
still test other values here if they help.

Thanks,
Birk

