Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB3282F26
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788058907; cv=none; b=XnkxoyzanLvRTtZRNaCIGiD/36t3u2fILmfnYSPrm/EryRTMRkKfHXVKYlcMoOqReL/9BW1OThShepaVntnEKa4+KkryODJlwdZv1SH787MVMKjc2GyoYElv68D/v+wqBB+mHuoHcn8aK24gX/kSty21fzYpoXRl3TP50qIogMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788058907; c=relaxed/simple;
	bh=4W3oUA0hHsPtckxQGQFuKJgt9r8LBpn0Co+ShXCVFb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtdXyuNX4ubO5RoTI4EW3g38q+A4LlNe37iMYtOAL0gJS/geautITS4Ky1rtKCqljSpz5Jlgp7tCafN+H8zgbEiyvn7/j3q1L11IWyEIJllu9ehxsQa6ZqYLOgtYZcTakef0DBVGBGgIyOLOHNIXaL/T6keL4xI9ICtzyHINp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlpCKQQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlpCKQQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A071F00A3E;
	Sun, 30 Aug 2026 03:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788058906;
	bh=6gJLnbh+q/Ag22wt8k1Ofo5IGtH8o2r78ScjUgBZq5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jlpCKQQiyL4UGShJZ2MoWUjgZgskzoB1rxWO3YRLJWntzwRC61/g63mJMJhzh46Qb
	 vWrfydaQXLekgjdETOUpGJALZ3g209evDxUenKCK3ZhKzj/f0NWVwhbvS/fd3PwPCW
	 zG/K+utmHUTd1CuxotQZIo6BPFdTnWjd81tAIfWp/ara6kgWCaiJCjgqIcmKKw0WMr
	 polpEaecooSiJAA0uJUO3ifflPz+uJHoA/TEt8OFRfjZ4A8o5AMhLbrznuxbBLtSIO
	 ekHbM+b6saLYc5g9d487B+94/V86A464g4gnOTZOXhq8mQSn6Rqfg3ewbuQiVu5box
	 EQiNv/oPgGcLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: Please consider these upstream CVE fixes for 6.1.y
Date: Sat, 29 Aug 2026 22:56:43 -0400
Message-ID: <20260829-stable-daily-0003-cve-fixes-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828232904.91398-1-artem@trailofbits.com>
References: <20260828232904.91398-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 28, 2026 at 07:29:04PM -0400, Artem Dinaburg wrote:
> Could you please queue these commits for 6.1.y?

Queued for 6.1, thanks. 17 of the 18 were also missing from 6.18, 6.12 and/or
6.6, so they went to those trees too rather than leaving the newer trees behind
the older one, plus the applicable subset on 5.15 and 5.10.

-- 
Thanks,
Sasha
