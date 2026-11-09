Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239620;
	b=pw07uss2GMge+WL3MIJc4K63JgxjK2xfbxpT/aENW9La2yPVhi69HNpI05L1cLhd9PtD
	 km6KicwB7rzaHPjVGcRRraG3AXJpSvgePHJHQaLjMJ72oAyrQ4oknBeLLRX1ds728JhCQ
	 dmUUJPfSUNOVsaflNrDfFknpOvQoPNNZxnc0G0vzihUKpmZ76DsDgAQ+zhT+JVpVEkQ+o
	 zj/0TAeS+QJ6GXVQhM/5TtlUYKAhMXbl9DZhVuCiHocXQRpEltwjBcvjgMrOwuHWMcZiV
	 9p2hOtHlIqBGHSuZUKoTGYB8CBDIODVWggYnMrPAlpQwqSOWH9tFh1FmQJqJpD4uTkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239620;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jFo4skFx1oI7a6DOH6A0MdXM9DZv84YPwncYWI++UGQ=;
	b=yI3w5MIxwZi+hcsG2o7s05NiD791XNQfarCMTEdgUmh14nWMoHBjkYVYgPtM86dGCG17
	 5tg+mW5ornmOZa419EZQ82pKuv3eWalJXylT9eL4pQOyPllc9Opdx77gMYAJAkCpiBJSh
	 zbQWKoNCqtATlyUpl3xUUdA9UYGRXtTD1GV1Uu5RCnlPwiw/uYhB6y4FVLmTcSHwAqc2k
	 Fa9T33OAHmsvkTqXGTk1DwPNzmHklQ2Xd10mqsJL5ZWzTg0OBfKxv9pvs3fKbs8g5P3kR
	 ljGNznHKoLUSpoXlCSi4jjGJ23kR4HR6+54H3qfnsmSMA1eQWHqEp+NefRhklKrkSaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSqNGLtw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EC606EE86
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSqNGLtw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B7F1F008A4;
	Mon,  9 Nov 2026 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239619;
	bh=jFo4skFx1oI7a6DOH6A0MdXM9DZv84YPwncYWI++UGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZSqNGLtwm2xCDlLEQxnYL070NcU3UWxoSlu9lXkytY1ni5BlIFU65f2YiV17mV8Wr
	 M917vLf8gb+/4cERSyVl10a9gVHMvwuKEiuJDDFYIa3MSkK01PvfFHKY/4YNW7RG3w
	 lddjWC0aiUYF60IyNenkQfYs19DQDu8PjqvAVSWHp8X5Eaxg6wQiThJEyC68IKJ6qh
	 zXkG3res+WdDZU7Cpen0Z11vlVrix6hJsb6rGKxwYXpWj/RRmo/934CpnZRLPVS8K/
	 cHIhGV3UQfsmgngO8Mym6j7EP24DfDVS3rZnHI10IoHJsoQIwOrSzRbjxQhuzBFeuu
	 3kralhgboUxCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@kernel.org,
	Yu Junzhe <junzheyu1@gmail.com>,
	Daejun Park <daejun7.park@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Subject: Re: [PATCH 6.6.y] jbd2: don't advance j_fc_off before the buffer is recorded
Date: Mon,  9 Nov 2026 10:52:55 -0500
Message-ID: <2026-11-09-1-daily-reply-0013-jbd2-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109-jbd2-fcoff-6-6-y-v1-1-4ec879f3b004@samsung.com>
References: <20261109-jbd2-fcoff-6-6-y-v1-1-4ec879f3b004@samsung.com>
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

> jbd2: don't advance j_fc_off before the buffer is recorded

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
