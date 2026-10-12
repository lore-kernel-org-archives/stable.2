Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9074394780
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791775525; cv=none; b=TXd6hPIUMnrTrMl/Np9zodX2Sw0wrhdFFn116Dx3TYt6QE6GTERsgzbo4vD0e+6ygwf7X1t5cXlihF7qA0+q5ca/8gXEX/V+V/Hz+Mltca1tjAVWft32NjhsPeya8s+zPibw7/9AhSSaS/qCFGkjaTnfRakoe2leiJc8UuEx+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791775525; c=relaxed/simple;
	bh=/zdr0vI7bXYxk9EbrqCZLSzg1E+iQCzgXuNOauDgcec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7HnPbw/33rlZV5FosEx+gJ9bF9X2A8MYlzkrR9JjZwLRD/1h7GvtKDWE1AqdlpyQ2CCN7XkeKm3JfAeEMCRnnM+QJTRz3vhCvuUC6EcauXIXszpIPLgZJXw+42DqWeQy4c7ep5TosxR8vyKHEKrwqtBO/xwHRgcX8U4gearGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g41ZX1jf; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g41ZX1jf"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33e623bd651so162777eec.0
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 20:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791775524; x=1792380324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/zdr0vI7bXYxk9EbrqCZLSzg1E+iQCzgXuNOauDgcec=;
        b=g41ZX1jfVmF5LLBKZbkfRBecqfzICZj8Tu9IendGgPZ3xZqjp2N3VtrqS5lMHtEJOT
         c5dUOc2yBAvuM9uq7lhOPKqJ7pVpK2Mk4cwErbWafMX9RxYKJn5Jhdbaw7vXMGMOeTe7
         v2cPP7afGRm3h7Kl13UmLTOp9I7ZmqgKnhG5Jr5xmKfG1uiQjD8u2ymM/JuPo/rtVWQx
         PBAGUxwggtXiKspLDVaoyFxV9Og81GB2dCvQujp6/cgNgtGCPxo43RC55K0cAuHu0yaZ
         D4layb1VjGSfwl+7b9RDV0+ESo4bK8ltPgciIDaxQB7Z/kQD6dzh6kxnK7MJdjLcsTrE
         omNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791775524; x=1792380324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/zdr0vI7bXYxk9EbrqCZLSzg1E+iQCzgXuNOauDgcec=;
        b=uZS0C5NWWcT8dxKDMU2P3+k1Nf/VD7+TSXIfHMTOlvhdyJSUCxtD5XHZPSCBnFrNkS
         k5xfqxdrp1veN7R/MZdzn0d3XlAsDHl6Z0MhVI4PxFUqWCtvcuuZsXcYI7QpvPUY4cxg
         sTifM1eQoGlQTQAWB44/LX1qwUxOsOY43goAtU6c/BBuxSzmGQlG5FMkRkSGIBKZWjjl
         uA5eKHZ5AJVbdLOA4xT/S9MDRulC0t0CpKCZ4V3VQNwkgqqYxzYl2LpTT8/Ca/ZM6U4E
         mN0jxyFZNI8e5XN3z2jqpNbuaqKX0HBjVW6xZrHfeJLxAM2+Eot0lkmkJsJjkWl5enEP
         xxSw==
X-Forwarded-Encrypted: i=1; AKwUvBxfH+CIvRISmozavAbliM7YPm/56Bo0m2AJqWcJysiXDT2Dm9O0wW43zpUL2GZhJUxnbmNQjh0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkY0YAlmtkDMCbnuZAtaglUlkkGWPF0e+PAFZU/th1JptudBEP
	Dn0BNYoc6VtSDpYiAD29AyYpfa4GNZrXGp85c1QyvOtsXW5u2GhiV1y6
X-Gm-Gg: AYBFou1slESZQE0t7yHJAJdpu/bK0DpEJNLhRIwPC690rj05Ur6WXC2w5F8NKnMXgRv
	sWSkmiBLQ93l+fGCeoNnRG/rusT1uYI2GV6PlupKya0tyZ1VGlzofxGapS/iAii22BhDdnAHIHP
	EwzI56a6X/YtUt05S7hWRYduoQNWXnztvfFC7pHu3UTCUSAk37SGKj8Mp09YT1UbCaOusajlrPM
	/Ntwr5tzcDw8TNrWPEmMHm1nOixvWibF01fN/TD4iUgknXIO2fqzDBn7Ii86Y5LEinUvL18R4/c
	FR41y4tTlC0RzbmAUkZLl1DHMg9Iov0PecsjCCJbFcwX6GJ77A14w6xESSIroOHnkKJdjQOfiyT
	V4/ZdWokXo+KSGvMvYPOZKO/I8RnXNVxYmK++lrNotOpCrgF9C3k2lJd2DI7wNcBz30Lf82W32t
	fv+iw1D0NEYrIcBjVXPjJYG4MB5JOaAi9lgMbXNCpfVAl3WMGTDKd6S4GZ07JUAWT7NeyS8VSLp
	4MXQamzALjjkLur4HB+aToW9BpecX517E+M40+RNkPtr8pC3dVLli0CHODMfQkvPG/ri5Xr4cVF
	7M7ku7wCiyPvGAQooQ==
X-Received: by 2002:a05:7301:5413:b0:358:c9f3:b055 with SMTP id 5a478bee46e88-358c9f3b260mr12190729eec.1.1791775523805;
        Sun, 11 Oct 2026 20:25:23 -0700 (PDT)
Received: from cachyos-aura ([45.112.149.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35977229a6esm11708053eec.8.2026.10.11.20.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 20:25:23 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Charles <hanker007@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 00/12] platform/x86: lenovo-wmi-{other,capdata,helpers}: Improve robustness on faulty firmware
Date: Mon, 12 Oct 2026 08:55:16 +0530
Message-ID: <20261012032516.15692-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009-lwmi-wmi-new-api-v2-0-402828382679@rong.moe>
References: <20261009-lwmi-wmi-new-api-v2-0-402828382679@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested-by: Navon John Lukose <navonjohnlukose@gmail.com>
