Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8FA2C3757
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701639; cv=none; b=SMlVLlNg7rD5gaItdbqDL2n2T2RzNnUnb0JVR7SSzGW6p39+yWFUQpaqcG4zDwbj4I//uJ2D0/u4XYENPCItQhIEduz1sO5Dg9PuWyxq2zs8cmEk0wMlpl7PJTpilWI7BMNua9qVCKMQeRpQLtKWW/Ym6H2ohtCs6JjFcDfPPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701639; c=relaxed/simple;
	bh=hSWx9a9zffkIra2VAWTcsWYjjNU/KlakazJVZYi9w0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDOD5yii/6kPQA8H6ZKOOg3/ollnYZlD8n8FkD6vquW/70im+2fuGVr/Yz00nDoO/WzCtHY8Ia4o4k6rtD/rUHjssmoki/dGgZhhLImBpdEzR/TpZJH99Ff1DiLm4LEkC7OC5eQbAApMhFoGA+730uMOEu/ThJ7u0vwZtQWHzYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TriqEx73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TriqEx73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19A31F00ACA;
	Sun,  6 Sep 2026 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701635;
	bh=zttl80t7t0mD4iBByRDIRAokx7o5KRFaMyEbXwToNms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TriqEx73WJ9yGydOyTgYOa1l2xRodfvi0MZ+7aA+7H0QV5fiwWTRi0NvADkRGDxvK
	 JbHznn7YZRd2XK4G7ctqWipAOzYz6YSSyAzX5YnFwS93n4Ll6z/7RrtgGcqxA3Dnwv
	 QoGNs8JTatXO55qok66oeSTFW3VBzvMC5Hn47Z7aiL/JIwgkowwL6mIxq2G7xeD1D2
	 7lE1dhnSM8eETIrSnYSwsHbqARDKkQunhAnmkj7g5rYMydaNkGFeIJTkej45+Ob9pC
	 us0vXCP6xNWPtvAPdAQxAhWZogeoeKXl+KEFlnv9UkBPJKfDQwezAw7Y5r4B2dn2Yj
	 qIBhJPDeeYHgQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	ruanjinjie@huawei.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 6.18.y] entry: Fix seccomp bypass after ptrace with TSYNC
Date: Sun,  6 Sep 2026 09:33:00 -0400
Message-ID: <2026-09-05-daily-reply-0030-seccomp-tsync-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87ik4la892.ffs@fw13>
References: <87ik4la892.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Sashiko review pointed out the following issue.
>
> If a thread is stopped in syscall_trace_enter() for ptrace, another
> thread can install a seccomp filter with SECCOMP_FILTER_FLAG_TSYNC
> (e.g., via seccomp_attach_filter()). This will successfully set
> SYSCALL_WORK_SECCOMP on the stopped thread, but syscall_trace_enter()

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
