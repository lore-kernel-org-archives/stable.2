Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CE364EBF;
	Tue, 22 Sep 2026 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043830; cv=none; b=H672JcLwYcLPo83OHEDoCHPsKeCTL7cT8rY58Oy7IbgjD2uXS1bGXHMJDfGPMjFtxSTVXXCTs0I2x9F9oMYiDeFM/2UUNA3aDyCLeakVu96M2oxtjiOsDmMwGUFXijYShCvYqEZY6vF3W6GB7JIwRUypeK0o4t/eLTpg0vNC5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043830; c=relaxed/simple;
	bh=nHTAfk6up/ZYAY+CtnjjHsvqW4nyG3UPuK9IbK8/oM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz+qvMmkUeUhF18njabsJ7xT2toR5+pNVY3TVJakwX9aTykidsrYlIH0ng0++bICbbjqzx4FdM4DTHnhIv+05P6nn4rJptcgnxZo5tz7j5hqfKKqQfeFEXG+kfiavGK5XChtsirsieLwH4NJ2RHZrL59RehOW3hyACBBh2X+0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKKB/1C3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKKB/1C3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6B21F000FF;
	Tue, 22 Sep 2026 02:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790043829;
	bh=aT3WSQsjijWvUk3bgetXyUamJ9XvWlHmx7vZ7os7un8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKKB/1C3uOnDztTuRZBpSndHcV/CYFBsxhOq0o8XdkWY3qE1c7b98xtaVX+vAYANG
	 zcCzllxjA2umT2xCRjwRacv+3UDVqE09H2wtsS2wNf6U4j/2tBNyNHGlFY702LKojn
	 F90c7qQt3DUlbjupiinYJlyNser2hzkwVl48m9q3VOrKDqMb8R6dqU0rdtPBfXS3G3
	 ojMs1TJyIpAEH6JNn7XOkj55Np/Lo9yyGHNcKlLXkGJmtUOXd4MTXM153gguPjgHcE
	 VZn8auKZa1V58AYvMNL5q+RGqlrLSbzNo4KnouZj0TuNLC14b639ZGpy/a/CzIG1e1
	 M/yGCgcWPhMcw==
From: Sasha Levin <sashal@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	regressions <regressions@lists.linux.dev>,
	linux-acpi <linux-acpi@vger.kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	xen-devel <xen-devel@lists.xenproject.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stable <stable@vger.kernel.org>,
	Support TRINITY <support@trinity-net.com>
Subject: Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks bare-metal Xen dom0 boot
Date: Mon, 21 Sep 2026 22:23:38 -0400
Message-ID: <2026-09-21-daily-reply-0001-re-acpi-cpuidle-xen-dom0-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1909296988.289641012.1790015372050.JavaMail.zimbra@trinity-net.com>
References: <1909296988.289641012.1790015372050.JavaMail.zimbra@trinity-net.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I will try testing 6.18.52 with commit 0089ce1c056a ("ACPI: processor:
> Update cpuidle driver check in __acpi_processor_start()") applied,
> instead of using my lifecycle revert.

Queued for 6.18, thanks.

Please still post the result of that test once you have it.

-- 
Thanks,
Sasha
