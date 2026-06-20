Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60857395266;
	Sat, 20 Jun 2026 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956515; cv=none; b=Mn1eGw8kKrQd7rngR7z3o7AA7mcvNawgsT/E5CjI1lj3uVXJRxY4P3paiae14wdt7UdK5fomE1Gx9Oql4jp3uGwEjqZXI493M8IOaPSXlhKR9IsPE2St3Wgc/ululd/iP7a94+toCucs8XGDREq9gH3mhkYa1aJMTJavUfLFVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956515; c=relaxed/simple;
	bh=Z68yr+yHdFH8xYzQsReYj+tz4kBPzytXSKIWssUGops=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a58eXVUgeElidW/uuzF3/Ek7NM7cMA9ja6qxKXXUUzsOblZWRY1ZbVjtK4kTQcvNEKTIebsiM98JmlA5whEFrh/a3N+Z7F/VnNJQlpnG2saLLOcPhE8Ih0BkifZhYU1YM2ab/pvCSTp2dG+q0kOJhhz6n/+aBQHjCs6eIfIt3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaQFxOJj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaQFxOJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AF21F00A3D;
	Sat, 20 Jun 2026 11:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956514;
	bh=8Bce3y5FB0VyOVjBzhNstRLdXCR/QSbHX4wZv9NNX8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UaQFxOJjIRkY7n6drn9/3xxxGDQvpBObWnA7zjxYSd+LKSQILvPM+ER+z+g3Fv59f
	 zOs7HCB8FAjWYAB2CmLSEM8GlfunK90nsb3cXwJQo1/NUkRlq0hfAtSHzD4DAE7Q3L
	 pz/DQCpPj+TDBrn50Q/93cTtHwIi5Kv1s8aZICdkCTBvLbNUXliU0byjUq950m8r3l
	 Mtga5q2O48PfjOxywJ/df2N5e9NxmSz6w8K6WKac99dUIpRsCpLUnXbBOSje7oY5AD
	 Q4Vy8I2UFHhfV39tpQ0N//s4T0s5KiVr0xXt7pcIsqJCKqXE+RjYBZqR/7tULGzD7i
	 w+RLn9INYp/9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	v9fs-developer@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	lvc-project@linuxtesting.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: Re: [PATCH 5.10] net: 9p: fix refcount leak in p9_read_work() error handling
Date: Sat, 20 Jun 2026 07:54:59 -0400
Message-ID: <20260619.0011.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618151940.76321-1-alexevgmart@gmail.com>
References: <20260618151940.76321-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.10] net: 9p: fix refcount leak in p9_read_work() error handling

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
