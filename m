Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992468;
	b=5XOh66ZMCyFSVPG3grZw04obTSux3tLVx0B+Z0yhTy8RDY1LBPEzpNYF3w/la1+2luV2
	 Sjljwvitg0Alz9Lj5t6IMHA3tDvnSemTOPMKprg1wNhbHPFld5CTGrf0MIdIT5lQ92hTm
	 6bB3l+eIIAAHdYMhfnvJT/LTAM8rAr+Us1weHYaSGNvRcY/OwQHEmnPI0//tcFrosifZT
	 tS2+/vjBB2qiJ5yfpc7jIFyuLah9m1ztvqfhcPJ7A4l+YOtwPJy8Bs3hc3dPCk2XPOXG+
	 2u0tOk1leD587wB/LA2UG1vBuEM1kcQdEvmHX4jLCLh4Jas00SWmUENXrnLwbktVnNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KJHbuu9YNunQc2098aJOeh/4wneftBInLaZd5ecyQ20=;
	b=AAvtL0uxN8yZf7fSJ5SPF09c6lBbmwpu8vsM7VKHXbE9In2VFHC9dO161V6NR+e28Zj2
	 L4Th3PQAKTuPoZt+EM5aSMRAUwERYLkzz/dWTvh3YKxSB0vVJT4lva1brdxay/yEVMW3c
	 qqIt3n6bxPXKBa/4ukZNqsjTRxOcWC7fKhT1RR/JJ7v8rc7iKxwdupjSUXxef2ur9QWqS
	 DZvDvcwgA1kan2MXmULvrQvQZpJmHNYvFYRSW3n6HvVjXfS0m8fccCLlc1osTtrfd7cBO
	 dx2yxUc05CFRynBHh0varYwjXPbtdg9E8kJGkzw4VUh+Nw5v7oSPvArjyH0we93FsIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cg0E+dri;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA10606A322
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA10606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cg0E+dri
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-353804b591eso4879315eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792992467; x=1793597267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KJHbuu9YNunQc2098aJOeh/4wneftBInLaZd5ecyQ20=;
        b=cg0E+dritt0P6TfxAW9Q255khPeEmu+69fU8a2+/61exzipudfLtte3lz6pHT99rWJ
         NYh0W4TJ029dbTawErQ+RMpBmQSz611482As9+CYIbrL8/dA1OIcBJkDJUQtVhq3uKft
         8Xho4cBVbfyF3g1PoekWa2iOGxAm3ryDdP3tigjYTJU89NCwQVhS7FyZ/CTgfrLFDkts
         rbNE2r1zXGpM+8Zn07zrtdJ8ntU6kprsxSvad4T7fL3WFTq4nXGqK89wr56ZdHihhPSN
         gebvQ1afjV7bvIobenNv1K8k5v76Yd6zWZXiWvWLM4QKCNB62wf5aWZ1/f3BsqpjZdOV
         NA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992467; x=1793597267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KJHbuu9YNunQc2098aJOeh/4wneftBInLaZd5ecyQ20=;
        b=1ae84EuskuLsplpWyiGXydt04hgBvKhU8auOfmz5WR0x+MMcwIj5ts63oq8UIN1iRn
         ewpM8vHbZxmvvyJM/Ut89WBOH9860alBSJXV9moD/2KqEkPry3FUSsirsdUU7NqYB2a/
         YbN86pXqEYosEImgKe9DQq88CWA2AItbjzUvRg2EcRD5w2lxL1gxoiUyHnPcF3I1wjUw
         xIA0bMqLIPc32+JILBPKdJ50F7q5KwFhI05JxerPw4oh/jH3nb1w3bBzE46As6mOHs5N
         MPsJVCnx5SOlhVee1tAX+SPTFkaRt7KRAyF9mmjajoqkba4FQAyDGveYZmvDDF4ZMj1d
         CaMw==
