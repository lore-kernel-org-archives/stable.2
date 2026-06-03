Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE443AD52B;
	Wed,  3 Jun 2026 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499687; cv=none; b=cbLF+O3D4RHf1Hb1/CO8HYy96XI8hI5quwVnpfNlkonIn/vBsBZ2yhnJsi3tPW/m2SPvML8cK8VtK6G9WnPG3FrVQ1/7u0YeaxsRhnyYMKXcKVEhkJTfTFxSnFrtcLm49l3V9s+CqMSvGgt6Ki857TMEfMCv/rGzRPRIgtKICEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499687; c=relaxed/simple;
	bh=sfJFFRIt7ZtI5VSlY/vt/ttfsmf0TZHVo6bPhf4KChg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WU3La+ykwNB1DOJHqXI2M64gOSeO8yTgL3VlWO3ZjRHbS2XEeOLUxtQYXxg0klwzVrSyJ4XsKkIsK9dOzXo6K/cib16T+jePKGyJzsdWQL3oZ/RVnDG+7oNuAteDVznUSklSwn2KFPFu8/3bddGl/pY5iSTxVa66MdYtp05nEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlenalyA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlenalyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D741F00898;
	Wed,  3 Jun 2026 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499686;
	bh=q8gVi/KLN4RUu/hl2nIvT0jYawQsD47v53vKakKU8zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IlenalyAI25X2pwHqJJ8/93TFOIjYZTFa05KP0tQul4B6AoYQ3L4kvq3L+PMWCJK8
	 np0v8vEvaImhcIi/tfzMYPpeQlNAiSPTjUH79S/BY9XNdBParsdx8DvV+a/RtrVovz
	 STm7FiJZCm+lXenwzyUVmPKXRJCzPiWDS3ug/dGt5u5h/NI5ZnjvN+aYOWIg3wgEjQ
	 YGtP0vVDtMsK+aNsxD3d1m8IOv2GA//pgKte7JyuTy4mCo3TnmVP4EZ6rrjCP1W7gL
	 mId5vdfmnudQsqDqSfvvmIUVZjEfhhvaPLvRzFAk01Da9xfwX2mN/CUNSQB9X6b3jR
	 7hEywtPZwtTpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>
Cc: Sasha Levin <sashal@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Chi-hsien Lin <chi-hsien.lin@infineon.com>,
	Wright Feng <wright.feng@infineon.com>,
	Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Piotr Haber <phaber@broadcom.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com,
	SHA-cyfmac-dev-list@infineon.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work
Date: Wed,  3 Jun 2026 11:14:10 -0400
Message-ID: <20260603111500.item035@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528055431.4124445-1-rob_garcia@163.com>
References: <20260528055431.4124445-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 5.15.y, thanks.

-- 
Thanks,
Sasha
