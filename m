Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792474154;
	b=JNlL7VOO0JMyxaO0ubnaNy3+nfuAHIBKVWXF/2ER0oWLw6g9k+B4GpQm97PWEexu38SO
	 SAUcNQ/lXPY3j8Rrw9uPXLtLESfz4Nexwh8S7PQQQJ/dvLH/KtrYy9UhLZA1AMcFnjxDk
	 ju7AuDx6tbA/R1rW+oSbbDuhuUi8+vRVn8gS3wg/aHraz0FgmgdcJuC3bY5SwVPc0pbLf
	 uk1U0+NcH9CWYaeQ+uqRnpTWD97QEZ87HFKmNlYiWpLIFWNmAKK2w6e5NEOijI/hBQI5E
	 0F435M18P4O4eKMde05fuw9B8JPNyGv2g1c3cx+S/qrSpvqJ+1c54+tyjIAwj8kIWgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c9R77y7CmEav0rC77XG2mhErQJ4vnSWiNFq8rafLmTg=;
	b=OD7edNx6Qm8z/s1xA6DFmnu/1mE1b6JhzQo51ZHxxDlzgVDel3IhYuyVqEgdyK7Khgit
	 zIeTvuDFo4pjKEh95yGdRMeWQ1rs6Q9MSlWWSjAgDdXSpx3638M+f8NmBZElFBKlqRKj5
	 ulLnfCIOfuwyue4XlsQRzc3G+LqLaqrXcSnVTfM/lxBgASz2fTYMZUKEB+MurXQMkVbWy
	 +SkIWwM2G7Ckc5isdp5lRelG0v+IUM6mJWLFPvsVDyzPbwAaKIMD5TFtNDlWIHjRFieQQ
	 GzNY5v8OovX+birxKtv7QwsZwJWtAs0+aAxhctPOOZnBg2bj7td5lYYTFAXJnYl95GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IQBUBur3;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F05606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F05606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IQBUBur3
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so196246a12.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792474153; x=1793078953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c9R77y7CmEav0rC77XG2mhErQJ4vnSWiNFq8rafLmTg=;
        b=IQBUBur3C3ooYTg5kvhTecuHSB1BGpjp7yAA0mIKn1KXQvvi8yjEcRmkxmKnWdeE7E
         0wnTYdvYGnwAqgAO0varwi/dIYQYYwS3hLf3CcXVW5HdtDxHqnKocb23lWaeCrUyzVkJ
         V9ibknii+z+WI7x7BKoDF/F29SvU+LcIdoAmsK8L7WcmZWt1ZJB/VGooD2EisfUsIgbL
         XmWCcBxoRhup+qP1okUxUbtANYOkhCdiB1wdmC4hnz7h0xaFqxHtmI5p13UXlGNVD8R1
         P6ePeijdS59iYgsFsWSMB8pgwiovwod371lTewAs2HI3HiUZMDA7nQOeT12z8cOB757r
         9ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792474153; x=1793078953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c9R77y7CmEav0rC77XG2mhErQJ4vnSWiNFq8rafLmTg=;
        b=iIj1V1CYa/s0YibeA0KwS+BSUWqR0hYyVgPCEzH8wSREEb9fq0wqKkOX9sJf3OkMNV
         2syTl2SKGEXnOEFqd6vAbV0cHW97Rv5Qqjg9G1NUdZRj11B0CdZcG9Kkf7dcI/TwMac2
         bB8EGsz+FNe3PXamzd3h8vnKRIvotjqjxNKEbpH2PpkYvAItx2VIdEcJxoRnW5mIAC1a
         4Xvtz4ObleausbaR3085F5TDtwWArVBYz53vGIB0udiV/HMTnNwUb3dt/Y7OE5WauBMP
         o2x8OZoykUBiUTXuxQgFJ5+edWH/V3cWf6NnqHAAX4LOnquh9dDVOC6vL9vdcVvEhx4F
         Cyrg==
X-Forwarded-Encrypted: i=1; AKwUvBzEl2izj7nMnjdjOSX4ch4PySELR9W4Krk7xElSShJk2/T9ubTofOZJmQGnaP0WB6FnNZw3ej8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/7ZknU0m61OXIYy5P+BDGMnP+qD4j0rRu6jSOcBDR6QRvBHt9
	D3CjfsA0OCx8BmK3mzLtNRXFACexWMTxj+pQFASt8XCIE2PQVcmk+EUu
X-Gm-Gg: AYBFou18f051QEJbm+bK9UQi31++G2qpkfqkDAHIXVIfCzKpYF+T/+mFmha1ItRJKij
	Dk6rCh2w54OAnyY+H6dwHkUaNsNveRRItkZd+lTIptd9X6UcYet2FDqYr2ktVRC6y52CTZRPfGB
	ZlASpnFzGRhZuMM6+xwMIxSX2/mVhDZou/RwEBGw/Dnxo85BU4z2JGx/O83nVSytgmhPkmirrzA
	OOqdARPo1WVtwY5AaJpUh9oCRUKdwxdOrMsM8HwD6PpQWvb4Tgi2oNErKQHFzI1rCvH/MrC9hKr
	E69m3nWb3U1FkHQ5yWfyG9Fcj+yeq6dEYXzbYTBvbukTAfJJw2hb8z6C96/QqWV4Sa/qismDkyx
	vtL9DWKVgd5sUGBHAwdR/xp+SUVycRajW0tBqa1apsM9JJ8Yv8kHPK408UYXZrOTk6wHw+6eOYz
	oG+lZoYkJZepXkFz4LMB4Q70CFkZeLIKNRzZNEpZepk65sXgNPbAXeoIgeb2OYibTi/9lOKpY3Z
	Um9
X-Received: by 2002:a05:6a20:c885:b0:3de:57da:7fa6 with SMTP id adf61e73a8af0-3e26fb93cc3mr773371637.39.1792474152912;
        Mon, 19 Oct 2026 22:29:12 -0700 (PDT)
Received: from hachimi ([101.5.175.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654eaf4e3sm4406759a12.26.2026.10.19.22.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 22:29:12 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: hamzamahfooz@linux.microsoft.com
Cc: airlied@gmail.com,
	decui@microsoft.com,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longli@microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	regressions@lists.linux.dev,
	simona@ffwll.ch,
	ssengar@linux.microsoft.com,
	stable@vger.kernel.org,
	tzimmermann@suse.de,
	xlfylawarthur@gmail.com
Subject: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Date: Tue, 20 Oct 2026 13:28:47 +0800
Message-ID: <20261020052849.9241-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atZjtSlZAocUWYBS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <atZjtSlZAocUWYBS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

On Mon, 19 Oct 2026 14:38:45 -0400, Hamza Mahfooz wrote:
> I actually have been working on cursor plane support for hyperv-drm.
> I'll post a patch soon.

That will be great. When the patch is ready I'll validate that the
problem at hand is settled.