X-Forwarded-Encrypted: i=1; AKwUvBwvYJj3i1T4DWkTyq3ImLGKYF0fhWizOZeDYMqLi/j1udc1Pj99xiDG08VwVMEnfLQKRLjHKzI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUv7OP6yBpWsK32Yg+PDqJwq6SnmUGcZruZwWNCJkUPsYEWn7o
	PD3Z1pcmKA09PusOVx9RR7t+xafa5aZi9AY0iR0FNczbEETVEg5JE8fF
X-Gm-Gg: AYBFou0xXsk+k0cTkKIt6sNEdXlogezkrGmslOQ465M9FsmwIHuXepM6gNvedjVsnew
	dbqkyvCVwR3kFmXJkhSoLFrsr4HzvoZK400k5kdUD7uWr5KbIdi0jWd5QefifOVNlAtOXR7uRFU
	tySQ5u4L6wU+08FYLxwxGzCCBIQiHBQ3C2V1NGv0VDiJS2DBXT5rPOPQPu+BmWXfl1Sk78FbS/D
	KdRs4+Joz+TprkdlLZc6/+SWxROCGvj8txUSk71un411/OQYG5DhftioYjythiDEIP5WSsrZDw7
	irsMjwiLexzYEyylPrSqIEk4RYpn8vMosCujarvOmqW5hmNlnACFnXN32Y6H7JxbVZCsEOse1HT
	/3JDdBinq41qvms25GNBy0v091OHZsU5pKKsSx8EA6aN+eThwVQZG/HEtm78Qvl7N7MO0OjqPi4
	CTv08kF323QMJdQnfeuC8kC6bJzsj6DdLihKYVgnnRItsD25IniZSKKzSZpccOwvN+UrsZmTJdc
	5yLNrNxKe0FGcMF0D/ihy7RPPNGgbCbZ8X7Ypr3ejOjd6gYknXWjnvUgfjQ8BdPj5FRq+is5AFI
	QJhQ0+4jCSwX2YryPNxjOYLHvA==
X-Received: by 2002:a05:7022:3a09:b0:195:76af:b810 with SMTP id a92af1059eb24-19935fc69dfmr10272975c88.25.1792992466519;
        Sun, 25 Oct 2026 22:27:46 -0700 (PDT)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee69sm29188566c88.4.2026.10.25.22.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:27:46 -0700 (PDT)
From: Tim Budding <tim.budding@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 3/4] sctp: don't treat an I-FORWARD-TSN as an association reset
Date: Sun, 25 Oct 2026 22:27:40 -0700
Message-Id: <20261026052740.187459-1-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179293012867.3134.16497481637722705271@kernel.org>
References: <20261024120627.837568-4-tim.budding@gmail.com> <179293012867.3134.16497481637722705271@kernel.org>
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

On Sun, 25 Oct 2026 12:08:48 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> With this call gone, sctp_intl_skip() now sends
> SCTP_PARTIAL_DELIVERY_ABORTED for an I-FORWARD-TSN at the leading edge.
> Is the pdapi_seq it reports still the message that was being partially
> delivered?

[...]

> Could sctp_intl_skip() pass sin->mid_uo (unordered) or sin->mid
> (ordered) to sctp_intl_stream_abort_pd() for the notification, and
> keep using the skip MID for the flush and sctp_mid_skip()?

Thanks, this is a real bug. sctp_intl_skip() has always reported the
skip entry's MID, which is the largest MID skipped on that stream, so
for an I-FORWARD-TSN below the leading edge pdapi_seq could already be
wrong when more than one message on the stream was skipped. For
unordered streams it was wrong whenever the abort was reported at all,
as the old check only fired when the skip MID was larger than the one
being delivered. This patch removes the path that happened to report
the right MID at the leading edge, so it now shows up there too.

v2 will add a patch before this one that does that: report sin->mid_uo
/ sin->mid in the notification and keep the skip MID for the flush and
sctp_mid_skip(). The selftest will check pdapi_seq for an I-FORWARD-TSN
below the leading edge that skips two messages on the stream being
partially delivered.
