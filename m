Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798919;
	b=42eF6BxfaHsiKvax0Qd1iwZpizR5zZz78Q8RVFo48/pHk6J9GqBhDzG4qnC6BVG/ZZ/w
	 1QHRseNxgGBPXNe7gw8AaSg62AzPF1LpTd/wzCbXXWHb9ymYc42O7pzfh+coyjzjMLRe1
	 FKMYRgn2wxr99NnIYg6pMgmj9iSTxfh51Qs+mr8e16chpknypj42A1y7bxwf0asGVt0TQ
	 MueIOlS0sB17A0cUg6oTXDYPBOo50WfM8Eq5sItnP4hkjN9hN31/b7wg+zdFrZqb2KhF2
	 zrb0EiNMVu26J9ynAgs92BapYgo7SUv3jAuIrRWBkOyXbru6+FVebM0Gk1TIOKuWe7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798919;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ztBR1ptgh7GQqiuo/qRymv4crCTasz2wMBF4Htfs+/4=;
	b=knxDUCBdJiP1T+hckFRxTcWdJEOU2nEGHH+QboWAyq52r2g0SEa5bDcDUMJuBIvQaQxk
	 3kaGCu2FkxwLOKvMCL+OyCHm0+ifoZxxg67nceNpX/IohHTCtRYoAWzfZ8cblWjcyJyY7
	 OakgnT2e/FAoi/WMMt7ebueIYEb7Guuu4NT3oR6lwx93KtFOiVD3uM9lpgKHjX6HqGU04
	 Rq7y5ciCegZsroyHADrLvce7AJjMUGaJDIQIA1yk+9N8ZFiW3FZyQfmXUzD7iiG4coCrq
	 uvesfF88hSTXUkdEeGujXVcG0m31YpKJXGDZZZbnHojPFRlB0LXkFmHJVey+M4dLSkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWPqVjR6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F9606A337;
	Fri, 27 Nov 2026 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWPqVjR6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF111F00931;
	Fri, 27 Nov 2026 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798918;
	bh=ztBR1ptgh7GQqiuo/qRymv4crCTasz2wMBF4Htfs+/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lWPqVjR6NHcqtv+sS2sXcxvrSbmvUBRXDby5wdNYM2MzAEqTudoth59t+W2ad8ROT
	 UPFHuddXurPALabNszTMOZWEAcNgZjha5LUN9hn6as3OPxZgawD0QT6/jGNBTuy35q
	 lL9I+ZRP+BKs4RGucp2MPPbLgKzZbziDd2LrlC8ENgQe904G4JR5ITTSVFENRa/J7V
	 tAwkaQL7qYCZslmNJ8e/LZLOPjET2pAKyUPTza93km+TWOfp77phB9Tf4cF0+WbPUj
	 rwhL3/pTGQ5tA+UEpgtCj575dMaliTWyoJxflUxqoEqvKqg3DyYw4O5gQI/s1YCMVc
	 mnTrqefnTchvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Guillaume Laporte <glapt.pro@outlook.com>,
	Vincent Thiberville <vincent@harfanglab.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH 6.18.y 0/4] bpf: Fix interpreter-unsupported insns
Date: Fri, 27 Nov 2026 12:01:02 -0500
Message-ID: <2026-11-26-1-daily-reply-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126154714.169698-1-leon.hwang@linux.dev>
References: <20261126154714.169698-1-leon.hwang@linux.dev>
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

> Request from Guillaume and Vincent [1][2], backport the following commits to
> linux-6.18.y with editing the commits manually, excluding patch 3.

Queued this series for 6.18 and your 6.12 series for 6.12, thanks.

-- 
Thanks,
Sasha
