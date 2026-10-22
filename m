Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634661;
	b=ni3kEBgsVlXXGSEF6se7zAg9HhbFD+plHPhi1Zn0suo60tg+1i+fnyW8l/WnAc3VOHNl
	 DbjWEQY3NSrVuqegc6o0Dll/q5TbB1qTzfaXuatEL9clMIH+SXeMYd48CGQUDDwyMTJI1
	 Q5hm7mnMtxKB1+qxsDP69t9hPxzNCkuQQJ7IdV+U1FgXTWU+m7WwntXvpFbcOsi7UEPg6
	 sRNcKOwpMx5/tGQrxiOo0NYtMlXociEVAOIa2fcfqwhT2jUKIs8h9o5p4Aqhi80iCs4uI
	 EzSozmr4UVukmzeDWQJdv4IcUrTp8U++MIYHLz4NFXG7u7uuGQ0BaJPLC1km3fMCfWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634661;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MKixWjMNMAPfTm1URbaW/Oh+/AlYgA6o2yZ8gdOjFT8=;
	b=VK3eO/cea0UATGlKskhkJ/zxe7jZORhpYVL7LXwGr/Ja6FgDiFh0b0BtF7/jPmENinOD
	 a5EawAKyLewpmmorEmx+S+noylMZZdgQ58Jj2X/s4wuIdR7d2BS3R5P6jiyfk+VGid7WX
	 eif7gmUmycwh+lVDn+LbsQ9kPvo0LP+wI95CvwREmZpGIpimmEGchOWzIvemPeitOMePI
	 8f7VfdDHc+0kc0+57/HySyhrieLb6YSK+AWei5uaoB1AP3IHEqIVEod8Km3tlKvG5Q17m
	 eve5ozj/+4LpGXoO1dK+LBqeNUVi8E+Kn47Ls7C24N0j1ImUz0l7UiryY/MXdJeyMQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAUpKLWX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0022606A320;
	Thu, 22 Oct 2026 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAUpKLWX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7071F000C1;
	Thu, 22 Oct 2026 02:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634660;
	bh=MKixWjMNMAPfTm1URbaW/Oh+/AlYgA6o2yZ8gdOjFT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAUpKLWXSGZYwhGXiYX0zWgjmMed8YfAJTKkRTDbVlJp5mnhRs2VDmnfP/ajdVj5w
	 xarq9XPjjJh5G3olKswlbJ/VwARkENiXJFETViIXn1PyLLQTvSIX7Mo/F4yBkJkmfJ
	 BpkECHCGHTj6W8YcR67SFItIE3lp2qiDObpz0kq4TAqBcA0cQojlYCaTj+QqqJxK62
	 yuidgZs+8NxXm1k2spx0AqyZUAA7Nrh/FJm00GmGMlxe9xFaZt9Kwb2tWtrsfJmJpY
	 rLYUCmrcrPtwlf+eXUF3kDf/WajIEQtZ5b4rr0iMxGPOrdiLogMcXYFMtU+EmLUI0s
	 qyzw6zbQfshvQ==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable/linux-6.12.y: (build)request for member ‘f’ in something not a structure or union in arc...
Date: Wed, 21 Oct 2026 22:03:45 -0400
Message-ID: <2026-10-21-1-daily-reply-0020-kernelci-s390-fault-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179258034449.241924.15241097267562754477@kernelci.org>
References: <179258034449.241924.15241097267562754477@kernelci.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>   448 |                         clear_bit(PG_arch_1, &folio->flags.f);

This is 74ccc099f1ba ("s390/mm: Add missing secure storage access fixups
for donated memory") in v6.12.114, which uses folio->flags.f. That field
only exists from 6.18, so the backport can't build on 6.12.

I reverted it from the 6.12 queue. The revert will be in the next 6.12.y
release.

-- 
Thanks,
Sasha
