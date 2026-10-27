Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094090;
	b=MtvlJ+wUFtaSBEn1JfUS0Xw89MxMk4Zxo271zgaScPKktKMEpTasrR2nQi1vRQ2Z4kVw
	 bkKKOCHrFi9oGLIiX/0xs/D06Y2V1Vlg0TrMliD5UNyzMwj7kVpWmtpuMjzv0T6ae4hlL
	 tvDr6JbSDsblkJggrgpuySIlmNEYqAv+uTHm85+ZJ82M+vcj8KYeyYzF4wgqPMKSEpL7r
	 0HUfZdgTFPX5aQSpx81SJ33xfSak3iiYN0O5s7cjKSESgcsxSueeB2q/djFYitdqrIGaL
	 rFXA3VE02hiappioxuAvK/YZcxlkH4Av3noWiDdU204hBalaE/6fpS70r0DOAeN5fxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UDSipwswQiKOFZETfFd0sP/sXqxajC2VdO9O8E2arqs=;
	b=Qtq/NCmy6QgKLOlzQzUBpFrRwjn24HFTgwjPDScp3WdG/PpPslyncJSHia+GHDxPoiXE
	 8DLiROFmJNgxAmRgmGxZACr7aNXaWEVmTYC9sgdNWEsS/bJ1W+E3CJoka+nei9oF3Im4X
	 4phu2Iwb9DXWR5RMh8RmGfROAC9G/5/iP0I8NtJJwAzZDYLYejqiCzi8KFIgG/tqzT5C7
	 cOtd/h6Dfh/qM1bpI+a6tVUkJBrzd2pbiZkA67o/8c7VtrOF95c5GGWIbAATvsdJTxFzn
	 lgyK5MKi0N1WTqzyNgRRJpEfGfF7BPAlU7cMjagNk9qvSvvtYppF65sLzM1TBKHI3Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A8J8lbBW;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E437606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E437606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A8J8lbBW
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36661f953e4so7193508eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793094089; x=1793698889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UDSipwswQiKOFZETfFd0sP/sXqxajC2VdO9O8E2arqs=;
        b=A8J8lbBWFpci3PVBaMCaWnW5Z+hQkw7snfrchHPOGAZXAsrJkFuyHLrU5uhLycHaLx
         2FK8TAA3hEU/4+CnI1/oON1dEZfa/TNTYleoytAZPjl66uMgDq+1Mj1B6uog+HJIns07
         hHf8LQ6C/l2hoAKOH+qZR4IeQ26/aaFxKELU4aGzcJzpT+705p0t7BL8HVq62FgBvxcK
         GrItPLBJp1K03l4O6ZCOTf0L+/fA/h4xkIQbtXh9mNzwWIaFUE1Sv40TASNr/0+6bp70
         bJcSEa+7mZXTljgsNVFkLrwUNVgzJguaviKD1MOVL14KOxJdIxjgu5In5cnK/qzC1YPA
         fgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094089; x=1793698889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UDSipwswQiKOFZETfFd0sP/sXqxajC2VdO9O8E2arqs=;
        b=SMmZOfbQzx7uAUCTwD0hAsZExFB6cgOM9wuIstTWtyZPsh5a1rz6OYGmAmXerpEN6q
         GyhPD45b0shDl6a1XpbffLSzBUEEEcIRygXAGbUKwmUTtPRCJ1tvow09vc3l2uMbqZ58
         uHy2qe+tlqqFSsldfHLecQR2vL5ddj5NcjaLFoFgHdJP39xQZXQy4PfVmGAP4dVvDUCp
         Zrz6oG6rx69Qdwc/IDXcx2ovR55yk8WkZ2pX9QCL4DndCgxjKgifkZ1QA4UhTmmLPqWK
         ibhnSGba2bL9KzIMBPPiv5la2GjyM27PeGXIP9n8uXCt7y5jppUlfgr/WqZ1WbN7TJ0W
         FTkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxw5ZOeeP7wcg60oZOjYwzVaXt8htWdoyt2csTmcO+GPvgztN0DNCmQUSzlD8X6Od08jKYdD6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKEuZ04pkEiLYIkrGundbh342TR87HvriF7uzWYvLzrC0VaaYY
	ACz4ULwBTN2wxSvGyOxi/JQ/A1fUsCXkzF2Ee7q7WpYCKtK/PzA6lBJe
X-Gm-Gg: AYBFou1mbUcgCXhFOapTYMVMyTNFmVXHW4+MG5Vi/uU9xz+FU/JUotuzFYPzUhKETMy
	cSqGRGcSAKug5GuWYTETTj2vK2d91zqzLFlLrGKLQBsjh/HXF3+4lBJ1lic6OM89P94dt9WEQId
	CN7FiP7PJ6/ID9IblFOADOer1P1ehR3waJbxfhLmv2mve2z0Tr2/nLB8UpGn6nY0XLU0zPF8C5X
	GrzOrHSnzS6mwpC10NmdgkDqUC5udmc6hmRxwXuYPe/gckZo3h1kLep615CtHS0CAYB1kRJ3+Vq
	W5HtoVdsQp5ztferSJ2c16pt4fR6X7UxMX94kKWCXwFjEgZ7JCWErSm40p4bN76B7zsEkctO/20
	mBF4lpb5TQoH7iuxhuXMRbMmdbeOB82Xq6fZWWV4SmeRvO2DZ/WaWbVg9J4isy+dRCkOwx0UC7n
	+27SS18AfhRKg27N0k9diqRHZisUoy2PXkHtWLjEE71ICbFeALXFr4+FmZSpu9SxoTnKkujTjVh
	PZlupCPnzpfdaFo3Udfl1iV32DQc1w9ADIButbpyfbfaGsMyrIf4SVTMIt3JkDn2dNTm09RzSd9
	vPFX5OQRAHq/LpUxu6YQh/DCOCbPtVJRQQX+f9HSghdD7zYq845fsS3u+lU4DfglOOoa1Uk3C7V
	IGtCx9m/WYs/h
X-Received: by 2002:a05:693c:87d7:10b0:366:83dd:46f7 with SMTP id 5a478bee46e88-369e84bc5bemr13599484eec.17.1793094088758;
        Tue, 27 Oct 2026 02:41:28 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm60208024eec.23.2026.10.27.02.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:41:28 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: even.xu@intel.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	rui1.zhang@intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate GET REPORT response size
Date: Tue, 27 Oct 2026 18:41:24 +0900
Message-ID: <20261027094124.223069-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027025820.3085067-1-even.xu@intel.com>
References: <20261027025820.3085067-1-even.xu@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Even,

Thank you for picking this up, and thanks to Rui for testing it.

On Tue, Oct 27, 2026 at 10:58:20AM +0800, Even Xu wrote:
> -		qsdev->report_len = sizeof(body_hdr->content_id) + input_len;
> +		report_len = sizeof(body_hdr->content_id) + input_len;
> +		if (report_len > qsdev->report_buf_size) {

One question about this bound. The DATA case accepts a content_len up
to max_input_len, and the GET response adds the content ID on top of
that. A GET_FEATURE or GET_INPUT_REPORT response of the same size then
gives report_len = max_input_len + 1, which this version rejects when
max_input_len is the larger of the two lengths. v1 compared against the
allocation, which has the output report header to spare.

Can a response that large happen? If it can, comparing input_len would
keep the same limit as the DATA case:

	if (input_len > qsdev->report_buf_size) {

Best regards,
HyeongJun
