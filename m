Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABAD2F9DA1;
	Wed,  2 Sep 2026 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788320782; cv=none; b=fJy9JtncVeYhqhAzwpECsUqUN5VTHlfeIxHPuqUQF1x5YHs1TkGHPiOqS2guZseycC5PBriIWjRYMNcMD8FCHn/wY5Yyr7o0Ow9EZk9U9aPCqx4UHqed3qpISEkd81Isb0V3Vjr5OBpTmUSP7WGqC0Lqpxp33J52JKgbqIy2D+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788320782; c=relaxed/simple;
	bh=7XL0uELu7KE+AwvM5tEDDXSj5E+EENqSJUJBeJb0eLU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=U55TXEeHNROLtngS4fOkrn0dUIxob1q/v1GGXMIeMI6dxE+mnRvxkOfx+sPTLeRUqKfuCGXHnlk3gN8vnwk+V+rkZ+FAKwnoLDuWVaPvPpUMpsGBPvih1LkfOMX1YrrNllez8Q9D7yu9Q9IaOpvNMDhx48itWj5bsa/G/mvqffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OCrxIVcb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OCrxIVcb"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6823kAH612289434, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788320771; bh=aKSN6MXwsSo0DN7iEfis6Dsvk/snwOPwksyYBqrYLEg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=OCrxIVcbF7hszbiK1pgxlAq+Dh7nHhRwpismJm5OVhbRCwr2dERUi/fgTsXrGqEQU
	 YwpDjQ3qaPwKU+Rbw0njR4XotHTU9JZevQZQNfYV5zN7vAAMi7CQHW84aZgk4QPegs
	 +712di+bjqo0JTjeIE+pyfBGSQ1WqHSlXAsRFKkqjW/QLszGrXZsKYi3i2vdlBy1iY
	 wlsM6fTk12yenhsc8ZxgcsnLdBrAeSdQCZ9ozzErQdyDqTE5lge3F4zb+SYic8kme/
	 efUkp4R/S4hMfC+U9ftJ9ONom22pT7+IkwW7F7gTrdQAyEANqs+VyfHpiUJ/zexUSj
	 cUeh1TP+/mJ3w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6823kAH612289434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 11:46:11 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 2 Sep 2026 11:46:11 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 2 Sep 2026 11:46:11 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43 via Frontend
 Transport; Wed, 2 Sep 2026 11:46:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>, Ping-Ke Shih
	<pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtw89: cap firmware section_num before parsing
In-Reply-To: <20260825174438.63168-1-acharyalaxman8848@gmail.com>
References: <26bf80f23bfa4fe49183d1f724fffc5c@realtek.com> <20260825174438.63168-1-acharyalaxman8848@gmail.com>
Message-ID: <b8764495-71fb-4c3f-910c-61bd2b030acd@RTKEXHMBS05.realtek.com.tw>
Date: Wed, 2 Sep 2026 11:46:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:

> rtw89_fw_bin_info.section_info has FWDL_SECTION_MAX_NUM (10) entries.
> The v0/v1 header parsers take section_num from an 8-bit firmware field
> (0..255) and write info->section_info[i] with no cap.
> rtw89_fw_download_suit() keeps that object on the stack, so a crafted
> firmware blob overflows the stack.
> 
> Reject a truncated header and a section table that does not fit in the
> firmware image before reading fw_hdr->sections[i].
> 
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Cc: stable@vger.kernel.org
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

273b0a8be083 wifi: rtw89: cap firmware section_num before parsing

---
https://github.com/pkshih/rtw.git

