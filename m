Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F302377A80
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190792; cv=none; b=DH2UcBJm3MrKr2q848wK4NOCpAFsgUNjuJe0Kbp5zyw6eQRC9DbiAIaEq3YEvW3BDhp5ipcphjLknPaMOKkoILm3jjujtN8vWi3abKHl+vaBs+yq1g6Qthys1vmkG1gNEi5gmg9X+QkOd6lH/6cErv7hzJ7skcoOHHwh6c+3XSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190792; c=relaxed/simple;
	bh=Nh8wXEpYytbUKB07v+1m1SllqrCgimHURDZbx9B6Pfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhl6bGJAolHWTxjpfhQH9K/SjvpiTSXihGz4QD/5YdIEty0m8uohOD1hqZ7uX5iaNdf4NhqUqxwIstIjEBVPiAE4eCsX8wtzDhwvcJdLg6a4fMqcy2UIAdJrm+yeAevL14irsk/Nq0CAC4GjHwlJTrGQZ6LihG8XRHVmQve2iYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmiFRKvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmiFRKvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAF31F000E9;
	Mon, 27 Jul 2026 22:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190790;
	bh=/5nLrZPT3sk9NKlUs5Ex7QhXgIENzaKq+dlKzXU6jbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lmiFRKvWOEMJ2OhzOn8vYyu8z1XfaObYnLpAtMKFz8VW6lQtYbLqfYupQm2zec1Us
	 kDn1ZSN2R5Hwy3uLrWz+70gYos31AJNtITcOZYQzbudGaFNtRufS5M0eTj7E5668pu
	 x0E/ca/RYP0bGR7OFqy3oWfFM+hB/hhHXfgeWutIzDw7nC+dznSlHh+7F4tK7fRNTA
	 lFnSmbqyLg9KAdS/bnJlQ4GiULj/vdM8uiR25sWxrItE6sdSNlC9p96OJZutvlshQo
	 wP/y6XxLkPqLq7qYUFHUYp01es1oLScguSnx7C8sktjoUKnl5u/snpcZQqb2QxQBpI
	 t5W1OCmfetTMQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	jwlee2217@gmail.com,
	oleg@redhat.com,
	qw3rtyp0@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH V2 5.10.y] posix-cpu-timers: Prevent UAF caused by non-leader exec()
Date: Mon, 27 Jul 2026 18:19:37 -0400
Message-ID: <20260727202413.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87qzkoiymz.ffs@fw13>
References: <87qzkoiymz.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 11:13:08AM +0200, Thomas Gleixner wrote:
>V2: Fixed the old->interval fallout - Sasha

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
