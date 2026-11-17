Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923764;
	b=NowgX4uwZnAsv5aXr18fAcbOCv0nYbbYgYnH2N5askMUwfnRoa5Gvi9cvxpNKe5uPzOq
	 5qD4cCs+1fqjY0EPkY8iIuZHQ2Y8NiNENYM2uqLavKlFxEwnFEBAe0z9IsWOhCkgbzgyV
	 f9ijm1IUdg/lMzqhQte9j8+LtgyOMMFWmUr8Ysdqp7c0PPhG9rpXCmdcrUSByLFkZEtGF
	 9idMMjZAMfDdoX+Wepi0ZnPjHIOM4dRFUq3EBCMkA6lpo1OzBG1BZZOdG4SjoyrgqbwpJ
	 cP9LD1WQLMTt9zJufaHUlhebz4/yGa+ofpJ4SQevsuEvCukDLOCAbVX5hKSu/3/PrQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923764;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7Q2L8jjilb/GpNsWuFpT/b1KRGx6wj/KhSu95qexhro=;
	b=os34c7pcWChhq3fJBvHMZTRUPXt3DoEAyMEvZvH+Dw9f0+ReA3vQANGrbmrZ15JrcYUf
	 3WSfIO/N/fNF5OUdN46PfWkJgLrfkh+lYagiHFE42rs1WT8sw870takVzpyWcc3ScxmfA
	 fe63RWPa80EIq/XHx53myX/u5CfzVr+o/3YXUcnVeyliNZm+JLL1+vVXtwrBtRnN3qamt
	 pdHsR7jewQ3VtR1X5fyR9SPjoYQA6u1UaUx/euogq2KcCr3RXBJtHzxhvZHzvJCZ2GYCl
	 09HP5g8MtNRC9mCORFxlfdojlwdlqierT7Gmx8owrphHIkdz9iHCU8Fk7Uggc3PANIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U36rQmZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44913606A329;
	Tue, 17 Nov 2026 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U36rQmZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57851F000C5;
	Tue, 17 Nov 2026 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923764;
	bh=7Q2L8jjilb/GpNsWuFpT/b1KRGx6wj/KhSu95qexhro=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=U36rQmZvQJZraztVobO19/Jn/B5zdB3FWdeiAGrQTzC0vhfUeKlOTYp2pysaKxXSF
	 2+k1M0IPXaBzLMjvaMtx6SYCB8C/w+IGAd/WtDwqtptCUg7z98iJbZBeM/gBB9Pq2C
	 j3Gig/HFuBJOrqYhKgCJEEcpwNTO37qC7PTbRgqVrsMlMnuybXFZPpvbMUGdbFqwcr
	 pqoFleR1tSqpz9FPo4OmrCBddyxkA6mL1RPeVxL9lhQEMSwOjCQoY8xhp4sbF1ahwl
	 IvdKyz8lfSIv69vd9eEfZQWV1L+5me6a/N/KtGh0GEqDUTfAKg7EU7JNEaXU3m5MUe
	 tgqws+2enkaQw==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] media: iris: Skip redundant decoder input config
 params
From: bod@kernel.org
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Vedang Nagar <quic_vnagar@quicinc.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261031-fix_dec_seek-v1-1-cfedf0c267ee@oss.qualcomm.com>
References: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
 <20261031-fix_dec_seek-v1-1-cfedf0c267ee@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 13:55:58 +0000
Message-Id: <179492375803.2846709.17266637550647614190.b4-reply@b4>
X-Mailer: b4 0.17-dev-e3fc9
X-Developer-Signature: v=1; a=openpgp-sha256; l=658; i=bod@kernel.org;
 h=from:subject:message-id; bh=7Q2L8jjilb/GpNsWuFpT/b1KRGx6wj/KhSu95qexhro=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBq/FzuQUtuXyJFgJTPQ9BF7I2rHvKqSuO+HB0zL
 Jm8xkCmnTCJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCavxc7gAKCRAicTuzoY3I
 OkhyD/9CbN6TAojopt3QE48PMtLqCQ+tGlmI+b5oXoFbPhVxnUDxh428z+aeWwN4bZuqK7dVd+k
 NtsVDCCJxzlwZG+ogMBqS/zJLg39HdCqnTcBCl/5yEVMMTKG1nsMthpVJ8s5xC0ScGn4UPQbvaD
 J5k2pR+uin62Rq+oMOP+iUy1zTygWaA6QWcIsCzsDDH+gcLrhggPwsgsJnx59mVa7p0dQmw7YXN
 7ZR839kWBocHpKg47NMzXr7UIRZgj0YtLopm1uHnE0DGPbhjXBHBJ+fnoNWkmWh6/Ko2sKzBn4t
 R1X8glIwP5na9A93tTFMyo7WhedflVGLAz2an8mSgj97HfiB7AdBB29eS/2jBsD06nNdPlkvmle
 SYuDQ6BzxSgNfOqOKgp4AP1NZrG+GK6yf7hLdEIc/thrgCbs1TkhEerN6puj6HzDB0z6dsFAB00
 O8w65xz8H4Mp6DLoq9hZ5K32a7D7PDe0Jzf3rMrYj75yBf9lm+chkYvtILXe+MzayXZ5c9T4iZ8
 /wGChVvbx25e9HMV7fBtnjq4YmmV3Jim+KYTFKIe4D7pFdZAApGMChYfDOTRpmmZ/StVRUN+zbC
 8nxnaz8qO9eme3+fpzagYhY0u58TNHxUUC2MRLrlJNnDaNqDoWyRgx6bkF1uNTLsA5c08PsuST8
 eYc84NMs9gaUulg==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-10-31 01:49 +0530, Vishnu Reddy wrote:
> The decoder input configuration parameters are sent to the firmware every
> time the output plane is streamed on. This includes streamon after a seek.
> Resending these parameters generates a port settings change (PSC) event
> even when the input configuration has not changed. The client then
> receives a redundant resolution change notification on every seek. A seek
> hang was observed when redundant PSC events were generated for the same
> configuration.

Its not clear reading the git log here where that hang occurs. Userspace,
kernel, firmware ? I think you should specify that.
---
bod

