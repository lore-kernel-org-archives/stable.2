Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E92C234E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744162; cv=none; b=umzvkiMukFZAqT8wl8+wLlFpYaTj1/HVE6PVCStA+gD4y2IEfTKmJN5u+89oVLYni6nTjvJEuwCIWAzoCloZAxMGnFjohx0p8Ig/z7/bChMunl976DPNkwEUCb2fb9N4FxM8ykY+EBfXQY6Uh7vSrDFbd/RjFeNceHQ3RXC8ZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744162; c=relaxed/simple;
	bh=8MWUzovI8xZFjnNfae2qnxWFdmqxgIuCqSI2SoE+INI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui7xoH92LUsFGkZN4jAJeCM2atfYJjk93f4zrop5cKujtLoGTuS+TF0onWoCJsEyBxtb7jikQ9hsiuRG5VHenfE2j9I945ljDCGnCMcyGEGOdvnclVAx7bJ6gQwPAEL4Q18JuNuEDRkpEmkCoNiHckd0fgk5lC3zAk2qzOfDbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwOWTmAM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwOWTmAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A111F00A3D;
	Mon,  7 Sep 2026 01:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788744161;
	bh=S2v+LcfDgheGT2RlOCSwA+K1kZ8eakvDFRWEbjdSAtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mwOWTmAMkP0K06pxkPPyac6qmG1gyNk6T2vKC9jpHZb2PbIGhEY8/1ie/ehj8cMxX
	 UAiil3AZxhuLNSq2w9RNMzd34Q5iAPDPaeemegO0bDFuOs5XnzfPB7DQZS2cMp1drC
	 +jKcC61wCuTYIlfcaUr6GHnCdHrvPqYhjYcnX5D/26Jd9VrSh+MIruaprbwZf6s4kf
	 If4yGfV5N7cu8Teyy2qMXYZ4fjq5q8nhXT7jMcXuittPstjeduE2oaIz8ygCPKR5Gz
	 5ZXZnLTvGHf1sn35S5Aduz7COCOlYE5jyNJsKrmdm8of4m/nmjd4LhP+Q1ksnQL0oQ
	 PIkneEWksyrFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>
Subject: Re: [PATCH 6.12.y v2 1/2] fsnotify: inotify: pass mark connector to fsnotify_recalc_mask()
Date: Sun,  6 Sep 2026 21:22:34 -0400
Message-ID: <2026-09-06-daily-reply-0004-fsnotify-mask-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906030345.3332040-1-yjkwon0026@snu.ac.kr>
References: <20260906030345.3332040-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 4520b96b8136ba2465a3f4dc5c3fb8bdf3d92e4e ]
>
> fsnotify_recalc_mask() expects a plain struct fsnotify_mark_connector *,
> but inode->i_fsnotify_marks is an __rcu pointer.  Use fsn_mark->connector
> instead to avoid sparse "different address spaces" warnings.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
