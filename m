Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548213;
	b=loaPa9OV9gLssTs91JdMPTx/jfBhg5Pczd6v/HmsYpcLrOorwf5qALAFtqN/UYR6FvzA
	 FFWzPtm7EyEL32bekPsSR1bJT0wGU1M5BiFWTEkm8MrENy0lxs08jIH9+GPJ0lYpwqbW2
	 7cLYAaHW3srtXySZ8ZIpO721/AosuOLhczlXfIk/Mn326eC++5l1x5VWG91cg2Uo0a5Uu
	 HYhCV2P12RF2NoN3VFm4j5Z0Ew/hwNfajl+zv5fvReRLZ4WpBB4pBpLb7SntGaVj+fmdS
	 PHIEb2EDnvpeKXwb+fhO7HdHil5OvhxAkZIz6cq+vvsys2CQ2LtriXoZ7WNFpdxL5Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548213;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=6wNcOcijuFyofb0i/mEXiGYiJ4ggHQsHy+6EtjUDPPc=;
	b=cJkq/Glf+aO9k1ruFDJlmZhBKVUa8cSwHQWmXAuxhmFVr80TOPAi/vLsq8Z5wX15qHvX
	 qL3QND/V/v7zlEKsFpeU6+pihFdVla5qElxkkGicxiYuSYzeYRIoZergxygb8BkyLswDi
	 oMH3n/DOy19s0/+/4ih0IdthH/+Gj7jRJEvXUocnNcRRfIPe/+Udnu+Y/P6Ua5RPBSC6r
	 Hd9yzKo1uM3J075+VXyXa7Rp7bV9HlcRi4cWuIA/mk+7LgejX5tKcS6CmdtFMSQsntb0Q
	 lZZcMbbiKcRvFd7gUm2NwrQ4AQjcwNIPFf1VYu4PSC3W9/KLQ9U4WKcpX8taGLi6U/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hLXDhy7R;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC89606A31C
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEC89606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hLXDhy7R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6w
	NcOcijuFyofb0i/mEXiGYiJ4ggHQsHy+6EtjUDPPc=; b=hLXDhy7RYubi6DuVYQ
	faiJdsQgEub1Xv1WbQTMn1MPYerowzGOLYq+VD+N63HER5W0qPEk4BXE/ZFCrVmi
	JI7IjMebT4/o01sf1pXGm8xsOvQ8FGRJMGAZBbo/c+KLZB3Ev3oHym2W7QK2Sk2v
	iXAFRznc67jNUcxofYUDOHC1s=
Received: from LAPTOP-BJS5C4G0 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3d_RnHdhqC8iOBQ--.37165S2;
	Wed, 21 Oct 2026 10:03:20 +0800 (CST)
From: Heyang Tan <thy15333007817@163.com>
To: stable@vger.kernel.org
Subject: [STABLE] wifi: p54: validate firmware record lengths
Date: Wed, 21 Oct 2026 10:03:16 +0800
Message-ID: <20261021020316.319-1-thy15333007817@163.com>
X-Mailer: git-send-email 2.51.0.windows.1
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
X-CM-TRANSID:_____wD3d_RnHdhqC8iOBQ--.37165S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU8UDGDUUUU
X-CM-SenderInfo: 5wk1ikatttiiixyrlqqrwthudrp/xtbC-Qgy22rYHWg7VwAA33

Hi,

Please backport upstream commit

  db7b86bd97b380ece8fa39cfdd7502a9fd35e56f
  ("wifi: p54: validate firmware record lengths")

to the 6.18.y through 5.10.y stable trees.

The commit fixes out-of-bounds reads in p54_parse_firmware() for
truncated component-ID / component-version records, and an rx_end
underflow that produces an invalid RX window.  It is self-contained,
applies cleanly to those branches, and was Tested-by the p54
maintainer on PCI and USB hardware.

Thanks,
Heyang Tan

