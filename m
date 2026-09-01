Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC43A6EEC;
	Tue,  1 Sep 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225723; cv=none; b=Ac0rp0r8MxfMwJKduHsGEWSVZeOt7Uyr7bcxnkHr4TbHnX5HrdGj8FYCb7W133HjxNaDEkvPLCbW0IFXwI+2e4UecAtae340tPW0ZCrvqgAmNs+g0+1zTLR+kRUphGWocnanwdbb01fdhkvQEuP3Jv+r7eHsY0Fw3+UDOJeum1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225723; c=relaxed/simple;
	bh=5F5Lv0TJQzMDZu4hPAbKwOP5LWp9cVx2JNBofpxx96M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK2HJmLZaCg4KvVsYqGnvKZzc1v53GdKaxOxvY2t7NO4U2JqKqSAWq+l7SDlirfLG0lgH/YaR8HqhS1Z/NZJcuCoHbgAOHh9zbz0eAl6rbipDwV99jEfxRqwh98bGK7mZbr7ME0jQUpNP4P8yF3c2OolWryD73sUyt5aPlUyoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhkSoav/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhkSoav/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3741F00A3F;
	Tue,  1 Sep 2026 01:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225720;
	bh=THd9JWzjC7dmzYda60P56EbIAEkHHD9Vt0zj28Sgg80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UhkSoav/sRFjejUeKEwC2WkAdBBdmF4vFlDqNXy9X7NPH8Kq6X7izMkZ9OfVi6tlO
	 yyDOE9I5Ges59fhwT5/iI1qNjsYgCpXQKF/CobnkFRMruxtlGw+Xwdsn9gDA4cv5ap
	 p3HhArTAGe/XbDBtX2olEcUw/aM/jDTzW2wwGXECmshdFmwUuh+jV+gYhhyWmsDGQs
	 bHkQcWVUfMW7kBNd+IdBWWFpt0Gb0oMqPF6aE36kG65AQiaLmKIjWvKbYtk+26inza
	 iE1Q8xLjQX37MKHHCeQ3vuP/mpJs07fpybUuNC2VBIWcfwxL7VujGgUffynTVTknOj
	 Lq3l8tr3BQbnw==
From: Sasha Levin <sashal@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil@kernel.org>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Alessandro Menezes <alessandroasm@gmail.com>
Subject: Re: [PATCH] Revert "media: siano: Convert to use sysfs_emit_at() API"
Date: Mon, 31 Aug 2026 21:21:48 -0400
Message-ID: <20260831-daily-reply-0004-siano-revert@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830172330.3395671-1-alessandroasm@gmail.com>
References: <20260830172330.3395671-1-alessandroasm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This reverts commit 2f7d0c94396e ("media: siano: Convert to use
> sysfs_emit_at() API").
>
> sysfs_emit_at() may only be used from sysfs show() methods, where the
> destination is the page-sized, page-aligned buffer that sysfs passes to
> the callback.

This looks right, but 2f7d0c94396e ("media: siano: Convert to
use sysfs_emit_at() API") is still unfixed in mainline so taking a
revert into stable now would leave us permanently diverged from
upstream.

So please have it fixed upstream first.

-- 
Thanks,
Sasha
