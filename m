Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476D48383F
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948123; cv=none; b=Je5E36dRHfs4NNpRq/S5kp0EErGDcgdwdx2zy8Yw7aALFnpiZsBp19+KksMjpsXpddMQZbeIUn2XvRJcz0SfYcW08MFLngO83jFrEcthVEiahyzbBY4dpv6ShBSiLwotR1dShAQrHMUkyA1xY2deguzSGraX1h06dQ2oVzcZtpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948123; c=relaxed/simple;
	bh=fhZY4QOdEVQqllsxEzd7iVDU4xnnVmX5i+uEjnPxtSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T91yLb+ZfwGnXObPy1naiUFRzTe/FqFBdiwzXfv7nMMDL5AbEpq4Lle49t3bzRVp0NSjanbzkGQmPOPDXueSwVpxR+zPFIJDutUEXXnyYlhxXWLhTO3PK5RCT5/Bbsc0W+PxrQ18UbaiRc9wPsZvBgsZR4lMswJRWfhB2UMJqB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDrydQ3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDrydQ3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B7D1F00A3D;
	Wed,  5 Aug 2026 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948122;
	bh=xS+EzEA0avTZhhdeCGgx6DXOkdwUXnZzNsCaKC7yKZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QDrydQ3uU9j2h3BCQA6VJL+5ZrWPhCW6jHozTaPkTulqr94MT09H9LjLZJZJmFTe1
	 rzR+CMiGrrSuv7pg7QwIMVm5GB+kMQMXoHS0u0ZHlZ2iF8KosFUeOa8Flnun8Bhhn1
	 QbxHsD0cqz1xBdjDmtCHD+OxAJuYxL9re75+tQeAYcEd+9tNWhnU5aa7qBJRxfOZ0y
	 AV9/wkS8pKNi5C2rQcWhtu2rOVjaFH6kD6nLP/YnG+auzAM71//odhePoQxbZMWFoI
	 csgeOiLgjvlRyD0C1MRToUjGEFZUhv1NrtGxU3WuY6M0koZ7XQMQAhtF0e07lA7DeQ
	 O1jaZaOOdSGQQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NG, TZE YEE" <tze.yee.ng@altera.com>
Subject: Re: [PATCH 5.15.y v2] firmware: stratix10-svc: fix memory leaks and list corruption bugs
Date: Wed,  5 Aug 2026 12:41:52 -0400
Message-ID: <20260805164000.stable-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0e069c96-02bd-4fca-87fb-8d561ef92e50@altera.com>
References: <0e069c96-02bd-4fca-87fb-8d561ef92e50@altera.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:43:12AM +0000, NG, TZE YEE wrote:
> I see you helped to backport the patch to 5.10, 5.15, 6.12, 6.18 and
> 7.1. Should I follow the same steps shared by you to submit the patch to
> 6.1 and 6.6 mentioned by Sasha?

Yes please, one patch each for 6.6.y and 6.1.y, the same way you sent the
5.15.y and 5.10.y v2.

Your 5.15.y and 5.10.y v2 patches look good and stay on hold until 6.6 and
6.1 have the fix.

-- 
Thanks,
Sasha
