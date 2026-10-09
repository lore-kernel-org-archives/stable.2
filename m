Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4773B3BF0
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565812; cv=none; b=YA1S6QXjyRY3GwZskCOj8K1xv2w4s+fpt1o+lJ3GHllt8tdzwA0ZixM/jPVrZQmqe2aqroSmmsV4Cmbja7Ilczk3bvYoUqr9DouED2ACDSxLhwQJuyUkJ3AsYPB1NJcyLz1asaxaF4XI5oEEMknE4h3db1ppgUSPYO5gB70wp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565812; c=relaxed/simple;
	bh=PV7kGmu3yzMJEz0znRcVADbxrT02Wt2MpenYUEBX7dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgOdORP395+2aUa83MUZFVXBt1PGui4DzQFDUrqfDRoxQCx3AD54HA7RAg+zc4fVAfiz/Z2tn5qBSnh+RwC+5lAC6bTddWO7EVpwhwPuGqJXv15n1peoO9z52f3MI4dplo11Jdc6ZO/zIrRbL4B6jO0IAUDbjnlONmc1N2a+UUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD0Mkopz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD0Mkopz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E44D1F00893;
	Fri,  9 Oct 2026 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565811;
	bh=BGFuiLisNk6Tjb74BmdIou/ocVH6Hx1bjxZZ237l/b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TD0MkopzieOAi5kAvA8mT1/5Q779gRhMvXpJQBBFIHZrLcahFPvyZ5NvE7CBW33xk
	 serf0YdANjjBqAte2bX375bcTSm14mhRp9V9prHA9yZMiAp5gZTwKwsm+lGLa1y7PB
	 6xaz/UgfbxYhnrskYsTK8VPW9BAmwBrk2MMply8j9dLcfm2IxaCsdcwHLA5ihkwePN
	 wgOLj8+QNZd/GHj/VddT0DxwTMs2WPUIA16vVdLwE0bQvmy3jN8r40rHusL+OkFuf9
	 j3TuNV95CsJjkGt563LICNJB7LsikWUtOT+epo3Nt/8UPnU01+TBAMbdVBFLbjoMsr
	 Qk5iglcecbd2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [PATCH 6.6.y] tty: port: fix tty_port_tty_vhangup() race
Date: Fri,  9 Oct 2026 13:09:39 -0400
Message-ID: <2026-10-09-1-daily-reply-0002-tty-vhangup-race-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008134319.1183247-1-ue081723@gmail.com>
References: <20261008134319.1183247-1-ue081723@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Add the missing serialisation to tty_port_tty_vhangup() and
> tty_port_hangup() so that the former does not return until the port has
> been shut down also when there is a racing hangup.

Queued for 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
