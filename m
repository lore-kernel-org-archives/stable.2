Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.111.35.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793335359;
	b=4YgSVyND/r0Ub+kOAn4OpECpuDULyf3cxJfkXl/NFK0SFTOObGKuOO2En2OHd5YweN1N
	 gu5PBurpYFuO0gY/f0SbTaA/DxYOKbBC+ELYS29pb56OepWxETe1oYni8yivSicjoePj2
	 rH5nBJp0zN/7kaiSQZ1k/EebCbUVjUkL9sui8E10RVKuJ3fDIGNCP0QSyLzDN2DbMDctB
	 qE2rI7+TlE+Bz8RXtyObamJ+iU9AnE7S1sl5YHG0wzHVH4huho3iHfXmSAW90bca8/WUs
	 msqEb2mNMLgDxXi/zpW2/lPDHVJ76VaqIwTTRpi0PtqmFnh85mxPvu9s7vjdXNJiHRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793335359;
	h=DMARC-Filter:X-Originating-IP:Received:DKIM-Signature:X-Session-ID:
	 X-Originating-IP:X-Works-Send-Opt:X-Works-Smtp-Source:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wDxxms1bv5/o+/3MhiBxEI7oF1cgDh8buYrPsh2YVoU=;
	b=UX+YvTyi2uRZtSOYSR9DVS2Zdzp62Qu3vD+qmf7lbizt4EGPi8eWcQGNkWD7x//daOBr
	 X7bR52gcQnzXe1pI5rmYy8tLjm8W63FjaS8UvJGpd4F1h2Z3my6hQ606RIqoUUtI4+D4P
	 Qd7Ovjp0octD2x2ukn5DR0jQLN3NOXDRwjh+ecatDSDKUzzfziqLdVQC06Q5xB9eS3ICg
	 ED6+F5updWCQ/vWlD+NiPlRoYMCuQSY6r+vYqgl8Aq88mGRE1wRE7A/DMgQE4Frr8McFC
	 zvxYJqq66A44XvTjZqwMlQchZccGpLzm++vAhQy+mFEWAFFSaoItG2rxlYY9peheprA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=navercorp.com;
	spf=pass smtp.mailfrom=navercorp.com;
	dkim=pass header.d=navercorp.com header.i=@navercorp.com header.a=rsa-sha256 header.s=s20171120 header.b=WJmsze00;
	arc=none smtp.remote-ip=114.111.35.55
Received: from cvsmtppost01.nmdf.navercorp.com (cvsmtppost01.nmdf.navercorp.com [114.111.35.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68771606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68771606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=navercorp.com header.i=@navercorp.com header.a=rsa-sha256 header.s=s20171120 header.b=WJmsze00
Received: from kr0s-hmac-real-0 ([10.180.30.112])
  by cvsmtppost01.nmdf.navercorp.com with ESMTP id heW1KIhuR4+viiwJeIW-2g
  for <stable@vger.kernel.org>;
  Fri, 30 Oct 2026 04:42:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1793335350;
	bh=wDxxms1bv5/o+/3MhiBxEI7oF1cgDh8buYrPsh2YVoU=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=WJmsze0077DrjQGxK1QTDrj3yjEmCP+Mnyvu9OcoIk2vhODdMLsXlG5eAaQkizgR2
	 fL06ySrutNAFAHOqOzMFOAWbRJukUBGFKyRsy1yMRAgTdrjzqoPjn6yHoozAbSWieO
	 kpe40BgAAHJiMyJ5Aa1vAFMwIQD7ikpr8/mwoQbRVkp9OMXwGud3SGdN08hwDf41Dy
	 nwz1jbNz5TmLh9wSxwHW4Q0ERl1tIuCAQVRWGjtkmQYdeoMEE0DP5VXt/0xkapoTvo
	 uPQSwO1wAb4ksCAbM+5XrJVA6WV7Dr+zVJhlsnQ3wGDWww9cmw52TR8nldCRqkBF53
	 qLOrIcxcBFTNQ==
X-Session-ID: axEJGcA2Qpem4vHPMyrmQA
X-Works-Send-Opt: TdYwjAumKAumKAbZjAgmKqKXKoJYFHmwKBwYjHmm
X-Works-Smtp-Source: XqKmKqKlFqJZ+HmmFxvZ+6E=
Received: from localhost.localdomain ([10.25.101.111])
  by cvnsmtp02.nmdf.navercorp.com with ESMTP id axEJGcA2Qpem4vHPMyrmQA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Fri, 30 Oct 2026 04:42:30 -0000
From: Gyutae Bae <gyutae.opensource@navercorp.com>
To: Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minsu Jeon <minsu.jeon@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>
Subject: Re: Backport request: Revert "softirq: Let ksoftirqd do its job" (d15121be7485)
Date: Fri, 30 Oct 2026 13:42:28 +0900
Message-Id: <20261030044228.7815-1-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com>
References: <20261029054200.97234-1-gyutae.opensource@navercorp.com> <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com>
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

On 10/29/26 09:33, Paolo Abeni wrote:
> IMHO such change should not land to stable lightly. It's a behavioural
> change with subtle side effects. The threaded napi feature is disabled
> by default for the same reason. Also the revert has some soft functional
> dependencies in napi threaded cleanup and improvements landed into v6.4,
> i.e. 6bb218b5a6e3f3c5e2e76faf8fc976f3f6f72496, likely more.

Thanks for taking a look. I understand the concern about changing
behavior in stable kernels.

Gyutae Bae
