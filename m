Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF43F6C3B
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270017; cv=none; b=aQHn1r/9M+fsWOOg16XD9utez4lMBLER0Z+aufd4VsAMRNlzp9T+k1dzl5FIyFGfQWRM6ISaF3rR6VSxLwqr0EEJY5cGbhadNr3b9FFy3bm7RpbwJlnDmMP6c9bWtD5EbQXtZfvxcyXZ0Hi0uquo1EMu7KJ4p9S2xXXNK4mhJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270017; c=relaxed/simple;
	bh=nqXduWlVFqnAZdtdLJWl5XFal6Mbu1BEEZ2thKqvxxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qw1CU0sZoBY4i/8alNco1nTnVNx4IKDurPNausVs4eOH0ihzpnzJZVU9cN81/+ODb/g4MwEhKYHSeTA5/52i7mNro1SRNENXvEJCBWA2VZ3sXpmVUGaji3jij0XVDLAyPm/zXNffWX+3Pt7s+2dNZdOhMgllYV0N7ZZF6+yBsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHtnpe7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHtnpe7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D58B1F00898;
	Thu, 24 Sep 2026 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270016;
	bh=+Beo4RGZ5hELy3JgNFb4+kgCbR2YXqHv9oPFM+tcvqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHtnpe7p/5VwdhmiDHSX9ZbuihRHST4NakEQnuHGvG0uparyUCA4XYAxtlEBZlTWL
	 VgHTMY0+Q3OSkjVEjJROZ4samJfiy6A90eYFzlYQHU+8iZzqJ9d5KLdJXPd526vv3D
	 fTgz3tG2D0qOZB4Sh09+fBo9iLPJk9RS79sYWQ2u1txBtzIf69+mbitdfz/TnkxbVd
	 3BD2Wp8ZEqi9yrdUqZ0igZ5gWh5xACPEC/tEIAnQ4voS1ctabHZubRQJULVq24VxGi
	 pviKBVV8vKHDIeEf6DGipC2D4CXul9EbgZXRu6eKPWWEHUsxr03kuUyCDMjntVL30E
	 KhkWWSQKJvLjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Maxim Skokov <skokovmaksimevg@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	apparmor@lists.ubuntu.com,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: Re: [6.6.y] apparmor: pdb leaks, two fixes missing
Date: Thu, 24 Sep 2026 13:13:22 -0400
Message-ID: <2026-09-24-daily-reply-0003-re-apparmor-pdb-leaks-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924124939.276438-1-skokovmaksimevg@gmail.com>
References: <20260924124939.276438-1-skokovmaksimevg@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please apply to 6.6.y:
>
> 1af5aa82c976 ("apparmor: free the allocated pdb objects")
> 8ead196be219 ("apparmor: Fix memory leak in unpack_profile()")
>
> Both fix 98b824ff8984 ("apparmor: refcount the pdb"), which is in 6.6.

Queued for 6.6, thanks. I also queued c567de2c4f5f ("apparmor: Fix 8-byte
alignment for initial dfa blob streams"), which fixes the same commit.

-- 
Thanks,
Sasha
