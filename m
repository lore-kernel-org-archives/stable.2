Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B4175A7F;
	Sat, 17 Oct 2026 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206032; cv=none; b=pBToBVJUm5I1fAyMEZRjpAKnfpiID2Yr5FC+7TgSFY7xZ8XS8AoxlqEN8C05c5u7m8CisTDGTfYFfdmFKkdN0fBc76U1FmZyAFH2UqWT5Ags5YdYnFQMJ/bYpgfYjB4QiQApEvdxZZzHP88PJlbVrfYkXpVGndUM8D5YCQJl6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206032; c=relaxed/simple;
	bh=r7yj14XEWxRWae94x+Oy70DIhGwCN6JXo8tx3B4DCX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAxxs3fmPEFmlmcsYZKgLUD3EmZcxG35KS41i5v1A2IkNOId5ROrKv9nOwEshB8jXdyQYA/ZOKkzFMqpLEsj7NyY4oEg4eVDFqeKsda+5YY2+uZQchGYPAvV2rWc8/g+J01lfk+D/BMCdEuY7n7qetZahqpq9SFMF6sYlFKOBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgLf/7yE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgLf/7yE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EA61F000C7;
	Sat, 17 Oct 2026 03:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206028;
	bh=LG9e3ZC+RcLY7z5/m+r5Hzyr7Sph+6VSFhdGdqOJRAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PgLf/7yE86pgHIj3SUvX7PE4VNM+cHjjy5jGFlYexla8EECmj78c/DzJU0MwITrSY
	 H2F6ztBSthdYJG8erxnZekqZd/Mw2gL0fyfq6Bco7UAHPnZ/ecE0oIbKlPcwrvHll/
	 +k70A9vI3uKXON7w7Mkmz/grduPFinTgDG21OWqaH4/PhWyGWplb4NSl0wR7GdKB6V
	 v07pJSUi44KxeQpyziZyEuRc3j4BKxpM6DBSBbX0apKqDKfINteeOMNr7gyEHlf66a
	 p3onQtHq77Z1wo6CQCycxZIlIfgoHEqHFHyq22vAWj/E5EBO02NMVRC4WPjTBf+hwD
	 pcv/7/WIUMNLg==
From: Sasha Levin <sashal@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	mehmet.fide@screeningeagle.com,
	Mehmet Fide <mehmet.fide@gmail.com>
Subject: Re: [PATCH v2] wifi: ath9k: reject short WMI command responses
Date: Fri, 16 Oct 2026 23:00:08 -0400
Message-ID: <2026-10-16-1-daily-reply-0003-ath9k-wmi-revert-7-2-6-18-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015184044.1321868-1-mehmet.fide@gmail.com>
References: <20261015184044.1321868-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> this change breaks ath9k_htc with the AR9271 firmware from linux-firmware
> (ath9k_htc/htc_9271-1.4.0.fw, "FW Version: 1.4"). The firmware answers

Queued the revert for 7.2, 6.18 and 6.12. The original patch is dropped from
the 6.6, 6.1, 5.15 and 5.10 queues.

-- 
Thanks,
Sasha
