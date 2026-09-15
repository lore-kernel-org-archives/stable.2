Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AF3D6484;
	Tue, 15 Sep 2026 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437841; cv=none; b=spDQeCFND2iRkUp1+v0ad+9GnxLxF/0ipZNsMBP4fm5S4nw5YxCgCvWoqQjMgaHaeUkBhFOLFdjOE60n1D18xfAoAMkoHtxDUFI5u+ZT78mt8joeSmiKKp3IRgjL8JuWHO3G6Bt83jIes+DHGjKCueI2S0Wll5o+bhoILwlmPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437841; c=relaxed/simple;
	bh=S5c+UjTTUMmXolVmYXl2aucC5h2r4TBDkEOjFp6Ov8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHmsDo1tggVfjaZT3zIBUVdyRdEMwsahQo7o4TOPy8iFGFqg/r04nPIbYYyB9dEcb9Ne+wtTvdoaaGnTToT9F8VockfM/jIazdBXBGIZkxb2V8NTZKvgiiAbcSsTzR0WbmoIohlaFRFpUlGxXusGsGOl32twFibOg9ZImXdsd80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSkaw8Ga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSkaw8Ga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68DE1F000FF;
	Tue, 15 Sep 2026 02:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437839;
	bh=6BBLwH6OoxKdrD7IqzKlKv1nEF2RNk2WPyD04azMsxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MSkaw8GafPwgiXdDi6XMrD05ApEaTsILm6jJP2rDgrLEthON5FZEWb7fzyxIFlV1M
	 HKeYde2qIqp/Y5OS4tn77UgM2raY6OlIjOiyAhTYdlQPCaDmB1CvvEkwq8O7t2wPXH
	 1DGRd2mz5mUVKAt8AsqoMJQKOM1LVAPBMXY3PKwwQmTR0I+qw3rRk3EJFro+65f2dW
	 FsnBw2hlBXutNTnv4SIJo/21WM39OHwYoLTpwyYopRvN9D9N5xBQUNa1ow3nFgw7y/
	 7C2lOf3GVgUM3/wgIdUv3O3zvCipNNvWVMeO56tHOZNlfiH+q3vKWbqkOk8R+0hGCl
	 RM1rTjbc91HdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Zwerschke <cito@online.de>,
	Max Chou <max.chou@realtek.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev,
	"ra.prism" <ra.prism@gmail.com>
Subject: Re: [REGRESSION] btusb: ASUS USB-BT540/BT600 IDs backported without, RTL8761CUV support, adapter re-enumerates endlessly (6.18.50, 6.12.109,, 6.1.188, 5.15.221, 5.10.270)
Date: Mon, 14 Sep 2026 22:03:32 -0400
Message-ID: <daily-reply-0016-re-btusb-rtl8761cuv-regression@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9ac1c05b-e9f2-49e9-af63-9cd0e42115fc@gmail.com>
References: <9ac1c05b-e9f2-49e9-af63-9cd0e42115fc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Both set BTUSB_REALTEK for 0b05:1bef / 0b05:1d70, so the adapters now go
> through btrtl setup. btrtl only learned about this chip in v6.19-rc1:
>
>    4a23ce935f74 ("Bluetooth: btrtl: Add the support for RTL8761CUV")

Thanks for the detailed report, this is a good catch.

4a23ce935f74 ("Bluetooth: btrtl: Add the support for RTL8761CUV") is queued
for 6.18 and 6.12, which closes it on those two.

It cannot go to 6.6, 6.1, 5.15 or 5.10: btrtl there has no .hw_info field,
IC_INFO() still takes four arguments, and CHIP_ID_8922A, CHIP_ID_8852BT and
hci_set_quirk() are all absent, so it does not build. Those four trees get
980084de4d9b ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU") and
6f0624b4427e ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU")
reverted instead, which puts the adapters back on the generic path they were on
before.

-- 
Thanks,
Sasha
