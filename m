Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530056;
	b=cU/ztnNzQrg3aax7SHg5E2siTImJS1tlK2qG0pUf5L1uEJWLQ/uxEPs1EH138vhVw5Vi
	 RIOR1dbhKml24T/5bk+bfrfkvpsRaGKXaj39lUda+mNxIdXEIhiLGXuNL9yxrB3PNwm3p
	 pLCz80bH5kgihbuDXcM6y3x2xBmzlLzEHNDJvwgm9E7YCwSnLeUZ5Xt689vLbir9MCxbL
	 LZ1RIU0mbGIPlIX2oEllJUZ1y64i7V8pIfE5h1ZnQznQX1W666gqFtKIDVQG91Q4f6APQ
	 Y6WkDaX0T2U2qHo9RVi+hkqPsaWyqmowAEft8gb8rxB/X5bwpWV3J2mMTjW1fQ2mWcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530056;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ChUOIQNUtXrtFdhA00nCLe7t8Y8/cC4syEz/n6o5XYU=;
	b=aJsSCzXBHf1oqj2dVC//8CmnhzFPkmqfAfljW1SQu1SiiGntQGDr1OWMi8K8cAiwN8TE
	 pfLBjGBnQDMQNYi6XtJPsTWfL1Qw1Hk4VHBV/xjLCDXiSnWkhcxoABL/EKZgtAG60nhA1
	 EXEm9c5AKC6gR3okua0WUagAN7ru2qWwzBaT2jdWMwQ/8fcgyBmrhmhUlGdxpxxnLwtGN
	 qajDaI1atCwyOEvJfs4+Q++Sb7AhcBpfZcxo81VPT+tPvCvhnGO5E26wnospACUHEHVds
	 YoPcyqF3zIzjJXUV9ouYC8r6d4GQZQRE8jGO7DuPZ19RqhMBppdist4SfQmsG6wUHCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=EMGO2cU6;
	arc=none smtp.remote-ip=109.224.244.18
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA45606A31E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EA45606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=EMGO2cU6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792530048; x=1792789248;
	bh=ChUOIQNUtXrtFdhA00nCLe7t8Y8/cC4syEz/n6o5XYU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EMGO2cU68ukfaNZcc4irCWnoVMK9PEQe2KZutZSYuFH98ii1tX6U6ouPbowUh8hFW
	 hHmanQF1HX0Ea094BIvzY1GZgJRTRZf5pbU1IUC1ucTVjVbwOzOC9cXBang3hOGXaW
	 dtYvR2/zviLk5ErzIRUkWYJwe28ZJrxmm26ndvOn7eLPHrujUOQ+hquEKK0Pa58biX
	 X6E+6QgJ/Jl0q6A2k3u87CQrjFJ1L0GcLKSwyi5/GsfjBQbxSm4jcinz5NgYZ4oto1
	 2bcPNQNWoBFBzEPCy0WxEyTpiPnH1nRt1GJzaNg32uPxp/D5qzOjsEu029X2zyLlEP
	 N5+SgkZ0/qXBg==
Date: Tue, 20 Oct 2026 21:00:44 +0000
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Hungyu Lin <dennylin0707@gmail.com>, Stefan Schmidt <stefan.schmidt@linaro.org>, Hans Verkuil <hverkuil@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] media: qcom: iris: Wait for threaded IRQ completion during power-off
Message-ID: <179253004057.67768.17541883604161296564@pm.me>
In-Reply-To: <20261007-fix-disable-irq-safely-v1-2-45746f9a92de@oss.qualcomm.com>
References: <20261007-fix-disable-irq-safely-v1-0-45746f9a92de@oss.qualcomm.com> <20261007-fix-disable-irq-safely-v1-2-45746f9a92de@oss.qualcomm.com>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 3696101d2f4746d805262ac4724b99604f31f80a
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 07 Oct 2026 17:01:06 +0530, Vishnu Reddy wrote:
> Release core->lock before calling disable_irq() and reacquire it after th=
e
> handler completes.

When I tested 1/2, this patch was left out because it does not apply to
7.2.8. I have now backported it, with conflicts in context only, and
tested both patches together on the Lenovo Yoga Slim 7x (X1E80100).
qcom_iris unloaded and reloaded ten times in a row with a decode after
each load, the decoder runtime suspended after each of 20 decodes, and
the decoded frames match software decoding.

Tested-by: Birk Skyum <birk.skyum@pm.me> # Lenovo Yoga Slim 7x (X1E80100)

