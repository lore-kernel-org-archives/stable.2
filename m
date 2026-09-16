Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4A4052B8
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586926; cv=none; b=Oxzx7Oxa+G10xOKejOJ5rxv48DYeWFAa6Txv/0U1Wmb+ODF3aB4HE3iYdL3ZJ5GdCWLXa6qVas43MGDso1N2HOZ+ZGr4oS7pwikHmGMol0UCpg83Dtnr4yXC8f1NXya74+P6ob050JAu65OJYEvDx9AF4a6PVl4BdDxXX3qyqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586926; c=relaxed/simple;
	bh=z+vbrpr9osUq6CNyda+XqLg6xzHJ5a4S4lLJzFOLSkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUJp2ern6yqLZ0cLZn7TsE28QLeYme2hd5XSQek653F7lKbnUxoVOeLXjDB8+d+EIJC39+EqP19vyQs5wn8gCxMVye5EwKNieEhwWFBmZeFOYoHDDhY+jlpymWfVlqgEzo+5uqfMyEsVdodja8qBW8uVLqNobLcTqpFKtSecsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5QpxjuD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5QpxjuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5681F000FF;
	Wed, 16 Sep 2026 19:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586905;
	bh=Hq4UW8HYtt3r2OTiCZ6Bh9MjwEYMt95Y2m+V1Lgo17o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P5QpxjuDwbZQQ3CW8zQsfmOM8/DrSGnMFvjZRwrclttgt0xfwIc4fT+DQD+NdpE+C
	 S0Jcw8QG25PxcOZTBlX7Tt7JAet2kpq+3IKlXbBjv0KEdczM7rNkMcM1t64Ev5XMqi
	 LhOtEQWWHw0OWvSxmIOGaDxvlXslsdYflDZ9A93XaJS0HkhXb4i6+zjBnJJYwfQUKy
	 ZKDG3KJIguXHYk134Tyrp7v/zZL6QLWF5PzY2chHQEt2CY7/VWf1wYS6qiBHyO/gvO
	 1LsfKMkzMq+j/BS3pLsA+OVmt9JhMltSlFITSPDAVEwcnysXqJkaEYejOqB2Nulnzz
	 MA6rRNbkhOZQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linkinjeon@kernel.org,
	gregkh@linuxfoundation.org,
	Abdifatah Suruur <suruurism@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 6.18.y] ksmbd: don't hold ci->m_lock while waiting for a lease break ack
Date: Wed, 16 Sep 2026 15:27:51 -0400
Message-ID: <daily-reply-20260916-0001-re-ksmbd-m-lock-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915195659.1947-1-suruurism@gmail.com>
References: <20260915195659.1947-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 27a9bc968d4ae809a3f5ca2f2b136856ee613cb4 upstream.
>
> When a cifs.ko client caches a read-handle (RH) lease via deferred close
> and a conflicting open arrives, ksmbd breaks the lease and waits for the
> acknowledgment in wait_for_break_ack() for up to OPLOCK_WAIT_TIME (35s).

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
