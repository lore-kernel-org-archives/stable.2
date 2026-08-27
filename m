Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CF3812DB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805496; cv=none; b=ty37yP40PKbrhdlQkA1C5ACU75WP3Vb6qk+woT8mXcs2aodLy92IeG3Girh+SzPieKpK63FeOvHcsjahvMhQp5+gidpQ3N+xqdAwJ9qgLXzA2mWI02z4374QWibo+EPkZVNUqEYYJ2YDgK5vMKLNe9PRcnyoSKCdrD98h7P0bk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805496; c=relaxed/simple;
	bh=0P+Ppehm+2rMxkEV+1Euuypk94PflIXQ90MtgsW7QNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpVxAvtf/UfZJNlkhNr8kxiKx3p6FQ/VBANF7u4t6IUZnt1PUqQSKLddtCKPscPiNc6XMrdN3JNLYybUK76mMd8TWQyRsaHMH9peueefQSmMt8JBnTjWi0cNgoeipCy3CZ1GWjDfOIWH3S7oWosAwM1Wjg7t4QAh9+NDtSvFN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANXRAwja; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANXRAwja"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so476667a12.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 21:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787805494; x=1788410294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0P+Ppehm+2rMxkEV+1Euuypk94PflIXQ90MtgsW7QNE=;
        b=ANXRAwja2tPvK/Lmozql6U9jtUI8WKVTpz5dr0cqfuy+MMN11iGJwcuhGk4hh/guma
         /8imGq/AfwincljYvn+NWp5QX6AoWJqoyMUMfNyXPVdRUWuXYEEwzDRx1E5xuIva79jR
         m2pTsYPeet7fSJAVAtBL+moHhDnMXu5+/HcINAzAohPeRaHZcReBN4/qSFSLY2/Ox8P1
         JaBC1cCF+J+LVlCUeLDn+LuYedX8cbfLE+00D4KDKnV2ZTm68UtjUIeDQAWgKi6Na/XW
         osYrWcy8AJx06h5OrNbEMqe9qrEZ5RvqDgB1eZuSRczHXo/YwXmperkDWAEW4oEm0gsM
         vS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787805494; x=1788410294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0P+Ppehm+2rMxkEV+1Euuypk94PflIXQ90MtgsW7QNE=;
        b=KXiSATt1CucinHYaHL3MxWdNELvIDw1q0ojb7mEHl4VnloibdDC2+31NQ34t7DlGbW
         9h2BLEV/5Dss5dV3rYkWjBesid5xgWeiMHBygm+13hYUUtCY2JN5p72acqG/mNhgJo4O
         VA4mFRgs7NTyC6aZLlsXlqcFKMwyul4Yu60JDCE+wpdzqAr04zJiW50jvr7uhbOWa8zV
         KoOWn7lvkiC/yEKDx4GwCT7G339wffpRdrbBoKJIOaEnSRmIvdCi9u9qeclU5vfQVEd9
         m4r4jmtxDar7AVv6Mp4SRtiez8+9NFRQ9DvsJNIh5Q2XUonhcrdAkBkSWeV97nvmxPDM
         kclg==
X-Forwarded-Encrypted: i=1; AHgh+RpaC2Uf50qoVrhJiXEUhPlHNw0s0fgMBIHrcDr17Vbfk1vJMIp9365rAQ8QxtDNMwCjQoRfGnA=@vger.kernel.org
X-Gm-Message-State: AFuF++mnwj2qiG87yabsfIthThP+B0kchBqetBGSfTwwfiMrYD8N8tYY
	HNhkHCr3O+UQd0Dfo7iyMG/bw2ptU2nnu91FrR9ASjnu1X/lwKh0FnNc
X-Gm-Gg: AR+sD10YuN3haO+oXLTLIgtTbj5i0K+Tgs++tkLn4Zq+Y3qVS7TV33Wu8VJkHFySCoL
	xBJeu/Q+ifzJ5fQaLup+VxKE82G8LXUT2cNAgBAU5q7kW6IUwOFkQ1QTyf25ecvy2KiN2iGiioG
	wvLLaEcyUs7BoKUlNz5qIlKQT1kZqDSbJzUu9z9YWyExSvx7wVck3b12EnHLauyjW1kefmE4GzD
	28ZQsV9ZrWHuNLlUctUU5ESzjKH0UAzTewgHT6woLly3bFeJamtlhGimh6aRjcnamJ2skiEFNmo
	GMvV7+vPFBBezzuwwHUwivA4J1nctwmy6Trs+y7rSW34EZ0SXDSsujfTSfggaoQRfqxxF6ZqYOA
	MQTVk2ieqTqSqloV8/Doguze06xB83HzmK+lXsMJmBg65wVs8aAtxacdn8kG4ddqdet3UW2L3eS
	h0X8mShXUcUEgpOU+nFn7Q/AOiyZ+CIArQ9GckeFTjD9+2wenNoHWb1xx2i2kSTo6etA==
X-Received: by 2002:a17:90b:35d1:b0:396:65b3:c05e with SMTP id 98e67ed59e1d1-3969bb1e82bmr5197069a91.9.1787805494011;
        Wed, 26 Aug 2026 21:38:14 -0700 (PDT)
Received: from Default ([2409:40f4:1012:4330:756d:2890:a615:2db9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3285f3cd3b0sm118260eec.12.2026.08.26.21.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 21:38:13 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: jeffinphilip14@gmail.com
Cc: balbi@ti.com,
	bigeasy@linutronix.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+fd6ef980cf1c722be639@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: gadget: fix null pointer dereference in usb_put_function_instance()
Date: Thu, 27 Aug 2026 10:07:46 +0530
Message-ID: <20260827043746.13087-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816061712.15547-1-jeffinphilip14@gmail.com>
References: <20260816061712.15547-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Aug 2026 11:47:12 +0530, Jeffin Philip wrote:

>usb_put_function_instance() attempts to dereference fd inside fi struct
>to get mod in uvc_alloc_inst() error path. However, fd is not allocated
>until later in try_get_usb_function_instance() after allocating fi in
>uvc_alloc_inst() and thus guranteed to be null in error path. Fix this
>by adding a null check for fi->fd that returns if fd is null.

Friendly ping, let me know if you want me to fix anything.

Thanks.
Jeffin.
