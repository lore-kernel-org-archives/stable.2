Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484826;
	b=5PZ0ChMZaXx6y66TIXMxFa8aa+hOiUFYaLlY+MrQZ1lDyUdcfR/ZT2vyf3l8aCRnuLT3
	 SQVoAIfGcPs7EfimxQhAw0UoA3wJI8Jf0sbm7DofoQtn6xsaH78/aGPsbJ4PKAGq5ILHF
	 IjnNcyuvhY8O6MW8A/UptqlixQjlaSdY45J9gl7aa4VX10vsL4INlnwSH+eSS9lHJLICR
	 jYpuyAd+d/BADAdAXckaM4fOmQa4QEBdCSpwYDc6MwXxDNLM7QqyEQw9v8USN5K/zZnuq
	 tNdKPQEKDpUbS0Wjmc0UcUamFxuf8ZxiFGW2bbXEvXM2ZEI95TZ8NOJpIe4twrKMkRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484826;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VMBzrrptxpMHeOnmZnjJR4WMJYNVOuYhnbtu6IFZ97o=;
	b=YPdKgEh3OApgfc/GvOLNJx/UuED3m4PT3hC8hczSMZfa9zVgAbQG5KBAGFrVKW+c0484
	 RgZgnoI05HrwKgUshhnBF9JVngDlIC8QOJxcIflOuIAJR0X5UZVWQtvZLDoag0l7IHFEF
	 iHWRYnqk0Te19RT/ic1T8CwlOIIKKta7XPOCtCaZ1oacBd4QvPxYH88wLumcJ9vnJ75j2
	 9h1Z1LmqBR2+s/kI3HAMbDmWhb0qqwKIzSrXVT0zJPvpK+DBq2//lATW3vCdm0bvql6tK
	 20K8iVv7p72PZl1U6ex/GEcmkmQGLuWH5zCxASy2PTg8OdPwJsA9Oo9yJpoDMvRiJ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=dzD7vvbV;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1548606A31E;
	Tue, 24 Nov 2026 01:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1548606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=dzD7vvbV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=dzD7vvbVlKieNEFtYWvIyEuY77kUlJoNGeTllICteZS1eSkEnDKvAAbKYmlPCU5j6mPyNJz+vYdK0
	 uKdKiLcz6GF54VtP/2ePjK/QRaBZjFP+dZIAeKDf7e+am4wfe3m7oKtNtErr5NX+zYpXXyZHWSVvgN
	 merMRFP5pxX6htzo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56b04ec972f3-3f0da;
	Tue, 24 Nov 2026 09:47:04 +0800 (CST)
X-RM-TRANSID:2ee56b04ec972f3-3f0da
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[104.224.130.48])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66b04ec855e5-0e6c8;
	Tue, 24 Nov 2026 09:47:04 +0800 (CST)
X-RM-TRANSID:2ee66b04ec855e5-0e6c8
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] ip_gre: fix stale header length after erspan version change
Date: Mon, 23 Nov 2026 17:46:43 -0800
Message-ID: <20261124014646.7954-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123123529.3183627-1-bsdhenrymartin@gmail.com>
References: <20261123123529.3183627-1-bsdhenrymartin@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 23, 2026 at 08:35:29PM +0800, Henry Martin wrote:
> +	erspan_calc_hlen(dev);
> +	hlen = t->hlen - hlen;

Thanks. Version changes and repeated ttl changes are fine with v2, but
my suggestion missed two cases, sorry:

- If changelink fails after the encap setup, t->hlen stays reset, so
  the next good one lowers the MTU again. On ver 2, alternating
  erspan_hwid 0xff (-EINVAL) and 7 gives 1446, 1434, 1422, ... It stays
  at 1446 without the patch.

- When the link changes, ip_tunnel_changelink() calls
  ip_tunnel_bind_dev() with the reset t->hlen: "dev va" on ver 1 gives
  MTU 1458 instead of 1450 (same without the patch).

Moving the block right after erspan_netlink_parms(), before checking
err, fixes both in my tests.

The changelog also says the sequence number is written over the ERSPAN
base header; it is the GRE base header.


