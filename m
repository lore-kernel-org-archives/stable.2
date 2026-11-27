Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798898;
	b=eEOLDWgRoQQvJorv/6iCg9yvTwB9HnryMTh5M7oX0v6VDZcp/k32TZWxxb2b9S8IyjJm
	 F4kBkZtPf4bA+DkIAgV+FvA2jZz8PeURn36Ziw6GkBnfoLgjiplNTYKJec7HM4sG4vLS+
	 OZ63Mj/xC+ZNw9i/qPu/xBSoywQRz54sQgBTT0oatvMi2mQKL1L0z1I4ndy/g2V1TLICJ
	 1K51o5JuEPL2FV0nhr25jfHbitpCiLiqBANat8AFV7snLiBBuhHZzm+LMArry0ugnNMdT
	 c3n+nlvXvR1FSDzl0LhPIbjHw+eB198G/PWK1Gbpou87ydqeeYiPe+kx/8v6EYQ6Q5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798898;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fnICLWlEpr8hKNV++Wh8sUclv+RkfltPKWrdO8+U1kM=;
	b=eYI19hVy8ZH1R6Vt0hqmtuc1rCcNLmzhtb/vKX6kamywAO2YdDkUe/TguRMqHt3EN/y5
	 HqsnYUnl+Y0QjwqS41ktymewgjH4/7Crh1Sb53TemGRv7VNuQNUd+hreAlC0fbIbYnJ+r
	 FTbXKdF52RG2hPCMQd4jpzhd/Y3TJSQIJ/rbx9uaY2nN/C1LrVnqbmdR5L9p+mdG18jCB
	 kZNsJNq1wM6ySRzSF9rz0Z8pENU/fExQGSZtpua79LE16gXyUYTE08bflq5TPXDhe2Lcr
	 o5SAYDUPA6/xuDTNAi22rJ1P5qON/WqN1v32dsjHYSPegxfQPqNDbT507Q2Iglzj6pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiFIYGHX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B650606A31C;
	Fri, 27 Nov 2026 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiFIYGHX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC14D1F00898;
	Fri, 27 Nov 2026 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798897;
	bh=fnICLWlEpr8hKNV++Wh8sUclv+RkfltPKWrdO8+U1kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TiFIYGHX4jnneuyPztjYqi0ETsOX0JMxwEDuxXhqMof/Quk8qGNsxasuJaTHbqgAy
	 alCY2zsNacms4Rza3julcOqRjPSyvh4+F0Qq5EOUXMRGbEiOwL9ULRrre2ZItACidd
	 irXat+sOq4jtXd9O3QhqwdJF94MmcDk+76JFmfTu4jYucwHmfqWaZNGM+7iFrHjvpk
	 oRskpG3tC1KJhkBKHMtbGyvMDgsp8YRPLmt0iXXnhnNFO0/rQNdk4LIHMe/zvyn9X1
	 EmHWPDvYbR1rSzin3m34X4sBLkbwr5MFcL4Yluhvl9Pk7itg290KtsRsfVn1fqjI2q
	 qwvwllyCxwf6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>,
	Kang Chen <k.chen@smail.nju.edu.cn>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 7.3.y 0/2] sched_ext: Backport two fixes dropped from 7.3.7-rc1
Date: Fri, 27 Nov 2026 12:00:50 -0500
Message-ID: <2026-11-26-1-daily-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126162700.22257-1-yphbchou0911@gmail.com>
References: <20261126162700.22257-1-yphbchou0911@gmail.com>
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

> These are 7.3 backports of two sched_ext fixes dropped from 7.3.7-rc2
> because their rc1 versions failed to build [1][2].

Queued the series for 7.3, thanks.

-- 
Thanks,
Sasha
