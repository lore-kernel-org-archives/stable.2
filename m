Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3313D309EEB
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252286; cv=none; b=dIAfhb3WVhBQvBVUK3teoVhfY+5pr4ufKWVkvn26JGryEfg9KsX2FqaSKW/9qu6GdoCo6Vl7yugmPU/GWC0C7o2RxIk+zoo+iNg7vbFFeu/F96Gq5V7xACFP4h0GbGNWJWrcYunEfhFsaZ8lz+F/pXpL9G3DsmmknSypZcEiiyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252286; c=relaxed/simple;
	bh=39deCPJArBb01biu+hUSTfU7PY9jIfT0Oom+ht5hGWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C05OvrCDnYh2J5YAbgopuUY3xS0ze3UU2ILjp2vlBmAwL47Fj2kjbJD9zV+61DFJiK2gmykSbs/O+Y13Zb5GC9P8J2ygw8ZrCBCul4pihbwoizy89Wa0fiFMjU3xWSZc7U99cl4g9Agk8tgZQUZjfq3avpm9lvqtsA5Z0285R9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo3ihOps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo3ihOps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EF01F00A3E;
	Fri, 17 Jul 2026 01:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252285;
	bh=ySERCMJxLGteR2yuh5kZRtwTeZ6QGb8Dfy5jL/Ly/RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fo3ihOpse/mcGHx+sSmyOL7/Ggvgoe6azBywnlsa2OZD3Nfw3TjAXnoJ7C6CvvjRb
	 jX1Z0hy2e8frqRguN46rxydx4kHid6ASQGppPczk8cimOb611UPDrhYyExnK1yHWHH
	 BlFVnN2b1pZHrsy5Hs1vlnhRDxR/GQGcZ2lR/4urND5flKmIzW5J7h+Jgosmyacx/v
	 z55DtuFfmhw2Fzki6kBD5jmTb6kzy9Zq9NwQoRb/PiZFsIvhXDHSYY18kDQIpDL0TC
	 YqFOS0N8UCbZ3n0uS20Yu4jPYnf8twNpbmj9dyCXu62+MOxcVFnlnjijSSteWRfyhH
	 xl5W/MiO8ww7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	sj@kernel.org,
	vbabka@kernel.org,
	chenyichong@uniontech.com
Subject: Re: [PATCH 5.10.y] tools/mm/slabinfo: fix total_objects attribute name
Date: Thu, 16 Jul 2026 21:37:42 -0400
Message-ID: <20260716232340.0018-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716080545.1165733-1-chenyichong@uniontech.com>
References: <20260716080545.1165733-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 16, 2026 at 04:05:45PM +0800, Yichong Chen wrote:
> SLUB exports the total_objects sysfs attribute, but slabinfo tries to read
> objects_total. As a result, the lookup fails and the field remains zero.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
