Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5533AA1A1
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578676; cv=none; b=d5fK4lStnvQtwqzEEyAcM+dQzxAknPmt9Da3JGITXQIBu4L9xByQmFjUyVs2Tq8ZOqc12o4tHovmU5ki6ZiTsQAOO6YYM8YBWUiMVtJHp/E4gXec3nt8iYDIZB46ZtLiGknMQ2m60IA1tKKt37TdsV3EXGtgJxLdmcychf9FbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578676; c=relaxed/simple;
	bh=/wWdg1Dafmd+Z1nUL/kWOfWvtap5yY4WzBV71mj5gNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqMQvaMtuMo4utt31iN4ln0dAsIojheUEvyoI/YmxuVuE3lxiFWHwyiTYpkB6ikJNFhpfCm23ix1F+190d27XFq8az9hnQpqnW/ByYjD93qlN3kKRIbFplDWY8qwJgXrVwStM+RvO8nFoL0+wxr+R/cec3oeuEBWidpKerGm5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIieo5IO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIieo5IO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983A61F000E9;
	Tue, 16 Jun 2026 02:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781578675;
	bh=/wWdg1Dafmd+Z1nUL/kWOfWvtap5yY4WzBV71mj5gNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HIieo5IO2xQcDZED7tFIJO14CqB/hSkjHn4dk/lEznsWYRgxUKzHcPVmYCTfTu6jN
	 M+K+h8WO2UTTa0W3gyfyaWp/Dva+0IXyPsdQJjibQS4iU3TOS+G7jqGj4bWM4Gz6EC
	 M+Jsy0kMRv3giZrmIlsH38FkxFwDK1IHF8vDEhWv5gm9X3YVEYZSlONH3jBYGfIAAL
	 wLO9FCKv9LS28bJnbm+0pzMF0Zly36hm0anSlQwgjYFkwjYRQ/I/VekujW/MHQo4Tb
	 yP3QPEaPZ+AqkuwMGsFGiDyXbuk4TuEw3qEyfH1Hsj1WDYpfOS3EaxVWhZz8wJ4gVO
	 xEt5fKRCo2Pxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	Matt Fleming <matt@readmodwrite.com>
Subject: Re: [PATCH 6.18.y] sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()
Date: Mon, 15 Jun 2026 22:57:46 -0400
Message-ID: <20260616130130.1000004-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615124703.2238517-1-matt@readmodwrite.com>
References: <20260615124703.2238517-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 15, 2026 at 01:47:03PM +0100, Matt Fleming wrote:
> [PATCH 6.18.y] sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()

Queued for 6.18.y, thanks.

--
Thanks,
Sasha
