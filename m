Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083973;
	b=dm1Cs0l0t7s0i7x8SSWlVK1wCFYWyNPipdbVQBr69WaxURg23U81imPJceVTvyuCm95r
	 UNCO/kmuPNPJAgC4pOvb2J5Liuid4ldLYY3KcRArnzBiWuqwf+d+dD9NOdnpefw6XNi/J
	 2loN1WjKhu/NRehEPbBgUMD0rtN5xGkxWq1us36EftapIf644s+Iq+c7Rw1rNd6AwLDCU
	 FM5/y5KwR7j90z8VR795nzRFMGZbpWPy8bNWCxKbBoVemHsmIvQlfqyh/l6H26QwlTsyY
	 iW9ysOT4mt68ZYS/ZQYnmj35W/QGf7lR+tYc3VD3748rtD2qB6zreTvk1qbflOcFRqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bcuq2df4LWxKU06cO1cKfQHt7bV53cP3D5X0WMKpC5M=;
	b=h1S8kCcWs/Lnn/7pHsBq1J5RzqCB88odzlrFXIcUVryZe7BSS0tdMI2brzcYfaumxwba
	 8AFP9jJf7X3w1/j38lhFTcQ2UMMfxianNQDu6W2t6N9bK4aTrFtPmiG849lxFid9mNjVA
	 +J8oOYTgLHAR7j/GYgDimakgKfjy0XiQWDbctSvZbNrFqKC4V7SJtg1yFem83ORf0jhxn
	 HRw8B88ozNPQFfM53dxCiZBWnz8vz9Cer4wM5fDw6nOqxn5KR86939EMBq/ANpYoGtx3w
	 xTej8kt8Fh8mqoC+wlN9h7pErOTM7hicichmpUIbfSJO1ghAZhCwR1j9ZWV6oszQ3bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CyVpYmwe;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364C606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0364C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CyVpYmwe
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so20818655e9.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793083971; x=1793688771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bcuq2df4LWxKU06cO1cKfQHt7bV53cP3D5X0WMKpC5M=;
        b=CyVpYmwexZ0bVEp0AP6HCD+adMbpynGOGrPpnbPVqkVSdUknZA4JinYq0I51kxx8Aa
         17jMEtKvvpyf6qJsb+JydH+g0gXGuN+gpDGCPywZi8w7SJkff9cmaY4GUC41TyRl41DM
         qD7lYaTVE+xOke0MyrzHq7xXdStA/EzCcFkL/dhcL1N/yvhuUCMLf4m2ph+ctGO+aI2y
         l+nhpfmo8m0zFLguHtoGeGbs5JAjWoVtefeElI/aiZd8obcTZX5IwfZSSpDP4nTW6Ut+
         b6g1/pCZedJSU4PX0NGcQqJekYsdDn1Fp4Cmw7tVPIdzIn5xFRARbGS3vl8i2WqWWLfN
         vnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793083971; x=1793688771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bcuq2df4LWxKU06cO1cKfQHt7bV53cP3D5X0WMKpC5M=;
        b=Xwo2OY47BI+ujfoZQPU9yaKQbmKOoLlA+ucWVNRdbK/tCGNI7SSWaLWdyi0p7rCACt
         uYPfXNbnWq/KYNckJ+0TK0XwTsVUcaOa4sOgJJIKdJA2CmWugDkjde/raoNdautMsWq9
         FwTQplGiI812wmU7jk7qdGbzD02ax04VGImrGVJIjyXJjPeQnr6QyHZvUxMyjrr9/GBO
         6sbV7/I1SH9iV/v3X6sGVHn4A5in9e/xrlJhmneMEnqOd4gBO+XXkHHRdhauGPLuxdJb
         cjZ/PT2L7ttSRiYMIeFDjZPsNT1yPbhbRmj4E1j3ozN/gw20rU47eQycGiIHMwjgRI3e
         3E1g==
X-Forwarded-Encrypted: i=1; AKwUvBzddfSm6Y01RZQUCCthKajoCto+x/DOvkYYjK90SzJ6rqmrmJo54bVuLdTeXpEtWKTApk97z8I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvxJ29xEsf0VCzE6wP/GRy3bH5CsarbjwoL8J9mssu9yvUwr82
	rca1yPZABaJ1wX1afStXntwTmuQsum/xgWTx7a990tzI1zKO8RwKRjiT
