Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93043CE45;
	Thu, 27 Aug 2026 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850366; cv=none; b=koTBxTJKsFB0GlJiwITSPYftzIRA6ggnawE3/1vYyBDlHQ6BPeDJxlu/Q/FOJbSr1J3Q/mVhWcZfl7BYx+oo+IfaU8YkFTE4O3PeWucbY6zvcyoAGS0xaO0xTIeGPP5BrbgeINwfXJPCrOYM2EGBXIdo9NJBpjqvYpwg2JKVzSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850366; c=relaxed/simple;
	bh=TFCOK2adVw+xuACq5eqN89gZhBEbzVN+XzggcETvTCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMuF9ec1Ec4NBs2uT8MdICgiMZumDlTJEkpzc1txmeoOzq17zm1M13r/VpZxMDGlrQKNJzss6+wjm8FRQSWumhHGmOnSW2pHSCWKlp+moQu9oO2JD1/No7dy11xFSVCXtNr/IXdJ5mZlJefWJFMe6nxUuebdpcCUq/ENSfifM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.69])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b9692dc5;
	Fri, 28 Aug 2026 01:05:47 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: Fix job submit error handling
Date: Fri, 28 Aug 2026 01:05:38 +0800
Message-ID: <20260827170538.39179-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ao706o8ReDs-IXqf@rock-5b-plus>
References: <20260813142059.151644-1-Naixumogu@whut.edu.cn> <ao706o8ReDs-IXqf@rock-5b-plus>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0442f541003a1kunmb006e1c06f573
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTENDVh8YTkNISx1PQx0ZH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
	pVSktLVUtZBg++

Thanks for testing the patch and for the suggestion.

I have split the three independent fixes into separate patches and will send
a v2 series. I will carry your Tested-by tag.

Regards,
MoGGuU
