Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6CF26F2BF;
	Fri,  3 Jul 2026 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783046705; cv=none; b=QN1JoP/e35WiZmqs1eFp8kyd3r1etNr120hP8jrkjj04KJCBrlTm3xZS22gfgy/wB2yqtchoUywj5uG+ZWiBKLT8F62R7qsfWFqh6ee9q/3SKP4SJcp/TdOqu0EbeO3HqBHv5cY6vQe2rbOsAklAvkrTbewjAToyx/BNhzZ+vzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783046705; c=relaxed/simple;
	bh=+ipFK7NMKr7Maaq0K5V0f9gllGUqvQ7tq7AcD65gbqE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=FDdV6OFhuqn8xhTzuNv442brxTK7lL9LwHpAFF1CwopXIfOgwLilMRQgQ2xTF/bqYoMUE+7p3ksoV3T3ujtiZesv0lFbByEEExlrZzTpIMfXEFlav5/C/K0lcWYNovtVwpFTHMQ0x1SHBvaPN2mU6MihRg3l091b2fILHvVU8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=luDUukNV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="luDUukNV"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6632ixXeB2396962, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783046699; bh=lHF0dtg8uJynNxW8LUjwwm/P2/JGBjoVa7D8lnTSxso=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=luDUukNVIGED55VKYpCU5kB3UXyDQ5r263yMAaoT1TSkCl1YJ1sTJpSnmGUO4YvPB
	 Xk4o2HKfa3g6V487ZTZQfsBsJ9s/Tz5BcaPGOkJW5RnSvRPeWgOtKvoGyP3Fp5UYN8
	 xvldyCdkcd8j6+Bwi+cLtRnxRFk4xgESIkj3rGagTJ1iTY2Lw2yuMoDr9+VO1RTjdK
	 pv1ET2r139V6Bacn9/qhJUGI5oKeKbPt9bglv6tWNhJv0AkubzqRy8qXlPl/h6yJjk
	 8fcZqxmwiGa+C4CpsNeEMEXxZbsi1sxbnm/cnqfcIGzybq/TNpZBFd0tfkx3R3pVNv
	 ro68tmlxPCLNw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6632ixXeB2396962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 10:44:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:44:58 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:44:58 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 10:44:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Ping-Ke Shih <pkshih@realtek.com>,
	<linux-wireless@vger.kernel.org>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	<linux-kernel@vger.kernel.org>, Runyu Xiao <runyu.xiao@seu.edu.cn>, "Jianhao
 Xu" <jianhao.xu@seu.edu.cn>, <stable@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: rtlwifi: rtl8192du: check QoS TID before indexing tids
In-Reply-To: <20260620025632.46206-1-runyu.xiao@seu.edu.cn>
References: <20260620025632.46206-1-runyu.xiao@seu.edu.cn>
Message-ID: <5d4f27ad-124f-437a-8010-7390ef0029ff@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 10:44:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> rtl92du_tx_fill_desc() uses ieee80211_get_tid() to read the QoS TID
> from the 802.11 header and then uses it as an index into
> sta_entry->tids[]. ieee80211_get_tid() returns the low 4-bit QoS TID
> value, so the result can be in the range 0..15.
> 
> rtlwifi only allocates MAX_TID_COUNT entries for sta_entry->tids[], and
> MAX_TID_COUNT is 9. A QoS TID greater than 8 therefore indexes past the
> aggregation state array. Keep the default RTL_AGG_STOP state for
> out-of-range TIDs, matching rtl92cu_tx_fill_desc().
> 
> This issue was detected by our static analysis tool and confirmed by
> manual audit. UBSAN validation for the same bug pattern reports an
> array-index-out-of-bounds access with index 10 for type
> 'rtl_tid_data [9]'.
> 
> Fixes: 8321424134a4 ("wifi: rtlwifi: Add rtl8192du/trx.{c,h}")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

ed4f05d9f2f4 wifi: rtlwifi: rtl8192du: check QoS TID before indexing tids

---
https://github.com/pkshih/rtw.git

