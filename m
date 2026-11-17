Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794902736;
	b=r297MISRc7v1ktJ3S6oIpv2Zd6EyQSDOzI4lybB/PT+U4OkpX9m7Bk2nRU36/9rs5QaQ
	 WL9kkkhjEFwO3hNVmj4Xbbw/7b2nbcmsIRpcUmU/LQlLqU399GuIiMFKv1Yoctriq7Pxn
	 RLCF2Zk56RRbgpQsEOg3LOKfruz72GLWG2lJAjDUm8cCpqitL5QLutn4JPzSk2a8W/bBG
	 vvncWBHUcoa4r5Uhk/aOWImLxBSU3vpOn/rfgz0FbLp/53VggmFyNbtpaVWi2jmqhlF2C
	 1XVHlUgfsbtyHwRe22IRqyWiBlrFYBkm0d8wziogulVdT29zfk1SQNs5kYsd7IBo1qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902736;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	bh=F+PpRDb1ckXESGqfbVD4qYpr7NxHD1qCukQteZyeXzA=;
	b=CbxQFo9+bHE/IPzvtBCHOVPc6bOFwJDll+MgKwKZA0urBcivHoHUOsi3OM4PIjwxBJkK
	 XP63K2AmAR0MuVRR1gx53D4Pd4Bz7LihRZHjyu7QUSi+3wMuKnAdihEQYEFQhb/nB/r0A
	 IGoqk97Dgs7W4SMmIq8FFuO0fxXEKZnSwVBZimc8+fhoAfgflSv1Wqk7XthD30w3b8+v1
	 b/2VduEzT51zY0UpSqTdhZgDjcYzU20CADDz0TNbjD3I4ZIlFWbr/6gK5vhHSn13pMWVu
	 3vq629ZSesrbiXIqJoYRRqnduz3FYo7z/wI1bR/ewpA61sVYm1YxC35uc+jQbMWzfSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=M4ZNd0ES;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7406606A31C;
	Tue, 17 Nov 2026 08:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7406606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=M4ZNd0ES
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AH85CpY4071482, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794902712; bh=F+PpRDb1ckXESGqfbVD4qYpr7NxHD1qCukQteZyeXzA=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=M4ZNd0ESEJZlxzXdMDI7nI/KcAMt0cVfaVUOPILnwop6MG1PH0ent49kcOHzNAaDr
	 DIqzSCpPJp5htEaLchLExe+geNMNsSU3hl61QtGJ6GmeUMppMXmf71l5a9qFDllXUv
	 e+VNcMaA0HTZrsh5tXhzQTZIZTCVtXB1LmStlaQzIfYq5bf1X3o//4qIAYEYfZbDZB
	 FzQw0L2q6TuAlHTA3pabzHNSuxnCbZHQyGsMqS5/nKCC3DBdAUg/I633AsnIUESDmn
	 W6UCOm4EytyiFzoFiD7GaE74TmPEefR8HbRtCN+i8RUm7MZfMwDGfD4amAHlVA+ApL
	 qVO/BqT3gyolA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AH85CpY4071482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 17 Nov 2026 16:05:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 16:05:12 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 16:05:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalpesh Solanki <skalpesh942@gmail.com>, <pkshih@realtek.com>,
	<luka.gejak@linux.dev>
CC: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Kalpesh Solanki
	<skalpesh942@gmail.com>
Subject: Re: [PATCH v6 1/3] wifi: rtw88: clear RTW_FLAG_RESTARTING on stop and start failure
In-Reply-To: <20261113034704.21283-2-skalpesh942@gmail.com>
References: <20261113034704.21283-1-skalpesh942@gmail.com> <20261113034704.21283-2-skalpesh942@gmail.com>
Message-ID: <20df9299-44fa-4aac-ac8c-5010138dacc2@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 17 Nov 2026 16:05:07 +0800
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

Kalpesh Solanki <skalpesh942@gmail.com> wrote:

> When mac80211 stops or suspends the device without WoWLAN,
> drv_reconfig_complete() is never invoked with
> IEEE80211_RECONFIG_TYPE_RESTART. If firmware recovery was in flight
> during this transition, RTW_FLAG_RESTARTING remains set permanently,
> blocking all subsequent firmware recoveries until the module is reloaded.
> 
> Similarly, if rtw_core_start() fails during drv_start() in a recovery
> restart, local->started remains false. When mac80211 cleans up via
> cfg80211_shutdown_all_interfaces(), drv_stop() returns early without
> calling rtw_ops_stop(), leaving RTW_FLAG_RESTARTING set permanently on
> hardware that failed to recover.
> 
> Clear RTW_FLAG_RESTARTING in rtw_ops_stop(), as well as in
> rtw_ops_start() when rtw_core_start() returns an error, ensuring the
> driver always exits the restarting state on error or teardown.
> 
> Fixes: 5c831644e1f4 ("rtw88: handle and recover when firmware crash")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

3f2238709f5d wifi: rtw88: clear RTW_FLAG_RESTARTING on stop and start failure
b719e9bced93 wifi: rtw88: skip already reset station in rtw_sta_remove()
27fdc67865bd wifi: rtw88: ps: trigger firmware recovery only after consecutive LPS leave failures on PCI

---
https://github.com/pkshih/rtw.git

