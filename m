Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5048E0EE;
	Tue,  8 Sep 2026 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907174; cv=none; b=qQodslkD2ARLYtWAN3UBNSHq4NS9p6rVLmSzzvPKRe6w6FZp3D8h8sVGvOEQzVR0kDK3/1Fnu/YCW10CHzeTK5aTBc6YGLYoxecBIw50SU9++WfdJP/t4Z/RsUOVYhL08Xc5NZnGSzI8R/TUxx+D8ertRiOqrBQam8app9pKH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907174; c=relaxed/simple;
	bh=vMfvSpho+BWlG8ZiW5udMMZ1Hw4Lv11VPiLD8o3D2Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3XFiNCHS/GrZoBSpE6m/RGy3ZAmc7mKJ74CcWWBU+r21OnAKwGWWCIAVP8e9N5hAAvPSoQMjEDoMYJ69hszdzOKWsg/1cWCY51BZPZYTPu3lTfHECDcVGYbrsLjL5Z5Zh3WpgSrO7yCasaFaMwk8Rn5zDFnhzTgNOwbZkdsht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI7jq/3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI7jq/3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739701F00A3F;
	Tue,  8 Sep 2026 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907163;
	bh=tSKxAeFtNIiZ0MMvnvckVM6rLNQkcV/nYhpXSi8PZ4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OI7jq/3RRO4C1OP8Y3wL6Dyn3kN5I6neDXcjCKnAKua9qsLIfeuyHC4UOrTIMXaqG
	 x+eQpdyA1an3CcM27BRGRIP7wgxM1I6p0HS3H83kqZwaRcYkGlS3B7Ix6RFgb2ULEG
	 dGx2KCQRbtGc8HuAB7u17CcAhtZkrBe5fRbnsRkWPCn21mzE0IFmWVVfSFVWVV66Lh
	 pZkFqB2HbuW18Umu8++wc06F5GCw9HRpMpwTt7G1swGhHwspNY/GSYRdEZ1pHE39IP
	 aeS2KPvLHbz2/hT9xmLhv7r9dfRtBYZm8CTzqa1F1qtGlnf3f3nEwMi562Up0XsML3
	 JfTgWwT4p4afg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	pengpeng@iscas.ac.cn,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Garcia <miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH 6.1.y] Input: aiptek - validate raw macro indices before updating state
Date: Tue,  8 Sep 2026 18:39:10 -0400
Message-ID: <2026-09-08-daily-reply-0003-aiptek-macro-index-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907184959.1567893-1-miguelgarciaroman8@gmail.com>
References: <20260907184959.1567893-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> aiptek_irq() derives macro key indices directly from tablet reports and
> then uses them to index macroKeyEvents[]. Report types 4 and 5 also save
> the derived value in aiptek->lastMacro and later use that state to
> release the previous key.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