X-Gm-Gg: AYBFou3piwpXbK9x9FLt9eAMTb5m1T+8D/ar4kpVgLVF9QXRwXzGL1V87n8ueIunZMR
	1kWcGBVo9MqekMcfXqP2BwsHuQj/Db/TAWNIOXbs0Y/HJD0Getv7yAg+oMPiO3IWi1gEBsyLXj8
	PxzgOf3mLswaMWx3/XG1dCjish/JRf/LeJRAzfejUQfJNifeXFs3ZeW2axrUwfRINYgxVjk6bgV
	S8rcFPxYZacRZGWRVB2EmY4EhEq1o6+snPVSlqdIHr/jXIZZ2Hrgw/T7WbhuVMnUsPpboguEzdI
	OKfwygBYlf3ZcqJa+v97SZcUs7g4Nxvj0100bqAtWgOYw1yWKIWKLLpI58D427Yn785A4X9LRlv
	TR9r6FBhUMcRRWxNWTBOdEsUc6UlEpVdUWdPopywashIDQOrZA2NCiLE2jZrHd1ylkIK/KtMqUp
	mCEWBAWBXBvpy+b4blPudcd8t/RkzCq/Ir5ZJ0IZ1vic3L0Rr1hxyse5nQOkj9r4igiKWQCia2h
	Ik0gmdgDqPh5MxKrce8cCqWpcz5YF/lY85x37c7aFaDb9C5zVKVBhPzjF7Mn3uxU5p91CKTGYl+
	xgllHg1BJp0z2svi1TbfZXX6yy69PCtXfujYvla9JY2gMciJQQk89mrdxPtRTNNPtmkZT8UDPyo
	GYkYA6GdW5SVQMVxMn7jI33uIKSEZlOchqJyO7LlnkbOnFgzGjv9Mx/ZbzWjf6mgdVadMJTrS9Q
	KJCAif
X-Received: by 2002:a05:600c:3f07:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4a35ac91137mr150192625e9.11.1793083971271;
        Mon, 26 Oct 2026 23:52:51 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2ac-9b01-6900-1f92-d182-4435.310.pool.telefonica.de. [2a02:3100:b2ac:9b01:6900:1f92:d182:4435])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2ed5a2sm259282285e9.15.2026.10.26.23.52.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 23:52:50 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Austin Schlegel <schlegelas@outlook.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Alan Cox <alan@linux.intel.com>,
	Stephen Warren <swarren@nvidia.com>,
	Austin Schlegel <austin.schlegel@arthrex.com>,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] serial: tegra: fix DMA descriptor use-after-free and stale completions
Date: Tue, 27 Oct 2026 07:52:39 +0100
Message-Id: <20261027065239.95915-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
References: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
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

On Thu, Oct 22, 2026 at 05:10:23PM -0400, Austin Schlegel wrote:
> Patch 2 (TX) fixes the same ordering bug in tegra_uart_stop_tx().
> It also fixes tegra_uart_flush_buffer(), which terminated the TX
> channel without clearing tx_in_progress, so a later
> tegra_uart_stop_tx() acked the freed descriptor.
>
> The bugs fixed by patches 2 and 3 were found in review (Sashiko, on v2)
> and have not been reproduced on hardware.
...
> Testing was done on Tegra234 (Jetson AGX Orin) with GPC DMA only. The
> APB DMA driver (Tegra20-Tegra210) recycles descriptors only after they
> are acked; the series keeps every ack but has not been tested there.

Tested on Jetson Nano (Tegra210, 70006040.serial with tegra20-apb-dma)
in TIOCM_LOOP internal loopback mode on v7.3-rc2 (5b0764a53235):

- Unpatched: queuing a 4096-byte TX DMA transfer at 115200 baud and
  calling tcflush(fd, TCOFLUSH) 5 ms later leaves tup->tx_in_progress
  set to TEGRA_UART_TX_DMA. Subsequent write() calls see
  tup->tx_in_progress != 0 in tegra_uart_start_tx() and never start TX
  (0/48 bytes received on loopback, TIOCSER_TEMT == 0).
- With v3 applied: tcflush(fd, TCOFLUSH) during in-flight TX DMA clears
  tx_in_progress and the follow-up write() transmits (48/48 bytes
  received, TIOCSER_TEMT == 1). Twenty rounds of 3 Mbaud loopback
  transfers with mid-transfer TCOFLUSH and port close/reopen completed
  with no warnings.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl
