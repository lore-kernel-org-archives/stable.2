Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634645;
	b=aWPAljPJRjbmob76yKISLj3pfObefXIWw3CY5Ez/DmiNjsBTcSiiA+XRj7AFiaTIu9Dl
	 jr/jwA6nSpkDEeze2VDunNrLe/I7QHooyb29UrlfS5A4AxmTRE3OQrWxvKhnKH5cibjo6
	 JSi2V885s2XXarnuy1V8DWH3WpWFJk/K58nG3q3VvcSIPcKp4GLSg4Sx1Sd/GZA6/swrs
	 Zl+OEWn1yvNbRUbu1eq4ffv7d4YjFDFGpfAH0nZy/PaGHWX1589x1qn/w8dux/xD2Q/EO
	 VCRwK6tQMv/GanUfUwMjY9ba7UnzFEOnmffZDXTnNm1Hr7F1HpQnA5mnpbnfgNRUS/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634645;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D186RsOPDw8rmImQs44b04+WZUHbh0p799zf41rcur0=;
	b=XKBRVkFUvsomOkHIBSETQruZy7bWiXh38Pidi8OOFeO7ZCRGx/HUmIEalYikz0rxV0Mg
	 ahsfoRdyndzxJFPtn4Pp6rMI0xPitGNBKiG8FQxazUZ153Zfocsn1RCaKC4YjQnjwDOdd
	 aZ2TLJt+hYC+o1lDn7GzjbPswzlIyM3hWG+EJmNu9DHn0RQeqfuQq/+j+95+6lB4swEFM
	 g15jZfyOtISL3cqaAwlLtoLuFgh3mhlsIM8uC8+wkgZtDsyQPRsmr5RyL37NTbBOfT4RN
	 YLAdmCBn0/Io533ZvXtbYJKOF1DtrcpMUL67oKo5NsdEHQm703T7eZZqA0w3Dt08dGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtVqF0uP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305C606A321
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtVqF0uP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD351F000C1;
	Thu, 22 Oct 2026 02:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634644;
	bh=D186RsOPDw8rmImQs44b04+WZUHbh0p799zf41rcur0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtVqF0uPIB7WB52gI61vM5+Sl+YAK3E/JUSVgNKj2BjfnvBJSL5Wfz2VikDg1gpy4
	 2J89H2+GIXHk5i9m7qQEhh2kabN1Q1PnVZSoCyLUi2BZ8o1JBBgyyTOTeFX+qcJww1
	 ylvQ8DM3j12Gr0FG4mH+bf7WPQVZZD8/lrAJQVS9uunlgmdK99/em+YNFMOCawLhCf
	 mnl76e1M77c1D0LJE9JGe39LXOXAMYfrjP0RPP3qBx1GTCYUdV9YDoe0yDxbtHvKPs
	 576X9eUqMMSJfJ+2M3s6tvQt1pjX8+YCddiL4JEsbTAPUNfyEybmXcPnnpcy/k6FVI
	 G4qRdplrgfStQ==
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
Subject: Re: [PATCH 5.10.y] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE
Date: Wed, 21 Oct 2026 22:03:31 -0400
Message-ID: <2026-10-21-1-daily-reply-0006-cgroup-skb-link-create-5-10-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2024-38564-5-10-v1-1-785c0999bf7e@bootlin.com>
References: <20261020-cve-2024-38564-5-10-v1-1-785c0999bf7e@bootlin.com>
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

Same as for the 5.15.y patch: link_create() in 5.10 already rejects a
prog->type mismatch, so this adds nothing.

-- 
Thanks,
Sasha
