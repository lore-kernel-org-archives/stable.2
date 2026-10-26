Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017934;
	b=4lx9Ob+RSW92ZizSUlXQMye6eT2l0rgQuZSgJpf0G4HjomDM2bsBUAYUOxveEwQVmAMz
	 zd1DLcDDYYswFOhkfMQpqLilldJveYI/Wx6dRxnIQZGUtRynl9JjvnOKL00GfMpEVPOqo
	 97p32QFprRrD3h+2YOz5bcKevrgr4GQnFZORyi4s7Bdaeqw2+UoecoY0Aa9uZGKfKRiWD
	 3PCQqgu8sVYvXaZ2tU2oW74NBoiN8maxCXWBTytYWM5dXC3sc45stXN+KiG6JxP4fTrXr
	 1RszeKLi/omIJ93SdBk1TF3n3vrz8S225T5xVZWU+VIg+t1ML8yQAO1CfEUJwuRs73g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ktUKdiKYfb7DoM5zhVHml/g4TQZHJlrIih9rFWqZVKQ=;
	b=W/Gq9OnyDVp4TWe+v6s8HvTGMWAksS/kZ3PWFpCXWzSFupPIGGS7xRh1S+b5l0YMegMy
	 mMBZUhVinxvsflOBCOtPTIhShoyJY2i3T3lU5NSm7AX5wYt7bek2Nl+TroJxZ27Z4ZPZG
	 bU7kp2GOXrDfe9Rxo4QHamERNByGz8zosF1zhunS4MuhTV1865Tc2zeZ3Mj8SjQqqqLMH
	 FNxXWm7gwwVqaOW6E4xKiLi5fPmilz1gh6sXm+lftPfKSEWnG5MQr4kTZkdbCgGLmlBCf
	 b71WTucKhZdIA64B9BYYuoGaIcCVcOdCcg6F66gsiN4CLJeuACyQPxuDR5BoSG8RQuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mivMcba8;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C812606A329
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C812606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mivMcba8
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so9683375e9.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793017932; x=1793622732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ktUKdiKYfb7DoM5zhVHml/g4TQZHJlrIih9rFWqZVKQ=;
        b=mivMcba8uYDlFfKaqTMPiPMpITmJGgJrVgHOAE8jYmLoBhYW45mBdXMQ02LqG2updu
         9LeHTzDGRg5A4F89RhWaUFJZ5c+VI/1ilvjcrv5DlQxsAoj2wFryqCx3b/uPou7AXDeb
         Wss9LdDOSh3+0Gu7kqjVfhjI8DS+Lu5UP/fenZyhi4gwhMFIDpqrbDyquPelPmXH+51y
         m+m44LxpXGLxus7eX+O3txTAid5lu69y7VhycvS1snpdVZw/LgFjEanIemDgwrso3110
         rirMGQoCitHWBLayc4HPMr+aanfRqUmn39o06PX8Oae+V0uea0+PN4brPriZTVyZxsuE
         4C4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793017932; x=1793622732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ktUKdiKYfb7DoM5zhVHml/g4TQZHJlrIih9rFWqZVKQ=;
        b=WhvBKj+vVm87TtP+sqUtvpdyMydv1sDCZiwNj4HPeeE+NUlatUrfHpr5AC7KGC3FUP
         dwTS06uDPEMoJCJyPb7+MYZan4mIy0URb9R8bjWbksjEHyfPGBjuhJY8fTxkbXrfkW1A
         TLHZVsGLGeJ/7H227BQkByyatHYABLL8icexW5xZ2c47v7TH6R+XqKjc4ABfIH7zSJSd
         SrLtHozoda37H+K6xAv6M+c9hFP+ruNAEb3pJ2gTWXbwNvVYp5lpcEp02Ej42BRwhWnb
         JakK9Q4an0y/f0x2MMOln5/camYqhpYmPHUFFN1Xfy8PKOXPkoz6HrmFdnitmPMCbFQE
         spng==
