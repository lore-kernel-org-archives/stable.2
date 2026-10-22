Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634652;
	b=3cCRXK0Su4z7Rr8YpQe8A++vP+GZT768sXWQm2frDczqaTf9NTc6yjSP3c4JEOlkv+ww
	 Jqk/YXC9VDgoEUmpI3CTw4eXHeSWvQwLDXMe+Bcv/O0np7zoy0IjNJQO9Ny7s59oUCuLN
	 QA+hJFeN+Ds1cw57nCipZjymkjbjanZ5VAYp8ttdvmG1SbGoFwlDG1dL2+lIgb6cfG/Cn
	 ASA1Ysy/IF6F/vJ6CZ3V/IuItto/5LmKhH5b8W5CJHZe0jtkeCZvpu7EVK+vNzTEOnPqN
	 yiaw78UIXaj8ACN7Svda7ThM3za9WKBd3g+p71s+BNV93o/MZAKffuE4RoNRHnWAiUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634652;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vOYgRzzdBZVb791ahua+Vd9VZ9mzQ5ffdxL3uGu3IaU=;
	b=dXWhamL72kerQK92TVhxRPr+aOfP11QKplXKrw9L4p4vij2IQGpO9ypZ2hOwOhqSs+Jq
	 naXatR/8eEKYb1cJdTOrBaq7Eadh1QjWB/tj5rhqcKJKChB7iyHZzqsZYub9rJF9ldjVp
	 MGhIgGsndR8IiinvlYft5U4HijScNQOOVU8gevY3iz6HEp0suV/cgttQR07CRXAY9yFI8
	 N8dH4GmTXxBGcgfegelixcengvKdKzcov8pm9vrZRmB4+YIf1BviVCXXMWm3H/OgeBC0u
	 r2LmAh0bd7jp7BZngA3bPyFg7Yzasd91k/hXPWjK2W/1yw1e4+Hr0yLmzmqk2ohYRMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z11qdJUf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB032606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z11qdJUf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE0A1F000C7;
	Thu, 22 Oct 2026 02:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634651;
	bh=vOYgRzzdBZVb791ahua+Vd9VZ9mzQ5ffdxL3uGu3IaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z11qdJUfp1Clw99b1QYDZY+L5tPsWsU8FCF+NnIJs6rL0x38Asb1gAltF+3ZKxyI1
	 n0amEk8QGihiYxr9h+mi9eGaP6Z4OYwrRyRf/ehZbOJBUBCC7IK4AEG9kmD/735Zgw
	 tYQP6knEFzLCi0FxpHKkdEKdrdTQoMPZmqAZtglYptzL54sTAp1ra2wDqrEpEDO4ew
	 K1Bo7F2D3HpFl0oFszZHVtKpVim0aksqf01bwPY05Oq/XrcYapGFvxU+g2wOR1trdV
	 tbBf9zfCwjWzKuYicM0pl7czFd8WLzGH7ntn2Cee/waIjrwO5onAkVOQUZW713+uv4
	 IirFNfVC5IiGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Zhang Changzhong <zhangchangzhong@huawei.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH] net/sched: cls_u32: skip hash tables in u32_bind_class()
Date: Wed, 21 Oct 2026 22:03:37 -0400
Message-ID: <2026-10-21-1-daily-reply-0012-cls-u32-bind-class-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2026-74739-5-10-v1-1-c4b65c36f234@bootlin.com>
References: <20261020-cve-2026-74739-5-10-v1-1-c4b65c36f234@bootlin.com>
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

> u32_walk() enumerates both struct tc_u_hnode and struct tc_u_knode
> through the walker callback. u32_bind_class() unconditionally casts the

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
