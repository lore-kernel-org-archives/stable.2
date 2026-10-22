Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634646;
	b=VP8spmMK1i8F1KhooNhRh5saKiYZtI9qIMpo/OtPvHIHIJKIDU8tfdnDLJ85YyfAi6ds
	 0zChSEV6G9UkQlWJdlDu+nD/6ien9xmoPkRt2ZrLTuKG+wpM7QZKMFcJ00I8j6OS/zVwO
	 bIRDkMGRE3+du7aPjpZF7Slw1QlUK6eF1YZ0iea+umkJMmYPgZeGg1Km61bWT4t2HbgLA
	 tksoHz/kCrLrnSS6H95x6SFke6AKL36wUs0qD+lb6wg29giEBrlMzEZr5hixuTPOZUOWo
	 vKqVtl6Q49uBk4owtjyT4WeDmk8LoF/gpv+9Yb/rLA6XVjlEze4xxrUMRM5EKJJFVRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634646;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KWREijeQE29uLv1OJSfk3otBI53w9OdC4ec/MY3ohQA=;
	b=X4W1vh/IqoEy44NU8kICBkHQ7crcg/AohE9381P1w2QMilATfyemHfAa9tyX3l0uMGa1
	 PZRimQW0eEbnsTZlfGdUNAew0G7na4UVuro+E/imXNs5IHZzwchNeCfkG2BJSCPILRfbq
	 atAk6L3iWeau93cbon+gyZ1bJTLaX8C08bMP3pE9R3YZuVK5dMphWGuzqWmeiVMOBSsY1
	 mdtgFCLDqQgUt6W66SYPKdGmmNAevL21g8R6TF6LAIOP4AkxRA0JPRY6280AvbQOdmH4Z
	 RK0BO4RA9MNlVLCdlZW++fkP5c287s4w1mBB+WYUrysS+yTFdYYKfXR8NA1+etxropg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ABbZvK/k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE4606A325
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABbZvK/k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31481F000C2;
	Thu, 22 Oct 2026 02:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634645;
	bh=KWREijeQE29uLv1OJSfk3otBI53w9OdC4ec/MY3ohQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ABbZvK/k0pn9ZHpX6XX4XWxbDKGhbXJrAE2EfeTZF+05ZYAZU3X4Oo2U4fOaG/TM4
	 pQKzwpDxB4bcciPQl17dBLxFK9JfCG9mi86aqS+hT+wWKYQI+/wM8oOxAO/tG1mlbK
	 yB9pk/8wZc5OyCStpKNjyFkvXTU1gJ0SHlOZwhzq7x4ayxjQG1hk0RYfWKSq3TAqLs
	 CvHtOHeE17jgdIFHCUiGOppBrkFu/PWoZ+MC89k0X4axWY/UIbKXNNG9Rc0srPxfOL
	 zcWOgyzAlRr3D2ucYe6e77tUjH6R/BAqDMbNuk+uEK7CaoWguOS2x/UER5EmIbtN3b
	 4xYhX6bp0R/YQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Stanislav Fomichev <sdf@google.com>,
	syzbot+838346b979830606c854@syzkaller.appspotmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 6.1.y] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE
Date: Wed, 21 Oct 2026 22:03:32 -0400
Message-ID: <2026-10-21-1-daily-reply-0007-cgroup-skb-link-create-6-1-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2024-38564-v1-1-0f8b454b9ef6@bootlin.com>
References: <20261020-cve-2024-38564-v1-1-0f8b454b9ef6@bootlin.com>
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

> Add missing attach_type enforcement for the link_create case.

This is already queued for 6.1, so no resend is needed.

-- 
Thanks,
Sasha
