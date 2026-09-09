Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B142A168;
	Wed,  9 Sep 2026 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985631; cv=none; b=WBPXaXu55h+ajNxRXMTsE8hySN8sZUZXl+EB5fH4JVTI6iRESWIfuRDd3tMQxYENrwNCR+Un2Gk6S0EXe3qwwsAU4SLF8lwmbFTjdCmevlMx/cm4MCb4vp3yhlPGzPnz+sJ1c3ZZmvsWbxr8si9y7SCwbCLTgveea6Gqo9HvE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985631; c=relaxed/simple;
	bh=J25A3dPuOdnA/m1lTkwhfvP5N+xRrHCX3pNi38tvZlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpeWorURb3Bsv/d6K76P48p38LgJ7D8erMiasHnEUbpfLYE6TcMzJum5XbsXmWhVPrcC+5UULRJ2LTjzJ/gIbIiMjGqAGF4j+9fdlq0FnXSq72GxUJvZngQEvC5YeFE26UgQVrFMXqaE0gxtl6OfYChYPgkPASesTFa7/m1mIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omn3XP22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omn3XP22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736171F00899;
	Wed,  9 Sep 2026 20:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985625;
	bh=1WkAA8rYM1cRIQUgKxx429MxBXubZ1B+gbpFHLpZa7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omn3XP22Qxae/GpSuV/ewrlt1UM3WMwjbh6Rjn1JRhnxeBugjxzxBIs3O0eXSjnz4
	 Kb1lIrx0X2Z23mhmFrisut+NTfrduidEulnx13lwBecWH0uHe/WzsdoLlp52vbSxuw
	 gsGDGw5klT1D4fafjIhedpWDgLHnHLkbC4pCgZSPV75FcH/S0nkT0l+5CejwS1ZxNA
	 0PBWID9K1Ig3vtLnIUN2tF51ct4P9rwx198Uv5WMKLqNEc5kh7QwzyrVy7miVuIh4u
	 j7Kzu8iIMztF4F7Mg6hMc2/3z2T49k3PTf0uj1hK2MeHfCqQLY6zoWKmEtTzEU+ZWj
	 UN5VKHo5NsmDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Andrey Ignatov <rdna@fb.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] bpf: Enforce expected_attach_type for tailcall compatibility
Date: Wed,  9 Sep 2026 16:26:29 -0400
Message-ID: <2026-09-09-daily-reply-0031-bpf-tailcall-attach-type-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908-cve-2025-40123-v1-1-be62451196fb@bootlin.com>
References: <20260908-cve-2025-40123-v1-1-be62451196fb@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The underlying issue goes beyond XDP though. Another example are programs
> of type BPF_PROG_TYPE_CGROUP_SOCK_ADDR. sock_addr_is_valid_access() as well
> as sock_addr_func_proto() have different logic depending on the programs'
> expected_attach_type.

Thanks for the 5.10.y backport of 4540aed51b12 ("bpf: Enforce
expected_attach_type for tailcall compatibility"). Holding this until a 5.15.y
version exists too, since fixes need to land on newer trees first.

-- 
Thanks,
Sasha
