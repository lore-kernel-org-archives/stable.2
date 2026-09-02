Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08DE4AD7C2
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387281; cv=none; b=qVV0ylvyNTG5MQmVASKhEqq7NggNZaEoomtPPGsyDJ63dSvuVAbeRhgOMRS7XxuAnQ1VsHjs0RcGE7fi3BQbX38SqTkQh7XY9JbfxesdbAh4IXC19LMlZYHKPbgefGHPUw4FcqOe6cQXeDwP29H67S7f6x4aKVWloGG4Vgtk7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387281; c=relaxed/simple;
	bh=C3S4rnWdRCc2Pm2t/LWn1VS4o5ljW/qgMjltZVwa7tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJtSK1HY7LoE6tqxjNLT0/h9hJYhEsN+JDmh3+wXynQBru4OxjahcqDUSKXk/eYe2eu124XlbCH7RiprMPtsQt/2oedopMNIQ9CCX0iutXE9hZeOnv7fplu5ul4JFaN3EgOANbAxyaVY+lp4EN0EGfEgB+5ZOJ6zj8kzuofmaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AboozBwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AboozBwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688A51F00A3D;
	Wed,  2 Sep 2026 22:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387274;
	bh=x7e4OJY1Ozx1LfghICBQrlIw2wCews9F1XCfVjT6j7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AboozBwNGxKheP51itd8qK5fy1YQaBPw56CX5bk4M4l6uWQZqvUF7xPbS/TzgFPnC
	 Es7VU3xvNKrdgsl3HYr8lWURMwe4dtVAAljibZTl4IIfPfPbA94Y4UGhP6O0jkqEAn
	 UbwFoGBarpUX8wR34dJK0Ftd0RawMQPTM6Aum+veB0O2Q25bRj3MbOSPh/DSRqLdQm
	 cVDLcYkOE5jlN5iY1YPAI44TiuQ4HQdW5GjLP5qBJpY73s2ZTi36LGiiQgQNDa6jGl
	 OTZBqYKRQfwkOeH8u4L2BSLtV01D9jPDuSdlEOZi7uwRmeRHWJxYVVYH0ZpisZkdHQ
	 ElG5tT8o6X1Vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: Please consider these upstream CVE fixes for 6.18.y
Date: Wed,  2 Sep 2026 18:14:12 -0400
Message-ID: <20260902-daily-reply-0013-cve-fixes-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901024907.61883-1-artem@trailofbits.com>
References: <20260901024907.61883-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> My 6.12.y request covers the three fixes shared by 6.12.y and 6.18.y,
> leaving these six mainline CVE fixes still missing from 6.18.y.
>
> Could you please queue these six commits for 6.18.y?

Queued all six for 6.18.y, thanks.

-- 
Thanks,
Sasha
