Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E31F942;
	Thu, 30 Jul 2026 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389978; cv=none; b=Fmsw1kXHUKQw7h4csna9N08VtQvY0bJqjIXT2GvKIiYzEMNsktBUC+rWxYCeBXAtv4xqeNB0pDzpB2R7qCnyA8w1/1x0BHciIwzx25O7OGk/7yy+iJEKiDQZPScTvdTaVxZHvb5Xd1vZPGmAFm4TKbnGQgV8o2BcYrpkptUqSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389978; c=relaxed/simple;
	bh=iejjyPrmNhE06apCLSgYfu9JilFFitAJr5pfimkOBTY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=s+NthQW3/+XW43lVc2ummelUCeoZULB3kY0onD2W+6Dmp3hUXJbdf8B02+07zytzpI/AYXxz1JjDMGpj4lCVF1n5vCLcJmkMCRUuiG2IyLD14ymMT5qcMMaB9waJK+zf7aBSrrF3J7o19K7ksI/iDF8+OV5hNZ8DEPHCHrct2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RxkW9ESn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RxkW9ESn"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66U5dW311970765, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785389972; bh=oAuAXm/tIjqUC+juPvjyJJBAbcHsMFfVRTRXVtrFo58=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=RxkW9ESnnBS7YSLM6ingnToYfpgg66XQjgQeCKYALlbkdz77jLbbnCkcCftGI0Fpy
	 k30eq6frH4i+ovmGTMdp7UPnutNFk1B19j3mtKZ/IYVt40H3BUMSREzTDiuf8Ubizr
	 YpE9ez9AKAw536OjlPFxMI9/0B8eGealXpCwwXbMZk5sYs5vRdfYocvC36LdiEKIQ3
	 t0+XzUFcqgLyYfA/JdPmn5RDfrwmOBN6t1bbkqjRNXXl3jO+Q0aJDdqEkpGfungyMo
	 vVfLokGS8mVuJmu7l0sjbp48FSVWU6jbEEm4Vb+zzbc31ku/Mgrh8NXVYOAieBxVOL
	 I4/OfIXi+i+5Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66U5dW311970765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 13:39:32 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 30 Jul 2026 13:39:32 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 30 Jul 2026 13:39:32 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Jul 2026 13:39:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, <pkshih@realtek.com>
CC: Abdun Nihaal <nihaal@cse.iitm.ac.in>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: Fix potential memory leak in rtw_txq_push_skb()
In-Reply-To: <20260727064223.61836-1-nihaal@cse.iitm.ac.in>
References: <20260727064223.61836-1-nihaal@cse.iitm.ac.in>
Message-ID: <e7f7b2c1-3469-487e-8968-0d7b3e29b2ab@RTKEXHMBS03.realtek.com.tw>
Date: Thu, 30 Jul 2026 13:39:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abdun Nihaal <nihaal@cse.iitm.ac.in> wrote:

> The skb passed to the rtw_hci_tx_write() is expected to be freed when
> the function fails, but the error path in rtw_txq_push_skb() does not
> free the skb before returning. This can lead to a memory leak in
> rtw_txq_push() where a dequeued skb is passed to rtw_txq_push_skb().
> 
> Fixes: aaab5d0e6737 ("rtw88: kick off TX packets once for higher efficiency")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9f2948010764 wifi: rtw88: Fix potential memory leak in rtw_txq_push_skb()

---
https://github.com/pkshih/rtw.git

