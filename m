Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634638;
	b=Eb+9NXIS7jbaBD+affWCdT21JRsxCAixYpvTUjNjmfujBJ9+2uTrItiROgetO2LzlI7i
	 RpgFRPSIyBw6Urf6US07VtW4+D5p8s2yYuaghJDt3EyIYUIvDNnaXdb2PCw2hnTSNsXZr
	 XLqDlXnUHv+c10u+qmgU5UYwHi5CQVHB+l6/qyePM8rQaPSoqyN1RmZ301/ts+FYcuGo1
	 3l/hFlbydNZHpini+ey1eBu6vBus6l+HnepmjYyqG+gjOwKjIOr/vweEV/Y0ESQqTpJdq
	 cWEC/M+INnUinuDM92cFCMidTDAmttmj49niDJCzyR8nw4Kr4rM4kn8QNtL/eLd0ZNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gyTtE2uoUyP3JQvCFV/kqaMvSasPNhSKJs+GgQuwHjk=;
	b=PUkLFQ4RCNcoME21t06RJpXhbxrUkGaMWDxXYjF4cSo5lz+pw3s8fkTVknHS+yNrGqDU
	 kJT/LEerUp4Kt3WTAdasGYOO3aoZ3V89noEl6zY4bA0YSyGvQhTFUDCoTYQeGAojp6vJ0
	 Fq1tgZ6CZ+oxHv3n0fMirOYqpJaFCbn77Zkk6TC340PWAv1thBA2x3aaUXxuI3lmUuVGI
	 yp2XNtOjb2vRxAu4hr/o3O/NHlQ/mqlaEOi30QNhRvdXUmBBp52S+JxDndS/VdOGkAmJr
	 bgnc/Ag819xIoW0A2zYwYVazwbndcFGQOiW5i42elj1lCaoPI4MjeGki1FfEt+RQwYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1lDYq6c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBB606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1lDYq6c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1921D1F000C4;
	Thu, 22 Oct 2026 02:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634638;
	bh=gyTtE2uoUyP3JQvCFV/kqaMvSasPNhSKJs+GgQuwHjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n1lDYq6cVHs5/OmzIELn2xTOVH/1i8+/w0MhTcrioksYF9RHJzhKv0YNrpUVGuSnA
	 QxPgRy3+AiDhjRvHwK60OWB4Vc7cnMmSYr9f1IvdfDgXiyDVZpo5unSH8GcZM83UjG
	 8jqxCUffP+ZUFz++oBW5YDuyoxKj6HiOOXQTlXy2m7kH7FNTCZ3dwmmkp8Gf8l1taq
	 KpZ7u0TT5K8G0f24JCw2S1FlPYmmiVSUWIbQkY/DlCSUDjZgajynwgdUmyV0o6tkng
	 9z86S0QlX5kKIk0K5GrojIhf9LBQ5CJtK+bujoZq2Px7TCs1/y0R/lDdHWFVd/xv7/
	 xWZIlvCHp8c2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 5.15.y] mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF
Date: Wed, 21 Oct 2026 22:03:27 -0400
Message-ID: <2026-10-21-1-daily-reply-0002-vmalloc-ptdump-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020093017.750359-1-ljs@kernel.org>
References: <20261020093017.750359-1-ljs@kernel.org>
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

> Currently there is a nasty race between ptdump and vmap when attempting to
> map a huge P4D, PUD or PMD entry:

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
