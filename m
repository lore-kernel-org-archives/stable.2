Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344397;
	b=4q8f2sNA1q5xfaxh/4OLeZzcublG0cNgovW+HDBV3ZKnakj5EbAn814AodCtFLNN9oxv
	 Y5VNwANOK674DujpGnGs4/iFYX4VQACje6no7+xpkAh1HyYaFjG/5BALw8sGF0woBAIr6
	 9CGETT6aQaPeScwIw4m4IGHx9a7TxpTN93m97Kb0A6nnMM+of+vtNWyv0ArtQfBo3oHuJ
	 nqcEchI7ho7I+Kq+92M5nSpVRYhL/A5FdOZ3kcXaCh3Q0O+me1nJCQs0BwIKC135CDARl
	 kb1432hN7abf1deYbYFoFOrC7dpl3TJdtvTmIjejE0KAJCE21nqmBY1mZrW3Dvic1oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344397;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KSTgnwgdr4teeJicPAPrkDHuRbco48eVURoNsQoMiJc=;
	b=eS1JerndrguTz7GKGepCMlBYLbY3PPr9OIryda7GOrCbyOMhrYPZanwOjLPo+rLCBz/j
	 XyxumS1PMqb2xvJy3IX9nCyX1rCPqdpUEX0JxXcTz925zNoMwk6hS0HDlO3y7s6Smu826
	 CeGOy61aLs2Enlb+o7EU9hrFkZiQ+HO/jnFlRspd9K0V3q/+AvzqFcO2UwQrLRiMsBwWr
	 5ow1TAdt3+aQ1//t9ZOnxmnv033oaKNMldZOeWneKG98g+As7yataNsvNjN2y1wi6WML1
	 BSeaTHgwIFRkbnZ9PraftSY+R9o5DK2kW7EKpy8kspF0dQd0AVmx2gN3tzdgOxWC76w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfP7bgwU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B8606A33C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfP7bgwU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0752C1F008A2;
	Tue, 10 Nov 2026 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344396;
	bh=KSTgnwgdr4teeJicPAPrkDHuRbco48eVURoNsQoMiJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DfP7bgwU4eP5RKyx6hZZqrfT9zrAof82CCAhIJYH2PysVnYw2EZukCTVWjj6A4Tqi
	 tsKida7JO26WIwOAqT9DannYws9vhNRXVauTSuU88ToOVVqacyNd3hZFcxndfq2+Sj
	 oV4yj3VkJlwJLB0jWVwWamI9R3c7aGLg7iklMzmUbqBc4+UtxFoKu3vtWvR/kOiqtQ
	 opRTI8CA4E7Kh8Q5oj1ZVsKvFIF10YPN8GxDxb3Hj5bnXbcKdjQ4q3AJ4mc+UXcIfd
	 HXGB7R9PT3fYFJSODtqZjmmyLU5taCObRbaDi8dDCgFKNTbHGs9JWkwEEH20eIgGvm
	 424QzxZpWDvOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Michal Blaszczyk <michalblk@google.com>
Subject: Re: [PATCH 6.18.y] sched_ext: Reset runnable_at when a task leaves its scheduler
Date: Tue, 10 Nov 2026 15:59:21 -0500
Message-ID: <2026-11-10-1-daily-reply-0025-sched-ext-runnable-at@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110162946.2141451-1-michalblk@google.com>
References: <20261110162946.2141451-1-michalblk@google.com>
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

> sched_ext: Reset runnable_at when a task leaves its scheduler

Queued for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
