Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276477;
	b=Ts13IBuEJACXRzB3Inim3GQRcFKukXSBxQuxeINo5OL0McAFnyMnMq2OpzDL3keL4uxa
	 6DTFKuTUyasGJdzTqIBGRQjESA37hpK8bwPpS4jI6hdpt6VtLvqVoRBfcVZ7+B+5A8iio
	 rp0kqVXKOVp1QHRJiByxts2BLKrEjGT4fkbhKIVcRg0Myu5dzsyOWx5eyT3vp53rl5To4
	 iRWJjLd+/i/CyZqzRpEy9sm4wd8WoYlHpFe0bCpGL7jzrEvHfq8AO/oQk/L2ecqfLHacO
	 JFdmYLpkLXbIv0GoLNmad8ZaRCW2h5ylMT3jxkohX1+sdwnSZ6rPY+jPZcTQ9jWtUxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276477;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=Z4fiPdjuryHoPrnsvdKYYlxnv3G1wnCz9WlJstxSDKo=;
	b=iQtnWEbA86e72ELQYdhv9/FuwRS4CzObHHG+8Zztn9wN5w8ByHNj4qlsD04LiL8js0qc
	 LMfRtrMueTcM+hw3JvzFo8+YdWko+35XYnyuLgw46R/bxmppMFfiVW5uC1sZIK1g1PN14
	 FYxlulPpupJdS2wL6cQ2EPuWT7p0fcT6ls1AQJr4rKcxX0p64BGI00nXQNeM8ncC3tueU
	 JDwB1OOhXeGNkNDHQPfq4u296NbsX+8tHNJbCjpFP9QfL59Z5yxJZ8lsiSNnis6tWcwEl
	 qhjbtF+u+KE7aTFnzV5Cmx+eEpmGWe0GIpWhrdfh8POmlCR02Gyp1xw7PY+0zN0MtpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=BmRTNTCA;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C06606A321;
	Tue, 10 Nov 2026 02:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2C06606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=BmRTNTCA
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jNqml0Jmqz57HS2;
	Tue, 10 Nov 2026 10:07:51 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794276471;
	bh=d9FkNtdpXKsoqZFBPF8zP0zgE5utmCIsm4jF9JD3q/s=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=BmRTNTCAqXyNfvatUR416oMS98Ce9H+sFH7R/GM2yhzeM7v6TTeE4mEHbzKq7rVou
	 quA9EoRRrC8XsQj6OIV253XXou1Wfy+7Wh+QOud0Jqo2yJ3BtGVf1AsGhAYJNyTDiV
	 ghiGBP5P5J181PvpqGuWL+bFrasUvqroYpxgfH1qj1apa283Oyf1KM8zwDVMLWnmRb
	 3ubQ+vwDilJ76XyYpikMeV/nUko43RTBMfi5uMA28RByN1viorHoWgs/AdXtx6Zofy
	 HHuTNeDJijsoKHkBNky/vEXlxgTy+EnTCZxOFKmuGdHn7Zp8o7dwRvlBpPmB6Cb8T4
	 OD7QVc/LTb/og==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AA27gew014253;
	Tue, 10 Nov 2026 10:07:42 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 10:07:43 +0800 (CST)
X-Zmail-TransId: 2afc6af27c6f35d-33e6a
X-Mailer: Zmail v1.0
Message-ID: <20261110100743207gue5TpQyWMj3Sw1Fuwd6c@zte.com.cn>
In-Reply-To: <avIjXxp3hu7xd_s9@ryzen>
References: avHknBRJnZPpAIke@ryzen,20261110000234827nXRPQjzsInWFXaAaxeF6N@zte.com.cn,avIjXxp3hu7xd_s9@ryzen
Date: Tue, 10 Nov 2026 10:07:43 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <cassel@kernel.org>
Cc: <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXRhOiBhaGNpX2R3YzogcmVqZWN0IGludmFsaWQgZGV2aWNlIHRyZWUgcG9ydCBudW1iZXJz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AA27gew014253
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 10:07:51 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF27C77.000/4jNqml0Jmqz57HS2

On Mon, Nov 09, 2026 at 08:47:43PM +0100, Niklas Cassel wrote:
> I think it is okay to keep his tag, since the only change is a dropped
> warning.

Thanks, agreed.  I will keep Damien's Reviewed-by on the v2 and send it
as patch 2/2, with the libahci_platform fix as patch 1/2.

Best,
Shao Mingyin
