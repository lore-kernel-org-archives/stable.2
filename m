Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8631E83D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941266; cv=none; b=LrBHo2Gm/mkcwLBv1bXGHXf6uBokW23JlcZW4UUJOmFur32fKwPlRIg36Do+oUUy9T9zGMlZdsnQMTmLhnIHegZzq2OugECFCgmaKwSR3uPYNUifZOw/SdtYdqYMJrk8gWkQ/jC7DTzzpm+TQPAdMszR4rrwfc20NhF7Hge56gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941266; c=relaxed/simple;
	bh=tr4agZpZkqcrdqb1RRIseZ//p9X/R8u2NkxQPynQJcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtVX2B0TQmAJqTBoXXUZzcQ0emxDJJH240HfmA+y2oXaXD9NnnN+4vKfGfay3NS9fkTTUbVe35GcIn5VxGsZ1XllCObX1oPyNjpgKJGqt4aDWuT7qElRNwEC1ZjXfmdAryxthoAF0JjcMQvEAkB5HOIlhPab4SC8iXWx8xXspGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnOOkU/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnOOkU/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C000E1F0089A;
	Wed, 14 Oct 2026 01:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941265;
	bh=GnP6RnXjIxLA2QeKZTP8ILt0+HqDHWhVEw8yPw/OidU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PnOOkU/818qc7bxa95lOK1Ft7NQRfGDuXWZWaP0U5bacKqy/IYMXWvYSvT7yOMv2Z
	 OwEFJPI3p/WBpewmXrCAy6/sP4rcDpiEdHamoFUmcDxGyWJ3h7AQ81RE+ywggpgE6C
	 84pc/gd5MeDLaRU/KTjrOhj4lUy7ytRWtpBEgE4LteMPyfIByaOAQwpMGvUZvwqhcm
	 6FfeOpbW7vEoQ5vhzVAkTrQWGp+DjIMwhfn+MDB7ASzVIbqLVqgrzJLReY7yc2QREF
	 pg9wc6sOfNIhEyb2fLFggaM+OwqhARxIoOzucaz2JT2Pvr8gasuc5Ou64pCebYpHjX
	 sdk17zZMqIYYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kuba Piecuch <jpiecuch@google.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6.18.y] sched_ext: Generate qseq from a per-task counter
Date: Tue, 13 Oct 2026 21:27:15 -0400
Message-ID: <2026-10-13-1-daily-reply-0025-sched-ext-qseq-per-task-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013090229.3584603-3-jpiecuch@google.com>
References: <20261013090229.3584603-3-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> finish_dispatch() uses the qseq embedded in p->scx.ops_state to tell
> whether the QUEUED instance of a task it's about to claim is the one
> scx_bpf_dsq_insert() saw.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
