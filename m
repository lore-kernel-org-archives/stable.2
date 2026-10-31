Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793410313;
	b=3rHe/6HjfyvZ+H7LA69joSoR+mRCwt9JAu/83U9jNXyKpGwY3AnSS29dhnqMCtspvyVw
	 jzVFXkrNdB+FpmuXE+Zf6lhOPa4jvDX+nMTFqn/z5ojzynNFpJszHcqP6TgXWks5VNG9S
	 +kmjYVunOicq4Fe0BwKLChktDXD9wtM9yTig/kYqG7fIkBkjbbQ+bAxpoN9o6iMGlLy3U
	 gDENLCOX5OkOougS+TT/gkLSaLTCK86EB59uCFy2LAPHbR/5w2DMh0KS+zSzFRBwiJ4xF
	 nWLYu8kouA+tao1Ii4zuF4E1LUlNgIfUGDHbO/4zqXo9zxH2s/Sxay7DnMaZVV4jFaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793410313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nnMXVI7pxSqYqYmr+cJgAyqTawsiLp5YajS+zEQksOM=;
	b=lcoe6Hbey1fAgqvS444zcFVsjBFP7USkpsOl3QRNYKaHTw3uvyZLeKRbZNIlbdcXSYmH
	 ocu/69CQMExZQHg6LzS3Ln/ihvTXTsjEiUstvSMT3wTA02NeyItJyVnOSRVUZtQ+PWRCl
	 NKhC+hmDlU7F9zs+V4713zC4XOA6KiSmGfWpVdUWzhypW6tNteu8i0F8CXk6rRE3+VttB
	 K4BUl7v5rGrBx7fzwTne3r9SGCft+QVKIf1uwk1on9nWCREAeCRmPjau8n4zClhVUA11H
	 WsNx1ccw8HaeY/RV7fQAU8CAPwTizdcBuDUlMqI5wCg7056uQye3GmEo+zJ2K8Y19Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VpTC+yCU;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F84606A322
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 01:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F84606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VpTC+yCU
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-34cbc588a31so638852eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793410312; x=1794015112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nnMXVI7pxSqYqYmr+cJgAyqTawsiLp5YajS+zEQksOM=;
        b=VpTC+yCU71DBdqXgz1LKbQNMOo+CoTVfbjagSAdjMqu/UezP7IeaVnTLbj+D8DT64a
         UgpIB/AoGz+QTWDXKQGu5eBN53Ah4U3OyB8xG/N4UtjGnTTAIK0698FSBrMBFrxeGUWW
         dcxhyrkWPDAlD055uHgNpHcaWdSU631DRHO8KUI/NjLmtA5C6YY62CoVuu41PEjbUR0w
         9yMpK2Rs0cVaYZTrJ6hOV4KrowM3q6fE44FlnK+e4WVWcaLDUFryb6sQP5InEHohby/Z
         TgZmnqsMovDi8VQmWkxF9tt+UpGJDOKDk8/JAOA8TqAZAgNpbI5lnV5R97otEtz8uMJy
         TddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793410312; x=1794015112;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nnMXVI7pxSqYqYmr+cJgAyqTawsiLp5YajS+zEQksOM=;
        b=tnKq9Eg8Rj0FIecCCkJyWfjJkyGvUMMgmgB92RFjVTlpvrYZjbyYMqIab0/E76xhDE
         /oJjPS7Di+O7iSjEFD3I+T+PhZI1isx7q9BOKtBtWR2zurh1VcJugHPKFMOfNhXp043p
         Zfdg0ViFFOSJHzpp5xEsDzU8sxDWQImaNopuIgrKAsTbYi5fwdTsj7OaOh+UalCPILNA
         cTc6CBNnucrfH3Ggq68mu4JP76lIQyua6dfjqNnVtC63h3keL/7alzzqwum/+0FkSkG4
         jy41q71fYWqefnVteKgRWG9lUEv6R4GXoTObsuGIBg6TRYyoUmKPToHGokqbBW4s4UOv
         t5jg==
