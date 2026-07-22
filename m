Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E43603FB
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681650; cv=none; b=iK1d66g1MocsRJS2GJIOsdvwHu5kQenosrl2mgqqS7WiS70nVn2RH75iMS3jkzWpiBCLnqIK/jjmqOWfrWN8ZkKKxLIFXN2VMJtTzUPel0v3zv7GlzCklNU3Zrd1vrTgGc9t6xAw/ZeHV8k0Rv8cIHGV0RYTJ0COj3aWJYrD16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681650; c=relaxed/simple;
	bh=mAYDP2iQNt62cbQ6fkqbPaCPdNfHfyEB78RJ10XUGhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEq+PxKy9Sg1Y+Dpf0gL4iVb6vEs9ucMsuD0KC5QJGFV0OluJgG8E+MQFfJ6HrwZetgYJpoXZjvKx3aEMUwRzdkaIU0XWNqIcI55WFCgJbZ6FyOE00wTosacOxYdm58Q8pAk+JxWs/a0BwXLjEvCY37TDmCU258vv0FLFbiFq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/NYz7FH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/NYz7FH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97A11F00A3D;
	Wed, 22 Jul 2026 00:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681647;
	bh=R7uXYP5yGNkFUxm55DgZeWVoGeHr6GZDjzhGVoSpyjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/NYz7FHyCkNDlyc7mqyEZpcehtxrdbSbtqI1C1qiNpnDpvjUhLi0xFo4qjbJGEeW
	 X7kaZA2QCP3tpS1I31yuwEPF8nj4Bc7LS39cIdjYmYcK3ZG5UAV1JFUmYtGWhKeO71
	 cgOZu0pS9OYXew1uLGJxVI82YRJmQu9yCoeN6zoEdVQwkh+zM9YxvxjIsA9lDCzU29
	 MwJ/M+i2bM7MkH2hCpC5lHireYI+KZJtkFGhPlqkrPqGYMF/z1LO9RanpArTDRU2ug
	 XVgRH73yk1WJTg9t5jBRqokHYJ4zpc22qMTcVEc0VcCHMU6XpRINBDSb7XxvKmIKHz
	 2KBNeX74TLMjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Guixiong Wei <weiguixiong@bytedance.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 6.12.y] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Date: Tue, 21 Jul 2026 20:53:53 -0400
Message-ID: <20260721201114.0006-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721150743.46717-2-weiguixiong@bytedance.com>
References: <20260721150743.46717-2-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 6b63520ed14b17bbe9c2103debbd2152dde1fba3 upstream.
>
> When the last CPU of a legacy uncore die goes offline,
> uncore_freq_remove_die_entry() clears control_cpu. During CPU hotplug
> re-add, uncore_freq_add_entry() still populates sysfs attributes before
> assigning the new control CPU.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
