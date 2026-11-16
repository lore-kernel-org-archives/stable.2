Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825461;
	b=lIEK5e8oY6p8oXttMBNXuy6EWE2OsaaAD3hTixb/l0XgbOWipxb//35qPNs5VwecmKGt
	 /DtQPiOwUdkJ4gvyaRtAljvfDL9FE5E+Bz6XsiGkAsp8Iz8qwnEua3bIDJaQdgVUTmY6s
	 HcQhpuCb0V71nIImNIBl3uagLr4IfoaBrgcEwWoS+XMUpH/4U7EOZZBCmqq98Ci/tY/Zn
	 yKMKRwvSV3iPjaLhH4/ag1M/8J30BPKqDHiTU3jtiEFElABp94fHAC38l3vJXgZ0VTNPm
	 6NKawLCiNHAtedsjEs6xVm6rkYDPfCZJ55wx94t+FTWNhr6hGhXY2pewQL97B3O6uIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825461;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=/GCPAd6kHKEiM8IfAgF80ZnqxP8C3ez55s7HWJvwjdU=;
	b=3HdnbAYg+Cjh2dJmhOdCZOvxMhFGNoRYYqog4Cthib6dVVpQC+A/Jiw2ir63r4r5zWbo
	 svwfcLY1azJ/lYGZ3wbGBKx5Mbl8d6yKk2UX+4ySWMgUs2Cs+GpugertZcQ6XWkPF4hAw
	 w5UCd37r4ooUeUU5c5C9Emyap8PlYDLcPf6JTv5wdolDBprqvUYUTrsD7Ig0lHWlbhCVl
	 xqJ0bsZAtt2ArdHwZ+wSYj8gYFzZJiI9592iUCKDy7z3Y2SG/ZxPKTPpzMKgSP69ZVCW7
	 Lt4kqlqoU2VVNbHQaTbN3r3BHqveRjoYZwU7NIpJXswYU0LTQTIRzWORY44G9MVa9HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=D6e5zpBh;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7D606A32A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F7D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=D6e5zpBh
DKIM2-Signature:  i=1; m=1; t=1794825458;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:mzjsHOFBLKLAwaklQevzewSKhCbd
   vWUkkUpZ3F6m+QSuzLSgJ0zc9xU3y9E1op8X5s3cgqq3um0Dn7MRxjf6WUF5I2Yb+0340B/kRGB
   K9pIv+a4yFTdWO3C2O6aNdmHwowOv4Q4IvkTZ7eJt+8jIhvEkMfEeuvGTG/lJo99q+NCWjfAZ89
   beHIF18fo94pKguZ0RWNupv+hCee5jjGf3p4JuFgo8UdN0MEUhcypqJT+9rvO7GnFQkFnh6Y7m9
   1DY285V9Jdf9lak6CxjcMdAM5HiWvb6/pA7ZubHrEb4R7dH9Ov0zsUO07+oYSS7DEyBbI9Cdqx/
   C52sPUD8RnW0Ew==;
Message-Instance:  m=1;
 h=sha256:
   mTgSnPIgQAo7sCQ2Qi/skYZh5e01zeios2QeuqOq56k=:
   bBTZ/rtzF4z2DLFAzLPSXaLy0E0T8GUsx1TXINyUjNs=,
  sha512:
   IKVqGH1uxnS4bnp5Hu4HWX5atnCldgFzqJObuRoxIhdXwgLZpCUFDk5RvTUMgE9YCuO4DbvguB0Haexn6tOV5A==:
   nBwE4r7v0oFa5gOxnw9BEIMxjQKFBpZqLvyNlJLRFdh5ZpCPZzgmAdkfNkylettxZKsGtNhgyZMA3QNmgDkOZg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794825445; x=1795430245; i=wahrenst@gmx.net;
	bh=/GCPAd6kHKEiM8IfAgF80ZnqxP8C3ez55s7HWJvwjdU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D6e5zpBhMEqBXHETMziRvfZJAyJZEE+QVhGuUuSIfBwluWzpyymE2LevSrXYctah
	 vZ/D+XK/5R/31AC4iVPNLbDWKU5NswzlvWJXSxXWZcpr4ozk5MymeSlKsbAg1Fof5
	 9WWuOBLVNRFLpEzt5uRJlpLOQXepyMjN5incX/TIwfndVqtsHbBWHm+/0alW8s+1v
	 at/XS/aMCtvcwtkfFXCI6iArLIZBaublUdHTWu3DBvosJATzKfWO88ZuoHRlKyep+
	 lDTU5fi8NmBqwr93ZswlTYbM9N98FdB5QDZ0/+q9FDlMPLQtpRNWfOVOp3DrDz/BY
	 Kp6PYRcOTkEFmL/TKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCpb-1wuOLi0Ok3-00Zm7I; Mon, 16
 Nov 2026 11:37:25 +0100
Message-ID: <a1c08551-8f1e-444a-9597-219fb3228e0e@gmx.net>
Date: Mon, 16 Nov 2026 11:37:22 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] qca_spi: Avoid unsequenced accesses to jiffies in
 qcaspi_netdev_tx_timeout()
To: Nathan Chancellor <nathan@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, stable@vger.kernel.org
References: <20261115-qca_spi-wunsequenced-v2-1-8cf32f12d546@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20261115-qca_spi-wunsequenced-v2-1-8cf32f12d546@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tu5VFCKA4q+bKIlTAsu3cZvJjOG2PUjTetMQV6XRKLLsS9hx0aE
 flE9HxGhnBHhrt9aXwrG7pMc/d0b17eBX2GRs1EZVAVgSxXkKP60i/LYGEqyKZf0faqn7Mc
 biAOXebRAX5UpXIwlzQUOVrY1cyWVAOJLJQdgVniY6d/AfCDNFLhkwlSNyMjrJE3wUv3S6A
 1KTY31uH3xb2/14uA9JkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TUx73lpeZog=;Bjw+QQ6lsicew3kZlxc0zqkr6lY
 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
 WIGi5DAIA==

Am 16.11.26 um 05:45 schrieb Nathan Chancellor:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in
> qcaspi_netdev_tx_timeout(), which can break the build with
> CONFIG_WERROR=y / W=e:
>
>    drivers/net/ethernet/qualcomm/qca_spi.c:805:16: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>      805 |                     jiffies, jiffies - dev_trans_start(dev));
>          |                     ~~~~~~~  ^
>
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
> function call is indeterminately sequenced, meaning any side effects in
> the arguments are unsequenced.
>
> Printing jiffies on its own is not that useful for debugging transmit
> timeouts, so get rid of it to clear up the warning.
>
> Cc: stable@vger.kernel.org
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2197
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
