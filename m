Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903870;
	b=H2xulDNeXMOarguckJLYR3ngzTWez2M6YmDwp24lZ1GvFzP6A0Lo0qSw0ihamAwpCYqC
	 cRPcBvWpaXecBOSBqUcOjZ0G7REOQlbkKYwonbc9zBkI+JhMS8VxhgzqXarmL48VvbR7k
	 lU1tWci5HCKv4A6S12xzjhGsoFe61uM6WMswB9oB6tWJT2Yet5xnbBL70EGpIeKiYKpjI
	 GOBA+BK4taKtea7NNjEa/DExdO+suESsLhftTq5zss7RtPGxniG+0VrG+/m4cKl1KDAQq
	 PPsLfNtZIdJAj2uHUkEqBmakBShpkUspmdjx8Ok8Q4mPx28b4qH8UNs9InI1uhcN6zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903870;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	bh=w7OTxenFT6A8JYevnH8NQBfKgcuFik3UXOa/tHwcT6o=;
	b=hGpM+418bSHI0xyMLqPuUEGaOytln+14jKptqt3ptXOpAo+Y2CCnYyF3uoFwEJ8Y6N53
	 SjyVgv4K9hQsjPvATFbwsRdZSymA6c6NaheHA1Gt1pJPXQENC+Kgxjm+B5UIGbZnoUb7p
	 lOqFL2rBh++C/noqzbpEbx8JY1hiIw8ll+lc8ZIGBfoGxK4oa1lp+eq7HDvIwmZqXIow2
	 IhuPZyofMgug+KKyBEAnTMnHIRLtBE5c0vp5KY2gzprlmfpL4+xe7q5+RzxKP1jxxS5km
	 Bbs2K2vtJCYdp4e6uedZGDd0o5sH5KAiji9tACguirG+4VeetmhIFQ2IgwFsxdfcLog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=nq8QtScd;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803E606A8BD;
	Tue, 17 Nov 2026 08:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C803E606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=nq8QtScd
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AH8O9Am8085203, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794903849; bh=w7OTxenFT6A8JYevnH8NQBfKgcuFik3UXOa/tHwcT6o=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=nq8QtScdKoGCetjKtrmu0oUh/WHqPY95XaE7qrOgLqFunCAfszGhVCFm37TQA0wmW
	 EnvmeBjKZbiFof8jOlMMZYAqSKuOA7kJ0zFtTST1o4pch4c49DcuL5T7LTJzL0CU47
	 sE7w6qdNFS+7VfzB1Q/mxVwqbkqmd3oZy7x+OG81aa72RFBI05V07u8G0jcpr1PV2p
	 8HplxMN7G3SBjXex8OLgqpse4PmUpQX6fNEEjxo5fDwOnAG+cxMaHSh4/21B7rz1VN
	 Mj7xyJTTPMjq7NKjeeGqcl2od1oxl8VPt35kwNs1pAPM4s+7+yp5ui5RK6R/3bc0Wz
	 43uo5kXXQmPXQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AH8O9Am8085203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 17 Nov 2026 16:24:09 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 16:24:09 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 16:24:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mauricio Faria de Oliveira <mfo@igalia.com>,
	<linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Po-Hao Huang <phhuang@realtek.com>,
	Kalle Valo <kvalo@kernel.org>, <kernel-dev@igalia.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mauricio Faria de
 Oliveira <mfo@igalia.com>, Luka Gejak <luka.gejak@linux.dev>
Subject: Re: [PATCH v2] wifi: rtw88: fix skb leak in hw_scan probe request length check
In-Reply-To: <20261116-rtw88-hw-scan-skb-leak-v2-1-cc9644774fff@igalia.com>
References: <20261116-rtw88-hw-scan-skb-leak-v2-1-cc9644774fff@igalia.com>
Message-ID: <4f05b7e9-211f-458a-a73a-8b4708317f9e@RTKEXHMBS05.realtek.com.tw>
Date: Tue, 17 Nov 2026 16:24:04 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Mauricio Faria de Oliveira <mfo@igalia.com> wrote:

> In _rtw_hw_scan_update_probe_req(), if the first loop fails (goto out;) the
> skb is leaked. It does not reach kfree_skb() at the end of the loop body or
> in the second loop (out:) since it is unlinked from probe_req_list.
> 
> Fix the leak by calling kfree_skb() if the first loop fails.
> 
> In /sys/kernel/debug/kmemleak, after simulating the failure:
> 
>   unreferenced object 0xffff88810965a000 (size 232):
>     comm "iw", pid 4729, jiffies 4345008185
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace (crc 20f7de11):
>       kmem_cache_alloc_node_noprof+0x302/0x380
>       __alloc_skb+0x74/0x2f0
>       skb_copy+0x57/0xe0
>       rtw_hw_scan_update_probe_req+0xff/0x230
>       rtw_hw_scan_prehandle+0x4e/0x180
>       rtw_hw_scan_offload+0x186/0x1d0
>       rtw_ops_hw_scan+0x61/0xb0
>       drv_hw_scan+0x81/0x130
>       __ieee80211_start_scan+0x2e0/0x760
>       rdev_scan+0x42/0x100
>       nl80211_trigger_scan+0x53b/0x730
>       genl_family_rcv_msg_doit+0x103/0x160
>       genl_rcv_msg+0x1b5/0x2c0
>       netlink_rcv_skb+0x52/0x100
>       genl_rcv+0x28/0x40
>       netlink_unicast+0x26d/0x3b0
> 
> This leak exists in the first loop since the function was introduced, and
> still happened with the addition of the second loop, in these two commits:
> 
> Fixes: 10d162b2ed39 ("rtw88: 8822c: add ieee80211_ops::hw_scan")
> Fixes: d95984b5580d ("rtw88: fix memory overrun and memory leak during hw_scan")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

432441d951ca wifi: rtw88: fix skb leak in hw_scan probe request length check

---
https://github.com/pkshih/rtw.git

