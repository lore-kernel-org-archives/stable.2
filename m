Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4B3431F8
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556429; cv=none; b=bVDpgRZ6K/w4tKt41V6ox5oyomiEPRp0LFXo9YmIRD3F6J0B56ZW8jAPYynbPRU11UJuCD4x59t+s9VczWkc5ENVmiogAo//gBpsXKyRVw2k9mf32ZiCs0U7sbaADhQDrkZ3UoLu2VswblSGsdmwRIvYaEAuH/nC3q3DUGtS/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556429; c=relaxed/simple;
	bh=EJiXm8Dsks2gupnzl0q0HhcnmSRuHBlBWdlylLjcnp0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YPNKOy0ywExG0q+jdQjWG/jt5/CEb3FNgwbmv6xZ8bAsz7wHDsm82IRxxmfb46uAZcu044e9g6sBePtBr4uI6rsusIHyXEUFSWFpRvWGt21B9XEnyyW57UvsPXlp79mksdUR7f17eVGlN2Rvp8gv9JP8hVPlUboQfdBd7SADheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=zX1mcR7h; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="zX1mcR7h"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33c2520ad38so10064949eec.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 07:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791556427; x=1792161227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BmVCNkG8K6lMWvkOR5yLGM5dHZ5EXwHVBaE9Y4/+eeg=;
        b=zX1mcR7hUXZtG+wnRdwWiw5ltq8CJ/FzijDIZ394BtSI6fL6cZpC2xiF+biZZiWObr
         2eH6lIp3lZH7fpP87uDt/xhxFFwwvM9E1NDZfShEFpJamHOhoQnl8tEYEthr+zs15y8a
         C0+3ynZ67KnyIcswG06/lEbVXJw0HQKpr1rYHiI0SV1AK/eelAleYTWCHD1Bw68WkDC4
         6/wh1XPudM7NlGcWQM/8uKVTY1TA79LknR22QIEI/FU7K0ikYieNttKDHjNoUX3fVHY7
         9xkGJ48kc0ONBTW5rKnaqUgy6zCH949mQKV/VnBUUikWGFId6UQgdW32Pen509jmOXBa
         s/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556427; x=1792161227;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmVCNkG8K6lMWvkOR5yLGM5dHZ5EXwHVBaE9Y4/+eeg=;
        b=YNcDlQlU3lt6V5BounXRlYTWSCath4LO410h1iVLsnAZ9vYpySEXRKPqouaGh0Rt3L
         e45wtyr+YXC+vvYBVOH2eYD+ZeaNWNfM7tyRQ0XOjmBmMIaFL7ukV+Hm9xmYCF10PrQ8
         NmMkqJRRM199UOkSNHK9bl6M7QKmOz63sC830XXvm/ByNfQbCSJvFvXmbG/k9+ffmI+T
         54MW/3olUr1YjM6+bjEndV1hYXORorabMzlfcarD1W8d3jUS3YVi4XZw5LPLnNSC+uue
         Iqeu89gh582iDSeMqoUpf24tTNmaVN8uOW+hbUqanTUb2IB3hL2aUgBfDwQn+qUZwUMD
         2Btg==
X-Gm-Message-State: AFuF++ncHTWUl7CH7wO2431LDrywKrhIWoB8fb5AUHRyHDPW59tRpnCZ
	67N5QEradQvhcK9gC/AVrCpyM3pHST299ftCxY6o8UiQLdtMPegEQJRMHQBy21KLvDaSLdDJi/X
	YRq7MyEY=
X-Gm-Gg: AYBFou0rdq6gqED0L1qi78cg201onQAWmfxm6+B+Xc+uKavZbtIlwUL4NJ2zTKzDbiS
	yA4oAO9By1dmFEuV72ePjfd82qxcBFPfclzf5wcTlcLjQ/y3y+fuw1iN3Oi0esX+PD2C9eTWzck
	9PuEaelxHXzIuuYk416Silo/oDn1TMz89ZLF5Ronekmo+aUV5zdb7bXrmHRgepEIzfnmQLsR561
	atylZxyUd/Wlaa2/5EWVHqwBIM4GavaUnvhSaJfQqP5IzeCakM5MwQZ7bUjWdxbM6PtmdOD8I9L
	WgsCWfQzUiKrvCG5Xe1M4EUQrh288V/E7JzWWxEZoNl9nWo3TB8R/Z6yQ6f9yK+G+x75CGu86Hs
	tXQaakRzH2orWugYrDG8EqLy5dh6u2ajqzMnHIh5q0EpQ3Dbc9Q606qPW3VvXTawv+IKybADdc9
	RO9lp7c/spFqOtoyqGFRqu0lowpiLRQVoOGwDzBUi2EsvtUZJIVRuK1LrUp3wNXSREzOy1PdHBE
	NMGEklIoKUQ59pvHC9wkZZBsDCjgHpHNO3k0liCZan0PzD+Y4PnDKKtQliYUdVEQMVe91P9STc=
X-Received: by 2002:a05:7301:1929:b0:355:81bc:567f with SMTP id 5a478bee46e88-35581bc5872mr1019837eec.25.1791556425727;
        Fri, 09 Oct 2026 07:33:45 -0700 (PDT)
Received: from xps16.local ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e05esm8003444eec.25.2026.10.09.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:33:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, 
 Natasha Klaus <natalie.klaus@runtimeverification.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20261009133807.730724-1-natalie.klaus@runtimeverification.com>
References: <20261009133807.730724-1-natalie.klaus@runtimeverification.com>
Subject: Re: [PATCH] io_uring/net: populate CONNECT filter fields for
 24-byte sockaddr_in6
Message-Id: <179155642237.219229.1342920568325633046.b4-ty@b4>
Date: Fri, 09 Oct 2026 08:33:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 09 Oct 2026 16:38:07 +0300, Natasha Klaus wrote:
> io_connect_bpf_populate() fills connect.port and connect.v6_addr for
> AF_INET6 only when addr_len >= sizeof(struct sockaddr_in6), i.e. 28
> bytes.
> 
> The IPv6 connect paths accept SIN6_LEN_RFC2133 (24 bytes), which
> already holds sin6_port and sin6_addr. io_connect() passes addr_len to
> the socket layer unchanged.
> 
> [...]

Applied, thanks!

[1/1] io_uring/net: populate CONNECT filter fields for 24-byte sockaddr_in6
      commit: aa5d5f8e502318e783545ba5d04bb40130b83e20

Best regards,
-- 
Jens Axboe



