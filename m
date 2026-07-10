Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C92225A38
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717405; cv=none; b=PpRdyozdiATE4w7GjzvhrO8g1zpdBpg+j0P4KmODwxHN/4yB8PdfaiFjYXX83OIZmsrY4nzrs7hOu7/1vXifRZrIFX8QP5+MOtRLo0YG6bRqWmmEdp12ghhcYfz2z4PzDEdJ3i1BB6ppEzo3irAkHSqIPtebpB69pGqnXx1kFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717405; c=relaxed/simple;
	bh=ZhhNa0t/7wxhfaXMOZH0053tyQZ7otJJGKLCILUg/DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLLgz1d/sltQCZ4TD9f0SesQ6Eeigh2HgoFxpAatUMG8kXPbaBC8CioziNnFd1rrnN92KkBNvaJCTpJqa4O8DKzJBxSfRGWCAFSmG0ycfQ2qsXd4nFwG5VnR3luDiTXY//0CveNftuWWPt2MeyumFTRsRX404raGhjy36KbShSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARKJwzRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARKJwzRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E141F00A3D;
	Fri, 10 Jul 2026 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717404;
	bh=TRbIXopC9vYVCcxu0eGR6GlAGJwY9ROYRhRW9oGYgpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARKJwzRFeGfs+8vC6W/rQEAL0/H+mWGiKoCI3I0QlOOjY46KynYNW6MtcB40CI1SW
	 H/4jErQzc7HfRZ9QUPgSrqf66CsQyw2Zqlk/9+tseYd6iny6zOQHgNW0r7gIfj+u3y
	 CBiGVit5kZA9aUk5QswPv175quQlcakTKtivuPZGW1CFUDJr6oCxjIu2f7v/AgDEr7
	 /BNdymS8lWoogBSYLylt3CBED9q/JThoY/siHeJ4U0ixYNttXwWx013uyfV+dwvfYK
	 HkbCngv9C4doIXfZmHBEnVx6SGSGS5OycKxeJb8HL0M4GHhpV0tu/CPRKcTCdhgBPM
	 eWjaSzMuh+ynw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Keenan Dong <keenanat2000@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	Sid Kumar <sidkumar1@gmail.com>
Subject: Re: [PATCH 5.15.y v2 1/2] rtmutex: Use waiter::task instead of current in remove_waiter()
Date: Fri, 10 Jul 2026 17:02:58 -0400
Message-ID: <20260710163023.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709145949.3640783-1-sidkumar1@gmail.com>
References: <20260709145949.3640783-1-sidkumar1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 10:59:48AM -0400, Sid Kumar wrote:
> remove_waiter() is used by the slowlock paths, but it is also used for
> proxy-lock rollback in rt_mutex_start_proxy_lock() when invoked from
> futex_requeue().
>
> In the latter case waiter::task is not current, but remove_waiter()
> operates on current for the dequeue operation. That results in several
> problems:

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
