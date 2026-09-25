Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154563672A8;
	Fri, 25 Sep 2026 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362094; cv=none; b=YlJK5mzf59NxSuF67ehj3OiK9+szP6+iqnYq2zBrxHFysUtzmGVT/E3toz/MXL2fRRMUltgfDhmH8iq4yuW6LKKds9c/tfZ6pPOLECHnYqRDhUfDcAAPZ29av0k6utAkueIb0aGYq43kBCbxRY71ePoiuubgKilXQklyy8JZVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362094; c=relaxed/simple;
	bh=/SMplcpA0YKctlHFcy3uhF3/U1/aPLbjCmUJB/OYEyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKeic5ydEd9a6i0kYgXSd46efeAn0RbJVnFhOczR/1tYRMzb3grildvGnWRsFr7UFMBSJUjvQEYZo6DXnNx7qh2tFV1ppTOOkmOE+lCHoREJLpoCZc40i+IMzLSjvMScvcYGdAH0zvz6VZprFfiawJlbomAAHn2yyWK+hb+y5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am8HJFSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="am8HJFSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C181F00898;
	Fri, 25 Sep 2026 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362093;
	bh=qearm8dZNrGghmgjuKc5pZbtBnwsRRrbUtdflYhHIY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=am8HJFSmMYnacME3weuHHfdFEK+9w8vRZhUCQZxm42T/T3l5b6/F0qVs7cD06szzW
	 g/yUyotk53hqTUqy37dTaOBNxxadcyIh6seq6aaQUb4LAtdHG2/Oad/63WnB8oZhXM
	 PYHaah+HJqIu8WuYr5uG1eapIdLvdU6/BdelKmz6xnqHgGAUSppPkKdSuy9UdAUPeP
	 OyBgMJp8oZu0VO4abNfqfwcgVsuld+/v+q+XlmxxKWGZY9pb4tcJ2mFQkYP3trGtSY
	 3wsUyu/uHWoEfVbBZ8zO0rg9uSAvyr6tZNH+YlZgCG4Qub2zEixntaEz8TqgLHH8nW
	 LNIoWu6OjULwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Jiri Kosina <jkosina@suse.com>,
	Suraj Jitindar Singh <surajjs@amazon.com>
Subject: Re: [PATCH 6.1.y] HID: hyperv: streamline driver probe to avoid devres issues
Date: Fri, 25 Sep 2026 14:47:54 -0400
Message-ID: <2026-09-25-daily-reply-0002-re-hid-hyperv-devres-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924203921.21711-1-surajjs@amazon.com>
References: <20260924203921.21711-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fixes: 62c68e7cee33 ("HID: ensure timely release of driver-allocated resources")

Queued for 6.1, 5.15 and 5.10, thanks. The same regression shipped in
5.15.y and 5.10.y, so I took it there as well.

-- 
Thanks,
Sasha
