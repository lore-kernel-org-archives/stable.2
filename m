Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E564825D8;
	Mon, 21 Sep 2026 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989765; cv=none; b=M6jaL7JZbX017Glf6npRp1aWFmxgcEOkuARH1C3u5HBD5nPPnheq8cPni4WN1hk3nhCbAYXR9jnxnkPP/i1hJbVFwP+fhUQA7Zw7AJFx4kdXSN5LVSrL+xNQzRybBaBJmCeQxn7/BflClY7ZEX3lX/j/3Fv4mqAHqr/Z44iawAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989765; c=relaxed/simple;
	bh=u1WhI9U6b1XC1j1N3n7Q4HWjw9ehxiJ9KvxzF3einho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxAH7bNe1FA1kqMlhNUSHlkkNd2wGn252/34b4lXMMfexjKxjvJejduSGlCQXpX/RdKsd54N1bu489+R6ZLev4NkYwPhN1CwUv4lz2ulR/ge3/LD2ZV5BoyfFF2Rt8+XzAOW14rsk2V7keJVK3dixQH7MagMPAzU0/N7gvl0L/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=asf4h0A6; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="asf4h0A6"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e9246a2f;
	Mon, 21 Sep 2026 19:22:36 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH net v2] net: macb: initialize PTP state before registering clock
Date: Mon, 21 Sep 2026 19:22:31 +0800
Message-Id: <20260921112231.71716-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921111128.69129-1-runyu.xiao@seu.edu.cn>
References: <20260921111128.69129-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c3b41fde03a1kunm6099a0b349253
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTE8dVk4YSxhCSUxCQktITFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=asf4h0A6ILvlyWr1XuV/XaUoB1ihNSZjaQo/6St9X9RCcI5g8/KebCGUN8SIaUlPDxTmv4/aO+F0BfB6+FItOGCAZtM2u82UdTsn4pyS+ZWBV/EuBMBsnh0bElKsko+GLp2VjFPfVm8+t/OuTGuZiybasM4hgLY8q9vg4Jmg5vM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=u1WhI9U6b1XC1j1N3n7Q4HWjw9ehxiJ9KvxzF3einho=;
	h=date:mime-version:subject:message-id:from;

Hello,

Please disregard the [PATCH net v2] message I sent above. It was sent
in error as a duplicate.

The corresponding v3 had already been submitted and applied, so this v2
does not contain a new change and does not need review or application.
I had not updated my local submission state before sending the prepared
v2.

Sorry for the duplicate submission and the unnecessary noise.

Regards,
Runyu
