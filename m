Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C43DA7E4
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031722; cv=none; b=fdiPN9ssEjmaqztR43CD+XBsUIBBrW3a2Ys8kWwrQGknMUoTKzp3hIc72aanMCmjjv6kZpzzXF/RtriiM6VQ1Uvt4hNJSJuEWvGyKyvunozgnh4U7unc2wdTKZf5Bm7qi3vSucqGKUi+Kd/Bg/EHTDb5zClJYWtqNC4DKLVhcbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031722; c=relaxed/simple;
	bh=Azk9vLWdcFUm0rin/x9F0DNXMUr/g4qM7o/1SCI2+c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qV7H64nUwNk/vjkAsXZtBtAZeO7BPvGHl+0VAYdZJYWyBJhLmBNEgIT/76hjySRAgXbE2KK7vmFutRiXV004zNlS1AhtP2iYC/lQ+Bz/OeXtfdqfgwq7wABCMRNxZ6Vgt9R/zfo/1+wqakEUDUoztl93Ge1TwSPTcwZ3nMpD0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoXKe+74; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoXKe+74"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd60d155070so770919a12.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792031719; x=1792636519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Azk9vLWdcFUm0rin/x9F0DNXMUr/g4qM7o/1SCI2+c4=;
        b=AoXKe+7412efTE3EiwkvFQ1eH6HE8+DIv/au2cGQ+bJsCJCsMy7MqhBT+x1d9NR03/
         dUVVhqiuRoMcUh3VkjX/X8DJr839oZuoxYgPUE2RgQjmh4/JUsQmaQMMqnHBf9yhtqdR
         cwUItZ6bJP7KzS0deSFFEj5KaPugm+oAXaPqAk6rDeAGWOQhW1krcDLHJVjBudpenUOO
         kU2wlQX0ORcDR6LukEdPEv+m6DIIcQj6lxj63U3JP8uJlq9O+gHq0qWUSyqxVYzlXHqi
         1w/e9MuSsYOh3tbDHwEdtc2K2HOpwTPl0YsY54rUT55znrRZYaKTlx/qSuN1/23G1xur
         D1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031719; x=1792636519;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Azk9vLWdcFUm0rin/x9F0DNXMUr/g4qM7o/1SCI2+c4=;
        b=nw6KXESTBiXoCUlWPDVEByX0g/UAuneqRik+NhTIc0ojmDnN7KuTNsrPYN9tvfdQ5p
         0/WV5ZAigo0jpvGzBpgDM1RHUbpo0SlQR6nitmunZT9piRl+8JP6iYzDjLHjJ1uD7Q/W
         Khmqxy3qPnzlec70k962J/qqENme0vAZ+GGo2N6mVVebD5ADDan7/0z4A3Ykytf6KTYP
         Sy9Pjo0nYbv98t7LLRE/kCXe91vTc9s17EXmSFIeD8NRfhKG0Pv7AoWwsEBhGB7VzwL4
         acwilGAz9jlR14Y1aFkxLrtoe27QSu8WEUzUcWlrBV1XbXaNOK7isklXbnjGxfawGtZC
         Wwhg==
X-Forwarded-Encrypted: i=1; AKwUvBzNv/S49lQk3NqD86G93jSa5vNi1tkjug/lQaFxcUhqYNNDgO7aD0BI1LQxAyF8x9BMKebvHvE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ292WFXGHY3pP5Rm9nIALH1kMTyHkfH+jyKeRTikYUHgLc0dI
	pDoS+dKuDvej1/dh+m7ktBt4pympPVEcPZwmpTOMy97f+QDVTbYmyM4I
X-Gm-Gg: AYBFou35ey/LDc11+Le7W3r1/Kk4ybHoS4bUIh5vQDTkhvkcw5mUi+BZqISmlIrgO88
	aTp8kxA2hC/a3orVRa9T88Aqnmro/L5VXuFIKIxQ9BbC8idbo+w4QuJfOpAi6aG04eP0UFHtDiT
	MnzaRYxnaI8MepM2OYA81xkAdYT0nZg6jC7IYmGidwpKoqh+pzO9t5Zdm/Dhz4iquyRMyi6Os52
	pn7KH+Ft0cgabLm8VeYuOhUMFO8H1Ul9AL/s3C9MfxdfkgfLC0YK+GQ6yTu+0LGBpyxY8mo09y4
	tyyNSPv3+GXQd291oaa/bkjWsvo8ZcP8ydAziwjRgWdvslaKMolqsmeTFocV7a6HU+VEv9xKJ4Y
	7EWe/y0VBnNWzshV3lCcczQONOey7EPoZmOscSzWk8K0DcLe4kwLV9fK5k31kqCTeiAppFfYae6
	lqieFEFe3o8DZv2CZlB50TQQ6TdNQ7nX7TJf9N918SRAzQIWyvBPoCTTnJfr6NA3hbYfcCrpQs/
	g==
X-Received: by 2002:a17:90b:4fd1:b0:3a8:5fd6:cb6 with SMTP id 98e67ed59e1d1-3ab39feaf19mr13291631a91.0.1792031719067;
        Wed, 14 Oct 2026 19:35:19 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac944511f1sm2034989a91.12.2026.10.14.19.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:35:18 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>
Cc: Qiliang Yuan <odys.yuan@gmail.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] ext4: fix shrinker scan budget accounting, plus a related cleanup
Date: Thu, 15 Oct 2026 10:35:11 +0800
Message-ID: <20261015023342.ping-ext4-v4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001-fix-ext4-es-scan-nr-scanned-v4-0-b13703714ce2@gmail.com>
References: <20261001-fix-ext4-es-scan-nr-scanned-v4-0-b13703714ce2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Ted, Jan,

Friendly ping on this series -- it's been about two weeks since v4
with no review feedback yet. Patch 1 reverts ext4_es_scan() to the
sc->nr_scanned-based SHRINK_STOP check from v1, which Jan had
already reviewed and preferred over v3's nr_shrunk-based attempt.

Let me know if anything's still needed on my end.

Thanks,
Qiliang