X-Forwarded-Encrypted: i=1; AKwUvBxbj7Wg9kcOTBNPvIbaEZAfe5qdTXe3R2uNdQnPIWgzPFI1HyO+B5ew0/Mgx16PNGNp5tOlvRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIx0f9f/QCLsVQxHu4ECk7gw9p90ym6ViAFGSvzDHCRvqQ/+eXZ
	57lCoQ4bG/oqKrO5C04srEz4//pDTV5zay8MJCOK9aMLa5TIy8cKBvqi
X-Gm-Gg: AYBFou1uGgbD+r1xxA6MFPwbh+i3yYkoyllyg+ENJHoMPMAZzHY7P3WQ7rW7EuB5n0d
	7c6DkjRzUy1GIaMNWxqL46py9frJWsCpsXBG3/pWq+PAcXDcW3+0Cdk1KSpP4E+k/F//3po6PGh
	/LRXQrhOKPS9V7ieptbAtIscM70F13gDAqPP68QLRMhjFSMdcKOZBjBoP173XOLXAL2ggEqtYiU
	zhF2623QGa7W1mOS6at27vURiltrLO2eMvBwRtBLlNdzuPeENuBKlQwWk/ueNNcaGs8FNlcDwPm
	Oka/QdWO+Ogm2Ja9QMvH+dfZt2XpHEQIflp7GKh8PjQkv/A8UqsUbt1jcj6LtOs2E4tly9K2Qtu
	BnakG8n7Yf6FpJjhFKXz9Kv4vUAr6Oj3BtQ0R2mqZvUV4TBleRRl+9cvoOjNM+71mzBlVenHusl
	NoijK9/SjuvnA6FyiR9HG66Lwx9mqaiEJ959J2bgHYqIETGfaoboiupxLojuryN0VpwVY8iKgt8
	89epE9kOYE5k8Qsy6Xx1TGqbjlgJ7qugHGXP+mP57R/ZqHERlXjHhUSNoPn2Snn8wz4yB+HpYi1
	mXIeNGXp
X-Received: by 2002:a05:600c:608e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4a642ccc70emr45612025e9.11.1793017931500;
        Mon, 26 Oct 2026 05:32:11 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdf9bdsm15684045f8f.55.2026.10.26.05.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:32:11 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Vladyslav Tymoshchuk <tvlad744@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuen-Han Tsai <khtsai@google.com>,
	Sonali Pradhan <sonalipradhan@google.com>,
	Kees Cook <kees@kernel.org>,
	Felipe Balbi <balbi@ti.com>,
	Jim Baxter <jim_baxter@mentor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_ncm: restart the TX timer if the TX freelist is empty
Date: Mon, 26 Oct 2026 14:31:59 +0200
Message-ID: <20261026123159.53234-1-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20260817192638.437798-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260817192638.437798-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

On Mon, Aug 17, 2026 at 10:26:38PM +0300, Cosmin Tanislav wrote:
> Under sustained TX saturation the request freelist is empty most of the
> time. Since the timer is never restarted, small packets keep getting
> accumulated into the NTB, until either TX_MAX_NUM_DPE packets are stored
> or NTB_DEFAULT_IN_SIZE is reached, which is an unknown amount of time.

I hit this on a OnePlus Pad 3 (SM8750, dwc3, high speed to a Windows 11
host, qmult 5). Pulling 20 MB from the gadget over ssh stalled for 40 s
or more in 2 of 24 runs, and most of the other runs took ~6 s instead of
~1 s. During a stall the sender kept retransmitting, the qdisc backlog
was empty, tx_packets did not move and the ep1in TRB ring had nothing
owned by the controller, so the frames were sitting in the pending NTB.

With this patch on top of v7.3-rc5: 24 of 24 runs at ~0.9 s, no stalls.
Host to gadget is unchanged.

Francesco Lavra posted the same fix in July [1], but without the
hrtimer_forward_now(), so the timer would fire again right away.

[1] https://lore.kernel.org/linux-usb/20260727165441.1969927-1-flavra@baylibre.com/

Tested-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
