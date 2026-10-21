Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566240;
	b=prziixy3t/QabT9Tnoj7p/Ggug2eL3f5vfOytFu7uIyD5hwuRJyz1UGJs6IMNWw54I/1
	 LyfvFhvp+KjP2I6tS9m4HxuZe1FF5p98OG+FAy2oT8e3XCF9O3+yYAzGPhFvX3wBhSUDR
	 zv8RwnNVIT0n5TyMhlH2mA68/sdAZe5caZ/j0k8yiGrF9OoVi9ixtLnL0yD23804Vxw9w
	 YbKwacBffYX/Lx99QkdwMPEibn20j9RfV3/ptHdooQlRXGamPaTHwn6zqm+hd/Hjg6NH6
	 /oj7QGCbOKHf8oZfMVcN58ZXjX3NJDwdBYDMJ1dBuCoCfZZAOrRg9OIf5pwIdBFvapg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2U3R5sF+UF/ThzqmsP+AbA8AsR1nfKMwT/Du2FLLvgE=;
	b=w/S2JjN6jabmCI5eNsBQC2mXnfx8wp8Tp1TU5cdiBNC2e5CnKIcGfT4n4LyiZaSrRxh+
	 p3sQr6MNiVwgv2ISgZGo6LtpXXdWlAndW7X/fXyBnk3znMGs+vOvA4K8iRcIYSzm3Q3Sd
	 FTsHAeEJ/bQBIbb9RWgRPBYCsuXT4ul/7uGtUMsYs9jwRfSLsRBrgIvlehSldlWdmB3NW
	 yUR4xB+9dnRPPaYfU/GTo/hfIfsRsDJ6ivkw/nL22v64KXLDb8j9pcD61ksaFWK70Y8X5
	 5xakuy/z3QR5vdX9QDVCyBYgPzsgEqDbtSU9q3ea+JzSuhuMBvYKxZpTVwYD5aNzldA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iMN1xn3h;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B12606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62B12606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iMN1xn3h
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36661f953e4so800762eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566240; x=1793171040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2U3R5sF+UF/ThzqmsP+AbA8AsR1nfKMwT/Du2FLLvgE=;
        b=iMN1xn3hejHPBSHO0Pv92Dy4wXE2672uh0915XPB/HFGgnDT6+rlnF3lCrW4i4dNtD
         DDvjLbrO/arbG/I0bPaOeJbSJfN1iAVDKEY9MGNpNKXDjDtKW6swe9+PnIn8Xkcz9gC7
         3drI9HemMcncLg5PGjJJ/njlganMXmGXofaMicxVglmruVmHWg6ot6L/kLl04IXgOSkz
         haustV2SEOzeXKNsIoCslKeXa4x6f9q09NyTf5CXN3YRCjIslgDf9qJ71WTEM3e5ATH7
         6v3HkspheiHVIn3RFX5ycVzW8XW/lxYytJvhkEKzJgs4iOWPsjwiDwcfe5fqOf3wQxi/
         B2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566240; x=1793171040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2U3R5sF+UF/ThzqmsP+AbA8AsR1nfKMwT/Du2FLLvgE=;
        b=BePmaRV3VzPqvK7r5YsCioKRAmwLy6uB/u3nSGQL72CcTPZ6j4VI1t1tb8o9dG4GKG
         NjfBh9ioytgbzxQ3YCM/BCFucWAFr0MhLmMtaHCXKYPnwxBuy7iFL0UJfyK3rAwG1Pj4
         qSAin8BY8Zf40YJDBjKTx17ujSFOyx+sYikkxB4++JDpOI7BwbCAf8qiqBO8C13FWBPB
         1uI2WHyHmG4nWJwYLNaqxQEz14akHv74aYzt/N42+mL3UINBHGphhN8rOeAMQKHYrhTM
         luYPHqukPsEvRFtwp+VXLzkJW/lqD/B9USaBfW3K0CsbDK+fFbaaX8iLVzl0y7zsvR3k
         rAcA==
X-Forwarded-Encrypted: i=1; AKwUvBw8zLDLlsDvWUZufiLPnGURKm5aYGk+of2uKGwJTr/jXBdGdoxNbrAQ0pydTp+2QwfkLYVM7PA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIamD7mPZAYMwMx2TdCkbNnitH8bHMj0VLqOsw9kDLcCrf0mg8i
	ziJbAahfNzDsXMlYpnUcGksu6CKu3up1aMyXpLxxJftV8VAcDT/n1WCb
X-Gm-Gg: AYBFou1eFPRpxCzdQ5E9OxWmphB7VpbBEjMgMhEyr5c9IOqWwmRvdLWn7Jro9ui7ycJ
	kSFAo0dV9wsK96C4nPTZNbhY/mdxiec8zHqE4Js07coxF7lS62KeQ8qXXo5f7t+Lrj7I08s6ilA
	kuctV6UPhS8J6+0GULPgMI978BHqHbsz9cdSR31aJcshfCNDnhoFVRFXoa5oDOGq3T/pu5Afgrf
	t4nq+WbjJNUCyfY669SrNvow8XxFTqI6F7hU8K0SUV/DSbrvrCvCZqnaDzfthZ1pSCzXlZU/s+7
	4xg08x/9jI3jB1QPGM5tTVQRUsRvuS4CWzhOCEecosRELJMHvzhSsxH+wD0xuX4+AbJF2LHQ5pe
	Td4q/7xkCMQZiptvACam69OlNvOiHmeY1pfsz821IxsC9lpEruo2gvjBx1rt4wGl9vZEtQAA77h
	+J8XM47t8GQUHTjKNvex0CxcBaLK9v/BG3+dgDcCZJCI0tsyz+69P2l4V5zGdqj0kE3KpdrZw/4
	lHaYfkZXcPyjBvnOlPVTIGj0zC662CDO+jvmq3g8XYBlOsiZlaIMFC9JLGMELNEnlOpqOQ1rUGc
	X622ek4=
X-Received: by 2002:a05:7300:cf96:b0:35c:6366:1d52 with SMTP id 5a478bee46e88-3674df52799mr2205316eec.21.1792566239253;
        Wed, 21 Oct 2026 00:03:59 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405edd7bsm4512649eec.6.2026.10.21.00.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:03:58 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Wed, 21 Oct 2026 07:03:53 +0000
Message-ID: <20261021070353.50603-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179256281931.3133.3826869783117765302@kernel.org>
References: <20261019170751.200446-1-w453y.me@gmail.com> <20261019170751.200446-2-w453y.me@gmail.com> <179256281931.3133.3826869783117765302@kernel.org>
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

Thanks. The first issue was fixed in v2, which also skips subflows in
TCP_CLOSE. The second one is right: v4 left no remote ID 0 address when
the initial subflow was the only one, and broke adding another endpoint
in that case. v5 falls back to the msk's remote address, like
fill_remote_addr(), with tests for both cases:

https://lore.kernel.org/mptcp/20261021070324.50533-1-w453y.me@gmail.com/

pw-bot: cr

Abdul Wasey
