Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793677251;
	b=zrAR5BIlzumbVWYEl4yZltUcvs5PMF/nVIlTzxDAM6XqTd7eerAr6+CbyaRvEpCx4QjP
	 FXjH0p1nuPNSCTXMVcYLt6MxZrW4XGugDHjT5RnRrUqR0Iyrnh31HD3Tr5fqUqZ/FOn/i
	 u1/B5wAKNPJftqiNKWYvF20H3L4UxvbdlVCsgYqZFd8vc8+gDAcaP52tZ73KnZt9g8nuX
	 gSOiduCUFGH+wEPa23YkZrYgYTDrIcIxVWj8M7lw2lYXuyqgqJfTGVX05jeUqMgr63H+u
	 imULqO6/w/0C3aQ6osz2amRu75rzqYxPEklw6S5iCaTbov0S7POfEzhToqv0fxkVS9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677251;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:Date:MIME-Version:Content-Type;
	bh=HodTozwawD9j07WmHXhpT9Uy+aGkSUigiAybYEm4Tyc=;
	b=F4I1D7YA4C0qPDUyk88C43ecNWY9AHmzWn7m0e73OCTOsSIDzO7LUYscoS5xVghpIhRt
	 sDWlh4348ZdzWkfUIknsgOegMEsXxPqrrciNa783IZKD46CeUH2g1nhh/4qjblC3Lw/X0
	 CLH5yx9Alnwb90SUznKiCSs7LC9hYHWmwMjQOsyiEh2+dLhSKujtrtQoC86wE9yoLfcFL
	 S+8NvwOmwFovdKIaj6cZxBM8iza1TkOmkn0zXcHbFbNMQx6OpUzymZx/dq1DGrh78nUy9
	 HbskzAU1jO567mIutBE9ob93+oYg+JihU+Tg/dH1hM2fxhqmBRVXwRDwGRpKWKYHP+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=fZTdKQOJ;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE9606A324;
	Tue,  3 Nov 2026 03:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15BE9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=fZTdKQOJ
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A33ecc872705184, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793677238; bh=HodTozwawD9j07WmHXhpT9Uy+aGkSUigiAybYEm4Tyc=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=fZTdKQOJNPpmX5B5vn7vbz10rPnNlFERaOP8rokIGPTj2QFPPwm5C0nGBm/wRIjJu
	 mgiCd577ULPA6q/fOS44FRvHFZ6m8aJI642lhVrOmn6A9I9UfHOMvqF1Be+1TTlWkR
	 G3hPmEzxZMnH8pqAlkm+vXOTyJXSxxR96+FzgaVd6i1Rg0Z8Pd+HXXwRxLWZYEaoZT
	 f8ePDJpNeFC1PGjr24lZK8uVUjSeEitv+1hlJW0cF5jhUiis92D+MrsqKNn9HAjyZ2
	 zGVdKoMqGIPMgrpWQL6xyIHTplYxNbxduK6Qt4nK8HqTLI6wLTtS2O2StSosAw5/tm
	 n3/l+AmKiKGNw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A33ecc872705184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Nov 2026 11:40:38 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 11:40:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 11:40:38 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 11:40:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Devin Wittmayer <lucid_duck@justthetip.ca>, Ping-Ke Shih
	<pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH rtw-next v2] wifi: rtw89: debug: return the error when a read handler fails
In-Reply-To: <20261019170120.726156-1-lucid_duck@justthetip.ca>
References: <20261019170120.726156-1-lucid_duck@justthetip.ca>
Message-ID: <4f4ca02a-3d58-4391-9efa-6c82b708efa8@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 3 Nov 2026 11:40:38 +0800
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

Devin Wittmayer <lucid_duck@justthetip.ca> wrote:

> Return the error when a read handler fails, instead of passing it to the
> copy to userspace as a length:
> 
>   rtw89_8852bu 2-1:1.0: invalid read reg len 0
>   usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-8k' (offset 56, size 262144)!
>   kernel BUG at mm/usercopy.c:102!
> 
> Fixes: 831cceed3baf ("wifi: rtw89: debugfs: implement file_ops::read/write to replace seq_file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

cc595477e6f8 wifi: rtw89: debug: return the error when a read handler fails

---
https://github.com/pkshih/rtw.git