X-Forwarded-Encrypted: i=1; AKwUvBzCtQcm/COhSFtZ5jyU8HFuepH41Xng5yOLjM4IA77Va24uk/dj2haXtsOlLl/ZspyykK3PCew=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaOqZOUAAT2xu3NIta7viKtw+o21n3yDxQ0+FV6j4uQTa74/ni
	BZia9j1XQK8AosL3EsyiZRXeVEg6cCeOnAjcZnlCACUqpLW5Rf2QPAed
X-Gm-Gg: AYBFou3n3PvPGjreJyqreCBgkwtsMpOqpWYXe78AfH8sIMY1KFwgIGYf/KhyuPPNMn2
	y+3RW55t5RtyqJpifFneo2enlTQGQdzxlr3eB3kP4zOqCvZtZTTa8hjs/5SkcVy2TROIrSrDSbD
	90hsJ9RDhrc1DdS5/nB4wn0JfUgwecmO7zj3sFW/kFPWO1lEm38E5MT2yb0WVlS5rSofqSqeZeu
	d5t8YyNtXsW5PUvWTx8TxMnJp6ALgzAPuntGuVVfbpF+PGDvqGZ+rTCCMz1SX0QP5Ol9VlxaAiO
	q9OAMvjCsGpBQG1TfFe79Mb94eoGu0fEtXqNSbR2Gsn/xhUX5b0NueyfRqTDGMV1wQWYhsUiyxZ
	pG/zVTiCtz/Bp7B4cT4K4lL+9nfBJu+m8hOpw+gi7GIBaYO3cXjdxWts46yGHw0S8/rHS7Rb4ZS
	n9pPcNKIxGL9m0fF0cNY1HrR2Kw3jD+60TtwCUpkvrs8913ZGpA1O1IWhfP78IMyHOYN1ZCM4Jg
	vew8kkVTOO5Cp8StRnpHXvvA8WVLUr+jrz4rjXgeAqyYdTUyJbBJQQ90xQMannKZVjOI4a7lpuG
	nG8/K+e/akP3mbejTxyrv+topshP+yv2N//pT03gIH2Ok4g5SzmS
X-Received: by 2002:a05:7301:1927:b0:369:f419:e7bb with SMTP id 5a478bee46e88-36a4260caacmr5280670eec.39.1793410311487;
        Fri, 30 Oct 2026 18:31:51 -0700 (PDT)
Received: from 192.168.1.3 ([2409:8a1e:2331:2850:d40c:1fcf:6319:8524])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4294419dsm11009649eec.18.2026.10.30.18.31.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 18:31:51 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Sat, 31 Oct 2026 09:31:43 +0800
Message-Id: <20261031013143.42509-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-3-testwrzwrz@gmail.com> <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Any reason you're not reading the real value from
> /proc/sys/net/core/max_skb_frags ?

The test wants to exercise the maximum supported number of frames, but also
needs to run on every build. CONFIG_MAX_SKB_FRAGS ranges from 17 to 45, so
using the minimum (17, i.e. 18 frames) gives the largest bound that works
everywhere. af_xdp.rst documents the same limit:

  "For copy mode, the maximum supported number of frames in a packet is
   equal to CONFIG_MAX_SKB_FRAGS + 1."

xsk checks MAX_SKB_FRAGS directly (net/xdp/xsk.c), not
net.core.max_skb_frags. I also set net.core.max_skb_frags=4 and ran
xdp_metadata; it still passes, which confirms xsk does not consume that
sysctl. Reading it in this test would not tell us the xsk limit, and would
only reduce coverage if it is lowered.

CONFIG_MAX_SKB_FRAGS is compile-time and has no userspace interface, so 18
frames is the portable upper bound. That is why I used 17.

Thanks,
Rongzheng
