Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3B423786;
	Mon, 17 Aug 2026 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996873; cv=none; b=myUmQGjhjGfXW4S1BOwYIW0tfVFoSfjwM246LicPlmMy3Gcr4CYwFbQ2GZkOgXnCZzSM2OTNje6N3/cUEGCjIAtaoV7Eke27Z+BsfFZuv2yOzZmQpwJwfjsdhnOInQPPhAG7szOPI8cxDxfDHMkh9cCKm3HXieKEwy15F/MtDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996873; c=relaxed/simple;
	bh=adBHAGZJIcg8hGYrTjNLrmyuG8LG+DRfpp20ZDclqmU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OKa9YNR9dW4heRV+EYSc6oo387VIgDfCZC1YOT8gRIg1vLk0mHTkM8vBlVjdQvAiFR3sh8BC3kghy3KdvA70S1ZCw/IVQMt6JPaKFp75hH7QB7bhh8+aXHgZbWXm5M7j+FJAj0Sf2VabjoK0lM/Xv3iqkZL/gNXFCeEJMwMzMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMshiOvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMshiOvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3E31F000E9;
	Mon, 17 Aug 2026 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996872;
	bh=ra7Z7ncAB1zZr6NRuNY7z+lfT4f4+C8W8KOgF9WPwwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FMshiOvK1R7uHU/FXalxbeSaQm2cNjSN025T6KUgHCN0/TFgaHMWKH/DuRBS8DqZx
	 ZxUzfDkWe5VEldRyE1d1bXdnkYXEYDPF1juLlVx1kRacbke2wbVBTtjVIV2Dj+t4LA
	 fcLM0GlL8LrDxSy6PdD8LdGIiVOl0h/Gvmn1UqoqaVV3j00PdTspiUqgSc94pQS79E
	 cr4INfRVischMHtWzweYK3GDA3wSw9o/tM+e3wWbsiRexmm6TLsItXyLee+TNkFuYk
	 TSpro/vGq7hmsjeXA/D906EncA/nts7yAipXqPF21VOLE7yNPXqnkNfW6YnNo6kpXv
	 j05rB6WdZD+iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A483926263;
	Mon, 17 Aug 2026 20:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: usb: qmi_wwan: add Telit Cinterion FE990D50
 composition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699682389.1714062.10704219346705097638.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:00:23 +0000
References: <20260812054911.447887-1-Fabio.Porcedda@telit.com>
In-Reply-To: <20260812054911.447887-1-Fabio.Porcedda@telit.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: bjorn@mork.no, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, dnlplm@gmail.com, stable@vger.kernel.org,
 leitao@debian.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 07:49:11 +0200 you wrote:
> From: Fabio Porcedda <fabio.porcedda@gmail.com>
> 
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
> [...]

Here is the summary with links:
  - [v3] net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition
    https://git.kernel.org/netdev/net-next/c/1056e79fffd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


