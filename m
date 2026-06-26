Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCCF2C11E6;
	Fri, 26 Jun 2026 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496489; cv=none; b=aMMJbjVvfz+wQXMgQqLhQ8ttm8SW+Y24GN1YL9kCTCNv1Hms8FMs4Zn7F6TCidSdXoOgIN8Tb4wXB2H+ZL6gztl0hbd0uf4dE0IMRp4NEJy1igpUaUoyFJhTyjJvFIeVtHrcHaA6cprD7Ytbu6AczUW1ZIC9PRZLQTLYwpR8Irs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496489; c=relaxed/simple;
	bh=fWY1L5E33ij1sq5JxjvtTVeurGVe+ZpJw13KZ4lYOPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=topr5nhFFaAacGBVcp+wOyWwO820KoluRVg/ifk5Xx4YQ4TnvIX7aewIo5Fur0Lbfm0TnW8fLwnz64cf37WRcGRopNk67k+Qa6ND8r1MUjsT7tOKfGOaZX5NQD1q4jOMqd3qfL2LnxVBz+JRhQzHRbKxoF/VC0nZd1GA1+JJwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWNZWhjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWNZWhjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946DA1F000E9;
	Fri, 26 Jun 2026 17:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496488;
	bh=naDAuYqy4XkbKqdknCBSlvNc82h32BG2nbEtcBo1JHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZWNZWhjLqtskbLn6Tj8yNTc1CeGzMRI9L3yF80ILe3/h1mwx+nvXxMqAGvPCazInP
	 mqtl2h8V+SyJs2H3x0oCoLPD6SfkgiAmya+LikXadEEgcgFSpmZU9ymLos+EBPyyIe
	 JQc+2kLKpzrVIR1dgajdemDs00hLoFXyhPtekn7pY8+VjkfhFRbgQLC4f5v3/pI4W2
	 zZSuCL9UKLV/0lKxzYdSghjfdW9u27idU0orvfy7Zm1ws8GH/94Gw3282N15W55w9X
	 KB83vOp7/woOcFB1QS71bzU26bQnqPN/r2eYvybzrz9/9PNBwySkaUKvOKjJtpJ+Pg
	 +32r5EFs7Evug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:54:19 -0400
Message-ID: <stable-reply-item006-role-71-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112232.1776865-1-pbonzini@redhat.com>
References: <20260626112232.1776865-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KVM: x86: Fix shadow paging use-after-free due to unexpected role

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
