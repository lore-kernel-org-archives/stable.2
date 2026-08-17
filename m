Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712EE274FD0;
	Mon, 17 Aug 2026 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937129; cv=none; b=scjv1P3YwKFLlIyLQgYs6sKrnCQLf/Sw+YFrw/bcfyFAlpb3OgSmRnSBuab2aF94XpLGyFEd8d85cTZflifVEIDgyGYtysG06spqk9spqd8UcUY/6TcsdB8PNmDl9pYLyK09ZmKInQjs+6TuMvhI9RVVSwf8Ki83xTD1OeJvLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937129; c=relaxed/simple;
	bh=WpmAZO51/P+vOk9A50fhc2GWjTKhZZowiNJVKmqpbLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXfP5rRqgz1SqDAGzW75ogo2ricoJY5/CVZwEj3H84PeAqYFpcUEGbSChhgp1f/SJsX/2wh0wRkvwwtKw0tn26RfH71yIZcbWKWSwKNcND6/3Ja/RoEdef5Hor+QHjQtBa00cMU74yvExHVoN+OPRVLJE17593BMe8QfXoF0I8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byx8EX09; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byx8EX09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7991F000E9;
	Mon, 17 Aug 2026 03:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786937128;
	bh=260jpCpJSE9PhxgKiyadApVv2e/PGGC2t7scs6nE7NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Byx8EX09/00lw5wRLWau3tYZ9q5WuYosYvj6wI1wor9OTVD5DlAo79W/kCXONDwit
	 /utRV+wshciZISbKPAg14vgWuBSttda9mD71e9Jjj4pZszwqORGHMlxdjdimTObAaZ
	 PElu1xx3F9FR3I6MJu7gscpmWwu3GhDVlBbuV5QbRUjsr8oJQkXaauDtrZt76TUhk5
	 0GDMlxQqx8MZlpgU9AIgwGP9jINvFn11DbGt4JPedY7nFOt4K7tIvXdamdPebgl+XA
	 nA7FHe7SX5OouBDKJuf98PuyrVosXd7iBZdjv1AZKKDCoNbh5rG6WKrLruOg8gbM3h
	 NpB/nhCCcZq7A==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	llvm@lists.linux.dev,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: Backports of c1f3e770eec26d6f96dd6d2ea30555ba7c09a244 for 6.6 and 6.1
Date: Sun, 16 Aug 2026 23:25:14 -0400
Message-ID: <20260816211000.11@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814025208.GA1929807@ax162>
References: <20260814025208.GA1929807@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider applying the attached backport of upstream commit
> c1f3e770eec2 ("fortify: Disable -Wstringop-overread in tests"), along
> with a worthwhile prerequisite patch to clear up some other issues and
> make that change apply correctly.

Queued both for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
