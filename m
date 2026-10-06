Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD81A6822
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322597; cv=none; b=CIAkmxliUkgkpX8moRbIS253XRS+AEBBtQ0zLs4RZJyfXo0nZAbIxIfoevheIpr4Wrst5WZ6hVPnUhpp0KvTdPYbNDMraKWer6oLD5VtLYYY1dprUmC4JX1hZd8L/P7KR2gcSqrWzXx2XOSOGNn1HTyroyZSmASN3INfRghOn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322597; c=relaxed/simple;
	bh=AqgrYaB6m5VSkAaPMVvVsS4lAgagQKAm+FIGA6+wPsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyXnanBHakLhRdX/x8lLJKo3yD/vt8/2V+LISKr8QIpl9ADC/+TYT2pfXPJIhtyWpQelEDjCS8/CyoAkCvQijZn6jgSxWmQnOCyPkLOgOr9daHF2+9UsQ1itVsei+h6vgDpOk/MooCNKEQ12efj7fIcbApJUtv7gQDQ7SRebhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONW0JBoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONW0JBoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF0F1F0089C;
	Tue,  6 Oct 2026 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322596;
	bh=xO9WpeoxIYcOMftXh+NMVHlQo0USYy+IvCo9TVJzD+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ONW0JBoauQVp46hHge/35OdIXre4vpT2a/QP4JlzsavBRfdPm3Sqx+0bKbzgBewN5
	 nDb9dIzU5Wb9B7dlvrt+TAFIskrwpzTLt4eBdYQkI0GUBGfh6RNyGBTk9obdJF9Htm
	 GUiBz2vIKI0GXr/Y6/QALN1+6xV1O6IWE27MsoTyFOzXpGfdLh/nrbVCiVV4wYsoE6
	 BGWl2Ak+x5f6oDjgyczgk8nKdvZpQvxZJWWRzMGS/I5/7ldKyPgw3CgKx2wob338ib
	 XBm0Zszbf6OO+NqoA0gV1xVlHXcv5uQpfXCprQDLgntAIfnMqlgghU2tc0JeXhPhl8
	 jP8YUjT+7Pj4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Frank Sorenson <sorenson@redhat.com>
Subject: Re: [PATCH 6.1.y] smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races
Date: Tue,  6 Oct 2026 17:35:48 -0400
Message-ID: <2026-10-06-1-daily-reply-0016-smb-cifsfileinfo-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005173638.3905008-1-sorenson@redhat.com>
References: <20261005173638.3905008-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 19465a9aeb664f1d710d0d22c07c31bfb7c85446 ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
