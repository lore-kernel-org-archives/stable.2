Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6337FF5E
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354653; cv=none; b=dS3Gk32iKU7LsWAy7GgMoOIpIiq1ohu/GOtnsETUTHguC9L0tDG4ptDqaiCQqdRVglqyhzQ7oyBlaowYJlHfx01jeoA5EOiTkQtc4QzmN58MffVFKofCcfJbYNr3JKzX6PAkc6vZAb+FFhaqg/ngvptzchoUtlYO089W3kL3jLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354653; c=relaxed/simple;
	bh=G7/Rq6x4qK/s/0ukf/XPAzi6mDI+d+8xFFJYWcIDSnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTiyWgee15FPbCFNhss3vLuUUW9g60zaoNgd67M7Ouzl16MezahDxxbNehqOs380J8VEOjAWZvVh8xUYg/7fMqloA7VhZ/Zqc1aNxZ0Wr+g0jbja5hEeFNemsGE2iQ/0Fqz3udH1ZNova66y3QtdjLrir+ggtB7Ws4XrMF2renA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hNIAns4+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hNIAns4+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=Q6TnNJxglyiOUlwz1+rqzlNKomb7yKNuiARfJmiELgk=; b=hNIAns4+nEHA3e63UsyljX5Sfy
	BzoA87RKBUmzmY/pF7xA7lJQ15AQh70MLIQXFFLnKcIqlKPTanSaLwlpYeYabKXNQmN6flfIVDZiZ
	XOt3gRYAKOfbckwOUV6NEkEcOdh68iMX5wL0VkPecRADebRMx4VjlOaeQk8lecMm0U+tURlOBAsL/
	c1IHve4nUjI9CLgzfV0dGRw/1ivYV0w2KsUEUApN9CA+8I2Nq1vhFy0TfRlvZgCyV1S6IaluNdCKS
	BsUePqOFiuSUqmtiGS8UUEKSPega0gR87mweW+/J/k/Dr4uqDRapf1hH0u7bu2QNw+NIAUqjerU4D
	qYs2drAg==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 0/3] Rockchip GPIO driver resource leaks
Date: Mon,  6 Jul 2026 18:17:10 +0200
Message-ID: <20260706161713.2676365-1-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Patches 2+3 resolve resource leaks, while patch 1 is structural
change without functionality change, that is needed for 2+3 to
apply cleanly.


Marco Scardovi (2):
  gpio: rockchip: teardown bugs and resource leaks
  gpio: rockchip: fix generic IRQ chip leak on remove

Ye Zhang (1):
  gpio: rockchip: change the GPIO version judgment logic

 drivers/gpio/gpio-rockchip.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

-- 
2.53.0

