Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB8363C60
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970895; cv=none; b=e4q5Im1MP+tofcSJlC46B23e/yMp5ur0WUaynKC2jEWkdJhTg/je/YA/KiJr0/fsLxj4HxQHuq+BAiSYHAyNCvfMtct2Q5BnADEnGOwqD29SlS9UutFRURXkn4ck76tVtkLZDlEOuLD3SSPqAG2vS8EgYoXGVy8p05iYr7yZips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970895; c=relaxed/simple;
	bh=LVL31AZVXoL3DFFKVbBHUG9Ai5ooEgE5ceDfmGSMtxU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nKncYesm0kVjILAFZ1HXQJ2mSZC6PTyx0KE6jv4/mU7jGuNfeds3f1a6SLhWyal+rgJiQxm/dcAPjxxRGBIU3X+yX+KxtbLwh7lIontrfzDK3pvD7nPv83UvaFSAlptBSY+/NSDkIqCYe6un0RkKWGAOgnUerG3FsrUTPzqbAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=L7TMVZJc; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="L7TMVZJc"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 582841FB8A;
	Mon, 21 Sep 2026 08:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789970882;
	bh=FcWXLE6n6eabZa2TmuprdWpqRcts46qa8J7UDZb1NrY=; h=From:To:Subject;
	b=L7TMVZJckXQbZgP8aee+Ku6xCWS+kyv7RM3M/RPs/VUve0FmuaAhg6Vj/D8t33aSV
	 u8fqQTPc/IGc/8geV/vVSXqz8EgXw88+xT31wL3iIm3m0NK0WWe/uxiVEKNU84B+Gs
	 r2eK7g7azROkdu7CKr5+TE1vhzKqFn5692Ct3/uh6lwQ5q1Oa0icvbIQlSVtmlN3Fk
	 QdTgIHnTt0Ok75rxDVlbgbSl4WNLn413VofbZnue/7RUED9f9yp/gxAwZwH6HDu/mW
	 zKLE4HBO8KGCLcZ6xGNgOX6jflnkdu298gtnAz8ySRtPy91pNs/ffp/Yx8P8yfzKL/
	 sA0I4M4dx5Kwg==
Date: Mon, 21 Sep 2026 08:07:58 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-6.1.y] 6.1.189-rc1 build failure: implicit declaration of
 'is_core_idle' when CONFIG_NUMA_BALANCING=n
Message-ID: <20260921060758.GA13965@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linux stable maintainers,

Building linux-6.1.y at commit 7c5e16cff0f2 ("Linux 6.1.189-rc1") fails
on configs with CONFIG_NUMA_BALANCING disabled

  kernel/sched/fair.c: In function 'update_sd_lb_stats':
  kernel/sched/fair.c:9912:53: error: implicit declaration of function 'is_core_idle'
  [-Werror=implicit-function-declaration]
          env->dst_core_idle = !sched_smt_active() || is_core_idle(env->dst_cpu);

This was introduced by:

commit fa94761a8f440dae2a2eddb36da1f017e332aa5c
Author: Andrea Righi <arighi@nvidia.com>
Date:   Sat May 9 20:07:28 2026 +0200

    sched/fair: Reject misfit pulls onto busy SMT siblings on asym-capacity

    [ Upstream commit bf6aa722198d3c06e4236e8c5a480f30a64e1513 ]


Thanks,
Francesco

