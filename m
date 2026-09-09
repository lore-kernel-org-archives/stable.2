Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAD542A152;
	Wed,  9 Sep 2026 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985617; cv=none; b=U4v+H32dTvNrLDiVBXsjTUkOCT90alB1TQfHov0OdS2nOuL9aRI0ApqoEqMnd0ESkOB2Ujac4jVG/jaSHm+unMc/hfeTg+4+ypDP0zCx0In+NoCOr7iMwaYApShE1C+G+ifgbX7av2U7uJVeknUmYIBBplQEufkn12zgJ4aemkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985617; c=relaxed/simple;
	bh=l2uh+NPLmHUJn3m1aEzJMYBUVLqVGgGDDUY3jQNNJv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgiYTnst8tDGCkboWMXXIZdmCrdEnEsDpMqc0uryT5YHc/qYjVm5uQeHmsm/D8GS/vCttmpXpqYoJouu7WnXEhrQivNHHUh5k5H5CY3L044nd1ksSWbnWHXo1vfEffVpofkEZ7F9pUlvFGTf7DWxHWX73P7eZB98TiXWVtbgSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLTB+w7o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLTB+w7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E681F008A1;
	Wed,  9 Sep 2026 20:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985611;
	bh=exNp/kb3ooDq1EguyEB2evKnLFpPt6bNUbZdx8tkN0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mLTB+w7oiFPsaRzjajbc9ZsbuH8SeSxfSsBzXMBgHcEXeN7BMmq4pCG3YyXNXNA/y
	 G2eClB62M9Z9arzsKghDYbmIy3lL2hisA/4aeMy2pVG57kk9rbTX9/fpjpEq5oo9Vu
	 bc0kCYMam6r/I7tsPdGqQvVnuqKjIfFt1abaU56Py2QFM6HY72x3Ew9cORuo8Qm0L2
	 56zL92bHY9rzhzNnBkQUUDZpXjt9paJhrEhrVVEuMddavu3oZfhSF4l0NJDm4lHNQJ
	 yxzMuum3+lPML4LRsjm0dpjvfIs4ouFLigGlcOiG0avOeGLUNxIUKlfnW/YMrm9aKs
	 eK3ZtLZFS5NzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Wed,  9 Sep 2026 16:26:15 -0400
Message-ID: <2026-09-09-daily-reply-0017-damon-paddr-drop-optim-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909054545.256743-1-sj@kernel.org>
References: <20260909054545.256743-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It can race when multiple kdamonds are being used.  The problem from the
> race is doubtful, but the gain from the optimization is also doubtful.
> Simply drop the optimization in favor of code simplicity.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
