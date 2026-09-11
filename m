Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47C448B9B;
	Fri, 11 Sep 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125701; cv=none; b=OSFJ0FYgF0Xnt73ezIzU1+55cYrWiydTJDWfY9wRnBpWpRcK5dr2Bj5wqTsgdaPh0yefv3osefdDpK6vCp2Fd0kaFf2mRItfpLgsLseu/fAzmdYKiJCjEmaQZXqrBv/sPFHcf8LX2urBXCv5lbYKIvEZnSzfpx9Et2hXZkV58AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125701; c=relaxed/simple;
	bh=6l3tE5aukaRa0TamsHqAwe5puMIZo+63hnCL9DOeEoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moyIbV+tih++54+ldRnA4OVm7gkswRsY2oYdMsQr4dplbvM5EeDzGlNhjwU/10ZFy7g8QI3aYwbktleWWUuvYCwAsEfjAaqvEDRuRZ8RjXhRbo+oL8zZEXpnTKleNdG1cJcb8etvEyfWMwPRyxeG/HBhmfSKvu8oL13kiq/LINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOweOnv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOweOnv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78891F00898;
	Fri, 11 Sep 2026 11:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125695;
	bh=MrfAa/ncpVuU+jlyo05m6FyiXPJKkQEJEUser5JwTrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SOweOnv9/+KvhKPXlomeIVdlWi62on6wJyU7pmYHjBqp6x6HcJU4/M97UIS0pQ2vv
	 5idnLfsZ2Z2sEV8i3B9Kp3wadmTLt3s6lzTGZND7VPY3gyNwjp/Brr/jHWX/NMm0RD
	 1ioC/0p+SC7wllnCuhAlOFf0A1Wu4o8dVZwUQ/yHkY48WhVrfNqOTAna/T1beDolv0
	 5X+vOtRpVWYMtphyk68sru7E/Oo+84KDip5wVIHLx4vCq5tDtCH1O7+UfrrfVp3ppN
	 ginB7sgRh7zfj2G+cX4KGfKhd1YpxfHihRpHDOOGQeHP8xd9ikAH++AlwKsihEBgNg
	 IaEgFfoMKTOGQ==
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
Subject: Re: [PATCH 5.15.y] bpf: Enforce expected_attach_type for tailcall compatibility
Date: Fri, 11 Sep 2026 07:20:54 -0400
Message-ID: <daily-reply-0035-re-bpf-tailcall-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910-cve-2025-40123-5-15-v1-1-547774d4a00b@bootlin.com>
References: <20260910-cve-2025-40123-5-15-v1-1-547774d4a00b@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 4540aed51b12bc13364149bf95f6ecef013197c0 ]
>
> Yinhao et al. recently reported:
>
>   Our fuzzer tool discovered an uninitialized pointer issue in the
>   bpf_prog_test_run_xdp() function within the Linux kernel's BPF
>   subsystem.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
