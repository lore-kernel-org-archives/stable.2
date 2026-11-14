Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678145;
	b=gicoYjCq0LAgPguSGGLu+7EaAs/axe6bvrSXvIIbywzkt4bbbpGgL7rr6U5h7PIFhpXC
	 5wifgoHsrtJgoHeqUYlUPDcx6JqDmCnV480EJNHWfVnfhMCE15GvFdeJhiqfla8J2raAS
	 uNeEhVFGHC2gSKP2Ivjf7oxpfAL6TpVld3V+MjH8UZkGQhdybRt5fJOXupZEgDD02wO9q
	 i4MDq+ITN4cV/DyCnVX49IuBwg21ZIN7ZAwHPDt7ZuUbS8sndK1JQS69HbxYaZSKr+9lV
	 LLD+jLr/EyRRwePm+l7ug2pom0UWSMn/LPwgLI8Gx+Rdsb3/9W9ha+W4nfdNGODP/Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678145;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eYeigTS1jIQXCqo2N5Tbo5gQD0/Qtmj6G1TFkya7J9g=;
	b=u/tUH/U3dn7iP7Ht91f6BwZn/NAFc7H6oX7V+xICFxIZZFLDIraSXtgggfXFKjczCWFm
	 9msNePDDK5q6rZYTYEZ/rlI0/4RTafijQyd7kwQVK1LfnmgXZkQGBbFBKRIyrMhdyA2do
	 Pidi1Z+TuEi6nfk9ScaDK/gHf6XUn5wYYCGtGxreGhLeZ/I7NT/frphY8zu6lQiOa2kST
	 nfl7I/i57Z87rkacYYr4qD8ib5cpPx2XRCQZketMQPstyAvBwGESmJW4+EoXAOu9Hs9MG
	 XUh348ddikxWmU0GiHSIw5qlBkLRGjxekNIKM2yqL2CQAsRtbw4yP3BzFmFrBc8uRBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvfxD4rp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7934606A327;
	Sat, 14 Nov 2026 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvfxD4rp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C961F000C4;
	Sat, 14 Nov 2026 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678145;
	bh=eYeigTS1jIQXCqo2N5Tbo5gQD0/Qtmj6G1TFkya7J9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvfxD4rpEF5dXot3Gy7pM0HW45BdlrAE7f61J3p6Db/FNrFbAu07FCtuFqGTa2K/h
	 fEHdCIqx8gjiVIIN9VhCZiiFZQFCOwZaG5hoEAR6weOgV5BxkWnJPsqq3SE8MLrxX7
	 +i0qO/wt5+Qsny3Oi2Gs6kFuaNCDsuz6+X/IHI+sarflMmssgYTsXNiOraDpWRaeOH
	 Cy7bRcjpbPDdmW6soJQmTLogcDYesWcM9dTLAdoikdNAXnPhfWkdHr91HOTwPpIJAp
	 +eYDglN1CTIz8QWSKkT3oAxsVDDWCsd78H1EpCDuH/dP6W/2ylwqKV+9Cick+ueOEa
	 afMWvA2Dlvt0g==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yufan Chen <yufan.chen@linux.dev>,
	dev@rebasedinc.com
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Date: Sat, 14 Nov 2026 12:42:12 -0500
Message-ID: <draft-agent5-0001-re-eventfd-signal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-13, dev@rebasedinc.com wrote:
> If this is correct, a backport of 04fe9aeb4f3c to 6.18.y and 6.12.y looks like the right fix; it keeps the CVE-2026-80920 fix in place.

Queued for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
