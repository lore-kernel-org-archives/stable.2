Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586684;
	b=zX9aI5lomrJyjxJ9VywTukoeAGUxEG1SWSootdSjSliymRDKpAy5eQ3jDXG2HiVlltZI
	 42we5E9ITpRUCTwk3ZEm2JC1JMWrXqu468st0u2546Uu1edUnVjPc+Rh6OycMTUr8k+Du
	 s382d2Az4r/T02jq5UKCYqoawKyYXVwX6JjXmusz1OYsPQRmUj79j5Fy2npGJBmO73del
	 3ZVRrn1pLrzaH5KvvjVboluCm83m5+JXWMzJYKN3Wz/N8fVr+5rbyI3oRYfLb19jTjK0u
	 YIo01rdJSveKo8L19pKg6AEhpr0KM/uTQ8XkbaFXUriMDxyaQq7DlAP8j0hzVPBj3Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586684;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=xUZr/zqEmoEBovgMSDTVhuMDucl7/TZ8GHZmXHe3qV8=;
	b=z75ksWA2A47QDhtwo5n1ncnwYKmUDgLAQ4LvE66KeQjZhLc3jFPO3WU36lTa/Ec7hYw4
	 zwMHRzlOrv2Pqasn0i4KY3/DKtcyNdSGUz4JJaCaRG3eMxccpwxhH+8wlLGADyh3RwgVl
	 MqiebPAVKTEtTqV/DMOpLZx1xuDtK2B9A8f/Xpuea+QdigxcrWpzNik4ErXvd33A7s+A8
	 Ylu6jBmGW987AQ4JSAhJrcw6exUPaIsYCe/bPwOclQiT6VwFQpfsHvwbxrSGQHbmAnTB8
	 KSyJtDaYyXSmcp9on6ow6s5ayH+jDVYf3FIxiFN3r3PJbLd86csA+ayMLOPN+Wgj4Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XPtgk83Q;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75584606A31A;
	Wed, 21 Oct 2026 12:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75584606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XPtgk83Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xU
	Zr/zqEmoEBovgMSDTVhuMDucl7/TZ8GHZmXHe3qV8=; b=XPtgk83Q40VYA+HJ16
	zfMzS0bsB5U1UenLgg8/TKcQ3aHYK3TodlRLsaszs3AUXxTZuqjSoYZNdm0w6K3T
	9NTNyvZslwF3mXcKLPUMb5E1iSJzwzqj/j47vlCFqwh58tzE6On5UXSWLtJ0vBud
	ENSHFH1JhPHNz83LZX5fCJYgU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA305aOs9hqlSXSBA--.18552S2;
	Wed, 21 Oct 2026 20:43:59 +0800 (CST)
From: Wei Tao <taowei@kylinos.cn>
To: kuba@kernel.org
Cc: taowei@kylinos.cn,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_flow: avoid integer overflow in perturb_period
Date: Wed, 21 Oct 2026 20:43:58 +0800
Message-Id: <20261021124358.369372-1-taowei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020142422.7ae3e051@kernel.org>
References: <20261020142422.7ae3e051@kernel.org>
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
X-CM-TRANSID:PygvCgA305aOs9hqlSXSBA--.18552S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaZjjUUUUU
Sender: cs_taowei@163.com
X-CM-SenderInfo: xfvb3tprzhxqqrwthudrp/xtbC-RDhI2rYs5BJdQAA3C

> Same questions / treatment as your cls_fw patch.

Same treatment as the cls_fw patch.  I will post the v2 once net-next
reopens.

Thanks,
Wei Tao

