Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607763;
	b=4sUtaunf10bFAl8Bko42mls/DeeNGue0BiX+eXpA6aaL3NC+Oy0jLm/o0Pl0PF2cEZw9
	 4ZAkJS1aHIDjIWaIk9HDBIuG2OG0GrlR2wzegrr53Ig6TF75Zv35Bwt21EESaAxVAIf94
	 zmj5MrKNKBKiPnMKCjYFZTGVIGqDAKc1OkXp/qLU6saTcdkhTO62PO+qMeIpyGv0KqK5J
	 /hVL/G55cbjoPUS8EgQhl1f3MMBYARfzW/ASKwZAMRku7WT6qrXhM4Pi5+3PsrtqNW4BL
	 djbB1y0UmBGC8ldXUlpGdJLxTEZHjTAFHNFDFdWUgXdVK84ThzDUdL8mNNv6z3kWRbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=eAX2A50EYtJkcTfS6TxnLukDj/BxU0JA6j0fOn1wRUc=;
	b=XKhN1gdc9szWZaDQocmTMu/K0gTl4Jir6Ion/K8Pmf0VWcMdq9pBHklh3jTzw68gnXiQ
	 w4K1e3+iArOTCG8lZHRIYAophmag+Uxwcj/zBtT82NP4+sWg3KiKg/zkOjaNVihC1xTdi
	 uhbsYXlt/zvaf/7OioSFxMC2/dshHy/N0OIPL/axllOa1obRmPNEsATkzDiPDYWHd4nrL
	 S8b4Cf7BWAIfrzJrBIyakbCsCUGbKLpWClQFwH/nH6QxnFrgmoaIoThTjbqlnS7cYVz4x
	 ZsLKqEgDMJzalj7jvDK2fjfEez5Xel3tAKlo0A1g1RsKnDOagB8do7OyXEWORN2GTNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zpg9buxU;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28A606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F28A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zpg9buxU
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso8249235e9.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794607761; x=1795212561; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eAX2A50EYtJkcTfS6TxnLukDj/BxU0JA6j0fOn1wRUc=;
        b=Zpg9buxU1o9Z00Kb2GMN6SokzoV0WckspdEtudVGjsdPuxxztrLFHlgFEK4077S1LF
         ccK+FcYkH7eame7BwYSCSrZ+SgmKHGC/3iNuq7d9gn9wKxrxIW+a7SnzDJqBQlQhX0So
         CeQ12FKEM8mxDAXAMrkcl+d6nxHoJ5uY1T6LOVMUs4w+NkhZb+staBSHcC2nq8dIyQu4
         j0K2apJ6A4pXs5/IbwuijNV8E7saOQp4Olm4ydtRDqFS+YzxUX2WjzoVyR3Pi8IfAyi6
         o3C0r3dg6abjkmbW4hePM3Oao+mR9cDm00xLf5mesAGxXVA9XQBev+D7OZN9Gwh5XwlR
         nA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794607761; x=1795212561;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAX2A50EYtJkcTfS6TxnLukDj/BxU0JA6j0fOn1wRUc=;
        b=YEG40MbAYppbjNm3Sll5gNMuvTlkhzW0DHKq6H4G8lzDXXfC5gtv8+baAtCMgSXvTV
         Bs+XPNqujSDLPJAt7BhQEs0AqqpQNf57GADzu0lTwdV3yuMDT74pChH6hqvAu3kPqXsT
         VkzPtmMIWh3BG7qaUaMz2p2k1pmTdZX0RfW9/4PdcvUZcTiU+RhJq0RhL29kVwm7bMUQ
         BQKk6G0iYXiuSWyLmiOiArSHcqurtVM3uI7tKRqu0HE3u4AjJNKbWMgJolyDihybJcCq
         tH58xgbC9ohNV9G+cnktFpdfJ+ARiey6SC1MnLqTfTDvF0Olw4beJVB08LKuubye+VBA
         mpww==
X-Forwarded-Encrypted: i=1; AL+hErFG8G6pUqHUKAKj+SYqxMsetB+jDbDlhW/GBaeFDTyIaBd7CjkrLnlvAfGVqIM8WECawSvd8mQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Cp9aRku+qVvmKIUOJtQEZ7fVamfR/Kp+D6jKUMjiU/ayQcmjl
	OKMZ+Fv5gZRsI79WqB06IwvRydlW1joIxPxnIUfgXRxLes0O0iklvlU=
X-Gm-Gg: AYBFou0mBJX6au/xySKEnkDSEYFlCT30scBZEq7AJotQlVktM4SK2XSuwgxDXOAAcDK
	d5/xmc38pNqCBl4Dfwn0Ro6gFwqYAbPu7sSmtohHh5H6bwgDH9YILmPeNJet66QE7okN1MsmJ7V
	URYd74IvPMGgs8aKygOC5w8Sh5c2KCpDheJR7nT3bBgZs2aIuruPlbSQa3zFxBVG1JgJgFa8yih
	+KMtNlBeKTAJXADGrq78tN4DRr9mbA6hFYYoMSluRyobJPgdlmOO9hl72XJvkofULZ/fAFMZj1f
	fP5/9hrpzEGK4XOqbXp9OFy42SZx7UiZedTekszarJSZ/6xiTptwOjDw7VUVaTsWeIanlhxY3JI
	FPl4K37Azwi6PzSoYqnZXmWbjvMP4LHt63Ts9Lj4vP+jlVrK2b/GXcCwgyrcZOXc8xw2Z9p1zwq
	H7kkk5M5ViZzSAi59h14dTARkxy9pqM3Y1aPg0ufdfm3qd56geefWQoIRart8h4ZmslO/BPZ8sb
	GJiJQZLz9eJ+0LMtvVy+2fgYm7RA0T7bS7S1BWKhSrLVE6ZVkaPpGAwbPr6499F/WG4YBY=
X-Received: by 2002:a05:600c:8b8c:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4bb609ae053mr20773075e9.7.1794607761393;
        Fri, 13 Nov 2026 14:09:21 -0800 (PST)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae5299sm102617785e9.11.2026.11.13.14.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:09:21 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 brauner@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_flow: pin file with get_file_rcu
 before reading f_cred
Date: Fri, 13 Nov 2026 22:09:20 -0000
Message-ID: <179460776060.2603197.3619232752332382972@gmail.com>
In-Reply-To: <179441146372.2168702.5462633106767625518@kernel.org>
References: <20261111153106.580776-1-tristmd@gmail.com>
 <179441146372.2168702.5462633106767625518@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

These were found by manual code inspection. After commit 0ede61d8589cc
("file: convert to SLAB_TYPESAFE_BY_RCU"), I audited callers that read
file->f_cred under RCU without pinning the file with get_file_rcu().

The issue has not been triggered in practice. It is a theoretical race
where a struct file slab slot is freed and reused while netfilter code
still reads f_cred through the old pointer, but the race window is
narrow (a few loads in softirq context).

The same bug class was independently confirmed and fixed in eventpoll
(commits a10fbbe74e1c7, 0d8cd9537c641 in v7.3), which validates that
SLAB_TYPESAFE_BY_RCU file reuse is a real concern for unpinned readers.

Thanks,
Tristan
