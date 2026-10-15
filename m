Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2124119F7;
	Thu, 15 Oct 2026 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092988; cv=none; b=MuSshoEYkeNQRDsi5GT32GONg0NNdlSgo24wbSWA4GL2w8y2UaxmMnoVTxpJ29px5nuLF8YwDLhrFlLmiVeUe7oLrNvri+YrxNgR6x3dzISawqj0ar3h7Z2aUH/Aobn90OJPmKoNeHe7k23wHcSHjbd262VADO3cKUdoxd2civw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092988; c=relaxed/simple;
	bh=ZsuiRVBV9ZzR6NJzLmW5kS6GSCHD7U+tkTTJSXQd8Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxLp3JGYgC0z+Imveb4hOpmx2+gYtLtce0x5ccwkU/A6wUgG/ujI0vCJmHl3xeV5W4KPxF4NMRITzIQ3VASne/Vvr1PxWVWVoYPZgxlLUoJMzhZG4J5F39f1sxhDCJrogk+taKnZM4e7VsoR3ATcnF0EzzYYl6j37G4zr8oQgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE5ei4Nw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE5ei4Nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086DB1F000C5;
	Thu, 15 Oct 2026 19:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092987;
	bh=6NkP0ki9Tf1UG0FG6r85CH7qTlsJ/5KV6aTGVLn6VqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GE5ei4NwWldBcwymO0yUA0Qh4xfgeWxpWoXQz1tPOTe8pL5twsMpspnazlcOEV/pf
	 TddRqv6x4CLfnsY0u1JzcIwNA5zgRcfTqwjBOJDOPXd5Lz/jjO7aIlasxiaEG6Vc9n
	 QUQ32LqKXjXw9lKmWnFVNqtvNPaVnBZKjFewXqoRrNbhcZaG1rRuhLT3834eK+8J3r
	 kMTUYTMLEpLLspM6noX2rrrR1kNXpu8H+WYg8PYNqUWERTj4BJ3EVnUr8yXivKGTau
	 FZrsj5iOtltc2//8CFyikNBSJRUyxyokBspJUPEHy6G0SfGC9Tr3NW0SVmxIepSxIU
	 9lw1XZTgZwTFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	cassiogabrielcontato@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	tiwai@suse.de,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y] ALSA: pcm: oss: Fix setup list UAF on proc write error
Date: Thu, 15 Oct 2026 15:35:48 -0400
Message-ID: <2026-10-15-1-daily-reply-0005-alsa-oss-setup-list-uaf-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014192210.24272-1-artem@trailofbits.com>
References: <20261014192210.24272-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> snd_pcm_oss_proc_write() links a newly allocated setup entry into the
> OSS setup list before duplicating the task name. If the task-name
> allocation fails, the error path frees the already linked entry and

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
