Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273592;
	b=f/M8iuhlC2Fvpds5dszMWn+laUzzTNouELO57dVfaBZsYQ7C/aGsQk/s8ZmlnZN1ZnaF
	 bogsYQpcYtqQ6VaKhM57Y4eqmzI4d1hPZbShTnHER2NOuD7eCOgWGJXDtcBr8wiCxliKg
	 EtEX/9w2jZ6xIbaVm/wtdM0MMIsXd/ELy8IuCn1cCoqX1DviP8NFPTQcTs+hnone+xky1
	 HWCTha6rI/LHiNJyjOP191LWRqZ394+TuA57LjUdsREzjx8abz1zRar76mAk8CV6rwMEu
	 1JdlL61BVIFSxYa8HPngHOJQ2Nu2qa0HQfdWT+JcyAP/zdUBTyKmeKASPiQvD2bQZ6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273592;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4BVerJ+PIwQl6opsILaayW4Xvw6MachSUWjGHlpDmwQ=;
	b=l+0W6EcayHj/EHodYVA9ygsAfyb42lgJsvfReneak9toGjplUanJIq+O6X1TCJG3amTN
	 TICy0Gp366i+a1GW/ZJ9F9kLDX3HUJyZotmEepKSa3hTtsG1YXKzzjLx5Fvne8tLb9tY2
	 sw7WalHsdZ2ZmKHJlJZbxtwKrFpl6CR2wrcO4xPvAz2QuRMQBkSKJIpnHMVdXz8RtwhTG
	 N9t042/bO87uLLqCN+KbNrEvNWfss6w2Owkl/2yY8cc8KlswJ7TZ1QuAPerCGIKBXL05x
	 1Sq4JMWHCTB7+N3X8mGeLKv2i59fECbZcUSwXFzMdOJlplHHVPBwfRr5gvm1ZUeoEXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.98
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA7606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16EA7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07887422|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0129995-0.000415244-0.986585;FP=2673825485910912515|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.k-TY7CU_1794273579;
Received: from 172.18.24.170(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.k-TY7CU_1794273579 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:19:40 +0800
Message-ID: <c86128b4-1ead-4645-aaca-4f2584faba62@open-hieco.net>
Date: Tue, 10 Nov 2026 09:19:39 +0800
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
Subject: Re: FAILED: patch "[PATCH] hwmon: (k10temp) Stop matching Hygon
 devices" failed to apply to 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>, sashal@kernel.org,
 Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org
References: <20261107053014-failed-6.6-08e6615c909b@kernel.org>
Content-Language: en-US
From: Lin Wang <wanglin@open-hieco.net>
In-Reply-To: <20261107053014-failed-6.6-08e6615c909b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha, Guenter,

On 11/7/2026 6:30 PM, Sasha Levin wrote:
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to<stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetchhttps://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 08e6615c909b2504a5862764f3a7fca00c7ab066
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to'20261107053014-failed-6.6-08e6615c909b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Please skip 08e6615c909b ("hwmon: (k10temp) Stop matching Hygon
devices") for 5.10.y, 5.15.y, 6.1.y, 6.6.y, 6.12.y and 6.18.y.

k10temp works on early Hygon platforms, including with the reworked
AMD node code. Backporting this commit would remove working
temperature monitoring.

The removal is part of separating Hygon support from the AMD NB/SMN
code in mainline. These stable trees do not include that separation
and should retain the existing support.

Thanks,

Lin
