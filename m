Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8C433E81;
	Wed,  9 Sep 2026 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985621; cv=none; b=OCLGFtrz/7bI7ezdCX8u5Hqe8veeV9W+51cDZUi36LcWF3ksjzz1k8V/gJF5YQBEPAajPNqzKpVJjLHRgjNHcvuQLK0HTi16fkKUML5hA/0aqpkWoxhZpAoYt45DAmOERKqOPjVmKALr8op6stvBFL8/xW/tF1v/q6mSzTKVXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985621; c=relaxed/simple;
	bh=ktm8qkORTSSyFu/YWqO+EkKBEdIPFXJtS2PpdGD+ujI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kec7b/XS+x0zJmAaG4gNxRyqiRr/43FPerQtGOCcsyt+vM8KRULEcsqaLlgsb/NOP27DCUDHWYBmPhfIy5zPb17RQZtGs3Wt3z44VnFqQlRiGYj1avAQaF3N0wrDa1TKkY4N8UFMM/YURAo72ZHQaSe2PfUsRPOscEDwgbYqIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjE8CTMB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjE8CTMB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4852E1F0089E;
	Wed,  9 Sep 2026 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985617;
	bh=+6QUgGhJbZ4kuGKOKhzq/6U5IX+fLvplh8Yw00ga2NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bjE8CTMBn9Ln6zdD7RjzgKBUu4k3MbPVubyYdO7ovJbXhcvmIEo/dLFaAZ0HfX8JT
	 QMqHYYIakoZflRSy+sRpYfGhDC8OsO8cZUJHcj4QOd9iugZrPw1NTHSKQm14zLXJBB
	 WSNQuvgALt7ml0+Yo818lftECBrFUEoEMcqvFKbMHumMNAVQvH/geGGcDncKpiNdQ/
	 n3UWP8ZZi14BucU5IcVP6K34vMJV4nL5Ei7yo7RZIB9MorRDyF2xYVKufAaFOzz3vK
	 1q5LzgassRmN8C2epRrusauhsa4AhlG7htn1i8SkCdc6p2vKT8CBRUctyAieNmivZg
	 XXmC5575+bXbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/sysfs-schemes: kobject_del() scheme dirs
Date: Wed,  9 Sep 2026 16:26:22 -0400
Message-ID: <2026-09-09-daily-reply-0024-damon-sysfs-schemes-kobject-del-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909035529.159422-1-sj@kernel.org>
References: <20260909035529.159422-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
> could cause directories creation failures due to the name conflicts.  Fix
> those issues for scheme directories by adding kobject_del() calls.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
