Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715141DE11
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791107144; cv=none; b=SslvfAXA158k+XX17De0/QNziKgpRQVV8EzlMsRBiJ1eOSMSFccUHTBa61hST81a4wEOVb7aKGFdpExeCJrFChyCUAjC1d6kA7s2ou1DH40W8OUbmD/1Jnmy+RA54B3DcsH4h7p5VslS0MlSY/h9CKuBbLmVlWEwsH+9u5w6YJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791107144; c=relaxed/simple;
	bh=uSpJlr9pWB8cp8BrFmQO5ngregHs2jVsmD4SjTxJsbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmkUcaPTIHvIWi8ydULsU/wZ61N/KuMa3GSmyXMxWUJVU56/Ql4l0a1mlRo2ANLRpiNMMst0sg9BS1uMG0riNP8m1dHtDVeoBi9Vfwdv7LXsm9WY4Vp5MaDlB6LUWQogmB4RWI7r1qheT8oL8ZhUngFMXpFXSTcEpM//eAK5jGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HEsp9s+G; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HEsp9s+G"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so251628a12.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 02:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791107137; x=1791711937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KxK826MAOAYwXMvz4tvmAzJFT8E/SsdJVdTSWQcGqO8=;
        b=A5HyFHmDC6N5K+JtJPFdoi8N/fpv4RmdDvm2WYwV3hx5Y6kmzMJfR6dHtSwMYuGwHv
         L/KpgiAICftC6wrZveKHVcbG6I2AsJqV89ucf7Lnyb3Ps/380qajiWTwhf26S7Uln8S2
         S4rIF3PKzFiG+WXgMNyVv0kb9JfrKbiWsrif2yg6uVcvfqGKJ43V1GMEF0JX2kDgRNrQ
         FAKXM6nCqos6ZnMiEmNAeg+CKzoFu0nlO2cyVO8Au0D7HGOm0vxCOvPJDlofKpL1z79j
         tmhoQx2Pb0r9nqp9Wr9hlYymQeR8MSist196NQQyP/QTz6Bs8KqHxJebrcuV5g5lND4g
         /nRw==
X-Forwarded-Encrypted: i=1; AKwUvBwOqG8dICdDwnU1HHGJqdDkgymPj+b5f+pdWaiNoedlIGcTrxthHG7eB8MfLABkqJs7fwIuBT8=@vger.kernel.org
X-Gm-Message-State: AFuF++kJT87HGcQ9e9TUZmZCgfBwVw5JZF2p5Wwy7kh+p0vMFmtA6x7y
	QpeJvj+zXsZqS+rD43MgSseXd7AEAGhDrvdsVn592sYcCry06Zz1eghjZzmyq0xOcahcTUc0IS+
	Fe6kytmwknmZJY89qrBwdEwbH7quMojdRRlk/GyjEHQFUoywcxEjqQAAHBx2ateczZYZKY0xHOu
	3BYe+Ml0Alyh2KhTznmxRbbeVqSkcUH2uimbwJjv6B/kxst3wYPcilON7dkkVekr6ecragmPBCe
	ow4X8li9Z18vlT11g==
X-Gm-Gg: AYBFou0ey54pqmaz1dHHW/4lQUQkm82r3asnhvbiEEHx6OdsF0AyTzoJSZdwNN2xz/e
	zq8L6smmALzuZC720Q9QrVKI4P8TW5FZws2Ng4jp8thkWbvva+zenwE25NcnwhB5kByJRB5LDMF
	D5go1NVYXZG9G1NHtsH/hRhqKdEiwMLu2axeygJWrTWbYOeyD8xQed/txPqkUezC3YU45zjfdRK
	nK9BAgNSqzpjI0sEGZJyFr+cNvtJ6ShL98eJim88iL+GOs7dalsdCP3yMggcNdwQa1vYWOVJoWV
	KauWb2+ien5kUv7qS9hTcrgHDPtIPNQbAb3L6q/5fuE36mFUYduZyCsW2V36ZHZurW7cKYxcnCp
	ekLPlgTBfqSMC+Gl3soYqsLhtmn5nF404kAEF4P+oNA5goNILVAMzvmkhq8lRQiBP9NCiHTJdwi
	fiCfX7eglLFGJEcER4lx+sGdmUvrqBEwkpSjEs2WJWtw==
X-Received: by 2002:a05:6a00:340a:b0:874:708d:b620 with SMTP id d2e1a72fcca58-88c63b80948mr3717414b3a.30.1791107137047;
        Sun, 04 Oct 2026 02:45:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-88b0b9ecd0esm1468467b3a.6.2026.10.04.02.45.35
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 02:45:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34d80ca2184so1226402eec.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791107134; x=1791711934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KxK826MAOAYwXMvz4tvmAzJFT8E/SsdJVdTSWQcGqO8=;
        b=HEsp9s+GXwoBW3iYzUzslBstyzxFW/F1yZb+tVyN99i57PETeOk+yU7gkB5DpukJfz
         PZCnVoAECJu7L/aOx3sdLWUDm9RgL2kNLxHUmawtpXxp1JJmaZso07Al/7zQ2BY6Oq/r
         XJ5tdImn22Fw5+9lt8lUBRyyS2R7MroTN1OeE=
X-Forwarded-Encrypted: i=1; AKwUvBwxUJqXj2qwUI8dWwMCHMdhLdd7p+j9+AYcEwNBRSaVMyKikZdtyTJ5eYjS1SSKuxJZtK4BnVQ=@vger.kernel.org
X-Received: by 2002:a05:7300:d509:b0:351:23ce:992d with SMTP id 5a478bee46e88-35123cea7f7mr2847633eec.27.1791107133701;
        Sun, 04 Oct 2026 02:45:33 -0700 (PDT)
X-Received: by 2002:a05:7300:d509:b0:351:23ce:992d with SMTP id 5a478bee46e88-35123cea7f7mr2847594eec.27.1791107133106;
        Sun, 04 Oct 2026 02:45:33 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272f27dcsm3508030eec.30.2026.10.04.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 02:45:32 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Janne Grunau <j@jannau.net>
Cc: Hante Meuleman <meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	Jason Huang <jason.huang2@infineon.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload
Date: Sun,  4 Oct 2026 02:45:27 -0700
Message-ID: <20261004094527.1324037-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260915-brcmfmac-4way-handshake-offload-authenticated-event-v2-1-fbb9cc7ac177@jannau.net>
References: <20260915-brcmfmac-4way-handshake-offload-authenticated-event-v2-1-fbb9cc7ac177@jannau.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, 15 Sep 2026 21:17:38 +0200, Janne Grunau wrote:
> Since commit 416386060 ("Mark authorization completed on driver
> indication during 4-way HS offload") [0] wpa_supplicant expects
> NL80211_CMD_PORT_AUTHORIZED to complete the authentication when the
> driver supports 4-way handshake offload.

[...]

> Cc: stable@vger.kernel.org
> Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK")

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Janne Grunau <j@jannau.net>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
