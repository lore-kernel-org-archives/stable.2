Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E3136358;
	Thu, 11 Jun 2026 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138733; cv=none; b=aS2jZxjkNi8XLJaPECqXLbcevDtJlMYpVF6fcdJoyJWTLRzjyaQ+YzbEqmT073osfiGG9gfstz5dko7It6u9otd3cmKBJfNegNv/KjfVXkiRPbykgujtVf9aPi39bq6fqO/Hqbg/Cu4QtZ92wDzHstxamSE6pnhNaM1iS9RJ4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138733; c=relaxed/simple;
	bh=tnstdAhuHJJStqezeTNY3UwWTHrnFd2lI0J81uB62qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Es5q49sjPzEhtwnUqtvk1kRSkRgHO7IKSh0wW317zVBNJS4vMffNskBd6z16hhcAExn57w5mfRm847za5hVET0NsySBUaeOiElHQgzKaicJEGjhZ74fo0Grr1LqSb0tbXILq9daRrZQjImE/9/pnNz96TqiLs7EbgFCl1rs6i/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6AOqmIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6AOqmIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8EE1F00898;
	Thu, 11 Jun 2026 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138732;
	bh=tnstdAhuHJJStqezeTNY3UwWTHrnFd2lI0J81uB62qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V6AOqmIhGgxy32lGdOb/v/ImSrJaO0hd4AYGcTewtYNvzrVGuYqOf/ukQAGV7j4Wi
	 U3OSvOlnBljJkjelCPE57GRdL3AgSTi3AW3y3i4ZkDAAR9s8cQQilqyV3EEEpBWcis
	 2b6J2djWJ902cDiDJtOJZqkofd2MGqxuKwxbvUMvgp+ULRvQAYqP6M1YtfKr12oAy8
	 uMX9WjID16GnUYMen8pk90oOua4XhkgBiRPLh4R1DxdS2K02a9JU96E+9isT6v3fBc
	 pLC3zemfnJ5uw7fsSNeUM8GpicgFV7VWblG9KVFrupZNyFwYonK3/RvPvGtXZ8zTn3
	 NvJ99+N0uJM9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Edward Lo <loyuantsung@gmail.com>
Subject: Re: [PATCH 5.15/6.1] fs/ntfs3: Return error for inconsistent extended attributes
Date: Wed, 10 Jun 2026 20:45:18 -0400
Message-ID: <20260610-stable-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610085204.21142-1-apanov@astralinux.ru>
References: <20260610085204.21142-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jun 10, 2026 at 11:52:04AM +0300, Alexey Panov wrote:
> [PATCH 5.15/6.1] fs/ntfs3: Return error for inconsistent extended attributes
> Backport fix for CVE-2023-54125

Queued for 6.1 and 5.15, thanks.

--
Thanks,
Sasha
