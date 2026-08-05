Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05B1A682E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948122; cv=none; b=sRXxXOCQAikzsQKVLva+pH0JGreXNvprYAADZ28AA5EWC3Vt9SfGSslmFw5bZ8a8oAPxzOe7bdvixIAV56hUE4MsocCpQPCwFGPwyWZWXfBW2lRpy0qBpcYWvZXo2nYLyYBHcc4g+Ty+FYW/eztSaiBEyMLzmquKySoAcwI/1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948122; c=relaxed/simple;
	bh=lU1h8ufnehFrL6wZGYDd9Pvuwg+uqShN+q0G5OeNsU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB+oeG2gGc1YIXeXnwPxMXFugV/GHNQPR5yVu2c7lsDY+XKHp8pW3npEyhkDhDRBrHxw+Z9kFfB2Bx0Q2IEvMlaQm1FgiLTuZnyMEvHO3ZrG8IOIYx1LLk8m8BlsBdt6y8X0+YM72UKY1w+KAeN9GZzUG1Cg0rGvWU9w41pbUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+VVTgeT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+VVTgeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05CA1F000E9;
	Wed,  5 Aug 2026 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948121;
	bh=5Nk7QkBnUEhvfEIxtFOWsL1KX8xtpw9ObrvnNNJYQ1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M+VVTgeTiLnZohlkV2XGgE8DGAdbMQRNNpq9fTENGHcfIg3woWsFk1i2RunRhhSFx
	 IMElvVqp5Tz/Bg30wPnU/HNgmB1PnypHYs6jO1zFZs50MhP4YURygRnqNIEy0JKYpt
	 hoAsLyYXfO87LvUyu0RiZHyW03GuUN225lFItFC1pm+KxqHUksatPM81en78VFa7MR
	 UouJuky50nSWuXEI5R1+xDY8E0R7fmvDQv33g1Fr/F/r/YgAi8Z7D4bteEhT8nE4Bn
	 T959WFdDSMA866kvnJyfjaPRu1T91rqfUdlyr/KNXtzkL3KkRdbjmVtLZ8ll19mOkP
	 cH35Tk7X13+1w==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 6.18.y 0/5] Backport fixes for handshake
Date: Wed,  5 Aug 2026 12:41:51 -0400
Message-ID: <20260805164000.stable-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805091348.609325-1-guanwentao@uniontech.com>
References: <20260805091348.609325-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 05:13:44PM +0800, Wentao Guan wrote:
> Christian Brauner (2):
>   file: add FD_{ADD,PREPARE}()
>   net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()
>
> Chuck Lever (3):
>   net/handshake: Take a long-lived file reference at submit
>   net/handshake: hand off the pinned file reference to accept_doit
>   net/handshake: Close the submit-side sock_hold race

The series is missing two follow-ups, and without them 6.18 ends up worse
off than it is today:

- dabac51b8102 ("net/handshake: Fix null-ptr-deref in handshake_complete()")
  fixes fe67b063f687 ("net/handshake: convert handshake_nl_accept_doit() to
  FD_PREPARE()"), your 2/5. After that conversion the ordinary "no pending
  request" ACCEPT path falls through to handshake_complete(NULL, -EIO, NULL)
  and dereferences req->hr_sk.

- d2ea4d254d04 ("file: ensure cleanup") fixes 011703a9acd7 ("file: add
  FD_{ADD,PREPARE}()"), your 1/5. Without it the imported cleanup guard is
  err-gated and no-ops on the accept-failure path, leaking an fd and a
  struct file.

Either way, please get an ack from the handshake maintainers.

-- 
Thanks,
Sasha
