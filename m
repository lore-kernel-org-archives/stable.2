Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634644;
	b=Ozvn9S6T3PMtnp4YGH8MT91lfn8+upsjzWdg2BoxZdCuok2lqcCFCS02HUuzJeIeeGGS
	 GLrqcSmNaLOXCxawQPaa3a6rC28wRejTpjR9NG22Rbym9rC7tl7ggMhfY9qS6kgnV3bXQ
	 uIeqeR1uq9s5QiIiA4OCkkRdBK10eEZtiyM/N5WCtRVobhOyqWK7Q5Ly0FmZ4ca7xzrVk
	 dkRKlrmDKRkELA1pBUFdub86Q45gJTY62pmpS6xnlNO/Vy9jyE1IquyOFM+TK/EHQIhRb
	 gNPDPyvYzX4QgLrrgBX8UQ1Li+IN2WL/LI9UZ/dahpTuLFd3hvPbWuJMJQjNwa5JtnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634644;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yHeb+TekU+XC5c27R+SykpXIanEQHAogCi6gSn+ipQI=;
	b=N2EXjxhHYALCYUZ+YyY4qzXNUxnnXg+iIFj1d5X20r1Ln0vG8o8zgPQPRtT1ae7xCvaT
	 xyyTeO2P9FlbQK1QXqDtqd4NO+6yRwMl/2bjfiZE9hbpB9GSqj+18CVN17Z6v73i+RFUe
	 m3smetdReFb8CaHrXMEHUPHSTXgVPcCVhWvCE36KcUiNN/EBS7D+gtgO1s6om1A5mHwQu
	 qlA2aY6S3GXkc2idBwI9mmF7RPksaYhD6pbI0sYSfsmo9cfFhurF8WZjIBzLlwFfJczgU
	 r9X3hPXLmDCzKBDMrlBO0df9KowR6EnVxPwOjfFSKJyAWdwU0CmRzjv4UjmyOb398Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUW+4KbM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B13606A31F
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUW+4KbM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1091F000C4;
	Thu, 22 Oct 2026 02:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634643;
	bh=yHeb+TekU+XC5c27R+SykpXIanEQHAogCi6gSn+ipQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kUW+4KbMsJvl/Yy6xfm+dhrElHuC4trD6BsY8YdaLEac0QG2XLOMm83NT3u49XHO+
	 WLSYVFwEZtdWNnX86AX4c3g5DJ1YRh3oQCINTy2GPLshCTO9WvRXr+7tyxy6hVaPKI
	 4uqtXugxr3ll5wU/Hr3JLJJAUrv3DvxsZcwme2z8hPJAbI00D5l/cJV+yoGrlGOpFv
	 WMOUQSrw2bjeQrd7VFlZr6TbjDdAh3YxBUqEVpZwu2rZZqhEcx+s9Dy0UrkcTB/SS4
	 OH1ib7rVVSZqSjcU33YP7eZ0yLXUvcW/H54zekZjhVwOQv2NXeGpXz7ZhGLNBYjRzF
	 eFYDklqE7upxw==
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
Subject: Re: [PATCH 5.15.y] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE
Date: Wed, 21 Oct 2026 22:03:30 -0400
Message-ID: <2026-10-21-1-daily-reply-0005-cgroup-skb-link-create-5-15-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2024-38564-5-15-v1-1-9c9412a9c0a7@bootlin.com>
References: <20261020-cve-2024-38564-5-15-v1-1-9c9412a9c0a7@bootlin.com>
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
> Otherwise, it's currently possible to attach cgroup_skb prog
> types to other cgroup hooks.

5.15 and 5.10 don't have this problem. link_create() there still has the
check that 3505cb9fa26c ("bpf: Add attach_type checks under
bpf_prog_attach_check_attach_type") removed in v6.6-rc1: it maps the
attach type with attach_type_to_prog_type() and returns -EINVAL for an
unspecified type or a prog->type mismatch. A cgroup_skb program
therefore can't be attached to another cgroup hook, and the patch only
moves bpf_prog_attach_check_attach_type() and adds a redundant check.

The CVE's affected range comes from the Fixes: tag, af6eea57437a ("bpf:
Implement bpf_link-based cgroup BPF program attachment"), which is
inaccurate here.

-- 
Thanks,
Sasha
