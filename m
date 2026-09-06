Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1DC3D7D77
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701646; cv=none; b=Uhso5GEIcxVATndXRQKsSvku6Iz1XQqsx0QBeYvFrDW/KGZuOS09vcGgU6udJRu1nwe37AQcumCskhOU0pjmmEX87QKDcpWqDhrna9ac1wHagnPEuVdtYwSouZ8GHsWHmA9O+0mIX+ybbl+pxW9lYMSCV0VRbFqvIyNKHKx6pqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701646; c=relaxed/simple;
	bh=jvkxaFDmCcoERLhcWV9pLzI9bgsqfuxo3Un7hq+U7p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCbt23+OZf9GZ4iJPaGbtVwuJBmy+qQ1DoOG8iK62DKagYXglorPUvk5U5PBEHcYwAkq1c7bkrrV86gNQydQwspEAXFyAjEqBz0Hxz2PGYq+XwZCT1o5oWoF3NOTskq+69u01jG4P6of2fq2oNnsJWVRRbs7FdRFHCk4uhU1lPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsPlwmy7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsPlwmy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A011F00A3A;
	Sun,  6 Sep 2026 13:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701642;
	bh=Kg/+3XNSUbq9bAGXiz8w5hsiogytEqLiuRW3eoMxN+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KsPlwmy7Pi+q9iLQL2lcziaUQCelzmUYGShSxHHu82fV0jg3BdHy6ebMQbb9607er
	 uZM/WuUTupJb4bre+TYC6LmUM5wHaTK8ov9Gmb/qi7wIAOiMj8q31THjySeoLYhEUc
	 hsJngIaWv414TAF3xGEO4oXIAP70lx0n9ICZZfIlTP24MzlTDsE8BZU4doUEePmm5V
	 0NAPBpneC+YN8qlreiLASsJ5qsqSIzTxMAtDf+5sbUkc3rIUbLByRRIRG73v9P2Ok8
	 LkFSklYz5falPbmosVwU8fpYze7Ye3yHJO0dIcWZRrnj3T4iwerLWvdKOYYryGeh3w
	 VG1xmZZftFqSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 6.6.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sun,  6 Sep 2026 09:33:08 -0400
Message-ID: <2026-09-05-daily-reply-0038-fsnotify-stale-mask-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905024642.3937399-1-yjkwon0026@snu.ac.kr>
References: <20260905024642.3937399-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When a mark gets a new event bit, fanotify and inotify may avoid
> recalculating the object mask if the cached aggregate already contains that
> bit. This is racy with a recalculation triggered by a concurrent update to
> another mark on the same connector.
>
> The concurrent scan can read the mark before the new bit is added, while

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
