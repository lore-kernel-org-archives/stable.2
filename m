Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDACA3C10A4;
	Mon, 10 Aug 2026 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367238; cv=none; b=A5l1XUoc58DWhUl0R+KYJlA0fl8KRRfOnGlBSc+cxYEphPo5RTf6MQTllClyVb507RANprsZNbK6ZNQZadAtZyMGiteUnyRB6p111V05TDoTLJXX8ihXoALmtqpkE75CNPsodvILcNdlIe0RVPJSyV0fjckNjRgFViLNpsn/Gcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367238; c=relaxed/simple;
	bh=RSsagnmt0uB+R5PLVeR69Qc0rXEGxi/FAZhNcAeJdD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBpZS880CJpw7y+5wztSKxNhTS1KdKv4s0SMOI3qHU43gFLLgIvAdG2aqYerp5VR5rVAvAq70+NCt3qmk7o+R0+TQAOLgUw0bxvZvMDbkwI+8kGkrSCkO+XW1e5MXujkCrNJNVa6UuQjOnbZXDJmdM65AP1+3DD99OVvn/5HufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vsHQDwMy; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vsHQDwMy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9traob+/jbB3iPmvdcasV8tC2hfuwT9wN5GPpDQZHcM=; b=vsHQDwMywuVYL4wCvC9tcNpvl1
	3fPV0arPQlTk/cm2sMwzh2Y3CNjIji6pSY9fW0YFj2VuEjj5EUxZDU5aZTa5WYy1VMjgmsaOWPrmo
	hdWsFYaSJn8dJEGSfqYT/kZGLavNuARLLHGlFqZcdh4LkKHBhxzm5akjsk9ib2sf1ojyib9LUhil/
	lEuhoI8HK/T9zGtphNJcxgbAhcrkVNyQRvMjBLNi+TGWCWK1MZd/G/rVKYFT1bCxK9QpXjgh2UyMA
	SwxkiF4f3WpVelb0ZQRus9uATiMpyVtmTMnKZ0qbIwTugcTPFGiLFSBKW40Wp3MS9/7zXngZcNGA/
	a70jTNpw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtPie-002lrn-3D;
	Mon, 10 Aug 2026 13:07:09 +0000
Date: Mon, 10 Aug 2026 06:07:04 -0700
From: Breno Leitao <leitao@debian.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: qmi_wwan: add Telit Cinterion FE990D50
 composition
Message-ID: <annMvEUa7sUvVIfr@gmail.com>
References: <20260810103409.133796-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810103409.133796-1-fabio.porcedda@gmail.com>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 12:34:09PM +0200, Fabio Porcedda wrote:
> Add the followin Telit Cinterion FE990D50 composition:
> 
> 0x0991: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
>         tty (diag) + ADPL + adb
> T:  Bus=01 Lev=01 Prnt=01 Port=06 Cnt=03 Dev#= 10 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=0991 Rev=06.06
> S:  Manufacturer=Telit Cinterion
> S:  Product=FE990
> S:  SerialNumber=2aa802d2
> C:  #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
> Changes:
> v2: 
> - Add stable@vger.kernel.org

Why CCing stable?
