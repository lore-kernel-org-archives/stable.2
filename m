Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8F230BE9
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066815; cv=none; b=o0tcp682s3NgRCAoSPtUm90kwvUWSf+bo75KDwetDF0Nq2qHGXVOSf3YJaGYQE1sfcfuv4wRl32P/js5Z2dZ5kSPkGUspNfYrsOsCYxI51Kqpu+N6pvUXq9agPd8qMhU1yIprEVVNbd+20zfoEdSRjgrvLFF3O3mDCUM82PPqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066815; c=relaxed/simple;
	bh=3Px26IH+mM3+ernY4GckVsxUS8BlvdPtgS2ucHaWQ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIlyZ+armFz1haOdAa8cxMvkHsDDJR8KNhGeYpUROYPRWXyVxIV4M9LN0iZpMB6YIRwkXymG1EK14CWywdiYSOo10qX1YhESPLYU7o76rebIrEjUPp+KYbLON98Aus4OsKNai5kjUcf+/LRYbWU9KMbjoQT4tml/YVCF/lULwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZJtax+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZJtax+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA8B1F0089B;
	Sat,  3 Oct 2026 22:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791066814;
	bh=he/QfJqKPiU4YAedVbATkBZt2a7G7K3zDOoJs5jnvtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eZJtax+JecmPouOCX+MYdqcWr3Y/kS8obqWZL+32TFfh1cwgCBKNhPjlp9rop8hZM
	 5GdM4IXGm6q8XCT8uisRtfGXezbBmd9hmkLOPhgoA1JPs50E6ttRv8b1RdGyn2DbBG
	 60WAb3MJ5i4eeSso9CwSf0DECsOkemkn85BuqRTUNLifrbXJ6umfG7SJkqLSmIrQm2
	 DjPjxLzrYW6/Ushn0V0PWtXC2yQMfIblgkfP0+TX3QXZ6/crEe9wUxLZTC/czCasON
	 zQVSpbv/q0Uun8OzKSAzKXiDIXjpI0hwYFpw+oNHsDTNAtsQ7gUWGzOAySUofJF7Px
	 X66k9N4OslvBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 6.6] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Sat,  3 Oct 2026 18:32:45 -0400
Message-ID: <2026-10-03-1-daily-reply-0002-re-smb-kill-suid-cifsacl-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002145533.3927672-1-doebel@amazon.de>
References: <20261002145533.3927672-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit b8e5dc4f95e5484159b343903f302eb6d783f2e6 upstream.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
