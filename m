Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795320909;
	b=pAW+vYK6CwU3piRvyqiGq2qs0Re+fk7JPDXIaRcw4hdWP2HH4+Qd9fLzeiXSSO7xjOqR
	 YLxpA9gI5O5PTGx9Zrjr9u6mtpvdyEoM22J8uFvLjug+FxKU1F85aIxoDhzd5aQqcE6cX
	 qM2tEyHa4I0Fph54nV5rLGCTVsBDj2OfIon31aFsM5l8s2P0N9y73vvokbE/VVqMGIaUe
	 qpinY7IwrnAtyhDnBPfH7TZLxbmXyNT+FWATV8qWRH0yMNK/GcTqHgvrdzqxIOqE8o6sc
	 sj//ObNIAJgh3wq3l1+NnsuZhVrDRrqKJobiAAoW75gGmBNVoKLsiRUkEgGTDfS14eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795320909;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:Date:MIME-Version:Content-Type;
	bh=xBb72HO1pvi/quYz7ygtDn+gbk+xkVVdd8it6HzzL6U=;
	b=qGnvNSJGXt6FtQv6vVsaVR8tK6VmQWBVlQRKSF9/VmtR0R5ZfCsIDLVg8mMwhtfl1r79
	 60rvkWgzlBQ5SovQ6J6U+eLnQvLy6LJk8TpBxh8G0nkdfPimzhU6D90snCfqzKUvxcSRl
	 f5iOzzg+mAG7SqGrPkR27UPn+crbOuLW5rgBDkpIVE2tAGwRnUzJ8S/5B3Z5ThlIw4lgU
	 Z/3bRG84W6o76tXVn6QjR7INT+e9OEcDk8iztZYheI+Q7kq0OMy3WikOeteImJNNJhduz
	 onwS1PH6OPcbbpenTSjKT8JPnI98CSNhiF7vqOWKEWCsvWjDD4PAAjTiYTztBHB1oWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b="k/3YAR0Q";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D5606A331;
	Sun, 22 Nov 2026 04:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E4D5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=k/3YAR0Q
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AM4ExKO2553871, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1795320899; bh=xBb72HO1pvi/quYz7ygtDn+gbk+xkVVdd8it6HzzL6U=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=k/3YAR0Qg/Zxm1b5TetAts1PRZY82B2iDWKgqYACc3/pkYu7lq1zm1a8JttUsY6Fk
	 AJLHfQ5n3iDU/JinfHov3VfsZ2wA6jxrocM970W6dpSP7wo2xUuF/wngXsdHqpvpgu
	 hYPGsIXEycZARcBG9ADvFYnf/QjeWDCmsg/+GJ+OJ8jGi+i1O7nUHj4UymzsneXoTf
	 KP8xk782O/1SwPsUJLtHqRMJ/hd79lmXHiSVEp7tbnawi/+QcEw/Tizp+DaTZc7U7z
	 +dQQzfuEfR1Buq83N9lJhf3tr4Yftk68pUYNVPsooP5+gW/d3t7d5lgULnVAhlfMQH
	 C1DRexI66oEog==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AM4ExKO2553871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 22 Nov 2026 12:14:59 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 12:15:00 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 12:14:59 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Sun, 22 Nov 2026 12:14:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Enver Ikromov <owner@ph4ntom-rev.uz>, Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH rtw-next v8 1/5] wifi: rtw89: avoid NULL vif dereference in rtw89_ops_tx()
In-Reply-To: <20261119080328.391-2-owner@ph4ntom-rev.uz>
References: <20261119080328.391-1-owner@ph4ntom-rev.uz> <20261119080328.391-2-owner@ph4ntom-rev.uz>
Message-ID: <63269466-8c67-461e-a29b-f64bb0d47f6a@RTKEXHMBS05.realtek.com.tw>
Date: Sun, 22 Nov 2026 12:14:59 +0800
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

Enver Ikromov <owner@ph4ntom-rev.uz> wrote:

> Injecting a raw frame on a passive monitor interface while a station or
> AP interface is also up causes a kernel NULL pointer dereference,
> because mac80211 has no virtual monitor vif in concurrent mode and
> passes a NULL vif to the driver TX path.
> 
> Check the vif pointer with vif_to_rtwvif_safe() and drop frames without
> a vif.
> 
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Enver Ikromov <owner@ph4ntom-rev.uz>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

0202cb50fe9f wifi: rtw89: avoid NULL vif dereference in rtw89_ops_tx()
260247bfbc5b wifi: rtw89: handle negative rate index for injected frames
e07c9af7bbc8 wifi: rtw89: restore channel when leaving idle on non-chanctx devices
4175fc84dbe9 wifi: rtw89: avoid reading seq_ctrl on control frames
92608bb5f14f wifi: rtw89: honor ASSIGN_SEQ, retries, and NO_ACK for injected frames

---
https://github.com/pkshih/rtw.git

