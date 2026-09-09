Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5038550DA6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985628; cv=none; b=d0HoRiNPITL/7faFIVj7GwNVlGnFPHeGTNdGg8+AirpFZjMy5vdvFURQkdz+ssQkTb7oNJORx6Yxms4RFB8EMXu2q7uQacGKTx+8bOltr0VfOUgbcEpBrd5mx/1MPkXew5epm+/RqTAkYlqE7DmTKhKFDuiuO4UDasLBHul76Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985628; c=relaxed/simple;
	bh=w1wU4HDwM8DtPTCDSkqozvUyq/Qwo/Xw/3o33MZKpcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQKTdcPA3pfSS/KZ4qcJHO6y3nYoSHLkuAWX50a6z5/uJivWYfMRgNP223FD+qk6+Kxlt1yhxCbfUdQ8V6lTpSFtecqYaKQzTw3Xdm8kmVAaqtd2fhbMsqTsv61kiH2xxTZefebZjG88iDmnKD5/3WBQe7W0LxyzBHcW0Tl3HD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTaFkAHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTaFkAHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CB01F0089A;
	Wed,  9 Sep 2026 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985622;
	bh=613UaFhUw8CJBRJZAEJM4azvh3I42Z8jKwyZm/03Tlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hTaFkAHXerWFnKfMbWXv8YXpWJgbKbffyV+TM6P8Op3WLo0xxURa2gZLJc7VNYobp
	 +a1MAwOSY1R5XagxVe0R1uwlp2zP7pbkwcClIqLX5g5z7jLkirVFLRyMcPipZRZ1NU
	 hwzMHJEb343yMyYx25tMJje2Kcheb3dF/dwcrrC+EkOSPcRy+xVrFQ0BMAef40wlM7
	 yUHqnERsdFqByQM5MNaJ0U6bWYJwkg7lBa5K8Icw+e0FQVSiglzqoN/yYR2NSxScn+
	 SfttbbEr1tan3KKHslo8DCb1qIrb8N4N3iQioARDIyMZzRjEnOVFEnBl7PgwKgHG9y
	 mHcsKzGwr58Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 6.12.y] ksmbd: fix use-after-free in oplock break notification
Date: Wed,  9 Sep 2026 16:26:27 -0400
Message-ID: <2026-09-09-daily-reply-0029-ksmbd-oplock-break-uaf-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909075825.3252-1-suruurism@gmail.com>
References: <20260909075825.3252-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Select and pin the connection under ci->m_lock, the same lock
> session_fd_check() and ksmbd_reopen_durable_fd() use to update
> opinfo->conn, so a concurrent detach either loses the race to the
> clear or keeps the connection alive until the notification work
> releases it.

smb_break_all_levII_oplock() already holds down_read(&ci->m_lock) for the whole
loop before it calls oplock_break() -> smb2_oplock_break_noti() for non-lease
Level II entries. The new smb2_oplock_break_conn_get() takes
down_read(&ci->m_lock) again from inside that same region. That is a
self-nested read that deadlocks once a writer (session_fd_check() is one)
queues in between.

Upstream avoids this with the deferred-break machinery
(oplock_break_add()/oplock_break_drain_none()) that this backport drops. Could
you send a v2 that either defers the break out of the held-lock region or picks
up the connection without re-taking m_lock?

-- 
Thanks,
Sasha
