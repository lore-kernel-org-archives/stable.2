Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026543;
	b=Ite9vr0Os0CBj6/bZO13frjryF4MLsf9stwbNxagcgrVhXPqPb++nDLcU93MdQnVuJOU
	 SjBJ0CjDDXyhLIEd0DR0My4z/jxegSH4CRHBYOv1qBWxqTuW4k5ggGKhSc6WuVwhFV3D9
	 exnhsxLr0HhtVXam2Y0nUnDtc+z8NnRWegXjs7gY0jQNXyNKfo2k16OFEs893bVTQtXVV
	 hcpvvq4lPBCvEpUnp7BNRFz+cNddp+Zcisnbrcp/lq0ZnCnCx6QhJtzgZYKx/EqgKRP6X
	 7loxRipoaoMpWjaWPZ7zQaGqG3UaIHK80thSOoczQWwVw840Yd/hd8VpsqBxfoy9ryA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N3UVCZ01NtzZBTQTfy6B2Rj4m9gham0iwhTudNRqEe4=;
	b=b9WG3WTFXhGd6eL+Sj4athtn3BeaEXqXyvd5XGU68SM68mM3rAkNZoztlEfof5wUmGBV
	 2CpQrw4sCyn4ZC5enohIw83oWmTduo2y8ggP64EUyx/L1TogGJLMMD2nPQJQHsXGpayW9
	 qEcvz+nCrsfv7GUDfSXQmKaqUYtDmOTGVirMH3IYVaX4Dw3LhDAKaAwRpYbbmwTOo/yWe
	 Q58e8TfRrYhHoBaYIz24PFyYZdA9uLtzmNTxAdaW+BMyqxvg8jDPoaC4tVsk2PqNL1BJP
	 vRTzgmX6NQkNUgKqto1wumjkEBPNghLOLHlSnTeBuX4uSY5eijqkpIvKlfuwcOUs2Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ya7N+tEq;
	arc=none smtp.remote-ip=74.125.228.8
Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5AE606A321
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D5AE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ya7N+tEq
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cd3da0e82daso665574a12.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793026543; x=1793631343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N3UVCZ01NtzZBTQTfy6B2Rj4m9gham0iwhTudNRqEe4=;
        b=Ya7N+tEqw7L5wqauN62InhvMjZ07hzBv8z1qv4xYl2l7+7mOtjMxFicn89wJu8WQVz
         pVHjA1mp2HdRtfukIy/YsDoV3KYlr0G5uIegku1JE/42fMSxxJPmKtGDklYBwnkSwnI8
         TElChyK1/vUWAws789Aq0wc2r/GMyal2jK+81TKfc0m73RDr1V5P5Za1VVzQUNCedoqA
         478ec51dXrH/qGDIYhLjmf2T/uMmtN8c3aPqOKGIoiyNNn2Otxpq9Uo4VzNamliEKvoB
         Dg5S3jC5fM8ztd4zHkXjLifKH00SYCtNXc+pmNaBbQtEdgWdBOS4Mg1srpwqPYC9flbK
         aMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026543; x=1793631343;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N3UVCZ01NtzZBTQTfy6B2Rj4m9gham0iwhTudNRqEe4=;
        b=EUy1dnQnDvmqaw49Iu5XJnLVlNv9OFFSZMuPFwSuUdgF1kXR6cC1/1hZQbFATee4L3
         QVqdckAPGM664O++6dMU7Z0hrGRmZmzw/wZcGP6xtEB/U9rqc1E/LHOAYeCTtP2Tn+xF
         HdcAf5TZ1Ph1uY5Hg+IVvks3FjD7n5gs5j+TDWt4oOAKXgBxM+16MreWGYuNmILGA/DH
         uzTkSUwGarv5yGRUs/BpGB1iA96vg1CQKYcWPijgSZQ8nIIABHd/mrqQMl3o0NV0gPnN
         c1T9J1MMqAaUJgdo2XW+L1SXXXokJUsxR1WgxekSTizBkAGnni8dM1YYhhOuEOBfv1y5
         oTGA==
X-Forwarded-Encrypted: i=1; AKwUvBzJKxPSY0oD8NxOj4HpYt688ERyDrhHcBCpBdImWafW+n3ZF66QK+FL3/9jDpTPAjki38/w5Y4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKH/YdyXvLRlt8uAlJTKfl0vylXr5+pJzGyhXfbKHffkrtq0cnb
	vExqeHNr2rqmTUUm1yAjJaaUP6kuS76Gt8WM7TlR2i2+SiM7x+S5dMM3
X-Gm-Gg: AYBFou3DIIUbgIeIcLQJXNWJcRG9DJCcSce6Hs+lvJY3i+SI+D0p4lkx+2Wj5ePyVN9
	mHoxgZgGEbur6vKpYx1SSMVzYvhDWkXw89Q+PSgf5jSrPjKvRJGt8xZbB0Iq+ytP7j+FpdJCtt9
	DecJNf/Bn1QAr3UV/0EZmQR3Ab5a/g/tEY1rSPFR5Hg46LCbZLS8Rbog1A3yHv7mqOnASKiOOt3
	QihSzJd9FlSg4wOhCgpAXb4a52d9L+j1cmPB8XWXM3UluNL9UckOqNxMrM3nsYq6Q1+20Qkrbnn
	63sc4aPllD7GfMzDqj24rPNDQZ6tYXzqDiC4xlIHW2+UUchR05zViG3tRxTFc5QOoA3sYO064Q4
	PLhctsI+HlCNtpIMl3ILDQlXBA6LyoStuFbjDBy8o0KB/aOtc+I6Zyp/u7asoeqx1Faz2zEDY7K
	1TaPAWXBWQT1gVlzeJls9nqPLE8fvi/wFlMG813wtGmnSgYkw/gkJCqJeE/L5lPReHuuxnwQzSx
	sVobKVSkani+aMB/x/DuVpVggukoUgCtAbynabqmr20WMJZg2J3zz9XdDoiAJUXzbllKcoYuPJN
	oRVFAXV4i1YYo8gR
X-Received: by 2002:a05:6a00:3a23:b0:8a0:1dab:fd50 with SMTP id d2e1a72fcca58-8a367a2e5bamr5994625b3a.20.1793026542774;
        Mon, 26 Oct 2026 07:55:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2300:286:8580:7ae4:15b1:705])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b469507sm1361172b3a.31.2026.10.26.07.55.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 07:55:42 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Mon, 26 Oct 2026 22:55:30 +0800
Message-Id: <20261026145530.46896-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179293961591.3134.5478895656850588086@kernel.org>
References: <20261024141157.59301-3-testwrzwrz@gmail.com> <179293961591.3134.5478895656850588086@kernel.org>
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

Hi Sashiko,

Thanks for the review.

> Should RX_MAC and TX_MAC be copied here? In this file they are text
> strings meant for the ip link commands:

No. This is a regression I introduced in v2. RX_MAC and TX_MAC are the
text strings used for the ip link commands, so copying ETH_ALEN bytes
from them copies only the first six ASCII characters, "00:00:".

The root cause is that I reused the ASCII macros intended for the ip
link commands as packet bytes. The test only checks the UDP destination
port, so it still passed with the wrong Ethernet addresses. In v3 I will
restore the binary literals and add an Ethernet MAC check so this
regression is caught.

> Should the condition be retries-- > 0 instead?

This check is pre-existing and not introduced by this series. I will
send a separate patch for it rather than mixing it into this fix.

Thanks,
Rongzheng

pw-bot: cr
