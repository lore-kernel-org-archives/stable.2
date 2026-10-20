Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502147;
	b=UjkDLbWxg6lu31puFL/W+qRVcIEVipguulTVMcwZgCD0sVa102KmcCdJ6e/GP0HMapuh
	 0KnLC0FiZUO3A4tZDNeRitoOx1MHCSdXXRHlWJXY+KZ9yi4hDVoQBNZbQSqxTCmC94rW2
	 yFCXeidjYMjvRx/3xJmnSdEdpY4UXV3xLyOik9kj75eGBa3YHNFrm1lUxPCauWBuNoDwY
	 Lw7LApO+EXltX5MjRRei5/OHsgZT+xeIJ8spqPsL5vV3KX4+zLl/ECL/mWj3IW6lSnKH4
	 oIHYIo5SG8RzASAL3olj+YbJGtEdqW8LLdVyWyOqDOiuti6koDiYVkQ19CVufw/g6eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502147;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=21Ns/YBEwZQWni2k9iPZ+g2qxVfaJKV+vF/odCNBOZs=;
	b=3Ijlo0qK9SLIVyQm1QjcaaFHmkBpevyVG8HYNiCmg8/Bd2Ypsw7F8/O2qa/nmgJeFEzK
	 DkL3msMpGr9Yhj/yybt3mkZzkUrhLliDtAhoDLcRrFj83/pmjww5XzV0K4Y+KPkUYBabN
	 LiNnsKo9mnJkK8Bu0lsTNOOdafznBEaf0BwWYmHG4e1Cq0Z7bCYq0lFSrN1jzD2zZU4mw
	 QZqVRqXiGxkVxqEvf6yHgnqLASsLwpiZqEvOUnVaVC73R/9Vnz/+RYj4GJSF7BznOQRfx
	 Tbz5c7DrKNRLFx41pHeAnHH8Oak6B8JfBh6vQZWjto7tebp9SjbNE/26rfBgs6TlsBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=zwKD9imj;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96516606A326;
	Tue, 20 Oct 2026 13:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96516606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=zwKD9imj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=zwKD9imjUpgk87K2Pmmrn76ziPO3W9/ohs7U/Vke+3xh7ADf3EIZy4bgAdv1e01jOT+ApRz2MnQ5r
	 VTTYztKGZ7uMVOeq3QOz6Ib9o17OxvK6k/vZUkocxHrtZuG21+TaXRsI7LHPtRIi0XdnmTQD2rFmPZ
	 od8LY9X5ULurqWuI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ad7697de4b-1e809;
	Tue, 20 Oct 2026 21:15:41 +0800 (CST)
X-RM-TRANSID:2ee76ad7697de4b-1e809
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [192.168.229.154] (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16ad7697809e-cf017;
	Tue, 20 Oct 2026 21:15:41 +0800 (CST)
X-RM-TRANSID:2ee16ad7697809e-cf017
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, lorenzo@kernel.org,
 stable@vger.kernel.org, toke@redhat.com, yana06070@163.com
Subject:
 Re: [PATCH net] veth: fix stale peer max_mtu on XDP program replacement
Date: Tue, 20 Oct 2026 21:14:02 +0800
Message-ID: <20261020131402.5fad43b1f27b.xdp-mtu-cc-toke@cmss.chinamobile.com>
In-Reply-To: <20261020020147.790274-1-yanxia@cmss.chinamobile.com>
References: <20261020020147.790274-1-yanxia@cmss.chinamobile.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Toke,

Adding you to Cc; I missed you on the original submission.

The patch refreshes peer max_mtu when replacing an XDP program with
one that has different fragment support:

https://lore.kernel.org/netdev/20261020020147.790274-1-yanxia@cmss.chinamobile.com/

Best regards,
Xia Yan


