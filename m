Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D51318EC7
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465591; cv=none; b=IMRhX6NqEuKhKrHKuZLlLuy+hpNAWTC42BUobi4EAbl2gNqJ3ZwCV0s/r7VoZDxFUN/Bnj46RojHqIDRB55J+2yEVezUo/VZs1qqvZkXD7RJfh08LyGAyr7r8nlXVoh0d6oUgF28EiKh7sayLxKBatgwR5xxMp1AEL59t6jIdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465591; c=relaxed/simple;
	bh=HsErp8F50KoXAb0sTGb+lsMg3PNdWCN3jhlSr1VxMsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS1zDgQEVfQoM8D6gNZgEdR4rRnn0+qaXSAf2lSrkz3k+61UpK0v2Iq3+fU2IifOk1VLkoEo6RUZXcIf4LFIirMqDM95LfTZ0SKWUrZGyhFuDtop1/2loJ1vEA6JopE68TJHl6qAD1S/C9QGuivv2KVf9gG9Tn1JbnqYKnMJfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsJCJ0S7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsJCJ0S7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376A01F00A3E;
	Fri, 31 Jul 2026 02:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465590;
	bh=0ZpVakQJS+rW1VTrH+O9cRlh36yWbXNhBTCDbrkQh80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HsJCJ0S7VBDNaRTNzVPx/uIkEM+Il7X7Pc1j6Nn1fxwWQ9+1jpmN8Ne2W6fKQQbRU
	 XWk6L6i93eWLyI7k9f2pfdSsOeWqjH7ttRkNXJQVkyh4nlbpgjMYvoZPHP7tlxFldO
	 oTpvzVqnzR8JVKFsqEulb+JJkllUzuRs86urbUVdlQAbJRNhuYPx8w/64pK6CNDGjG
	 c3F5Azcglt9J0O8AspQU6mBSvgCjMR4S68EAu1Z560gJBF6sq0BJlQ9rE30tuCrvzs
	 CRsdj9SfgdsPlS3mrIdI7df6DY08XP4iRAL34iY7Y3uoxcgSv4rJmKXc1LaFh93XyT
	 dW0M7NuZsr0BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tze.yee.ng@altera.com
Subject: Re: [PATCH 5.15.y] firmware: stratix10-svc: fix memory leaks and list corruption bugs
Date: Thu, 30 Jul 2026 22:39:43 -0400
Message-ID: <20260730203630.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730023604.14996-1-tze.yee.ng@altera.com>
References: <2026072955-anatomist-verdict-df3a@gregkh> <20260730023604.14996-1-tze.yee.ng@altera.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 29, 2026 at 07:36:04PM -0700, tze.yee.ng@altera.com wrote:
>-	pmem = devm_kzalloc(chan->ctrl->dev, sizeof(*pmem), GFP_KERNEL);
>+	pmem = kzalloc_obj(*pmem);

Did you even build test this?

>@@ -944,16 +946,17 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
> {
> 	struct stratix10_svc_data_mem *pmem;
>
>+	guard(mutex)(&svc_mem_lock);
>+
> 	list_for_each_entry(pmem, &svc_data_mem, node)

This wouldn't work either, right?

-- 
Thanks,
Sasha
