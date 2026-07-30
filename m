Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498E36EA99;
	Thu, 30 Jul 2026 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785378426; cv=none; b=UKDW3nQedjkIsZ4vTaVhtZ8pSIKlrSxFu5UBldAtY92QaipRz27w0PY4akYdPAO0Di5wtXSw0u7p4z1ez2U4qKqSIxmEYwL9YTiRHQbNsH1iYbPGkBnqHrRf/TfVBHVYhDLww4WgcjlOF0TIUUQ6fZXLyrD5pvBwdFUD4dAvCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785378426; c=relaxed/simple;
	bh=hdr+I5ijQ8u7740m8+ozoeMz11NrjDxVVv5NtiFOmJA=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=XuuklYzCPwK0N2ck6bCQp+EDDeniuXRe7Vr8a5yLJPUxMi8DA0sbBJM+tDOntOunOAVruQST4TCwIx1jHApLY3taEgWcS9bA91iq7qo3I8d+8JLaXu8y0UaEMwCyRpjRzZ7q0nCdUfbJzoipfLTXfEhA93Ba/KCbwklv6TyJB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Im539Gbl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Im539Gbl"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66U2QwpmE901008, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785378418; bh=kKVlt+V3BhNp+dxX1r8VPigS/6B3TjazsHmFAYl98cc=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Im539Gblv/4vf8zpNhP27gtHz1aFGSsmK89GEs0XLxSAjP/dwpSJCtFzzS/JZxKrM
	 aC3rhDqHTI1/nKzA2U//eodB+kzH3JNzXnlQIjUjCxCH1tKTjchnQxq/NfGV+r2w+O
	 iTSEXwBkvAa8kFr1zfmSTNXTj9yDF2o0VyTTt0CL3HyDkpIWpTzb91e6xIA22MapRs
	 +Og4h510gzjCARsFf/0PMD3vv1Qoi1YH1DT3mFcBXXQPX2TjGz+cCDELYGBdgDUl8S
	 elUXJ/txgzZB7+pvwiEoPsnalyXEZ0XsOrHPUYij4K8Vdna0jFVRnRsszhqBQC/oOb
	 PtDXUWATsA9+A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66U2QwpmE901008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 10:26:58 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 30 Jul 2026 10:26:57 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Jul 2026 10:26:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, <pkshih@realtek.com>
CC: Abdun Nihaal <nihaal@cse.iitm.ac.in>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rtl8821cerfe2@gmail.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtlwifi: rtl8192du: Fix possible memory leak in rtl92du_init_sw_vars()
In-Reply-To: <20260723114539.136986-1-nihaal@cse.iitm.ac.in>
References: <20260723114539.136986-1-nihaal@cse.iitm.ac.in>
Message-ID: <694f9f07-892c-43b0-8eba-a884eab2063d@RTKEXHMBS03.realtek.com.tw>
Date: Thu, 30 Jul 2026 10:26:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abdun Nihaal <nihaal@cse.iitm.ac.in> wrote:

> The memory allocated inside rtl92du_init_shared_data() is not freed in
> any of the subsequent error paths in rtl92du_init_sw_vars().
> Fix that by adding a call to rtl92du_deinit_shared_data() in the error
> path.
> 
> Fixes: b5dc8873b6ff ("wifi: rtlwifi: Add rtl8192du/sw.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

6496ce90845d wifi: rtlwifi: rtl8192du: Fix possible memory leak in rtl92du_init_sw_vars()

---
https://github.com/pkshih/rtw.git

